Return-Path: <linux-kernel+bounces-444981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF9E9F0F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7702188281B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211791E22E6;
	Fri, 13 Dec 2024 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6n7TOqC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522E1DFE33
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101368; cv=none; b=sRoLX6y+H8iwKXo9XwajynMdCsMMKU0u+EAVbjs7VkQpac1eWYP/TdMrq33Ill2AfdGWquIpyi441CE+HJ37zKvzDZY1YuNYszr1MsAkgskUea5Jf5bdwWgHHC+TmnDfbnzpsJdQ+1zbLOce4pV4cNeTehQ/nvUMFxrS967o/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101368; c=relaxed/simple;
	bh=SIsC3C9i1wELYLT6FCZ2zsprbHI9S3yM2hqoLVMVBu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtW/4Ysu0W4QGnTjLZydKlEIcIteEC1324ECYTeluEo1H4hKwasvuB9gsrSVbdqxdVgSE+tLaScsy6RpIhhDD13OmWdNY1t/4LrJoIsCMxKyEVQ/MrISsmzxyl3V7MJQPSQCqGNSl3tgQ53ZNNaQaFjGpva4TS0xEWQ6TwAe9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t6n7TOqC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43618283d48so13409015e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101365; x=1734706165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15AaAK2+TNf0pjNDy/UAqLLtCRlZm3/kpGALTDknfLk=;
        b=t6n7TOqCj4oVvwCCeh05j/IHlJZ1PtXHobd6m3/Wkq5CrU/6lzpQ/QJVmvp4cL0H0o
         QDIPBzhvY8YSExEg+20JTNgi0Yr3pQ2+zjs/rJCTfbg0Et3uM3t9xpGwJIyHGeSMMIGs
         rjyNjLHUiWObxjJvTBUbhoKR8+1Yu+ZYSqlq3q8cGBGXYqA7jA8zxQuX1DYyRLvGKYGK
         rtHSb3PQ3XMKgeE2s2mVVpRiE20OujMFd4CTWaz5A77X/khsVkTRljI+xwpeVzbWaR9W
         bep5hEd0MyRoeFIYfmiZhDyQw6sDuu1hEbx3N7rPl1JL4+zhhm3tM79fUs67DLgCbolG
         XKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101365; x=1734706165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15AaAK2+TNf0pjNDy/UAqLLtCRlZm3/kpGALTDknfLk=;
        b=skCTEEFG9n2GFVRrCkAyf0bwn38r077hGJHo3cyC/YtCVbGVHIdypSiRB7Ve1ompi2
         fS85xnun+MQzE2KiwqZMSWHGHotIRHejmYu6PDUEYXjmBVdHp7jEmkzU/1qbOUoZP6Jt
         zQ21s0ySRr3ZQAKwjn+bHtGOTBR2kGuw9cTkLGT09JRx/I6nlTasK226iYuio42v1dz2
         tE5U59lkEZCd9RZhr/Wi+b6irI2dpB6bJjp8ItFKkuzHQdBPoa1hW7SQiHlE6kgl09yV
         DghD0n8FuqQCTyNu6/HLs7sYu73468Fg7mMsxDsD+l3NKYo3ZJVV2bKnaNpEXl5u0k7j
         foiA==
X-Gm-Message-State: AOJu0YzEeGMbMpIBzCgd4J6qghq8acCSsku3ryT6n1DgubvuTHKwtr+l
	IWZWXeUIrJpGR5Z+Y+Yk/lhQlJ39GlyMnACsFtRV9fwxIUDXMDPWDsBf4Hfc/8Baf6+lVzWQhXW
	w
X-Gm-Gg: ASbGncsGKFk+wPM0QSCgOFV5MtST+OSZIzrktib944zIYMhcKQQKCmtRSYw9nI1aqXm
	5cYc/RTYsOVt+sBTd6r98A6tov06n56Kph1M/MLbB0jJqnSoLh3NdHtvq4dy3nHUVLqWj2cwz8T
	MSfDoQ1KUCj25DXjiAHv1MznPn3urN0YeHG/XRtXz15lrGAXgABfMMBksD5hLuAOxhvKQHP5e60
	rgqBuMjW6UXG1H9jZohwmQ4MPBqK5chCp9kxD2upC+9d4uzvlu0KTZtUw==
X-Google-Smtp-Source: AGHT+IHO0M2mkaBgTv2bRXcbzSWDj4N1+DMABwuK3YzAtH8N7NuvAFA9fIE961ZHfmLSmGa1Mu+Zcg==
X-Received: by 2002:a05:6000:2ad:b0:385:df6b:7ef6 with SMTP id ffacd0b85a97d-3888e0be442mr1907627f8f.51.1734101364916;
        Fri, 13 Dec 2024 06:49:24 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:dd7a:c2d:2b46:b1a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824c50b7sm7196295f8f.57.2024.12.13.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:49:24 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org
Cc: james.clark@linaro.org,
	mike.leach@linaro.org,
	suzuki.poulose@arm.com,
	alexander.shishkin@linux.intel.com
Subject: [PATCH v2 1/3] coresight: Update timeout functions to allow return of test register value
Date: Fri, 13 Dec 2024 14:49:17 +0000
Message-Id: <20241213144919.110642-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213144919.110642-1-mike.leach@linaro.org>
References: <20241213144919.110642-1-mike.leach@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current coresight_timeout function spins on a bit on a test register,
till bit value achieved or timeout hit.

Add another function to return the full value of the register being
tested.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 50 +++++++++++++++-----
 include/linux/coresight.h                    |  2 +
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index ea38ecf26fcb..feb1a1db355f 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1017,32 +1017,37 @@ static void coresight_remove_conns(struct coresight_device *csdev)
 }
 
 /**
- * coresight_timeout - loop until a bit has changed to a specific register
- *			state.
+ * coresight_timeout_retval - loop until a bit has changed to a specific register
+ *			      state. Return final register value
  * @csa: coresight device access for the device
  * @offset: Offset of the register from the base of the device.
  * @position: the position of the bit of interest.
  * @value: the value the bit should have.
+ * @rval:  the last read value of the register being tested.
  *
  * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
  * TIMEOUT_US has elapsed, which ever happens first.
  */
-int coresight_timeout(struct csdev_access *csa, u32 offset,
-		      int position, int value)
+int coresight_timeout_retval(struct csdev_access *csa, u32 offset,
+			     int position, int value, u32 *rval)
 {
-	int i;
-	u32 val;
+	int i, rc = -EAGAIN;
+	u32 val = 0;
 
 	for (i = TIMEOUT_US; i > 0; i--) {
 		val = csdev_access_read32(csa, offset);
 		/* waiting on the bit to go from 0 to 1 */
 		if (value) {
-			if (val & BIT(position))
-				return 0;
+			if (val & BIT(position)) {
+				rc = 0;
+				goto return_rval;
+			}
 		/* waiting on the bit to go from 1 to 0 */
 		} else {
-			if (!(val & BIT(position)))
-				return 0;
+			if (!(val & BIT(position))) {
+				rc = 0;
+				goto return_rval;
+			}
 		}
 
 		/*
@@ -1054,7 +1059,30 @@ int coresight_timeout(struct csdev_access *csa, u32 offset,
 			udelay(1);
 	}
 
-	return -EAGAIN;
+return_rval:
+	*rval = val;
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(coresight_timeout_retval);
+
+/**
+ * coresight_timeout - loop until a bit has changed to a specific register
+ *		       state
+ * @csa: coresight device access for the device
+ * @offset: Offset of the register from the base of the device.
+ * @position: the position of the bit of interest.
+ * @value: the value the bit should have.
+ *
+ * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
+ * TIMEOUT_US has elapsed, which ever happens first.
+ */
+int coresight_timeout(struct csdev_access *csa, u32 offset,
+		      int position, int value)
+{
+	u32 rval = 0;
+
+	return coresight_timeout_retval(csa, offset, position, value, &rval);
 }
 EXPORT_SYMBOL_GPL(coresight_timeout);
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 055ce5cd5c44..29cb71e82b0b 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -639,6 +639,8 @@ extern int coresight_enable_sysfs(struct coresight_device *csdev);
 extern void coresight_disable_sysfs(struct coresight_device *csdev);
 extern int coresight_timeout(struct csdev_access *csa, u32 offset,
 			     int position, int value);
+extern int coresight_timeout_retval(struct csdev_access *csa, u32 offset,
+				    int position, int value, u32 *rval);
 
 extern int coresight_claim_device(struct coresight_device *csdev);
 extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
-- 
2.25.1


