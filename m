Return-Path: <linux-kernel+bounces-176196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263AD8C2B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7570DB22D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5CA13B59F;
	Fri, 10 May 2024 21:10:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340543AD9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375439; cv=none; b=W5DLs8Wlz6gg2wy8Pyl6KsXGh22AK2oIcg4GZNbv/Q9QhTVxHNNRK6yiqFHQZfEuoisRFDqXUFKOnoxQD657sjL35gt0ctiPWzzTKXvC7ffamZ7LNAffTl6QQbItBnY26omsUPrxKu9fZI3zVPyXAwM5EmBSBiO1RymSIOnXsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375439; c=relaxed/simple;
	bh=+rpWdopJAFSlVIYNSEBVqrD6Z/rY/Q2uU461TBjnPiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sOAfW4bbItTqNFUxOEyAxj3TN4c19VKNDPr6MN9kFn/qPDxYIgKFo+YHMwGvIIRMVmCllC6Il0Fagiw48HJTLYAGzyWAebONJOnEB/Q75RQp+pHT2z7G2hdqjTB4/IQj+6GXakxUvYZfBMPRdhW9eOXSdrnYnu5JZetqollqvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5XVb-0003hi-OI; Fri, 10 May 2024 23:10:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5XVb-000hKm-8H; Fri, 10 May 2024 23:10:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5XVb-002Gqu-0W;
	Fri, 10 May 2024 23:10:27 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] mfd: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Fri, 10 May 2024 23:10:11 +0200
Message-ID: <20240510211011.2273978-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=14514; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+rpWdopJAFSlVIYNSEBVqrD6Z/rY/Q2uU461TBjnPiE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhjS7XuMUd+e3jY7tTcwPLW6yirGrzw5we7y24eAUWaFG9 4s//Tk7GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZhI+mP2/4EGHmk6v3XSf+5S Pr/3hOyj6/8bSieIcmm91FxuxMFQ4vkk0HLn04zG7WFxJzq3dOWzR3Fu+7VTIVR0eYSt6Vmf8v1 MVirF5wS/On0Pb3nr073uy5RFiqFGU9hmnVvSuHvq8muCFg3F+wOOihRtz9f62rTRR7r9t9Ocaq s3ps09WTO1HrjudJx0sLr+jEqj0WLpSo/nLpzuWUmHza9UF3OfjzRlqJ80pd2fn7Pkrdb9iqpMl 22vdMy8z5+P+L9lyVmVfSct93dsfBudl9l30kHHYM3tE+6bJ12xevzQ27+mYNJ3s9D36ifvOXAo 3hb5u+2T6BzG/3ni7FwyfPqry7JCnM5Zx0i6rYry9NgFAA==
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

While add it, also remove commas after the sentinel entries.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch was created based on today's next. It it doesn't apply any
more in a few files, feel free to drop the conflicting changes and apply
the rest. I'll address the fallout later then.

Best regards
Uwe

 drivers/mfd/88pm800.c       |  2 +-
 drivers/mfd/88pm805.c       |  2 +-
 drivers/mfd/88pm860x-core.c |  2 +-
 drivers/mfd/aat2870-core.c  |  2 +-
 drivers/mfd/act8945a.c      |  2 +-
 drivers/mfd/as3722.c        |  4 ++--
 drivers/mfd/axp20x-i2c.c    | 24 ++++++++++++------------
 drivers/mfd/bd9571mwv.c     |  2 +-
 drivers/mfd/da9055-i2c.c    |  2 +-
 drivers/mfd/lm3533-core.c   |  4 ++--
 drivers/mfd/lp3943.c        |  2 +-
 drivers/mfd/lp873x.c        |  4 ++--
 drivers/mfd/lp87565.c       |  4 ++--
 drivers/mfd/lp8788.c        |  2 +-
 drivers/mfd/max8907.c       |  2 +-
 drivers/mfd/max8925-i2c.c   |  4 ++--
 drivers/mfd/menelaus.c      |  2 +-
 drivers/mfd/retu-mfd.c      |  4 ++--
 drivers/mfd/stw481x.c       |  4 ++--
 drivers/mfd/tps6105x.c      |  4 ++--
 drivers/mfd/tps6507x.c      |  2 +-
 drivers/mfd/tps65086.c      |  2 +-
 drivers/mfd/tps65090.c      |  4 ++--
 drivers/mfd/tps6586x.c      |  4 ++--
 drivers/mfd/tps65912-i2c.c  |  2 +-
 drivers/mfd/twl6040.c       |  6 +++---
 drivers/mfd/wl1273-core.c   |  2 +-
 drivers/mfd/wm8350-i2c.c    |  6 +++---
 drivers/mfd/wm8400-core.c   |  2 +-
 29 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 300caa067335..384ecf5301d2 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -116,7 +116,7 @@ enum {
 #define PM800_CHIP_GEN_ID_NUM	0x3
 
 static const struct i2c_device_id pm80x_id_table[] = {
-	{"88PM800", 0},
+	{ "88PM800" },
 	{} /* NULL terminated */
 };
 MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index 68417c3c4f5a..205f0762a928 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -30,7 +30,7 @@
 #include <linux/delay.h>
 
 static const struct i2c_device_id pm80x_id_table[] = {
-	{"88PM805", 0},
+	{ "88PM805" },
 	{} /* NULL terminated */
 };
 MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 151bf03e772d..7f003f71e1af 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1233,7 +1233,7 @@ static int pm860x_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(pm860x_pm_ops, pm860x_suspend, pm860x_resume);
 
 static const struct i2c_device_id pm860x_id_table[] = {
-	{ "88PM860x", 0 },
+	{ "88PM860x" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, pm860x_id_table);
diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 2fee62f1016c..8ef510e84688 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -439,7 +439,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(aat2870_pm_ops, aat2870_i2c_suspend,
 				aat2870_i2c_resume);
 
 static const struct i2c_device_id aat2870_i2c_id_table[] = {
-	{ "aat2870", 0 },
+	{ "aat2870" },
 	{ }
 };
 
diff --git a/drivers/mfd/act8945a.c b/drivers/mfd/act8945a.c
index 4e32ac3d573e..cafefb4451cb 100644
--- a/drivers/mfd/act8945a.c
+++ b/drivers/mfd/act8945a.c
@@ -54,7 +54,7 @@ static int act8945a_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id act8945a_i2c_id[] = {
-	{ "act8945a", 0 },
+	{ "act8945a" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, act8945a_i2c_id);
diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index bec047bdd088..6c0d89b0c7e3 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -430,8 +430,8 @@ static const struct of_device_id as3722_of_match[] = {
 MODULE_DEVICE_TABLE(of, as3722_of_match);
 
 static const struct i2c_device_id as3722_i2c_id[] = {
-	{ "as3722", 0 },
-	{},
+	{ "as3722" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
 
diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index b8e7ac89f697..791a0b4cb64b 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -75,18 +75,18 @@ MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
 #endif
 
 static const struct i2c_device_id axp20x_i2c_id[] = {
-	{ "axp152", 0 },
-	{ "axp192", 0 },
-	{ "axp202", 0 },
-	{ "axp209", 0 },
-	{ "axp221", 0 },
-	{ "axp223", 0 },
-	{ "axp313a", 0 },
-	{ "axp717", 0 },
-	{ "axp803", 0 },
-	{ "axp806", 0 },
-	{ "axp15060", 0 },
-	{ },
+	{ "axp152" },
+	{ "axp192" },
+	{ "axp202" },
+	{ "axp209" },
+	{ "axp221" },
+	{ "axp223" },
+	{ "axp313a" },
+	{ "axp717" },
+	{ "axp803" },
+	{ "axp806" },
+	{ "axp15060" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
 
diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
index 0a955178d469..e7c2ac74d998 100644
--- a/drivers/mfd/bd9571mwv.c
+++ b/drivers/mfd/bd9571mwv.c
@@ -268,7 +268,7 @@ static const struct of_device_id bd9571mwv_of_match_table[] = {
 MODULE_DEVICE_TABLE(of, bd9571mwv_of_match_table);
 
 static const struct i2c_device_id bd9571mwv_id_table[] = {
-	{ "bd9571mwv", 0 },
+	{ "bd9571mwv" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, bd9571mwv_id_table);
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 9a5f51b60bad..6c1981832aaf 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -54,7 +54,7 @@ static void da9055_i2c_remove(struct i2c_client *i2c)
  * and CODEC, which must be different to operate together.
  */
 static const struct i2c_device_id da9055_i2c_id[] = {
-	{"da9055-pmic", 0},
+	{ "da9055-pmic" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index c211183cecb2..c1219e608c5f 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -614,8 +614,8 @@ static void lm3533_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id lm3533_i2c_ids[] = {
-	{ "lm3533", 0 },
-	{ },
+	{ "lm3533" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm3533_i2c_ids);
 
diff --git a/drivers/mfd/lp3943.c b/drivers/mfd/lp3943.c
index 7f749a23dca8..6764553147e4 100644
--- a/drivers/mfd/lp3943.c
+++ b/drivers/mfd/lp3943.c
@@ -126,7 +126,7 @@ static int lp3943_probe(struct i2c_client *cl)
 }
 
 static const struct i2c_device_id lp3943_ids[] = {
-	{ "lp3943", 0 },
+	{ "lp3943" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp3943_ids);
diff --git a/drivers/mfd/lp873x.c b/drivers/mfd/lp873x.c
index de7ab7aed3c6..e8c5c89c2a76 100644
--- a/drivers/mfd/lp873x.c
+++ b/drivers/mfd/lp873x.c
@@ -68,8 +68,8 @@ static const struct of_device_id of_lp873x_match_table[] = {
 MODULE_DEVICE_TABLE(of, of_lp873x_match_table);
 
 static const struct i2c_device_id lp873x_id_table[] = {
-	{ "lp873x", 0 },
-	{ },
+	{ "lp873x" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp873x_id_table);
 
diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index 08c62ddfb4f5..9488d3793c10 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -106,8 +106,8 @@ static void lp87565_shutdown(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lp87565_id_table[] = {
-	{ "lp87565-q1", 0 },
-	{ },
+	{ "lp87565-q1" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp87565_id_table);
 
diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index f371eeb042e0..32f255378f5a 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -216,7 +216,7 @@ static void lp8788_remove(struct i2c_client *cl)
 }
 
 static const struct i2c_device_id lp8788_ids[] = {
-	{"lp8788", 0},
+	{ "lp8788" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp8788_ids);
diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index accf426234b6..7bac1d651771 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -300,7 +300,7 @@ MODULE_DEVICE_TABLE(of, max8907_of_match);
 #endif
 
 static const struct i2c_device_id max8907_i2c_id[] = {
-	{"max8907", 0},
+	{ "max8907" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, max8907_i2c_id);
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index 7608000488f9..556aea7ec0a0 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -127,8 +127,8 @@ EXPORT_SYMBOL(max8925_set_bits);
 
 
 static const struct i2c_device_id max8925_id_table[] = {
-	{ "max8925", 0 },
-	{ },
+	{ "max8925" },
+	{ }
 };
 
 static int max8925_dt_init(struct device_node *np, struct device *dev,
diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 662604ea97f2..4411e56d7847 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1231,7 +1231,7 @@ static void menelaus_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id menelaus_id[] = {
-	{ "menelaus", 0 },
+	{ "menelaus" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, menelaus_id);
diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index b50cfa7f4b8f..9184e553fafd 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -300,8 +300,8 @@ static void retu_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id retu_id[] = {
-	{ "retu", 0 },
-	{ "tahvo", 0 },
+	{ "retu" },
+	{ "tahvo" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, retu_id);
diff --git a/drivers/mfd/stw481x.c b/drivers/mfd/stw481x.c
index f35c3af680dd..5ed64d53c23d 100644
--- a/drivers/mfd/stw481x.c
+++ b/drivers/mfd/stw481x.c
@@ -222,8 +222,8 @@ static int stw481x_probe(struct i2c_client *client)
  * the structure of the I2C core.
  */
 static const struct i2c_device_id stw481x_id[] = {
-	{ "stw481x", 0 },
-	{ },
+	{ "stw481x" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stw481x_id);
 
diff --git a/drivers/mfd/tps6105x.c b/drivers/mfd/tps6105x.c
index 5601f6d0d874..0da1cecb5af6 100644
--- a/drivers/mfd/tps6105x.c
+++ b/drivers/mfd/tps6105x.c
@@ -191,8 +191,8 @@ static void tps6105x_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps6105x_id[] = {
-	{ "tps61050", 0 },
-	{ "tps61052", 0 },
+	{ "tps61050" },
+	{ "tps61052" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps6105x_id);
diff --git a/drivers/mfd/tps6507x.c b/drivers/mfd/tps6507x.c
index 95dafb0e9f00..9865512dc7cc 100644
--- a/drivers/mfd/tps6507x.c
+++ b/drivers/mfd/tps6507x.c
@@ -103,7 +103,7 @@ static int tps6507x_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id tps6507x_i2c_id[] = {
-	{ "tps6507x", 0 },
+	{ "tps6507x" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps6507x_i2c_id);
diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index fdce81b33f60..5ef0a7e0d61d 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -127,7 +127,7 @@ static void tps65086_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps65086_id_table[] = {
-	{ "tps65086", 0 },
+	{ "tps65086" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, tps65086_id_table);
diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index b764badaa62a..b82cd484ac85 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -225,8 +225,8 @@ static int tps65090_i2c_probe(struct i2c_client *client)
 
 
 static const struct i2c_device_id tps65090_id_table[] = {
-	{ "tps65090", 0 },
-	{ },
+	{ "tps65090" },
+	{ }
 };
 
 static struct i2c_driver tps65090_driver = {
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 03c65bbf2143..82714899efb2 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -642,8 +642,8 @@ static SIMPLE_DEV_PM_OPS(tps6586x_pm_ops, tps6586x_i2c_suspend,
 			 tps6586x_i2c_resume);
 
 static const struct i2c_device_id tps6586x_id_table[] = {
-	{ "tps6586x", 0 },
-	{ },
+	{ "tps6586x" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps6586x_id_table);
 
diff --git a/drivers/mfd/tps65912-i2c.c b/drivers/mfd/tps65912-i2c.c
index 3c5ac781b6c1..3cc1bc68be7c 100644
--- a/drivers/mfd/tps65912-i2c.c
+++ b/drivers/mfd/tps65912-i2c.c
@@ -50,7 +50,7 @@ static void tps65912_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps65912_i2c_id_table[] = {
-	{ "tps65912", 0 },
+	{ "tps65912" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, tps65912_i2c_id_table);
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 9ce34dfd99b3..c184e8bfab7c 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -817,9 +817,9 @@ static void twl6040_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id twl6040_i2c_id[] = {
-	{ "twl6040", 0, },
-	{ "twl6041", 0, },
-	{ },
+	{ "twl6040" },
+	{ "twl6041" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, twl6040_i2c_id);
 
diff --git a/drivers/mfd/wl1273-core.c b/drivers/mfd/wl1273-core.c
index e2a7fccaed01..2f185e93318e 100644
--- a/drivers/mfd/wl1273-core.c
+++ b/drivers/mfd/wl1273-core.c
@@ -13,7 +13,7 @@
 #define DRIVER_DESC "WL1273 FM Radio Core"
 
 static const struct i2c_device_id wl1273_driver_id_table[] = {
-	{ WL1273_FM_DRIVER_NAME, 0 },
+	{ WL1273_FM_DRIVER_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wl1273_driver_id_table);
diff --git a/drivers/mfd/wm8350-i2c.c b/drivers/mfd/wm8350-i2c.c
index c2a7d7069975..767c176b12a7 100644
--- a/drivers/mfd/wm8350-i2c.c
+++ b/drivers/mfd/wm8350-i2c.c
@@ -41,9 +41,9 @@ static int wm8350_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id wm8350_i2c_id[] = {
-	{ "wm8350", 0 },
-	{ "wm8351", 0 },
-	{ "wm8352", 0 },
+	{ "wm8350" },
+	{ "wm8351" },
+	{ "wm8352" },
 	{ }
 };
 
diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index ddfb234849dd..8ecfe878a5ba 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -135,7 +135,7 @@ static int wm8400_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id wm8400_i2c_id[] = {
-       { "wm8400", 0 },
+       { "wm8400" },
        { }
 };
 

base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
-- 
2.43.0


