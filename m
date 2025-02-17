Return-Path: <linux-kernel+bounces-517997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EE2A38879
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0AE16944D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6534E225783;
	Mon, 17 Feb 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YX5ZUx9s"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210722ACDC;
	Mon, 17 Feb 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807400; cv=none; b=A0T3U19fsph7suj1vn+La6IN9GJzoh+dMx/IrYSNRTKyaArgwNBEYb73M3jD9sjoajNw5Q8DPq3uvZYd2as7jcMBu8dDTzNgpKyMUh9AAiv4dAd9pHF0mO+jCLeB5CtM5QDTU0C8m5Gs0iBmq/aSbwOe0ph6Wq3+kEqK5ex8e3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807400; c=relaxed/simple;
	bh=AEBaymnMtzThhAWbasPZaB4nuTDWvbmgn6/H+d95Th0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyUy2CYBc/pKc8dhm6455qks677+DKQK2W/IbkYJmz2DESSnHhBgduea2HLPEtNFbGAsWGjz25+eqmLEbEPmpB3+QdywsMmUGy0AHR14ZINpZVQI6/OQefktvKLneiKzEWILGvQaH8Byha9cmvnr7bY84ERZd5zQPdJ3elcMmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YX5ZUx9s; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807397;
	bh=AEBaymnMtzThhAWbasPZaB4nuTDWvbmgn6/H+d95Th0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YX5ZUx9sJ2plJo/oWgVGpZTMOOJ6Hv8j2Q40fudL12f1rI9Pw+vridxzoRhvT6ApT
	 1NUctgP3FmFj9AaYPj/cGhO69fmapdkkLMNUqzHjcCntS80GLdUl4Ib0VxR+/9ouT6
	 tasvXebohR1MJlqwDolGkeUfWe3NYsJ4U3snCDbzpn8kKaZa7JwVNZcU84DJKNezbm
	 nw1ZNHjNVb/U4KMCpoAZILydsBmvAU2zMqo04muXPMNf3tsUWY6B8+OOp8crXBMVF5
	 I+nlkLY/Z8uwZtnnrI9OEHw436j2JmyveEb+Cawi/z12LnZ8SSPxEsnSuyH6vDLAUu
	 b95Wy0aXZPXGg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 22A9B17E156A;
	Mon, 17 Feb 2025 16:49:56 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	jie.qiu@mediatek.com,
	junzhi.zhao@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	dmitry.baryshkov@linaro.org,
	lewis.liao@mediatek.com,
	ives.chenjh@mediatek.com,
	tommyyl.chen@mediatek.com,
	jason-jh.lin@mediatek.com
Subject: [PATCH v7 27/43] drm/mediatek: mtk_hdmi: Remove unused members of struct mtk_hdmi
Date: Mon, 17 Feb 2025 16:48:20 +0100
Message-ID: <20250217154836.108895-28-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hdmi_colorspace csp member of struct mtk_hdmi is initialized
once but then it's never used at all.
Remove said member and the only assignment to it as a cleanup.

Also remove the ibias, ibias_up, min_clock, max_clock, min_hdisplay
and max_vdisplay members, as those were really completely unused.

This commit brings no functional changes.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index eb3b1009c305..6e4900f99b51 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -162,16 +162,9 @@ struct mtk_hdmi {
 	struct clk *clk[MTK_HDMI_CLK_COUNT];
 	struct drm_display_mode mode;
 	bool dvi_mode;
-	u32 min_clock;
-	u32 max_clock;
-	u32 max_hdisplay;
-	u32 max_vdisplay;
-	u32 ibias;
-	u32 ibias_up;
 	struct regmap *sys_regmap;
 	unsigned int sys_offset;
 	struct regmap *regs;
-	enum hdmi_colorspace csp;
 	struct platform_device *audio_pdev;
 	struct hdmi_audio_param aud_param;
 	bool audio_enable;
@@ -1036,7 +1029,6 @@ static int mtk_hdmi_output_init(struct mtk_hdmi *hdmi)
 {
 	struct hdmi_audio_param *aud_param = &hdmi->aud_param;
 
-	hdmi->csp = HDMI_COLORSPACE_RGB;
 	aud_param->aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
 	aud_param->aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 	aud_param->aud_input_type = HDMI_AUD_INPUT_I2S;
-- 
2.48.1


