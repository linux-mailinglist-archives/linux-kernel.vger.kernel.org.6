Return-Path: <linux-kernel+bounces-517989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A207CA3886B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07431701B9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B698B229B21;
	Mon, 17 Feb 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OW+EUzom"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C67228C9D;
	Mon, 17 Feb 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807390; cv=none; b=FjBxGuODX4V3M27hiaJ5JjFHTLijqbtnrMoiYOVqkwq8ATxO70/gHhL8JKAv+ERwUr5k6I5kmmPYKXhCRO/Y5SDCUdS86+RfMgrVbceMDXptqwul6ZMdH4WOgQkd6KLh662Pdh5R+4X/L0SRKWn0JQOCsbjrhtN687Y9xwvCZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807390; c=relaxed/simple;
	bh=bw8rCx7v+bgiBlD+SI/NQtL2q5RqtEsz/aiuZYDVTg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVTsZhXaRnAdUKJkoPlB1XM+Vi1KnTd68kOmerXf98LvRW6B23P4n1FquwNX27h8H42lCGOLZN5jwV71XcHsUO0gvX46Gk4Ae0f6u6STLwJfk4yezPDpAEBNnOwQoyHa4oxicOYEKfGoLOY+iIMR7TvXYa3e7m/4MuWLuOdN8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OW+EUzom; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807386;
	bh=bw8rCx7v+bgiBlD+SI/NQtL2q5RqtEsz/aiuZYDVTg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OW+EUzomV5z/EFv6by8ncUUdp8+dp+9Yexb+IIv9gNDj/OMFWeiHnwOGayOQODAuv
	 f9Gru2VhjKYtgWa6jFJGHGOcitnYJtb8+EKovhDdrFjECinl4QwHtrvvjeWU7BYt/U
	 nT3wMtFQ+Z3dk+Ii/6dKcweQzDzxHKgT74FyUQ3bKfUaEmh7UFm/uTEhOQ/xZieAJB
	 MdJAEnSERA0EqZhza+ezX0znEJqh7FQU6sGs5ucwv6r/f5oFB6kL90xk1WNmthk53C
	 VosIHn1hdZ3ntzcEmTVBUylCYoqaWtQ8bTipefuA0U3+ZMWylFCm7LY4mkzV2ZwscF
	 4hUOUiX08GSkA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 95F1E17E1578;
	Mon, 17 Feb 2025 16:49:45 +0100 (CET)
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
Subject: [PATCH v7 20/43] drm/mediatek: mtk_hdmi: Disgregate function mtk_hdmi_audio_set_param()
Date: Mon, 17 Feb 2025 16:48:13 +0100
Message-ID: <20250217154836.108895-21-angelogioacchino.delregno@collabora.com>
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

As a cleanup, and in preparation for splitting common bits of this
driver, disgregate the code in function mtk_hdmi_audio_set_param()
to the beginning and end of function mtk_hdmi_audio_hw_params().

In a later commit, the hw_params callback function will also be
disgregated so that the code will get two functions: one that
performs the generic hdmi_audio_param copy, and one that performs
IP specific setup, both of which will be called in the callback,
allowing all of the non IP version specific code to get moved in
a common file.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 6257503ce639..1f90cac112e2 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1054,20 +1054,6 @@ static void mtk_hdmi_audio_disable(struct mtk_hdmi *hdmi)
 	hdmi->audio_enable = false;
 }
 
-static int mtk_hdmi_audio_set_param(struct mtk_hdmi *hdmi,
-				    struct hdmi_audio_param *param)
-{
-	if (!hdmi->audio_enable) {
-		dev_err(hdmi->dev, "hdmi audio is in disable state!\n");
-		return -EINVAL;
-	}
-	dev_dbg(hdmi->dev, "codec:%d, input:%d, channel:%d, fs:%d\n",
-		param->aud_codec, param->aud_input_type,
-		param->aud_input_chan_type, param->codec_params.sample_rate);
-	memcpy(&hdmi->aud_param, param, sizeof(*param));
-	return mtk_hdmi_aud_output_config(hdmi, &hdmi->mode);
-}
-
 static int mtk_hdmi_output_set_display_mode(struct mtk_hdmi *hdmi,
 					    struct drm_display_mode *mode)
 {
@@ -1487,6 +1473,11 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
 	struct hdmi_audio_param hdmi_params;
 	unsigned int chan = params->cea.channels;
 
+	if (!hdmi->audio_enable) {
+		dev_err(hdmi->dev, "hdmi audio is in disable state!\n");
+		return -EINVAL;
+	}
+
 	dev_dbg(hdmi->dev, "%s: %u Hz, %d bit, %d channels\n", __func__,
 		params->sample_rate, params->sample_width, chan);
 
@@ -1547,8 +1538,13 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
 
 	memcpy(&hdmi_params.codec_params, params,
 	       sizeof(hdmi_params.codec_params));
+	memcpy(&hdmi->aud_param, &hdmi_params, sizeof(hdmi_params));
+
+	dev_dbg(hdmi->dev, "codec:%d, input:%d, channel:%d, fs:%d\n",
+		hdmi_params.aud_codec, hdmi_params.aud_input_type,
+		hdmi_params.aud_input_chan_type, hdmi_params.codec_params.sample_rate);
 
-	mtk_hdmi_audio_set_param(hdmi, &hdmi_params);
+	mtk_hdmi_aud_output_config(hdmi, &hdmi->mode);
 
 	return 0;
 }
-- 
2.48.1


