Return-Path: <linux-kernel+bounces-430102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE1B9E2C94
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4671283BCF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51A208965;
	Tue,  3 Dec 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UpKFcgJY"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68CA1FBEB4;
	Tue,  3 Dec 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256034; cv=none; b=Yr+R/vjFs/oz7ZOpBgHwZa2MKkFdDLqjmiUexhaiCAnTIWF66WsptTTct0A+kpGdn5lVCT2RidCAEeByZA3Bt+NzAdJe+m9kRwT3YvlvrFDyfXFgmQN2jv0qxmwGsnIgpG0mBfvvAi/vT+lACjFc7dbB9REBJdhaQAbd0ROaJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256034; c=relaxed/simple;
	bh=r5Ssnig5K4iq+cjzcbWHV6i3kYrY6ZAYLrhfvssWbLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPDJlPCcowdls8SN0n4hqkSfJZqI6Q2O6Dw0XQc1yAK3qjxg6xg7ibVeA/9BE4fKd+dG4xBjXoBjzE15IGkub63Mk+g/fEGZAQ2Etvw7CKNoSiOujPD1XR/WL+U322kG4HTD+mVUj1EzL88kCM3FW+2xrdu+yxD+WDtrGLgXDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UpKFcgJY; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K06vC1495071
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256006;
	bh=6xmTN+kkoEE3ituiPfKUm5w+9guJcPISz+CIpfQLz8g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UpKFcgJYBlIpmEaj8wS11esSaj0/oqC32kx/aMepX+E1w1Lbn6NEtKCpCCUyAOoGf
	 ocdqb3il94QxlGlkrsHNu8QaPk16sGdZrHzbaJgJLshuFzPKwZP2V+T9R3tNWtHpy8
	 t12gmQ+4emYyxpT5OsT1fXD5gTLjeTtbZ/qymwH8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K06pg035012
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:06 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:04 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02JZ122616;
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
Subject: [PATCH 05/21] ASoC: alc5623: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:45 -0600
Message-ID: <20241203200001.197295-5-afd@ti.com>
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
 sound/soc/codecs/alc5623.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index b24c322068847..fbf7237580797 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -987,9 +987,9 @@ static int alc5623_i2c_probe(struct i2c_client *client)
 	struct alc5623_priv *alc5623;
 	struct device_node *np;
 	unsigned int vid1, vid2;
+	unsigned int matched_id;
 	int ret;
 	u32 val32;
-	const struct i2c_device_id *id;
 
 	alc5623 = devm_kzalloc(&client->dev, sizeof(struct alc5623_priv),
 			       GFP_KERNEL);
@@ -1016,12 +1016,12 @@ static int alc5623_i2c_probe(struct i2c_client *client)
 	}
 	vid2 >>= 8;
 
-	id = i2c_match_id(alc5623_i2c_table, client);
+	matched_id = (uintptr_t)i2c_get_match_data(client);
 
-	if ((vid1 != 0x10ec) || (vid2 != id->driver_data)) {
+	if ((vid1 != 0x10ec) || (vid2 != matched_id)) {
 		dev_err(&client->dev, "unknown or wrong codec\n");
-		dev_err(&client->dev, "Expected %x:%lx, got %x:%x\n",
-				0x10ec, id->driver_data,
+		dev_err(&client->dev, "Expected %x:%x, got %x:%x\n",
+				0x10ec, matched_id,
 				vid1, vid2);
 		return -ENODEV;
 	}
-- 
2.39.2


