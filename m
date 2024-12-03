Return-Path: <linux-kernel+bounces-430115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5729E2E05
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260E2B47C99
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7A20C48C;
	Tue,  3 Dec 2024 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sCwzoZgS"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CE420B1F7;
	Tue,  3 Dec 2024 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256046; cv=none; b=IbHZlxQkZwqhnaxc4a2LL0z7DZhLeOUBoA+DU/DHpSxYS/XyONsvAcYAm8qV78gZ8Lh5DIcuoUULociqgNm53QEhPTdouZXeUKs75JvuxXimhL6xMwKNMAnFjs6J/JoaW+IoDhJbKqHG99dxpDcxa3/kTuV7roUXppszB4I3790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256046; c=relaxed/simple;
	bh=Fe/ifO9MSGOTyiWC/s4pDt/H5EJw4dvvzaxLZRG4GqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xf1xIPS/J2KUA6hsrCg763r/Y4FyG09HFS6tQ+EVcNwSF/glyXbMZnx0XkvlCJDgOysX2iQhhykzV8MX/AKg2x5n69rCgSgKlF0QGmGv1jPuvu4QLmz2uxcTOd+OMjSy1+Vpg8GNwd0NgsP1ElCWe5N+uuVqoWxcZDVGSluqw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sCwzoZgS; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K07bd1680016
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256007;
	bh=mQyN4UaF+YGF0AYZqoapFNBY+p6XrtzziUWapwScWvk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sCwzoZgSi/s6rFBTpLkdup2mLpZ4JgDV98m3ou88cM8AJz68C9fTvBK6JGkTPYRY+
	 +3MAzGZSdA2tDmJJ/nh6CuIr0bi7nVblLcPIFoq2n4HhsZp5CD4PBZ/mx6+/xfmJOO
	 Iv05e/zVOmHOpjkLWsxmRpc5Ww3ls5q+IAQPd+bY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K07hV045953
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:07 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:07 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jg122616;
	Tue, 3 Dec 2024 14:00:06 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 12/21] ASoC: ssm2602: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:52 -0600
Message-ID: <20241203200001.197295-12-afd@ti.com>
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
 sound/soc/codecs/ssm2602-i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ssm2602-i2c.c b/sound/soc/codecs/ssm2602-i2c.c
index 596096466cd48..49c74cba17c70 100644
--- a/sound/soc/codecs/ssm2602-i2c.c
+++ b/sound/soc/codecs/ssm2602-i2c.c
@@ -13,8 +13,6 @@
 
 #include "ssm2602.h"
 
-static const struct i2c_device_id ssm2602_i2c_id[];
-
 /*
  * ssm2602 2 wire address is determined by GPIO5
  * state during powerup.
@@ -23,8 +21,7 @@ static const struct i2c_device_id ssm2602_i2c_id[];
  */
 static int ssm2602_i2c_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_match_id(ssm2602_i2c_id, client);
-	return ssm2602_probe(&client->dev, id->driver_data,
+	return ssm2602_probe(&client->dev, (uintptr_t)i2c_get_match_data(client),
 		devm_regmap_init_i2c(client, &ssm2602_regmap_config));
 }
 
-- 
2.39.2


