Return-Path: <linux-kernel+bounces-548803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A67A54994
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FF73AEBE4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F60021ABCD;
	Thu,  6 Mar 2025 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pP49WSVj"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0312147FD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260659; cv=none; b=bEOQrcSF9KmreRlOWNZR9hG7stJAsm1EsysBxf1q65d+ABVvty7C8CMW7rceNuhXDiJM/dosEDXtfYZAEiqHHncP/1g/4rABG4nYQbMdoQuhVDifhueEBNlIHHYgO4e04+kG1of9q4AZ2wbirmdqqgOajdVgM/WEDoaGT8S/SUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260659; c=relaxed/simple;
	bh=weEyhWSu8QdhxPa3h+8EqamRWdh4rqkder4xaBT9piI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFqMn9D9eUVO+AdWjJLmg7LAJt8e0R8DfJusPfKKrl/OxJLca4Ce+/I6wCYo0UFJGIh2CoBLIM+pNWhyIPUz5DiqCcFzBpfRO3OC9GxBUgeKORiohiCBhFSW5xbVmW53fPki22CtrocH3HhxrOxTF94j22eVHncKXomkdnCSD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=pP49WSVj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so3064205e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741260652; x=1741865452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSormQ/4IGawY9DJj550yYD+TA4Iu9VFQYeDRV8SRRA=;
        b=pP49WSVj7GzwKId9F1foCN7psM2Ko1jB61cTX/cZxVQWrkCsFmgF9EeTlItRmfrYjK
         DAU2v8UuPoCDIVywFHzY1b/CkISRo9vpf57N4aGfgsZMFpi62/9VYXZcupGsg/JYqAPE
         qUruesVD6eqh21z4PO5ILcbzMTYVLyxYoqsFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260652; x=1741865452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSormQ/4IGawY9DJj550yYD+TA4Iu9VFQYeDRV8SRRA=;
        b=G49UpYva1FCyP97Mx5pqGVlgCge39IfuKC0I/uZU2DH0AEKYMTf0Lp5Sh05s+7azqs
         jqO49kqO4RfjIrRz7AN3h1todHhV90NCnTOsM6+2LkW/3cVULRfKSuKVA5tV4y/Ca4Mh
         14iiMFiUcSUGyK5+JXg9KcuiG/I46UokrBe+jq9k9HwThGvzUU0KDKUkkBZrU5zEI+sC
         Vy+lSuZHYgK5A1BLBPqYRbRpp7l/ZkTkilOdLbp12jx29/73rZb2BhuM7msj2mryVRQI
         Qt8ZeiOtfFETjDQnfVAbp6Yjs5eDdt7D8go+Yu0lkE0VwFXQ5Bnj7dvofxhMFD/2ecAq
         8h2w==
X-Gm-Message-State: AOJu0YyiZUynDJQQoBew1zc6ayWtAjQCf4hDJsG0tqMrTSstIp/aJTRF
	a5pC2uS3+Ot+KYIseH0DpfLpkdeBPIyMLH/a3eKvbrOAbol5RDE/vwq5Lu4M4XMKgwYy1LNaEie
	A
X-Gm-Gg: ASbGncv3yO7veZaotc/P8T+D/TskRey2bSfPLgnVa5rSNrINwInppF2Ys9odfm6fNKt
	6dhnRZd5kh+/emtWB6NUVVvkkhc1oM/nw9IFlOjivEdgEmkszd+e+CyqUD7AFyNo75vNS9cb/bB
	1BQdJ5rhmXuLRSTnQ2OkVREdYXPeoxB4JA/dPldmallNHEfdmMfnpducuumj4wV52uyp/3k3BwH
	NMdK4XoCWNwPM1RZDE0N8NPaF6vJeRwv2eORvmIVpDmzkotRFTlyQjZY80eItmphzwR08uVtJVO
	H9h5WdDoBBoJbLR3jBdQ9ZcpBgt674qEKkTKM9kL5Mntdg7RhDboDYAs/EI6troF1p+UgC9JkIu
	pBluxZw==
X-Google-Smtp-Source: AGHT+IFju58IgE1nRoM/oK2YAd+xHrTqLmVdD6uSzN0on8J3dyhPxgTVmw+Qj4n5J4YAqQe+m7QfaA==
X-Received: by 2002:a05:600c:1551:b0:43b:cb0c:3556 with SMTP id 5b1f17b1804b1-43bd2af49cemr46029225e9.28.1741260651912;
        Thu, 06 Mar 2025 03:30:51 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:4703:aa8c:6eab:8161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1749650f8f.3.2025.03.06.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:30:51 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v10 14/18] clk: imx8mp: rename ccm_base to base
Date: Thu,  6 Mar 2025 12:28:03 +0100
Message-ID: <20250306112959.242131-15-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old code also accessed the anatop address space and therefore used
the variables anatop_base and ccm_base to distinguish between the two
address spaces. However, now that a specific anatop driver exists for
the i.MX8MP platform, the variable ccm_base can be renamed to base, as
is usually the case for the variable pointing to the memory region
managed by a Linux driver.
The patch does not introduce any functional changes.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk-imx8mp.c | 378 +++++++++++++++++------------------
 1 file changed, 189 insertions(+), 189 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 9dda576e5fbd..012cd3b52e3f 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -392,12 +392,12 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node, *anp;
-	void __iomem *ccm_base;
+	void __iomem *base;
 	int err;
 
-	ccm_base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(ccm_base)))
-		return PTR_ERR(ccm_base);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (WARN_ON(IS_ERR(base)))
+		return PTR_ERR(base);
 
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
@@ -493,198 +493,198 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_CLKOUT2_DIV] = imx_anatop_get_clk_hw(anp, IMX8MP_ANATOP_CLK_CLKOUT2_DIV);
 	hws[IMX8MP_CLK_CLKOUT2] = imx_anatop_get_clk_hw(anp, IMX8MP_ANATOP_CLK_CLKOUT2);
 
-	hws[IMX8MP_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mp_a53_sels, ccm_base + 0x8000);
+	hws[IMX8MP_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mp_a53_sels, base + 0x8000);
 	hws[IMX8MP_CLK_A53_SRC] = hws[IMX8MP_CLK_A53_DIV];
 	hws[IMX8MP_CLK_A53_CG] = hws[IMX8MP_CLK_A53_DIV];
-	hws[IMX8MP_CLK_M7_CORE] = imx8m_clk_hw_composite_core("m7_core", imx8mp_m7_sels, ccm_base + 0x8080);
-	hws[IMX8MP_CLK_ML_CORE] = imx8m_clk_hw_composite_core("ml_core", imx8mp_ml_sels, ccm_base + 0x8100);
-	hws[IMX8MP_CLK_GPU3D_CORE] = imx8m_clk_hw_composite_core("gpu3d_core", imx8mp_gpu3d_core_sels, ccm_base + 0x8180);
-	hws[IMX8MP_CLK_GPU3D_SHADER_CORE] = imx8m_clk_hw_composite("gpu3d_shader_core", imx8mp_gpu3d_shader_sels, ccm_base + 0x8200);
-	hws[IMX8MP_CLK_GPU2D_CORE] = imx8m_clk_hw_composite("gpu2d_core", imx8mp_gpu2d_sels, ccm_base + 0x8280);
-	hws[IMX8MP_CLK_AUDIO_AXI] = imx8m_clk_hw_composite("audio_axi", imx8mp_audio_axi_sels, ccm_base + 0x8300);
+	hws[IMX8MP_CLK_M7_CORE] = imx8m_clk_hw_composite_core("m7_core", imx8mp_m7_sels, base + 0x8080);
+	hws[IMX8MP_CLK_ML_CORE] = imx8m_clk_hw_composite_core("ml_core", imx8mp_ml_sels, base + 0x8100);
+	hws[IMX8MP_CLK_GPU3D_CORE] = imx8m_clk_hw_composite_core("gpu3d_core", imx8mp_gpu3d_core_sels, base + 0x8180);
+	hws[IMX8MP_CLK_GPU3D_SHADER_CORE] = imx8m_clk_hw_composite("gpu3d_shader_core", imx8mp_gpu3d_shader_sels, base + 0x8200);
+	hws[IMX8MP_CLK_GPU2D_CORE] = imx8m_clk_hw_composite("gpu2d_core", imx8mp_gpu2d_sels, base + 0x8280);
+	hws[IMX8MP_CLK_AUDIO_AXI] = imx8m_clk_hw_composite("audio_axi", imx8mp_audio_axi_sels, base + 0x8300);
 	hws[IMX8MP_CLK_AUDIO_AXI_SRC] = hws[IMX8MP_CLK_AUDIO_AXI];
-	hws[IMX8MP_CLK_HSIO_AXI] = imx8m_clk_hw_composite("hsio_axi", imx8mp_hsio_axi_sels, ccm_base + 0x8380);
-	hws[IMX8MP_CLK_MEDIA_ISP] = imx8m_clk_hw_composite("media_isp", imx8mp_media_isp_sels, ccm_base + 0x8400);
+	hws[IMX8MP_CLK_HSIO_AXI] = imx8m_clk_hw_composite("hsio_axi", imx8mp_hsio_axi_sels, base + 0x8380);
+	hws[IMX8MP_CLK_MEDIA_ISP] = imx8m_clk_hw_composite("media_isp", imx8mp_media_isp_sels, base + 0x8400);
 
 	/* CORE SEL */
-	hws[IMX8MP_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", ccm_base + 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels));
-
-	hws[IMX8MP_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mp_main_axi_sels, ccm_base + 0x8800);
-	hws[IMX8MP_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mp_enet_axi_sels, ccm_base + 0x8880);
-	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
-	hws[IMX8MP_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mp_vpu_bus_sels, ccm_base + 0x8980);
-	hws[IMX8MP_CLK_MEDIA_AXI] = imx8m_clk_hw_composite_bus("media_axi", imx8mp_media_axi_sels, ccm_base + 0x8a00);
-	hws[IMX8MP_CLK_MEDIA_APB] = imx8m_clk_hw_composite_bus("media_apb", imx8mp_media_apb_sels, ccm_base + 0x8a80);
-	hws[IMX8MP_CLK_HDMI_APB] = imx8m_clk_hw_composite_bus("hdmi_apb", imx8mp_media_apb_sels, ccm_base + 0x8b00);
-	hws[IMX8MP_CLK_HDMI_AXI] = imx8m_clk_hw_composite_bus("hdmi_axi", imx8mp_media_axi_sels, ccm_base + 0x8b80);
-	hws[IMX8MP_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mp_gpu_axi_sels, ccm_base + 0x8c00);
-	hws[IMX8MP_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mp_gpu_ahb_sels, ccm_base + 0x8c80);
-	hws[IMX8MP_CLK_NOC] = imx8m_clk_hw_composite_bus_critical("noc", imx8mp_noc_sels, ccm_base + 0x8d00);
-	hws[IMX8MP_CLK_NOC_IO] = imx8m_clk_hw_composite_bus_critical("noc_io", imx8mp_noc_io_sels, ccm_base + 0x8d80);
-	hws[IMX8MP_CLK_ML_AXI] = imx8m_clk_hw_composite_bus("ml_axi", imx8mp_ml_axi_sels, ccm_base + 0x8e00);
-	hws[IMX8MP_CLK_ML_AHB] = imx8m_clk_hw_composite_bus("ml_ahb", imx8mp_ml_ahb_sels, ccm_base + 0x8e80);
-
-	hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb_root", imx8mp_ahb_sels, ccm_base + 0x9000);
-	hws[IMX8MP_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mp_audio_ahb_sels, ccm_base + 0x9100);
-	hws[IMX8MP_CLK_MIPI_DSI_ESC_RX] = imx8m_clk_hw_composite_bus("mipi_dsi_esc_rx", imx8mp_mipi_dsi_esc_rx_sels, ccm_base + 0x9200);
-	hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite_bus_flags("media_disp2_pix", imx8mp_media_disp_pix_sels, ccm_base + 0x9300, CLK_SET_RATE_PARENT);
-
-	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
-
-	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
-	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
-	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
-	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
-	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
-	hws[IMX8MP_CLK_CAN2] = imx8m_clk_hw_composite("can2", imx8mp_can2_sels, ccm_base + 0xa280);
-	hws[IMX8MP_CLK_PCIE_AUX] = imx8m_clk_hw_composite("pcie_aux", imx8mp_pcie_aux_sels, ccm_base + 0xa400);
-	hws[IMX8MP_CLK_I2C5] = imx8m_clk_hw_composite("i2c5", imx8mp_i2c5_sels, ccm_base + 0xa480);
-	hws[IMX8MP_CLK_I2C6] = imx8m_clk_hw_composite("i2c6", imx8mp_i2c6_sels, ccm_base + 0xa500);
-	hws[IMX8MP_CLK_SAI1] = imx8m_clk_hw_composite("sai1", imx8mp_sai1_sels, ccm_base + 0xa580);
-	hws[IMX8MP_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mp_sai2_sels, ccm_base + 0xa600);
-	hws[IMX8MP_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mp_sai3_sels, ccm_base + 0xa680);
-	hws[IMX8MP_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mp_sai5_sels, ccm_base + 0xa780);
-	hws[IMX8MP_CLK_SAI6] = imx8m_clk_hw_composite("sai6", imx8mp_sai6_sels, ccm_base + 0xa800);
-	hws[IMX8MP_CLK_ENET_QOS] = imx8m_clk_hw_composite("enet_qos", imx8mp_enet_qos_sels, ccm_base + 0xa880);
-	hws[IMX8MP_CLK_ENET_QOS_TIMER] = imx8m_clk_hw_composite("enet_qos_timer", imx8mp_enet_qos_timer_sels, ccm_base + 0xa900);
-	hws[IMX8MP_CLK_ENET_REF] = imx8m_clk_hw_composite("enet_ref", imx8mp_enet_ref_sels, ccm_base + 0xa980);
-	hws[IMX8MP_CLK_ENET_TIMER] = imx8m_clk_hw_composite("enet_timer", imx8mp_enet_timer_sels, ccm_base + 0xaa00);
-	hws[IMX8MP_CLK_ENET_PHY_REF] = imx8m_clk_hw_composite("enet_phy_ref", imx8mp_enet_phy_ref_sels, ccm_base + 0xaa80);
-	hws[IMX8MP_CLK_NAND] = imx8m_clk_hw_composite("nand", imx8mp_nand_sels, ccm_base + 0xab00);
-	hws[IMX8MP_CLK_QSPI] = imx8m_clk_hw_composite("qspi", imx8mp_qspi_sels, ccm_base + 0xab80);
-	hws[IMX8MP_CLK_USDHC1] = imx8m_clk_hw_composite("usdhc1", imx8mp_usdhc1_sels, ccm_base + 0xac00);
-	hws[IMX8MP_CLK_USDHC2] = imx8m_clk_hw_composite("usdhc2", imx8mp_usdhc2_sels, ccm_base + 0xac80);
-	hws[IMX8MP_CLK_I2C1] = imx8m_clk_hw_composite("i2c1", imx8mp_i2c1_sels, ccm_base + 0xad00);
-	hws[IMX8MP_CLK_I2C2] = imx8m_clk_hw_composite("i2c2", imx8mp_i2c2_sels, ccm_base + 0xad80);
-	hws[IMX8MP_CLK_I2C3] = imx8m_clk_hw_composite("i2c3", imx8mp_i2c3_sels, ccm_base + 0xae00);
-	hws[IMX8MP_CLK_I2C4] = imx8m_clk_hw_composite("i2c4", imx8mp_i2c4_sels, ccm_base + 0xae80);
-
-	hws[IMX8MP_CLK_UART1] = imx8m_clk_hw_composite("uart1", imx8mp_uart1_sels, ccm_base + 0xaf00);
-	hws[IMX8MP_CLK_UART2] = imx8m_clk_hw_composite("uart2", imx8mp_uart2_sels, ccm_base + 0xaf80);
-	hws[IMX8MP_CLK_UART3] = imx8m_clk_hw_composite("uart3", imx8mp_uart3_sels, ccm_base + 0xb000);
-	hws[IMX8MP_CLK_UART4] = imx8m_clk_hw_composite("uart4", imx8mp_uart4_sels, ccm_base + 0xb080);
-	hws[IMX8MP_CLK_USB_CORE_REF] = imx8m_clk_hw_composite("usb_core_ref", imx8mp_usb_core_ref_sels, ccm_base + 0xb100);
-	hws[IMX8MP_CLK_USB_PHY_REF] = imx8m_clk_hw_composite("usb_phy_ref", imx8mp_usb_phy_ref_sels, ccm_base + 0xb180);
-	hws[IMX8MP_CLK_GIC] = imx8m_clk_hw_composite_critical("gic", imx8mp_gic_sels, ccm_base + 0xb200);
-	hws[IMX8MP_CLK_ECSPI1] = imx8m_clk_hw_composite("ecspi1", imx8mp_ecspi1_sels, ccm_base + 0xb280);
-	hws[IMX8MP_CLK_ECSPI2] = imx8m_clk_hw_composite("ecspi2", imx8mp_ecspi2_sels, ccm_base + 0xb300);
-	hws[IMX8MP_CLK_PWM1] = imx8m_clk_hw_composite("pwm1", imx8mp_pwm1_sels, ccm_base + 0xb380);
-	hws[IMX8MP_CLK_PWM2] = imx8m_clk_hw_composite("pwm2", imx8mp_pwm2_sels, ccm_base + 0xb400);
-	hws[IMX8MP_CLK_PWM3] = imx8m_clk_hw_composite("pwm3", imx8mp_pwm3_sels, ccm_base + 0xb480);
-	hws[IMX8MP_CLK_PWM4] = imx8m_clk_hw_composite("pwm4", imx8mp_pwm4_sels, ccm_base + 0xb500);
-
-	hws[IMX8MP_CLK_GPT1] = imx8m_clk_hw_composite("gpt1", imx8mp_gpt1_sels, ccm_base + 0xb580);
-	hws[IMX8MP_CLK_GPT2] = imx8m_clk_hw_composite("gpt2", imx8mp_gpt2_sels, ccm_base + 0xb600);
-	hws[IMX8MP_CLK_GPT3] = imx8m_clk_hw_composite("gpt3", imx8mp_gpt3_sels, ccm_base + 0xb680);
-	hws[IMX8MP_CLK_GPT4] = imx8m_clk_hw_composite("gpt4", imx8mp_gpt4_sels, ccm_base + 0xb700);
-	hws[IMX8MP_CLK_GPT5] = imx8m_clk_hw_composite("gpt5", imx8mp_gpt5_sels, ccm_base + 0xb780);
-	hws[IMX8MP_CLK_GPT6] = imx8m_clk_hw_composite("gpt6", imx8mp_gpt6_sels, ccm_base + 0xb800);
-	hws[IMX8MP_CLK_WDOG] = imx8m_clk_hw_composite("wdog", imx8mp_wdog_sels, ccm_base + 0xb900);
-	hws[IMX8MP_CLK_WRCLK] = imx8m_clk_hw_composite("wrclk", imx8mp_wrclk_sels, ccm_base + 0xb980);
-	hws[IMX8MP_CLK_IPP_DO_CLKO1] = imx8m_clk_hw_composite("ipp_do_clko1", imx8mp_ipp_do_clko1_sels, ccm_base + 0xba00);
-	hws[IMX8MP_CLK_IPP_DO_CLKO2] = imx8m_clk_hw_composite("ipp_do_clko2", imx8mp_ipp_do_clko2_sels, ccm_base + 0xba80);
-	hws[IMX8MP_CLK_HDMI_FDCC_TST] = imx8m_clk_hw_composite("hdmi_fdcc_tst", imx8mp_hdmi_fdcc_tst_sels, ccm_base + 0xbb00);
-	hws[IMX8MP_CLK_HDMI_24M] = imx8m_clk_hw_composite("hdmi_24m", imx8mp_hdmi_24m_sels, ccm_base + 0xbb80);
-	hws[IMX8MP_CLK_HDMI_REF_266M] = imx8m_clk_hw_composite("hdmi_ref_266m", imx8mp_hdmi_ref_266m_sels, ccm_base + 0xbc00);
-	hws[IMX8MP_CLK_USDHC3] = imx8m_clk_hw_composite("usdhc3", imx8mp_usdhc3_sels, ccm_base + 0xbc80);
-	hws[IMX8MP_CLK_MEDIA_CAM1_PIX] = imx8m_clk_hw_composite("media_cam1_pix", imx8mp_media_cam1_pix_sels, ccm_base + 0xbd00);
-	hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF] = imx8m_clk_hw_composite("media_mipi_phy1_ref", imx8mp_media_mipi_phy1_ref_sels, ccm_base + 0xbd80);
-	hws[IMX8MP_CLK_MEDIA_DISP1_PIX] = imx8m_clk_hw_composite_bus_flags("media_disp1_pix", imx8mp_media_disp_pix_sels, ccm_base + 0xbe00, CLK_SET_RATE_PARENT);
-	hws[IMX8MP_CLK_MEDIA_CAM2_PIX] = imx8m_clk_hw_composite("media_cam2_pix", imx8mp_media_cam2_pix_sels, ccm_base + 0xbe80);
-	hws[IMX8MP_CLK_MEDIA_LDB] = imx8m_clk_hw_composite("media_ldb", imx8mp_media_ldb_sels, ccm_base + 0xbf00);
-	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite_critical("mem_repair", imx8mp_memrepair_sels, ccm_base + 0xbf80);
-	hws[IMX8MP_CLK_MEDIA_MIPI_TEST_BYTE] = imx8m_clk_hw_composite("media_mipi_test_byte", imx8mp_media_mipi_test_byte_sels, ccm_base + 0xc100);
-	hws[IMX8MP_CLK_ECSPI3] = imx8m_clk_hw_composite("ecspi3", imx8mp_ecspi3_sels, ccm_base + 0xc180);
-	hws[IMX8MP_CLK_PDM] = imx8m_clk_hw_composite("pdm", imx8mp_pdm_sels, ccm_base + 0xc200);
-	hws[IMX8MP_CLK_VPU_VC8000E] = imx8m_clk_hw_composite("vpu_vc8000e", imx8mp_vpu_vc8000e_sels, ccm_base + 0xc280);
-	hws[IMX8MP_CLK_SAI7] = imx8m_clk_hw_composite("sai7", imx8mp_sai7_sels, ccm_base + 0xc300);
+	hws[IMX8MP_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", base + 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels));
+
+	hws[IMX8MP_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mp_main_axi_sels, base + 0x8800);
+	hws[IMX8MP_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mp_enet_axi_sels, base + 0x8880);
+	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite("nand_usdhc_bus", imx8mp_nand_usdhc_sels, base + 0x8900);
+	hws[IMX8MP_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mp_vpu_bus_sels, base + 0x8980);
+	hws[IMX8MP_CLK_MEDIA_AXI] = imx8m_clk_hw_composite_bus("media_axi", imx8mp_media_axi_sels, base + 0x8a00);
+	hws[IMX8MP_CLK_MEDIA_APB] = imx8m_clk_hw_composite_bus("media_apb", imx8mp_media_apb_sels, base + 0x8a80);
+	hws[IMX8MP_CLK_HDMI_APB] = imx8m_clk_hw_composite_bus("hdmi_apb", imx8mp_media_apb_sels, base + 0x8b00);
+	hws[IMX8MP_CLK_HDMI_AXI] = imx8m_clk_hw_composite_bus("hdmi_axi", imx8mp_media_axi_sels, base + 0x8b80);
+	hws[IMX8MP_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mp_gpu_axi_sels, base + 0x8c00);
+	hws[IMX8MP_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mp_gpu_ahb_sels, base + 0x8c80);
+	hws[IMX8MP_CLK_NOC] = imx8m_clk_hw_composite_bus_critical("noc", imx8mp_noc_sels, base + 0x8d00);
+	hws[IMX8MP_CLK_NOC_IO] = imx8m_clk_hw_composite_bus_critical("noc_io", imx8mp_noc_io_sels, base + 0x8d80);
+	hws[IMX8MP_CLK_ML_AXI] = imx8m_clk_hw_composite_bus("ml_axi", imx8mp_ml_axi_sels, base + 0x8e00);
+	hws[IMX8MP_CLK_ML_AHB] = imx8m_clk_hw_composite_bus("ml_ahb", imx8mp_ml_ahb_sels, base + 0x8e80);
+
+	hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb_root", imx8mp_ahb_sels, base + 0x9000);
+	hws[IMX8MP_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mp_audio_ahb_sels, base + 0x9100);
+	hws[IMX8MP_CLK_MIPI_DSI_ESC_RX] = imx8m_clk_hw_composite_bus("mipi_dsi_esc_rx", imx8mp_mipi_dsi_esc_rx_sels, base + 0x9200);
+	hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite_bus_flags("media_disp2_pix", imx8mp_media_disp_pix_sels, base + 0x9300, CLK_SET_RATE_PARENT);
+
+	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", base + 0x9080, 0, 1);
+
+	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mp_dram_alt_sels, base + 0xa000);
+	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mp_dram_apb_sels, base + 0xa080);
+	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, base + 0xa100);
+	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, base + 0xa180);
+	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, base + 0xa200);
+	hws[IMX8MP_CLK_CAN2] = imx8m_clk_hw_composite("can2", imx8mp_can2_sels, base + 0xa280);
+	hws[IMX8MP_CLK_PCIE_AUX] = imx8m_clk_hw_composite("pcie_aux", imx8mp_pcie_aux_sels, base + 0xa400);
+	hws[IMX8MP_CLK_I2C5] = imx8m_clk_hw_composite("i2c5", imx8mp_i2c5_sels, base + 0xa480);
+	hws[IMX8MP_CLK_I2C6] = imx8m_clk_hw_composite("i2c6", imx8mp_i2c6_sels, base + 0xa500);
+	hws[IMX8MP_CLK_SAI1] = imx8m_clk_hw_composite("sai1", imx8mp_sai1_sels, base + 0xa580);
+	hws[IMX8MP_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mp_sai2_sels, base + 0xa600);
+	hws[IMX8MP_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mp_sai3_sels, base + 0xa680);
+	hws[IMX8MP_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mp_sai5_sels, base + 0xa780);
+	hws[IMX8MP_CLK_SAI6] = imx8m_clk_hw_composite("sai6", imx8mp_sai6_sels, base + 0xa800);
+	hws[IMX8MP_CLK_ENET_QOS] = imx8m_clk_hw_composite("enet_qos", imx8mp_enet_qos_sels, base + 0xa880);
+	hws[IMX8MP_CLK_ENET_QOS_TIMER] = imx8m_clk_hw_composite("enet_qos_timer", imx8mp_enet_qos_timer_sels, base + 0xa900);
+	hws[IMX8MP_CLK_ENET_REF] = imx8m_clk_hw_composite("enet_ref", imx8mp_enet_ref_sels, base + 0xa980);
+	hws[IMX8MP_CLK_ENET_TIMER] = imx8m_clk_hw_composite("enet_timer", imx8mp_enet_timer_sels, base + 0xaa00);
+	hws[IMX8MP_CLK_ENET_PHY_REF] = imx8m_clk_hw_composite("enet_phy_ref", imx8mp_enet_phy_ref_sels, base + 0xaa80);
+	hws[IMX8MP_CLK_NAND] = imx8m_clk_hw_composite("nand", imx8mp_nand_sels, base + 0xab00);
+	hws[IMX8MP_CLK_QSPI] = imx8m_clk_hw_composite("qspi", imx8mp_qspi_sels, base + 0xab80);
+	hws[IMX8MP_CLK_USDHC1] = imx8m_clk_hw_composite("usdhc1", imx8mp_usdhc1_sels, base + 0xac00);
+	hws[IMX8MP_CLK_USDHC2] = imx8m_clk_hw_composite("usdhc2", imx8mp_usdhc2_sels, base + 0xac80);
+	hws[IMX8MP_CLK_I2C1] = imx8m_clk_hw_composite("i2c1", imx8mp_i2c1_sels, base + 0xad00);
+	hws[IMX8MP_CLK_I2C2] = imx8m_clk_hw_composite("i2c2", imx8mp_i2c2_sels, base + 0xad80);
+	hws[IMX8MP_CLK_I2C3] = imx8m_clk_hw_composite("i2c3", imx8mp_i2c3_sels, base + 0xae00);
+	hws[IMX8MP_CLK_I2C4] = imx8m_clk_hw_composite("i2c4", imx8mp_i2c4_sels, base + 0xae80);
+
+	hws[IMX8MP_CLK_UART1] = imx8m_clk_hw_composite("uart1", imx8mp_uart1_sels, base + 0xaf00);
+	hws[IMX8MP_CLK_UART2] = imx8m_clk_hw_composite("uart2", imx8mp_uart2_sels, base + 0xaf80);
+	hws[IMX8MP_CLK_UART3] = imx8m_clk_hw_composite("uart3", imx8mp_uart3_sels, base + 0xb000);
+	hws[IMX8MP_CLK_UART4] = imx8m_clk_hw_composite("uart4", imx8mp_uart4_sels, base + 0xb080);
+	hws[IMX8MP_CLK_USB_CORE_REF] = imx8m_clk_hw_composite("usb_core_ref", imx8mp_usb_core_ref_sels, base + 0xb100);
+	hws[IMX8MP_CLK_USB_PHY_REF] = imx8m_clk_hw_composite("usb_phy_ref", imx8mp_usb_phy_ref_sels, base + 0xb180);
+	hws[IMX8MP_CLK_GIC] = imx8m_clk_hw_composite_critical("gic", imx8mp_gic_sels, base + 0xb200);
+	hws[IMX8MP_CLK_ECSPI1] = imx8m_clk_hw_composite("ecspi1", imx8mp_ecspi1_sels, base + 0xb280);
+	hws[IMX8MP_CLK_ECSPI2] = imx8m_clk_hw_composite("ecspi2", imx8mp_ecspi2_sels, base + 0xb300);
+	hws[IMX8MP_CLK_PWM1] = imx8m_clk_hw_composite("pwm1", imx8mp_pwm1_sels, base + 0xb380);
+	hws[IMX8MP_CLK_PWM2] = imx8m_clk_hw_composite("pwm2", imx8mp_pwm2_sels, base + 0xb400);
+	hws[IMX8MP_CLK_PWM3] = imx8m_clk_hw_composite("pwm3", imx8mp_pwm3_sels, base + 0xb480);
+	hws[IMX8MP_CLK_PWM4] = imx8m_clk_hw_composite("pwm4", imx8mp_pwm4_sels, base + 0xb500);
+
+	hws[IMX8MP_CLK_GPT1] = imx8m_clk_hw_composite("gpt1", imx8mp_gpt1_sels, base + 0xb580);
+	hws[IMX8MP_CLK_GPT2] = imx8m_clk_hw_composite("gpt2", imx8mp_gpt2_sels, base + 0xb600);
+	hws[IMX8MP_CLK_GPT3] = imx8m_clk_hw_composite("gpt3", imx8mp_gpt3_sels, base + 0xb680);
+	hws[IMX8MP_CLK_GPT4] = imx8m_clk_hw_composite("gpt4", imx8mp_gpt4_sels, base + 0xb700);
+	hws[IMX8MP_CLK_GPT5] = imx8m_clk_hw_composite("gpt5", imx8mp_gpt5_sels, base + 0xb780);
+	hws[IMX8MP_CLK_GPT6] = imx8m_clk_hw_composite("gpt6", imx8mp_gpt6_sels, base + 0xb800);
+	hws[IMX8MP_CLK_WDOG] = imx8m_clk_hw_composite("wdog", imx8mp_wdog_sels, base + 0xb900);
+	hws[IMX8MP_CLK_WRCLK] = imx8m_clk_hw_composite("wrclk", imx8mp_wrclk_sels, base + 0xb980);
+	hws[IMX8MP_CLK_IPP_DO_CLKO1] = imx8m_clk_hw_composite("ipp_do_clko1", imx8mp_ipp_do_clko1_sels, base + 0xba00);
+	hws[IMX8MP_CLK_IPP_DO_CLKO2] = imx8m_clk_hw_composite("ipp_do_clko2", imx8mp_ipp_do_clko2_sels, base + 0xba80);
+	hws[IMX8MP_CLK_HDMI_FDCC_TST] = imx8m_clk_hw_composite("hdmi_fdcc_tst", imx8mp_hdmi_fdcc_tst_sels, base + 0xbb00);
+	hws[IMX8MP_CLK_HDMI_24M] = imx8m_clk_hw_composite("hdmi_24m", imx8mp_hdmi_24m_sels, base + 0xbb80);
+	hws[IMX8MP_CLK_HDMI_REF_266M] = imx8m_clk_hw_composite("hdmi_ref_266m", imx8mp_hdmi_ref_266m_sels, base + 0xbc00);
+	hws[IMX8MP_CLK_USDHC3] = imx8m_clk_hw_composite("usdhc3", imx8mp_usdhc3_sels, base + 0xbc80);
+	hws[IMX8MP_CLK_MEDIA_CAM1_PIX] = imx8m_clk_hw_composite("media_cam1_pix", imx8mp_media_cam1_pix_sels, base + 0xbd00);
+	hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF] = imx8m_clk_hw_composite("media_mipi_phy1_ref", imx8mp_media_mipi_phy1_ref_sels, base + 0xbd80);
+	hws[IMX8MP_CLK_MEDIA_DISP1_PIX] = imx8m_clk_hw_composite_bus_flags("media_disp1_pix", imx8mp_media_disp_pix_sels, base + 0xbe00, CLK_SET_RATE_PARENT);
+	hws[IMX8MP_CLK_MEDIA_CAM2_PIX] = imx8m_clk_hw_composite("media_cam2_pix", imx8mp_media_cam2_pix_sels, base + 0xbe80);
+	hws[IMX8MP_CLK_MEDIA_LDB] = imx8m_clk_hw_composite("media_ldb", imx8mp_media_ldb_sels, base + 0xbf00);
+	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite_critical("mem_repair", imx8mp_memrepair_sels, base + 0xbf80);
+	hws[IMX8MP_CLK_MEDIA_MIPI_TEST_BYTE] = imx8m_clk_hw_composite("media_mipi_test_byte", imx8mp_media_mipi_test_byte_sels, base + 0xc100);
+	hws[IMX8MP_CLK_ECSPI3] = imx8m_clk_hw_composite("ecspi3", imx8mp_ecspi3_sels, base + 0xc180);
+	hws[IMX8MP_CLK_PDM] = imx8m_clk_hw_composite("pdm", imx8mp_pdm_sels, base + 0xc200);
+	hws[IMX8MP_CLK_VPU_VC8000E] = imx8m_clk_hw_composite("vpu_vc8000e", imx8mp_vpu_vc8000e_sels, base + 0xc280);
+	hws[IMX8MP_CLK_SAI7] = imx8m_clk_hw_composite("sai7", imx8mp_sai7_sels, base + 0xc300);
 
 	hws[IMX8MP_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
-	hws[IMX8MP_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", ccm_base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL);
-
-	hws[IMX8MP_CLK_DRAM1_ROOT] = imx_clk_hw_gate4_flags("dram1_root_clk", "dram_core_clk", ccm_base + 0x4050, 0, CLK_IS_CRITICAL);
-	hws[IMX8MP_CLK_ECSPI1_ROOT] = imx_clk_hw_gate4("ecspi1_root_clk", "ecspi1", ccm_base + 0x4070, 0);
-	hws[IMX8MP_CLK_ECSPI2_ROOT] = imx_clk_hw_gate4("ecspi2_root_clk", "ecspi2", ccm_base + 0x4080, 0);
-	hws[IMX8MP_CLK_ECSPI3_ROOT] = imx_clk_hw_gate4("ecspi3_root_clk", "ecspi3", ccm_base + 0x4090, 0);
-	hws[IMX8MP_CLK_ENET1_ROOT] = imx_clk_hw_gate4("enet1_root_clk", "enet_axi", ccm_base + 0x40a0, 0);
-	hws[IMX8MP_CLK_GPIO1_ROOT] = imx_clk_hw_gate4("gpio1_root_clk", "ipg_root", ccm_base + 0x40b0, 0);
-	hws[IMX8MP_CLK_GPIO2_ROOT] = imx_clk_hw_gate4("gpio2_root_clk", "ipg_root", ccm_base + 0x40c0, 0);
-	hws[IMX8MP_CLK_GPIO3_ROOT] = imx_clk_hw_gate4("gpio3_root_clk", "ipg_root", ccm_base + 0x40d0, 0);
-	hws[IMX8MP_CLK_GPIO4_ROOT] = imx_clk_hw_gate4("gpio4_root_clk", "ipg_root", ccm_base + 0x40e0, 0);
-	hws[IMX8MP_CLK_GPIO5_ROOT] = imx_clk_hw_gate4("gpio5_root_clk", "ipg_root", ccm_base + 0x40f0, 0);
-	hws[IMX8MP_CLK_GPT1_ROOT] = imx_clk_hw_gate4("gpt1_root_clk", "gpt1", ccm_base + 0x4100, 0);
-	hws[IMX8MP_CLK_GPT2_ROOT] = imx_clk_hw_gate4("gpt2_root_clk", "gpt2", ccm_base + 0x4110, 0);
-	hws[IMX8MP_CLK_GPT3_ROOT] = imx_clk_hw_gate4("gpt3_root_clk", "gpt3", ccm_base + 0x4120, 0);
-	hws[IMX8MP_CLK_GPT4_ROOT] = imx_clk_hw_gate4("gpt4_root_clk", "gpt4", ccm_base + 0x4130, 0);
-	hws[IMX8MP_CLK_GPT5_ROOT] = imx_clk_hw_gate4("gpt5_root_clk", "gpt5", ccm_base + 0x4140, 0);
-	hws[IMX8MP_CLK_GPT6_ROOT] = imx_clk_hw_gate4("gpt6_root_clk", "gpt6", ccm_base + 0x4150, 0);
-	hws[IMX8MP_CLK_I2C1_ROOT] = imx_clk_hw_gate4("i2c1_root_clk", "i2c1", ccm_base + 0x4170, 0);
-	hws[IMX8MP_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", ccm_base + 0x4180, 0);
-	hws[IMX8MP_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", ccm_base + 0x4190, 0);
-	hws[IMX8MP_CLK_I2C4_ROOT] = imx_clk_hw_gate4("i2c4_root_clk", "i2c4", ccm_base + 0x41a0, 0);
-	hws[IMX8MP_CLK_MU_ROOT] = imx_clk_hw_gate4("mu_root_clk", "ipg_root", ccm_base + 0x4210, 0);
-	hws[IMX8MP_CLK_OCOTP_ROOT] = imx_clk_hw_gate4("ocotp_root_clk", "ipg_root", ccm_base + 0x4220, 0);
-	hws[IMX8MP_CLK_PCIE_ROOT] = imx_clk_hw_gate4("pcie_root_clk", "pcie_aux", ccm_base + 0x4250, 0);
-	hws[IMX8MP_CLK_PWM1_ROOT] = imx_clk_hw_gate4("pwm1_root_clk", "pwm1", ccm_base + 0x4280, 0);
-	hws[IMX8MP_CLK_PWM2_ROOT] = imx_clk_hw_gate4("pwm2_root_clk", "pwm2", ccm_base + 0x4290, 0);
-	hws[IMX8MP_CLK_PWM3_ROOT] = imx_clk_hw_gate4("pwm3_root_clk", "pwm3", ccm_base + 0x42a0, 0);
-	hws[IMX8MP_CLK_PWM4_ROOT] = imx_clk_hw_gate4("pwm4_root_clk", "pwm4", ccm_base + 0x42b0, 0);
-	hws[IMX8MP_CLK_QOS_ROOT] = imx_clk_hw_gate4("qos_root_clk", "ipg_root", ccm_base + 0x42c0, 0);
-	hws[IMX8MP_CLK_QOS_ENET_ROOT] = imx_clk_hw_gate4("qos_enet_root_clk", "ipg_root", ccm_base + 0x42e0, 0);
-	hws[IMX8MP_CLK_QSPI_ROOT] = imx_clk_hw_gate4("qspi_root_clk", "qspi", ccm_base + 0x42f0, 0);
-	hws[IMX8MP_CLK_NAND_ROOT] = imx_clk_hw_gate2_shared2("nand_root_clk", "nand", ccm_base + 0x4300, 0, &share_count_nand);
-	hws[IMX8MP_CLK_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_hw_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_bus", ccm_base + 0x4300, 0, &share_count_nand);
-	hws[IMX8MP_CLK_I2C5_ROOT] = imx_clk_hw_gate2("i2c5_root_clk", "i2c5", ccm_base + 0x4330, 0);
-	hws[IMX8MP_CLK_I2C6_ROOT] = imx_clk_hw_gate2("i2c6_root_clk", "i2c6", ccm_base + 0x4340, 0);
-	hws[IMX8MP_CLK_CAN1_ROOT] = imx_clk_hw_gate2("can1_root_clk", "can1", ccm_base + 0x4350, 0);
-	hws[IMX8MP_CLK_CAN2_ROOT] = imx_clk_hw_gate2("can2_root_clk", "can2", ccm_base + 0x4360, 0);
-	hws[IMX8MP_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_root_clk", "ipg_root", ccm_base + 0x43a0, 0);
-	hws[IMX8MP_CLK_SIM_ENET_ROOT] = imx_clk_hw_gate4("sim_enet_root_clk", "enet_axi", ccm_base + 0x4400, 0);
-	hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base + 0x43b0, 0);
-	hws[IMX8MP_CLK_GPU2D_ROOT] = imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_core", ccm_base + 0x4450, 0);
-	hws[IMX8MP_CLK_GPU3D_ROOT] = imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core", ccm_base + 0x4460, 0);
-	hws[IMX8MP_CLK_UART1_ROOT] = imx_clk_hw_gate4("uart1_root_clk", "uart1", ccm_base + 0x4490, 0);
-	hws[IMX8MP_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", ccm_base + 0x44a0, 0);
-	hws[IMX8MP_CLK_UART3_ROOT] = imx_clk_hw_gate4("uart3_root_clk", "uart3", ccm_base + 0x44b0, 0);
-	hws[IMX8MP_CLK_UART4_ROOT] = imx_clk_hw_gate4("uart4_root_clk", "uart4", ccm_base + 0x44c0, 0);
-	hws[IMX8MP_CLK_USB_ROOT] = imx_clk_hw_gate2_shared2("usb_root_clk", "hsio_axi", ccm_base + 0x44d0, 0, &share_count_usb);
-	hws[IMX8MP_CLK_USB_SUSP] = imx_clk_hw_gate2_shared2("usb_suspend_clk", "osc_32k", ccm_base + 0x44d0, 0, &share_count_usb);
-	hws[IMX8MP_CLK_USB_PHY_ROOT] = imx_clk_hw_gate4("usb_phy_root_clk", "usb_phy_ref", ccm_base + 0x44f0, 0);
-	hws[IMX8MP_CLK_USDHC1_ROOT] = imx_clk_hw_gate4("usdhc1_root_clk", "usdhc1", ccm_base + 0x4510, 0);
-	hws[IMX8MP_CLK_USDHC2_ROOT] = imx_clk_hw_gate4("usdhc2_root_clk", "usdhc2", ccm_base + 0x4520, 0);
-	hws[IMX8MP_CLK_WDOG1_ROOT] = imx_clk_hw_gate4("wdog1_root_clk", "wdog", ccm_base + 0x4530, 0);
-	hws[IMX8MP_CLK_WDOG2_ROOT] = imx_clk_hw_gate4("wdog2_root_clk", "wdog", ccm_base + 0x4540, 0);
-	hws[IMX8MP_CLK_WDOG3_ROOT] = imx_clk_hw_gate4("wdog3_root_clk", "wdog", ccm_base + 0x4550, 0);
-	hws[IMX8MP_CLK_VPU_G1_ROOT] = imx_clk_hw_gate4("vpu_g1_root_clk", "vpu_g1", ccm_base + 0x4560, 0);
-	hws[IMX8MP_CLK_GPU_ROOT] = imx_clk_hw_gate4("gpu_root_clk", "gpu_axi", ccm_base + 0x4570, 0);
-	hws[IMX8MP_CLK_VPU_VC8KE_ROOT] = imx_clk_hw_gate4("vpu_vc8ke_root_clk", "vpu_vc8000e", ccm_base + 0x4590, 0);
-	hws[IMX8MP_CLK_VPU_G2_ROOT] = imx_clk_hw_gate4("vpu_g2_root_clk", "vpu_g2", ccm_base + 0x45a0, 0);
-	hws[IMX8MP_CLK_NPU_ROOT] = imx_clk_hw_gate4("npu_root_clk", "ml_core", ccm_base + 0x45b0, 0);
-	hws[IMX8MP_CLK_HSIO_ROOT] = imx_clk_hw_gate4("hsio_root_clk", "ipg_root", ccm_base + 0x45c0, 0);
-	hws[IMX8MP_CLK_MEDIA_APB_ROOT] = imx_clk_hw_gate2_shared2("media_apb_root_clk", "media_apb", ccm_base + 0x45d0, 0, &share_count_media);
-	hws[IMX8MP_CLK_MEDIA_AXI_ROOT] = imx_clk_hw_gate2_shared2("media_axi_root_clk", "media_axi", ccm_base + 0x45d0, 0, &share_count_media);
-	hws[IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_cam1_pix_root_clk", "media_cam1_pix", ccm_base + 0x45d0, 0, &share_count_media);
-	hws[IMX8MP_CLK_MEDIA_CAM2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_cam2_pix_root_clk", "media_cam2_pix", ccm_base + 0x45d0, 0, &share_count_media);
-	hws[IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp1_pix_root_clk", "media_disp1_pix", ccm_base + 0x45d0, 0, &share_count_media);
-	hws[IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp2_pix_root_clk", "media_disp2_pix", ccm_base + 0x45d0, 0, &share_count_media);
-	hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT] = imx_clk_hw_gate2_shared2("media_mipi_phy1_ref_root", "media_mipi_phy1_ref", ccm_base + 0x45d0, 0, &share_count_media);
-	hws[IMX8MP_CLK_MEDIA_LDB_ROOT] = imx_clk_hw_gate2_shared2("media_ldb_root_clk", "media_ldb", ccm_base + 0x45d0, 0, &share_count_media);
-	hws[IMX8MP_CLK_MEDIA_ISP_ROOT] = imx_clk_hw_gate2_shared2("media_isp_root_clk", "media_isp", ccm_base + 0x45d0, 0, &share_count_media);
-
-	hws[IMX8MP_CLK_USDHC3_ROOT] = imx_clk_hw_gate4("usdhc3_root_clk", "usdhc3", ccm_base + 0x45e0, 0);
-	hws[IMX8MP_CLK_HDMI_ROOT] = imx_clk_hw_gate4("hdmi_root_clk", "hdmi_axi", ccm_base + 0x45f0, 0);
-	hws[IMX8MP_CLK_TSENSOR_ROOT] = imx_clk_hw_gate4("tsensor_root_clk", "ipg_root", ccm_base + 0x4620, 0);
-	hws[IMX8MP_CLK_VPU_ROOT] = imx_clk_hw_gate4("vpu_root_clk", "vpu_bus", ccm_base + 0x4630, 0);
-
-	hws[IMX8MP_CLK_AUDIO_AHB_ROOT] = imx_clk_hw_gate2_shared2("audio_ahb_root", "audio_ahb", ccm_base + 0x4650, 0, &share_count_audio);
-	hws[IMX8MP_CLK_AUDIO_AXI_ROOT] = imx_clk_hw_gate2_shared2("audio_axi_root", "audio_axi", ccm_base + 0x4650, 0, &share_count_audio);
-	hws[IMX8MP_CLK_SAI1_ROOT] = imx_clk_hw_gate2_shared2("sai1_root", "sai1", ccm_base + 0x4650, 0, &share_count_audio);
-	hws[IMX8MP_CLK_SAI2_ROOT] = imx_clk_hw_gate2_shared2("sai2_root", "sai2", ccm_base + 0x4650, 0, &share_count_audio);
-	hws[IMX8MP_CLK_SAI3_ROOT] = imx_clk_hw_gate2_shared2("sai3_root", "sai3", ccm_base + 0x4650, 0, &share_count_audio);
-	hws[IMX8MP_CLK_SAI5_ROOT] = imx_clk_hw_gate2_shared2("sai5_root", "sai5", ccm_base + 0x4650, 0, &share_count_audio);
-	hws[IMX8MP_CLK_SAI6_ROOT] = imx_clk_hw_gate2_shared2("sai6_root", "sai6", ccm_base + 0x4650, 0, &share_count_audio);
-	hws[IMX8MP_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root", "sai7", ccm_base + 0x4650, 0, &share_count_audio);
-	hws[IMX8MP_CLK_PDM_ROOT] = imx_clk_hw_gate2_shared2("pdm_root", "pdm", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL);
+
+	hws[IMX8MP_CLK_DRAM1_ROOT] = imx_clk_hw_gate4_flags("dram1_root_clk", "dram_core_clk", base + 0x4050, 0, CLK_IS_CRITICAL);
+	hws[IMX8MP_CLK_ECSPI1_ROOT] = imx_clk_hw_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0);
+	hws[IMX8MP_CLK_ECSPI2_ROOT] = imx_clk_hw_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0);
+	hws[IMX8MP_CLK_ECSPI3_ROOT] = imx_clk_hw_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0);
+	hws[IMX8MP_CLK_ENET1_ROOT] = imx_clk_hw_gate4("enet1_root_clk", "enet_axi", base + 0x40a0, 0);
+	hws[IMX8MP_CLK_GPIO1_ROOT] = imx_clk_hw_gate4("gpio1_root_clk", "ipg_root", base + 0x40b0, 0);
+	hws[IMX8MP_CLK_GPIO2_ROOT] = imx_clk_hw_gate4("gpio2_root_clk", "ipg_root", base + 0x40c0, 0);
+	hws[IMX8MP_CLK_GPIO3_ROOT] = imx_clk_hw_gate4("gpio3_root_clk", "ipg_root", base + 0x40d0, 0);
+	hws[IMX8MP_CLK_GPIO4_ROOT] = imx_clk_hw_gate4("gpio4_root_clk", "ipg_root", base + 0x40e0, 0);
+	hws[IMX8MP_CLK_GPIO5_ROOT] = imx_clk_hw_gate4("gpio5_root_clk", "ipg_root", base + 0x40f0, 0);
+	hws[IMX8MP_CLK_GPT1_ROOT] = imx_clk_hw_gate4("gpt1_root_clk", "gpt1", base + 0x4100, 0);
+	hws[IMX8MP_CLK_GPT2_ROOT] = imx_clk_hw_gate4("gpt2_root_clk", "gpt2", base + 0x4110, 0);
+	hws[IMX8MP_CLK_GPT3_ROOT] = imx_clk_hw_gate4("gpt3_root_clk", "gpt3", base + 0x4120, 0);
+	hws[IMX8MP_CLK_GPT4_ROOT] = imx_clk_hw_gate4("gpt4_root_clk", "gpt4", base + 0x4130, 0);
+	hws[IMX8MP_CLK_GPT5_ROOT] = imx_clk_hw_gate4("gpt5_root_clk", "gpt5", base + 0x4140, 0);
+	hws[IMX8MP_CLK_GPT6_ROOT] = imx_clk_hw_gate4("gpt6_root_clk", "gpt6", base + 0x4150, 0);
+	hws[IMX8MP_CLK_I2C1_ROOT] = imx_clk_hw_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0);
+	hws[IMX8MP_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0);
+	hws[IMX8MP_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0);
+	hws[IMX8MP_CLK_I2C4_ROOT] = imx_clk_hw_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0);
+	hws[IMX8MP_CLK_MU_ROOT] = imx_clk_hw_gate4("mu_root_clk", "ipg_root", base + 0x4210, 0);
+	hws[IMX8MP_CLK_OCOTP_ROOT] = imx_clk_hw_gate4("ocotp_root_clk", "ipg_root", base + 0x4220, 0);
+	hws[IMX8MP_CLK_PCIE_ROOT] = imx_clk_hw_gate4("pcie_root_clk", "pcie_aux", base + 0x4250, 0);
+	hws[IMX8MP_CLK_PWM1_ROOT] = imx_clk_hw_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0);
+	hws[IMX8MP_CLK_PWM2_ROOT] = imx_clk_hw_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0);
+	hws[IMX8MP_CLK_PWM3_ROOT] = imx_clk_hw_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0);
+	hws[IMX8MP_CLK_PWM4_ROOT] = imx_clk_hw_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0);
+	hws[IMX8MP_CLK_QOS_ROOT] = imx_clk_hw_gate4("qos_root_clk", "ipg_root", base + 0x42c0, 0);
+	hws[IMX8MP_CLK_QOS_ENET_ROOT] = imx_clk_hw_gate4("qos_enet_root_clk", "ipg_root", base + 0x42e0, 0);
+	hws[IMX8MP_CLK_QSPI_ROOT] = imx_clk_hw_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0);
+	hws[IMX8MP_CLK_NAND_ROOT] = imx_clk_hw_gate2_shared2("nand_root_clk", "nand", base + 0x4300, 0, &share_count_nand);
+	hws[IMX8MP_CLK_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_hw_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_count_nand);
+	hws[IMX8MP_CLK_I2C5_ROOT] = imx_clk_hw_gate2("i2c5_root_clk", "i2c5", base + 0x4330, 0);
+	hws[IMX8MP_CLK_I2C6_ROOT] = imx_clk_hw_gate2("i2c6_root_clk", "i2c6", base + 0x4340, 0);
+	hws[IMX8MP_CLK_CAN1_ROOT] = imx_clk_hw_gate2("can1_root_clk", "can1", base + 0x4350, 0);
+	hws[IMX8MP_CLK_CAN2_ROOT] = imx_clk_hw_gate2("can2_root_clk", "can2", base + 0x4360, 0);
+	hws[IMX8MP_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_root_clk", "ipg_root", base + 0x43a0, 0);
+	hws[IMX8MP_CLK_SIM_ENET_ROOT] = imx_clk_hw_gate4("sim_enet_root_clk", "enet_axi", base + 0x4400, 0);
+	hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", base + 0x43b0, 0);
+	hws[IMX8MP_CLK_GPU2D_ROOT] = imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_core", base + 0x4450, 0);
+	hws[IMX8MP_CLK_GPU3D_ROOT] = imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core", base + 0x4460, 0);
+	hws[IMX8MP_CLK_UART1_ROOT] = imx_clk_hw_gate4("uart1_root_clk", "uart1", base + 0x4490, 0);
+	hws[IMX8MP_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0);
+	hws[IMX8MP_CLK_UART3_ROOT] = imx_clk_hw_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0);
+	hws[IMX8MP_CLK_UART4_ROOT] = imx_clk_hw_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0);
+	hws[IMX8MP_CLK_USB_ROOT] = imx_clk_hw_gate2_shared2("usb_root_clk", "hsio_axi", base + 0x44d0, 0, &share_count_usb);
+	hws[IMX8MP_CLK_USB_SUSP] = imx_clk_hw_gate2_shared2("usb_suspend_clk", "osc_32k", base + 0x44d0, 0, &share_count_usb);
+	hws[IMX8MP_CLK_USB_PHY_ROOT] = imx_clk_hw_gate4("usb_phy_root_clk", "usb_phy_ref", base + 0x44f0, 0);
+	hws[IMX8MP_CLK_USDHC1_ROOT] = imx_clk_hw_gate4("usdhc1_root_clk", "usdhc1", base + 0x4510, 0);
+	hws[IMX8MP_CLK_USDHC2_ROOT] = imx_clk_hw_gate4("usdhc2_root_clk", "usdhc2", base + 0x4520, 0);
+	hws[IMX8MP_CLK_WDOG1_ROOT] = imx_clk_hw_gate4("wdog1_root_clk", "wdog", base + 0x4530, 0);
+	hws[IMX8MP_CLK_WDOG2_ROOT] = imx_clk_hw_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0);
+	hws[IMX8MP_CLK_WDOG3_ROOT] = imx_clk_hw_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0);
+	hws[IMX8MP_CLK_VPU_G1_ROOT] = imx_clk_hw_gate4("vpu_g1_root_clk", "vpu_g1", base + 0x4560, 0);
+	hws[IMX8MP_CLK_GPU_ROOT] = imx_clk_hw_gate4("gpu_root_clk", "gpu_axi", base + 0x4570, 0);
+	hws[IMX8MP_CLK_VPU_VC8KE_ROOT] = imx_clk_hw_gate4("vpu_vc8ke_root_clk", "vpu_vc8000e", base + 0x4590, 0);
+	hws[IMX8MP_CLK_VPU_G2_ROOT] = imx_clk_hw_gate4("vpu_g2_root_clk", "vpu_g2", base + 0x45a0, 0);
+	hws[IMX8MP_CLK_NPU_ROOT] = imx_clk_hw_gate4("npu_root_clk", "ml_core", base + 0x45b0, 0);
+	hws[IMX8MP_CLK_HSIO_ROOT] = imx_clk_hw_gate4("hsio_root_clk", "ipg_root", base + 0x45c0, 0);
+	hws[IMX8MP_CLK_MEDIA_APB_ROOT] = imx_clk_hw_gate2_shared2("media_apb_root_clk", "media_apb", base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_AXI_ROOT] = imx_clk_hw_gate2_shared2("media_axi_root_clk", "media_axi", base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_cam1_pix_root_clk", "media_cam1_pix", base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_CAM2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_cam2_pix_root_clk", "media_cam2_pix", base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp1_pix_root_clk", "media_disp1_pix", base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp2_pix_root_clk", "media_disp2_pix", base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT] = imx_clk_hw_gate2_shared2("media_mipi_phy1_ref_root", "media_mipi_phy1_ref", base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_LDB_ROOT] = imx_clk_hw_gate2_shared2("media_ldb_root_clk", "media_ldb", base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_ISP_ROOT] = imx_clk_hw_gate2_shared2("media_isp_root_clk", "media_isp", base + 0x45d0, 0, &share_count_media);
+
+	hws[IMX8MP_CLK_USDHC3_ROOT] = imx_clk_hw_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0);
+	hws[IMX8MP_CLK_HDMI_ROOT] = imx_clk_hw_gate4("hdmi_root_clk", "hdmi_axi", base + 0x45f0, 0);
+	hws[IMX8MP_CLK_TSENSOR_ROOT] = imx_clk_hw_gate4("tsensor_root_clk", "ipg_root", base + 0x4620, 0);
+	hws[IMX8MP_CLK_VPU_ROOT] = imx_clk_hw_gate4("vpu_root_clk", "vpu_bus", base + 0x4630, 0);
+
+	hws[IMX8MP_CLK_AUDIO_AHB_ROOT] = imx_clk_hw_gate2_shared2("audio_ahb_root", "audio_ahb", base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_AUDIO_AXI_ROOT] = imx_clk_hw_gate2_shared2("audio_axi_root", "audio_axi", base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI1_ROOT] = imx_clk_hw_gate2_shared2("sai1_root", "sai1", base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI2_ROOT] = imx_clk_hw_gate2_shared2("sai2_root", "sai2", base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI3_ROOT] = imx_clk_hw_gate2_shared2("sai3_root", "sai3", base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI5_ROOT] = imx_clk_hw_gate2_shared2("sai5_root", "sai5", base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI6_ROOT] = imx_clk_hw_gate2_shared2("sai6_root", "sai6", base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root", "sai7", base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_PDM_ROOT] = imx_clk_hw_gate2_shared2("pdm_root", "pdm", base + 0x4650, 0, &share_count_audio);
 
 	hws[IMX8MP_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
 					     hws[IMX8MP_CLK_A53_CORE]->clk,
-- 
2.43.0


