Return-Path: <linux-kernel+bounces-447246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A429F2F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BC21882606
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA7204C09;
	Mon, 16 Dec 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="biRaF6i9"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D42040BF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348786; cv=none; b=SuuXKm7+oUNJmFswGFnbe1+ioa6JdNnSI/Ski8kf9fF2gbc7k+BL1Rt/+i1J1tsLyqjZJ9A6pXwPVB5uxt3YAShG9+PC3elzy1HsaSKuAiFiEZYW3oEaxwdSkSZQqClDnuDL6GmMd3RDUEw2uIjfphC5DuauQ3AFhxaEIfbcmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348786; c=relaxed/simple;
	bh=lrmkPttDURFKu0OlFekPYzaHej1ygcR7qwdieg64a/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwhggUKxTE/swGVWNNv79dBssHRQKRZCjhhlTWZswPEGZUhq78EpX+8rlusroNScPVn88YE7EJedWC2BueKyNS+hnzmkOF21VrzPJOgLXaEwVw0KphALe7uDMSoJuoyJndH/gzeV+1/m1kwyeIsyRTut+hI9S5NQLvDUPEf1dBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=biRaF6i9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348782;
	bh=lrmkPttDURFKu0OlFekPYzaHej1ygcR7qwdieg64a/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=biRaF6i9GcEtBBhecaVAmJ/d074BoDpxM/yFqI0GiBW2g+6QMvy0rNi/9PoEi4gMV
	 WVcZubEW1Oc+v1/vTNebBWumGkLMcy8+6kLuxnN32eYCQ2oGHueRyuVm3ISf98TDV1
	 rQ2lyp6vUM5et1FYKhvig4H4UyLAfVLLHdeNqc3A=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:32:58 +0100
Subject: [PATCH 3/9] misc: sram: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-misc-drivers-v1-3-d50ff7b21367@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348781; l=1550;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lrmkPttDURFKu0OlFekPYzaHej1ygcR7qwdieg64a/U=;
 b=vg/FYOfVa/0xZABko9TadSA+Ov/vDdDTdJZ1gLuLI9VX5gubiYiyEKA5sAsk8XZpp2Gy4/gVH
 I1SUKqTuU5SAto9UpeOJtdEQ+vGj112l9+Gje3A6G+FoiOk6uyqNVEm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/sram.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index e40b027a88e25209933a20dc9dbd7db29cb81ba5..e5069882457ef6ba5dc084d02994034dc39d24c6 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -23,7 +23,7 @@
 #define SRAM_GRANULARITY	32
 
 static ssize_t sram_read(struct file *filp, struct kobject *kobj,
-			 struct bin_attribute *attr,
+			 const struct bin_attribute *attr,
 			 char *buf, loff_t pos, size_t count)
 {
 	struct sram_partition *part;
@@ -38,7 +38,7 @@ static ssize_t sram_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t sram_write(struct file *filp, struct kobject *kobj,
-			  struct bin_attribute *attr,
+			  const struct bin_attribute *attr,
 			  char *buf, loff_t pos, size_t count)
 {
 	struct sram_partition *part;
@@ -83,8 +83,8 @@ static int sram_add_export(struct sram_dev *sram, struct sram_reserve *block,
 		return -ENOMEM;
 
 	part->battr.attr.mode = S_IRUSR | S_IWUSR;
-	part->battr.read = sram_read;
-	part->battr.write = sram_write;
+	part->battr.read_new = sram_read;
+	part->battr.write_new = sram_write;
 	part->battr.size = block->size;
 
 	return device_create_bin_file(sram->dev, &part->battr);

-- 
2.47.1


