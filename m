Return-Path: <linux-kernel+bounces-402221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB99C2524
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F4B5B2411B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4D11AA1CF;
	Fri,  8 Nov 2024 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hV6unLtf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38C1AA1E7;
	Fri,  8 Nov 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091954; cv=none; b=g6hcynMVovLyLww/45peywTUTKu+wz51Pb7U50Zwv3DY+23f2Sx3GrIXCICkreBNCCJIsjvPDTMm6sLdxZRVY46tCeOfqWc12Q7z25FSMhkDhabitD1THhAel4XZOD/qVvwQ8Jnk0EZ9hDoLFThjy4P3Xj8JTjShudduEmkYH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091954; c=relaxed/simple;
	bh=zzcz+Stq2T7s9D0cmgD0YFLHantSHMsqXWl51R2tUCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibn+zg7hOwsd1eFpVYWGYv7ACQfjfXfAuB+g66AIQGghU0u+wF97enDbJULA28iqv8bMKLkoysIKCZJ578N3a8woWQWEd3+XqpVtdhh8Xx16JMSZp7ZMa2/wG3ywvCOXcDQ4CQzR/nAPetVkpiZnbvYXG8n+JmwOwqYeAYsoC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hV6unLtf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731091950;
	bh=zzcz+Stq2T7s9D0cmgD0YFLHantSHMsqXWl51R2tUCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hV6unLtfPWrM3YOLJ3wA7SThBaEEZQUBcI+28bEdF449hvRESbGdf/cxhSau/LDXj
	 U4PLuKGLJi5AVpr2RzIVKRlSMF68j4cN7NaM+WbdP3aoeW+M3fT51wYXmMJ/oYCCaI
	 OK0XQVfsVTlxDKS9QvhttqVeJTs20de7AdeynuA3pIQW/a1b1JAdSRFXGWT2/0fMUe
	 YjYiQxqZPToVWZwZhkp4BZLmYf4cWVpG8rG4O7yTjvKwQGRvo9mklMhmg2IuSnUYnh
	 VI8Ce4h/bSmBDVLl6xy3wjQ/YaiAks+iw2PzP+ztCv0poNFa02+85OBI84EudGSQQ9
	 aYrqnvPfdSGZg==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C1CE817E376C;
	Fri,  8 Nov 2024 19:52:27 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Sandy Huang <hjc@rock-chips.com>,
	Heiko Stubner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Alexey Charkov <alchark@gmail.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 1/3] vop2: Add clock resets support
Date: Fri,  8 Nov 2024 13:50:39 -0500
Message-ID: <20241108185212.198603-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108185212.198603-1-detlev.casanova@collabora.com>
References: <20241108185212.198603-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the end of initialization, each VP clock needs to be reset before
they can be used.

Failing to do so can put the VOP in an undefined state where the
generated HDMI signal is either lost or not matching the selected mode.

This issue can be reproduced by switching modes multiple times.
Depending on the setup, after about 10 mode switches, the signal will be
lost and the value in register 0x890 (VSYNCWIDTH + VFRONT) will take the value
`0x0000018c`.
That makes VSYNCWIDTH=0, which is wrong.

Adding the clock resets after the VOP configuration fixes the issue.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 9873172e3fd3..6122eb18e6c9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/swab.h>
 
 #include <drm/drm.h>
@@ -157,6 +158,7 @@ struct vop2_win {
 struct vop2_video_port {
 	struct drm_crtc crtc;
 	struct vop2 *vop2;
+	struct reset_control *dclk_rst;
 	struct clk *dclk;
 	unsigned int id;
 	const struct vop2_video_port_data *data;
@@ -1917,6 +1919,26 @@ static int us_to_vertical_line(struct drm_display_mode *mode, int us)
 	return us * mode->clock / mode->htotal / 1000;
 }
 
+static int vop2_clk_reset(struct vop2_video_port *vp)
+{
+	struct reset_control *rstc = vp->dclk_rst;
+	struct vop2 *vop2 = vp->vop2;
+	int ret;
+
+	if (!rstc)
+		return 0;
+
+	ret = reset_control_assert(rstc);
+	if (ret < 0)
+		drm_warn(vop2->drm, "failed to assert reset\n");
+	udelay(10);
+	ret = reset_control_deassert(rstc);
+	if (ret < 0)
+		drm_warn(vop2->drm, "failed to deassert reset\n");
+
+	return ret;
+}
+
 static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 				    struct drm_atomic_state *state)
 {
@@ -2057,6 +2079,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vop2_vp_write(vp, RK3568_VP_DSP_CTRL, dsp_ctrl);
 
+	vop2_clk_reset(vp);
+
 	drm_crtc_vblank_on(crtc);
 
 	vop2_unlock(vop2);
@@ -2708,6 +2732,12 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 		vp->data = vp_data;
 
 		snprintf(dclk_name, sizeof(dclk_name), "dclk_vp%d", vp->id);
+		vp->dclk_rst = devm_reset_control_get_optional(vop2->dev, dclk_name);
+		if (IS_ERR(vp->dclk_rst)) {
+		        drm_err(vop2->drm, "failed to get %s reset\n", dclk_name);
+		        return PTR_ERR(vp->dclk_rst);
+		}
+
 		vp->dclk = devm_clk_get(vop2->dev, dclk_name);
 		if (IS_ERR(vp->dclk)) {
 			drm_err(vop2->drm, "failed to get %s\n", dclk_name);
-- 
2.47.0


