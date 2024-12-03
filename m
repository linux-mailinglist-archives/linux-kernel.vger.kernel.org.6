Return-Path: <linux-kernel+bounces-430101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB51F9E2C92
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00116167B68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E1B207A3E;
	Tue,  3 Dec 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kpYcKbTe"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755191F9AAC;
	Tue,  3 Dec 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256034; cv=none; b=GRfMVUsp1uuZqefCfzW6K445d8C1iQXfMSeNgUmDCeWumgZ78/ISrsL0karRsD8K4t9fl8Lv4vPsLbsc3CUDb3Dz/iTxLiyQKYyfL3IdMd6ND1xF5hqidkyDKuAnc86988Y4X1hwxSeThz9SF2ZRTfNsw4sNKrbuPUepY/ZUsc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256034; c=relaxed/simple;
	bh=NjYejlU8rKviM5a74ukuEGuTQ2jgtoXaeTvllB9WGXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kal9krme0yPzv9ZNHllyU5ZuY0e0NcNxy3FCTw4XF8ezd76T1/qtUJ52c7bbmJCc0HtAEk63qKcuf8RlJYRywbKy/5bWVj/8o9TBjoL461dLjCNF2ml3Wp1uBBNTGdX/TMUI31Sm0wrvT0qCB/GF46MUDk/NlULy78kpQMKuFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kpYcKbTe; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K09QU1495083
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256009;
	bh=cD4n/pK3P519jlcYhx03bw9eImxMjHvApEMPBSWocJc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kpYcKbTeINn7bXP8J0AVUVWU2aTRaSaUTBObR2i0uqRPEe7yVQtauRWRGZguycxY1
	 axe/MyqJkSIQzfoKWLBqbIbI5VesxVqB9QYqrWRzJ7NYzjZu7afUSMA27HISMnBSfx
	 xsoXW3uSj7hJjeufGuQcTheKR00Z2GWIqHksoc40=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K09ED035233
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:09 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:08 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jl122616;
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
Subject: [PATCH 17/21] ASoC: tlv320aic31xx: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:57 -0600
Message-ID: <20241203200001.197295-17-afd@ti.com>
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
 sound/soc/codecs/tlv320aic31xx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d81ab9c25c29e..4b3f9128ec37e 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1736,12 +1736,8 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c)
 {
 	struct aic31xx_priv *aic31xx;
 	unsigned int micbias_value = MICBIAS_2_0V;
-	const struct i2c_device_id *id = i2c_match_id(aic31xx_i2c_id, i2c);
 	int i, ret;
 
-	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
-		id->name, (int)id->driver_data);
-
 	aic31xx = devm_kzalloc(&i2c->dev, sizeof(*aic31xx), GFP_KERNEL);
 	if (!aic31xx)
 		return -ENOMEM;
@@ -1758,7 +1754,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c)
 	aic31xx->dev = &i2c->dev;
 	aic31xx->irq = i2c->irq;
 
-	aic31xx->codec_type = id->driver_data;
+	aic31xx->codec_type = (uintptr_t)i2c_get_match_data(i2c);
 
 	dev_set_drvdata(aic31xx->dev, aic31xx);
 
-- 
2.39.2


