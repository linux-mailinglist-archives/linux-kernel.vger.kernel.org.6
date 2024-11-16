Return-Path: <linux-kernel+bounces-411856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D969D0079
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A59B24B87
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D901A3BA1;
	Sat, 16 Nov 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XDvCv4Fx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F11917D0;
	Sat, 16 Nov 2024 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731781373; cv=none; b=O1Hhz/SuoHo/kItWY1Nj+p854X6CIW2gRDBvnhlskh3B9WuF2R5Msj0F2D0McoHhy4ECxqW6qfhMkMEK+mClolg9VztO0gWXmGZ07OYIQo2FbNh77l6Uy9jTUqogQ7oV3bq63tLrN1mZVcyj63acQmkRx3vZaAyXUOl2OGiTVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731781373; c=relaxed/simple;
	bh=xZrD/jL4dNv1NcNZfaSbnGqvkzIAEesN0BD0ysPgDCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVUV7binDLaM4uYJbX1GAdR93CdNO0gYaFrjdLbCsdV0aHxGF689Etsfy58Tck3/ZnRq+vqgJnBY4znYKTMoZDEvaJHyV3r8WavaIgUz65rZ1v7nSVSxEf7qasLfoYUB3215ts+zE1ZzfwjuFlCjvYHO+m9UWMiDKzqtRpc7Vy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XDvCv4Fx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731781364;
	bh=xZrD/jL4dNv1NcNZfaSbnGqvkzIAEesN0BD0ysPgDCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XDvCv4FxsDxUwK8lehYWRqyimYPPIFdPKyuLA1UFo6YYcKj3JFihlgC4AIv+yu11F
	 qTKHgZFCMITVpzi+7PXuQGpba7DpRpWkMWDS5lem25UpbPzqP4AKgMIJ/qOAkcYn8k
	 Fe1+FkByqHjtUniC8XoHNbrNL/IAmPBgArhPRWftp1ihd28JXApe9AtQoSV12t530C
	 NWcdHuK23rWfp9EhBrLJ96mRZwcRFRt4hIKeIkqrzRpNAWU2rZ4mvYFOyjj9Q32pQB
	 rg9NYJSnilGbL8naAFW3IfRnFkX063Aulp7vNWD/sVbbs4ukGx8rQuKMDrC18Jftqn
	 aLRf8tArTiExw==
Received: from localhost (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA52017E377C;
	Sat, 16 Nov 2024 19:22:43 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 16 Nov 2024 20:22:34 +0200
Subject: [PATCH 3/5] drm/rockchip: vop2: Improve display modes handling on
 RK3588 HDMI0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-vop2-hdmi0-disp-modes-v1-3-2bca51db4898@collabora.com>
References: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
In-Reply-To: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The RK3588 specific implementation is currently quite limited in terms
of handling the full range of display modes supported by the connected
screens, e.g. 2560x1440@75Hz, 2048x1152@60Hz, 1024x768@60Hz are just a
few of them.

Additionally, it doesn't cope well with non-integer refresh rates like
59.94, 29.97, 23.98, etc.

Make use of HDMI0 PHY PLL as a more accurate DCLK source to handle
all display modes up to 4K@60Hz.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 3e4c1cfd0bac6fa90f4cab85e27c2a69b86fc9aa..dfe1a50132d596f036430d7db3631398d0802972 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -158,6 +158,7 @@ struct vop2_video_port {
 	struct drm_crtc crtc;
 	struct vop2 *vop2;
 	struct clk *dclk;
+	struct clk *dclk_src;
 	unsigned int id;
 	const struct vop2_video_port_data *data;
 
@@ -212,6 +213,7 @@ struct vop2 {
 	struct clk *hclk;
 	struct clk *aclk;
 	struct clk *pclk;
+	struct clk *pll_hdmiphy0;
 
 	/* optional internal rgb encoder */
 	struct rockchip_rgb *rgb;
@@ -220,6 +222,8 @@ struct vop2 {
 	struct vop2_win win[];
 };
 
+#define VOP2_MAX_DCLK_RATE		600000 /* kHz */
+
 #define vop2_output_if_is_hdmi(x)	((x) == ROCKCHIP_VOP2_EP_HDMI0 || \
 					 (x) == ROCKCHIP_VOP2_EP_HDMI1)
 
@@ -1103,6 +1107,9 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	vop2_crtc_disable_irq(vp, VP_INT_DSP_HOLD_VALID);
 
+	if (vp->dclk_src)
+		clk_set_parent(vp->dclk, vp->dclk_src);
+
 	clk_disable_unprepare(vp->dclk);
 
 	vop2->enable_count--;
@@ -2192,6 +2199,27 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vop2_vp_write(vp, RK3568_VP_MIPI_CTRL, 0);
 
+	/*
+	 * Switch to HDMI PHY PLL as DCLK source for display modes up
+	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
+	 */
+	if (vop2->pll_hdmiphy0 && mode->crtc_clock <= VOP2_MAX_DCLK_RATE) {
+		drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
+			struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
+
+			if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0) {
+				if (!vp->dclk_src)
+					vp->dclk_src = clk_get_parent(vp->dclk);
+
+				ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy0);
+				if (ret < 0)
+					drm_warn(vop2->drm,
+						 "Could not switch to HDMI0 PHY PLL: %d\n", ret);
+				break;
+			}
+		}
+	}
+
 	clk_set_rate(vp->dclk, clock);
 
 	vop2_post_config(crtc);
@@ -3355,6 +3383,12 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(vop2->pclk);
 	}
 
+	vop2->pll_hdmiphy0 = devm_clk_get_optional(vop2->dev, "pll_hdmiphy0");
+	if (IS_ERR(vop2->pll_hdmiphy0)) {
+		drm_err(vop2->drm, "failed to get pll_hdmiphy0\n");
+		return PTR_ERR(vop2->pll_hdmiphy0);
+	}
+
 	vop2->irq = platform_get_irq(pdev, 0);
 	if (vop2->irq < 0) {
 		drm_err(vop2->drm, "cannot find irq for vop2\n");

-- 
2.47.0


