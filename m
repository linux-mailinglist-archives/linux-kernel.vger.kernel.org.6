Return-Path: <linux-kernel+bounces-427216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D79DFE43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7326280DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C51FDE24;
	Mon,  2 Dec 2024 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inlD5oQB"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3A1FCCE8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134011; cv=none; b=Ha6kZOQXLaqQ2i+l17X8efqql2EsHZWnSwSbjPbCoXfRtHmjzxwZ83bLJUppdQq/IO4N4g7mGhHzNHZEqX+TQwmDHi1TVd0ZQCzu57Y4bgCDxKvHK/Yghfx7tWiU37xFL5GnmfFgpeK3NMT0AV+eg5Nhmnf0ocILtHS6dQTUyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134011; c=relaxed/simple;
	bh=AR2ot2ScldeaKrjr/qeTAbSFGVp+4LY+MmiRX3d+ewg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtnxalfU9XM2xRqU7pJWQn0rrcjjpNqaUxRmNUXnfixNJ5k5NbJXNnM5X6fI3k1/YClr4NasGLQh/rCmrt/KhrgQLqq1uKV7YdYLlZ8UG+MvIipsl8qwzK1JwyNTzWUEJVaS884vyvOuUSGgJsKn72YZ+2HfAmkA6TOwMYbUGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=inlD5oQB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e0844ee50so999422e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733134007; x=1733738807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKmZ4meMm9nE0dI/BvNTGi28DshZDKFMZdPFX/d5o80=;
        b=inlD5oQBqSmErD2KNqX+KpOynyURYSvfQyyjzEcfOhbwyVsDrIzpG+t0vwv6FhzCrH
         5DPAxdDD1wp6deCQMqhXp929Z5nsKsxT3OcLMsf8FWBdVTJZvHJpy2XR14/fD3LcxUXN
         clBbYBTVsLHFU9IHfjO+lJ8JdxEaKkcIul3xS6fO0gpt8phL4OZiHbYTCt47VBRZ3WlK
         RZIOz3gLbgrJ6Cwt8kJ/lsnw+xsqS5802jhDlXuSmZZx8SNxLk693blr6I9nzOP2RpI3
         NfGJLXSyOx3DX7pwQd2n0vPu+nxrAj26NRoksRvCJNHXj7PTf6F34etTk/THqa03H4Xi
         jOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134007; x=1733738807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKmZ4meMm9nE0dI/BvNTGi28DshZDKFMZdPFX/d5o80=;
        b=vbjkWTIYNKHjeoN4vHW3AU/4Lt3v0TkrlS+rVNj6D6h2PModDaDjTeJPoWaScifh/B
         TLpbQ3xPzil8qfrN9yvHAPm+owE9gEqQ77CApQeDB9juotIpG0x8ye3OWCB2RN+X5fOh
         gP/NLw/RvrDZfuybin4hzRZyf4aPrvUHmokqYDzvX66S4TI4vuMgBqFi/66e7FhKj+bx
         9S4eEXElZfcgj7nVv5GLfESZs0TikqQyZGGjli37M5fS77zJZ74t71loZyxOgYFY6l+e
         AlWeivLBs7deRV5g730qRt/EBWuNWAbSXS9cWn+j+0QRhubm/qo8PMHf+uCnDGrU+Scm
         HarA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Rb6kMUST+L49/AFeIbW2uAVAdIWZkl9LAQbVrwoqWuksg22CdIgnuGvbhqOOicjI+9vzoFZeFbzlhkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwadXHpvwMoYs39whurad77NEaODMTWNpEPkxgb81Y9HGnE90LP
	U4xgIyru25JZ4jX+UbRUYPlLOO1ZplbT1eN6kc93twpca8zD1XjTU9+Q4F4DSgU=
X-Gm-Gg: ASbGnctr64fPitMNuIA6BTUz1wGQLQXeEC9RUKbMeGh5wm+20xlURxPRENhFBuvMkie
	bj0ygthVkI8oFpPW1Zd0cigywel6KH0vnapHyE/iekRLGa/F0TbnUnXnoVyyuvntYbDsg/MqOL/
	gST7LPtluH1XtvthvEYIzTw613v5idEZifdB+57HHRaWzl5qpXE6Z39GZANe7Gyoi/yXj13Aq2J
	pOo26eruX85E3RJIAPyct5hq7fUaZYlJZPFtKH6KM9EJ6QP+2p+hv6tjg==
X-Google-Smtp-Source: AGHT+IFdz74bhOiErirLg1uVa/kS6L6ABLXhjVEgRvnq7b4eLRGlp15VVcv/hGaB6m/2IrwrF6cJWQ==
X-Received: by 2002:a05:6512:2355:b0:53d:dbec:9f51 with SMTP id 2adb3069b0e04-53df00d9e17mr9650818e87.29.1733134007450;
        Mon, 02 Dec 2024 02:06:47 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f191sm1418314e87.136.2024.12.02.02.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:06:46 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 02 Dec 2024 12:06:33 +0200
Subject: [PATCH v2 03/14] drm/msm/dp: drop msm_dp_panel_dump_regs() and
 msm_dp_catalog_dump_regs()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-fd-dp-audio-fixup-v2-3-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4566;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AR2ot2ScldeaKrjr/qeTAbSFGVp+4LY+MmiRX3d+ewg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnTYasvLhVXT1PoULbzt8jxFufYyZm5wLqC0S3i
 etxsT7zaN6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ02GrAAKCRCLPIo+Aiko
 1QTMB/0QU5l53Y8AaEI4u3qBcu1vjCe+gJ6SbK+ZINkaHnJfgj9KnI09BOlWj3maNvD3H0x9nWs
 5JChhscj/5Z1F6zUok+rqKwnW/XiJa/9i+ILWKi71GsHrw0m5PH4m09Lze8FNxo7EyaciEwy+VA
 Xy0tK2MmQuxbVzXdHflNyEmAg7qu8YyPIe1onCJcMBpUbdgRrKTGqaTQIv/3/7dBuy90Y17KxkY
 OiLnpserbAP/YdHO4bhgoxdp4kcU9qNwe+dtTDjKTh5Mo0nDk/plPbzzghPa5Rhow3yMlimnjbD
 R3Egc6UEfeJOW/QGiBnig7ehonUgcdHkBfjLn2pGhIWVlids
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The msm_dp_panel_dump_regs() and msm_dp_catalog_dump_regs() are not
called anywhere. If there is a necessity to dump registers, the
snapshotting should be used instead. Drop these two functions.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 37 -------------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h |  1 -
 drivers/gpu/drm/msm/dp/dp_panel.c   | 11 -----------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  1 -
 4 files changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index b4c8856fb25d01dd1b30c5ec33ce821aafa9551d..0357dec1acd5773f25707e7ebdfca4b1d2b1bb4e 100644
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


