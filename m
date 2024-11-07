Return-Path: <linux-kernel+bounces-399804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D529C046A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543FEB21ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70920EA54;
	Thu,  7 Nov 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg4qq+Ce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293DB20C47C;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979841; cv=none; b=LWkKgQBXGwKqGl/6fG0kFB+EfVnA/I/KM5nTOSQ+w9q5jWyDLHkt1eTYstGbAlLHnIVP3yXqeVjq0cIM3TFC4myudDHOlUdbmBRceanHK3YtTvbDq9x4kEfUfuNcc+NR9q53oKLrdFGHHt+5Qset+96Scj7AaT6DC+XfH44MX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979841; c=relaxed/simple;
	bh=jc3lmpbmP5zBXZt8ih0/6VWlSDJK5i7MOpw2pO3/b8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbNFemZtpO+DaC+OCAjwySZQY27hO8/a/Wf+wHjMb888d+A3UBG1d30+E5+TYrjhlY4d83B4duTFQITx9K41BmKYO2NHqhuHEQNQYSIgigpMFm3FMGFmqjDlbrEmec3Jl7xAYfMwohSqxRJKoYKZKyfGZ16Kdm7f+f7ld+CaM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg4qq+Ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B86B9C4CED6;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730979840;
	bh=jc3lmpbmP5zBXZt8ih0/6VWlSDJK5i7MOpw2pO3/b8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kg4qq+Ce9ESWaVmIvB8/GoLECVMz7jEosLB0Ke138JhJhMN98CBlo79aKPBuHxKCE
	 J3c0g4J8q4dps2pHc5ZZtiTsOPZR7Mz6usgbE8A3j+QJ9TqnrN6CvKLXw6TqzUuG75
	 3HOS1dST9ZwICGFO0naAZtUP5/uRr0GvGrepsbM8AmTVE2F+GgZGWUD53meWwioCgL
	 zqrBUErvdqgeN2Ujv/EaBjGgkoUWb6yVmGGO/3ou0EUWYGkpZ5Ug5H7Igk01t66OM1
	 Cr/x/RgFuT+ZEB/d9wIf9MylORW2M7q1Tn0m3250LPQzEaI5mnMfyZLDFr5LuCXxC+
	 WlAzR2K34zDsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA57D43350;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
From: Oliver Facklam via B4 Relay <devnull+oliver.facklam.zuehlke.com@kernel.org>
Date: Thu, 07 Nov 2024 12:43:30 +0100
Subject: [PATCH 4/4] usb: typec: hd3ss3220: support configuring role
 preference based on fwnode property and typec_operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-usb-typec-controller-enhancements-v1-4-3886c1acced2@zuehlke.com>
References: <20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com>
In-Reply-To: <20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oliver Facklam <oliver.facklam@zuehlke.com>, 
 Benedict von Heyl <benedict.vonheyl@zuehlke.com>, 
 Mathis Foerst <mathis.foerst@zuehlke.com>, 
 Michael Glettig <michael.glettig@zuehlke.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730979838; l=4311;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=XHflV9vRXXwBeMjU3taqyyigWiet9h+BzR1A+QQQN2o=;
 b=MFk/3IkAL+g3y3G9e9CD/xiHKOIjDVMyQXkvcAryZBJ1PRXy33ovhS2wklRVWrl80ziI1E09f
 baLbkB5WtO6AnNm3yhMnw9BrdVLQ+NP2KXzbzly+3rr1u/WZZEIMm9v
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=
X-Endpoint-Received: by B4 Relay for oliver.facklam@zuehlke.com/20241107
 with auth_id=271
X-Original-From: Oliver Facklam <oliver.facklam@zuehlke.com>
Reply-To: oliver.facklam@zuehlke.com

From: Oliver Facklam <oliver.facklam@zuehlke.com>

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
index 357c4e9491a2e3047046db91858ac98ab484ef62..c6922989a3cd04fd878e37888856ac1b9c5135ec 100644
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
@@ -323,6 +319,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
 	if (ret)
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



