Return-Path: <linux-kernel+bounces-433148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E95419E5470
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE511690CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2F8215F4E;
	Thu,  5 Dec 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S1Hbia3O"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C999214A6A;
	Thu,  5 Dec 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399152; cv=none; b=UAMJb8kKzUftZPF9pTeNKuKb4gUCKgAuGupSFGmwWzDgpsEXPPrZMubH2bN7k6HDxzPhc8rJZIWCixwD8Ab6kilRuvzF8NtrkwCSy9Za75IABvlNHvTBj/oHZa6X2V8FeMl/9SnAJtqwCo8rshfTiRBsH4iS+GP/qAhuYvv8jnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399152; c=relaxed/simple;
	bh=I2ffCGsBLbgyg0ys+NKCjU6t4+9PoTlYY0fg9x7wOt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRnJcTNJ741nK55OlZR98Jmh8oqRthE9b4EtDZAyoOeGqpqEyyZ0kwbKk4N6xhFSuqOXgapnq1M3vi6k6y1d+XG+wsvt5o3PHU9gpLA2w9ADcjIFJ6x7PCHwAwQxo5AyVMK2yyIIN06UBhrmxqib59lcQIq3J7bNB4DMQUwyrKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S1Hbia3O; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733399148;
	bh=I2ffCGsBLbgyg0ys+NKCjU6t4+9PoTlYY0fg9x7wOt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1Hbia3OTBmNfjwhi9eXRxumCOQHJ0fqjI4VfFJrJpHvBKacwwz3Z3bkRx9tMCuv1
	 0+EGTCKSPx8J8hNfUziyvv+ZZ6X9ifiCxVFcEkzbSef3PDJj4dTvmx+7c7A6y8v7Yf
	 wvaNa+m9iFW2OolX9TohkzajljON8nj+1Jf+ZmneWF2ZgpTFI3gcyVoFg1/SFX0UGy
	 YEsV6MYBMDHVkm35GtLe69K2yoZtD+VGPAldFw2DJv9e95a+Ol+HrBoWy5syA+gcpv
	 TkKIDSZGqlzB9HOblpnnlLIc6GGfTcJ+7y3K44ZQ5iWyh9c1vIROQPFhvtSBsz/hXm
	 XH/BAGJj9xSoQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C716C17E36B6;
	Thu,  5 Dec 2024 12:45:47 +0100 (CET)
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
	kernel@collabora.com
Subject: [PATCH v2 11/15] drm/mediatek: mtk_hdmi: Fix typo for aud_sampe_size member
Date: Thu,  5 Dec 2024 12:45:13 +0100
Message-ID: <20241205114518.53527-12-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename member aud_sampe_size of struct hdmi_audio_param to
aud_sample_size to fix a typo and enhance readability.

This commit brings no functional changes.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 9e8d9144cf86..7808141526fa 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -136,7 +136,7 @@ enum hdmi_aud_channel_swap_type {
 
 struct hdmi_audio_param {
 	enum hdmi_audio_coding_type aud_codec;
-	enum hdmi_audio_sample_size aud_sampe_size;
+	enum hdmi_audio_sample_size aud_sample_size;
 	enum hdmi_aud_input_type aud_input_type;
 	enum hdmi_aud_i2s_fmt aud_i2s_fmt;
 	enum hdmi_aud_mclk aud_mclk;
@@ -1032,7 +1032,7 @@ static int mtk_hdmi_output_init(struct mtk_hdmi *hdmi)
 
 	hdmi->csp = HDMI_COLORSPACE_RGB;
 	aud_param->aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-	aud_param->aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+	aud_param->aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 	aud_param->aud_input_type = HDMI_AUD_INPUT_I2S;
 	aud_param->aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
 	aud_param->aud_mclk = HDMI_AUD_MCLK_128FS;
@@ -1528,14 +1528,14 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
 	switch (daifmt->fmt) {
 	case HDMI_I2S:
 		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		hdmi_params.aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 		hdmi_params.aud_input_type = HDMI_AUD_INPUT_I2S;
 		hdmi_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
 		hdmi_params.aud_mclk = HDMI_AUD_MCLK_128FS;
 		break;
 	case HDMI_SPDIF:
 		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		hdmi_params.aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 		hdmi_params.aud_input_type = HDMI_AUD_INPUT_SPDIF;
 		break;
 	default:
-- 
2.47.0


