Return-Path: <linux-kernel+bounces-428292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7209E0C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1DF286B0D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3B1DE8A5;
	Mon,  2 Dec 2024 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OPYr2Vd9"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3E1DE4FC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168610; cv=none; b=VOjjKrUf6UwA/TIgy5AwwPx1iy7N/8xR0x3T49tMKhI8gFdXsQRp1XKyKU/B3q29o0CELE38KGld7Bwlm+ioz9vPTS60GJhOgJaBafo7dsq8h1QWUU7zP1MOSaNq9HP6GA0k/VXnocz8abaNNcByZFJsZvOIYEcdviIe4VOwkIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168610; c=relaxed/simple;
	bh=n1+D0i8OXR5P0ydgsCj6+rtw09x6rt1HAh8gDChLLsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H2JdN52ZskLZDwsHrMhU3V4dqjiutJsaCcHp1Ss+tNSk6uNN8It7GvSiqKCCkWQ7d2GuG7nGON8zrUkPLsYfFfyQEalN9HmK5sSbWNym8iMjyWYcJIF62a6AkHO6kJg9IJtEYazsyfDmRY8K9EhFNDb34tJEHUxKB0vkrgn1U80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OPYr2Vd9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733168607;
	bh=n1+D0i8OXR5P0ydgsCj6+rtw09x6rt1HAh8gDChLLsU=;
	h=From:Date:Subject:To:Cc:From;
	b=OPYr2Vd9yjk1lS7rif5qQ+wqUHvlzWYZodHeE5abVLYY6W9BZxYShZE6yONeKH4tl
	 JZdSAQG0ITrmyggAIElzHT+OlMoxdepfmwM4XbBvk7yLOFZ6FkMGEkJ/+kU+f/romH
	 qaQcdQzD16dcMRrpc8XK2wozM9+qHfKIk5d9N0gg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:43:24 +0100
Subject: [PATCH] x86/sysfs: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-x86-v1-1-b767d5f0ac5c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANsNTmcC/x2MQQqAIBAAvxJ7biGtJPpKRJSttRcLV8KI/p50G
 ZjDzANCgUmgLx4IdLHw4bOosgC7z34j5DU76Eo3KgPlFidoDy8RF/bTHGPA1BlsVaeaWjtrjIO
 cn4Ecp389jO/7Ad8nmEdqAAAA
X-Change-ID: 20241202-sysfs-const-bin_attr-x86-5181432fc66f
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733168606; l=3110;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=n1+D0i8OXR5P0ydgsCj6+rtw09x6rt1HAh8gDChLLsU=;
 b=lVyHsqTz0gZAHaPIJmbBZkmCnDqrN2VKi8cJIoDwx04pUrp+d/mlHI8bezXtSozynZ0eZASxn
 bjU4jd6w9nDDArKwqRh+WAfBfS/1SWDmg0sRcEBDG+Xx7s5ROKgdFXr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/kernel/ksysfs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
index 257892fcefa794803d8eaf2d3d1810ebb278957b..b68d4be9464efab13b808fd69092003a89b5612b 100644
--- a/arch/x86/kernel/ksysfs.c
+++ b/arch/x86/kernel/ksysfs.c
@@ -28,19 +28,19 @@ static ssize_t version_show(struct kobject *kobj,
 static struct kobj_attribute boot_params_version_attr = __ATTR_RO(version);
 
 static ssize_t boot_params_data_read(struct file *fp, struct kobject *kobj,
-				     struct bin_attribute *bin_attr,
+				     const struct bin_attribute *bin_attr,
 				     char *buf, loff_t off, size_t count)
 {
 	memcpy(buf, (void *)&boot_params + off, count);
 	return count;
 }
 
-static struct bin_attribute boot_params_data_attr = {
+static const struct bin_attribute boot_params_data_attr = {
 	.attr = {
 		.name = "data",
 		.mode = S_IRUGO,
 	},
-	.read = boot_params_data_read,
+	.read_new = boot_params_data_read,
 	.size = sizeof(boot_params),
 };
 
@@ -49,14 +49,14 @@ static struct attribute *boot_params_version_attrs[] = {
 	NULL,
 };
 
-static struct bin_attribute *boot_params_data_attrs[] = {
+static const struct bin_attribute *const boot_params_data_attrs[] = {
 	&boot_params_data_attr,
 	NULL,
 };
 
 static const struct attribute_group boot_params_attr_group = {
 	.attrs = boot_params_version_attrs,
-	.bin_attrs = boot_params_data_attrs,
+	.bin_attrs_new = boot_params_data_attrs,
 };
 
 static int kobj_to_setup_data_nr(struct kobject *kobj, int *nr)
@@ -172,7 +172,7 @@ static ssize_t type_show(struct kobject *kobj,
 
 static ssize_t setup_data_data_read(struct file *fp,
 				    struct kobject *kobj,
-				    struct bin_attribute *bin_attr,
+				    const struct bin_attribute *bin_attr,
 				    char *buf,
 				    loff_t off, size_t count)
 {
@@ -250,7 +250,7 @@ static struct bin_attribute data_attr __ro_after_init = {
 		.name = "data",
 		.mode = S_IRUGO,
 	},
-	.read = setup_data_data_read,
+	.read_new = setup_data_data_read,
 };
 
 static struct attribute *setup_data_type_attrs[] = {
@@ -258,14 +258,14 @@ static struct attribute *setup_data_type_attrs[] = {
 	NULL,
 };
 
-static struct bin_attribute *setup_data_data_attrs[] = {
+static const struct bin_attribute *const setup_data_data_attrs[] = {
 	&data_attr,
 	NULL,
 };
 
 static const struct attribute_group setup_data_attr_group = {
 	.attrs = setup_data_type_attrs,
-	.bin_attrs = setup_data_data_attrs,
+	.bin_attrs_new = setup_data_data_attrs,
 };
 
 static int __init create_setup_data_node(struct kobject *parent,

---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241202-sysfs-const-bin_attr-x86-5181432fc66f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


