Return-Path: <linux-kernel+bounces-399802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C639C0464
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C0D1C22230
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C420EA37;
	Thu,  7 Nov 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZnfT7yp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B120B1FC;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979841; cv=none; b=uNtnZzMGxOJg+FTQfVDR8mvXGU0JuYSVf29rtLG/3bcg7uaXpzNMmApcfcpn7x43IveLmW7hV/07iZQ6Sbus6hxhWogeBdx1/GvYvJTjt+yWvUFDDEgswsCbNgzk5scc+GnuwzDcYep4w6FzFBIJvx7jEcmA7bMzm3vyfQidOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979841; c=relaxed/simple;
	bh=8OjwgE+KJS8rZ/T96z9AvyE20GFcpVpfz7Q+t0LI/bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTirEFGkVaP+M34F0oYRHusjj98FRUDpI1HZ9ue1+EGtuNp1Ll8V7mWE82oPplAbopWjG0deTCs2po93M/l/IhZe7LgonMRNIR1B3xJ0PiHl7dAZGcjHI+a3471RlgG8RSMcY0Tuk8h2eB2SaELTF2ykUWHp/kDWsFaItlYujgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZnfT7yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98F65C4CED2;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730979840;
	bh=8OjwgE+KJS8rZ/T96z9AvyE20GFcpVpfz7Q+t0LI/bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uZnfT7ypWbAXJ46bO6t/0s1Z44fed4nutzXjOGZvwIvLzpo59iTfXgT3qsjTJSmYb
	 AQOgde3fEDi1jUAQUq6zf2MhohI4RDzNH5h37KCZ2IEBNMdEEfQKZFP6FY8/Io5UmE
	 4HAeBTzqFKAzMCn2dtDKGqciUoE20bOEWT5dnE/DTQY6k5nXD1yRJNSMXMTsRfDiWJ
	 I0X3oeAUvaH64hMkew80+I0XKGmk1/VPZ3hmlq1y/Cm1vUwrchmmSjG8c+ZwCsDp3r
	 TDDjEl0nkgmQ/v6HPKQpoXOV8P38Y6vXKsQnkvvYQmxzxxsk2SqAXH/oz8zUXEhPMN
	 QHcy5JqIuLSDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB6D4334F;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
From: Oliver Facklam via B4 Relay <devnull+oliver.facklam.zuehlke.com@kernel.org>
Date: Thu, 07 Nov 2024 12:43:27 +0100
Subject: [PATCH 1/4] usb: typec: hd3ss3220: configure advertised power
 opmode based on fwnode property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-usb-typec-controller-enhancements-v1-1-3886c1acced2@zuehlke.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730979838; l=3492;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=xQEWItvO4K2hmgsVC5C+clRiGDX0sc04fruShxWbObY=;
 b=Tqye3+C+vb15i1SGLnSaSimixcm0SjmZ31zzyMIapThQJyi051aNEe82OlBkwdUKDm5CpER0k
 LhT95ki85z0A24A8UK8uE6zVtvqQYATagSVIufnge5fWpJJVeLWN4UQ
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=
X-Endpoint-Received: by B4 Relay for oliver.facklam@zuehlke.com/20241107
 with auth_id=271
X-Original-From: Oliver Facklam <oliver.facklam@zuehlke.com>
Reply-To: oliver.facklam@zuehlke.com

From: Oliver Facklam <oliver.facklam@zuehlke.com>

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



