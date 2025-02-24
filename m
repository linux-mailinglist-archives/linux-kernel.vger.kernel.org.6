Return-Path: <linux-kernel+bounces-528407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2963A4175B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705F7166375
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488F19B586;
	Mon, 24 Feb 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="g3HtaH9Y"
Received: from mail-m19731120.qiye.163.com (mail-m19731120.qiye.163.com [220.197.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A461819259A;
	Mon, 24 Feb 2025 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385768; cv=none; b=BUguUwcGVAVspAPNtqi7G7iurXOcWyU9Qb+n237HLro2hQRm0Ryfw3AsXfqnEnM0J7KmSHNAED5kU8vhdbaMGTUBaISjosyiGFEDgARi37IMS7Xkkr1o8bjET9nwyDyBpXIVui+pMTxTnPRnj20ly3OXUbi021AKQnR+pHF1LQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385768; c=relaxed/simple;
	bh=I3YiS7pg9E0UOR2N8R+I9po9/wZsxI7mFrdKExA/MVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sr9qd0bLcylv/LBDcVxbsQAHuaOXNm/0Vpad0HiKyVLqJuO/ca6NUQioNkm24h8+VjVNQlRDqfDOhwXGu6W4laKiOs7fefmqedF43cYEJ3cszoWlu7czX2a1jot8woR4MLrwjeYf2qjFdPgSvX5HVJTS8s0NBKeGGwdNcX/TEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=g3HtaH9Y; arc=none smtp.client-ip=220.197.31.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bfd2879f;
	Mon, 24 Feb 2025 16:13:59 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	boris.brezillon@collabora.com,
	l.stach@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v7 02/15] drm/rockchip: analogix_dp: Expand device data to support multiple edp display
Date: Mon, 24 Feb 2025 16:13:12 +0800
Message-Id: <20250224081325.96724-3-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224081325.96724-1-damon.ding@rock-chips.com>
References: <20250224081325.96724-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5NHlZDTEoeTBkaTBhMGhlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95370525bc03a3kunmbfd2879f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQw6CRw6AzIIIxMfTT5KETJD
	SC8wC09VSlVKTE9LSENPQ09KS0JCVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISktONwY+
DKIM-Signature:a=rsa-sha256;
	b=g3HtaH9YDtf9RQV/XLA+RPk22LW/TKr/xVe6jAp/bzrSg0eE5Hw/Blr0wkHIZqXt6XswF7xyGph4UmQnR9qIOXa6BkND1S/mlJAsPrGaqGU3dcDY0wzWJ0JKbvRaFU7743h6rr9el5pUGSqcphMlKvyNm9AiMQQvPCwfGD8z6AY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=lHxIGASN99m5dXd91pj3fT+U9t8J1461WyjTg1w5KfA=;
	h=date:mime-version:subject:message-id:from;

There are two main modifications: one is expanding struct
rockchip_dp_chip_data to an array, and the other is adding
&rockchip_dp_chip_data.reg to separate different edp devices.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v6:
- Add the description of &rockchip_dp_chip_data.reg
- Use drm_...() uniformly rather than mixing drm_...() and dev_..()

Changes in v7:
- Call dev_err_probe() if failed to find the chip-data
---
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 41 +++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 0d93df6b5144..a8265a1bf9ff 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -52,10 +52,12 @@ struct rockchip_grf_reg_field {
  * struct rockchip_dp_chip_data - splite the grf setting of kind of chips
  * @lcdc_sel: grf register field of lcdc_sel
  * @chip_type: specific chip type
+ * @reg: register base address
  */
 struct rockchip_dp_chip_data {
 	const struct rockchip_grf_reg_field lcdc_sel;
 	u32	chip_type;
+	u32	reg;
 };
 
 struct rockchip_dp_device {
@@ -396,6 +398,8 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 	const struct rockchip_dp_chip_data *dp_data;
 	struct drm_panel *panel = NULL;
 	struct rockchip_dp_device *dp;
+	struct resource *res;
+	int i;
 	int ret;
 
 	dp_data = of_device_get_match_data(dev);
@@ -410,9 +414,24 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 	if (!dp)
 		return -ENOMEM;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	i = 0;
+	while (dp_data[i].reg) {
+		if (dp_data[i].reg == res->start) {
+			dp->data = &dp_data[i];
+			break;
+		}
+
+		i++;
+	}
+
+	if (!dp->data)
+		return dev_err_probe(dev, -EINVAL, "no chip-data for %s node\n",
+				     dev->of_node->name);
+
 	dp->dev = dev;
 	dp->adp = ERR_PTR(-ENODEV);
-	dp->data = dp_data;
 	dp->plat_data.panel = panel;
 	dp->plat_data.dev_type = dp->data->chip_type;
 	dp->plat_data.power_on = rockchip_dp_poweron;
@@ -464,14 +483,22 @@ static int rockchip_dp_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(rockchip_dp_pm_ops, rockchip_dp_suspend,
 		rockchip_dp_resume, NULL);
 
-static const struct rockchip_dp_chip_data rk3399_edp = {
-	.lcdc_sel = GRF_REG_FIELD(0x6250, 5, 5),
-	.chip_type = RK3399_EDP,
+static const struct rockchip_dp_chip_data rk3399_edp[] = {
+	{
+		.lcdc_sel = GRF_REG_FIELD(0x6250, 5, 5),
+		.chip_type = RK3399_EDP,
+		.reg = 0xff970000,
+	},
+	{ /* sentinel */ }
 };
 
-static const struct rockchip_dp_chip_data rk3288_dp = {
-	.lcdc_sel = GRF_REG_FIELD(0x025c, 5, 5),
-	.chip_type = RK3288_DP,
+static const struct rockchip_dp_chip_data rk3288_dp[] = {
+	{
+		.lcdc_sel = GRF_REG_FIELD(0x025c, 5, 5),
+		.chip_type = RK3288_DP,
+		.reg = 0xff970000,
+	},
+	{ /* sentinel */ }
 };
 
 static const struct of_device_id rockchip_dp_dt_ids[] = {
-- 
2.34.1


