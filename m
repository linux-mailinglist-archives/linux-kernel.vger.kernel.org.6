Return-Path: <linux-kernel+bounces-441788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 569CD9ED415
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9183318889E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C42288EA;
	Wed, 11 Dec 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uAQpHu4T"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC917204F6A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939434; cv=none; b=dy9S0VVPjSmTR1gel/IwamfzFkcZPn0U7T/qTbW0QnVdlgtaLvHXTaZeif8kTPEPG/YEVmnkG8PSblS49/TuQ6pG2uhvKIsndrRblKvTDeWpn1ubyu/foXBtvP7BndcvQOV6cryJxjlraoDnS3lk3NWV4RcfuI3ZkR0ywWlbqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939434; c=relaxed/simple;
	bh=KK19iir1m59O/VjJu95BHnHglib78OZ0Gp0fadyWNAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6fDjvMTsSHOhnvtZBKJDYMaSyGJvqUObSo4zOT38v59fPu93PyQ2z8SA8z19OwcISj4WpsTQxE/gqeVVPI16/mwyLRP4gZos88oZcGALK02Epfhlr5VdneVmQ+VJFXpp4PvL+8ixFpQ5z3oO9V1l6OCiaJczYKNO0KsKqxHPD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uAQpHu4T; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939419;
	bh=KK19iir1m59O/VjJu95BHnHglib78OZ0Gp0fadyWNAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uAQpHu4TYcM+7XgyKrLM/dAoSrGT/MUS/mz5tPPe/kAi7vEeMQFso6EWfyWXMPiU9
	 pLnjwZ+mIEt8G2j2+hPZcscdHus3ox+2ckFGXWZLYv+lxJ4IZ55e0Y1URumlrA1U1o
	 8Q/e/RwQjpESd1iegdC3pDRhJs252BtjAfeugF+0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:27 +0100
Subject: [PATCH 12/12] w1: ds28e04: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-12-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939418; l=2969;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KK19iir1m59O/VjJu95BHnHglib78OZ0Gp0fadyWNAk=;
 b=xNZBL48ByI2FbIBtiklvPcqvgTduc7324TPOJvPIZWj170NpUEU8WQI2SL0QwkCLKo6/gU9/v
 WpZHl2gfnDDBcqcLERpUMFameVVzdKklB2G18Ejhs/vZ7GYU3DhHOwo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds28e04.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
index 2854b8b9e93f798b93127a0eda926d5ce29baa0d..d99ffadbe29bb48a5c60239b4d6f4cb0d7a5cb5d 100644
--- a/drivers/w1/slaves/w1_ds28e04.c
+++ b/drivers/w1/slaves/w1_ds28e04.c
@@ -112,7 +112,7 @@ static int w1_f1C_read(struct w1_slave *sl, int addr, int len, char *data)
 }
 
 static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
-			   struct bin_attribute *bin_attr, char *buf,
+			   const struct bin_attribute *bin_attr, char *buf,
 			   loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -223,7 +223,7 @@ static int w1_f1C_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 }
 
 static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
+			    const struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 
 {
@@ -276,10 +276,10 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static BIN_ATTR_RW(eeprom, W1_EEPROM_SIZE);
+static const BIN_ATTR_RW(eeprom, W1_EEPROM_SIZE);
 
 static ssize_t pio_read(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *bin_attr, char *buf, loff_t off,
+			const struct bin_attribute *bin_attr, char *buf, loff_t off,
 			size_t count)
 
 {
@@ -298,8 +298,8 @@ static ssize_t pio_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t pio_write(struct file *filp, struct kobject *kobj,
-			 struct bin_attribute *bin_attr, char *buf, loff_t off,
-			 size_t count)
+			 const struct bin_attribute *bin_attr, char *buf,
+			 loff_t off, size_t count)
 
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -337,7 +337,7 @@ static ssize_t pio_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static BIN_ATTR_RW(pio, 1);
+static const BIN_ATTR_RW(pio, 1);
 
 static ssize_t crccheck_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -363,7 +363,7 @@ static struct attribute *w1_f1C_attrs[] = {
 	NULL,
 };
 
-static struct bin_attribute *w1_f1C_bin_attrs[] = {
+static const struct bin_attribute *const w1_f1C_bin_attrs[] = {
 	&bin_attr_eeprom,
 	&bin_attr_pio,
 	NULL,
@@ -371,7 +371,7 @@ static struct bin_attribute *w1_f1C_bin_attrs[] = {
 
 static const struct attribute_group w1_f1C_group = {
 	.attrs		= w1_f1C_attrs,
-	.bin_attrs	= w1_f1C_bin_attrs,
+	.bin_attrs_new	= w1_f1C_bin_attrs,
 };
 
 static const struct attribute_group *w1_f1C_groups[] = {

-- 
2.47.1


