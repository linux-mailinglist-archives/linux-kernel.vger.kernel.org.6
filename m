Return-Path: <linux-kernel+bounces-430110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4889E2C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D90166C26
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7B920C022;
	Tue,  3 Dec 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lLtij/M7"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E820ADE6;
	Tue,  3 Dec 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256044; cv=none; b=h0kE3jlkjyLTDQaqNJ7QY2tLjd5vilZlfssZ4fLSrst2reTUNHPGm+8Vd7tkWww1zzKu88c7MQ2S1we/cYSf3ilNgBo5jKUw18r55YdLh+cdkFO32pyTm43/Pb8Dp5KotmlYPWHXQ4n8vLOoJp6IUp9KgcTVAezA7xQikf6FLcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256044; c=relaxed/simple;
	bh=SfyS9rLrBDgisyfoZV78ydFswRPw/M4mCZzBMG/X7Gw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCzpdgNSpqUFod9wXNCs3LSYI9HAy2Baa/9SyAbMXNO7TYz5MNwqiZas8QXVD+s3dqRgxqtvRZos6CcyBiN5daFj6o3QvsX5l17vqcfduEpwlyb8WKftC+SC0MlpXiqzqaaHOsXP8e1tdh7ZeOvmX5ra79d2oWNXvn1kg0CEAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lLtij/M7; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K09I0114310;
	Tue, 3 Dec 2024 14:00:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256009;
	bh=GH32qWK+cI1v1G+fMV3AGBkKrmgD5DhQifqsl4mIi80=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lLtij/M7HYytn7dZwaR2l9D+qNehtq+0ver6iMRwKB9TNJOB6Cvxap+3n0myVUZln
	 ZT37CS5cu35gg+OCjCus2jKJ/omi4Tu7b1VGdtpZdejn4O4N6cJ2KczZJjkFwNed/D
	 H1hlcSlo6myLT3CzdpIsHGfLYfdZDt6TnDHdzfn0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K09xE031612
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:09 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:09 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jm122616;
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
Subject: [PATCH 18/21] ASoC: tlv320aic3x: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:58 -0600
Message-ID: <20241203200001.197295-18-afd@ti.com>
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
 sound/soc/codecs/tlv320aic3x-i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x-i2c.c b/sound/soc/codecs/tlv320aic3x-i2c.c
index bb33fd3dfb4f0..0b585925c1ac4 100644
--- a/sound/soc/codecs/tlv320aic3x-i2c.c
+++ b/sound/soc/codecs/tlv320aic3x-i2c.c
@@ -31,14 +31,13 @@ static int aic3x_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap *regmap;
 	struct regmap_config config;
-	const struct i2c_device_id *id = i2c_match_id(aic3x_i2c_id, i2c);
 
 	config = aic3x_regmap;
 	config.reg_bits = 8;
 	config.val_bits = 8;
 
 	regmap = devm_regmap_init_i2c(i2c, &config);
-	return aic3x_probe(&i2c->dev, regmap, id->driver_data);
+	return aic3x_probe(&i2c->dev, regmap, (uintptr_t)i2c_get_match_data(i2c));
 }
 
 static void aic3x_i2c_remove(struct i2c_client *i2c)
-- 
2.39.2


