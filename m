Return-Path: <linux-kernel+bounces-430107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6639E2D77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596CEB386D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEFC1F9437;
	Tue,  3 Dec 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CVNo+qMf"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CB1AA1EB;
	Tue,  3 Dec 2024 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256042; cv=none; b=gVfewD9NZmS3yZlkOyVu8UhHAvG+enAIbjJWvZ3zTJR3qqbRJNI4L/WSwtsfB9yibGQ2FP6hkIcSBqw1msxFcGDgjwu5caL63kmk5wvK6kH6K82bYyTSwIXtNOmDlboS/swg8p8y8+m43LNogjdTTlaFlk9ozhQTDdC0W+5/q50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256042; c=relaxed/simple;
	bh=98S2N3DF4Ab00/pba4PqgYqXoJdQl74CzABJgc0IIbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffVPd0a/3quUpLBq7SZVphCW85bo+iD++Jwi6avl8n/YadY9ACn8Cpi5QQeawnuowhB53ikT2ycJmzVpWcqptPm6SEhnQ/4XIgZm9eaTf1S9g4Docl2PhVKdzv1MYhsieCOXm4hmD+9FLb28Lybrtk3I03RAX0+0sQImmsitQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CVNo+qMf; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K061W1663511
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256006;
	bh=reeFBcyckW+uWyXmE2/gFSmabe/vxaEIFPgDH+bFf2s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CVNo+qMfjJauDET1PIHp7LY+oRXrWCIYjX3PyieQl/cNJgrWTkw2X19GWna8pMvTO
	 A3lpClfHXG3NtOt6a54c1Ni2c1Cuvu5HQ8rYuxr061XEshJEuDLDjv2eT+DgJgsWZy
	 sveXlNZVjHGhVnLnIk9dpOrrxXCK6fQsn8c6I/Ts=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K05xh031113
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:05 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:05 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jc122616;
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
Subject: [PATCH 08/21] ASoC: max98090: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:48 -0600
Message-ID: <20241203200001.197295-8-afd@ti.com>
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
 sound/soc/codecs/max98090.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 2adf744c65263..790e2ae6dc182 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2543,8 +2543,6 @@ MODULE_DEVICE_TABLE(i2c, max98090_i2c_id);
 static int max98090_i2c_probe(struct i2c_client *i2c)
 {
 	struct max98090_priv *max98090;
-	const struct acpi_device_id *acpi_id;
-	kernel_ulong_t driver_data = 0;
 	int ret;
 
 	pr_debug("max98090_i2c_probe\n");
@@ -2554,21 +2552,7 @@ static int max98090_i2c_probe(struct i2c_client *i2c)
 	if (max98090 == NULL)
 		return -ENOMEM;
 
-	if (ACPI_HANDLE(&i2c->dev)) {
-		acpi_id = acpi_match_device(i2c->dev.driver->acpi_match_table,
-					    &i2c->dev);
-		if (!acpi_id) {
-			dev_err(&i2c->dev, "No driver data\n");
-			return -EINVAL;
-		}
-		driver_data = acpi_id->driver_data;
-	} else {
-		const struct i2c_device_id *i2c_id =
-			i2c_match_id(max98090_i2c_id, i2c);
-		driver_data = i2c_id->driver_data;
-	}
-
-	max98090->devtype = driver_data;
+	max98090->devtype = (uintptr_t)i2c_get_match_data(i2c);
 	i2c_set_clientdata(i2c, max98090);
 	max98090->pdata = i2c->dev.platform_data;
 
-- 
2.39.2


