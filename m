Return-Path: <linux-kernel+bounces-430099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6567E9E2C91
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F56284792
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A7A205E04;
	Tue,  3 Dec 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fl3VAPc5"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA71B3724;
	Tue,  3 Dec 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256033; cv=none; b=AUd3lj4OzYfjZ/nzQk0c6L6stMTUQEAOcx76a++mdbpPpefCRrEqYVshbkAeaPWejctOxrVkH3B35qT23OPT/ImWV3CZv0tHtkKeT/IRYDmsfk5MKfiUTrOVF4tZe3EN1BEesFw/wDeZmpl69AO+zpkX3zYxCpRY3spLWyHLFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256033; c=relaxed/simple;
	bh=kbUadZWMLB9QFr8ymoYDR74sgK4EuHKuY7Ru4T7FeYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qy7Ekgg0ICFz29ab0bqfmgPx5unSfePlVsm+6pk6MXHojcWL6qndLt8xY5tGNdLNiqtIJJpA4Eai/qC6yTG6EJlv8MrNtu2yNBSTsMObiIdxn5/A3WQQBownZV9BSPG98rXQkQD2bSo1f0v9HmmZiVGsOP82bBC4WMCt2cNDPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fl3VAPc5; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K05G11663503
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Dec 2024 14:00:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256005;
	bh=MOO66E6nunjkk5i9keFTAZvvbB4m1HuIDnaO0EWJMS8=;
	h=From:To:CC:Subject:Date;
	b=Fl3VAPc5YYWyWQOQGqTuu3TAKuRrjN7sDkieYpKfXI+ZYtcASsFjzF0CtUIuqCfD0
	 Ar5vgy3qupr4CtpJG2B7HwrYzzA+RgeZXeTE3lGfP6dd9gLvB5EkoTr6zHw9jPYAPm
	 hXLWBbWznRS5NTkLBhySeNmwoA7Xhiov7Dd+YF2Y=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K05wM028909;
	Tue, 3 Dec 2024 14:00:05 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:02 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02JV122616;
	Tue, 3 Dec 2024 14:00:02 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 01/21] ASoC: ad193x: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:41 -0600
Message-ID: <20241203200001.197295-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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
 sound/soc/codecs/ad193x-i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad193x-i2c.c b/sound/soc/codecs/ad193x-i2c.c
index 15d74bb31c4c5..6aa168e01fbbd 100644
--- a/sound/soc/codecs/ad193x-i2c.c
+++ b/sound/soc/codecs/ad193x-i2c.c
@@ -23,7 +23,6 @@ MODULE_DEVICE_TABLE(i2c, ad193x_id);
 static int ad193x_i2c_probe(struct i2c_client *client)
 {
 	struct regmap_config config;
-	const struct i2c_device_id *id = i2c_match_id(ad193x_id, client);
 
 	config = ad193x_regmap_config;
 	config.val_bits = 8;
@@ -31,7 +30,7 @@ static int ad193x_i2c_probe(struct i2c_client *client)
 
 	return ad193x_probe(&client->dev,
 			    devm_regmap_init_i2c(client, &config),
-			    (enum ad193x_type)id->driver_data);
+			    (uintptr_t)i2c_get_match_data(client));
 }
 
 static struct i2c_driver ad193x_i2c_driver = {
-- 
2.39.2


