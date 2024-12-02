Return-Path: <linux-kernel+bounces-428018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D23A9E0A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22036BC5A04
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547D1DAC93;
	Mon,  2 Dec 2024 16:35:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029291DA116
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157343; cv=none; b=JwnFRkk2b8StzO8VyjjCvpbXO1Y0NVdfe8NOxAyxDR7styYUmLhPVB1hkrvR3ZkIFMqceCHNmkCOApjbhIquxNP6f3/NbcwDD0lv82nb2RRZYlnogOrb1oJZuffASftZIb7ezb4mi3q5qK8PiMXUCMJ+aET7WmuXc6MPIRHurMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157343; c=relaxed/simple;
	bh=4Znxh2vezX6ykUQvILB+ITgVuJR4RNnDtKVTVonUfCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TldyM/EWuhJNALuTRVDIA2cSeN2FXj3wcs6JSi39gG9uifcA6+2AeQi/CXUPIkdYA0uWn1SLouXrWO60fzp5yqklBrqunU5WdDLzRHgArGdlKB4KgfNs9aTxpX6wPln5TZ4q9YK1izXZfm31zkgHoBshSGNGA/erd64m5MVhy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1tI9Od-0004Mi-9G; Mon, 02 Dec 2024 17:35:39 +0100
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 02 Dec 2024 17:35:22 +0100
Subject: [PATCH 3/3] mtd: mchp48l640: add support for Fujitsu MB85RS128TY
 FRAM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-mb85rs128ty-v1-3-a660b6490dc8@pengutronix.de>
References: <20241202-mb85rs128ty-v1-0-a660b6490dc8@pengutronix.de>
In-Reply-To: <20241202-mb85rs128ty-v1-0-a660b6490dc8@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Schocher <hs@denx.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Jander <david@protonic.nl>, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=Urh+tFnbGE+nh11saAIXFyyQDAFGEwL1Wkf7BzXgzas=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYkj3fXgzdP6VVf5/r4Q8v5EWVvvFfdKX60tZebdavct8c
 m2d32pmho5SFgYxDgZZMUWWWDU5BSFj/+tmlXaxMHNYmUCGMHBxCsBEPi5kZDj+7dDCEw6upvy1
 zg66lTx/2/VXVdtVF/9IkDV3fdfr2MTwV1533eQ50pqf9Do0MkPDZjWyhR1cc23eqhldnhIPHJz
 jGAA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

The Fujitsu FRAM chips use the same command set as Microchip EERAM.
The only differences are that the Fujitsu FRAM chips don't really have a
page size limit, nor do they automatically reset the WEL bit.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/mtd/devices/mchp48l640.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/devices/mchp48l640.c b/drivers/mtd/devices/mchp48l640.c
index 4cdd24aaed416fc7e40a8060b5c7eaf6684fc6d5..7584d0ba93969d79ba3d9c7a97bc63bd0e5ef327 100644
--- a/drivers/mtd/devices/mchp48l640.c
+++ b/drivers/mtd/devices/mchp48l640.c
@@ -303,6 +303,12 @@ static const struct mchp48_caps mchp48l640_caps = {
 	.auto_disable_wel = true,
 };
 
+static const struct mchp48_caps mb85rs128ty_caps = {
+	.size = SZ_16K,
+	.page_size = 256,
+	.auto_disable_wel = false,
+};
+
 static int mchp48l640_probe(struct spi_device *spi)
 {
 	struct mchp48l640_flash *flash;
@@ -361,6 +367,10 @@ static const struct of_device_id mchp48l640_of_table[] = {
 		.compatible = "microchip,48l640",
 		.data = &mchp48l640_caps,
 	},
+	{
+		.compatible = "fujitsu,mb85rs128ty",
+		.data = &mb85rs128ty_caps,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mchp48l640_of_table);
@@ -370,6 +380,10 @@ static const struct spi_device_id mchp48l640_spi_ids[] = {
 		.name = "48l640",
 		.driver_data = (kernel_ulong_t)&mchp48l640_caps,
 	},
+	{
+		.name = "mb85rs128ty",
+		.driver_data = (kernel_ulong_t)&mb85rs128ty_caps,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, mchp48l640_spi_ids);

-- 
2.39.5


