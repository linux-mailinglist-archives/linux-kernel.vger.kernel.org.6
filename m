Return-Path: <linux-kernel+bounces-408878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE379C849A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7141F2370B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFE01F708C;
	Thu, 14 Nov 2024 08:10:09 +0000 (UTC)
Received: from smtp.ps-zuehlke.com (smtp.ps-zuehlke.com [193.135.254.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C331F585B;
	Thu, 14 Nov 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.135.254.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571808; cv=none; b=unNmE9s23pkZIAa+nSXmgyZzCjpzepFy6OC9MXUVXhqTqfdJNvO75Nm2vInoXIWxaQvgLgUzFxTjRv8PQ5oReoi2UG3nf72g0wUE/THYzrjucdBPbi6VUlfD4XtfCb7VYDh65sH/N/w3bHdAjq73zBGvVLMfiZuyj0im3c6dQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571808; c=relaxed/simple;
	bh=xQEWItvO4K2hmgsVC5C+clRiGDX0sc04fruShxWbObY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DykQVfUzhlhxSPjZf7EabkcVLvcSw3sVqR6iRO3yhRCeeqmcLl77utQqTSqyFeOEzmJt3DkDjLJJ5tocWPmmailSZ1Og4Efu6uwD5tlV/B2boMoYQlWcVlx+FPlIKISFqshLAkqmOc7RrssRQtP2SYU6DbzF/yxxYLrWpjD4OTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; arc=none smtp.client-ip=193.135.254.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
Received: from ZUEN49445. (unknown [10.192.66.22])
	by smtp.ps-zuehlke.com (Postfix) with ESMTP id 6A591125;
	Thu, 14 Nov 2024 09:02:22 +0100 (CET)
From: Oliver Facklam <oliver.facklam@zuehlke.com>
Date: Thu, 14 Nov 2024 09:02:06 +0100
Subject: [PATCH v2 1/4] usb: typec: hd3ss3220: configure advertised power
 opmode based on fwnode property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-usb-typec-controller-enhancements-v2-1-362376856aea@zuehlke.com>
References: <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
In-Reply-To: <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Biju Das <biju.das@bp.renesas.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benedict von Heyl <benedict.vonheyl@zuehlke.com>, 
 Mathis Foerst <mathis.foerst@zuehlke.com>, 
 Michael Glettig <michael.glettig@zuehlke.com>, 
 Oliver Facklam <oliver.facklam@zuehlke.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731571341; l=3492;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=xQEWItvO4K2hmgsVC5C+clRiGDX0sc04fruShxWbObY=;
 b=HvVCPl5uvDhWEKRy2xR7rnyd/4v1VTPmR59H8YR95Mo8LP9O3Q3eZF607y8RAWA8Py+TZBeDn
 vTizckKK1p0CT/ymSi9KSfkQmxwYZkXnP7bjOQk7F9FJxHwSbo6vV3W
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=

The TI HD3SS3220 Type-C controller supports configuring its advertised
power operation mode over I2C using the CURRENT_MODE_ADVERTISE field
of the Connection Status Register.

Configure this power mode based on the existing (optional) property
"typec-power-opmode" of /schemas/connector/usb-connector.yaml

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


