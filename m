Return-Path: <linux-kernel+bounces-176200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54EA8C2B94
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C64C1F223DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0662013B5A8;
	Fri, 10 May 2024 21:15:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5213B597
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375708; cv=none; b=I16msPVZNvC3smEnilcQ/zx9sqBJFfjTpYRDIZKj4NGvwzE/m/WQEkdByEw4IY9CNnO4/LDLQ8+XDbFKMdJzSCq/xBRFg4Ew7QYzWFG/aN1yX2dy8P6bQ3FAc5VgnvGsz4fOQdovxsTwr0F//6x8qqdtB1KAXgN4XXduUILrt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375708; c=relaxed/simple;
	bh=CfRgQ4O3FLma9WD+HWpo6N4bagp3UwWFygtTgB2J2Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rx/JyeAMVuGJkPfoh6zEm2J4jNgkFJC+Xbf4gVS1+AEqu5FcmZqFP2IMJzzp8rc3MbFw0fvKYL+Aw1A61t9wfv6sf1uglVtarK3vqyWDZ8MIVfKpEXlAnURACcIQip5mz5MoW1FBw+N9SQvkwOipFad9oya7dNgBreyIcHI+cio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5Xa2-0005b4-Hi; Fri, 10 May 2024 23:15:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5Xa2-000hLJ-3k; Fri, 10 May 2024 23:15:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5Xa2-002H8M-06;
	Fri, 10 May 2024 23:15:02 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] eeprom: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Fri, 10 May 2024 23:14:54 +0200
Message-ID: <20240510211454.2274614-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4368; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CfRgQ4O3FLma9WD+HWpo6N4bagp3UwWFygtTgB2J2Es=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmPo5P7Y593d6ajJj3oGKxDcBmxQMC3TvrnLOB0 qFf3YoCadKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZj6OTwAKCRCPgPtYfRL+ Ts32B/4k4lqap2GqDeTq+ngKtfcQ9irLerPCFaeeUjxnjC3djBycQ5RGcRa+BJqR+OUp9bZg7nG S1W77+E4vobGM7JyCtL9JQNbK/N2a2PEOYu6RhBXr6qyE1EejfrbuhiZsbNc52G6VTcidm/WRtp VGcecYSdASeKVNL3Fb8okFewdxe8cKUsxmDs8TyDQjjqf+zHITki7zY+zOinafhvbjrJ7DpIZel RH8Dn9viCNOfkfSTXtwf5cerT+LX6mnAOnkWWWEzA/ZddyGdQRDElbTCnwB+KZe5zwx5jFSdTib GHXnpIZU0fus4HNsuF6xd2cUT9Y8XlOf+CcefazQfKWmcNT6
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/misc/eeprom/ee1004.c      |  2 +-
 drivers/misc/eeprom/idt_89hpesx.c | 96 +++++++++++++++----------------
 drivers/misc/eeprom/max6875.c     |  2 +-
 3 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 21feebc3044c..bf4f65dc6d9a 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -52,7 +52,7 @@ static struct ee1004_bus_data {
 } ee1004_bus_data[EE1004_MAX_BUSSES];
 
 static const struct i2c_device_id ee1004_ids[] = {
-	{ "ee1004", 0 },
+	{ "ee1004" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ee1004_ids);
diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 327afb866b21..43421fe37d33 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -1426,58 +1426,58 @@ MODULE_DEVICE_TABLE(i2c, ee_ids);
  * idt_ids - supported IDT 89HPESx devices
  */
 static const struct i2c_device_id idt_ids[] = {
-	{ "89hpes8nt2", 0 },
-	{ "89hpes12nt3", 0 },
+	{ "89hpes8nt2" },
+	{ "89hpes12nt3" },
 
-	{ "89hpes24nt6ag2", 0 },
-	{ "89hpes32nt8ag2", 0 },
-	{ "89hpes32nt8bg2", 0 },
-	{ "89hpes12nt12g2", 0 },
-	{ "89hpes16nt16g2", 0 },
-	{ "89hpes24nt24g2", 0 },
-	{ "89hpes32nt24ag2", 0 },
-	{ "89hpes32nt24bg2", 0 },
+	{ "89hpes24nt6ag2" },
+	{ "89hpes32nt8ag2" },
+	{ "89hpes32nt8bg2" },
+	{ "89hpes12nt12g2" },
+	{ "89hpes16nt16g2" },
+	{ "89hpes24nt24g2" },
+	{ "89hpes32nt24ag2" },
+	{ "89hpes32nt24bg2" },
 
-	{ "89hpes12n3", 0 },
-	{ "89hpes12n3a", 0 },
-	{ "89hpes24n3", 0 },
-	{ "89hpes24n3a", 0 },
+	{ "89hpes12n3" },
+	{ "89hpes12n3a" },
+	{ "89hpes24n3" },
+	{ "89hpes24n3a" },
 
-	{ "89hpes32h8", 0 },
-	{ "89hpes32h8g2", 0 },
-	{ "89hpes48h12", 0 },
-	{ "89hpes48h12g2", 0 },
-	{ "89hpes48h12ag2", 0 },
-	{ "89hpes16h16", 0 },
-	{ "89hpes22h16", 0 },
-	{ "89hpes22h16g2", 0 },
-	{ "89hpes34h16", 0 },
-	{ "89hpes34h16g2", 0 },
-	{ "89hpes64h16", 0 },
-	{ "89hpes64h16g2", 0 },
-	{ "89hpes64h16ag2", 0 },
+	{ "89hpes32h8" },
+	{ "89hpes32h8g2" },
+	{ "89hpes48h12" },
+	{ "89hpes48h12g2" },
+	{ "89hpes48h12ag2" },
+	{ "89hpes16h16" },
+	{ "89hpes22h16" },
+	{ "89hpes22h16g2" },
+	{ "89hpes34h16" },
+	{ "89hpes34h16g2" },
+	{ "89hpes64h16" },
+	{ "89hpes64h16g2" },
+	{ "89hpes64h16ag2" },
 
-	/* { "89hpes3t3", 0 }, // No SMBus-slave iface */
-	{ "89hpes12t3g2", 0 },
-	{ "89hpes24t3g2", 0 },
-	/* { "89hpes4t4", 0 }, // No SMBus-slave iface */
-	{ "89hpes16t4", 0 },
-	{ "89hpes4t4g2", 0 },
-	{ "89hpes10t4g2", 0 },
-	{ "89hpes16t4g2", 0 },
-	{ "89hpes16t4ag2", 0 },
-	{ "89hpes5t5", 0 },
-	{ "89hpes6t5", 0 },
-	{ "89hpes8t5", 0 },
-	{ "89hpes8t5a", 0 },
-	{ "89hpes24t6", 0 },
-	{ "89hpes6t6g2", 0 },
-	{ "89hpes24t6g2", 0 },
-	{ "89hpes16t7", 0 },
-	{ "89hpes32t8", 0 },
-	{ "89hpes32t8g2", 0 },
-	{ "89hpes48t12", 0 },
-	{ "89hpes48t12g2", 0 },
+	/* { "89hpes3t3" }, // No SMBus-slave iface */
+	{ "89hpes12t3g2" },
+	{ "89hpes24t3g2" },
+	/* { "89hpes4t4" }, // No SMBus-slave iface */
+	{ "89hpes16t4" },
+	{ "89hpes4t4g2" },
+	{ "89hpes10t4g2" },
+	{ "89hpes16t4g2" },
+	{ "89hpes16t4ag2" },
+	{ "89hpes5t5" },
+	{ "89hpes6t5" },
+	{ "89hpes8t5" },
+	{ "89hpes8t5a" },
+	{ "89hpes24t6" },
+	{ "89hpes6t6g2" },
+	{ "89hpes24t6g2" },
+	{ "89hpes16t7" },
+	{ "89hpes32t8" },
+	{ "89hpes32t8g2" },
+	{ "89hpes48t12" },
+	{ "89hpes48t12g2" },
 	{ /* END OF LIST */ }
 };
 MODULE_DEVICE_TABLE(i2c, idt_ids);
diff --git a/drivers/misc/eeprom/max6875.c b/drivers/misc/eeprom/max6875.c
index cb6b1efeafe0..6fab2ffa736b 100644
--- a/drivers/misc/eeprom/max6875.c
+++ b/drivers/misc/eeprom/max6875.c
@@ -183,7 +183,7 @@ static void max6875_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max6875_id[] = {
-	{ "max6875", 0 },
+	{ "max6875" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max6875_id);

base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
-- 
2.43.0


