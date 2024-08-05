Return-Path: <linux-kernel+bounces-274318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C798B94767A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD511F216B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23F14B965;
	Mon,  5 Aug 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OxiFoluR"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44114B943
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844788; cv=none; b=a/e04DtdPHpZb9gp5aXSK3SbYuWJAlLzYlHUQ735BzySqtUzGn+LlvtGeY7FG6yDOSNTNSL1Nhlz4tOUZdh1wEWP8q0xEL4Az6yDCTWk5RfWnXJ6vsowMfsuVG9EJzRyCL4eZfSg1DA5s3dGPLbvAWaZ6NEn0HXvqEnPAQlHmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844788; c=relaxed/simple;
	bh=qyiV1GhC3m5TLdS5WwV8t8H3dtagEn1cvm+78buBvbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=od9KPlGjLtEZphDRRsWe5ot6RiRlElEZxUjfG5qlgvfzq6yLBaE1Egiip0d4O1I+InvA2etg8zuTTRgpfdUCC6IRebcYPV7mAGHLoSOJIohFwE15P5f8fmm2OSSo/Dan87nSNToZkRrD3FohT2ez2Uq35m6x87RYLCy9fZcQbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OxiFoluR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d7bc07b7so601843985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722844785; x=1723449585; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oM88vPFk4kzqi6cbaKo2eNFku1B95XjFdsasoS9AADs=;
        b=OxiFoluRmaL/XefevXE6t9bmXrQjwiUAMFRiwIOiHlA0kgjkFA5ybTk2o9K4d7cH7f
         se8AquqM5KGxf8Lt/qYVq+bGLVx6Xy9FcvawaXGoTzBSnqBTHKS8CvfyMiYUpfzdHqh7
         IgL9K9dmmCGuX64KyElBFH4/PV1BWXxopauqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844785; x=1723449585;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oM88vPFk4kzqi6cbaKo2eNFku1B95XjFdsasoS9AADs=;
        b=SrPggSq5+Owsao8TT/bag5QbG1fvr2ONwivnNRiH1m37fQmOnhfcW5Mi2n+HCcGudB
         e3mHkoZBxTspDI7DQAJHi/8MJILkR8ZX0V2QThzfb0a4uqz+mHmjte7ShEXX+ZFUsU8A
         zzutuPeglOuLumTqfQ9SU46oP+hQI4rmZfS/zVyJVTvfTYytJWMTRY8Ourz1NMhNRFK1
         8dT2Tpqn50kIA/U2OzmOStQ8EZNwfYxnGvzQnS3yyUg+ENLk2O7UWO9Qu1eQMUYka/h/
         YAPI65rQIomSQVzDs8VSgjHy6za2F5Kh8xVv5lWn+1UMVCCwF4MTlsBVV9Mfj5uahbMz
         n2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtT4HaK2oomt/yHdUpKIjhPOb/2XmiThbOsvfaAyjbqG576WKZbBpXMCP31dOiUJZluxBpjWFPeSJ7pmLOAnGve2zW+htTEMx5LACT
X-Gm-Message-State: AOJu0YwF4NFuO77NshwRC+qkQYmAEcfqB2pjoMjmLTCshSjmh4WHRWoC
	PhItsSHShmMuMNRPBw8EBfj2KfJ/+XxO7auSUmq5yp851WF2V4LwiGaq7nVxUw==
X-Google-Smtp-Source: AGHT+IHZKkjweL5Il9i8jMiTcEltDSXYA/goiQSYRqeNIyTtO6mrfpXmB90Pmm7AHwzA/I9EoO3gzQ==
X-Received: by 2002:a05:620a:4001:b0:7a1:d341:b35f with SMTP id af79cd13be357-7a34ef45810mr1376855085a.28.1722844785563;
        Mon, 05 Aug 2024 00:59:45 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f796911sm321806885a.131.2024.08.05.00.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:59:45 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 05 Aug 2024 07:59:43 +0000
Subject: [PATCH] media: siano: Simplify smscore_load_firmware_from_file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-siano-v1-1-6da2bc740267@chromium.org>
X-B4-Tracking: v=1; b=H4sIAG6GsGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNT3eLMxLx83WSTZLNEQ0MDs0RjSyWg2oKi1LTMCrA50bG1tQDAqBm
 LVwAAAA==
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The function is never called with a loadfirmware_handler, so we can
remove some dead code.

We can also use this as a excuse to remove some unused type definitions.

This fixes the following smatch warning:
drivers/media/common/siano/smscoreapi.c:1172 smscore_load_firmware_from_file() error: we previously assumed 'loadfirmware_handler' could be null (see line 1150)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Originally reported by Hans.
---
 drivers/media/common/siano/smscoreapi.c | 15 +++++----------
 drivers/media/common/siano/smscoreapi.h |  4 ----
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/media/common/siano/smscoreapi.c b/drivers/media/common/siano/smscoreapi.c
index b6f1eb5dbbdf..3732367e0c62 100644
--- a/drivers/media/common/siano/smscoreapi.c
+++ b/drivers/media/common/siano/smscoreapi.c
@@ -1132,8 +1132,7 @@ static char *smscore_get_fw_filename(struct smscore_device_t *coredev,
  * return: 0 on success, <0 on error.
  */
 static int smscore_load_firmware_from_file(struct smscore_device_t *coredev,
-					   int mode,
-					   loadfirmware_t loadfirmware_handler)
+					   int mode)
 {
 	int rc = -ENOENT;
 	u8 *fw_buf;
@@ -1147,8 +1146,7 @@ static int smscore_load_firmware_from_file(struct smscore_device_t *coredev,
 	}
 	pr_debug("Firmware name: %s\n", fw_filename);
 
-	if (!loadfirmware_handler &&
-	    !(coredev->device_flags & SMS_DEVICE_FAMILY2))
+	if (!(coredev->device_flags & SMS_DEVICE_FAMILY2))
 		return -EINVAL;
 
 	rc = request_firmware(&fw, fw_filename, coredev->device);
@@ -1166,10 +1164,8 @@ static int smscore_load_firmware_from_file(struct smscore_device_t *coredev,
 		memcpy(fw_buf, fw->data, fw->size);
 		fw_buf_size = fw->size;
 
-		rc = (coredev->device_flags & SMS_DEVICE_FAMILY2) ?
-			smscore_load_firmware_family2(coredev, fw_buf, fw_buf_size)
-			: loadfirmware_handler(coredev->context, fw_buf,
-			fw_buf_size);
+		rc = smscore_load_firmware_family2(coredev, fw_buf,
+						   fw_buf_size);
 	}
 
 	kfree(fw_buf);
@@ -1353,8 +1349,7 @@ int smscore_set_device_mode(struct smscore_device_t *coredev, int mode)
 		}
 
 		if (!(coredev->modes_supported & (1 << mode))) {
-			rc = smscore_load_firmware_from_file(coredev,
-							     mode, NULL);
+			rc = smscore_load_firmware_from_file(coredev, mode);
 			if (rc >= 0)
 				pr_debug("firmware download success\n");
 		} else {
diff --git a/drivers/media/common/siano/smscoreapi.h b/drivers/media/common/siano/smscoreapi.h
index 82d9f8a64d99..3c15082ce0e3 100644
--- a/drivers/media/common/siano/smscoreapi.h
+++ b/drivers/media/common/siano/smscoreapi.h
@@ -97,7 +97,6 @@ typedef int (*hotplug_t)(struct smscore_device_t *coredev,
 typedef int (*setmode_t)(void *context, int mode);
 typedef void (*detectmode_t)(void *context, int *mode);
 typedef int (*sendrequest_t)(void *context, void *buffer, size_t size);
-typedef int (*loadfirmware_t)(void *context, void *buffer, size_t size);
 typedef int (*preload_t)(void *context);
 typedef int (*postload_t)(void *context);
 
@@ -1102,9 +1101,6 @@ extern int smscore_register_device(struct smsdevice_params_t *params,
 extern void smscore_unregister_device(struct smscore_device_t *coredev);
 
 extern int smscore_start_device(struct smscore_device_t *coredev);
-extern int smscore_load_firmware(struct smscore_device_t *coredev,
-				 char *filename,
-				 loadfirmware_t loadfirmware_handler);
 
 extern int smscore_set_device_mode(struct smscore_device_t *coredev, int mode);
 extern int smscore_get_device_mode(struct smscore_device_t *coredev);

---
base-commit: 2c25dcc2361949bc7da730d22de36c019c6bf1e3
change-id: 20240805-siano-c4c6a1106a39

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


