Return-Path: <linux-kernel+bounces-428276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D59E0C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752B528305D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E742E1DF273;
	Mon,  2 Dec 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZM0A6z8z"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7991DED73;
	Mon,  2 Dec 2024 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168324; cv=none; b=HuGqiIPUXRDBAMvUzMklCFWhdERPnRvRq/ygLp3GOCWf9t2dmfQrlfMl+bLiCYx5dFi4E63GKExlOz+7F2HhCMfZshJOoNrOaAwrBSeb8VrFu9MBX6fL8u7q/PS6Ed4XkGlvl89ORci1vnnNLzraQbHwbnJiLCmuVFLzv6DCU5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168324; c=relaxed/simple;
	bh=0vcuNhLRTgSihR2euTqOu3GUXYlgxvTzCrcLW+vJNFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xx3p+NlCa1aQM9E2YTU3ZtxY5+Wp6KCZ+ekLOilWs5jluq/Ozqpo/wNQ7fS2DZTtqEx9mG1b8Hw/SMb0uxRr8+N93f2SyZA5cDui9X3AS6QnEUG6nA+r2xfPTRwdw454ZR0lUPiRaiHY9FScR5fqAWUzRDNWBZfwJTFp7ShWw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZM0A6z8z; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733168317;
	bh=0vcuNhLRTgSihR2euTqOu3GUXYlgxvTzCrcLW+vJNFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZM0A6z8zO3RMN0gIzDol8W2IO1RkNu3+aniBFzSvsdlBUqP92/Ch1vEOY38IV5gXA
	 rkJvE8eJb/1dXWUMlWQofq+zd89+Z7I6VGHMV3qBQpEAsgUKLaKrKKziqPrid103Va
	 7ECLimINi+1cDFZLXqGn5xIkC3vPsHvdmdsWxFLA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:38:36 +0100
Subject: [PATCH 5/5] platform/x86/amd/hsmp: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-pdx86-v1-5-9ab204c2a814@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733168316; l=3637;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0vcuNhLRTgSihR2euTqOu3GUXYlgxvTzCrcLW+vJNFw=;
 b=aj5Sq7rt8w+1KN2yvaOHBP2H/fvqSILVCbbuG2+cF6IQtooZBHuxMIw3F4l0RXKZZNO1VP/kP
 pTR3002AdPCCkZjpUp4Lu4p3LVGS9u4FE8nA8s6EDErtPFd2FdQuo++
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/amd/hsmp/acpi.c | 12 ++++++------
 drivers/platform/x86/amd/hsmp/plat.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/amd/hsmp/acpi.c b/drivers/platform/x86/amd/hsmp/acpi.c
index dd5b5773328a9aff376a389cbd0109cb8cf0e385..7d802bfe206c73a4570dcd3752faee853bb81485 100644
--- a/drivers/platform/x86/amd/hsmp/acpi.c
+++ b/drivers/platform/x86/amd/hsmp/acpi.c
@@ -226,7 +226,7 @@ static int hsmp_parse_acpi_table(struct device *dev, u16 sock_ind)
 }
 
 static ssize_t hsmp_metric_tbl_acpi_read(struct file *filp, struct kobject *kobj,
-					 struct bin_attribute *bin_attr, char *buf,
+					 const struct bin_attribute *bin_attr, char *buf,
 					 loff_t off, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -285,19 +285,19 @@ static int init_acpi(struct device *dev)
 	return ret;
 }
 
-static struct bin_attribute  hsmp_metric_tbl_attr = {
+static const struct bin_attribute  hsmp_metric_tbl_attr = {
 	.attr = { .name = HSMP_METRICS_TABLE_NAME, .mode = 0444},
-	.read = hsmp_metric_tbl_acpi_read,
+	.read_new = hsmp_metric_tbl_acpi_read,
 	.size = sizeof(struct hsmp_metric_table),
 };
 
-static struct bin_attribute *hsmp_attr_list[] = {
+static const struct bin_attribute *hsmp_attr_list[] = {
 	&hsmp_metric_tbl_attr,
 	NULL
 };
 
-static struct attribute_group hsmp_attr_grp = {
-	.bin_attrs = hsmp_attr_list,
+static const struct attribute_group hsmp_attr_grp = {
+	.bin_attrs_new = hsmp_attr_list,
 	.is_bin_visible = hsmp_is_sock_attr_visible,
 };
 
diff --git a/drivers/platform/x86/amd/hsmp/plat.c b/drivers/platform/x86/amd/hsmp/plat.c
index 748bbc35648474370275a80daf2c26e5d732f6ad..1fdcd65d398e6ceca154b804074cbba083f4b7f1 100644
--- a/drivers/platform/x86/amd/hsmp/plat.c
+++ b/drivers/platform/x86/amd/hsmp/plat.c
@@ -59,7 +59,7 @@ static int amd_hsmp_pci_rdwr(struct hsmp_socket *sock, u32 offset,
 }
 
 static ssize_t hsmp_metric_tbl_plat_read(struct file *filp, struct kobject *kobj,
-					 struct bin_attribute *bin_attr, char *buf,
+					 const struct bin_attribute *bin_attr, char *buf,
 					 loff_t off, size_t count)
 {
 	struct hsmp_socket *sock;
@@ -97,13 +97,13 @@ static umode_t hsmp_is_sock_attr_visible(struct kobject *kobj,
  * is_bin_visible function is used to show / hide the necessary groups.
  */
 #define HSMP_BIN_ATTR(index, _list)					\
-static struct bin_attribute attr##index = {				\
+static const struct bin_attribute attr##index = {			\
 	.attr = { .name = HSMP_METRICS_TABLE_NAME, .mode = 0444},	\
 	.private = (void *)index,					\
-	.read = hsmp_metric_tbl_plat_read,					\
+	.read_new = hsmp_metric_tbl_plat_read,				\
 	.size = sizeof(struct hsmp_metric_table),			\
 };									\
-static struct bin_attribute _list[] = {					\
+static const struct bin_attribute _list[] = {				\
 	&attr##index,							\
 	NULL								\
 }
@@ -118,8 +118,8 @@ HSMP_BIN_ATTR(6, *sock6_attr_list);
 HSMP_BIN_ATTR(7, *sock7_attr_list);
 
 #define HSMP_BIN_ATTR_GRP(index, _list, _name)			\
-static struct attribute_group sock##index##_attr_grp = {	\
-	.bin_attrs = _list,					\
+static const struct attribute_group sock##index##_attr_grp = {	\
+	.bin_attrs_new = _list,					\
 	.is_bin_visible = hsmp_is_sock_attr_visible,		\
 	.name = #_name,						\
 }

-- 
2.47.1


