Return-Path: <linux-kernel+bounces-399804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543C99C0469
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DE11C22227
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07F520EA55;
	Thu,  7 Nov 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5ynFb66"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6A20C483;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979841; cv=none; b=IgK6VlC0awT6P4bU/Zq6sVEE/kZ7IjpGUL09dREW1QtuxMuYR15pigKAjA8wxebma7BxrA+1AYhr652GgcKjpH8IF/VVwKiqMsj91teOnqZGqOHODezrBbmmPbWBMVzkQSWlDRAHAdpUxM7HabcvMMe3OKxmQ0qIR7qDB6Zs7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979841; c=relaxed/simple;
	bh=fTI5NBtzq4sCe/T7b4tutmnNVDOvNEZ2tE3VYZgBZFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=En/qTOLASIuP4x+P65u6id4TjN72AUyK+ZHc8+IMfKAAhiQiV806pfZ/R2KJAhncKEENH+IRJrallusw5XFC4OlvUdKVIw96PdFYYMwYJcQfL2UGvRHa71Zk+PtFLp92IrpRTu/cJzl6xkknOQCAnJ+Ku4wKh2iXn4P3mIOhXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5ynFb66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB8E2C4CED4;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730979840;
	bh=fTI5NBtzq4sCe/T7b4tutmnNVDOvNEZ2tE3VYZgBZFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P5ynFb66EQuAWFoim3WlXgtAsvCw8HVStoze3lsy5OZnhVu7IXeD+7/lheztZwE97
	 Qns2xVcZxFjG7kkc+REjgLE4BofNMOpMomZqj0WqbapVHoDLrAiuhYfLctyN5F69mX
	 V3uUB0+P++AT+2hJy5Yqn/3G43AyhwJbTypOfITdWd2A6C9YJA3nd/aGk5nLiz8xfi
	 9WOTY39XaiqPjIof3oUg524Iu6dgDCzaB1wYC8MFrGuHPlsxo3u0RLEl1KouvEqnT5
	 fzetJ6mrYn0uNMbXaj9DdyPTRE5WMjivQOWbuPja/xg2N+U0sI/VcveDfXQupv6hGS
	 BJEIh9PUqsrhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03FAD43354;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
From: Oliver Facklam via B4 Relay <devnull+oliver.facklam.zuehlke.com@kernel.org>
Date: Thu, 07 Nov 2024 12:43:29 +0100
Subject: [PATCH 3/4] usb: typec: hd3ss3220: support configuring port type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-usb-typec-controller-enhancements-v1-3-3886c1acced2@zuehlke.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730979838; l=4521;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=RoJ3L9O4AN+n7NPifu/hwf1btjsUL9d+mOMPJO0VD04=;
 b=ROIfT6svIEQiIdOfNTksvubjgWdQrobqW8MYz+gm2mXTODPw8LFK8qmdrsJ8mjcv9XX3bbggo
 HcusLZntEMlDVlBIo2t16wQDaJUzN87QucIyWbvTpwedAMtSzG7t/qH
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=
X-Endpoint-Received: by B4 Relay for oliver.facklam@zuehlke.com/20241107
 with auth_id=271
X-Original-From: Oliver Facklam <oliver.facklam@zuehlke.com>
Reply-To: oliver.facklam@zuehlke.com

From: Oliver Facklam <oliver.facklam@zuehlke.com>

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
index e6e4b1871b5d805f8c367131509f4e6ec0d2b5f0..357c4e9491a2e3047046db91858ac98ab484ef62 100644
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
@@ -263,6 +323,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
 	if (ret)
 		goto err_put_role;
 
+	ret = hd3ss3220_set_port_type(hd3ss3220, typec_cap.type);
+	if (ret < 0)
+		goto err_put_role;
+
 	typec_cap.driver_data = hd3ss3220;
 	typec_cap.ops = &hd3ss3220_ops;
 

-- 
2.34.1



