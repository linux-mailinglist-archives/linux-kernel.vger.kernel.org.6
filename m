Return-Path: <linux-kernel+bounces-430117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6019E2CA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C85164F1D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A5220D4E2;
	Tue,  3 Dec 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kmCIJATe"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075D20C00F;
	Tue,  3 Dec 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256047; cv=none; b=Yk5qMmGdL1DC6VVM+uloBTs1cRNA/6ijFoE4fo8c+a2QTaap0ZKv2uY+DiktgLH71ieZBdfFqKhi9ZimtViSgy3GKLfxcGV215q+zN99+K+SE/Y617a/LmN0XDE9Jtb8RhBRsP8C1jwnebjD4h0jk5UFoj1Qv5KpPWASGky7Aww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256047; c=relaxed/simple;
	bh=wpmkO7KYouUIorXZORPjHUHr4D4SGVkwMfMf6qZ59aM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPBZ2XtA3XR1J9h093QsnUNjsRYWx4O9dHtaB5hhzhsGkSBwWhzW+hVizBCLOAOTKlsFHIrhgLz84GtlhDlz5w274l4aDenXGUOuNg3qPRZ0VdExlHsj4yC85E0nKrprOQ7lduFbakCOkn8mracAPLKgqOCO3EVOaL3mVXscSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kmCIJATe; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K08W11495079
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256008;
	bh=96I7rxAMRRbMfkQkrInudpFR8oS/gJ4EZ6PrVdIxWtE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kmCIJATec9Wd9PyKZZSySCIiLtAK4jM71NLqw7OV3I99jif83tzSFubpjIa0yqDYo
	 0Cwo7khNeEg7uNhrT6T5zwnz4J6Bjwa+ONqfmUzcfASf67FPGT9h9K9q1ND+A0xK0v
	 2znvOuAToM5AbuP6MdNAuwyZziPXPT6HiNGSDL7E=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K08Bv046020
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:08 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:08 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jj122616;
	Tue, 3 Dec 2024 14:00:07 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 15/21] ASoC: tas5720: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:55 -0600
Message-ID: <20241203200001.197295-15-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203200001.197295-1-afd@ti.com>
References: <20241203200001.197295-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The function i2c_match_id() is used to fetch the matching ID from
the i2c_device_id table. This is often used to then retrieve the
matching driver_data. This can be done in one step with the helper
i2c_get_match_data().

This helper has a couple other benefits:
 * It doesn't need the i2c_device_id passed in so we do not need
   to have that forward declared, allowing us to remove those or
   move the i2c_device_id table down to its more natural spot
   with the other module info.
 * It also checks for device match data, which allows for OF and
   ACPI based probing. That means we do not have to manually check
   those first and can remove those checks.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 sound/soc/codecs/tas5720.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index 6dd6c0896efff..f0361822061fd 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -43,7 +43,6 @@ static const char * const tas5720_supply_names[] = {
 struct tas5720_data {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
-	struct i2c_client *tas5720_client;
 	enum tas572x_type devtype;
 	struct regulator_bulk_data supplies[TAS5720_NUM_SUPPLIES];
 	struct delayed_work fault_check_work;
@@ -729,7 +728,6 @@ static int tas5720_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct tas5720_data *data;
 	const struct regmap_config *regmap_config;
-	const struct i2c_device_id *id;
 	int ret;
 	int i;
 
@@ -737,11 +735,9 @@ static int tas5720_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	id = i2c_match_id(tas5720_id, client);
-	data->tas5720_client = client;
-	data->devtype = id->driver_data;
+	data->devtype = (uintptr_t)i2c_get_match_data(client);
 
-	switch (id->driver_data) {
+	switch (data->devtype) {
 	case TAS5720:
 		regmap_config = &tas5720_regmap_config;
 		break;
@@ -774,7 +770,7 @@ static int tas5720_probe(struct i2c_client *client)
 
 	dev_set_drvdata(dev, data);
 
-	switch (id->driver_data) {
+	switch (data->devtype) {
 	case TAS5720:
 		ret = devm_snd_soc_register_component(&client->dev,
 					&soc_component_dev_tas5720,
-- 
2.39.2


