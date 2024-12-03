Return-Path: <linux-kernel+bounces-430116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E30D9E2C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535DC28874C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEEE200120;
	Tue,  3 Dec 2024 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ovw4i2WE"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A420B1F6;
	Tue,  3 Dec 2024 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256046; cv=none; b=UnIdqVPX8cYy+9JgerYDiSHxM9fnCq/Tiuo2j1qFmhcFYq05dr6QQRMn9IQUvyJNzON/c0Mu6CfhEVXzNmuS7qNukWURmo2J1PryEiZlzZVNlxhWLkcxa7WE779lsRvNOOPB1JR9QHiy2N4vMZQmRA6pwHBH+A57G7idceTq/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256046; c=relaxed/simple;
	bh=haQrAr6qwTG3vrz6t/h9K4gmkhTY2jQ/+lzEb/FGoSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOpLBlLSrn/dAbTLOIpwMBQcA/PJeeX+uQSNRBJn01do7luyKv3WlFkpikPwmjq09GQ7yg+ygmeww7k3FpcBTwgw4oEhsYn4/QH9WcCYg55Au11knl4wtX/xEXEIZR6DfmoQdWpa0EfG3hCS+6Rt1AkQVdegPOtyfSiLT2nfqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ovw4i2WE; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K07DL1680020
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256007;
	bh=VALC4sCtl67PdPrCY01bRrk/kPnBf1Nk67idv24aQLI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ovw4i2WE0rw2I45MSzhWVuVVQr+CupsFcKfpzdldLeFcGn5fP390fq+OxaK8g++xS
	 u/bT2yZ2znegmF71cOSdbaYoMIv1C5NbybtEwLyZ4oqqg4vlaNu6fdT8OE8ZJluQQY
	 ncNEia36UG40003Cn93K6kJHgx53m8GkgT4OaU/I=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K077b031568
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:07 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:07 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jh122616;
	Tue, 3 Dec 2024 14:00:07 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 13/21] ASoC: tas2562: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:53 -0600
Message-ID: <20241203200001.197295-13-afd@ti.com>
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
 sound/soc/codecs/tas2562.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 54561ae598b87..fef7ce39f6643 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -731,16 +731,14 @@ static int tas2562_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct tas2562_data *data;
 	int ret;
-	const struct i2c_device_id *id;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	id = i2c_match_id(tas2562_id, client);
 	data->client = client;
 	data->dev = &client->dev;
-	data->model_id = id->driver_data;
+	data->model_id = (uintptr_t)i2c_get_match_data(client);
 
 	tas2562_parse_dt(data);
 
-- 
2.39.2


