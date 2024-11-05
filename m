Return-Path: <linux-kernel+bounces-397286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E069BD9FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D9228377A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F258A216A32;
	Tue,  5 Nov 2024 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZfgzGqL"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF121620A;
	Tue,  5 Nov 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730850979; cv=none; b=Y0WMDCtrcXslx7jpuG1gEYDrSxS0dUPAUZiESMHFxXv3Vs/OZzvxpmWj0zVmbNw+BOb1fPNKzVwB4me0W40c/zqL1Pn7lA2a1dRQjr7dj2z0JALOqdCP7xKCP2Qhy26FBYpv2qpHq94j4Cop/WE1cE2G+8ww0q+KqZShQc/ID3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730850979; c=relaxed/simple;
	bh=rVYY7hUS0/8px9P9VMyTF6luP4EveFr+K2h7mJPt0zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDrUDGmScACvp9QLAOj09ezj0SkZ65/GxBZYvk92t+RpVdakYZqZfFzIS1Hqo9BMwrBRDFYKpW3DOijurks6eKAyMnrR0ov4Y6SM+/v+0hzCysUpN3baT/fzJ0aj6umcjmeHD6LVIP9Uqh8xXOClvyQ4fNEHDsDNGNvBNlue+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZfgzGqL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca388d242so61343585ad.2;
        Tue, 05 Nov 2024 15:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730850977; x=1731455777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppYLRGxLF+7dK9BYL9ECT/GDpoTltO8iXIjQIhx/+g4=;
        b=dZfgzGqLS7YPmIf6wkkCQfXC3IMtv2k21u4Ctkyf0ViIxB5hHurebOiykAKxTGS0gp
         hPYvWX8rImW/wsJhO41TmTY7r2Jqrn4Xmf9HqjRy5o13px6iYoaWpefqECWTf/PW375k
         HWEK3nghWCa940raBS/wZrQ3qiPjqzZaUaE+HUmi+fnWIkEvmls2cP6eW0hSgb8XPc3w
         /I/NH2+0ToLOuojdPsN7kMDAMHQiq7fME2evXDsVorJ+TX9CxzqfS5fF2i1NVY/p1CKq
         3NrwwHTxW2EOcVrj0z0aSyq/c9mHKYIyxZB+Rx0KnUA/qmhaikv3Soj3gD7BtJAKTtMT
         jwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730850977; x=1731455777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppYLRGxLF+7dK9BYL9ECT/GDpoTltO8iXIjQIhx/+g4=;
        b=veBL7el5U7BFeoYn47kG5b5wJVD6YfFroB/CDNdVQfXKqspgYpFfPCSq21rI+QHI/F
         2kAR8HlDw1vNOu1XBdq+zRjk7+ezdvrHhBxyRgIzeyMeqEPCLFlJ5ahXloMU5JcZZO1y
         WmDwscx2Mn+Zd7ub1KJc+gh+Wt0CrZuklTMVZ9gi9jMNOyF0g9/jwfMhXO9/RkRlV9JP
         9WxCXQki+3uWbduXHY7EFa/UMwyeTOLDTc+pjsjQJkul5LUoWQrdp9s/Sp7X3cwJYvTO
         u21sEhcajq0ZWw8q/5lK1XwQthXSSZNxf19W7w7oXhbNFS6IeEvLLq5UJPw3S9XF69nP
         8s5w==
X-Forwarded-Encrypted: i=1; AJvYcCUBJBreWnN0qqxeuikDeRHpMbmROd/GPcRgv/fhLM4naXDxmpcU3JHx7azlbFc8D3R5hPUbZk41wKI4Myw=@vger.kernel.org, AJvYcCWN5IapIJnROPPZcCTzHn7Zbzvvsu2VQICGc7mIfcuXGWt2hmvXX/Y6MAjIjwYnnq4RK7GX/GI5HZCvGSLrh7R0l9kgpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUW4l5N62XyhuhCw5Tbp3B2RwkWnZ8ux0OA2V+BmVpwAh0ti6
	fzyDHZnCCnvYQKI7t0n0h4Zwh4ZHGr+A6DIwfIGwIG2Nl+qr/vILZkzLQG8yNxM=
X-Google-Smtp-Source: AGHT+IHJ1qg3Kz8hDFI5CbCYN8LAEKa52h1TO5mfYWSg2JRUQOuScn+FGukQF04qzxKxU8OIBZCLZA==
X-Received: by 2002:a17:902:ccc9:b0:20b:8642:9863 with SMTP id d9443c01a7336-2111af3fbf0mr239959115ad.18.1730850977030;
        Tue, 05 Nov 2024 15:56:17 -0800 (PST)
Received: from test-linux-ThinkPad-L480.. ([2404:7a80:b9a1:7100:c22a:afd1:3ca1:23bb])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21105729894sm83954785ad.119.2024.11.05.15.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 15:56:16 -0800 (PST)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vishnu Sankar <vishnuocv@gmail.com>,
	Vishnu Sankar <vsankar@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [PATCH] Thinkpad_acpi: Fix for ThinkPad's with ECFW showing incorrect fan speed
Date: Wed,  6 Nov 2024 08:55:05 +0900
Message-ID: <20241105235505.8493-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix for Thinkpad's with ECFW showing incorrect fan speed.
Some models use decimal instead of hexadecimal for the fan speed stored
in the EC registers.
for eg: the rpm register will have 0x4200 instead of 0x1068.
Here the actual RPM is "4200" in decimal.

A quirk added to handle this.

Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
Signed-off-by: Vishnu Sankar <vsankar@lenovo.com>
Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/thinkpad_acpi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 4c1b0553f872..6371a9f765c1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7936,6 +7936,7 @@ static u8 fan_control_resume_level;
 static int fan_watchdog_maxinterval;
 
 static bool fan_with_ns_addr;
+static bool ecfw_with_fan_dec_rpm;
 
 static struct mutex fan_mutex;
 
@@ -8682,7 +8683,11 @@ static ssize_t fan_fan1_input_show(struct device *dev,
 	if (res < 0)
 		return res;
 
-	return sysfs_emit(buf, "%u\n", speed);
+	/* Check for fan speeds displayed in hexadecimal */
+	if (!ecfw_with_fan_dec_rpm)
+		return sysfs_emit(buf, "%u\n", speed);
+	else
+		return sysfs_emit(buf, "%x\n", speed);
 }
 
 static DEVICE_ATTR(fan1_input, S_IRUGO, fan_fan1_input_show, NULL);
@@ -8699,7 +8704,11 @@ static ssize_t fan_fan2_input_show(struct device *dev,
 	if (res < 0)
 		return res;
 
-	return sysfs_emit(buf, "%u\n", speed);
+	/* Check for fan speeds displayed in hexadecimal */
+	if (!ecfw_with_fan_dec_rpm)
+		return sysfs_emit(buf, "%u\n", speed);
+	else
+		return sysfs_emit(buf, "%x\n", speed);
 }
 
 static DEVICE_ATTR(fan2_input, S_IRUGO, fan_fan2_input_show, NULL);
@@ -8775,6 +8784,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_2CTL		0x0004		/* selects fan2 control */
 #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
 #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
+#define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8803,6 +8813,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('R', '1', 'D', TPACPI_FAN_NS),	/* 11e Gen5 GL-R */
 	TPACPI_Q_LNV3('R', '0', 'V', TPACPI_FAN_NS),	/* 11e Gen5 KL-Y */
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
+	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -8847,6 +8858,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		tp_features.fan_ctrl_status_undef = 1;
 	}
 
+	/* Check for the EC/BIOS with RPM reported in decimal*/
+	if (quirks & TPACPI_FAN_DECRPM) {
+		pr_info("ECFW with fan RPM as decimal in EC register\n");
+		ecfw_with_fan_dec_rpm = 1;
+		tp_features.fan_ctrl_status_undef = 1;
+	}
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
@@ -9067,7 +9085,11 @@ static int fan_read(struct seq_file *m)
 		if (rc < 0)
 			return rc;
 
-		seq_printf(m, "speed:\t\t%d\n", speed);
+		/* Check for fan speeds displayed in hexadecimal */
+		if (!ecfw_with_fan_dec_rpm)
+			seq_printf(m, "speed:\t\t%d\n", speed);
+		else
+			seq_printf(m, "speed:\t\t%x\n", speed);
 
 		if (fan_status_access_mode == TPACPI_FAN_RD_TPEC_NS) {
 			/*
-- 
2.43.0


