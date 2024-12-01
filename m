Return-Path: <linux-kernel+bounces-426688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB26E9DF6B3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1D02815BA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39791D8DFE;
	Sun,  1 Dec 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eUiNqLB0"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10661D86E6
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075245; cv=none; b=fpNGppalkJ44sS3Xm1d6EoCHDrxolx2AutxurZiNbz6NkpWbXc1PArBEX82ogdGWuDjfwsu7z5pAmUa6gsnTpgbsS8oKGVMJ6U94JpPcZdmaSwHv+H5N1WFiN/O7UHa9+pTDZb0fXBTHvZqhlXC1Cf4dnvVOOetTwD6IVAdYB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075245; c=relaxed/simple;
	bh=fzrYQVPRvJThEGfjJPSPJARrs0VXkE93n/LfnSODBwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR2HQ2hN57T2qMdsW47cgidD9hPn9uzxFhcx67hdC/e/wBSjN3FQDeoxRI9n7QuSJDthzrfJ9B0tPjJNruBFbCzaXTDgg1lzhNti0WdEV+M5g3WjEauSZ32cABecPWX+DCMIqwwkHfWdG17JRt5lztPqnTnmxttykaIZtqpEozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=eUiNqLB0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa52edbcb63so795319866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075241; x=1733680041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSqxrvlSOtrilzS4oVqtZQSsrqzIaSxmH6tPcmFaubc=;
        b=eUiNqLB0vfgwI2KUbO0jcxb78JlqtUjjg9VthdNhXTuxvOWwN788sqR6UEDwyK2/Zh
         gr9jqbdYXRY3cPuxOTAPMxMxQx1v+P2ba7qQ4yrTP/b3LcQZiGzlR+tgXprPvUu6SxuT
         mLvRwkSKpKd8yKqRvWgiBK/kVw1W6Y7lY2kYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075241; x=1733680041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSqxrvlSOtrilzS4oVqtZQSsrqzIaSxmH6tPcmFaubc=;
        b=hsLuWuWiW7gE2rHHaT9oZyN3eEdJ4rb7urbeJUmhQoffL4zmBo61Ol/S9wdmAvhyjr
         Jgyk1SflPLSnEuuu3wCskmL4uZ1MALlbJS10PduSCgCz+1DXguHN0IxpaqGsR9WIBxSg
         xm3upkw/7k9pii2caJFAA9b5BhajTgmmATqUCY1ZKp1h3+2tzaZrAoxr++p/me1pESdq
         EXMVXnYAdzGaecVUxYABgiwjWFnI/3ECigPKffr5jKMXjNN1ALJ7NARLbwxRCywruwjT
         kyseuEXE0Y6eWzE4+o0CzcZ/ycWyZhUCuLQsTtfiI2AeTPikHV0lGuPH0/7BoT4JBpxj
         DHJg==
X-Gm-Message-State: AOJu0YwsQ4GCUhgQrZ5fopHMEoU5Ni3mlNnDPYtyigwPlN/pFeZdZ5UG
	y3Bp0BahlPaqkae/YW/JjO1rL38N3TCxU1yPGQpA9QALddSJl83fUZzESqfx8eBzyaHF3I3MUpP
	g
X-Gm-Gg: ASbGncts1DlwQxrbVUnhMxifxNt0rNqqAF0si7iyLqu3LivhrScvUlkEGoBZMkJaCF4
	8t154rcGQlWH93wZdW02Nlg/Vk2FYRx9ehyxtTgQFEtrpB+8dvQO5mhoGxZSFk6pu615GwiobCb
	DONPl1M7eZdoHtUQyNTzmsXXFzbLAdYe1vmr5NNCR7QJYxyG3uCinvqU1fKt405NbuGeMb+P/sK
	QthQt1e7GFDrTrXRUEDj7L60jyJI/J71cmTQeOfHPNe9hnm4SvGTutw++qVc7XTAO/dHQiRMcO2
	Qr+2AuQOsMq2FfOSvJRnb6iMXY68QFPiz7p5kJTw+Sc8nXpDnn0OQ3DtAjMgjh1hz+2F+eK+Tbh
	k+2wLgLBVmTB5Mzpe
X-Google-Smtp-Source: AGHT+IGrdvcmpbGkE9LyZkuNLkGL3XbPf4j6LkwQRMzSCWTNSS9R05Exc7NmQm9dPp1YG6FkFT2QDA==
X-Received: by 2002:a17:907:7fa8:b0:a99:ffa9:a27 with SMTP id a640c23a62f3a-aa594754be2mr1691551966b.26.1733075241067;
        Sun, 01 Dec 2024 09:47:21 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:19 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v4 02/18] clk: imx8mp: rename video_pll1 to video_pll
Date: Sun,  1 Dec 2024 18:46:02 +0100
Message-ID: <20241201174639.742000-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike audio_pll1 and audio_pll2, there is no video_pll2. Further, the
name used in the RM is video_pll. So, let's rename "video_pll1" to
"video_pll" to be consistent with the RM and avoid misunderstandings.

The IMX8MP_VIDEO_PLL1* constants have not been removed to ensure
backward compatibility of the patch.

No functional changes intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

 - Added in v4

---

(no changes since v1)

 drivers/clk/imx/clk-imx8mp.c             | 118 +++++++++++------------
 include/dt-bindings/clock/imx8mp-clock.h |   9 +-
 2 files changed, 65 insertions(+), 62 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 516dbd170c8a..e96460534e7d 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -23,7 +23,7 @@ static u32 share_count_audio;
 static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char * const audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
 static const char * const audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
-static const char * const video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
+static const char * const video_pll_bypass_sels[] = {"video_pll", "video_pll_ref_sel", };
 static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char * const gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
 static const char * const vpu_pll_bypass_sels[] = {"vpu_pll", "vpu_pll_ref_sel", };
@@ -40,27 +40,27 @@ static const char * const imx8mp_a53_core_sels[] = {"arm_a53_div", "arm_pll_out"
 
 static const char * const imx8mp_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m",
 					      "vpu_pll_out", "sys_pll1_800m", "audio_pll1_out",
-					      "video_pll1_out", "sys_pll3_out", };
+					      "video_pll_out", "sys_pll3_out", };
 
 static const char * const imx8mp_ml_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
 					      "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-					      "video_pll1_out", "audio_pll2_out", };
+					      "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_gpu3d_core_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
 						      "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						      "video_pll1_out", "audio_pll2_out", };
+						      "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_gpu3d_shader_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
 							"sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-							"video_pll1_out", "audio_pll2_out", };
+							"video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_gpu2d_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
 						 "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						 "video_pll1_out", "audio_pll2_out", };
+						 "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_audio_axi_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
 						     "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						     "video_pll1_out", "audio_pll2_out", };
+						     "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_hsio_axi_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m",
 						    "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
@@ -72,11 +72,11 @@ static const char * const imx8mp_media_isp_sels[] = {"osc_24m", "sys_pll2_1000m"
 
 static const char * const imx8mp_main_axi_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_1000m", "audio_pll1_out",
-						    "video_pll1_out", "sys_pll1_100m",};
+						    "video_pll_out", "sys_pll1_100m",};
 
 static const char * const imx8mp_enet_axi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
-						    "video_pll1_out", "sys_pll3_out", };
+						    "video_pll_out", "sys_pll3_out", };
 
 static const char * const imx8mp_nand_usdhc_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
@@ -96,35 +96,35 @@ static const char * const imx8mp_media_apb_sels[] = {"osc_24m", "sys_pll2_125m",
 
 static const char * const imx8mp_gpu_axi_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out",
 						   "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						   "video_pll1_out", "audio_pll2_out", };
+						   "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_gpu_ahb_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out",
 						   "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						   "video_pll1_out", "audio_pll2_out", };
+						   "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_noc_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out",
 					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
-					       "video_pll1_out", "audio_pll2_out", };
+					       "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_noc_io_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
-						  "video_pll1_out", "audio_pll2_out", };
+						  "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_ml_axi_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out",
 						  "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						  "video_pll1_out", "audio_pll2_out", };
+						  "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_ml_ahb_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out",
 						  "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						  "video_pll1_out", "audio_pll2_out", };
+						  "video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_ahb_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_800m",
 					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
-					       "audio_pll1_out", "video_pll1_out", };
+					       "audio_pll1_out", "video_pll_out", };
 
 static const char * const imx8mp_audio_ahb_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m",
 						     "sys_pll2_1000m", "sys_pll2_166m", "sys_pll3_out",
-						     "audio_pll1_out", "video_pll1_out", };
+						     "audio_pll1_out", "video_pll_out", };
 
 static const char * const imx8mp_mipi_dsi_esc_rx_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_80m",
 							   "sys_pll1_800m", "sys_pll2_1000m",
@@ -159,56 +159,56 @@ static const char * const imx8mp_pcie_aux_sels[] = {"osc_24m", "sys_pll2_200m",
 						    "sys_pll1_160m", "sys_pll1_200m", };
 
 static const char * const imx8mp_i2c5_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mp_i2c6_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mp_sai1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll_out", "sys_pll1_133m", "osc_hdmi",
 						"clk_ext1", "clk_ext2", };
 
 static const char * const imx8mp_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll_out", "sys_pll1_133m", "osc_hdmi",
 						"clk_ext2", "clk_ext3", };
 
 static const char * const imx8mp_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll_out", "sys_pll1_133m", "osc_hdmi",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mp_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll_out", "sys_pll1_133m", "osc_hdmi",
 						"clk_ext2", "clk_ext3", };
 
 static const char * const imx8mp_sai6_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll_out", "sys_pll1_133m", "osc_hdmi",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mp_enet_qos_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
-						    "video_pll1_out", "clk_ext4", };
+						    "video_pll_out", "clk_ext4", };
 
 static const char * const imx8mp_enet_qos_timer_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out",
 							  "clk_ext1", "clk_ext2", "clk_ext3",
-							  "clk_ext4", "video_pll1_out", };
+							  "clk_ext4", "video_pll_out", };
 
 static const char * const imx8mp_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
-						    "video_pll1_out", "clk_ext4", };
+						    "video_pll_out", "clk_ext4", };
 
 static const char * const imx8mp_enet_timer_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out",
 						      "clk_ext1", "clk_ext2", "clk_ext3",
-						      "clk_ext4", "video_pll1_out", };
+						      "clk_ext4", "video_pll_out", };
 
 static const char * const imx8mp_enet_phy_ref_sels[] = {"osc_24m", "sys_pll2_50m", "sys_pll2_125m",
 							"sys_pll2_200m", "sys_pll2_500m", "audio_pll1_out",
-							"video_pll1_out", "audio_pll2_out", };
+							"video_pll_out", "audio_pll2_out", };
 
 static const char * const imx8mp_nand_sels[] = {"osc_24m", "sys_pll2_500m", "audio_pll1_out",
 						"sys_pll1_400m", "audio_pll2_out", "sys_pll3_out",
-						"sys_pll2_250m", "video_pll1_out", };
+						"sys_pll2_250m", "video_pll_out", };
 
 static const char * const imx8mp_qspi_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll2_333m",
 						"sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
@@ -223,19 +223,19 @@ static const char * const imx8mp_usdhc2_sels[] = {"osc_24m", "sys_pll1_400m", "s
 						  "audio_pll2_out", "sys_pll1_100m", };
 
 static const char * const imx8mp_i2c1_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mp_i2c2_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mp_i2c3_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mp_i2c4_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mp_uart1_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
@@ -276,42 +276,42 @@ static const char * const imx8mp_ecspi2_sels[] = {"osc_24m", "sys_pll2_200m", "s
 
 static const char * const imx8mp_pwm1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
-						"sys_pll1_80m", "video_pll1_out", };
+						"sys_pll1_80m", "video_pll_out", };
 
 static const char * const imx8mp_pwm2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
-						"sys_pll1_80m", "video_pll1_out", };
+						"sys_pll1_80m", "video_pll_out", };
 
 static const char * const imx8mp_pwm3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
-						"sys_pll1_80m", "video_pll1_out", };
+						"sys_pll1_80m", "video_pll_out", };
 
 static const char * const imx8mp_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
-						"sys_pll1_80m", "video_pll1_out", };
+						"sys_pll1_80m", "video_pll_out", };
 
 static const char * const imx8mp_gpt1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext1" };
 
 static const char * const imx8mp_gpt2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext2" };
 
 static const char * const imx8mp_gpt3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext3" };
 
 static const char * const imx8mp_gpt4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext1" };
 
 static const char * const imx8mp_gpt5_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext2" };
 
 static const char * const imx8mp_gpt6_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
+						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
 						"audio_pll1_out", "clk_ext3" };
 
 static const char * const imx8mp_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
@@ -328,19 +328,19 @@ static const char * const imx8mp_ipp_do_clko1_sels[] = {"osc_24m", "sys_pll1_800
 
 static const char * const imx8mp_ipp_do_clko2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_400m",
 							"sys_pll1_166m", "sys_pll3_out", "audio_pll1_out",
-							"video_pll1_out", "osc_32k" };
+							"video_pll_out", "osc_32k" };
 
 static const char * const imx8mp_hdmi_fdcc_tst_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m",
 							 "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
-							 "audio_pll2_out", "video_pll1_out", };
+							 "audio_pll2_out", "video_pll_out", };
 
 static const char * const imx8mp_hdmi_24m_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						    "sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						    "sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						    "audio_pll2_out", "sys_pll1_133m", };
 
 static const char * const imx8mp_hdmi_ref_266m_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll3_out",
 							 "sys_pll2_333m", "sys_pll1_266m", "sys_pll2_200m",
-							 "audio_pll1_out", "video_pll1_out", };
+							 "audio_pll1_out", "video_pll_out", };
 
 static const char * const imx8mp_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
@@ -349,26 +349,26 @@ static const char * const imx8mp_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "s
 static const char * const imx8mp_media_cam1_pix_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m",
 							  "sys_pll1_800m", "sys_pll2_1000m",
 							  "sys_pll3_out", "audio_pll2_out",
-							  "video_pll1_out", };
+							  "video_pll_out", };
 
 static const char * const imx8mp_media_mipi_phy1_ref_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll2_100m",
 							       "sys_pll1_800m", "sys_pll2_1000m",
 							       "clk_ext2", "audio_pll2_out",
-							       "video_pll1_out", };
+							       "video_pll_out", };
 
-static const char * const imx8mp_media_disp_pix_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out",
+static const char * const imx8mp_media_disp_pix_sels[] = {"osc_24m", "video_pll_out", "audio_pll2_out",
 							   "audio_pll1_out", "sys_pll1_800m",
 							   "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
 
 static const char * const imx8mp_media_cam2_pix_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m",
 							  "sys_pll1_800m", "sys_pll2_1000m",
 							  "sys_pll3_out", "audio_pll2_out",
-							  "video_pll1_out", };
+							  "video_pll_out", };
 
 static const char * const imx8mp_media_ldb_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll2_100m",
 						     "sys_pll1_800m", "sys_pll2_1000m",
 						     "clk_ext2", "audio_pll2_out",
-						     "video_pll1_out", };
+						     "video_pll_out", };
 
 static const char * const imx8mp_memrepair_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_80m",
 							"sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
@@ -392,12 +392,12 @@ static const char * const imx8mp_vpu_vc8000e_sels[] = {"osc_24m", "vpu_pll_out",
 						       "sys_pll3_out", "audio_pll1_out", };
 
 static const char * const imx8mp_sai7_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll_out", "sys_pll1_133m", "osc_hdmi",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mp_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
 
-static const char * const imx8mp_clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char * const imx8mp_clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll_out",
 						  "dummy", "dummy", "gpu_pll_out", "vpu_pll_out",
 						  "arm_pll_out", "sys_pll1", "sys_pll2", "sys_pll3",
 						  "dummy", "dummy", "osc_24m", "dummy", "osc_32k"};
@@ -440,7 +440,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel", anatop_base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MP_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel", anatop_base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MP_VIDEO_PLL1_REF_SEL] = imx_clk_hw_mux("video_pll1_ref_sel", anatop_base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MP_VIDEO_PLL_REF_SEL] = imx_clk_hw_mux("video_pll_ref_sel", anatop_base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MP_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", anatop_base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MP_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", anatop_base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MP_VPU_PLL_REF_SEL] = imx_clk_hw_mux("vpu_pll_ref_sel", anatop_base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
@@ -451,7 +451,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", anatop_base, &imx_1443x_pll);
 	hws[IMX8MP_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", anatop_base + 0x14, &imx_1443x_pll);
-	hws[IMX8MP_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", anatop_base + 0x28, &imx_1443x_pll);
+	hws[IMX8MP_VIDEO_PLL] = imx_clk_hw_pll14xx("video_pll", "video_pll_ref_sel", anatop_base + 0x28, &imx_1443x_pll);
 	hws[IMX8MP_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", anatop_base + 0x50, &imx_1443x_dram_pll);
 	hws[IMX8MP_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", anatop_base + 0x64, &imx_1416x_pll);
 	hws[IMX8MP_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", anatop_base + 0x74, &imx_1416x_pll);
@@ -462,7 +462,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_AUDIO_PLL1_BYPASS] = imx_clk_hw_mux_flags("audio_pll1_bypass", anatop_base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MP_AUDIO_PLL2_BYPASS] = imx_clk_hw_mux_flags("audio_pll2_bypass", anatop_base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MP_VIDEO_PLL1_BYPASS] = imx_clk_hw_mux_flags("video_pll1_bypass", anatop_base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT);
+	hws[IMX8MP_VIDEO_PLL_BYPASS] = imx_clk_hw_mux_flags("video_pll_bypass", anatop_base + 0x28, 16, 1, video_pll_bypass_sels, ARRAY_SIZE(video_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MP_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", anatop_base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MP_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", anatop_base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MP_VPU_PLL_BYPASS] = imx_clk_hw_mux_flags("vpu_pll_bypass", anatop_base + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
@@ -473,7 +473,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_AUDIO_PLL1_OUT] = imx_clk_hw_gate("audio_pll1_out", "audio_pll1_bypass", anatop_base, 13);
 	hws[IMX8MP_AUDIO_PLL2_OUT] = imx_clk_hw_gate("audio_pll2_out", "audio_pll2_bypass", anatop_base + 0x14, 13);
-	hws[IMX8MP_VIDEO_PLL1_OUT] = imx_clk_hw_gate("video_pll1_out", "video_pll1_bypass", anatop_base + 0x28, 13);
+	hws[IMX8MP_VIDEO_PLL_OUT] = imx_clk_hw_gate("video_pll_out", "video_pll_bypass", anatop_base + 0x28, 13);
 	hws[IMX8MP_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", anatop_base + 0x50, 13);
 	hws[IMX8MP_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", anatop_base + 0x64, 11);
 	hws[IMX8MP_VPU_PLL_OUT] = imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypass", anatop_base + 0x74, 11);
diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 7da4243984b2..0601df6c8d38 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -16,7 +16,8 @@
 #define IMX8MP_CLK_EXT4				7
 #define IMX8MP_AUDIO_PLL1_REF_SEL		8
 #define IMX8MP_AUDIO_PLL2_REF_SEL		9
-#define IMX8MP_VIDEO_PLL1_REF_SEL		10
+#define IMX8MP_VIDEO_PLL_REF_SEL		10
+#define IMX8MP_VIDEO_PLL1_REF_SEL		IMX8MP_VIDEO_PLL_REF_SEL
 #define IMX8MP_DRAM_PLL_REF_SEL			11
 #define IMX8MP_GPU_PLL_REF_SEL			12
 #define IMX8MP_VPU_PLL_REF_SEL			13
@@ -26,7 +27,8 @@
 #define IMX8MP_SYS_PLL3_REF_SEL			17
 #define IMX8MP_AUDIO_PLL1			18
 #define IMX8MP_AUDIO_PLL2			19
-#define IMX8MP_VIDEO_PLL1			20
+#define IMX8MP_VIDEO_PLL			20
+#define IMX8MP_VIDEO_PLL1			IMX8MP_VIDEO_PLL
 #define IMX8MP_DRAM_PLL				21
 #define IMX8MP_GPU_PLL				22
 #define IMX8MP_VPU_PLL				23
@@ -46,7 +48,8 @@
 #define IMX8MP_SYS_PLL3_BYPASS			37
 #define IMX8MP_AUDIO_PLL1_OUT			38
 #define IMX8MP_AUDIO_PLL2_OUT			39
-#define IMX8MP_VIDEO_PLL1_OUT			40
+#define IMX8MP_VIDEO_PLL_OUT			40
+#define IMX8MP_VIDEO_PLL1_OUT			IMX8MP_VIDEO_PLL_OUT
 #define IMX8MP_DRAM_PLL_OUT			41
 #define IMX8MP_GPU_PLL_OUT			42
 #define IMX8MP_VPU_PLL_OUT			43
-- 
2.43.0


