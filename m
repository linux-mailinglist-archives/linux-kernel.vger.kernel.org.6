Return-Path: <linux-kernel+bounces-427244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF439DFE89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5176C281F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA21F9EA4;
	Mon,  2 Dec 2024 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WI5LKMdR"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626B1FA17F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134471; cv=none; b=dRytdj2mcnTaJxImBWUx7HN3P5+102WL7ZjpNTMT8D+afAF83qX5hRPet6RSN4w8ghX+thMNXPjd46pvY8FUk5PWCEzU1KwZtZOz3QsMmS3Yez0XBUQjluauiRuXFMtk7pcBTL0pasrCyDGcba3wK9KN7XSW4z4nMyVBNd3w0D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134471; c=relaxed/simple;
	bh=y89btrVZZHWMs6tFQVeVoCpJGbf3KUnvEJFPQGsh1qE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q5SFV6+2Jy8r0olNhbfIQ3Y/IDc95XfwGF5sklUOIiiuSJko3GBzF09hnPQ2ZDtjpZV3rv3qMBkMI/TynEfrlqj0cma2TKprwRP8GpzSMW9Ynf8hnIk6uE6qLg4riWzsnMaNEoc0/4WDl/nn3+YdF4qb93A1ibUxSLuqxvrhGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WI5LKMdR; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffdd9fc913so40860581fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733134467; x=1733739267; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEqu8QTTmJEH9b+tgcljzF1wPRZvnpRGaZo9l19yhks=;
        b=WI5LKMdRcFrPoL//rzJE58z4pyqRrIkPFDU4pzP2yGfuvzjSxJLJGmAl805RTA8aRC
         dYTtrFoZFD9H/ZIHnzOA1UJCMJwOOKTAp7MvXZUIU0BNDsGVXoW86aN9zBtZcioVFCWL
         ZMUSjKM8/Sluli6mFT4J02eVRZ74AqxMJdJtQLvlhRGmPuy8Lj+LBYs4Haxh2l8FuC5c
         iknCp20QBNWQMElV+Jfo8INeVGjROv9nYNH1HaCe/T8gNJjimzDR/lLSMDQikgUXDH/7
         CbZJS7JyZKyAquOOAdw/69ktilttlQPfUvdlsC/PbS7e/RKzXdzQ3QWHO4CI+5q3cM1j
         5pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134467; x=1733739267;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEqu8QTTmJEH9b+tgcljzF1wPRZvnpRGaZo9l19yhks=;
        b=idqDbBjNAm1T+kxP+vdjoRTWg2kozCtU2CxEi/ekuZJt24iCIu1SFlvHpbZOKBXcCu
         CQ00yGsgysFy4ooxPvHGIU0RAcin474SCooqKgLw/WKfWtAog04C9uw/8K8lFHdsMVN1
         zciZbEfF0leM/CWndwnMV6Vdn9ZiFIC/wlzKJD2CrJj+GddFIG3wXmTGx+MCV1ARxvhs
         sjylwCwREU4zUnagzhzC0GFPT1jk1qCdWoTiNvo+z7mwcUM216UsB42H8yFH+pMdLSv7
         hXIMNXzsw6f5dzz5xr6N4hIEfQ1uPt/slRbEHadPvOcA2vdCF6TahzFIL+d0wUW0HiHU
         xh0w==
X-Forwarded-Encrypted: i=1; AJvYcCVxutJmNUVTUaCV8UBQB511tRr/U9+CRVal/jweTS1v5fR6umTvxuV4WAV/b5kXy8hz8YDhhMRjQI2XiXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qG2avn4JOrhNnCPnXuKUE/oTO3mV/TbJgslpPH+l8kN5Mzxv
	SLT/npvGtRIfTwKuKPt1J8WsJRvMtP01N9K7Fy70soldOPKf/cqF44P+OGGltrk=
X-Gm-Gg: ASbGnctBq4VzASfBuAN2rv+7Yne5agP0vMvRVx/UftiergcTr27z/5Q2YSqAkh+9Zhu
	tU9gBLDjcxYT+kt9ggS3f0z0a9MP9RS2qGoQmyZMgG8/hlp3cuimZ8BumukaQu8oroTYSpa3ufs
	Wu8aUGntkCZYXdUOfrlBVGUovXV1p4j6Rve6lSuM2Yj6geIL9+zNpk6YYeWNYZroCsKuT7W9bIo
	maXFz3KigbhaDzc7hQDVQIqE2x8Kp2Qettq/BQd9iFe/qLJZm3/Bpcov7Uh5uf7LQcGeN0UC7Bo
	7PjMQmlH1lj5pnm/DXHo
X-Google-Smtp-Source: AGHT+IFouL2tbzASUTdPpFT+L+a+KMjLRYgELVVpgbmS4v/eYLV2yBBgeVOSFMTcgCxdfeHhL4SyXw==
X-Received: by 2002:a2e:91d1:0:b0:2ff:cae1:2297 with SMTP id 38308e7fff4ca-2ffd60cfac5mr107823531fa.26.1733134466887;
        Mon, 02 Dec 2024 02:14:26 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5e59sm181138325e9.44.2024.12.02.02.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:14:26 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH v3 0/2] iio: adc: ad7173: add calibration support to chip
 family
Date: Mon, 02 Dec 2024 11:09:51 +0100
Message-Id: <20241202-ad411x_calibration-v3-0-beb6aeec39e2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCHTWcC/33NSwrCMBAG4KtI1kYy0yaNrryHiEyT1Aa0laSEl
 tK7m3YlIq6Gfx7fzCy64F1kp93Mgks++r7LodjvmGmpuzvubc4MBZYAIDnZXMeboYevAw15naN
 RqoAK7FFrlg9fwTV+3NDLNefWx6EP0/Yjwdr9yyXgwGWjUdimlkaLc03TOnYH0z/ZKib8ULD6q
 SAXXKkS0JIpJNGXsizLG94fTs/9AAAA
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
Changes in v3:
- Small fixes to the ABI documentation of sigma_delta
- Move the system calibration mode to the ad7173_channel to avoid yet
  another allocation.
- Link to v2: https://lore.kernel.org/r/20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com

Changes in v2:
- Add a common ad sigma delta ABI documentation to describe calibration
  nodes that are common in the sigma delta family.
- Link to v1: https://lore.kernel.org/r/20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com

---
Guillaume Ranquet (2):
      iio: adc: ad7173: add calibration support
      iio: adc: ad-sigma-delta: Document ABI for sigma delta adc

 .../ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta   |  23 ++++
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 |  24 -----
 drivers/iio/adc/ad7173.c                           | 116 +++++++++++++++++++++
 3 files changed, 139 insertions(+), 24 deletions(-)
---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241115-ad411x_calibration-2c663171d988

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>


