Return-Path: <linux-kernel+bounces-441675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B789ED241
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07C31887751
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639131DE2D2;
	Wed, 11 Dec 2024 16:39:41 +0000 (UTC)
Received: from smtp.ps-zuehlke.com (smtp.ps-zuehlke.com [193.135.254.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864519FA93;
	Wed, 11 Dec 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.135.254.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935180; cv=none; b=hAzx4b1v+bqqVPmnEx6dcHtzB8KUvQl8AMTdgbpZVDRkJNfOIXBumCz+p89STN9/K2O2K92LcczDSNC9Gl0iUfgZxSx8Op6h92Z8CF/UKwQUYYnf9cL3myZB76NR84GPyooqWUXXXNT3+Bm+K7b1KDrqFECi810/rnvP5Q1gUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935180; c=relaxed/simple;
	bh=CD06QGixKkf9wmAKhKqCnHjVerQe9YZ03vz7/u4V2cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHpWPXwPcUM26LFoXcNFH+0k10ujY1VZ5mEoT3AMzO3QjppXBt+N4NB8GVDS5HPAZX7jbfHvRJBXxiF4y9o8BhEfz4qklZc8JnUkWv6Hvq5hrv1RLS7bSXWdSdsM9llZ/zGr/XSo5y930c+tZzcBK2Y+6CkMA81erCx+TD0bHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; arc=none smtp.client-ip=193.135.254.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
Received: from ZUEN49445. (unknown [10.195.248.60])
	by smtp.ps-zuehlke.com (Postfix) with ESMTP id C0D022B7;
	Wed, 11 Dec 2024 17:32:57 +0100 (CET)
From: Oliver Facklam <oliver.facklam@zuehlke.com>
Date: Wed, 11 Dec 2024 17:32:46 +0100
Subject: [PATCH v3 2/3] usb: typec: hd3ss3220: support configuring port
 type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-usb-typec-controller-enhancements-v3-2-e4bc1b6e1441@zuehlke.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733934778; l=5573;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=CD06QGixKkf9wmAKhKqCnHjVerQe9YZ03vz7/u4V2cs=;
 b=DiDGSGf5yg1QuihkRWYstJcNP8CX+ZYJlNlchzUQ2toKmVOSgg+JXJOnl/WwfBqbqH6tB+uoS
 txq8tDjO6YSAU23HpGXYRyF4Dw2eGNBi/jIYDXlODay+rnplV1oiaqW
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=

The TI HD3SS3220 Type-C controller supports configuring the port type
it will operate as through the MODE_SELECT field of the General
Control Register.

Configure the port type based on the fwnode property "power-role"
during probe, if present. If the property is absent, leave the
operation mode at the default, which is defined by the PORT pin
of the chip.
Support configuring the port type through the port_type_set
typec_operation as well.

The MODE_SELECT field can only be changed when the controller is in
unattached state, so follow the sequence recommended by the datasheet to:
1. disable termination on CC pins to disable the controller
2. change the mode
3. re-enable termination

This will effectively cause a connected device to disconnect
for the duration of the mode change.

Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
---
 drivers/usb/typec/hd3ss3220.c | 88 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 56f74bf70895ca701083bde44a5bbe0b691551e1..e2059b925ab15733ff097e940751759ed51e0ab3 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -35,10 +35,16 @@
 #define HD3SS3220_REG_CN_STAT_CTRL_INT_STATUS		BIT(4)
 
 /* Register HD3SS3220_REG_GEN_CTRL*/
+#define HD3SS3220_REG_GEN_CTRL_DISABLE_TERM		BIT(0)
 #define HD3SS3220_REG_GEN_CTRL_SRC_PREF_MASK		(BIT(2) | BIT(1))
 #define HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT	0x00
 #define HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SNK	BIT(1)
 #define HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SRC	(BIT(2) | BIT(1))
+#define HD3SS3220_REG_GEN_CTRL_MODE_SELECT_MASK		(BIT(5) | BIT(4))
+#define HD3SS3220_REG_GEN_CTRL_MODE_SELECT_DEFAULT	0x00
+#define HD3SS3220_REG_GEN_CTRL_MODE_SELECT_DFP		BIT(5)
+#define HD3SS3220_REG_GEN_CTRL_MODE_SELECT_UFP		BIT(4)
+#define HD3SS3220_REG_GEN_CTRL_MODE_SELECT_DRP		(BIT(5) | BIT(4))
 
 struct hd3ss3220 {
 	struct device *dev;
@@ -75,6 +81,52 @@ static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opm
 				  current_mode);
 }
 
+static int hd3ss3220_set_port_type(struct hd3ss3220 *hd3ss3220, int type)
+{
+	int mode_select, err;
+
+	switch (type) {
+	case TYPEC_PORT_SRC:
+		mode_select = HD3SS3220_REG_GEN_CTRL_MODE_SELECT_DFP;
+		break;
+	case TYPEC_PORT_SNK:
+		mode_select = HD3SS3220_REG_GEN_CTRL_MODE_SELECT_UFP;
+		break;
+	case TYPEC_PORT_DRP:
+		mode_select = HD3SS3220_REG_GEN_CTRL_MODE_SELECT_DRP;
+		break;
+	default:
+		dev_err(hd3ss3220->dev, "bad port type: %d\n", type);
+		return -EINVAL;
+	}
+
+	/* Disable termination before changing MODE_SELECT as required by datasheet */
+	err = regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
+				 HD3SS3220_REG_GEN_CTRL_DISABLE_TERM,
+				 HD3SS3220_REG_GEN_CTRL_DISABLE_TERM);
+	if (err < 0) {
+		dev_err(hd3ss3220->dev, "Failed to disable port for mode change: %d\n", err);
+		return err;
+	}
+
+	err = regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
+				 HD3SS3220_REG_GEN_CTRL_MODE_SELECT_MASK,
+				 mode_select);
+	if (err < 0) {
+		dev_err(hd3ss3220->dev, "Failed to change mode: %d\n", err);
+		regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
+				   HD3SS3220_REG_GEN_CTRL_DISABLE_TERM, 0);
+		return err;
+	}
+
+	err = regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
+				 HD3SS3220_REG_GEN_CTRL_DISABLE_TERM, 0);
+	if (err < 0)
+		dev_err(hd3ss3220->dev, "Failed to re-enable port after mode change: %d\n", err);
+
+	return err;
+}
+
 static int hd3ss3220_set_source_pref(struct hd3ss3220 *hd3ss3220, int src_pref)
 {
 	return regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
@@ -131,8 +183,16 @@ static int hd3ss3220_dr_set(struct typec_port *port, enum typec_data_role role)
 	return ret;
 }
 
+static int hd3ss3220_port_type_set(struct typec_port *port, enum typec_port_type type)
+{
+	struct hd3ss3220 *hd3ss3220 = typec_get_drvdata(port);
+
+	return hd3ss3220_set_port_type(hd3ss3220, type);
+}
+
 static const struct typec_operations hd3ss3220_ops = {
-	.dr_set = hd3ss3220_dr_set
+	.dr_set = hd3ss3220_dr_set,
+	.port_type_set = hd3ss3220_port_type_set,
 };
 
 static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
@@ -211,6 +271,28 @@ static int hd3ss3220_configure_power_opmode(struct hd3ss3220 *hd3ss3220,
 	return hd3ss3220_set_power_opmode(hd3ss3220, power_opmode);
 }
 
+static int hd3ss3220_configure_port_type(struct hd3ss3220 *hd3ss3220,
+					 struct fwnode_handle *connector,
+					 struct typec_capability *cap)
+{
+	/*
+	 * Port type can be configured through device tree
+	 */
+	const char *cap_str;
+	int ret;
+
+	ret = fwnode_property_read_string(connector, "power-role", &cap_str);
+	if (ret)
+		return 0;
+
+	ret = typec_find_port_power_role(cap_str);
+	if (ret < 0)
+		return ret;
+
+	cap->type = ret;
+	return hd3ss3220_set_port_type(hd3ss3220, cap->type);
+}
+
 static const struct regmap_config config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -266,6 +348,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
 	typec_cap.ops = &hd3ss3220_ops;
 	typec_cap.fwnode = connector;
 
+	ret = hd3ss3220_configure_port_type(hd3ss3220, connector, &typec_cap);
+	if (ret < 0)
+		goto err_put_role;
+
 	hd3ss3220->port = typec_register_port(&client->dev, &typec_cap);
 	if (IS_ERR(hd3ss3220->port)) {
 		ret = PTR_ERR(hd3ss3220->port);

-- 
2.34.1


