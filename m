Return-Path: <linux-kernel+bounces-430108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEAD9E2C9B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58B6287486
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6520B7FD;
	Tue,  3 Dec 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cbBmXjvE"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AD20ADCC;
	Tue,  3 Dec 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256043; cv=none; b=alpmboisCBC0FqVrJH4W34k0usuPBr62v4VlNrVHmiRSXEDwLAXgYfzjiv23s0OzQT6ktD+AMg/yeAMQth7BrZPDASIYBpS9cZlTpTvBHZ7RmlxgM4lOSYRaEbIa5h1k76svHC0aO980CC0SmHol+vqyCZvfeWWB70RG3QKNGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256043; c=relaxed/simple;
	bh=/reGmiVcoFoW+iOFVg5yUIZlQjoQQ0kLTcAdMkhWZ60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erCA1b3brHW7ouU4jqBK2CzPYtblDHlNWk8QQCVHxFND7EE0C/0j3f7GFab7NVcuoqplXjS9JVZ08Sock0FAuqZaYyowpF1Hm/2Yx29oPrPjbznXKjuvc5PZ5F8adf57HfwTE6/qyjOic8YjY8WrZagVX+3IQic3IejjQz1Tkss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cbBmXjvE; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K08Of1663523
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256008;
	bh=jMIIPCjH7YfqmRfUtf4RCBtjYbT4tmILPs6bVaWPSXA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cbBmXjvEIsU5Zz/oVJlEDAMoTYTxi5D9I1g/zn7hrb+NKaZse5sNPb/XMfxDDDP/H
	 DebaTnhnsUqte5BdmA7ywfv57TvY6VOdumBWiS11fJ2F5VdQgJGP/3ELFOgLXFyk6D
	 UcOgvY/32afH6gLCDyI01ZPYDcrGsuATqWbZo8Rg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K08tM035218
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:08 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:08 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jk122616;
	Tue, 3 Dec 2024 14:00:08 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 16/21] ASoC: tlv320adc3xxx: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:56 -0600
Message-ID: <20241203200001.197295-16-afd@ti.com>
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
 sound/soc/codecs/tlv320adc3xxx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index 868e8a91e05b3..1a50ff6752441 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -1401,7 +1401,6 @@ static int adc3xxx_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct adc3xxx *adc3xxx = NULL;
-	const struct i2c_device_id *id;
 	int ret;
 
 	adc3xxx = devm_kzalloc(dev, sizeof(struct adc3xxx), GFP_KERNEL);
@@ -1466,8 +1465,7 @@ static int adc3xxx_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, adc3xxx);
 
-	id = i2c_match_id(adc3xxx_i2c_id, i2c);
-	adc3xxx->type = id->driver_data;
+	adc3xxx->type = (uintptr_t)i2c_get_match_data(i2c);
 
 	/* Reset codec chip */
 	gpiod_set_value_cansleep(adc3xxx->rst_pin, 1);
-- 
2.39.2


