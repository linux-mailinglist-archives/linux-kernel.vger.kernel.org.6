Return-Path: <linux-kernel+bounces-446601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645869F26B7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CDEC7A135D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F681C5481;
	Sun, 15 Dec 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmGFi+1i"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065F1C1F20
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302659; cv=none; b=Zut4q8Jqd9YHD43zMJlw9pXTRSseO5n1HNFO6/BwefAxVFJU1+OjSoDYwjuP79UhGqES+UplnbrjPdOeuL4NKhURMEflbUitJpi0NPaa+MKexo5XxgJeGQzoLpqp/knag/jIolZfecfxQk3PBOLFZwYxRgaagUy6DIVgR8KBUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302659; c=relaxed/simple;
	bh=odEAnKN06Sybslt+wjHIuBH83/5gGKUyqyRktEqGDq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ku9ngrhjJ69cz5pdIgkAbVHhB3g42pCGXnWIBtbadgtr0q4LsgsoM3ue9GIqvyHrjwwlhD0blpcxvUlWYNYDGLDUQcbObpySVF/+H49NWuXfvSg9cFz9jn6J1Xnynl+U4p16BnlV9jqTag9tT5W1V/aUnKrVDJWrNGegYZmQVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmGFi+1i; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-300479ca5c6so34484351fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734302656; x=1734907456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FcosjnZ+EYpYsxWV3fspnFWPldQB9eLk6Pr9Uyc9VE=;
        b=kmGFi+1ib5Ay9L15nof4hv/gAkCAnsvnLTJoF7wEI1JCqoBX7KW0n7iVg89qyRz/6Q
         7w+1GEhFptnGPtq8VBep+EV537XSVs4Q30ss8B56EBIy24Qsz7QwFSXkwEsW/VVtWMVK
         2OCj5lNvqoyUz55UuJOB5j5pZUmwbGvjN3jyocxyM0JvFMIk3MO54hHAZyfZ4LhSrDqh
         Y6YeEsSNat0ULsXu29U/Rr0IbBpZB6OBsyyVUgmSq6F5t3LqyreRh0Np9m9JZ8niyy1N
         40WZ+I0qkt8M3pDbO2JhKaD8omJcTempzwUG1kQvGqPHbXQX+DLJ89pN3GHXxrHOq9/u
         cpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734302656; x=1734907456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FcosjnZ+EYpYsxWV3fspnFWPldQB9eLk6Pr9Uyc9VE=;
        b=VdPnbOBfd5OpcHey5hN0UkVCuOWaUFu5ByqzxF2JcOxKBlXoN+F+2waEViYcXfB7F4
         DNqxUxd/bkfVk9yJfIuV732xAmlPsa1xMwmcxgDHaQLt022w7GgVaTTN5sGG4CNiQbNq
         vo1ozPcBsB4QNuPtNGHNWpGJturjc/w8wANHEgY1a+9SU2m+g0K/7x+i1Of8AA6dQAZn
         qXQaYKVAx66RwtKRMvC6PT69HE/FbFfzEWz2dbNqlRk2cKUdhZOpkLZPcExtUnoB05i4
         9AXPNT3ac4G0GhIJwCugTplLHMkDWjWxGr+gj5XGGgWtxOfZ7tv8/eVAU7HophAp5PXJ
         1NtA==
X-Forwarded-Encrypted: i=1; AJvYcCUhqImY8yj4v80CkK7cQ+5DLpNfOnxg+3EhjR40RK0WvSECBu7mXty6k9A8lK9eapq8nd4ZTRj1l3pDADo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOkR+LP9id0qG5Dzd7J4JAs9o0YxOy22BLRcAws6HebzGNSNIc
	zY16aJuhKYDvLx/hQFt9Jcm9j6WrSZctwZGfa0JSOmGcvNGb/pzUq0SwPq0t+K8=
X-Gm-Gg: ASbGncvBWPceLD0zKejR3+6W1c7T0esyLAHlTVcrDHgeRVzTih4I11cwChCatIlTWak
	YU+qUjpgDG3MRc+wma6h5qq1jjhtfQp2fZAXG0kjtBxsGjWzk3zxP8PhRBBm0MAvpLRDDdYuoyL
	Vr+Gmx7R2y7+e9M7F9oorVUfDpjvIFMh03tzdnv+IWFiVMzsfT7U0Ut745lKz7v3XZ8j0ytJnp/
	/upR6Q5cJ/AiiAGfQlB2UWBK0j53Hn1s0dRg4RjxJniMu9InPr8/hZVbSlpiT3U
X-Google-Smtp-Source: AGHT+IG4DJ33Gm3rCir+qxsYYs+bqP1BaR2ZkVqSJ7/w4zdDpw5jPtuvekFuixkKeoThBzLK1i3U6w==
X-Received: by 2002:a05:651c:555:b0:2ff:ae6e:446e with SMTP id 38308e7fff4ca-302544e33a5mr32874111fa.40.1734302655625;
        Sun, 15 Dec 2024 14:44:15 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a41d1sm7201701fa.100.2024.12.15.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 14:44:14 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 00:44:06 +0200
Subject: [PATCH v4 01/16] drm/msm/dp: drop msm_dp_panel_dump_regs() and
 msm_dp_catalog_dump_regs()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fd-dp-audio-fixup-v4-1-f8d1961cf22f@linaro.org>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
In-Reply-To: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4735;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=odEAnKN06Sybslt+wjHIuBH83/5gGKUyqyRktEqGDq4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX1u4upBx874D1UMzYvwmvGy6lDnwOLEjzDpdr
 ZAmXI1cvP+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ19buAAKCRCLPIo+Aiko
 1WlOB/9WTcrueWc2ad6tuALzD/Y3g3rZKNBrv3wbbv1toKN6cEVe0lfE5iLLX8G3ykDYQKk0bTx
 w0qa/zZgKK/h1MrikedGs8XZpGoPmMT6IFCe8IsHUfjoQosSewObHrPblMraEbj3N6guc9kJRsO
 yte3RRvewIHoPk6vUzzIdwIcjEmcfpTuoiWTGhu2PfuZ+2OansjNFFQyztqZD80NtmhxcekzWoU
 o7Vts5p/k1kP+MPficCgzTsJub5yLpqgbGPXY0rtucrtRnS0LP01Gb7tDrcLlnRzLCeY+wrcrur
 q0V2BvuJR8/DnxNMZhwJ7aGwsy92ZdSg01rD6eS7c02Mcott
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The msm_dp_panel_dump_regs() and msm_dp_catalog_dump_regs() are not
called anywhere. If there is a necessity to dump registers, the
snapshotting should be used instead. Drop these two functions.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Tested-by: Stephen Boyd <swboyd@chromium.org> # sc7180-trogdor
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 37 -------------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h |  1 -
 drivers/gpu/drm/msm/dp/dp_panel.c   | 11 -----------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  1 -
 4 files changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 2a755a06ac4905f0ffa55a6df64ae4d948a78c0d..6a30996200bc7fbaacd0502f096e787f754752de 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -276,43 +276,6 @@ int msm_dp_catalog_aux_wait_for_hpd_connect_state(struct msm_dp_catalog *msm_dp_
 				min(wait_us, 2000), wait_us);
 }
 
-static void dump_regs(void __iomem *base, int len)
-{
-	int i;
-	u32 x0, x4, x8, xc;
-	u32 addr_off = 0;
-
-	len = DIV_ROUND_UP(len, 16);
-	for (i = 0; i < len; i++) {
-		x0 = readl_relaxed(base + addr_off);
-		x4 = readl_relaxed(base + addr_off + 0x04);
-		x8 = readl_relaxed(base + addr_off + 0x08);
-		xc = readl_relaxed(base + addr_off + 0x0c);
-
-		pr_info("%08x: %08x %08x %08x %08x", addr_off, x0, x4, x8, xc);
-		addr_off += 16;
-	}
-}
-
-void msm_dp_catalog_dump_regs(struct msm_dp_catalog *msm_dp_catalog)
-{
-	struct msm_dp_catalog_private *catalog = container_of(msm_dp_catalog,
-		struct msm_dp_catalog_private, msm_dp_catalog);
-	struct dss_io_data *io = &catalog->io;
-
-	pr_info("AHB regs\n");
-	dump_regs(io->ahb.base, io->ahb.len);
-
-	pr_info("AUXCLK regs\n");
-	dump_regs(io->aux.base, io->aux.len);
-
-	pr_info("LCLK regs\n");
-	dump_regs(io->link.base, io->link.len);
-
-	pr_info("P0CLK regs\n");
-	dump_regs(io->p0.base, io->p0.len);
-}
-
 u32 msm_dp_catalog_aux_get_irq(struct msm_dp_catalog *msm_dp_catalog)
 {
 	struct msm_dp_catalog_private *catalog = container_of(msm_dp_catalog,
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index e932b17eecbf514070cd8cd0b98ca0fefbe81ab7..62a401d8f75a6af06445a42af657d65e3fe542c5 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -104,7 +104,6 @@ int msm_dp_catalog_panel_timing_cfg(struct msm_dp_catalog *msm_dp_catalog, u32 t
 				u32 sync_start, u32 width_blanking, u32 msm_dp_active);
 void msm_dp_catalog_panel_enable_vsc_sdp(struct msm_dp_catalog *msm_dp_catalog, struct dp_sdp *vsc_sdp);
 void msm_dp_catalog_panel_disable_vsc_sdp(struct msm_dp_catalog *msm_dp_catalog);
-void msm_dp_catalog_dump_regs(struct msm_dp_catalog *msm_dp_catalog);
 void msm_dp_catalog_panel_tpg_enable(struct msm_dp_catalog *msm_dp_catalog,
 				struct drm_display_mode *drm_mode);
 void msm_dp_catalog_panel_tpg_disable(struct msm_dp_catalog *msm_dp_catalog);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 5d7eaa31bf3176566f40f01ff636bee64e81c64f..7d122496723a32fd591d094269397a9fdd51fe44 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -317,17 +317,6 @@ static int msm_dp_panel_setup_vsc_sdp_yuv_420(struct msm_dp_panel *msm_dp_panel)
 	return 0;
 }
 
-void msm_dp_panel_dump_regs(struct msm_dp_panel *msm_dp_panel)
-{
-	struct msm_dp_catalog *catalog;
-	struct msm_dp_panel_private *panel;
-
-	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
-	catalog = panel->catalog;
-
-	msm_dp_catalog_dump_regs(catalog);
-}
-
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel)
 {
 	u32 data, total_ver, total_hor;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 0e944db3adf2f187f313664fe80cf540ec7a19f2..47c1d349be470b60596b64a7bc8c7c39d2e8fdd1 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -55,7 +55,6 @@ struct msm_dp_panel {
 int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_deinit(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel);
-void msm_dp_panel_dump_regs(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
 		struct drm_connector *connector);
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel, u32 mode_max_bpp,

-- 
2.39.5


