Return-Path: <linux-kernel+bounces-272510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651D2945D58
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8945E1C21199
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F91E287F;
	Fri,  2 Aug 2024 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQmksAoS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C521DE85F;
	Fri,  2 Aug 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598978; cv=none; b=LnnqISRd5ywgXlq7eQQdARAjuVsQNEiZzpifCSFiOvjmg2b5VNWGgjq1kij/l1QbeikEB6eDRdAf/CvM680ous+NyWAFi1VnfRCsphRz+gEMtfLCc2y7eiIwVJvaZl7XLbDknelvuI7ZHNOvYef1veqpkw/I75PGIyOrt6isb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598978; c=relaxed/simple;
	bh=b8Xs2J80fSj/Uzmor/bUqJW5KAyUX2rnjFMQLV06hMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B2pVEcmL48wQor0PlbHfo1XKGZlgB/kFeBjVL2+Y5eGlV8mjZqdQmmAjnlyuYUJAvA5Npz4hYSUnjXzOs3CLScgTJiS6Zl26sGxBGohFPVm5SxysfdbPDvek3Q51+iVbCCw2sRvyttNQvOPvJZTvHVtzhoe4Ai+Waz5POfJnYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQmksAoS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f15dd0b489so9754271fa.3;
        Fri, 02 Aug 2024 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722598975; x=1723203775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOwlLJ3ofGI0TikYJvkZxHGMFAPFrL5NOyAVPrWUQ+k=;
        b=KQmksAoSg8YgKxap8TQnaCHPO9JJyKaRhbZ0Mc/gX1cpIVrCwgb/iGuC8UvX6Mrkx8
         eC+OtsUmqLxhKbX8+kAZ1yNDjyokNgi8f7hxl9QhlINLB2Y3SI1m4uY8zhotDNgnfHh7
         gtneW9oCincp5wyTVaB8Bx6zVoQDEEm1mi3+xqfH1TlqUB4NHnhBTdGzPgxNn0QwhiaZ
         mUAjYlta9yunX1tBngr6g71uqKgo5RMDfCUFamS8hfbQ+pCBZgefKxyZbPe7FU33AkAd
         HSmnkcFoY2UplL35Fc8UPVQvCQn2LjuSO2Qcjj26tKpkkf1OagFmreBWqksp5HtVPhMw
         9qHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722598975; x=1723203775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOwlLJ3ofGI0TikYJvkZxHGMFAPFrL5NOyAVPrWUQ+k=;
        b=mG3UfvPdirZ2kAj1DvT1ITTK8jnPQ2v7l+6ehSJcTY13zry75AYNo/QUx+FJjWSrU8
         FJAxHbfNEbAv2OCzvHF53kMsF1bLQViEnmpd6qVOyKiijeAO3m9KaoigMuKifYDyaPfJ
         lGnSRDwdt0566gOsEbm8fnL9+Jy10Fh1MJ1OC1VkJie6TnFjijSh9hFg5YGyb4+lUdzP
         bXbubdEZ12ocdrhad7bg3qRaCtsduhUcE39yzPTjz2PsMO8WzkKOD93RSRRo39Y1F+ea
         iLMdDGYw/YY/GVrzenrwBjWS2bhLtaHG8jWKEjyFQklgc4ICThvLtm7ZVMK3KHDgr1nx
         4tFg==
X-Forwarded-Encrypted: i=1; AJvYcCVcxMbTD8y1Tr1vyFzQLNM75iA/MhwrwdnXBNlPKxx6g8bu+CtHYQQupBrVHaO0e4K5zYqrsxX0Ev7/SMhWcVdl7S4SGj/4KMhSafXz
X-Gm-Message-State: AOJu0YzAfiY8+hWtES2pPZxOa0nKZk4n9A5k/LCLTdMxOGfXhdhIoaED
	g1nBvpVYigszjvQa47w2MoNvfG7AHgLBrcDiGYEGRQlovNFdSSD8BX7N1D5h
X-Google-Smtp-Source: AGHT+IG+hjnJrqP5K8N5VX1i9PsnTAXDZwc4jEIMQBxc57qkv2RRrZbZV6TiQhmdzFY+TrIqpfM45w==
X-Received: by 2002:a2e:4941:0:b0:2ef:28d2:39cc with SMTP id 38308e7fff4ca-2f15aa7187bmr22236801fa.3.1722598974134;
        Fri, 02 Aug 2024 04:42:54 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6cd8d67sm30582345e9.0.2024.08.02.04.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:42:53 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Jun Lei <jun.lei@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui.Pan@amd.com,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: remove extraneous ; after statements
Date: Fri,  2 Aug 2024 12:42:52 +0100
Message-Id: <20240802114252.449452-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a several statements with two following semicolons, replace
these with just one semicolon.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c  | 2 +-
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 2 +-
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c    | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c              | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 65776602648d..9956974c4527 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -1040,7 +1040,7 @@ void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state
 void dml21_extract_legacy_watermark_set(const struct dc *in_dc, struct dcn_watermarks *watermark, enum dml2_dchub_watermark_reg_set_index reg_set_idx, struct dml2_context *in_ctx)
 {
 	struct dml2_core_internal_display_mode_lib *mode_lib = &in_ctx->v21.dml_init.dml2_instance->core_instance.clean_me_up.mode_lib;
-	double refclk_freq_in_mhz = (in_ctx->v21.display_config.overrides.hw.dlg_ref_clk_mhz > 0) ? (double)in_ctx->v21.display_config.overrides.hw.dlg_ref_clk_mhz : mode_lib->soc.dchub_refclk_mhz;;
+	double refclk_freq_in_mhz = (in_ctx->v21.display_config.overrides.hw.dlg_ref_clk_mhz > 0) ? (double)in_ctx->v21.display_config.overrides.hw.dlg_ref_clk_mhz : mode_lib->soc.dchub_refclk_mhz;
 
 	if (reg_set_idx >= DML2_DCHUB_WATERMARK_SET_NUM) {
 		/* invalid register set index */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 13f2c80bad4c..54197d18ab19 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7218,7 +7218,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 #if defined(DV_BUILD)
 		// Assume a memory config setting of 3 in 420 mode or get a new ip parameter that reflects the programming.
 		if (mode_lib->ms.BytePerPixelC[k] != 0.0 && display_cfg->plane_descriptors[k].pixel_format != dml2_rgbe_alpha) {
-			lb_buffer_size_bits_luma = 34620 * 57;;
+			lb_buffer_size_bits_luma = 34620 * 57;
 			lb_buffer_size_bits_chroma = 13560 * 57;
 		}
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
index c54c29711a65..8f3c1c0b1cc1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
@@ -6464,8 +6464,8 @@ static void CalculateSwathAndDETConfiguration(struct dml2_core_internal_scratch
 			p->SwathHeightC[k] = l->MaximumSwathHeightC[k] / 2;
 			l->RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k] / 2;
 			l->RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k] / 2;
-			p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
-			p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
+			p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
+			p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
 		}
 
 		if (p->SwathHeightC[k] == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 7655501e75d4..9e8ff3a9718e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -421,7 +421,7 @@ unsigned int dml2_calc_max_scaled_time(
 
 void dml2_extract_writeback_wm(struct dc_state *context, struct display_mode_lib_st *dml_core_ctx)
 {
-	int i, j = 0;;
+	int i, j = 0;
 	struct mcif_arb_params *wb_arb_params = NULL;
 	struct dcn_bw_writeback *bw_writeback = NULL;
 	enum mmhubbub_wbif_mode wbif_mode = PACKED_444_FP16; /*for now*/
-- 
2.39.2


