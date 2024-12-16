Return-Path: <linux-kernel+bounces-447249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E69F2FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94AF16498C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E14206273;
	Mon, 16 Dec 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="c3mYq2mJ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220F20551F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348788; cv=none; b=F8ed7gVbdTBWbkTvoF3ivEhoE2t9csmQgvsL/EfI0h6Uyg4EmHxhtIrLnj9DVAYSAuX7NGsuyzJkYUySXFpYDmoNFDN1TML8y5grJz3RnTNApb0ZzmUeqlvBdrEtfngDg8q3MEExol8362strJrdF1ZDv6s09dR8vq+gA//MWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348788; c=relaxed/simple;
	bh=SGNU5IH45oWd8l2/U8DWBMgp52g/CAQH5eqzkYxnU98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sV5ege/PMV2VMqx2zIFW5qCuo2583u045/R0eJ+dtUy3K3sy8oR/tivRE3zzVQ4Ro4JhWF2fb975tnMoyWsYxjunZ0XAJt1OhlLOkUkbG/VR2xSaQ/DXidAljPJxIC6tfOoA1bhoNaxrLb/3q8GlAnGDli0QbomMj95a7PU5p2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=c3mYq2mJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348782;
	bh=SGNU5IH45oWd8l2/U8DWBMgp52g/CAQH5eqzkYxnU98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c3mYq2mJcekiJuhBgIIW27jXtnpzPT4YWscUJ2HP5DhUmVlnXWvFi+N42GdoVqI8C
	 eRRGwl70Gcq/YAiALSTicS2w9RrHzN2ZIYyhsuRox+eKdeMgTIGZdlaWpCqKw2mzla
	 Cd0K9z8QHx8LKszbT1NmV/lc7Y0GSLW1DySkfs/o=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:33:02 +0100
Subject: [PATCH 7/9] misc: eeprom/idt_89hpesx: Constify 'struct
 bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-misc-drivers-v1-7-d50ff7b21367@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348781; l=1790;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SGNU5IH45oWd8l2/U8DWBMgp52g/CAQH5eqzkYxnU98=;
 b=g8NH5MD7iQwipA2t3S5AFXTfyVoMJXZLw4AUNZ66awjEngV+bDzzXZSYF66Pl7unnvvTkaHQm
 L88qMM11/C4DkttBTBl8msv5BNPFGUgTCF2PNY/OqhAHX5VvqqD5uTD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/eeprom/idt_89hpesx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 43421fe37d338874ff1c2949497c64ebf0143106..1fc632ebf22f560088084519e5ad8e8b37958368 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -847,7 +847,7 @@ static int idt_csr_read(struct idt_89hpesx_dev *pdev, u16 csraddr, u32 *data)
  * @count:	Number of bytes to write
  */
 static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *attr,
+			    const struct bin_attribute *attr,
 			    char *buf, loff_t off, size_t count)
 {
 	struct idt_89hpesx_dev *pdev;
@@ -871,7 +871,7 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
  * @count:	Number of bytes to write
  */
 static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
-			   struct bin_attribute *attr,
+			   const struct bin_attribute *attr,
 			   char *buf, loff_t off, size_t count)
 {
 	struct idt_89hpesx_dev *pdev;
@@ -1017,7 +1017,7 @@ static ssize_t idt_dbgfs_csr_read(struct file *filep, char __user *ubuf,
  * NOTE Size will be changed in compliance with OF node. EEPROM attribute will
  * be read-only as well if the corresponding flag is specified in OF node.
  */
-static BIN_ATTR_RW(eeprom, EEPROM_DEF_SIZE);
+static const BIN_ATTR_RW(eeprom, EEPROM_DEF_SIZE);
 
 /*
  * csr_dbgfs_ops - CSR debugfs-node read/write operations

-- 
2.47.1


