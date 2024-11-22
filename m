Return-Path: <linux-kernel+bounces-418206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86E9D5EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9403D282EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A5A1DE3CF;
	Fri, 22 Nov 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gJCvKGXb"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550C1B0F0C;
	Fri, 22 Nov 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277646; cv=none; b=ETxPPdWYpAJ9XSDgfUQ0yVjLYYINopHne+1ygLTiEhV/VgnFH+kcs2cJnjS1AYoApNjyJhATjxu/BLmZVBvjgDDUeVDJY0dPtkIBpTCgGmZa3+aOQVUD6PjNKjE/CWflic+wjXhGc8IOJsH/wsC40DCDqvFL7LIOnKb12qFgkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277646; c=relaxed/simple;
	bh=mjxMKKRR+F1h24q7KEzQjUrXuJGe7CQC+v/QTRlQe8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sCQQ+0wD60OnMY+rkYGTF8Mac22bljk4lsHgfYlUApqI9DlSrSUwUhZAwnlYYzoSzpk050MMVbwy3llJadpWHtcSQXwv0DpX7NAGG4onSQycbQiGeLdpZTIbWvEzylRqD7Yy/sAZaER+3Wgg3XYOIkbuv62M9jS01ztSSjgJq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gJCvKGXb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732277641;
	bh=mjxMKKRR+F1h24q7KEzQjUrXuJGe7CQC+v/QTRlQe8g=;
	h=From:Date:Subject:To:Cc:From;
	b=gJCvKGXbdFh7tPTpXtDtsTfnr1HTCCgOmCWkYV4bmWcvmHlS5gqKptvU+1sAfmQgd
	 2z/BExWw9Csk0AfUERl1VXp+4s3aWNCZKHWltPq/gUwrroE68rCsbd3rWxi02BjONp
	 hTFFLkilPg62LYlboU0Dst6LyDEhqrC45v0aaH78=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 22 Nov 2024 13:14:00 +0100
Subject: [PATCH] of/fdt: Implement use BIN_ATTR_SIMPLE macro for fdt sysfs
 attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241122-sysfs-const-bin_attr-of-v1-1-7052f9dcd4be@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAId1QGcC/x3MTQqEMAxA4atI1hOw8Q/nKoNI1VSzaYemiCLe3
 eLyW7x3gXIUVvgWF0TeRSX4DPMpYN6sXxllyQYqqTaGCPVUpzgHrwkn8aNNKWJw2HVt01dk+7p
 dINf/yE6O9/wb7vsB/dgy4mkAAAA=
X-Change-ID: 20241122-sysfs-const-bin_attr-of-7765932a946d
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732277640; l=1879;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mjxMKKRR+F1h24q7KEzQjUrXuJGe7CQC+v/QTRlQe8g=;
 b=Dp96osO/8v+LmjTy0GZ/VPon8qwOn+5MrcHwRw6ng0nN7roQ0Q0gojDE+ntC3CJFgv4vtRwqF
 MZa3ulO+rRwBh1jowfik1cqG4Fy1xLNd25uJhyQBkWoWUyhycTTUSBf
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The usage of the macro allows to remove the custom handler function,
saving some memory. Additionally the code is easier to read.

While at it also mark the attribute as __ro_after_init, as the only
modification happens in the __init phase.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/of/fdt.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0121100372b41d44d841784b863af5492f19c31e..4b1e9f101ce34d7212cc8de99c7e7761a2636866 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1264,18 +1264,9 @@ void __init unflatten_and_copy_device_tree(void)
 }
 
 #ifdef CONFIG_SYSFS
-static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
-			       char *buf, loff_t off, size_t count)
-{
-	memcpy(buf, initial_boot_params + off, count);
-	return count;
-}
-
 static int __init of_fdt_raw_init(void)
 {
-	static struct bin_attribute of_fdt_raw_attr =
-		__BIN_ATTR(fdt, S_IRUSR, of_fdt_raw_read, NULL, 0);
+	static __ro_after_init BIN_ATTR_SIMPLE_ADMIN_RO(fdt);
 
 	if (!initial_boot_params)
 		return 0;
@@ -1285,8 +1276,9 @@ static int __init of_fdt_raw_init(void)
 		pr_warn("not creating '/sys/firmware/fdt': CRC check failed\n");
 		return 0;
 	}
-	of_fdt_raw_attr.size = fdt_totalsize(initial_boot_params);
-	return sysfs_create_bin_file(firmware_kobj, &of_fdt_raw_attr);
+	bin_attr_fdt.private = initial_boot_params;
+	bin_attr_fdt.size = fdt_totalsize(initial_boot_params);
+	return sysfs_create_bin_file(firmware_kobj, &bin_attr_fdt);
 }
 late_initcall(of_fdt_raw_init);
 #endif

---
base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
change-id: 20241122-sysfs-const-bin_attr-of-7765932a946d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


