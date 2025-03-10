Return-Path: <linux-kernel+bounces-554821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44CA59F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEDB3A5A95
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B00233159;
	Mon, 10 Mar 2025 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JLHhFmez"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391C230BD4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628473; cv=none; b=lScFjzujGGALPADsqEbHQOhyHgA+idVsdtQbKccsJdZAXShVoluSJ3YKMm3wzmqaf+NeOozJx6cXCPo5CwzsmD4citcP2JkRm1Wa0+bUyQuSml7DckAofCYJSX7yTde+dJB0q1yvzhqra+wnJAwOzuu7N9I8XrxnWz+Unwm5jk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628473; c=relaxed/simple;
	bh=5CSaYIH6K+6YfU9gGc1n6Mjj0iU2j2bA64dxCEYv5ls=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dfiIja5DwOTaMFO+4fwbE+tkfWk3UiDrNfoW7iHgmaBqLK4HUWJ1gLSBXjOrbH5SqdlyRU1ws+Mp7x282mwT0NLEB6J0RGhu9TslnGS3rNi1YrPrxbPAoo7aSCbbGGVTBH+j2oQp0kcI6m6MDs2rV8zKnDV9G6qhgCssm5itqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JLHhFmez; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913958ebf2so2154248f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741628469; x=1742233269; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=op0K5hQxl24cMPSQ2zXUerey4wk9VmfFfMkw2OmdMwo=;
        b=JLHhFmezIPhR8yET/sUs/4K5xmhFqI1XXyvtKUXs6sK3NvcRY2KvRTQcajoOgQwPts
         9ltIgDSqmrtNbI1Un+6JhLsX4FjLC34km9nDkPMRBtcY1cS1360H9zM79IsuKKgWNJNu
         K3TXiXWbE/KhukYOEpw7Kn/xXZdRmcFcJr+qy9nUDbyBy2CGWBuh7WNaBFSymD/UfddL
         SB8aUtqTKht3eosV3bexmnRX8h+G/Uoc/q+FhV665T4wzXRj8B09TJGoHKPSD4jQf4ql
         QS0w5xsA02TjjCd+a+fP1UlpmR+nUDdU+gZRcymDWx6HJ+MTiXxVX54jOXmU+aT8ga0i
         76Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741628469; x=1742233269;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=op0K5hQxl24cMPSQ2zXUerey4wk9VmfFfMkw2OmdMwo=;
        b=cZN1ydtQ3CAzlmn0zALabB5eZvSHjF9CISdANTTfWMcnWkOGXMzFkTucodB6e8ymAK
         FT8wOxBoESY6S5e72I+bGFTi9ihgagVPwA7GV2gd1ZEVSQ4N+F4BlzMWCSioOz5wGZQS
         brwSMOahDQX0MZDxqIXzu64ZNMw6/+3sDhx+yjZRBZSv6h/YJfP7i4KIbJti3S5epHHG
         r2ySE92e44jRityMTWsov/vvd2RoraSai94gycepx2YtfmKPMpizez+u4EoZsUGL0JH3
         t29p2om0Dw40eAMHo/uVss8UPFO0ePxzOqFsoIA/Rp79CvaXOUIwkQz/09Xf0XDRpUqr
         j6Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW/KLRMOc5cJeYH01ZPaYKsQD3zzx2ZFSdPr9W49SPH04V7ZhCOIEISgdwbulB4NWUuNNYdgdZE/FGFHzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rxbLxhNzVfcW9U/Q71GMsEIExGqpmwUtI2XVi55c+dEPlkOi
	SGQ4AlBMF8IMY3bkF7kf1ELyfzaHDt80cTs8baKS6FyJuIMiMBsFSvlL8WYzgp0=
X-Gm-Gg: ASbGncskXyjdezqQ24YnasBU71sm3Y1AU9xpRDmdhL89BNuzsbKvzMSfLO7y7otjgMY
	iZE62JsEYIly94Titmn1shtVpGyaZzsL/jWWhvFjX6CUpuT/YCal1MyBzpjQdJrNQVMfikJKKJ7
	W+YE0vReeCm/mmdqepK/6expKs/oJNNgPRbxiV97jIb5CSh/E36Gb+YjkkDtz3Jf1Y10pQB5BvE
	GsuMwjXVoUFQnNiF//fmAr7GBhLTSL98jSn/hqTQNr0zGp0gJN+h/VxC/HPgKDHj4wjii19oWIo
	AR4B3tiLUlcuAzwnXlB9IDvWLbEjF/BYL9Ali3uOpMS2SA1aLETKxkeVUIO73g7vYpzs4joemor
	4hebfPYKvkj8/J5/bgzs=
X-Google-Smtp-Source: AGHT+IGOgm3gmY4DlSe83JHp94+rEh9KGfjZ9kZ5Lnuk2aRTnT7RJnoSabcihrFdfyLb9ivTlMczAA==
X-Received: by 2002:a5d:47a3:0:b0:391:329b:893e with SMTP id ffacd0b85a97d-39263cebb08mr668621f8f.5.1741628469264;
        Mon, 10 Mar 2025 10:41:09 -0700 (PDT)
Received: from [127.0.1.1] (host-82-56-170-15.retail.telecomitalia.it. [82.56.170.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba8a9sm15597038f8f.9.2025.03.10.10.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:41:08 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v4 0/2] iio: ad7380: add SPI offload support
Date: Mon, 10 Mar 2025 18:39:51 +0100
Message-Id: <20250310-wip-bl-spi-offload-ad7380-v4-0-b184b37b7c72@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOcjz2cC/42NQQ6CMBBFr0K6dkxbBBpX3sOwGNqpTIK0aQ1KC
 He3cgKX7yX//U1kSkxZXKtNJFo4c5gLXE6VsCPODwJ2hYWWupFaS3hzhGGCHBmC91NAB+i62kh
 ovbK6s86oxomyj4k8f472vS88cn6FtB5Xi/rZf6qLAgWmNoimq6nVeBtwnXhIdLbhKfp937/DF
 SnpxQAAAA==
X-Change-ID: 20250220-wip-bl-spi-offload-ad7380-6f1c27cd815d
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

Add SPI offload support for the ad7380 ADC.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- fix return value on offload probe,
- add documentation patch 2/2.

Changes in v3:
- fix tabs erroneously added,
- fix documentation syntax error,
- add a note for the 4 channels ADC variants.
- Link to v2: https://lore.kernel.org/r/20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com

Changes in v4:
- add offload support to adaq4381-4.
- Link to v3: https://lore.kernel.org/r/20250304-wip-bl-spi-offload-ad7380-v3-0-2d830f863bd1@baylibre.com

---
Angelo Dureghello (2):
      iio: ad7380: add support for SPI offload
      doc: iio: ad7380: describe offload support

 Documentation/iio/ad7380.rst |  18 ++
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ad7380.c     | 511 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 495 insertions(+), 36 deletions(-)
---
base-commit: 73b788d05b5bd82c40193165583a9dcad2d8410e
change-id: 20250220-wip-bl-spi-offload-ad7380-6f1c27cd815d

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


