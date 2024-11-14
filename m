Return-Path: <linux-kernel+bounces-408878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABFE9C849B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367A41F23BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464AF1F7090;
	Thu, 14 Nov 2024 08:10:09 +0000 (UTC)
Received: from smtp.ps-zuehlke.com (smtp.ps-zuehlke.com [193.135.254.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B1D13CA99;
	Thu, 14 Nov 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.135.254.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571808; cv=none; b=W7fWuhxA83Qf1NmBBDLZs+WrjgAt3zR2mgnho3+ovfHsWjeY57uDviTe+pJEz8rFftxaG5KN+jygtQdykhQLrYtFd9vtFe6iADhhwV+53xh7iQdAnDvYqLvCk5T0RvjaPMtI7vtDhRJ7tCJf5spWOWNSWo1JkOn0OZoKOdyoYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571808; c=relaxed/simple;
	bh=xO9l0nLfli08W2OYf5c3unKKB7iAHPMUKyhuLnOgTpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1VbFMbZcwt62rSQVJqBgrrD1LnsTfO7vuKtHHqougnW/diwRO5WAI5eZMZnQV++YXkpYpy4DnDzE0ALX4ZE3OSUygesU/riN8cq90ww3y3GsTrteIFN21tdnDkJ0zTQjWOezTpx/ScVz3MVCLRkZqqX12KR5Uwo8B7gbGWi49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; arc=none smtp.client-ip=193.135.254.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
Received: from ZUEN49445. (unknown [10.192.66.22])
	by smtp.ps-zuehlke.com (Postfix) with ESMTP id 8AFC512E;
	Thu, 14 Nov 2024 09:02:22 +0100 (CET)
From: Oliver Facklam <oliver.facklam@zuehlke.com>
Date: Thu, 14 Nov 2024 09:02:09 +0100
Subject: [PATCH v2 4/4] usb: typec: hd3ss3220: support configuring role
 preference based on fwnode property and typec_operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-usb-typec-controller-enhancements-v2-4-362376856aea@zuehlke.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731571341; l=4351;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=xO9l0nLfli08W2OYf5c3unKKB7iAHPMUKyhuLnOgTpY=;
 b=Kcb57uEEl7mkDiGjvoRPZfkCmC0ZqKj2NW6arCgOh5SviGRuSPsY1J2FU4I+bQn+OAjY4fG8Y
 B/mDQ8GvsyhDKiYl5Z/tUpJ1UbKOEbe6FnnaLsDzoWGlal9QTDdHl9i
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
 drivers/usb/typec/hd3ss3220.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index e3e9b1597e3b09b82f0726a01f311fb60b4284da..666bf15f88a2adb778f14efd982c0803424512bd 100644
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
@@ -297,8 +295,6 @@ static int hd3ss3220_probe(struct i2c_client *client)
 	if (IS_ERR(hd3ss3220->regmap))
 		return PTR_ERR(hd3ss3220->regmap);
 
-	hd3ss3220_set_source_pref(hd3ss3220,
-				  HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT);
 	/* For backward compatibility check the connector child node first */
 	connector = device_get_named_child_node(hd3ss3220->dev, "connector");
 	if (connector) {
@@ -333,6 +329,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
 	if (ret != 0 && ret != -EINVAL && ret != -ENXIO)
 		goto err_put_role;
 
+	ret = hd3ss3220_set_source_pref(hd3ss3220, typec_cap.prefer_role);
+	if (ret < 0)
+		goto err_put_role;
+
 	ret = hd3ss3220_set_port_type(hd3ss3220, typec_cap.type);
 	if (ret < 0)
 		goto err_put_role;

-- 
2.34.1


