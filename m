Return-Path: <linux-kernel+bounces-430109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D89E2E1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A79B46CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91E820B808;
	Tue,  3 Dec 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dx9CyQRg"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307418FC91;
	Tue,  3 Dec 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256042; cv=none; b=RYqCxfI0B5Jwcx20/ncTuBtBTNIoEmaCE23FGJuRtrB0oYsHSYEvBs0YbtZITPhORPiaMtDBk8d/JJP0q50nHXQGI9iTQ3C/C8g7IN/9Kl1VLw73CkYXEvCXnl5nndflHG7KP1S3KarQ76p5LvVtjXf2Prc18MVHnMtJeHJ25D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256042; c=relaxed/simple;
	bh=4C3/OEvhnC35KoVHeykoD3L+vw3BLbZSJonpse2YmR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtJejpuq0cQcMxKkkJlMAbZf03qXZWzdk4C0KJ53Rv0rsybXYNm5SuMYN3aLuKaHiv6+fKrvXkwvoV/v2cHo03QnlDYVeWoII2nU5xNtmEMbaFgmq+xjZWTgJdKfeoBRWLCfMjSSWWM/gtPZx1GrL555QZmhyXW+0jKCryefT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dx9CyQRg; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K08X11933806
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Dec 2024 14:00:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256008;
	bh=qIpNvcwb6jGE4JnEYwnRpJQr4L5g98mEzuVOATTEvz8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Dx9CyQRgo6ZSXaoJuz4g34QRfWdOUULbtr5adzg3AjLI1kXQdtIp6wrVlKM6h1vA6
	 purdIMCl2/trKEUyeG9CR+S2j7UKN4Wn8A7O2JSUNTfawlpYNvKdRJelBUe4OjO/Ve
	 E2XieHrq47FAmFG0WTsI3PQUDKrbZpBGAPsrFFjs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K07b0029168;
	Tue, 3 Dec 2024 14:00:07 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:07 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Ji122616;
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
Subject: [PATCH 14/21] ASoC: tas2781: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:54 -0600
Message-ID: <20241203200001.197295-14-afd@ti.com>
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
 sound/soc/codecs/tas2781-i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index e41f81eb8d16c..5e59b80fe0082 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -1663,7 +1663,6 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 
 static int tasdevice_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_match_id(tasdevice_id, i2c);
 	const struct acpi_device_id *acpi_id;
 	struct tasdevice_priv *tas_priv;
 	int ret;
@@ -1685,7 +1684,7 @@ static int tasdevice_i2c_probe(struct i2c_client *i2c)
 		tas_priv->chip_id = acpi_id->driver_data;
 		tas_priv->isacpi = true;
 	} else {
-		tas_priv->chip_id = id ? id->driver_data : 0;
+		tas_priv->chip_id = (uintptr_t)i2c_get_match_data(i2c);
 		tas_priv->isacpi = false;
 	}
 
-- 
2.39.2


