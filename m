Return-Path: <linux-kernel+bounces-365438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D899E245
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088822840CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B9C1CFED9;
	Tue, 15 Oct 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eW2Bhrer"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8831CFECF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983349; cv=none; b=Wo3jR0vuTCQgkSNBFqVKAyKrzxxwim4Mldc4eL2bGZZ9+IlEMHFXKQ4rxtlMU0I9t0rTwh4piz9HmmhgbVg/yZ3UpebSQRmWr0Rm0Q6H2IE1hQ1h5MNIb1BzZw/0a/90NxziCWTtMGHx+tjXySniRPGpEOZYac4/AFbpfcNL0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983349; c=relaxed/simple;
	bh=LtzIlROurSiaY9C3qcwo268+cnEG6r5bRRRuf9pnuPk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EpCjBg9HwDefgQf3WBiq8ECNKwNLjYS4f8cBpP7NzovdkFMr+drSuQcLVdYUWx7TB/U/WGPnuiA1xq5iwLC++9neUxYlG1ccy3N3aBSFP8qm77RvvC3EEe7KvuOL8KQMVAEAEAb9BEcVk3vApy82BewWpoDKDzvUBcQc1nnzMOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eW2Bhrer; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43124843b04so27457475e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728983346; x=1729588146; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zo4oi4aky+ivt1/kLLwbqQ8oWOYu1u0gufAG02tiQEU=;
        b=eW2BhrerPpfsGyT/ac8N3PHatG5Tw25Zn6rKaw3/3X/cRfw95zsKTn8Z74KlaT+aqI
         YqPL77VUIss/X7R+ioQBFpwzll88bUUfV96zGSbpE3dvZPlN3v3gL08JKs9jiWx+3THG
         Ynq4gBrPg1rYPAqzbKdD3aeR8+Y+JdUzpl7Q2xmhIVmfF0yo/m/49I7QR5vq79f7YD0p
         2JaCi1xoxkMwqbjy9O897ZeYLGH5BPm3ZKI2It8oJ9vXZcJfax52wuqXQC6d11YgVnmO
         6nHSxm8Ct0mrhsf9uWm7zZFUHtALkRx8XZHP0Q1IUgeFDviRckPreptTMCr40bUGcdEY
         BZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983346; x=1729588146;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zo4oi4aky+ivt1/kLLwbqQ8oWOYu1u0gufAG02tiQEU=;
        b=v/Y8Vz/BTTB/xjFmJBO7RYSI2ddt8mmJkWOvB/XCZQKHEmN0XfYRcRDIytbj2+VDih
         R23xwb1fzLeb3ochKdGYHXV1q91RYsOt887C/MyINs7y0+0Z0PIcHxcLKR/b2FFBkNc5
         /SKmblSXXAFE1NaE4YljjljAqCmypxMLnKBqE/I5aOHlb8F8RafyXDy7snOoyOhLtBzb
         ktbcur/EmuLxl9jdhmVDjKQ9LgLhF9ngIQ3U5VcaAA1cx8pJJmd+9g3mCHpsyWaZ8IHg
         algVJiBaT9IUie5qCRYWR+BnrGyc8KE7OUtjZcLFttU9thpgeVGKXvp/RY6fZLe99IVy
         eU7A==
X-Forwarded-Encrypted: i=1; AJvYcCVoZfV63nAQTdzaPtUqDTPENj+O9jNHLnRlR1zOsgeT+6aq1izVOlj2RhYq7KgIJdJL3LQOFcTtP30JhPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxmgTSovOvkUpY4jvs/s7P+bYUyv2YckRqcgoQMlX5yG3HiH7w
	GtTxKqi9uN/BnR58+0Ga3Q37PsPpW05hfEsdfTLkfCa68zZ3qAkiuiqBHxI3bzI=
X-Google-Smtp-Source: AGHT+IEilcQqGZU77u5s49pKan4uTKo0ZlBRqQasDoTCdTFyKhvCZ4pBrcIKYkMF4Iz33U7oU75T6A==
X-Received: by 2002:a05:600c:1551:b0:42f:8515:e48c with SMTP id 5b1f17b1804b1-4311deb6142mr126238045e9.3.1728983346102;
        Tue, 15 Oct 2024 02:09:06 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc123dasm1012882f8f.94.2024.10.15.02.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:09:05 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH RFC 0/4] ad7380: add adaq4370-4 and adaq4380-4 support
Date: Tue, 15 Oct 2024 11:09:05 +0200
Message-Id: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADExDmcC/02PwWrDMAyGXyXoPIPlOLWXa2EPsGvpQZaVzbA2q
 Z2WQum7T2s32EGIT4Jfn27QpBZpMHY3qHIprcxHBXzpgD/p+CGmZGVw1nm0OBjKoY9WW9aik/8
 Bb9p5Wea6GvSZMQhb615BM5YqU7k+8nfw/raF/XNY5XTWW+vvJlETw/PhUNaxi0mojyESDoiJh
 TK7KU0u+mRtYh7IiVKG/45j9zS0/s9Q7z60vvQ9029C6DcDT5FovCDs7/dv9Ue4dfsAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.1

Hello,

This series add support for adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS)
which are quad-channel precision data acquisition signal chain μModule
solutions compatible with the ad738x family, with the following differences:

- configurable gain in front of each 4 adc
- internal reference is 3V derived from refin-supply (5V)
- additional supplies

This series depends on [1] which fix several supplies issues

[1]: https://lore.kernel.org/all/20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (4):
      dt-bindings: iio: adc: ad7380: add adaq4370-4 and adaq4380-4 compatible parts
      iio: adc: ad7380: fix oversampling formula
      iio: adc: ad7380: add support for adaq4370-4 and adaq4380-4
      docs: iio: ad7380: add adaq4370-4 and adaq4380-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 117 ++++++++++++++++++
 Documentation/iio/ad7380.rst                       |  15 +++
 drivers/iio/adc/ad7380.c                           | 135 +++++++++++++++++++--
 3 files changed, 258 insertions(+), 9 deletions(-)
---
base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
change-id: 20241015-ad7380-add-adaq4380-4-support-14dc17ec0029
prerequisite-change-id: 20241004-ad7380-fix-supplies-3677365cf8aa:v1
prerequisite-patch-id: 6d87f69eed38931663a1fe4035d92bdddcc06da2
prerequisite-patch-id: 337292de00e31ecc2f71eac207542f236d8c0ff4
prerequisite-patch-id: 7dee57142d0d12682b0be3b62f1c16851aeac069
prerequisite-patch-id: 4ca1d234fa53f27d4e73150df5b00e245a142f67
prerequisite-patch-id: d42f3c478b92a6f97194853fac271add226803cf
prerequisite-patch-id: 972bdbf06bafa7c56f604dbe8eb7d236aadaad99

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


