Return-Path: <linux-kernel+bounces-197581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3C28D6CB5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF861F28C94
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC6B132104;
	Fri, 31 May 2024 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY5zwxEj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0A12FB3C;
	Fri, 31 May 2024 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196768; cv=none; b=hIxgO2utTx+mlZxN5mne4qVWgw33UsHd7K55hFHghuWX4++Z7lBMG3lGFJ3i+M82seN70egs7tnq1mqHZdfIdoGP+v7iy6kRM1ia4yvXExeR0taDkqn+Kg/W+U5X2QPg0Jh6rknlWSRdCG9pubFsI1QT+eN8qj2HANEnhF6cjCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196768; c=relaxed/simple;
	bh=D477luvfjF+eAUjbIeGfefKrBVDD7g8FJVaLkaaiD/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awetxMXq+FeickXHlcMsZQ5q08RJwqQdkua8p8i7zBCIxT7tnvSj4L3ohT2mZha/xPRxDUfA3L//A+uX2K6ROaEMuToeyLzzXM85zWox9ehim1ik1O4IerIlcqD6JnNjvhBM45oIU7CkgDRZl62KEKVRWDy8NChakhgqf0Fzbr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY5zwxEj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f60a502bb2so19495265ad.3;
        Fri, 31 May 2024 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717196766; x=1717801566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02bhcz6aLliaeLlyIbjSokkjob+eSiUQSZJ2z5k8rSM=;
        b=BY5zwxEj9kj4JJBBWV9zfuIDd3HuK60rnckTDskaE4XKQlJjxhB6uZRigqNQ8FFxHn
         kj1GF8KvtqW82tT5d3vHMv3CkYnU9q8PEjOePpkbqd2F1FgaljtDsH2b4o5WyRJxqG4D
         uJqs8EoAjI6FtsplGnzwwDF9q9SDp2e1iIGI8u+roKersCNNg1UdepCvSscXG3wx1U4B
         LTnKdVHHpIvthDR/mOB0pp0yA5Wx0YG9mjp4bUc66ULk2tjLQS/bc8zqfG6GxFLbmwG9
         l2RYoX5wesFJPjWWICd7jt2Pxh8PjwXrU/VO6r66OtC07Wz+rnUxS7fb/VmCGl7eZmGC
         tzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717196766; x=1717801566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=02bhcz6aLliaeLlyIbjSokkjob+eSiUQSZJ2z5k8rSM=;
        b=m5OabHwr9/dkqPxTWFVBaN+OLdUqOZlyxIkGeyUNW4GVnQAzPdEq7V2ywFGrjDkRfY
         iENbQrZDvlSON5ZJmCpqO7UYSlyESOytWyyE7yuowEDEXhQE3Du5asvtT2XfhRAKZ/02
         NjSWmDHN/70pLh+aqlzx2+MYBHxnkbNrGfmBXjFE19fv3/iI5dPaE2vzBytUVVcJgtJG
         4DYOq+Hv+loRalJ4ie1IM10P7DOTbR6FCciCiUfNoh1YGIcvuFWvOX/9JXCgkdoDhIcI
         7JtU8Y4gbTsRx5nwQ9H791gzV5wzqwiUrGVRGWwzEIlsqxKalH1UthOkUm9SYxci0u6E
         RKzg==
X-Forwarded-Encrypted: i=1; AJvYcCVQM+FeJCUMxZ4TuXSOLENhTIFnzsxEXcKR/RCbeaQZkeoGVIWuMJUIIPFhAtsbeOLZfZb62gEeSzWye1Uc04LgvkVeAt0pK5H1+gPK
X-Gm-Message-State: AOJu0YzKmewzAY6aXVKvgGc3645vU2VLSQm7QHvoHfbsUVxvN+SPxet3
	ILwwSaxRiWKuKrAr0ajjpR/nWGGl2hvKpSjFwhNxnxaSkKjjnNgsgmoHKQ==
X-Google-Smtp-Source: AGHT+IEJzqhO/+LLPMHrGuJ4d8cYvBJOqGK2NLaawgcwSpY+4g6Hbcc+uaYTtxUrLPMcoumCc74hFA==
X-Received: by 2002:a17:903:41cd:b0:1f4:adcb:37cb with SMTP id d9443c01a7336-1f637102715mr34946685ad.65.1717196766025;
        Fri, 31 May 2024 16:06:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632408348sm21996885ad.258.2024.05.31.16.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:06:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH RFT v3 3/4] hwmon: (spd5118) Add suspend/resume support
Date: Fri, 31 May 2024 16:05:55 -0700
Message-Id: <20240531230556.1409532-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531230556.1409532-1-linux@roeck-us.net>
References: <20240531230556.1409532-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add suspend/resume support to ensure that limit and configuration
registers are updated and synchronized after a suspend/resume cycle.

Cc: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: No change

v2: New patch

RFT: I tested the patch through a suspend/resume cycle, and it seems
     to work, but I am not sure if that had any effect because,
     after all, the memory is still active during suspend/resume.
     I was unable to test a hibernation cycle with my system.

 drivers/hwmon/spd5118.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
index d3fc0ae17743..baa315172298 100644
--- a/drivers/hwmon/spd5118.c
+++ b/drivers/hwmon/spd5118.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
 
@@ -432,6 +433,8 @@ static int spd5118_probe(struct i2c_client *client)
 	if (!spd5118_vendor_valid(bank, vendor))
 		return -ENODEV;
 
+	dev_set_drvdata(dev, regmap);
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "spd5118",
 							 regmap, &spd5118_chip_info,
 							 NULL);
@@ -449,6 +452,31 @@ static int spd5118_probe(struct i2c_client *client)
 	return 0;
 }
 
+static int spd5118_suspend(struct device *dev)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+
+	regcache_cache_bypass(regmap, true);
+	regmap_update_bits(regmap, SPD5118_REG_TEMP_CONFIG, SPD5118_TS_DISABLE,
+			   SPD5118_TS_DISABLE);
+	regcache_cache_bypass(regmap, false);
+
+	regcache_cache_only(regmap, true);
+	regcache_mark_dirty(regmap);
+
+	return 0;
+}
+
+static int spd5118_resume(struct device *dev)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+
+	regcache_cache_only(regmap, false);
+	return regcache_sync(regmap);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(spd5118_pm_ops, spd5118_suspend, spd5118_resume);
+
 static const struct i2c_device_id spd5118_id[] = {
 	{ "spd5118", 0 },
 	{ }
@@ -466,6 +494,7 @@ static struct i2c_driver spd5118_driver = {
 	.driver = {
 		.name	= "spd5118",
 		.of_match_table = spd5118_of_ids,
+		.pm = pm_sleep_ptr(&spd5118_pm_ops),
 	},
 	.probe		= spd5118_probe,
 	.id_table	= spd5118_id,
-- 
2.39.2


