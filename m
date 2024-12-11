Return-Path: <linux-kernel+bounces-441676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9923C9ED240
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206C5281F56
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD051DE3A9;
	Wed, 11 Dec 2024 16:39:41 +0000 (UTC)
Received: from smtp.ps-zuehlke.com (smtp.ps-zuehlke.com [193.135.254.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285F5748A;
	Wed, 11 Dec 2024 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.135.254.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935181; cv=none; b=hrUY/oIRrLTztSm+3IFcfcBK/9EnTihrnPRpgv0UY0ESx/+yKRfYypaJZuDHJqW7FTvwJu7aZlVwapwBI5XlCJLWabQLne9cc832tG8aST2t09V1AqLYfoY1RwhnWaq/GJuoRyLMdDnnCTbP3XiWCeCYH1zOwgH67BYULrSRgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935181; c=relaxed/simple;
	bh=xKi0xZNR9LI7N0XonUL/BcURXG8Z3KjhIAdVmVip0CY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYK0b8Hm4ljY16RoaqP6w3YtswmL1cTA8lbhkeRHbPifioJZWvBTBmMCri9Y7nc+w9t53ZEdg7E5eS6HtuwhGW3pXQFeEw5vOmLxpJ9lyK1JQ1fM9JqaiVUkunrJU7DWpIOh0gwXZ8lgsev5xRJomNFc6UGTZkwOpNy7EzZyVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; arc=none smtp.client-ip=193.135.254.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
Received: from ZUEN49445. (unknown [10.195.248.60])
	by smtp.ps-zuehlke.com (Postfix) with ESMTP id BACA82B6;
	Wed, 11 Dec 2024 17:32:57 +0100 (CET)
From: Oliver Facklam <oliver.facklam@zuehlke.com>
Date: Wed, 11 Dec 2024 17:32:45 +0100
Subject: [PATCH v3 1/3] usb: typec: hd3ss3220: configure advertised power
 opmode based on fwnode property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-usb-typec-controller-enhancements-v3-1-e4bc1b6e1441@zuehlke.com>
References: <20241211-usb-typec-controller-enhancements-v3-0-e4bc1b6e1441@zuehlke.com>
In-Reply-To: <20241211-usb-typec-controller-enhancements-v3-0-e4bc1b6e1441@zuehlke.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Biju Das <biju.das@bp.renesas.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benedict von Heyl <benedict.vonheyl@zuehlke.com>, 
 Mathis Foerst <mathis.foerst@zuehlke.com>, 
 Michael Glettig <michael.glettig@zuehlke.com>, 
 Oliver Facklam <oliver.facklam@zuehlke.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733934778; l=3556;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=xKi0xZNR9LI7N0XonUL/BcURXG8Z3KjhIAdVmVip0CY=;
 b=npFp+weFko2uC98gLaVwRpg0UFyaJZ3doyfemFiJMDHGS5zfqrZd4yHUPciGmQdGau1n4xxrL
 P+PAwrkJM8+BYPyDj2//6NsoTqbFYklTO6cn8wWwtSH+LJtesuDyDXq
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=

The TI HD3SS3220 Type-C controller supports configuring its advertised
power operation mode over I2C using the CURRENT_MODE_ADVERTISE field
of the Connection Status Register.

Configure this power mode based on the existing (optional) property
"typec-power-opmode" of /schemas/connector/usb-connector.yaml

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
---
 drivers/usb/typec/hd3ss3220.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index fb1242e82ffdc64a9a3330f50155bb8f0fe45685..56f74bf70895ca701083bde44a5bbe0b691551e1 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -16,10 +16,17 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 
+#define HD3SS3220_REG_CN_STAT		0x08
 #define HD3SS3220_REG_CN_STAT_CTRL	0x09
 #define HD3SS3220_REG_GEN_CTRL		0x0A
 #define HD3SS3220_REG_DEV_REV		0xA0
 
+/* Register HD3SS3220_REG_CN_STAT */
+#define HD3SS3220_REG_CN_STAT_CURRENT_MODE_MASK		(BIT(7) | BIT(6))
+#define HD3SS3220_REG_CN_STAT_CURRENT_MODE_DEFAULT	0x00
+#define HD3SS3220_REG_CN_STAT_CURRENT_MODE_MID		BIT(6)
+#define HD3SS3220_REG_CN_STAT_CURRENT_MODE_HIGH		BIT(7)
+
 /* Register HD3SS3220_REG_CN_STAT_CTRL*/
 #define HD3SS3220_REG_CN_STAT_CTRL_ATTACHED_STATE_MASK	(BIT(7) | BIT(6))
 #define HD3SS3220_REG_CN_STAT_CTRL_AS_DFP		BIT(6)
@@ -43,6 +50,31 @@ struct hd3ss3220 {
 	bool poll;
 };
 
+static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opmode)
+{
+	int current_mode;
+
+	switch (power_opmode) {
+	case TYPEC_PWR_MODE_USB:
+		current_mode = HD3SS3220_REG_CN_STAT_CURRENT_MODE_DEFAULT;
+		break;
+	case TYPEC_PWR_MODE_1_5A:
+		current_mode = HD3SS3220_REG_CN_STAT_CURRENT_MODE_MID;
+		break;
+	case TYPEC_PWR_MODE_3_0A:
+		current_mode = HD3SS3220_REG_CN_STAT_CURRENT_MODE_HIGH;
+		break;
+	case TYPEC_PWR_MODE_PD: /* Power delivery not supported */
+	default:
+		dev_err(hd3ss3220->dev, "bad power operation mode: %d\n", power_opmode);
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_CN_STAT,
+				  HD3SS3220_REG_CN_STAT_CURRENT_MODE_MASK,
+				  current_mode);
+}
+
 static int hd3ss3220_set_source_pref(struct hd3ss3220 *hd3ss3220, int src_pref)
 {
 	return regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
@@ -162,6 +194,23 @@ static irqreturn_t hd3ss3220_irq_handler(int irq, void *data)
 	return hd3ss3220_irq(hd3ss3220);
 }
 
+static int hd3ss3220_configure_power_opmode(struct hd3ss3220 *hd3ss3220,
+					    struct fwnode_handle *connector)
+{
+	/*
+	 * Supported power operation mode can be configured through device tree
+	 */
+	const char *cap_str;
+	int ret, power_opmode;
+
+	ret = fwnode_property_read_string(connector, "typec-power-opmode", &cap_str);
+	if (ret)
+		return 0;
+
+	power_opmode = typec_find_pwr_opmode(cap_str);
+	return hd3ss3220_set_power_opmode(hd3ss3220, power_opmode);
+}
+
 static const struct regmap_config config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -223,6 +272,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
 		goto err_put_role;
 	}
 
+	ret = hd3ss3220_configure_power_opmode(hd3ss3220, connector);
+	if (ret < 0)
+		goto err_unreg_port;
+
 	hd3ss3220_set_role(hd3ss3220);
 	ret = regmap_read(hd3ss3220->regmap, HD3SS3220_REG_CN_STAT_CTRL, &data);
 	if (ret < 0)

-- 
2.34.1


