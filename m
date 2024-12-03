Return-Path: <linux-kernel+bounces-430098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5A9E2C90
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2224166179
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C831B205AD6;
	Tue,  3 Dec 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YV04ukeb"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00431A2645;
	Tue,  3 Dec 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256033; cv=none; b=j61bdRkin3C9gf3Mo64sHFveVFK/r7VRo0+/I2yT2IzIY1Tu0tOvGAUnyGVlRhJFrDXO2P7T0yg5I8qogNZ+vK70DF4SdJ0/NBOllvSsUMHZy6LDr16KaW2m3Bk7XUS1548+7Yd12lWIaUuABEd1n6oT97zEfIeMwIsUL2JskSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256033; c=relaxed/simple;
	bh=TEij262gwMNlw5ATosPv+expnW320s+GCi0ypMAa6rw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzV/vb/+C/oyqZb1I2MNyh/iUwowh38/ilwg5Rxl0MZ9gnG9wkUXkQ9HH9rvwMnJ88ekFFkuHnqYn4gCZnxGkRUXvWKxHPEP1kVlIwhL6VEkzN6ZJlLLsoVIGxJT/zO50mfkcatlfDNQvEjUaN7nAUsvS6AZ0L8gdvqHAVV03bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YV04ukeb; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K05vR042175;
	Tue, 3 Dec 2024 14:00:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256005;
	bh=abhck/a+r0bBagkATXDbDGF7BMtAIubi228vD14k2+k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YV04ukeb355Wf2/a35/MngYDNumC2Nkgwia3c1wpEABhFOKHqVIHvBcNWEarTOfov
	 HVP9olGyTS1B4rTvU+U8uW80tDK5KMRc70NKdQE9Y2tFQvRePNel1pyb2vV+KUrmam
	 nMhaDnZ/j3UZ4hFj70Bc8XzR/8Okjx2Ss8tjuvOE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K05ED034862
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:05 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:03 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02JW122616;
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
Subject: [PATCH 02/21] ASoC: adau1761: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:42 -0600
Message-ID: <20241203200001.197295-2-afd@ti.com>
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
 sound/soc/codecs/adau1761-i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/adau1761-i2c.c b/sound/soc/codecs/adau1761-i2c.c
index a554255186aef..eba7e4f42c78a 100644
--- a/sound/soc/codecs/adau1761-i2c.c
+++ b/sound/soc/codecs/adau1761-i2c.c
@@ -14,12 +14,9 @@
 
 #include "adau1761.h"
 
-static const struct i2c_device_id adau1761_i2c_ids[];
-
 static int adau1761_i2c_probe(struct i2c_client *client)
 {
 	struct regmap_config config;
-	const struct i2c_device_id *id = i2c_match_id(adau1761_i2c_ids, client);
 
 	config = adau1761_regmap_config;
 	config.val_bits = 8;
@@ -27,7 +24,7 @@ static int adau1761_i2c_probe(struct i2c_client *client)
 
 	return adau1761_probe(&client->dev,
 		devm_regmap_init_i2c(client, &config),
-		id->driver_data, NULL);
+		(uintptr_t)i2c_get_match_data(client), NULL);
 }
 
 static void adau1761_i2c_remove(struct i2c_client *client)
-- 
2.39.2


