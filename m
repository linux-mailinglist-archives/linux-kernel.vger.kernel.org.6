Return-Path: <linux-kernel+bounces-430104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADE99E2C97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE8828648D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2570320ADD0;
	Tue,  3 Dec 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O0gjkPuY"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5581A7270;
	Tue,  3 Dec 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256041; cv=none; b=SqMU/0qT57Bx7rPQjt4M9r4nV2gy4n1/vBkSVRAAup9AAduT0VK/bxuUHP5YDmdv27j8Pfke2JsnOgDBNIzrZ2JjotRJ+ING67eeOsRXpn76ub0ArqJKwUylkkfGS/Wj4Vdfz4gCbzDgiZAPzKfbA/0DKoWj7meYvUmDi6/QSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256041; c=relaxed/simple;
	bh=QfxcDFSSxd/WRIGX8otbUrnN/JCQqZ9QtYa0tzZsX3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duhRHMsiawrfB7g34HNBSAZZ8Z4rWH+Ae9m3AEuCGnstdGqTE9f47d65uSwQ7r2gQsCRigrPa/t28jBt9nc50XDClWtqZPBUpkiyWBC2opE2AOZgBU0QFpr92F8U9WRbg4hSr57NYOtokEVzZXSSBmMaREv9v/LYc/wmw69TQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O0gjkPuY; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K06wF1495063
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256006;
	bh=dFDjN+HiqWxAQkcNKyrrN8nLUrflg7tj1SJiQMb09rY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=O0gjkPuYQY8wcw/Orss5fag85PT1d/3m1eQ8uRDOVNZ+xrfkQqgdj6K0n91GqUyag
	 qCIIjKa1oXMs+REjZLrM4bl8mxVBe6ttS3H5ulRHG4BUJk/pFo0vrwR9azw20wzFQX
	 2hfNvFlbWBo+JgNIY58VO7xvEBRvv2By/mNXB2Vo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K06ob031240
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:06 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:06 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jd122616;
	Tue, 3 Dec 2024 14:00:05 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 09/21] ASoC: max98095: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:49 -0600
Message-ID: <20241203200001.197295-9-afd@ti.com>
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
 sound/soc/codecs/max98095.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 7e525d49328d2..cfb63fe69267b 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2115,7 +2115,6 @@ static int max98095_i2c_probe(struct i2c_client *i2c)
 {
 	struct max98095_priv *max98095;
 	int ret;
-	const struct i2c_device_id *id;
 
 	max98095 = devm_kzalloc(&i2c->dev, sizeof(struct max98095_priv),
 				GFP_KERNEL);
@@ -2131,8 +2130,7 @@ static int max98095_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	id = i2c_match_id(max98095_i2c_id, i2c);
-	max98095->devtype = id->driver_data;
+	max98095->devtype = (uintptr_t)i2c_get_match_data(i2c);
 	i2c_set_clientdata(i2c, max98095);
 	max98095->pdata = i2c->dev.platform_data;
 
-- 
2.39.2


