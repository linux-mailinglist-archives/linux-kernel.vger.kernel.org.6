Return-Path: <linux-kernel+bounces-441784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 440879ED410
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8B8188908D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCEF20B810;
	Wed, 11 Dec 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Rs+ay3Hy"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DC203717
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939433; cv=none; b=RKgd7SkaWLI3g6LDPlC8EJKdukwTrlQu4MlpSo1sU9U3KitA07gRZwZdwAxAPecS/1jo6MBmTI8C+vtkN/a7DBfHyu7u2LFJdZYXgJjXLfVk8Np4MOP7vqAWXrGTNwxL1W6uTTbZu08+5vHb7a/STciw9m7Dj//Urgw1bzEy6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939433; c=relaxed/simple;
	bh=P6DBml8KrtQ/YAj969y7H9LijFtK4LKZTE4QTzRzjxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQr5A4V9jX7bk1vXyKpv7hHBfGckmCNFSAV02KGoh99zVMQRZO90CS4+5J4zUCB1dE2KGnCBdPD9OgM0EHXVuLNHRmAlas7/5RRqegb73aQHT9E3dcrCDQ8pXdFflDH/6vE84Y87GsNIrQ+9xRg9vO++p1MqBLAytBClHGd/46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Rs+ay3Hy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939419;
	bh=P6DBml8KrtQ/YAj969y7H9LijFtK4LKZTE4QTzRzjxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rs+ay3HyBopAVXFA3dEhMgO+ooP5O+//cHoSuh3IrWcj/2xYezfVF6JbAo89v1ISn
	 W9uVI26AuVZTeOSZ0EipDliu22HcwYCLFXLI57dOdSd4lucpeLiew8+kVyca0Inw1u
	 aNDe/pP9KhPlMTvVUI44KHl4eXCAvItzWpYLjabc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:25 +0100
Subject: [PATCH 10/12] w1: ds2781: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-10-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939418; l=1623;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=P6DBml8KrtQ/YAj969y7H9LijFtK4LKZTE4QTzRzjxE=;
 b=pN3DzF9bRtBeUGejWHvMxGeZ95Sym1eamI8MK4C/ZwFLlgw85yLeVgGwcR0skihEoMelHCYpf
 2dEDLOsbe/KD0OgK0DxRYGWHAV2SQBBS+jIK+B49SVMgsD/H95626WK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds2781.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2781.c b/drivers/w1/slaves/w1_ds2781.c
index e418484b4a49e8474fbcdefac2d3599dcf9e2115..acd04ee96e81bd028e026711749649c59e35a141 100644
--- a/drivers/w1/slaves/w1_ds2781.c
+++ b/drivers/w1/slaves/w1_ds2781.c
@@ -84,7 +84,7 @@ int w1_ds2781_eeprom_cmd(struct device *dev, int addr, int cmd)
 EXPORT_SYMBOL(w1_ds2781_eeprom_cmd);
 
 static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
+			     const struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -92,15 +92,15 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
 	return w1_ds2781_io(dev, buf, off, count, 0);
 }
 
-static BIN_ATTR_RO(w1_slave, DS2781_DATA_SIZE);
+static const BIN_ATTR_RO(w1_slave, DS2781_DATA_SIZE);
 
-static struct bin_attribute *w1_ds2781_bin_attrs[] = {
+static const struct bin_attribute *const w1_ds2781_bin_attrs[] = {
 	&bin_attr_w1_slave,
 	NULL,
 };
 
 static const struct attribute_group w1_ds2781_group = {
-	.bin_attrs = w1_ds2781_bin_attrs,
+	.bin_attrs_new = w1_ds2781_bin_attrs,
 };
 
 static const struct attribute_group *w1_ds2781_groups[] = {

-- 
2.47.1


