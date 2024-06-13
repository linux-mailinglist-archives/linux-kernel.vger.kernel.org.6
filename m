Return-Path: <linux-kernel+bounces-213309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E47990739A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F461C23110
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C504145A1D;
	Thu, 13 Jun 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ClYh467H"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8E7144D18
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285059; cv=none; b=gSn5cHJyBMMRtAcsVgjN39fuM3iUkVPzQJOvun/Ad13zVntJkkxjPJLy1t1kvlD0O50IOnMk23cO1SUWCOBcwvhjeNSKmW0P+9h6uj7k9TSTbOittCZ9sortJPz9qzYrBhrRPGIdwuF/B9wgunNw42da1QebRkmKxzWWY4c/6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285059; c=relaxed/simple;
	bh=IzjMEluDdj9W5D1MbEZYeU4rwzK3qTksCGHXnGpVbHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nokpdYyY7smwd9M5u6iIvIyaLSYC4ouwUfakfyZMe4LcnyPpprSZPv3DRlnCA/8vftJNvc09J85ID5b5Etsnkk2YVioZ75gR4DFbUA53zHD4MK6z6m1NFSaEDDo7TS8ZTILnFSm4UCKlU3N/ISr9Fl7Zw4Nf51IUhso9+BZp3n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ClYh467H; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so1310462e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718285055; x=1718889855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/cKWx14xpoqErwPaH2eaTi1rw2DF/KkbsM0RLotWgM=;
        b=ClYh467HUncyqyqDJIfwCMnus5446SWCFmPS7uaF/QGkHmg3zdApZ+rxJcPn2npF/2
         f5c2B/mAe3C6xMDB2syskx1G7OCfMg6w36vyLn9qWjVuh/oLhBh7UP3wx4/IIW05P1Ka
         cvWtrZf1w/HbvLvqSjlacPEViTLlS5/JMVqd3ZNTuNscFFQr5EZdA4P/1pO+SukuwXjz
         pMTcwYp0OcbnJm+FmfREzsRId7o+q2RMQ8uuSgdQFz8DTNi/lx7wz+oz9sYyUFKk8Qg5
         f+sUnCVpWYI7Ak9QWWHved1GFjORFuUz1t6223Yq2toYWA33O6mBVVE0ybqkiVwPX4Bu
         Pv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285055; x=1718889855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/cKWx14xpoqErwPaH2eaTi1rw2DF/KkbsM0RLotWgM=;
        b=X76jCzed+tuuxDUJHN57n11ENU78pKADuhNnqwDX307oNb07f6Ipu1NoVXBuChWbme
         byn7mRwi56X5zkh4m2xXlFYMPrIY0MaVkl855BPqrW6qif61qB2W2fqYV9543uecANtK
         DdMvV+GofUzFYk94/1TptO013wm6NBSw0fU0hM5KVr9WAIyEug5xljuVdPUh+w8aG810
         mc9zW7aqO+qS55GJGKj+SGARi9SjzZBlAvi99sswYXmjz0rxJT42J7cDeuSsze6jU2xt
         BVr2WKHBtZMf/S31m8J/6tHqXwSxMeU3knFOwV7VrPHfz5MK+O2jacKHqwf88P1FHDi4
         sF9A==
X-Forwarded-Encrypted: i=1; AJvYcCV9u8a/qK/NMB/s4cEfqHMLVsZ+5amuIPogEmI50QqBJ4wPDTb5OyMSfNMXHgg3C+/OHjVLK7SqGwnvBfdb3/06RZIfk07QMp+GE9Er
X-Gm-Message-State: AOJu0YzugLzcJsy6wFznuoCZKqyMnzj3fZuh1ACEIupp69JNG7DCWgZO
	5nAdZPzDQNYtgR/7EVV3qk//2VsKJNgfolC9s1xVwcTU4QoelcUb3/PzYIPBGgI=
X-Google-Smtp-Source: AGHT+IEW1DcyYr2GYnlaMVY4yuAlqPs3gS+XBOdOdHo9qdeEuBtnlVor/QNgoD89nj7+WVfOt1DO4w==
X-Received: by 2002:ac2:5456:0:b0:52c:9a1f:52e7 with SMTP id 2adb3069b0e04-52c9a40587emr2960247e87.58.1718285054549;
        Thu, 13 Jun 2024 06:24:14 -0700 (PDT)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33c6esm25086225e9.4.2024.06.13.06.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:24:13 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 0/4] thermal: Add support of multiple sensors
Date: Thu, 13 Jun 2024 15:24:06 +0200
Message-ID: <20240613132410.161663-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following this comment [1], this updates thermal_of to support multiple
sensors.

This series intends to add support of thermal aggregation.
One use case for it is using the IPA in the case we have
multiple sensors for one performance domain.

This has been tested on the mt8195 using s-tui.
To test and validate, we heat up the CPU and the heat sink.
At some point, we run benchmark tests with different configurations:
- Mediatek kernel (IPA + their own thermal aggregation)
- Mainline kernel
- Mainline kernel with IPA and aggregation enabled
With the IPA and the aggregation enabled, we get the best performances
with the most stable CPU temperature.

The aggregation is configured and enabled using device tree.
One thermal zone has to be created with a list of sensors.
It will take care of registering a thermal zone for each sensors.
The cooling device will only be registered with the aggregating thermal
zone.

There are still something important missing: a way to check that all
aggregated sensors are part of the same performance domain.
So far, I don't see how this should be done. Some recommendations would be
appreciated.

Changes in v2:
- Rebased on 6.7
- Separated generic multi sensor and dt specific code
- Simplified the code
- Drop min / max and only do weighted average (seems more adequate for IPA)

Changes in v3:
- Rebased on 6.9
- Reworked the way to register a multi sensor thermal zone
  - Only one thermal zone to define in device tree
- Max has been re-added
- Enabled it on mt8195

Changes in v4:
- Rebased on lastest master (fixed the build issue)
- Dropped the average since I don't have any usecase for it

[1]: https://patchwork.kernel.org/comment/24723927/

Alexandre Bailon (4):
  dt-bindings: thermal: Restore the thermal-sensors property
  thermal: Add support of multi sensors to thermal_core
  thermal: Add support of multi sensors to thermal_of
  ARM64: mt8195: Use thermal aggregation for big and little cpu

 .../bindings/thermal/thermal-zones.yaml       |   5 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 212 ++-----------
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/thermal_core.h                |  15 +
 drivers/thermal/thermal_multi.c               | 288 ++++++++++++++++++
 drivers/thermal/thermal_of.c                  | 250 ++++++++++++++-
 include/uapi/linux/thermal.h                  |   5 +
 7 files changed, 579 insertions(+), 197 deletions(-)
 create mode 100644 drivers/thermal/thermal_multi.c

-- 
2.44.1


