Return-Path: <linux-kernel+bounces-349228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03898F2C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC71F21F16
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3FC1A0722;
	Thu,  3 Oct 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ScOmHMUv"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CD19B59F
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970082; cv=none; b=dOxOVYQfdeuqvW5s5dajLlbCFK0uJ4NsdCOAyN6ArgMBo3FY74m9XSSG8PqeqkkTd7y4lvcQCbS7FhycEYq+uSriRCQAwBtvvPPQyJGlaA19AuPd/wB0SaWKvsmxpM9CcSJ/f7oXh9NKTMztQrA/kG1fQdcaC2n7pOvWKdg6ZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970082; c=relaxed/simple;
	bh=4o2aGwPAsNoDYjUiEVkBx2txeHVKwL3MJan4RFUlyac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FPcrrSE7iBR1L+OyCehmX6PGaYxvrlvRikzUpBR3J5xhCgarcSzhmAGhS3ljlw8g3TcoVUE9auGySeRKFCdi7VG/++PkAlLWWv+N2NBsoYppa5L43pyswP2a8fyxg7isiacX9xO5+0dQaxbikfLLz3Mn3h3WC2lNrHzQleJ4Cbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ScOmHMUv; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41E311C0009;
	Thu,  3 Oct 2024 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727970078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BKWD6hfTMRkpZo2ZTaxz+r8w/HY52vT+fbu92PFcE9s=;
	b=ScOmHMUvC7xTjrm0RsHIt2m+5fM22lL6oD+svynm9Z9mlssrUMRNcieZnazTreCq8WV6g/
	AmPLV7K+pZ/V567a/DRDawRGppMGf2ErvJJPdMDtXE+uZlDSesB++J+Te7J0/KtGMwAZ4V
	LgzDF3rgnRmynbBqkA4DZDghusE7Wc5Gjwis3L321a4Cqjb5taN3VeQtVZ2/DisickF33K
	2OUQ4StlMj52kc3SCF5LQLS8PM+CkH8dkXoe1dTmlc55cPq5AeG4qF28MlKNp32mE/1voW
	UaZT0YqU5HfvXa5+CmlPV388JuxdXpvPETRNscXwA6BVpU9mwfQo0KPGCK5Aaw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 03 Oct 2024 17:41:10 +0200
Subject: [PATCH] drm/vkms: Remove usage of legacy drm_crtc members
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-remove-legacy-v1-1-0b7db1f1a1a6@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABW7/mYC/zWMywrCMBBFfyXM2sE09UV/RbrIY6wDJtVJLJXSf
 zdY3N1z4ZwFMglThk4tIDRx5jFVaHYK/N2mgZBDZTDaHBqtWxSK40T4oMH6D1pzurT27JwPR6j
 OU+jG86937TcWer1rtmwnOJsJ/Rgjl04FiRg5+/1/YKK5QL+uX1DN9fqZAAAA
To: =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3515;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=4o2aGwPAsNoDYjUiEVkBx2txeHVKwL3MJan4RFUlyac=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm/rsceyvbpfFc6ygSZPYZ19SGaTlnk0YPNRMuR
 yu+zxVvRSSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZv67HAAKCRAgrS7GWxAs
 4j/jD/9noNxwHRuLpMwpZ4tBcbdjfn7jbu0n49D1piETfbxOrzU6HY7kBpik+QnPn0bX9fKQJmq
 XBChyd72za8bsKtBz5bbzhjLb67TTIY/ROsdPHo+Yz1PTWjzNFDQtT8K6m8Ufq56FiZNxsROeex
 QfKk9pH2y7fEyyG2szgwy6qH0K0VzTQGRUNllXgetBWMKJ+VvElZ+Nl1pHK3Ubj/RhhBwNzA+XA
 f3hzT+E97AglbrE0yV49WSVV34vEoAifMo0wfzqWx6wyZ+MJYAdqeHO0vnpA5VxCymQWZXqaYig
 Pn2rO/gILyIartTTKteozvzBeLS2A4mEU7XN7GF4LoYwp7TMXz2fujXOODfQWO5yXli2F8wvzzH
 f4bsRITkC2phFoX3tdE+81C1IqikQi80sRylaLbHu3mguZF/oeEIQCvxuo5DTurTjF1dpqUti4v
 wGcPUUSpYaSjdxFmgIi1lSESLYfwp4RS4KIuKKftfG8mYxzPnKbd6AoAvQUy9ZG1gfWGJGoU3pD
 2LirMXtMcafuDBWQ4v4EoA0bIUm2rsBo/3+KjbVnsZm9pxnQaYvSvp5D2lld+vvtdiPlAMnwTiT
 U+JV6/lfuCXDMsVTW8zE0Ki9WwYuXU2vA0Ebm6qe1T5saxv6kCSm3jIDmYNi9PXoDx0WjTrhIl3
 LN/HekVFGKJU4Bg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Some members of the drm_crtc structure have been deprecated in favor of
equivalent members in the drm_crtc_state structure. As reported by Ville
Syrjala [1], the VKMS driver was still using these deprecated fields. This
commit updates the VKMS driver to use the new drm_crtc_state fields
instead.

Additionally, this commit removes the call to
`drm_calc_timestamping_constants` in `vkms_enable_vblank` as it is
redundant. This calculation is already performed in
`vkms_atomic_commit_tail` by calling
`drm_atomic_helper_commit_modeset_disables`.

[1]:https://lore.kernel.org/all/20241002182200.15363-1-ville.syrjala@linux.intel.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c  | 4 ++--
 drivers/gpu/drm/vkms/vkms_crtc.c      | 2 --
 drivers/gpu/drm/vkms/vkms_writeback.c | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 57a5769fc994..3f0977d746be 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -187,7 +187,7 @@ static void blend(struct vkms_writeback_job *wb,
 
 	const struct pixel_argb_u16 background_color = { .a = 0xffff };
 
-	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
+	size_t crtc_y_limit = crtc_state->base.mode.vdisplay;
 
 	/*
 	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
@@ -270,7 +270,7 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
 	if (WARN_ON(check_format_funcs(crtc_state, active_wb)))
 		return -EINVAL;
 
-	line_width = crtc_state->base.crtc->mode.hdisplay;
+	line_width = crtc_state->base.mode.hdisplay;
 	stage_buffer.n_pixels = line_width;
 	output_buffer.n_pixels = line_width;
 
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index a40295c18b48..bbf080d32d2c 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -64,8 +64,6 @@ static int vkms_enable_vblank(struct drm_crtc *crtc)
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 
-	drm_calc_timestamping_constants(crtc, &crtc->mode);
-
 	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	out->vblank_hrtimer.function = &vkms_vblank_simulate;
 	out->period_ns = ktime_set(0, vblank->framedur_ns);
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index bc724cbd5e3a..999d5c01ea81 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -131,8 +131,8 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	struct drm_connector_state *conn_state = wb_conn->base.state;
 	struct vkms_crtc_state *crtc_state = output->composer_state;
 	struct drm_framebuffer *fb = connector_state->writeback_job->fb;
-	u16 crtc_height = crtc_state->base.crtc->mode.vdisplay;
-	u16 crtc_width = crtc_state->base.crtc->mode.hdisplay;
+	u16 crtc_height = crtc_state->base.mode.vdisplay;
+	u16 crtc_width = crtc_state->base.mode.hdisplay;
 	struct vkms_writeback_job *active_wb;
 	struct vkms_frame_info *wb_frame_info;
 	u32 wb_format = fb->format->format;

---
base-commit: cbc1e8696fbea0010a73bf93534c712f9ad177db
change-id: 20241003-remove-legacy-a2683a7bbcd5

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


