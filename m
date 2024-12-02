Return-Path: <linux-kernel+bounces-428272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2D9E0C45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642EA163FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE41DE8A8;
	Mon,  2 Dec 2024 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="G/r5c3PZ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C81DE3C0;
	Mon,  2 Dec 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168320; cv=none; b=uBmKpDAUEqtzWxTVFe7t0dzXiHM5sFclXWEYcY78/ytg+MWJrOtwoe0s+WcYMc67mWBSDmkVv3oYcUBEm8EPuNbBydg2+RazZfFx/DEa3kYIBj55IJr80H0vaU3D3gunHr0SWEE5AMROy3fbhqDuVnikxxM8eBXPQrNMA0svIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168320; c=relaxed/simple;
	bh=bXwjaMZPKYJqfzSnqgQCkzKi6u0bdbqGe9sH10KIhs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWx7IQOjc10Q6MT1OSIctgSpkPAZYCNbvMUc0ZuSjlNdaMpQNC1C8bp8+dlyGHwXRO9u0Dqv92xj2980QZ8FhpOjiUqwMvoqMASLSptn/EvdWihO2iBipu1nmCNIGFoPZ2NT74ddGLTbUK60Yr84q/FoPmXMi1wJ291tgpIfjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=G/r5c3PZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733168316;
	bh=bXwjaMZPKYJqfzSnqgQCkzKi6u0bdbqGe9sH10KIhs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G/r5c3PZzuWfqzRo/c4UjVPrCv2Hc6wx/90Vf14fIwdZi1mnAVo+znnXrOMyEkmPu
	 LVYLqXjVKlg/LwK9IPwQ82u4AVpwKxa61AHceic6iFHI8jS38yrxPYDpNjxqyWtluW
	 13LmY3bKxLxct7MeeosLShQTiri85+iwSwZu9hjs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:38:32 +0100
Subject: [PATCH 1/5] platform/x86: dell: dcdbas: Constify 'struct
 bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-sysfs-const-bin_attr-pdx86-v1-1-9ab204c2a814@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733168316; l=2655;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bXwjaMZPKYJqfzSnqgQCkzKi6u0bdbqGe9sH10KIhs4=;
 b=qlK8gtGb9pNa8t3MtuntUov7EtP4pBk8jm4vpiVItgItUx2t+rUIlBuPse0+uSH+r4aLhON5n
 HLV3OxZHlGcBWC6ZLnz9xGyxMuWwtl16/VfQiz5EP06mNibuRFiCeIE
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

While at it switch from the custom DCDBAS_BIN_ATTR_RW() to the identical
BIN_ATTR_RW() macro.
---
 drivers/platform/x86/dell/dcdbas.c | 10 +++++-----
 drivers/platform/x86/dell/dcdbas.h |  8 --------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/dell/dcdbas.c
index 0aeb8149c16bfcb5df3cad77b69d7e5978ce6536..8149be25fa267ca027d809c45fe1c3f47fcfd453 100644
--- a/drivers/platform/x86/dell/dcdbas.c
+++ b/drivers/platform/x86/dell/dcdbas.c
@@ -163,7 +163,7 @@ static ssize_t smi_data_buf_size_store(struct device *dev,
 }
 
 static ssize_t smi_data_read(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr,
+			     const struct bin_attribute *bin_attr,
 			     char *buf, loff_t pos, size_t count)
 {
 	ssize_t ret;
@@ -176,7 +176,7 @@ static ssize_t smi_data_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t smi_data_write(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *bin_attr,
+			      const struct bin_attribute *bin_attr,
 			      char *buf, loff_t pos, size_t count)
 {
 	ssize_t ret;
@@ -636,9 +636,9 @@ static struct notifier_block dcdbas_reboot_nb = {
 	.priority = INT_MIN
 };
 
-static DCDBAS_BIN_ATTR_RW(smi_data);
+static const BIN_ATTR_ADMIN_RW(smi_data, 0);
 
-static struct bin_attribute *dcdbas_bin_attrs[] = {
+static const struct bin_attribute *const dcdbas_bin_attrs[] = {
 	&bin_attr_smi_data,
 	NULL
 };
@@ -662,7 +662,7 @@ static struct attribute *dcdbas_dev_attrs[] = {
 
 static const struct attribute_group dcdbas_attr_group = {
 	.attrs = dcdbas_dev_attrs,
-	.bin_attrs = dcdbas_bin_attrs,
+	.bin_attrs_new = dcdbas_bin_attrs,
 };
 
 static int dcdbas_probe(struct platform_device *dev)
diff --git a/drivers/platform/x86/dell/dcdbas.h b/drivers/platform/x86/dell/dcdbas.h
index 942a23ddded0592d2279da2dfee05113e8f4dbff..a05d7f667586310e379e38601309acdfad25645a 100644
--- a/drivers/platform/x86/dell/dcdbas.h
+++ b/drivers/platform/x86/dell/dcdbas.h
@@ -56,14 +56,6 @@
 #define DCDBAS_DEV_ATTR_WO(_name) \
 	DEVICE_ATTR(_name,0200,NULL,_name##_store);
 
-#define DCDBAS_BIN_ATTR_RW(_name) \
-struct bin_attribute bin_attr_##_name = { \
-	.attr =  { .name = __stringify(_name), \
-		   .mode = 0600 }, \
-	.read =  _name##_read, \
-	.write = _name##_write, \
-}
-
 struct smi_cmd {
 	__u32 magic;
 	__u32 ebx;

-- 
2.47.1


