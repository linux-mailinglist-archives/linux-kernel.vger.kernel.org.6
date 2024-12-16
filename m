Return-Path: <linux-kernel+bounces-447250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C49E69F2F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97507A2617
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D420626D;
	Mon, 16 Dec 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="svVmtvaE"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55120550E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348788; cv=none; b=M63RlZytGAH1U4Bey6ZdzZ1cUIqxHQf+yPKWPgpyfBRZio2W+rkwD5gpTR9PejlBySKL7aVZigvAqlOrZYDfnBFBg/v5JRBVi8ZGKs5snc8vCRcODK20xD3oPg4Xmq/C5ViHwdRihBssffazHniUTi+hvtNHgGfk6UsuCP16mQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348788; c=relaxed/simple;
	bh=P5yp8xYY8rjGfFuGyyUiA1DeB8eRe4QDxQgMbEH9sX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9G01z4VbiTDxiUhKgh9txXUQ/R+hKeB1pfo5qi2oDMf7qDAtT1pIZ2m0/yYdx7iIeGBWTb1NANGZqisUxrhdOXoA7sFiJTQp/4vMHgPAsLU1LljWuOl1/8CgJ8GTYGmgCkrxQosBz8Bpq3Fe8jWD0tQz4dVsZDRI8mHkI0kPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=svVmtvaE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348782;
	bh=P5yp8xYY8rjGfFuGyyUiA1DeB8eRe4QDxQgMbEH9sX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=svVmtvaEfVKWlI8VZwfYj66iHqRaO9PnQVSWrmsw4BujiyUQ+yko3HpWl4Dl1hkWB
	 5lkzEWLtizIAVIHU0EJsQ3SUY7mzGJTbzn38cGo4rpCCm/H6eD+4c/tweUanj8Stz1
	 u09BB8wsiP6LvSqot8lM67B0ywl2z3xoqRFkxljk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:33:03 +0100
Subject: [PATCH 8/9] misc: eeprom/max6875: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-misc-drivers-v1-8-d50ff7b21367@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348781; l=1212;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=P5yp8xYY8rjGfFuGyyUiA1DeB8eRe4QDxQgMbEH9sX4=;
 b=k7/JQA7TzOn/tnIeXdQZ/clBNOPvkBekXegG3kZ5eiGbNYKtRRCJtibmbDT1eNMQHtuOt/QMq
 jszYpZRVM+iAkaXxT6+Rw3UkJHgxAHt3vZgEkhmIAc06ICDAljy8us1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/eeprom/max6875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/max6875.c b/drivers/misc/eeprom/max6875.c
index 6fab2ffa736b741593931c413f230d7c43b5b8dd..1c36ad153e783ead6ba2481c64838390f0bb05f4 100644
--- a/drivers/misc/eeprom/max6875.c
+++ b/drivers/misc/eeprom/max6875.c
@@ -104,7 +104,7 @@ static void max6875_update_slice(struct i2c_client *client, int slice)
 }
 
 static ssize_t max6875_read(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr,
+			    const struct bin_attribute *bin_attr,
 			    char *buf, loff_t off, size_t count)
 {
 	struct i2c_client *client = kobj_to_i2c_client(kobj);
@@ -127,7 +127,7 @@ static const struct bin_attribute user_eeprom_attr = {
 		.mode = S_IRUGO,
 	},
 	.size = USER_EEPROM_SIZE,
-	.read = max6875_read,
+	.read_new = max6875_read,
 };
 
 static int max6875_probe(struct i2c_client *client)

-- 
2.47.1


