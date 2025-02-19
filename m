Return-Path: <linux-kernel+bounces-521797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432D5A3C26A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40FC171A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7C41EB195;
	Wed, 19 Feb 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gew0IX9/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2A1F2B87
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976246; cv=none; b=R0OvdHC0Uid2Qfi6BIpDdKcH2VzW282B1zu0Jh7uN6bLj8v4iulp+93+LkowFOTKT99FW5BWelpwWSvGiTVxUt9y88KONlx6xVP8VdSnMdjmwhy6R+NvjZRElxQeKHQp1hOkTcqmnsLLIl/cRpl+Wa4TM7Xwy98HWfWguWd4ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976246; c=relaxed/simple;
	bh=JIJ/E5tjz1JLehb66AzAvqmd8vmktuXELCPYG3qQBiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pM/83m9O4i5AYrxlA/+MMHqnXqdd/C9e2ybklwnTaUFwOoSHlfVxt99maGzJYisDfkRxOVw+l7Otz6sKlH4k+nMLxHHavA2SMEaYd57vQvrppw9Mf4XVff+456/k5yttM80TfN/WkVAZ/vH6VN9kTlQJOxZ77YcaKoOP0RjMGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gew0IX9/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso75236575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739976243; x=1740581043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjafTz2s5QAjTYhGL901I5LpQk//qv4ffra6sDQC6aY=;
        b=gew0IX9/GzGT915p39fe2L1YqJUjww9MeT6cs79Q4JP0c181CX8ck8t7HmYaetL0pZ
         ZeHPEuKxmIbbKDvkqDO7BNwJ38mRtc1vMS65hG16S+YU0MtgrHDT64sHMgGE+6DRbjH3
         nxn/y6n4DRU3O7U3NCJzmmbzuXYVSuqDCxGq8Hp0snUjfigSi8qyhy0gCTXQtZpLtbny
         0EiZKMCviZ3irZcPRyLRggsoRBsITPNjvCaWAGdbp5ieXyxHHC2yTRm5jCG6YJup6/Yl
         y8uZTrQhwR/GGdU5gkyND7JgDRxPNnbkfAPXoS1myge7fxy0iB5wSUH7uekEE+u3STtJ
         ydmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976243; x=1740581043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjafTz2s5QAjTYhGL901I5LpQk//qv4ffra6sDQC6aY=;
        b=o+o3NkTxQvw8FL1PUowfNfKevFLITuo+vBMNx21DLlRYPZgsSoezqggwTfmG0CFDMv
         SxKpcSPtFF2gNn7RKaV9/aW+ctJe9DJl06N7q77pudn5aonaGXtn+ZPGcPKhh+JdvVBH
         IAKw8ZhG+Ydm92exuu1IBVC1xPcD3RWKVAk+iBQnHAeMmJdxZidxHPYa90LWxPWcjUPL
         zxXEV2TzBP3ikKS7WJChCssBKaXmrj+djSgEbnehlpWEDV2jJiA1VT7xQwNZhWpLKWM3
         4i6HfbEK7EhQJp7n7iHvaSqgChrSjfA6M+PQQ35IzQPbqdO8+WqTriCGEeDAbTeoq3Nc
         uGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpJ9JOrNezIZBCnT7LYoEdLLNB1Y5FdatkXWTTzKFO8L5g5Zf2X3HBMhemdAsRW5ufitKQxkWGBbblD5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJf6bhnPdq0Qfe+snmCW+we//avKajTRm38ROFdU8zyO2MHIP
	brPeT6JN0cI//Vi2Xb9bvkjryweP0p6jhf+lM75eKIC/80u24s3FtlA50w8gZfQJqLAKEMwx5hT
	92Nc=
X-Gm-Gg: ASbGncv/DCbdIVbOlgjKHNg5lUnX6hoZC6TU3JShQpKlJPAwhEW5oIv0ZwTh7Brg1tA
	YJdVvUh3OGxAntg98qSZT/eCJqUSqQcaQSwbFxCPo1eOYq87NouqQ70ooK9hHLgCpJks69bR4jK
	1EBEc8/GKe73QYKHxYNBA29wI/FiU0ZWQO/N3f/bKf7ob1Vsi4g9ykri9I63Qh+iC+96z9Fggo0
	e8T2Cx0g06D/JQifnJ9nJP/Tl+6dy7uzBa4TBy717TAmx3Vi/nzIBOLcBeuoS/5FQKZrBR8yr+d
	s/bLJ+g/Jg7wDw==
X-Google-Smtp-Source: AGHT+IHk61Hym0qgekYAmPlkGyuZ3YcsegEJqHegHLnwBvZNjPjl/N8SXL2g7SZnxZqdvx9UkJKgPA==
X-Received: by 2002:a05:600c:3b02:b0:439:9a40:aa0b with SMTP id 5b1f17b1804b1-4399a40ac9dmr31659175e9.25.1739976242610;
        Wed, 19 Feb 2025 06:44:02 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:f0ed:3532:fe6:315c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43984924201sm92536685e9.6.2025.02.19.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 06:44:02 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] gpiolib: don't bail out if get_direction() fails in gpiochip_add_data()
Date: Wed, 19 Feb 2025 15:43:56 +0100
Message-ID: <20250219144356.258635-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Since commit 9d846b1aebbe ("gpiolib: check the return value of
gpio_chip::get_direction()") we check the return value of the
get_direction() callback as per its API contract. Some drivers have been
observed to fail to register now as they may call get_direction() in
gpiochip_add_data() in contexts where it has always silently failed.
Until we audit all drivers, replace the bail-out to a kernel log
warning.

Fixes: 9d846b1aebbe ("gpiolib: check the return value of gpio_chip::get_direction()")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/Z7VFB1nST6lbmBIo@finisterre.sirena.org.uk/
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/dfe03f88-407e-4ef1-ad30-42db53bbd4e4@samsung.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 704452fd94bb..48cf1bb23e24 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1060,7 +1060,15 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		if (gc->get_direction && gpiochip_line_is_valid(gc, desc_index)) {
 			ret = gc->get_direction(gc, desc_index);
 			if (ret < 0)
-				goto err_cleanup_desc_srcu;
+				/*
+				 * FIXME: Bail-out here once all GPIO drivers
+				 * are updated to not return errors in
+				 * situations that can be considered normal
+				 * operation.
+				 */
+				dev_warn(&gdev->dev,
+					 "%s: get_direction failed: %d\n",
+					 __func__, ret);
 
 			assign_bit(FLAG_IS_OUT, &desc->flags, !ret);
 		} else {
-- 
2.45.2


