Return-Path: <linux-kernel+bounces-423221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6A9DA483
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029412859AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E040B192598;
	Wed, 27 Nov 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pLGVbh11"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8C13D278
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698657; cv=none; b=HxtzHEkBJQmOFHAheRQd0UF1TzZw+zQLd823pMyooY9Ty9ZU5BPuBG2qrKGg2ye5aNdV5kygSAynNJ0CDLSfVOEpD3rgJ3N1HRPxUxAqpGOP28siDqz2zl4Rjc7mEQEdxlfAfTeZjVD7lXebZ5KKaSKDZMFIe5+hZfblz4ZLxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698657; c=relaxed/simple;
	bh=QZoJIG4i22rvpeEjP14VozO0ncUdYmR+qk+/61rW/SM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fRmBziulh3eOt9xcQHmNtjRtvh7gxmByZMEAIh9JEUoePESkZBOi6zQiNd+zvOWvcsMoRkKs3bpjXYsNc/qnTOkAbC9WTjBZvE3RfcSLXzW2fM2Qap5d8g9CpFcl4kj+am+gt2ZJ5uUI0NLb82zQz579guFyVULCFjLd9W2eisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pLGVbh11; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so20114575e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732698652; x=1733303452; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ARUfUjR/mNZtMyZUX1PAGOx1NvyA7/7V2fkoOD9DnrM=;
        b=pLGVbh11MrHur+k7o5EWjcMKkSh8o5tFU6fzd4F/wTL3h5dHSdJLOmrY0/c2SMP63S
         rusNqBdH1Q+IRxSRwLw4h3on+podRDVARuXwKBH8q7dpjdUx4i9FoVnf75aM6za2Qeul
         zrt1XPqRD/lRgjDfKypANaCE3JIFcrDk61ZRJQq+vs4sULeQfQWoaLevtY6AG4bDZRql
         Msp79O/a88C5nk6JREMJ1g0VBS/IfDzVPlYPr5qrsET0NE+ORHfPETJ/vJPgs0gkwj4h
         saTSwtAH5W40I7ku8MxGr2JsH5shhlk/7W8QSo4zZhBPrj9DNSKB6nzXz94YYQfT+dTU
         P2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732698652; x=1733303452;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARUfUjR/mNZtMyZUX1PAGOx1NvyA7/7V2fkoOD9DnrM=;
        b=hQuAHM56I0GNJnUJaOsI3g0AJ/Cj1zvH9FqcmmsxbyuBSVfBOgtTA8V1QejxN2KC3+
         VJMPjlbxwquiA67be3nD1hshAv1cNUm9v5mNu3GTSbYguUdYr490czhLtLnSba+6J58V
         qp2TFDCNEclvQF7tz2CwnEItKXJ3VXcDUXM3oKdqkerUdkoHdclLNPevmiOtMO9VxHB0
         +UXOXgpQIOQ7Sv8Pu+9hQMHUDLwwsuDZxZYtkgv1BH08QHpuup3zyhew84fS7ZdJVL+H
         Lie69KXKA8IWzrRxlRJLJDmyQuxdF+ebbBbP5bWIo/sxokC7iPXua7S/T4NBcZu/sT2M
         O84Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/7Q606MaHJIwNloKB/f0mby6KQPwWHePxYFaRUYz+WVrSJbm5OIPGNd8uBHJJsJFqJwThJNitMS9LUF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQou0koKYpTBbyiP52DF1cG4U9qJjRgHO3n4bE/1jaQxMc8nBR
	JAq1v3XcWPtOnIC1gziYBjfc2waagT0+p3WGU02JcsKB0fmWUbiYJslu7RQyFAs=
X-Gm-Gg: ASbGnct/DCmkyl+wjWN7fH2VVnFGhTtXUZ5B9i88ZdaI/5kMKAP0Vs+6opqoYndlTvr
	yH5vRmfu41/IzBxBqtCnBAuvcHginswXNS+ks/Sf0k6ALOskk61uYdZZlhnoSh6YQNatOzT4HpP
	uMqBGkIhGJUAgflUDVB3MBbGe+eIktTCvu40PPcOu8WZaSF/JpEZnxmhSYh+rmQB8zIJ64hXwvB
	87UPaj9i1KTtHG+9WtsvKl1fHKcHjL1aURYr/aZlxMgSJKVNeKuUvIZKQRaHWnxjw594ZUGWNN0
	GlHyOnoxLaoP/b7zKsH5
X-Google-Smtp-Source: AGHT+IGNKf6uXXawKtgFNNvKo1b3skAMb7ABO4jD16su4RMqhM7N4xYyU7qakid9Lbz4trmUIDCpfg==
X-Received: by 2002:a05:600c:458b:b0:431:5a0e:fa2e with SMTP id 5b1f17b1804b1-434a9de3d04mr16420615e9.21.1732698651731;
        Wed, 27 Nov 2024 01:10:51 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5285sm14529415e9.40.2024.11.27.01.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 01:10:51 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH v2 0/2] iio: adc: ad7173: add calibration support to chip
 family
Date: Wed, 27 Nov 2024 10:06:12 +0100
Message-Id: <20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAThRmcC/32NWwrCMBBFt1Lm20gmmhr9ch9SJM3DDmgjSQktJ
 Xs37QL8Gs7cO2dWSC6SS3BrVoguU6IwVhCHBsygx5djZCuD4OKMiJJpW+f8NPpNfdRTrTNh2va
 EF7RXpaAefqPzNO/SR1d5oDSFuOw/Mm7bv7qMDJn0SnDre2kUv/d62WJ3NOEDXSnlB8Hl6ha3A
 AAA
X-Change-ID: 20241115-ad411x_calibration-2c663171d988
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.15-dev

Calibration on the ad7173 family is the same as on the ad7192 family of
chips and mostly uses the ad_sigma_delta common code.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
Changes in v2:
- Add a common ad sigma delta ABI documentation to describe calibration
  nodes that are common in the sigma delta family.
- Link to v1: https://lore.kernel.org/r/20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com

---
Guillaume Ranquet (2):
      iio: adc: ad7173: add calibration support
      iio: adc: ad-sigma-delta: Document ABI for sigma delta adc

 .../ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta   |  23 ++++
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 |  24 ----
 drivers/iio/adc/ad7173.c                           | 123 +++++++++++++++++++++
 3 files changed, 146 insertions(+), 24 deletions(-)
---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241115-ad411x_calibration-2c663171d988

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>


