Return-Path: <linux-kernel+bounces-430097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F299E2DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A70B2AB7F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3028A1F4265;
	Tue,  3 Dec 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FCQJYf7F"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206118B463;
	Tue,  3 Dec 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256031; cv=none; b=nWh3ZkWdhGlYmgFI9tASoCzoS8O/Xsk9o8lYwJg035mcxMpuFs/f+OT0zVQNhWQdqyxHOnY7+CRkGde4vt8+iEUrsdn/usYefvmM/YOJOqAv2rfNx4KqfBcwVVju1GiLlHOQEbk/EK7D1Fa37REd5J6te4mTbD0ZcMslOcSzVoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256031; c=relaxed/simple;
	bh=la7glOnBz+PZ53/CC+OZYT/8aU0F33191sqWA+4HsEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suq6V6DFpGS6XNI10v6VfOSXPga+gKS37aw9mX2tGTSJ4UJG1t6I2mbaMmTLkroqGRK6txEUl7wUX55suT4C+V+1N16A5eAkC7RveX4NrNybiDDuGV5kn+usVIVwFC9g1L7/VQJiwuwuaw6Zyzja0QE8LqDj8KhuKZ7r3bT9RBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FCQJYf7F; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K04xL042126;
	Tue, 3 Dec 2024 14:00:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256004;
	bh=x7tOxLWZU+K20aLeJNLT1isDRM0WsRVvZHzRccrpDIU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FCQJYf7FDUgEca4aUz6squuShJyJbS4a/hqXRWVAMc+HrK0QBG6e1TT4sKfPgZA5B
	 WbDzZKgrvYSthM/BXLwYEvOHN35WuP7uCNxDGR8a4TTEvjcGByvTvW4oTPRHwb3hz6
	 si/jz5FQA6z7w54zL1ZowcOG+CtdrE8vEpmSDSLQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K049D045340
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:04 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:03 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02JX122616;
	Tue, 3 Dec 2024 14:00:03 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 03/21] ASoC: adau1781: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:43 -0600
Message-ID: <20241203200001.197295-3-afd@ti.com>
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
 sound/soc/codecs/adau1781-i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/adau1781-i2c.c b/sound/soc/codecs/adau1781-i2c.c
index 3a170fd78ff32..cb67fde8d9a84 100644
--- a/sound/soc/codecs/adau1781-i2c.c
+++ b/sound/soc/codecs/adau1781-i2c.c
@@ -14,12 +14,9 @@
 
 #include "adau1781.h"
 
-static const struct i2c_device_id adau1781_i2c_ids[];
-
 static int adau1781_i2c_probe(struct i2c_client *client)
 {
 	struct regmap_config config;
-	const struct i2c_device_id *id = i2c_match_id(adau1781_i2c_ids, client);
 
 	config = adau1781_regmap_config;
 	config.val_bits = 8;
@@ -27,7 +24,7 @@ static int adau1781_i2c_probe(struct i2c_client *client)
 
 	return adau1781_probe(&client->dev,
 		devm_regmap_init_i2c(client, &config),
-		id->driver_data, NULL);
+		(uintptr_t)i2c_get_match_data(client), NULL);
 }
 
 static void adau1781_i2c_remove(struct i2c_client *client)
-- 
2.39.2


