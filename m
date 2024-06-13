Return-Path: <linux-kernel+bounces-213778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F9F907A50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516AC1C22F03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B0D14A4EB;
	Thu, 13 Jun 2024 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X4JLbTL3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC614A093
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301277; cv=none; b=uN7DS7w6U+BWpnVbfQ+zYxbwE4gRWc11P1h63/VSkPReONe6X22GHtlqzjjNNiOzQnWwgtHtfg01O/231MzJi1YmcB32i/NoZ5l+ys4Pf5fgHvLjXiESUtkTtZRyRi6KxvuJ0daYjLpg6wCgHp2rsd1Ps7Yt2M8xO3rj/BbsumY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301277; c=relaxed/simple;
	bh=gCk809gYqcC206lj8Ily/zsMHk7miIt4jQaYiyfS40Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M1O/j79crIxdhyEavwwhr0vceEcVBHmQZRMuK7mZwdd1NuEcSAF3+Kl6fsNOUd8feK/3GSorLZfLvIzyj0bDwkadRxyhmcepgSg23Rkzqx3nTqS1w5mtu9O7UEUAYgJUf6me+E0euVdXGJJGKblLTSpq2zjHMCknoMKYWzc0vQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X4JLbTL3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DHsVSE031121;
	Thu, 13 Jun 2024 12:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718301271;
	bh=1QopD6o/3Pv6pxk2ngfzDNMHnHJdH0sr9isUtNXMlSo=;
	h=From:To:CC:Subject:Date;
	b=X4JLbTL3DmqKJmv7KaamNzvT3u774l0wBOz8scHb+Wc4tkz8v0JxZD/upYeUZf3lV
	 9prEF5xNr5u2aJkKsouJv6LziFe0uoBArAldIbl4F/Dr8+z9uAyNs8IpC9g7T9nXfL
	 GwGINRVCTuJdm0mt/eODBENwy6saxdPIY6BAtvbU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DHsVw5018852
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 12:54:31 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 12:54:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 12:54:31 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DHsUjG126648;
	Thu, 13 Jun 2024 12:54:31 -0500
From: Andrew Davis <afd@ti.com>
To: Lee Jones <lee@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2] mfd: tps65912: Use devm helper functions to simplify probe
Date: Thu, 13 Jun 2024 12:54:30 -0500
Message-ID: <20240613175430.57698-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This simplifies probe and also allows us to remove the remove
callbacks from the core and interface drivers. Do that here.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes for v2:
 - Rebased on latest -next (next-20240613)

 drivers/mfd/tps65912-core.c  | 21 +++++++--------------
 drivers/mfd/tps65912-i2c.c   |  8 --------
 drivers/mfd/tps65912-spi.c   |  8 --------
 include/linux/mfd/tps65912.h |  1 -
 4 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/mfd/tps65912-core.c b/drivers/mfd/tps65912-core.c
index 2305ea60367ac..87ee6aac37636 100644
--- a/drivers/mfd/tps65912-core.c
+++ b/drivers/mfd/tps65912-core.c
@@ -90,29 +90,22 @@ int tps65912_device_init(struct tps65912 *tps)
 {
 	int ret;
 
-	ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
-				  &tps65912_irq_chip, &tps->irq_data);
+	ret = devm_regmap_add_irq_chip(tps->dev, tps->regmap, tps->irq,
+				       IRQF_ONESHOT, 0, &tps65912_irq_chip,
+				       &tps->irq_data);
 	if (ret)
 		return ret;
 
-	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65912_cells,
-			      ARRAY_SIZE(tps65912_cells), NULL, 0,
-			      regmap_irq_get_domain(tps->irq_data));
-	if (ret) {
-		regmap_del_irq_chip(tps->irq, tps->irq_data);
+	ret = devm_mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65912_cells,
+				   ARRAY_SIZE(tps65912_cells), NULL, 0,
+				   regmap_irq_get_domain(tps->irq_data));
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tps65912_device_init);
 
-void tps65912_device_exit(struct tps65912 *tps)
-{
-	regmap_del_irq_chip(tps->irq, tps->irq_data);
-}
-EXPORT_SYMBOL_GPL(tps65912_device_exit);
-
 MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
 MODULE_DESCRIPTION("TPS65912x MFD Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/tps65912-i2c.c b/drivers/mfd/tps65912-i2c.c
index 3cc1bc68be7c3..138e50497b514 100644
--- a/drivers/mfd/tps65912-i2c.c
+++ b/drivers/mfd/tps65912-i2c.c
@@ -42,13 +42,6 @@ static int tps65912_i2c_probe(struct i2c_client *client)
 	return tps65912_device_init(tps);
 }
 
-static void tps65912_i2c_remove(struct i2c_client *client)
-{
-	struct tps65912 *tps = i2c_get_clientdata(client);
-
-	tps65912_device_exit(tps);
-}
-
 static const struct i2c_device_id tps65912_i2c_id_table[] = {
 	{ "tps65912" },
 	{ /* sentinel */ }
@@ -61,7 +54,6 @@ static struct i2c_driver tps65912_i2c_driver = {
 		.of_match_table = tps65912_i2c_of_match_table,
 	},
 	.probe		= tps65912_i2c_probe,
-	.remove		= tps65912_i2c_remove,
 	.id_table       = tps65912_i2c_id_table,
 };
 module_i2c_driver(tps65912_i2c_driver);
diff --git a/drivers/mfd/tps65912-spi.c b/drivers/mfd/tps65912-spi.c
index 9e976f9c6bbe3..2a77dccd60599 100644
--- a/drivers/mfd/tps65912-spi.c
+++ b/drivers/mfd/tps65912-spi.c
@@ -42,13 +42,6 @@ static int tps65912_spi_probe(struct spi_device *spi)
 	return tps65912_device_init(tps);
 }
 
-static void tps65912_spi_remove(struct spi_device *spi)
-{
-	struct tps65912 *tps = spi_get_drvdata(spi);
-
-	tps65912_device_exit(tps);
-}
-
 static const struct spi_device_id tps65912_spi_id_table[] = {
 	{ "tps65912", 0 },
 	{ /* sentinel */ }
@@ -61,7 +54,6 @@ static struct spi_driver tps65912_spi_driver = {
 		.of_match_table = tps65912_spi_of_match_table,
 	},
 	.probe		= tps65912_spi_probe,
-	.remove		= tps65912_spi_remove,
 	.id_table       = tps65912_spi_id_table,
 };
 module_spi_driver(tps65912_spi_driver);
diff --git a/include/linux/mfd/tps65912.h b/include/linux/mfd/tps65912.h
index 860ec0a16c963..e5373c302722c 100644
--- a/include/linux/mfd/tps65912.h
+++ b/include/linux/mfd/tps65912.h
@@ -314,6 +314,5 @@ struct tps65912 {
 extern const struct regmap_config tps65912_regmap_config;
 
 int tps65912_device_init(struct tps65912 *tps);
-void tps65912_device_exit(struct tps65912 *tps);
 
 #endif /*  __LINUX_MFD_TPS65912_H */
-- 
2.39.2


