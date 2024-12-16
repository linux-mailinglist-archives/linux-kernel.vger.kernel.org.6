Return-Path: <linux-kernel+bounces-447253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0319F2F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BBE188255C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EA720628E;
	Mon, 16 Dec 2024 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NfxFD6II"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB37204599
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348789; cv=none; b=QrbzB9e0t1phl+FaAs4oebbn8Md34yDF3eQM9of0SBENHEQPHtC/dwdmSV3B83S1gqLG6tnn1uX2XZ/abOMYVBnyGKr3MR7sqWKyf3YN4YDiA279z6zcVvOzH2O3kJZk5PEe0Kl9kaCbIE5J7YP6a1GlCKGIcKJrqNpuMzKxdZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348789; c=relaxed/simple;
	bh=K4ArLdURdX68J2n0OD7NKA61+TDFNtIXruvjgSApS6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlSZnEs7ZDr86OnGb4TWdEWN2s4iVzZoYeBrIsahKmPtp/gKipILFncVLmpvu29VG0jQKWOCyAJcKkElteZ6Jr+Ogld0ME5jbsL2IK78buopPDNaG+dozwwZW3HmLFskmZVb5TpBYYGwU5Q5mwmVG5mmq6Es8s1mmWSWy0hVJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NfxFD6II; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348782;
	bh=K4ArLdURdX68J2n0OD7NKA61+TDFNtIXruvjgSApS6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NfxFD6IIfv0b72FnNHcUemUJKW7ucb4PD4uqSFqSynxbBJ1SFm8Ol1Sv7jwELRPFE
	 749g1byC+LOX+bRy4uE6sridAEUEEZzgWFKpTEm6Voj+AnXNWP8H4ppwKng/R0X08P
	 v5cPrKAYHLUWz/wmrCIA3gqttNBQATRla42PJpY0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:33:04 +0100
Subject: [PATCH 9/9] misc: ds1682: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-misc-drivers-v1-9-d50ff7b21367@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348781; l=1662;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K4ArLdURdX68J2n0OD7NKA61+TDFNtIXruvjgSApS6k=;
 b=vnav+SRhHMJUpON2XxNPS9SvCbHCVXWtEVYujeOfGn+lPW1BTFAAtx1VDP0H2bZFBSIJAl63w
 ei68QXNXhzlD7MjpC5Xdlp+pHXf2dPAekPEInby2gxMr4OzqQ7toj+/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/ds1682.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
index 4175df7ef0111f69ed8d4229b7ab50a3c3d7ad12..5d5a70a62e98b6691aac1c0f9142d39555ba4f8c 100644
--- a/drivers/misc/ds1682.c
+++ b/drivers/misc/ds1682.c
@@ -154,7 +154,7 @@ static const struct attribute_group ds1682_group = {
  * User data attribute
  */
 static ssize_t ds1682_eeprom_read(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *attr,
+				  const struct bin_attribute *attr,
 				  char *buf, loff_t off, size_t count)
 {
 	struct i2c_client *client = kobj_to_i2c_client(kobj);
@@ -172,7 +172,7 @@ static ssize_t ds1682_eeprom_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t ds1682_eeprom_write(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *attr,
+				   const struct bin_attribute *attr,
 				   char *buf, loff_t off, size_t count)
 {
 	struct i2c_client *client = kobj_to_i2c_client(kobj);
@@ -194,8 +194,8 @@ static const struct bin_attribute ds1682_eeprom_attr = {
 		.mode = S_IRUGO | S_IWUSR,
 	},
 	.size = DS1682_EEPROM_SIZE,
-	.read = ds1682_eeprom_read,
-	.write = ds1682_eeprom_write,
+	.read_new = ds1682_eeprom_read,
+	.write_new = ds1682_eeprom_write,
 };
 
 static int ds1682_nvmem_read(void *priv, unsigned int offset, void *val,

-- 
2.47.1


