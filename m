Return-Path: <linux-kernel+bounces-430118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9069E2E13
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34B1B6046A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF02204F62;
	Tue,  3 Dec 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DcmOgOyF"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7820C014;
	Tue,  3 Dec 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256047; cv=none; b=AY/xRIkHo0A4TrHGtsxjhf3LUfYzWk9Nfi7mbreOae6BAV5hd4S+OJgMnZ8GxW1K7H0ypB1qJyVXe4hgMKbnnXY9oS8wcG4/Hnik9Rlq5ogfPYeCjpmr/RWck6ZeyI07EsY1he/fgXjwIgmMTkK3XfQPRGuUpEhMQPEYY8dvLWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256047; c=relaxed/simple;
	bh=pBPBqV3WqbSLCDSdSCJb9zPbMTHjchwdbDJbDugXH+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6hSRnhe87atjliyYKIEJD8HL1enVoQhrnXyYbBLoKPUnVKb6JsvTMrOdFq3A0ZusKiDQPCBrBIWMYmuiI9ySPuafD10r/5FFKwfE7YAekLnjqypqNtT+hpDhz9o+F47+4yifxH7KioHB9utYVRXVZHFGtLugCSSW0q2hTOgLek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DcmOgOyF; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K06mT1680008
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256006;
	bh=ajI/85hhx3e3h7PUVzg/SB0v86K9q+hy9AhlIg9QwaA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DcmOgOyFsvdoBNBOmoQADUA+u4xD0g8Csv+xEGEh43VPw8IohHYYQHDO0ns4S1wqp
	 uHzTYAz5N5gE9h4L8E4YERt84vTTSPtcxEdr4LjO6LRMEV9AO89ruQQAoWuFA+tyGH
	 OBeydViXA2NH75MVhrLWtTTjeGbdCSAv9u8faF/c=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K05gM030820
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:06 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:04 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02JY122616;
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
Subject: [PATCH 04/21] ASoC: adau1977: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:44 -0600
Message-ID: <20241203200001.197295-4-afd@ti.com>
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
 sound/soc/codecs/adau1977-i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/adau1977-i2c.c b/sound/soc/codecs/adau1977-i2c.c
index 24c7b9c84c198..441c8079246a4 100644
--- a/sound/soc/codecs/adau1977-i2c.c
+++ b/sound/soc/codecs/adau1977-i2c.c
@@ -14,12 +14,9 @@
 
 #include "adau1977.h"
 
-static const struct i2c_device_id adau1977_i2c_ids[];
-
 static int adau1977_i2c_probe(struct i2c_client *client)
 {
 	struct regmap_config config;
-	const struct i2c_device_id *id = i2c_match_id(adau1977_i2c_ids, client);
 
 	config = adau1977_regmap_config;
 	config.val_bits = 8;
@@ -27,7 +24,7 @@ static int adau1977_i2c_probe(struct i2c_client *client)
 
 	return adau1977_probe(&client->dev,
 		devm_regmap_init_i2c(client, &config),
-		id->driver_data, NULL);
+		(uintptr_t)i2c_get_match_data(client), NULL);
 }
 
 static const struct i2c_device_id adau1977_i2c_ids[] = {
-- 
2.39.2


