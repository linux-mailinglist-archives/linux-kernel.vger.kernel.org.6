Return-Path: <linux-kernel+bounces-447324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D8A9F3088
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708C61885021
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D420469D;
	Mon, 16 Dec 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OOVKp5zA"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C991FF7BE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352261; cv=none; b=BSmeMt36GgHqC4Q+MoxMJ0mTKvEXHTUhf5lzNUrEcpmMYCJNuJD0ec/kzhJbYcoKArSG1QQe9IP2tSWxYUTpth4L26fM4N3HaHHgwjIvhsjBr4JGejaHR75Wtn8BWEfbGaMlXrUz8a/3cyljQpCcvGMStPC2N3nnqtZ2UGeBcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352261; c=relaxed/simple;
	bh=0+9TMteYWG990gtbFDF8RxrBQySarAE5uXCGtqaHkxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nhz+On1WYXBHpUolq0Utrk4nRm9VFZROeUwVY5vpT8CzgddAPZk5dnS4eABbqoOV2Xgua8qhqfHOLJsG76S0+3a0Gp0xQmx55stBCT4bPeTeH6FcXHkwMC5PalNUb/qoo+n+sc+qEkfpzg5sKRMN3Tuxv71q0zHtG5eOSsWs4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OOVKp5zA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734352257;
	bh=0+9TMteYWG990gtbFDF8RxrBQySarAE5uXCGtqaHkxA=;
	h=From:Date:Subject:To:Cc:From;
	b=OOVKp5zABs5rt9WFE/ZiL0bslc9/F+UbyLdJlNkwEh7mfygSnCJYAlxrnGZou8nb4
	 o1CtyrU3cjEf7Y5nHb8ieqenupFbj6pvvVU2TvAEo3qIh+sDxdYrwX0AdYW1lIst7x
	 qY8TR1k9IRCUcP+f9VNBNZYfbngdQ7evAfyNorSU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 13:30:54 +0100
Subject: [PATCH] zorro: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-zorro-v1-1-220a38d49507@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAH0dYGcC/x3MwQqDMAwA0F+RnA3YrvbgrwyRaqPm0o6kyLbiv
 6/s+C6vgpIwKUxdBaGLlXNqMH0H2xnSQcixGexgnbHGo350V9xy0oIrpyWUIvjNIhnJOxeG8RH
 9StCCl9DO73/+nO/7BzXSGGpsAAAA
X-Change-ID: 20241216-sysfs-const-bin_attr-zorro-e644a053d6be
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734352256; l=1994;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0+9TMteYWG990gtbFDF8RxrBQySarAE5uXCGtqaHkxA=;
 b=6YpSGr/9+j9UEIJCZlc3sQHEcZ2QqF9LDrrDJ79mowiur2FapibX3H7AvDi3oA8/0IyNfRefk
 N7QNBVlaFiTB54/w6KMbtDrEEFL+8V28kSUOLg6qVWcPUWejb8NeOEo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/zorro/zorro-sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/zorro/zorro-sysfs.c b/drivers/zorro/zorro-sysfs.c
index 3d34dba9bb2dd488ffe509792940e51336c1852e..10aedcd21363442b2048ad4b0bebdbfd8c8ad30e 100644
--- a/drivers/zorro/zorro-sysfs.c
+++ b/drivers/zorro/zorro-sysfs.c
@@ -81,7 +81,7 @@ static struct attribute *zorro_device_attrs[] = {
 };
 
 static ssize_t zorro_read_config(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr,
+				 const struct bin_attribute *bin_attr,
 				 char *buf, loff_t off, size_t count)
 {
 	struct zorro_dev *z = to_zorro_dev(kobj_to_dev(kobj));
@@ -98,23 +98,23 @@ static ssize_t zorro_read_config(struct file *filp, struct kobject *kobj,
 	return memory_read_from_buffer(buf, count, &off, &cd, sizeof(cd));
 }
 
-static struct bin_attribute zorro_config_attr = {
+static const struct bin_attribute zorro_config_attr = {
 	.attr =	{
 		.name = "config",
 		.mode = S_IRUGO,
 	},
 	.size = sizeof(struct ConfigDev),
-	.read = zorro_read_config,
+	.read_new = zorro_read_config,
 };
 
-static struct bin_attribute *zorro_device_bin_attrs[] = {
+static const struct bin_attribute *const zorro_device_bin_attrs[] = {
 	&zorro_config_attr,
 	NULL
 };
 
 static const struct attribute_group zorro_device_attr_group = {
 	.attrs		= zorro_device_attrs,
-	.bin_attrs	= zorro_device_bin_attrs,
+	.bin_attrs_new	= zorro_device_bin_attrs,
 };
 
 const struct attribute_group *zorro_device_attribute_groups[] = {

---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241216-sysfs-const-bin_attr-zorro-e644a053d6be

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


