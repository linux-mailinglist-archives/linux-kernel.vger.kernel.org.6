Return-Path: <linux-kernel+bounces-430103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD669E2CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425A5B4589F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4D71DF73E;
	Tue,  3 Dec 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Un8xzhpk"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E620A5E8;
	Tue,  3 Dec 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256040; cv=none; b=esaS7koGY2E+bmyD7jMqGmRCSHt91k0+U9cYT1wdtcQbDdiZY7DLuX27migZTq6YKPeUkf364HYlnpRO7dpYBOdbBdIL8mt1peYAZC4rU3PSABmjf8Xlz6wm3eudXA1R4fQfCcn2+h4ux0bxPnyVUEnyPmzcBnPsA8LDInXhHcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256040; c=relaxed/simple;
	bh=zvnCdofeC9LHL/sX0EVtQfU55pXgpeCL0vbtF3jErY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbI7GX03VsadFWJjJZuE9z/5UA8bTeJLTH0vro1UZSivCHmqDUysNEkk/t35FeNKL9bKkLlBnRy1jOPqKMGqVNFUZ3rYh23qyVSvkTctPld3SgNsp3ne1R34YhwUtTXVWG+BC/tfPMaSj4A5GLPz+6RCpQ3w5Z1EQy/Z1yZmKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Un8xzhpk; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K06nq114290;
	Tue, 3 Dec 2024 14:00:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256006;
	bh=Wa3jAvCZ+fz9NaH9cx1/3JYMa7DDwUh5BsQngkmA4HI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Un8xzhpkKdUCQ2mWO+VGkXSn1l6CyoSTlfuDY+V7+Z2+HhI0pyTyiX/rayOMvRC/1
	 tQPTZiaxHRu1nGQrkSUZZem3CRFeSN9skxdCB0gjJ6vJ3kvXJ4avTrXR4EUW87z0xH
	 nGhpvzaGFY5eHdNJuFCa60iN2pu/P6/oxr5BiPtY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K06Pk045840
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:06 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:05 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jb122616;
	Tue, 3 Dec 2024 14:00:04 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 07/21] ASoC: max98088: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:47 -0600
Message-ID: <20241203200001.197295-7-afd@ti.com>
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
 sound/soc/codecs/max98088.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 8915f52506953..37e61d8d4be6c 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1731,7 +1731,6 @@ MODULE_DEVICE_TABLE(i2c, max98088_i2c_id);
 static int max98088_i2c_probe(struct i2c_client *i2c)
 {
 	struct max98088_priv *max98088;
-	const struct i2c_device_id *id;
 
 	max98088 = devm_kzalloc(&i2c->dev, sizeof(struct max98088_priv),
 				GFP_KERNEL);
@@ -1747,8 +1746,7 @@ static int max98088_i2c_probe(struct i2c_client *i2c)
 		if (PTR_ERR(max98088->mclk) == -EPROBE_DEFER)
 			return PTR_ERR(max98088->mclk);
 
-	id = i2c_match_id(max98088_i2c_id, i2c);
-	max98088->devtype = id->driver_data;
+	max98088->devtype = (uintptr_t)i2c_get_match_data(i2c);
 
 	i2c_set_clientdata(i2c, max98088);
 	max98088->pdata = i2c->dev.platform_data;
-- 
2.39.2


