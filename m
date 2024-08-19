Return-Path: <linux-kernel+bounces-291906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802799568BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FED8283141
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6C16193C;
	Mon, 19 Aug 2024 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK5RBWAF"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F115B138;
	Mon, 19 Aug 2024 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724064520; cv=none; b=Bphccp/qUKFq4o9WxugnEq5zyRp7HWrcSTtM3kqOdgdS+ThwpvQeDo1EB0poV50kxVWmB1Xdy8mURdOcKvy/fxc2IBw2SwwdshT7rZwi/Ym9LA9blL6NsJZ+xlHwnxRpNpD/+ZldE77VQ4W2+1sANECqo9o5q3m0WJD/yh/3ZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724064520; c=relaxed/simple;
	bh=Nj3xiPSoYEtxkGOEeiU2Eu9JpnPXqvdR31ixJzvMFkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tFaqAQD6RHlm1URnjtjOLmJ6Mg1AocmKlCvd17BJY8Q7vKtvgphqt4iQZ5uHEbRyKiazZxh2dmOrFNcD0+4a1u4EgfRu/F7BkbPmIsbRuUQsnNixLFbJelXnuZZxA7/oPEOCuWsn8dqCNF7wXrTYsDwC8uFECdqkwlpQ8G7MvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK5RBWAF; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db50abf929so3093797b6e.2;
        Mon, 19 Aug 2024 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724064518; x=1724669318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDFNlrnnBewoOaJUJduUAuxeqCnWuQdb8/A7+0DdWAk=;
        b=aK5RBWAF5ieAHXm8EgAjtTI4mna6MyzyEEl1gCVLQDTWK/B3iXsqxc14lkIQBrx5cf
         Q8t7JrfWhL6ZITyLZ6meMMaXj/BU/+pAFkYELsB5FTalrNeiOBFTkxqjl4oJ2XlOFWLp
         GSCJDj3f8qhEijI2R/FfXxpimNQNnRN4hmvOQayp31HQXMua6iu9k95gfXKRhaAR49Pf
         dzPQ64yzM6y0m+iQjmCAGQoYgqphmMVlATpv6hfwhBr12EXjqiFZhFcq+72Pf6Do+q1t
         +MIKvBDMfnbKNcXKpjHsLO0GJH9fLeM96VZZhLo0Y6a4/v31CSlg45fFIybuMUQsF3t9
         CJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724064518; x=1724669318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDFNlrnnBewoOaJUJduUAuxeqCnWuQdb8/A7+0DdWAk=;
        b=Kuh/Gj/S2wBmLrSSYRrux4VxRnEdGcknS2YRnd+konZc/zogBYxaVJFzO1RchOj56V
         lB9hiVONJUF4o+r0Bbkbvo1qIgw/iGE7NSZBgqsnhdmVeEcDeE+6jqnOtEYexhUttl57
         S35r6qjJdZmDGCyg5cGOxM8wV1Gg028jjwKOa7cihqL4PvOaOlN3ycmQ8w9Makt6tSd1
         UU03PprY0Y8WISaCuctIM/NgYzxnZxWQnhs8bhqtu4Hs2X6Swe3mk6grC6ak7FGe7CRP
         a4GCMjnb9IO2bc/d3CpfOqWrB4HQtLCjPaesfnffW3zP0yLW/TPtlIJcujoXxd8DDe95
         COoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiGgAE8JLVpqtAVbm+y+0le9nGYGzrl0IPN1gdgoeSF97Z8nGha0j9i5GpW4nuefpbpntLb2UZ1lQCqRLQ07kqy9cq3Hc/yOqGP7Mi
X-Gm-Message-State: AOJu0Yx6qWkE956fzp/5QwIpijpXq5PHlXOSZamnW67+SdkNSwhqaPeR
	vJDqjOCV5Oo7dMXJ5VGHrqJt7sEEPsLuCd8wjlbkuY2OWU2jN6Bt
X-Google-Smtp-Source: AGHT+IH48RRsLHe6pXtimb9oroClbatZsfiSw2mL+xvJI8nFcl5Xr8mDI7Jo2qZcDMRy9XKbaUCmUA==
X-Received: by 2002:a05:6808:1991:b0:3d9:da81:6d59 with SMTP id 5614622812f47-3dd3add4ecbmr11901379b6e.34.1724064517489;
        Mon, 19 Aug 2024 03:48:37 -0700 (PDT)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61ce853sm7286031a12.37.2024.08.19.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:48:36 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: linux@roeck-us.net,
	jdelvare@suse.com,
	chou.cosmo@gmail.com
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com
Subject: [PATCH v2] hwmon: (pt5161l) Fix invalid temperature reading
Date: Mon, 19 Aug 2024 18:46:30 +0800
Message-Id: <20240819104630.2375441-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The temperature reading function was using a signed long for the ADC
code, which could lead to mishandling of invalid codes on 32-bit
platforms. This allowed out-of-range ADC codes to be incorrectly
interpreted as valid values and used in temperature calculations.

Change adc_code to u32 to ensure that invalid ADC codes are correctly
identified on all platforms.

Fixes: 1b2ca93cd059 ("hwmon: Add driver for Astera Labs PT5161L retimer")
Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
Change log:

v2:
  - Fix build warnings of dev_dbg().

---
 drivers/hwmon/pt5161l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pt5161l.c b/drivers/hwmon/pt5161l.c
index b0d58a26d499..a9f0b23f9e76 100644
--- a/drivers/hwmon/pt5161l.c
+++ b/drivers/hwmon/pt5161l.c
@@ -427,7 +427,7 @@ static int pt5161l_read(struct device *dev, enum hwmon_sensor_types type,
 	struct pt5161l_data *data = dev_get_drvdata(dev);
 	int ret;
 	u8 buf[8];
-	long adc_code;
+	u32 adc_code;
 
 	switch (attr) {
 	case hwmon_temp_input:
@@ -449,7 +449,7 @@ static int pt5161l_read(struct device *dev, enum hwmon_sensor_types type,
 
 		adc_code = buf[3] << 24 | buf[2] << 16 | buf[1] << 8 | buf[0];
 		if (adc_code == 0 || adc_code >= 0x3ff) {
-			dev_dbg(dev, "Invalid adc_code %lx\n", adc_code);
+			dev_dbg(dev, "Invalid adc_code %x\n", adc_code);
 			return -EIO;
 		}
 
-- 
2.34.1


