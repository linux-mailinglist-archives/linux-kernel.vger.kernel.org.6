Return-Path: <linux-kernel+bounces-441677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F39ED243
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785CD1887AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543A51DE898;
	Wed, 11 Dec 2024 16:39:42 +0000 (UTC)
Received: from smtp.ps-zuehlke.com (smtp.ps-zuehlke.com [193.135.254.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286911A0726;
	Wed, 11 Dec 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.135.254.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935181; cv=none; b=Ud8mozKDiQ0jBG2OvNOnubIl7z7FvZD+TdCQutlHQGVWR/+JFeFaFBSzfsvVcBLt3BeQQlAtRdIhS7JcKVdh+A9TvO3m24K6o3aCQ4qO87fXbcUt35aCsrthb/9ghGBAJQolQHXU0di8Kq5MxwL5Q2/tnHwPIHMTRJzZKijk+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935181; c=relaxed/simple;
	bh=RyWqeoP8DlkITpAgb06Z9urOqB1IzYlqiNZ4kms8ib4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pGbOO+m4GS7Hjc10WfEYLLpBaFfnkxPmnIzEWx02BmhY0NySQTbmPBTATBkZStmY+qyiCPQf3UwOhi4Itz+UnXiyPig5UWsVDMyrLu7vBAgj30WRfQMD28bFeMiV5aH/naBShyv/C7eLDeoPPz7d6DLhDq9yROo2QAM1Xt84qY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; arc=none smtp.client-ip=193.135.254.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
Received: from ZUEN49445. (unknown [10.195.248.60])
	by smtp.ps-zuehlke.com (Postfix) with ESMTP id C67672B8;
	Wed, 11 Dec 2024 17:32:57 +0100 (CET)
From: Oliver Facklam <oliver.facklam@zuehlke.com>
Date: Wed, 11 Dec 2024 17:32:47 +0100
Subject: [PATCH v3 3/3] usb: typec: hd3ss3220: support configuring role
 preference based on fwnode property and typec_operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-usb-typec-controller-enhancements-v3-3-e4bc1b6e1441@zuehlke.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733934778; l=5156;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=RyWqeoP8DlkITpAgb06Z9urOqB1IzYlqiNZ4kms8ib4=;
 b=jpvHMUJb6XJgTnrFVZOFQFdYYUlryqhX/lgvkts8YFMTDI9Vr4me82+qn4ThqtQwjESFmmBRA
 hlvsxU7i0euAEnu3m5MK0MuWl+TYJYTViEFGzgSgc8RqP9IJ5NOe/s0
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=

The TI HD3SS3220 Type-C controller supports configuring
its role preference when operating as a dual-role port
through the SOURCE_PREF field of the General Control Register.

The previous driver behavior was to set the role preference
based on the dr_set typec_operation.
However, the controller does not support swapping the data role
on an active connection due to its lack of Power Delivery support.

Remove previous dr_set typec_operation, and support setting
the role preference based on the corresponding fwnode property,
as well as the try_role typec_operation.

Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
---
 drivers/usb/typec/hd3ss3220.c | 72 ++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index e2059b925ab15733ff097e940751759ed51e0ab3..3ecc688dda82a371929e204a490a68c8e9d81fe9 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -127,8 +127,25 @@ static int hd3ss3220_set_port_type(struct hd3ss3220 *hd3ss3220, int type)
 	return err;
 }
 
-static int hd3ss3220_set_source_pref(struct hd3ss3220 *hd3ss3220, int src_pref)
+static int hd3ss3220_set_source_pref(struct hd3ss3220 *hd3ss3220, int prefer_role)
 {
+	int src_pref;
+
+	switch (prefer_role) {
+	case TYPEC_NO_PREFERRED_ROLE:
+		src_pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT;
+		break;
+	case TYPEC_SINK:
+		src_pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SNK;
+		break;
+	case TYPEC_SOURCE:
+		src_pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SRC;
+		break;
+	default:
+		dev_err(hd3ss3220->dev, "bad role preference: %d\n", prefer_role);
+		return -EINVAL;
+	}
+
 	return regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
 				  HD3SS3220_REG_GEN_CTRL_SRC_PREF_MASK,
 				  src_pref);
@@ -160,27 +177,11 @@ static enum usb_role hd3ss3220_get_attached_state(struct hd3ss3220 *hd3ss3220)
 	return attached_state;
 }
 
-static int hd3ss3220_dr_set(struct typec_port *port, enum typec_data_role role)
+static int hd3ss3220_try_role(struct typec_port *port, int role)
 {
 	struct hd3ss3220 *hd3ss3220 = typec_get_drvdata(port);
-	enum usb_role role_val;
-	int pref, ret = 0;
 
-	if (role == TYPEC_HOST) {
-		role_val = USB_ROLE_HOST;
-		pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SRC;
-	} else {
-		role_val = USB_ROLE_DEVICE;
-		pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SNK;
-	}
-
-	ret = hd3ss3220_set_source_pref(hd3ss3220, pref);
-	usleep_range(10, 100);
-
-	usb_role_switch_set_role(hd3ss3220->role_sw, role_val);
-	typec_set_data_role(hd3ss3220->port, role);
-
-	return ret;
+	return hd3ss3220_set_source_pref(hd3ss3220, role);
 }
 
 static int hd3ss3220_port_type_set(struct typec_port *port, enum typec_port_type type)
@@ -191,7 +192,7 @@ static int hd3ss3220_port_type_set(struct typec_port *port, enum typec_port_type
 }
 
 static const struct typec_operations hd3ss3220_ops = {
-	.dr_set = hd3ss3220_dr_set,
+	.try_role = hd3ss3220_try_role,
 	.port_type_set = hd3ss3220_port_type_set,
 };
 
@@ -200,9 +201,6 @@ static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
 	enum usb_role role_state = hd3ss3220_get_attached_state(hd3ss3220);
 
 	usb_role_switch_set_role(hd3ss3220->role_sw, role_state);
-	if (role_state == USB_ROLE_NONE)
-		hd3ss3220_set_source_pref(hd3ss3220,
-				HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT);
 
 	switch (role_state) {
 	case USB_ROLE_HOST:
@@ -293,6 +291,28 @@ static int hd3ss3220_configure_port_type(struct hd3ss3220 *hd3ss3220,
 	return hd3ss3220_set_port_type(hd3ss3220, cap->type);
 }
 
+static int hd3ss3220_configure_source_pref(struct hd3ss3220 *hd3ss3220,
+					   struct fwnode_handle *connector,
+					   struct typec_capability *cap)
+{
+	/*
+	 * Preferred role can be configured through device tree
+	 */
+	const char *cap_str;
+	int ret;
+
+	ret = fwnode_property_read_string(connector, "try-power-role", &cap_str);
+	if (ret)
+		return 0;
+
+	ret = typec_find_power_role(cap_str);
+	if (ret < 0)
+		return ret;
+
+	cap->prefer_role = ret;
+	return hd3ss3220_set_source_pref(hd3ss3220, cap->prefer_role);
+}
+
 static const struct regmap_config config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -319,8 +339,6 @@ static int hd3ss3220_probe(struct i2c_client *client)
 	if (IS_ERR(hd3ss3220->regmap))
 		return PTR_ERR(hd3ss3220->regmap);
 
-	hd3ss3220_set_source_pref(hd3ss3220,
-				  HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT);
 	/* For backward compatibility check the connector child node first */
 	connector = device_get_named_child_node(hd3ss3220->dev, "connector");
 	if (connector) {
@@ -348,6 +366,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
 	typec_cap.ops = &hd3ss3220_ops;
 	typec_cap.fwnode = connector;
 
+	ret = hd3ss3220_configure_source_pref(hd3ss3220, connector, &typec_cap);
+	if (ret < 0)
+		goto err_put_role;
+
 	ret = hd3ss3220_configure_port_type(hd3ss3220, connector, &typec_cap);
 	if (ret < 0)
 		goto err_put_role;

-- 
2.34.1


