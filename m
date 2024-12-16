Return-Path: <linux-kernel+bounces-447321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4715B9F3080
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD217A1BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68725204C09;
	Mon, 16 Dec 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UxT2AXiL"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA1204C02
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351918; cv=none; b=F+fVwPFpU3OsO5G1Gz4QBm7F+JTtPnLY+ddTW0R8kReY9r2/aHDUZer83BnSNQJ3AFPQ+Cc3ekDVu2NAdaxiRJp34bRbWP7JWh+SC9VYCCCJ1FrWpTB0yVdUFpmGAplJQm23Y5NkUAC20M2m4G36C47ksPk1ZVbZkZgiYLjwRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351918; c=relaxed/simple;
	bh=RA82AkSXi61D6nUmUNT7oSNDv8q3l7RKH4P+1ooMy8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bYdgkIKQNFq9c1xROdeXb3w59ya3ORapOd0APci3rNEAX64CfDkvZIXUa487LasjHwK9i/qT7w930FWy6Y3QwNvbTKvs3YZStkdSsWiNvO7wZj+4gjB5kUv+bmcB2L31MXmCLuH6aSQgDJSrYyp3P/HmwL7ck82J14clvixBt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UxT2AXiL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734351914;
	bh=RA82AkSXi61D6nUmUNT7oSNDv8q3l7RKH4P+1ooMy8Y=;
	h=From:Date:Subject:To:Cc:From;
	b=UxT2AXiLbLGPc4bbt2HSvMzZe5Ai8TLCtDg7zxs8t5FeXdf3N5pPQvCLicHAD2TYR
	 +iHtHDIJmbe+gBaQj/qM4vKnPpu0YH/wrQOZnXX9QYojZiRLd0Mevoi4lrtJjmrji8
	 LGNEhKaJPNd7mnUeFuPHnHaO+29MUAyBL4jEYLxE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 13:25:12 +0100
Subject: [PATCH] accel/habanalabs: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-habanalabs-v1-1-b35463197efb@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACccYGcC/x3N0QqDMAxA0V+RPC+wljm6/YoMSds4AyNKU8Qh/
 vvKHs/LvQcYF2GDZ3dA4U1MFm1wlw7STPpmlNwM/upvzrs72tcmw7SoVYyiI9VacKZISh+KhiE
 9eg69zzkQtMpaeJL9fxhe5/kDCYLO5XEAAAA=
X-Change-ID: 20241216-sysfs-const-bin_attr-habanalabs-8c95e852dd8a
To: Ofir Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734351913; l=2078;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=RA82AkSXi61D6nUmUNT7oSNDv8q3l7RKH4P+1ooMy8Y=;
 b=OxYVpD7XCbhY4fhUwtBnLpZA0zeWUdS30JDxhVpWu8msJfjhMPB2GHAQI9HYTc+D/HqlA0Gq1
 SKaUCGk2U0dCOwsVHg/tq5aUjI5802594mnJmGFpJ8ZvtnaUhI5xh6f
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/accel/habanalabs/common/sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/habanalabs/common/sysfs.c b/drivers/accel/habanalabs/common/sysfs.c
index e9f8ccc0bbf9d4dabec1b51072d07170c51ffc9e..9d58efa2ff380c8773bd79bea613dc79a5a98020 100644
--- a/drivers/accel/habanalabs/common/sysfs.c
+++ b/drivers/accel/habanalabs/common/sysfs.c
@@ -368,7 +368,7 @@ static ssize_t max_power_store(struct device *dev,
 }
 
 static ssize_t eeprom_read_handler(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *attr, char *buf, loff_t offset,
+			const struct bin_attribute *attr, char *buf, loff_t offset,
 			size_t max_size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -443,10 +443,10 @@ static DEVICE_ATTR_RO(security_enabled);
 static DEVICE_ATTR_RO(module_id);
 static DEVICE_ATTR_RO(parent_device);
 
-static struct bin_attribute bin_attr_eeprom = {
+static const struct bin_attribute bin_attr_eeprom = {
 	.attr = {.name = "eeprom", .mode = (0444)},
 	.size = PAGE_SIZE,
-	.read = eeprom_read_handler
+	.read_new = eeprom_read_handler
 };
 
 static struct attribute *hl_dev_attrs[] = {
@@ -472,14 +472,14 @@ static struct attribute *hl_dev_attrs[] = {
 	NULL,
 };
 
-static struct bin_attribute *hl_dev_bin_attrs[] = {
+static const struct bin_attribute *const hl_dev_bin_attrs[] = {
 	&bin_attr_eeprom,
 	NULL
 };
 
 static struct attribute_group hl_dev_attr_group = {
 	.attrs = hl_dev_attrs,
-	.bin_attrs = hl_dev_bin_attrs,
+	.bin_attrs_new = hl_dev_bin_attrs,
 };
 
 static struct attribute_group hl_dev_clks_attr_group;

---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241216-sysfs-const-bin_attr-habanalabs-8c95e852dd8a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


