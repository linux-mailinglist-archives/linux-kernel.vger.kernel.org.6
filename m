Return-Path: <linux-kernel+bounces-408879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF5D9C849D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38271B276A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9201F7563;
	Thu, 14 Nov 2024 08:10:09 +0000 (UTC)
Received: from smtp.ps-zuehlke.com (smtp.ps-zuehlke.com [193.135.254.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BDF1F5858;
	Thu, 14 Nov 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.135.254.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571809; cv=none; b=EWLIOSnJ7EsoNDnndkLZvy7aA4v1wKpmkK+/rFdt7tCjsQ5AF1Wcx29I3gfHkOKEsMBs8ILcZLUC/p+bvEI46ycR0u/ZO1rATCScWUPyG/LUZaJCFE+jN/bEMq0q/mzKvF9thhjZDqjk+DsTS5ViwV4Ox/oBXkxh+6mquGhvCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571809; c=relaxed/simple;
	bh=uJEtCNxbDrnddnM8ZNno3zfUTeG9sWOhU95ycQbQD+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hsB1Kg28B4iwJf37BnTOQbPp7r2iMA/7G6ZFfiMbSdIxMwVGz3MoEZY1RB03Em2cuUZOVzgDnblvCIkqPfLLN93RtIvrM0suuoXS055FtDS8cHAwZpCTxIcZXah3C4SdgmAfhw8r8MVFHN1+Pvxbcn4zCLxzLslGwEaJ7qxM2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; arc=none smtp.client-ip=193.135.254.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
Received: from ZUEN49445. (unknown [10.192.66.22])
	by smtp.ps-zuehlke.com (Postfix) with ESMTP id 8121C12A;
	Thu, 14 Nov 2024 09:02:22 +0100 (CET)
From: Oliver Facklam <oliver.facklam@zuehlke.com>
Date: Thu, 14 Nov 2024 09:02:08 +0100
Subject: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731571341; l=4623;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=uJEtCNxbDrnddnM8ZNno3zfUTeG9sWOhU95ycQbQD+A=;
 b=NiJu2sCpaqzSnXgpilS8a8TbaucEGD7NY7K1ID2rBfiBIERP8l/UvjVQh0v/LWpwSchxFcqtf
 B6aHPbz8Lj9DFw+gS+drCwwwWwn3CaAkg94X+pCJ1ieJcflIu0eH9tA
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=

The TI HD3SS3220 Type-C controller supports configuring the port type
it will operate as through the MODE_SELECT field of the General
Control Register.

Configure the port type based on the fwnode property "power-role"
during probe, and through the port_type_set typec_operation.

The MODE_SELECT field can only be changed when the controller is in
unattached state, so follow the sequence recommended by the datasheet to:
1. disable termination on CC pins to disable the controller
2. change the mode
3. re-enable termination

This will effectively cause a connected device to disconnect
for the duration of the mode change.

Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
---
 drivers/usb/typec/hd3ss3220.c | 66 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index e581272bb47de95dee8363a5491f543354fcbbf8..e3e9b1597e3b09b82f0726a01f311fb60b4284da 100644
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
@@ -273,6 +333,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
 	if (ret != 0 && ret != -EINVAL && ret != -ENXIO)
 		goto err_put_role;
 
+	ret = hd3ss3220_set_port_type(hd3ss3220, typec_cap.type);
+	if (ret < 0)
+		goto err_put_role;
+
 	hd3ss3220->port = typec_register_port(&client->dev, &typec_cap);
 	if (IS_ERR(hd3ss3220->port)) {
 		ret = PTR_ERR(hd3ss3220->port);

-- 
2.34.1


