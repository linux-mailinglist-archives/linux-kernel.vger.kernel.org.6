Return-Path: <linux-kernel+bounces-529806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DD7A42B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDD07A50AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCDA266B46;
	Mon, 24 Feb 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="BQR8h4qZ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E1265CBF;
	Mon, 24 Feb 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421276; cv=none; b=p3I+MxbEmGDvHSKmizrZuwckSQy8FqKac3/ZU82X/ZrSJfkDcj8dXQj6UqIV8KgugfkC6o56nxALFKUvbK4oyn0lIrpZyAZZ5ADkdCEDeLXrveSqrkL3JXBJTl3FdtzNlorJ26j9OpVaDHgguWVohEhhtBBsJ5VQe1q7Z3zIlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421276; c=relaxed/simple;
	bh=DCXTAXYVaCDoehjsFSI9JGthYW2HgxuvBibu7CR934I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2pl3u0eB+giEQBTfXA5FzoxhXoLmG8VKyRYvHQsyt8yyRtahZH1GybXJXPxpNTjzZOeORdwaus63AslWN0ht7h56OdWOScI3WHUQhpzr0Kk5TMrEn5/vI7UDJn8tvs6o+IFpjlW7Ooe/X3eEDOwHfxs77APyA60Yz2J82PsrEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=BQR8h4qZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 31F111FBD4;
	Mon, 24 Feb 2025 19:08:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740420486;
	bh=C7U4HwlepaLvGf1mVinelge72wt+sVgO2WNDILODsR0=; h=From:To:Subject;
	b=BQR8h4qZ9ROPMhDIlNvrQ+RrB3mQKBzFKlMUHECmKM6plkdai1b9GBE+P333oXAxE
	 SNH+uN+MRoHMHQlB1hA3gDj+vrAMN0l9G4uQhLlKOoaFoPCLE/+PBGO/1wFFnMGwMA
	 p3pV/0uLeD6vLcCtdeJcajDtcCOV00tu6agYAlx0BlGV8QUsKA5vjvyiWyOp/ZDClO
	 9cwmuGjrXOmoP0zK1s3qaft9B7HZAzNqKB24Be5kYpzU70lEqGSJ84fOoJP0Fbp0xG
	 fDBKVa+PXfwGw6994eXRqE/xiP1S6pMUbsFVztX7A6o7x9HW4eBHftub1Z5PbSZjya
	 8PpAoDm8pkI6A==
From: Francesco Dolcini <francesco@dolcini.it>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (amc6821) Add PWM polarity configuration with OF
Date: Mon, 24 Feb 2025 19:08:01 +0100
Message-Id: <20250224180801.128685-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224180801.128685-1-francesco@dolcini.it>
References: <20250224180801.128685-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add support to configure the PWM-Out pin polarity based on a device
tree property.

The driver has a module option to set the PWM polarity (normal=0,
inverted=1), when specified it always takes the precedence over the DT
configuration.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: pwminv module parameter takes always the precedence over the DT property
v1: https://lore.kernel.org/all/20250218165633.106867-3-francesco@dolcini.it/
---
 drivers/hwmon/amc6821.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 1e3c6acd8974..317741995df2 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -37,7 +37,7 @@ static const unsigned short normal_i2c[] = {0x18, 0x19, 0x1a, 0x2c, 0x2d, 0x2e,
  * Insmod parameters
  */
 
-static int pwminv;	/*Inverted PWM output. */
+static int pwminv = -1; /*Inverted PWM output. */
 module_param(pwminv, int, 0444);
 
 static int init = 1; /*Power-on initialization.*/
@@ -845,9 +845,10 @@ static int amc6821_detect(struct i2c_client *client, struct i2c_board_info *info
 	return 0;
 }
 
-static int amc6821_init_client(struct amc6821_data *data)
+static int amc6821_init_client(struct i2c_client *client, struct amc6821_data *data)
 {
 	struct regmap *regmap = data->regmap;
+	u32 regval;
 	int err;
 
 	if (init) {
@@ -864,11 +865,15 @@ static int amc6821_init_client(struct amc6821_data *data)
 		if (err)
 			return err;
 
+		regval = AMC6821_CONF1_START;
+		if ((pwminv < 0 && of_property_read_bool(client->dev.of_node, "ti,pwm-inverted")) ||
+		    pwminv > 0)
+			regval |= AMC6821_CONF1_PWMINV;
+
 		err = regmap_update_bits(regmap, AMC6821_REG_CONF1,
 					 AMC6821_CONF1_THERMOVIE | AMC6821_CONF1_FANIE |
 					 AMC6821_CONF1_START | AMC6821_CONF1_PWMINV,
-					 AMC6821_CONF1_START |
-					 (pwminv ? AMC6821_CONF1_PWMINV : 0));
+					 regval);
 		if (err)
 			return err;
 	}
@@ -916,7 +921,7 @@ static int amc6821_probe(struct i2c_client *client)
 				     "Failed to initialize regmap\n");
 	data->regmap = regmap;
 
-	err = amc6821_init_client(data);
+	err = amc6821_init_client(client, data);
 	if (err)
 		return err;
 
-- 
2.39.5


