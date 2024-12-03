Return-Path: <linux-kernel+bounces-430106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D279E2C98
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EEF28660E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43720ADE0;
	Tue,  3 Dec 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nP4mdm0P"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F519E968;
	Tue,  3 Dec 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256041; cv=none; b=oeDRU973uO0EVFqxMb1gxGzdD5ExkzyJPp31sFewI+Gv2HlRC/Vi71D0WF4788oDSw532LvddtiKKvNeM9zMUL6jfP2kD+y6sHXiHc9ThHwbEGg0amTgHh7rdzEVwX7YxOvHt0xtuUkzBjW8R0kx4HARQx7ofPFpOqmrh+Z7pgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256041; c=relaxed/simple;
	bh=SVSHZJDm4sW2K+1NvsXu35ZhS+ayACiAMDtMCXE/mMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyOtYuhiTC5ldqKnLEvIGdawY0mkPzPxt9Jqxft7mqyf9Yg/dZh7GLqen8BN/taZ8l9rHkmDIAL4sHSokEeBvGYTF13juYJqzNBcvnMTvlU6jkfe9ncaCEBNvdWZl1U/VHsXYq9TuYtzNMVSVfHwUZAAeRq9bYLCBKjfjOOyfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nP4mdm0P; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K09Hm1933810
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Dec 2024 14:00:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256009;
	bh=og4RwAwqGBrDDCgM4KnJfTpdd2ofpeeAX2VUMArvaXY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nP4mdm0PWPckbR48ldsao7rc+lrgs8Y10JfFDH7jAskm2I6012WxBiyk0o7ObpUke
	 HgvkhiVDHhpNIXHM4bgsKIbZMDtWuQpet/I8vRxLtUTLSCsD0zhB3R2QMlrjAjN3my
	 ux+eHw0xjzxoNsgBfG9IVqAp+/0QUEgmnGnBphi4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K09JG029200;
	Tue, 3 Dec 2024 14:00:09 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:09 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jn122616;
	Tue, 3 Dec 2024 14:00:09 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 19/21] ASoC: tpa6130a2: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:59 -0600
Message-ID: <20241203200001.197295-19-afd@ti.com>
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
 sound/soc/codecs/tpa6130a2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 5bc486283fdee..b5472fa1bddab 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -222,7 +222,6 @@ static int tpa6130a2_probe(struct i2c_client *client)
 	struct tpa6130a2_data *data;
 	struct tpa6130a2_platform_data *pdata = client->dev.platform_data;
 	struct device_node *np = client->dev.of_node;
-	const struct i2c_device_id *id;
 	const char *regulator;
 	unsigned int version;
 	int ret;
@@ -251,8 +250,7 @@ static int tpa6130a2_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, data);
 
-	id = i2c_match_id(tpa6130a2_id, client);
-	data->id = id->driver_data;
+	data->id = (uintptr_t)i2c_get_match_data(client);
 
 	if (data->power_gpio >= 0) {
 		ret = devm_gpio_request(dev, data->power_gpio,
-- 
2.39.2


