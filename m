Return-Path: <linux-kernel+bounces-528383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF494A41723
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50781173666
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6018732B;
	Mon, 24 Feb 2025 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KVtLZnR2"
Received: from mail-m3298.qiye.163.com (mail-m3298.qiye.163.com [220.197.32.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13E5D8F0;
	Mon, 24 Feb 2025 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385158; cv=none; b=TJSw4rdpmdr9xBoumi49emqKL8IzGg6op0LJM09F4/siDOQmYBydo0cuvL+mER/AJdqvp8M7vRTkQ1IFt6MKIMUMqbrZ1/UTD7uhGLZuY9VUn8/tCnvRa8qwozk4/Z2Gd58ipni5QBv4v9vbFqOUQRncju2AyGCeOtgV/KaUf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385158; c=relaxed/simple;
	bh=Sek2ZphyNHaJ+Ru7vO98mkXvniDKzHpeNP+ZcytH11Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6tENDOfHURXeHJswodrSlzXMlbYdg0CCCqYRD5YkJEbaVt0tzpSJaOWO6y5PEvs0cF/ZoNbTDpD3ag2BM3p2nePO7VRlZyn2O9BM+BoQQE4bCC1abDVQHJn+zw2RpeknYq8QCq51vXOIPP3q3ziXVRYngIeyQNd+w1f1eDmFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KVtLZnR2; arc=none smtp.client-ip=220.197.32.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bfd28788;
	Mon, 24 Feb 2025 16:13:56 +0800 (GMT+08:00)
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
Subject: [PATCH v7 01/15] drm/rockchip: analogix_dp: Use formalized struct definition for grf field
Date: Mon, 24 Feb 2025 16:13:11 +0800
Message-Id: <20250224081325.96724-2-damon.ding@rock-chips.com>
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
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpKGFZJH0lNHU4aGk9JQk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9537051cda03a3kunmbfd28788
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P1E6ORw4PzILERMxCD0CEToP
	FApPCQ9VSlVKTE9LSENPQ0hDQkxOVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTU1DNwY+
DKIM-Signature:a=rsa-sha256;
	b=KVtLZnR2FSrrM27t5EQ5+cHBVwTgOA6SmY0fdULygZKvmcBwLgGfEjVFcP0FR7gLQOu6esS59caaJLUOR6e/luji1jkiKo4GoWzjSafGuwDto4/rnw/V1MXaBcpdeMSJWKQdi2GiRXGKLau7hU0gzsrdDH0JGH79xtVWozzXzxA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=DeKL38QgJPxWr8vk6VR+WnpBvTZ9seV20fol6Q/bbw8=;
	h=date:mime-version:subject:message-id:from;

The formalized struct definition will makes grf field operations more
concise and easier to extend.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Initialize struct rockchip_dp_chip_data rk3399_edp/rk3288_dp in order
  of its members

Changes in v6:
- Pass 'dp' in drm_...() rather than 'dp->drm_dev'

Changes in v7:
- Just keep the DRM_...() as they were in the previous for this series
---
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 77 +++++++++++--------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 0844175c37c5..0d93df6b5144 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -32,26 +32,29 @@
 
 #include "rockchip_drm_drv.h"
 
-#define RK3288_GRF_SOC_CON6		0x25c
-#define RK3288_EDP_LCDC_SEL		BIT(5)
-#define RK3399_GRF_SOC_CON20		0x6250
-#define RK3399_EDP_LCDC_SEL		BIT(5)
-
-#define HIWORD_UPDATE(val, mask)	(val | (mask) << 16)
-
 #define PSR_WAIT_LINE_FLAG_TIMEOUT_MS	100
 
+#define GRF_REG_FIELD(_reg, _lsb, _msb) {	\
+				.reg = _reg,	\
+				.lsb = _lsb,	\
+				.msb = _msb,	\
+				.valid = true,	\
+				}
+
+struct rockchip_grf_reg_field {
+	u32 reg;
+	u32 lsb;
+	u32 msb;
+	bool valid;
+};
+
 /**
  * struct rockchip_dp_chip_data - splite the grf setting of kind of chips
- * @lcdsel_grf_reg: grf register offset of lcdc select
- * @lcdsel_big: reg value of selecting vop big for eDP
- * @lcdsel_lit: reg value of selecting vop little for eDP
+ * @lcdc_sel: grf register field of lcdc_sel
  * @chip_type: specific chip type
  */
 struct rockchip_dp_chip_data {
-	u32	lcdsel_grf_reg;
-	u32	lcdsel_big;
-	u32	lcdsel_lit;
+	const struct rockchip_grf_reg_field lcdc_sel;
 	u32	chip_type;
 };
 
@@ -84,6 +87,26 @@ static struct rockchip_dp_device *pdata_encoder_to_dp(struct analogix_dp_plat_da
 	return container_of(plat_data, struct rockchip_dp_device, plat_data);
 }
 
+static int rockchip_grf_write(struct regmap *grf, u32 reg, u32 mask, u32 val)
+{
+	return regmap_write(grf, reg, (mask << 16) | (val & mask));
+}
+
+static int rockchip_grf_field_write(struct regmap *grf,
+				    const struct rockchip_grf_reg_field *field,
+				    u32 val)
+{
+	u32 mask;
+
+	if (!field->valid)
+		return 0;
+
+	mask = GENMASK(field->msb, field->lsb);
+	val <<= field->lsb;
+
+	return rockchip_grf_write(grf, field->reg, mask, val);
+}
+
 static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
 {
 	reset_control_assert(dp->rst);
@@ -181,7 +204,6 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder,
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
 	int ret;
-	u32 val;
 
 	crtc = rockchip_dp_drm_get_new_crtc(encoder, state);
 	if (!crtc)
@@ -192,24 +214,19 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder,
 	if (old_crtc_state && old_crtc_state->self_refresh_active)
 		return;
 
-	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
-	if (ret < 0)
-		return;
-
-	if (ret)
-		val = dp->data->lcdsel_lit;
-	else
-		val = dp->data->lcdsel_big;
-
-	DRM_DEV_DEBUG(dp->dev, "vop %s output to dp\n", (ret) ? "LIT" : "BIG");
-
 	ret = clk_prepare_enable(dp->grfclk);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dp->dev, "failed to enable grfclk %d\n", ret);
 		return;
 	}
 
-	ret = regmap_write(dp->grf, dp->data->lcdsel_grf_reg, val);
+	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
+	if (ret < 0)
+		return;
+
+	DRM_DEV_DEBUG(dp->dev, "vop %s output to dp\n", (ret) ? "LIT" : "BIG");
+
+	ret = rockchip_grf_field_write(dp->grf, &dp->data->lcdc_sel, ret);
 	if (ret != 0)
 		DRM_DEV_ERROR(dp->dev, "Could not write to GRF: %d\n", ret);
 
@@ -448,16 +465,12 @@ static DEFINE_RUNTIME_DEV_PM_OPS(rockchip_dp_pm_ops, rockchip_dp_suspend,
 		rockchip_dp_resume, NULL);
 
 static const struct rockchip_dp_chip_data rk3399_edp = {
-	.lcdsel_grf_reg = RK3399_GRF_SOC_CON20,
-	.lcdsel_big = HIWORD_UPDATE(0, RK3399_EDP_LCDC_SEL),
-	.lcdsel_lit = HIWORD_UPDATE(RK3399_EDP_LCDC_SEL, RK3399_EDP_LCDC_SEL),
+	.lcdc_sel = GRF_REG_FIELD(0x6250, 5, 5),
 	.chip_type = RK3399_EDP,
 };
 
 static const struct rockchip_dp_chip_data rk3288_dp = {
-	.lcdsel_grf_reg = RK3288_GRF_SOC_CON6,
-	.lcdsel_big = HIWORD_UPDATE(0, RK3288_EDP_LCDC_SEL),
-	.lcdsel_lit = HIWORD_UPDATE(RK3288_EDP_LCDC_SEL, RK3288_EDP_LCDC_SEL),
+	.lcdc_sel = GRF_REG_FIELD(0x025c, 5, 5),
 	.chip_type = RK3288_DP,
 };
 
-- 
2.34.1


