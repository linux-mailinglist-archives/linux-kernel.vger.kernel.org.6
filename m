Return-Path: <linux-kernel+bounces-382245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236929B0B71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485C71C20BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317421767C;
	Fri, 25 Oct 2024 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="qT2re+Nx"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7B22804C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876594; cv=none; b=RdibVsWa+Sz9htG44+6VpnwVetxFpAZxWZaM2Y8b2nCXypNxnGFG5JGqHgJ3IafRcJtZO5jFvAG1drMjXPKjM162myxNLfaytdDwT3qSNW+Fi2gGZfc0F+aS4Tkq2HgHI/FP22w3HCAOa0CcBszDaYGg+pGLj1OnOtVI2+ybmr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876594; c=relaxed/simple;
	bh=IRVZ6Owu3T+A91WqZIsgEYkin9Y418WN74j99JtCWmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKkqr5iGhmk1jEvrhk6MxhkS7obrPEUolNNW75CyrX6pIn14npA+i4wFYlJHTwY/9ZC8Jher+gSWZdSUXflYh1ouxKCjASgSF0CSmDv8hts4ouFc3fQrbtx2Igo8z/T/YWN5qic+Z+6QjXfmD+Oua74zkZ2xRttvjVtUPJSFyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=qT2re+Nx; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d8901cb98so2244154f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876586; x=1730481386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpgFdk3JtzocDW3WFzPDdBLFBiWF0X+yqUm+UTtblgc=;
        b=qT2re+NxFvZ75UR35dfmWb92+GcYbABMwrRPD6Zi9JsLbJTqcjbgi/Q2sBOOwEU3AD
         M6nKc2QmszPPabtEMdUS3PdHJM5smssb6OJGsz7H+L1gLMUOw98sCJdqeShCAR3aDb1d
         S3fq0KjrhE+KhrStX5ijFN/yZu91YUOPZzRac15DtWUVB/xe0PfDjRXWGBxR7Vu3HDQl
         CWSydZjxEQb5ZssLQZFoeI//3QoloV8h3eQTGelj3fZdT59DSOEZ8BV8z5rZ6Z358rI9
         n9hhSa/Ah3KGtNCFfs70qL9cyQ/70PbgQVRwOkCgEmkFsWIP532TIFvEn489okiiBql9
         d9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876586; x=1730481386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpgFdk3JtzocDW3WFzPDdBLFBiWF0X+yqUm+UTtblgc=;
        b=UvNfyOONyjbY7/Lm9hrim1xZJLkdMrwtWXFCmUTGszmDWWlKIXoy+PHc1h1q4Pi6kX
         FDEUIy6rxAZh1chneVRKKn+sb4k8Cz3IywjujYnvGOGIQNTlgEzXISjJVx8djCdqI8yn
         1vN4jeQFInL0NbmG2dqaTi4GHg9kq9gARXk9XRj39BPYizrOBLUlupCl/NQaYN3unSej
         Npe3NkUvM2ZBSYZp8QQlThRw/CPi2ras7ZfI+9ClIZDVlbcOM311Lz719Tbwft2OyiVp
         1Cwsyof6tdApV1R4zIlTpn9g7+cnbq7SFojquUHk8ZxqeLEzpnZM5Nu727vj/4cgGpiZ
         mdGg==
X-Forwarded-Encrypted: i=1; AJvYcCXOUJ7+UU7fwzz/9a08X4dAhrG6R2YqP8MBskvyYOhd5hSVUsi/TD++/2LQK2dgX3Ic1sSvH7UBwMBtRyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6fXaSkoaYfnQdmV+xoI71Fge0O8rxBz/cCp+iR60F4zUbbMD
	vvWg5/A25Q8yqT11J6QeHRQ3wioxuK6uv54SKhYqomPLOVVFpGsCBgvpNCj83DA=
X-Google-Smtp-Source: AGHT+IEjGuncFTNT/SZ4zceoos60e4tV8diFXOXGxrnPO4HgWUpl+fjYGjtIIh1LWTqEDG68tqrqAQ==
X-Received: by 2002:a5d:40c6:0:b0:37d:2d6f:3284 with SMTP id ffacd0b85a97d-38060eb2031mr225091f8f.9.1729876586551;
        Fri, 25 Oct 2024 10:16:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:26 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:57 +0100
Subject: [PATCH v2 26/36] drm/vc4: Add additional warn_on for incorrect
 revisions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-26-35efa83c8fc0@raspberrypi.com>
References: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
In-Reply-To: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

From: Maxime Ripard <mripard@kernel.org>

Some code path in vc4 are conditional to a generation and cannot be
executed on others. Let's put a WARN_ON if that ever happens.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hvs.c   | 30 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/vc4/vc4_kms.c   |  6 ++++++
 drivers/gpu/drm/vc4/vc4_plane.c | 17 +++++++++++++++++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 11acc56ab92d..2493ac17d78f 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -419,12 +419,15 @@ static int vc4_hvs_upload_linear_kernel(struct vc4_hvs *hvs,
 static void vc4_hvs_lut_load(struct vc4_hvs *hvs,
 			     struct vc4_crtc *vc4_crtc)
 {
-	struct drm_device *drm = &hvs->vc4->base;
+	struct vc4_dev *vc4 = hvs->vc4;
+	struct drm_device *drm = &vc4->base;
 	struct drm_crtc *crtc = &vc4_crtc->base;
 	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
 	int idx;
 	u32 i;
 
+	WARN_ON_ONCE(vc4->gen > VC4_GEN_5);
+
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
@@ -474,6 +477,8 @@ u8 vc4_hvs_get_fifo_frame_count(struct vc4_hvs *hvs, unsigned int fifo)
 	u8 field = 0;
 	int idx;
 
+	WARN_ON_ONCE(vc4->gen > VC4_GEN_6_D);
+
 	if (!drm_dev_enter(drm, &idx))
 		return 0;
 
@@ -530,6 +535,8 @@ int vc4_hvs_get_fifo_from_output(struct vc4_hvs *hvs, unsigned int output)
 	u32 reg;
 	int ret;
 
+	WARN_ON_ONCE(vc4->gen > VC4_GEN_6_D);
+
 	switch (vc4->gen) {
 	case VC4_GEN_4:
 		return output;
@@ -621,6 +628,8 @@ static int vc4_hvs_init_channel(struct vc4_hvs *hvs, struct drm_crtc *crtc,
 	u32 dispctrl;
 	int idx;
 
+	WARN_ON_ONCE(vc4->gen > VC4_GEN_5);
+
 	if (!drm_dev_enter(drm, &idx))
 		return -ENODEV;
 
@@ -682,6 +691,8 @@ static int vc6_hvs_init_channel(struct vc4_hvs *hvs, struct drm_crtc *crtc,
 	u32 disp_ctrl1;
 	int idx;
 
+	WARN_ON_ONCE(vc4->gen < VC4_GEN_6_C);
+
 	if (!drm_dev_enter(drm, &idx))
 		return -ENODEV;
 
@@ -707,9 +718,12 @@ static int vc6_hvs_init_channel(struct vc4_hvs *hvs, struct drm_crtc *crtc,
 
 static void __vc4_hvs_stop_channel(struct vc4_hvs *hvs, unsigned int chan)
 {
-	struct drm_device *drm = &hvs->vc4->base;
+	struct vc4_dev *vc4 = hvs->vc4;
+	struct drm_device *drm = &vc4->base;
 	int idx;
 
+	WARN_ON_ONCE(vc4->gen > VC4_GEN_5);
+
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
@@ -740,6 +754,8 @@ static void __vc6_hvs_stop_channel(struct vc4_hvs *hvs, unsigned int chan)
 	struct drm_device *drm = &vc4->base;
 	int idx;
 
+	WARN_ON_ONCE(vc4->gen < VC4_GEN_6_C);
+
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
@@ -927,6 +943,8 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
 	bool found = false;
 	int idx;
 
+	WARN_ON_ONCE(vc4->gen > VC4_GEN_6_D);
+
 	if (!drm_dev_enter(dev, &idx)) {
 		vc4_crtc_send_vblank(crtc);
 		return;
@@ -1011,6 +1029,8 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
 	if (crtc->state->color_mgmt_changed) {
 		u32 dispbkgndx = HVS_READ(SCALER_DISPBKGNDX(channel));
 
+		WARN_ON_ONCE(vc4->gen > VC4_GEN_5);
+
 		if (crtc->state->gamma_lut) {
 			vc4_hvs_update_gamma_lut(hvs, vc4_crtc);
 			dispbkgndx |= SCALER_DISPBKGND_GAMMA;
@@ -1040,6 +1060,8 @@ void vc4_hvs_mask_underrun(struct vc4_hvs *hvs, int channel)
 	u32 dispctrl;
 	int idx;
 
+	WARN_ON(vc4->gen > VC4_GEN_5);
+
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
@@ -1060,6 +1082,8 @@ void vc4_hvs_unmask_underrun(struct vc4_hvs *hvs, int channel)
 	u32 dispctrl;
 	int idx;
 
+	WARN_ON(vc4->gen > VC4_GEN_5);
+
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
@@ -1094,6 +1118,8 @@ static irqreturn_t vc4_hvs_irq_handler(int irq, void *data)
 	u32 status;
 	u32 dspeislur;
 
+	WARN_ON(vc4->gen > VC4_GEN_5);
+
 	/*
 	 * NOTE: We don't need to protect the register access using
 	 * drm_dev_enter() there because the interrupt handler lifetime
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index ce65e152876e..f5b167417428 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -138,6 +138,8 @@ vc4_ctm_commit(struct vc4_dev *vc4, struct drm_atomic_state *state)
 	struct vc4_ctm_state *ctm_state = to_vc4_ctm_state(vc4->ctm_manager.state);
 	struct drm_color_ctm *ctm = ctm_state->ctm;
 
+	WARN_ON_ONCE(vc4->gen > VC4_GEN_5);
+
 	if (ctm_state->fifo) {
 		HVS_WRITE(SCALER_OLEDCOEF2,
 			  VC4_SET_FIELD(vc4_ctm_s31_32_to_s0_9(ctm->matrix[0]),
@@ -213,6 +215,8 @@ static void vc4_hvs_pv_muxing_commit(struct vc4_dev *vc4,
 	struct drm_crtc *crtc;
 	unsigned int i;
 
+	WARN_ON_ONCE(vc4->gen != VC4_GEN_4);
+
 	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
 		struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 		struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc_state);
@@ -256,6 +260,8 @@ static void vc5_hvs_pv_muxing_commit(struct vc4_dev *vc4,
 	unsigned int i;
 	u32 reg;
 
+	WARN_ON_ONCE(vc4->gen != VC4_GEN_5);
+
 	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
 		struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc_state);
 		struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 205aea3ed419..c084967d3527 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -566,8 +566,11 @@ static int vc4_plane_setup_clipping_and_scaling(struct drm_plane_state *state)
 
 static void vc4_write_tpz(struct vc4_plane_state *vc4_state, u32 src, u32 dst)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(vc4_state->base.plane->dev);
 	u32 scale, recip;
 
+	WARN_ON_ONCE(vc4->gen > VC4_GEN_6_D);
+
 	scale = src / dst;
 
 	/* The specs note that while the reciprocal would be defined
@@ -593,10 +596,13 @@ static void vc4_write_tpz(struct vc4_plane_state *vc4_state, u32 src, u32 dst)
 static void vc4_write_ppf(struct vc4_plane_state *vc4_state, u32 src, u32 dst,
 			  u32 xy, int channel)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(vc4_state->base.plane->dev);
 	u32 scale = src / dst;
 	s32 offset, offset2;
 	s32 phase;
 
+	WARN_ON_ONCE(vc4->gen > VC4_GEN_6_D);
+
 	/*
 	 * Start the phase at 1/2 pixel from the 1st pixel at src_x.
 	 * 1/4 pixel for YUV.
@@ -825,8 +831,11 @@ static size_t vc6_upm_size(const struct drm_plane_state *state,
 static void vc4_write_scaling_parameters(struct drm_plane_state *state,
 					 int channel)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(state->plane->dev);
 	struct vc4_plane_state *vc4_state = to_vc4_plane_state(state);
 
+	WARN_ON_ONCE(vc4->gen > VC4_GEN_6_D);
+
 	/* Ch0 H-PPF Word 0: Scaling Parameters */
 	if (vc4_state->x_scaling[channel] == VC4_SCALING_PPF) {
 		vc4_write_ppf(vc4_state, vc4_state->src_w[channel],
@@ -1113,6 +1122,11 @@ static const u32 colorspace_coeffs[2][DRM_COLOR_ENCODING_MAX][3] = {
 
 static u32 vc4_hvs4_get_alpha_blend_mode(struct drm_plane_state *state)
 {
+	struct drm_device *dev = state->state->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	WARN_ON_ONCE(vc4->gen != VC4_GEN_4);
+
 	if (!state->fb->format->has_alpha)
 		return VC4_SET_FIELD(SCALER_POS2_ALPHA_MODE_FIXED,
 				     SCALER_POS2_ALPHA_MODE);
@@ -1137,6 +1151,9 @@ static u32 vc4_hvs5_get_alpha_blend_mode(struct drm_plane_state *state)
 	struct drm_device *dev = state->state->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
+	WARN_ON_ONCE(vc4->gen != VC4_GEN_5 && vc4->gen != VC4_GEN_6_C &&
+		     vc4->gen != VC4_GEN_6_D);
+
 	switch (vc4->gen) {
 	default:
 	case VC4_GEN_5:

-- 
2.34.1


