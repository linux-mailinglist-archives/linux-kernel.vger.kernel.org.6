Return-Path: <linux-kernel+bounces-428271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1969E0CC8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F51BB3C8E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846681DE8AE;
	Mon,  2 Dec 2024 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DuZ6F0XQ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B51DE3C1;
	Mon,  2 Dec 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168320; cv=none; b=r+yTAbWi1HMHSV+UbIDMcE0ePxr/Qy7iDg3P4FvHExMOIbMU/EXPci29WOue8I9R470bTDD2lU0I9l9zpOhMghUVSBonvkvdzgtLpuE8XvNhNzlrVGGRZLN1MLsU3s+5naBnfXYEzOGtsBpClQcD/dLoN/hHLYo9eL/65XOC7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168320; c=relaxed/simple;
	bh=9BROW2GIlm3pIefGAozPxLR1ebj2V3j4iYVTr6HjxPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4HGgYdIO41Pyuj0bhvCkPxTeiCNd3o80CxDxBP7SDg7JAdRVt9oM9AXx5JPf6ObSOGqSHj6+S+ZmMQSFkLf+k37av+z0WkN/PZoDmeC1hAooPyJOuZmPFTFZ2x7H4ssOyZcDyZuiyxiBnab6I82Kl+c2wi29AHVUvRfD/YBB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DuZ6F0XQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733168316;
	bh=9BROW2GIlm3pIefGAozPxLR1ebj2V3j4iYVTr6HjxPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DuZ6F0XQnTj4nCyp6QYk7tEm+WMEQVK1J4WxfEJAPwPk/ZDmZLaLqhgA+FLbit0nI
	 Ivr+wjrWnUeAfTHMXE3rQycgRhdso0g1CJNwyzXUKBgO0fITZFtkxCtGbEExWWh1fw
	 FlXdQfBzSCv43e+9CMpkm4+KWAztPrKizi1C4CG8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:38:34 +0100
Subject: [PATCH 3/5] platform/x86/intel/sdsi: Constify 'struct
 bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-pdx86-v1-3-9ab204c2a814@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-pdx86-v1-0-9ab204c2a814@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-pdx86-v1-0-9ab204c2a814@weissschuh.net>
To: Stuart Hayes <stuart.w.hayes@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>, 
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733168316; l=5102;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9BROW2GIlm3pIefGAozPxLR1ebj2V3j4iYVTr6HjxPg=;
 b=LR3P52TCXRc1e6dFbve1Qi3MwTQzBmJ1YS3VaXvsR6vIig1lGRDMaOwdhOyDVz2VJAj6Lm/oQ
 PHijPHrojXNAxuMSgp2lYaafaLdy9v/v6ZD46utdAJMlMqDGepzwBTS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/intel/sdsi.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 33f33b1070fdc949c1373251c3bca4234d9da119..30d1c2caf9842dbc355e7dea19f6446c56421228 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -398,8 +398,8 @@ static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 }
 
 static ssize_t provision_akc_write(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *attr, char *buf, loff_t off,
-				   size_t count)
+				   const struct bin_attribute *attr, char *buf,
+				   loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
@@ -409,11 +409,11 @@ static ssize_t provision_akc_write(struct file *filp, struct kobject *kobj,
 
 	return sdsi_provision(priv, buf, count, SDSI_CMD_PROVISION_AKC);
 }
-static BIN_ATTR_WO(provision_akc, SDSI_SIZE_WRITE_MSG);
+static const BIN_ATTR_WO(provision_akc, SDSI_SIZE_WRITE_MSG);
 
 static ssize_t provision_cap_write(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *attr, char *buf, loff_t off,
-				   size_t count)
+				   const struct bin_attribute *attr, char *buf,
+				   loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
@@ -423,7 +423,7 @@ static ssize_t provision_cap_write(struct file *filp, struct kobject *kobj,
 
 	return sdsi_provision(priv, buf, count, SDSI_CMD_PROVISION_CAP);
 }
-static BIN_ATTR_WO(provision_cap, SDSI_SIZE_WRITE_MSG);
+static const BIN_ATTR_WO(provision_cap, SDSI_SIZE_WRITE_MSG);
 
 static ssize_t
 certificate_read(u64 command, u64 control_flags, struct sdsi_priv *priv,
@@ -469,7 +469,7 @@ certificate_read(u64 command, u64 control_flags, struct sdsi_priv *priv,
 
 static ssize_t
 state_certificate_read(struct file *filp, struct kobject *kobj,
-		       struct bin_attribute *attr, char *buf, loff_t off,
+		       const struct bin_attribute *attr, char *buf, loff_t off,
 		       size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -477,11 +477,11 @@ state_certificate_read(struct file *filp, struct kobject *kobj,
 
 	return certificate_read(SDSI_CMD_READ_STATE, 0, priv, buf, off, count);
 }
-static BIN_ATTR_ADMIN_RO(state_certificate, SDSI_SIZE_READ_MSG);
+static const BIN_ATTR_ADMIN_RO(state_certificate, SDSI_SIZE_READ_MSG);
 
 static ssize_t
 meter_certificate_read(struct file *filp, struct kobject *kobj,
-		       struct bin_attribute *attr, char *buf, loff_t off,
+		       const struct bin_attribute *attr, char *buf, loff_t off,
 		       size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -489,11 +489,11 @@ meter_certificate_read(struct file *filp, struct kobject *kobj,
 
 	return certificate_read(SDSI_CMD_READ_METER, 0, priv, buf, off, count);
 }
-static BIN_ATTR_ADMIN_RO(meter_certificate, SDSI_SIZE_READ_MSG);
+static const BIN_ATTR_ADMIN_RO(meter_certificate, SDSI_SIZE_READ_MSG);
 
 static ssize_t
 meter_current_read(struct file *filp, struct kobject *kobj,
-		   struct bin_attribute *attr, char *buf, loff_t off,
+		   const struct bin_attribute *attr, char *buf, loff_t off,
 		   size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -502,11 +502,11 @@ meter_current_read(struct file *filp, struct kobject *kobj,
 	return certificate_read(SDSI_CMD_READ_METER, CTRL_METER_ENABLE_DRAM,
 				priv, buf, off, count);
 }
-static BIN_ATTR_ADMIN_RO(meter_current, SDSI_SIZE_READ_MSG);
+static const BIN_ATTR_ADMIN_RO(meter_current, SDSI_SIZE_READ_MSG);
 
 static ssize_t registers_read(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *attr, char *buf, loff_t off,
-			      size_t count)
+			      const struct bin_attribute *attr, char *buf,
+			      loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
@@ -528,9 +528,9 @@ static ssize_t registers_read(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-static BIN_ATTR_ADMIN_RO(registers, SDSI_SIZE_REGS);
+static const BIN_ATTR_ADMIN_RO(registers, SDSI_SIZE_REGS);
 
-static struct bin_attribute *sdsi_bin_attrs[] = {
+static const struct bin_attribute *const sdsi_bin_attrs[] = {
 	&bin_attr_registers,
 	&bin_attr_state_certificate,
 	&bin_attr_meter_certificate,
@@ -576,7 +576,7 @@ static struct attribute *sdsi_attrs[] = {
 
 static const struct attribute_group sdsi_group = {
 	.attrs = sdsi_attrs,
-	.bin_attrs = sdsi_bin_attrs,
+	.bin_attrs_new = sdsi_bin_attrs,
 	.is_bin_visible = sdsi_battr_is_visible,
 };
 __ATTRIBUTE_GROUPS(sdsi);

-- 
2.47.1


