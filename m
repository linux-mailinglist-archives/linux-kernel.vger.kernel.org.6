Return-Path: <linux-kernel+bounces-198166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911EF8D745F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481A81F2143F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E42C1A2;
	Sun,  2 Jun 2024 09:02:54 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADD219F3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318974; cv=none; b=Uq39gtnMsg6CnSt3nkExvcked5/Hggz3nCgnrvpZM1tguk7VwDvtrvGJeKa1XTWRwPn/aXP8x+GNZIWItU7dm5+Wz3aP9w4e1HZcOBCUN9melsYNQDfJs4+8JFy86eaZ6IivHm9zYbEGcIu98Be9vdJ9pMOLp3UEE2XVKgxutLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318974; c=relaxed/simple;
	bh=ByJ2gn9CXxDqnzfeuHKTYoPy0ArsgzOsDRL+FAHDFKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEDfX7nZ7Rgmm3VRBlLJFNsyTs7RaXWNOGiGgQ4w1V1NUqoPoDi94m6ETjDl4R4bPC/+Mquup82ysiArNPxTJhzNFQpyQjiWxuGd5ElErXwkIg4O71gYxVZaA6PLMcRtBblXRstkz4dqIfUOQO+lt/75FoK2/POGWXaBxcbHxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id e2b70418-20be-11ef-ab01-005056bdd08f;
	Sun, 02 Jun 2024 12:02:49 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jorge Lopez <jorge.lopez2@hp.com>,
	Li Zetao <lizetao1@huawei.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-input@vger.kernel.org
Cc: Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Mark Pearson <markpearson@lenovo.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH v1 1/7] platform/x86: asus-tf103c-dock: Use 2-argument strscpy()
Date: Sun,  2 Jun 2024 11:57:54 +0300
Message-ID: <20240602090244.1666360-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240602090244.1666360-1-andy.shevchenko@gmail.com>
References: <20240602090244.1666360-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 2-argument strscpy(), which is not only shorter but also provides
an additional check that destination buffer is an array.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/x86/asus-tf103c-dock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-tf103c-dock.c b/drivers/platform/x86/asus-tf103c-dock.c
index 8f0f87637c5f..b441d8ca72d3 100644
--- a/drivers/platform/x86/asus-tf103c-dock.c
+++ b/drivers/platform/x86/asus-tf103c-dock.c
@@ -490,7 +490,7 @@ static void tf103c_dock_enable_touchpad(struct tf103c_dock_data *dock)
 		return;
 	}
 
-	strscpy(board_info.type, "elan_i2c", I2C_NAME_SIZE);
+	strscpy(board_info.type, "elan_i2c");
 	board_info.addr = TF103C_DOCK_TP_ADDR;
 	board_info.dev_name = TF103C_DOCK_DEV_NAME "-tp";
 	board_info.irq = dock->tp_irq;
@@ -795,7 +795,7 @@ static int tf103c_dock_probe(struct i2c_client *client)
 	 */
 	dock->ec_client = client;
 
-	strscpy(board_info.type, "tf103c-dock-intr", I2C_NAME_SIZE);
+	strscpy(board_info.type, "tf103c-dock-intr");
 	board_info.addr = TF103C_DOCK_INTR_ADDR;
 	board_info.dev_name = TF103C_DOCK_DEV_NAME "-intr";
 
@@ -803,7 +803,7 @@ static int tf103c_dock_probe(struct i2c_client *client)
 	if (IS_ERR(dock->intr_client))
 		return dev_err_probe(dev, PTR_ERR(dock->intr_client), "creating intr client\n");
 
-	strscpy(board_info.type, "tf103c-dock-kbd", I2C_NAME_SIZE);
+	strscpy(board_info.type, "tf103c-dock-kbd");
 	board_info.addr = TF103C_DOCK_KBD_ADDR;
 	board_info.dev_name = TF103C_DOCK_DEV_NAME "-kbd";
 
@@ -846,8 +846,8 @@ static int tf103c_dock_probe(struct i2c_client *client)
 	dock->hid->vendor = 0x0b05;  /* USB_VENDOR_ID_ASUSTEK */
 	dock->hid->product = 0x0103; /* From TF-103-C */
 	dock->hid->version = 0x0100; /* 1.0 */
-	strscpy(dock->hid->name, "Asus TF103C Dock Keyboard", sizeof(dock->hid->name));
-	strscpy(dock->hid->phys, dev_name(dev), sizeof(dock->hid->phys));
+	strscpy(dock->hid->name, "Asus TF103C Dock Keyboard");
+	strscpy(dock->hid->phys, dev_name(dev));
 
 	ret = hid_add_device(dock->hid);
 	if (ret)
-- 
2.45.1


