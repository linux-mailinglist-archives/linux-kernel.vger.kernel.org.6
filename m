Return-Path: <linux-kernel+bounces-527643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A280BA40DA3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8E91891966
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202C20371C;
	Sun, 23 Feb 2025 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SvqbIkZ/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C31FCCF1;
	Sun, 23 Feb 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740303164; cv=none; b=qEgZZyEg2Vcv9VRayPNqljLVo5NEvtEwTen5PcgZYBcLtikA8TBp/IEVJ9kxgEqDnxWqBJEj63s09Sps6iaabV99WcVk1Go7HXcp/c3MwMlNJXRAtc2fYvxVy6zyYqkiB3HddnyklNAJzO7DKiDJ4a96WBtXBLTU0F8kypTyjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740303164; c=relaxed/simple;
	bh=0OPWL1Pq9MJ+uuqDestb4m/s3yphbnfHKs8L0d5GcPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tj31NKGEP2Y9IpI47zFL77ofhu8uiCHIxj79yUHnTM4C/v8i5rC4i8cBvHW62j7rYNa2toQVgp3oftOqYKvslGXVXUoZePs4n/DYASDbcUOrYx6TxoSNtedan0D5+Hmyrsadl+cuOaQ/47Z04HWz4RucgbNBH2U5gY6xYLIGWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SvqbIkZ/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740303154;
	bh=0OPWL1Pq9MJ+uuqDestb4m/s3yphbnfHKs8L0d5GcPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SvqbIkZ/e8ipm7IDhPI+prNTIqS9yLKUdQsBSQ6erv4wHJk0AHBAE4XecaQP+Ibf/
	 VEOxe7GjI8ypKosnmoaqAVIJrRf/JX3LUJYl9dPRoosLnJ1+Gaga3vmSKB0OBOKGpx
	 IDj4NFuvl38bquAdx8TGPTF9gOZCX3OqjQdFv0DvFZgNeTvEXBEaw+ItiKe2Aywzuk
	 KdXxj3O8xfiCRUsdijuK87mdEJXffBi10C7EkDoJHfl7EDNIu5wot8Pbv42Oy1XPIm
	 zsNRiPX7A5C9n7x5VzohyaeoCa0tcscdSJGU6xFcpBrTmyZFno4Bsk0YW+bAVJ1Giu
	 G+oee4AEvCMlw==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id B45A517E00FC;
	Sun, 23 Feb 2025 10:32:34 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 23 Feb 2025 11:31:37 +0200
Subject: [PATCH v2 1/5] drm/rockchip: vop2: Improve display modes handling
 on RK3588 HDMI1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-vop2-hdmi1-disp-modes-v2-1-f4cec5e06fbe@collabora.com>
References: <20250223-vop2-hdmi1-disp-modes-v2-0-f4cec5e06fbe@collabora.com>
In-Reply-To: <20250223-vop2-hdmi1-disp-modes-v2-0-f4cec5e06fbe@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

The RK3588 specific implementation is currently quite limited in terms
of handling the full range of display modes supported by the connected
screens, e.g. 2560x1440@75Hz, 2048x1152@60Hz, 1024x768@60Hz are just a
few of them.

Additionally, it doesn't cope well with non-integer refresh rates like
59.94, 29.97, 23.98, etc.

Make use of HDMI1 PHY PLL as a more accurate DCLK source to handle
all display modes up to 4K@60Hz.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index afc946ead87091373605e59dbca281a9e91bea57..14e039e9143ab855f32c392c5b097b97bcba70b8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -216,6 +216,7 @@ struct vop2 {
 	struct clk *aclk;
 	struct clk *pclk;
 	struct clk *pll_hdmiphy0;
+	struct clk *pll_hdmiphy1;
 
 	/* optional internal rgb encoder */
 	struct rockchip_rgb *rgb;
@@ -2270,11 +2271,14 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 	 * Switch to HDMI PHY PLL as DCLK source for display modes up
 	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
 	 */
-	if (vop2->pll_hdmiphy0 && clock <= VOP2_MAX_DCLK_RATE) {
+	if ((vop2->pll_hdmiphy0 || vop2->pll_hdmiphy1) && clock <= VOP2_MAX_DCLK_RATE) {
 		drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
 			struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
 
 			if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0) {
+				if (!vop2->pll_hdmiphy0)
+					break;
+
 				if (!vp->dclk_src)
 					vp->dclk_src = clk_get_parent(vp->dclk);
 
@@ -2284,6 +2288,20 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 						 "Could not switch to HDMI0 PHY PLL: %d\n", ret);
 				break;
 			}
+
+			if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI1) {
+				if (!vop2->pll_hdmiphy1)
+					break;
+
+				if (!vp->dclk_src)
+					vp->dclk_src = clk_get_parent(vp->dclk);
+
+				ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy1);
+				if (ret < 0)
+					drm_warn(vop2->drm,
+						 "Could not switch to HDMI1 PHY PLL: %d\n", ret);
+				break;
+			}
 		}
 	}
 
@@ -3733,6 +3751,11 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(vop2->pll_hdmiphy0);
 	}
 
+	vop2->pll_hdmiphy1 = devm_clk_get_optional(vop2->dev, "pll_hdmiphy1");
+	if (IS_ERR(vop2->pll_hdmiphy1))
+		return dev_err_probe(drm->dev, PTR_ERR(vop2->pll_hdmiphy1),
+				     "failed to get pll_hdmiphy1\n");
+
 	vop2->irq = platform_get_irq(pdev, 0);
 	if (vop2->irq < 0) {
 		drm_err(vop2->drm, "cannot find irq for vop2\n");

-- 
2.48.1


