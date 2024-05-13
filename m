Return-Path: <linux-kernel+bounces-177318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1958C3CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297331F21CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB264146D56;
	Mon, 13 May 2024 08:05:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D86146D50
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587538; cv=none; b=HUbjaRe2XPKI/xHU+Rz861N852UZvS62MTmhOSr+Sa9dz3mEWKOczpV6I7ElS7v2IDXl1g/ZPPJoekad89iFdBJ3ywtUey+Bo9ZmXMeeBN4+3E/RCMHaDEqzC4cw38HKgPcnwCRnxkL7QhErH2OqWhOJoSAJZsg1ToceGrtjA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587538; c=relaxed/simple;
	bh=fbAGScRhVQHSB6uzeuUiqvEOgLOrxU0SyVLG4IG4kcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QpOCyVmotviA2WaSEEqJZgumfs1S9hvacUPODUPXYpbpyK4x/stmjzmnsFGBkSymFHapeQf/1xOzQrtCbMoUxFrLviN3ClMsPDxLbi+3FT8Z+bCHC9HflhLBF6lj+4Bx8cWUUsblGNcSuRVPOldQds2MK7q056wmZ1LRpxA9/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s6Qgf-0001zw-3x; Mon, 13 May 2024 10:05:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s6Qge-001851-Mj; Mon, 13 May 2024 10:05:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s6Qge-003CrH-1w;
	Mon, 13 May 2024 10:05:32 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] regulator: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Mon, 13 May 2024 10:05:26 +0200
Message-ID: <20240513080525.2353168-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9909; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fbAGScRhVQHSB6uzeuUiqvEOgLOrxU0SyVLG4IG4kcA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmQcnGk4c6n+sJdkwYHH0jL0h6/Ec20qU0t7hPJ cOXf0lRDgaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZkHJxgAKCRCPgPtYfRL+ TqWsCACnO5VXsISoC9nEPCVARLqOgmo9Fgh0BCQBZmmQoq07TW4y3tTPkih9IJXGrVnA8TaOYqd 5vw5b2HJsB8MK75tQiYpZ+858c21mA35u2f/ubvBNfnHTcGjX/PQrlbSnDSTlGSffCB0k5goR1g 8cooZoCYS+5mFBA255gGjsPKJ+hQT+g82akS2+vBrKp0bxrISDqMbo1snSRPuBnGzjCtbbNJYfX 0CWrYSZUpz8K3BJXyeIWbzLj5Y2gzVrA0utYWxEGqXR28ltNxIlB9GtOa0/RP3w0hnbZ3QX/wb5 2NIa2EDk9DDLLQd4N1++eXdJkdFVNfsNRjnAlBDAhcaa54U6
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
 drivers/regulator/da9210-regulator.c   |  4 ++--
 drivers/regulator/lp3971.c             |  2 +-
 drivers/regulator/lp3972.c             |  2 +-
 drivers/regulator/lp8755.c             |  2 +-
 drivers/regulator/max1586.c            |  2 +-
 drivers/regulator/max20411-regulator.c |  4 ++--
 drivers/regulator/max8649.c            |  2 +-
 drivers/regulator/max8893.c            |  4 ++--
 drivers/regulator/max8952.c            |  4 ++--
 drivers/regulator/mcp16502.c           |  2 +-
 drivers/regulator/mt6311-regulator.c   |  4 ++--
 drivers/regulator/pf8x00-regulator.c   |  8 ++++----
 drivers/regulator/pv88060-regulator.c  |  4 ++--
 drivers/regulator/pv88090-regulator.c  |  4 ++--
 drivers/regulator/slg51000-regulator.c |  4 ++--
 drivers/regulator/sy8106a-regulator.c  |  4 ++--
 drivers/regulator/tps6286x-regulator.c | 10 +++++-----
 drivers/regulator/tps6287x-regulator.c | 10 +++++-----
 18 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 02b85ca4a6fc..39ade0dba40f 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -202,8 +202,8 @@ static int da9210_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id da9210_i2c_id[] = {
-	{"da9210", 0},
-	{},
+	{ "da9210" },
+	{}
 };
 
 MODULE_DEVICE_TABLE(i2c, da9210_i2c_id);
diff --git a/drivers/regulator/lp3971.c b/drivers/regulator/lp3971.c
index e1b5c45f97f4..d4dab86fe385 100644
--- a/drivers/regulator/lp3971.c
+++ b/drivers/regulator/lp3971.c
@@ -439,7 +439,7 @@ static int lp3971_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id lp3971_i2c_id[] = {
-	{ "lp3971", 0 },
+	{ "lp3971" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp3971_i2c_id);
diff --git a/drivers/regulator/lp3972.c b/drivers/regulator/lp3972.c
index 7bd6f05edd8d..1b918fb72134 100644
--- a/drivers/regulator/lp3972.c
+++ b/drivers/regulator/lp3972.c
@@ -537,7 +537,7 @@ static int lp3972_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id lp3972_i2c_id[] = {
-	{ "lp3972", 0 },
+	{ "lp3972" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp3972_i2c_id);
diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 8d01e18046f3..5509bee49bda 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -430,7 +430,7 @@ static void lp8755_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lp8755_id[] = {
-	{LP8755_NAME, 0},
+	{ LP8755_NAME },
 	{}
 };
 
diff --git a/drivers/regulator/max1586.c b/drivers/regulator/max1586.c
index 0f133129252e..4242fbb7b147 100644
--- a/drivers/regulator/max1586.c
+++ b/drivers/regulator/max1586.c
@@ -276,7 +276,7 @@ static int max1586_pmic_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max1586_id[] = {
-	{ "max1586", 0 },
+	{ "max1586" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max1586_id);
diff --git a/drivers/regulator/max20411-regulator.c b/drivers/regulator/max20411-regulator.c
index 8c09dc71b16d..ce430c925c71 100644
--- a/drivers/regulator/max20411-regulator.c
+++ b/drivers/regulator/max20411-regulator.c
@@ -145,8 +145,8 @@ static const struct of_device_id of_max20411_match_tbl[] = {
 MODULE_DEVICE_TABLE(of, of_max20411_match_tbl);
 
 static const struct i2c_device_id max20411_id[] = {
-	{ "max20411", 0 },
-	{ },
+	{ "max20411" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max20411_id);
 
diff --git a/drivers/regulator/max8649.c b/drivers/regulator/max8649.c
index 24e1dfba78c8..f57c588bcf28 100644
--- a/drivers/regulator/max8649.c
+++ b/drivers/regulator/max8649.c
@@ -240,7 +240,7 @@ static int max8649_regulator_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max8649_id[] = {
-	{ "max8649", 0 },
+	{ "max8649" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max8649_id);
diff --git a/drivers/regulator/max8893.c b/drivers/regulator/max8893.c
index 30592425e193..5a90633d8536 100644
--- a/drivers/regulator/max8893.c
+++ b/drivers/regulator/max8893.c
@@ -162,8 +162,8 @@ MODULE_DEVICE_TABLE(of, max8893_dt_match);
 #endif
 
 static const struct i2c_device_id max8893_ids[] = {
-	{ "max8893", 0 },
-	{ },
+	{ "max8893" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max8893_ids);
 
diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index 0b0b841d214a..1f94315bfb02 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -307,8 +307,8 @@ static int max8952_pmic_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max8952_ids[] = {
-	{ "max8952", 0 },
-	{ },
+	{ "max8952" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max8952_ids);
 
diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 0c15a19fe83a..5de9d4fa5113 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -577,7 +577,7 @@ static const struct dev_pm_ops mcp16502_pm_ops = {
 };
 #endif
 static const struct i2c_device_id mcp16502_i2c_id[] = {
-	{ "mcp16502", 0 },
+	{ "mcp16502" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp16502_i2c_id);
diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index c00638cd2d1e..2ebc1c0b5e6f 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -133,8 +133,8 @@ static int mt6311_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id mt6311_i2c_id[] = {
-	{"mt6311", 0},
-	{},
+	{ "mt6311" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, mt6311_i2c_id);
 
diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 9fd8e0949b32..ea3611de42b4 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -596,10 +596,10 @@ static const struct of_device_id pf8x00_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, pf8x00_dt_ids);
 
 static const struct i2c_device_id pf8x00_i2c_id[] = {
-	{ "pf8100", 0 },
-	{ "pf8121a", 0 },
-	{ "pf8200", 0 },
-	{},
+	{ "pf8100" },
+	{ "pf8121a" },
+	{ "pf8200" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, pf8x00_i2c_id);
 
diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index aa90360fa046..ae1c4b9daaa1 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -360,8 +360,8 @@ static int pv88060_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id pv88060_i2c_id[] = {
-	{"pv88060", 0},
-	{},
+	{ "pv88060" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, pv88060_i2c_id);
 
diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index f4acde4d56c8..3c48757bbbda 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -381,8 +381,8 @@ static int pv88090_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id pv88090_i2c_id[] = {
-	{"pv88090", 0},
-	{},
+	{ "pv88090" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, pv88090_i2c_id);
 
diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 59aa16825d8a..3bbd4a29e6d3 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -497,8 +497,8 @@ static int slg51000_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id slg51000_i2c_id[] = {
-	{"slg51000", 0},
-	{},
+	{ "slg51000" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, slg51000_i2c_id);
 
diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy8106a-regulator.c
index 1bcfdd6dcfc1..d79a4cc25a0d 100644
--- a/drivers/regulator/sy8106a-regulator.c
+++ b/drivers/regulator/sy8106a-regulator.c
@@ -130,8 +130,8 @@ static const struct of_device_id sy8106a_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, sy8106a_i2c_of_match);
 
 static const struct i2c_device_id sy8106a_i2c_id[] = {
-	{ "sy8106a", 0 },
-	{ },
+	{ "sy8106a" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sy8106a_i2c_id);
 
diff --git a/drivers/regulator/tps6286x-regulator.c b/drivers/regulator/tps6286x-regulator.c
index 758c70269653..67e4c8d316d9 100644
--- a/drivers/regulator/tps6286x-regulator.c
+++ b/drivers/regulator/tps6286x-regulator.c
@@ -136,11 +136,11 @@ static int tps6286x_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id tps6286x_i2c_id[] = {
-	{ "tps62864", 0 },
-	{ "tps62866", 0 },
-	{ "tps62868", 0 },
-	{ "tps62869", 0 },
-	{},
+	{ "tps62864" },
+	{ "tps62866" },
+	{ "tps62868" },
+	{ "tps62869" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, tps6286x_i2c_id);
 
diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index 9b7c3d77789e..8e4d44e2b1af 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -164,11 +164,11 @@ static const struct of_device_id tps6287x_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, tps6287x_dt_ids);
 
 static const struct i2c_device_id tps6287x_i2c_id[] = {
-	{ "tps62870", 0 },
-	{ "tps62871", 0 },
-	{ "tps62872", 0 },
-	{ "tps62873", 0 },
-	{},
+	{ "tps62870" },
+	{ "tps62871" },
+	{ "tps62872" },
+	{ "tps62873" },
+	{}
 };
 
 MODULE_DEVICE_TABLE(i2c, tps6287x_i2c_id);

base-commit: 6ba6c795dc73c22ce2c86006f17c4aa802db2a60
-- 
2.43.0


