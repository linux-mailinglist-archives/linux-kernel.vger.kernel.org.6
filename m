Return-Path: <linux-kernel+bounces-168569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B68BBA45
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037DD282806
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835881CF8D;
	Sat,  4 May 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1e/seyg"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474918AEA;
	Sat,  4 May 2024 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714814739; cv=none; b=qMaIFijhUqKCMIgEIkxg5ml/hUD/nLrBcZOkxn5cApKbepPKc0wvT1uGw/pEelU7hs6YAH+NUD5d08FGaTnydWDeBfCft7OCCecfKfJbMrhNvYKgN7GSYz/jYc71EnhG/ZHCmAXIg2pQUi0Jt53EVcm0V5p7yKRyyPpUQ3tzGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714814739; c=relaxed/simple;
	bh=JmqBOUqv0pEp2j8Vl0tU2XN/+m58FcCDXRY3FwvbYYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkzV/HTOVMD/C5uS9VCskREn/wrCYWCcP9APavdtj6jnZrei+X4s78rk+xjM+sRM5IxoYcX6mmlIZVW5oOhIGfdvoao1Kqo72rjzJwPKphjJFosiTq+0Tt9b6yLtLXE7rvkSjHNwejygYqNBDyGw2G2PzEMNUk2yECQyhBn6JdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1e/seyg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a8f0d941so53456666b.2;
        Sat, 04 May 2024 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714814736; x=1715419536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dDi1shqlNMKuzQzzByJJzGXL/6g55t36MtT1y0ff/Q=;
        b=m1e/seygBoq8fNiO1lFwMG+yFvnr1fRl4UkCeIKMy+xjediPc10BRWI+I8BAEuDrFW
         IiqWdvPpIQwJN6j89fNNpB447rVZyjseZRXzKg/I83vyw7cppAAh0HssFm9uXoPVY+uy
         hMGCrCP+BPkVQXrlqdydtsZclDiWZXjKb1nBTUo1q9ZsrR/4HxK9BCoavDB9ivQp0Evi
         ZhBjpHiNEcd6sLpdLDt9SVzBIFsldH5Nh5V3Vfv4mqrO2Os6GEmw4C+77cOTQn8OdUzj
         a0j6F4pWBcNOsNicd4CdVm6erAQA6OGEACf8c4mXI4wg0qA829K/M51HzEilXCTUktnL
         U4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714814736; x=1715419536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dDi1shqlNMKuzQzzByJJzGXL/6g55t36MtT1y0ff/Q=;
        b=ZuI+YR+WcwUIvSmlQ2dGOo8mvdPE2PcVP/+8rY4M534G4wvjozEyoOT72RGmticdtF
         4N6JSCtVgaY8gqipw5uHvAWnXLGhhH5DiEi8I671DACucXcYCQwp81pL6iRUPQp1JCho
         qREhHEb/eihsIMqaPlxtaebZz9M1dfSqRzjXwG8wTF0OsJ00qYm66W1txzmqXg/vMqW2
         mvT1T8QdM290xnR8wW2xxVBqFyTVImQSwV6J7aeelRKdQAoA1KNHsHLPKaXOxpbLcC0r
         6mla4zENXLLLUeDRs6PAbRoneiSyKIVQ4aw234jUNsJnqOFKi/tK1s1P85RvmZnG6ib5
         B3eA==
X-Forwarded-Encrypted: i=1; AJvYcCUjW/8346pPy+KxUTRN5uZc4o94GDiLPaGIiIBt3eNCH/K7F23uvOII+zVHQuaBC5fjiXzm//kL8tmWBeNYQoyt3v/pyYjaHBPuz4+l
X-Gm-Message-State: AOJu0YwE+sGTsVVx7S7Z7dRFxXanxjSf9GYoO05b9f0fklaZ73tGWkUF
	3RlqXVbn7DZqFw7pgnGFDCHqUOQ74l1kUBoHX15JClGD+NjufxhJMBCOsALEkNI=
X-Google-Smtp-Source: AGHT+IG0BCogiF1vRODFuxzzsfNseP/BLm5xLWn0pQKsI+b7CSjIr6iRoEOewsOZdZ5i9WslsfI+PA==
X-Received: by 2002:a17:906:2c07:b0:a58:e86d:40e6 with SMTP id e7-20020a1709062c0700b00a58e86d40e6mr3023516ejh.26.1714814735853;
        Sat, 04 May 2024 02:25:35 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id ce3-20020a170906b24300b00a587831c09fsm2740231ejb.186.2024.05.04.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 02:25:34 -0700 (PDT)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Jonas Malaco <jonas@protocubo.io>,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Marius Zachmann <mail@mariuszachmann.de>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock
Date: Sat,  4 May 2024 11:25:03 +0200
Message-ID: <20240504092504.24158-4-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504092504.24158-1-savicaleksa83@gmail.com>
References: <20240504092504.24158-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through hidraw, userspace can cause a status report to be sent
from the device. The parsing in ccp_raw_event() may happen in
parallel to a send_usb_cmd() call (which resets the completion
for tracking the report) if it's running on a different CPU where
bottom half interrupts are not disabled.

Add a spinlock around the complete_all() in ccp_raw_event() and
reinit_completion() in send_usb_cmd() to prevent race issues.

Fixes: 40c3a4454225 ("hwmon: add Corsair Commander Pro driver")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/corsair-cpro.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index 6ab4d2478b1f..3e63666a61bd 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #define USB_VENDOR_ID_CORSAIR			0x1b1c
@@ -77,6 +78,8 @@
 struct ccp_device {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
+	/* For reinitializing the completion below */
+	spinlock_t wait_input_report_lock;
 	struct completion wait_input_report;
 	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
 	u8 *cmd_buffer;
@@ -118,7 +121,15 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
 	ccp->cmd_buffer[2] = byte2;
 	ccp->cmd_buffer[3] = byte3;
 
+	/*
+	 * Disable raw event parsing for a moment to safely reinitialize the
+	 * completion. Reinit is done because hidraw could have triggered
+	 * the raw event parsing and marked the ccp->wait_input_report
+	 * completion as done.
+	 */
+	spin_lock_bh(&ccp->wait_input_report_lock);
 	reinit_completion(&ccp->wait_input_report);
+	spin_unlock_bh(&ccp->wait_input_report_lock);
 
 	ret = hid_hw_output_report(ccp->hdev, ccp->cmd_buffer, OUT_BUFFER_SIZE);
 	if (ret < 0)
@@ -136,11 +147,12 @@ static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	struct ccp_device *ccp = hid_get_drvdata(hdev);
 
 	/* only copy buffer when requested */
-	if (completion_done(&ccp->wait_input_report))
-		return 0;
-
-	memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
-	complete_all(&ccp->wait_input_report);
+	spin_lock(&ccp->wait_input_report_lock);
+	if (!completion_done(&ccp->wait_input_report)) {
+		memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
+		complete_all(&ccp->wait_input_report);
+	}
+	spin_unlock(&ccp->wait_input_report_lock);
 
 	return 0;
 }
@@ -515,7 +527,9 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ccp->hdev = hdev;
 	hid_set_drvdata(hdev, ccp);
+
 	mutex_init(&ccp->mutex);
+	spin_lock_init(&ccp->wait_input_report_lock);
 	init_completion(&ccp->wait_input_report);
 
 	hid_device_io_start(hdev);
-- 
2.44.0


