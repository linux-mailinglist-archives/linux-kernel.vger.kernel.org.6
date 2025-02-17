Return-Path: <linux-kernel+bounces-518002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B069A38896
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2AA1884512
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E7022CBFD;
	Mon, 17 Feb 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qVPOSSBN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040722C35C;
	Mon, 17 Feb 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807408; cv=none; b=O3h1TP7u/cw7vq8UGzngQFSwcYTbl8ge3ZRPTJBZKcOu6ZE3wUAyA5mltS87OKvYUeSJrZQ2cJ2uzkGIiFIN7u6wOHbFr/7xN1kyBPY8yg78uJnEBm9dplRHGVYN2+TPL8SOdAjlMHOLRq1s69Y4yOP4FF9kJQRVFIxkrh1ZlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807408; c=relaxed/simple;
	bh=s9TR1FVrUafUEV8MdpPVkHJ7rP7lJNUQXfdRVs9cVzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7O5CjZ1JxIjHmEt6H74blWQddI5aIuBpAqeDgxYchskMwUhGBrp46dppegOqPCSvzN5RdoPXw6jS6BaSPZeKIrS0SxZU+wV7JcaYu7kDgBXp3ME5El3z2kjFRw5wz6YaoQmAm95hSGJR2w1LOCWvMVOAucL4yd8RNk2kz82ioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qVPOSSBN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807405;
	bh=s9TR1FVrUafUEV8MdpPVkHJ7rP7lJNUQXfdRVs9cVzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVPOSSBNV0u6iiv3VLUG0XphnUt/xZds2RLxmnnp5Rpf+judhtS/FhlACXKnxtunN
	 CpmPs6a+gZ9C5/XnjuFe2XDyhFZvb6dhjRjiTPIUaTePikoDQ5/EvtBHLUNZNXaiW6
	 cHwvRNj0VB55O7jFkU8INoAspvk01ax9gDjZkgd23GzxtTm4rsDvmJ2urRxa++xkeN
	 DItZOV10ZVGykUPDDSXE0L2uJSD0f/FUQFfrvfvkPeN3LhMvRf+Dtr/1ojV3nTLEav
	 1xRJkrggBlqektFJM+WLdNNkRsTI+svnm7O5BIDWxWblK1IFfa5bgmxbATKwQRkpxy
	 Occ05pzRIb2rQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A6BD117E0F86;
	Mon, 17 Feb 2025 16:50:03 +0100 (CET)
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
Subject: [PATCH v7 32/43] drm/mediatek: mtk_hdmi: Remove driver bound to HDMI print
Date: Mon, 17 Feb 2025 16:48:25 +0100
Message-ID: <20250217154836.108895-33-angelogioacchino.delregno@collabora.com>
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

Remove the "driver bound to HDMI" print to avoid useless spam in
the kernel log, as registered and bound drivers can be debugged
through debugfs.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 2e98a8ed6cbe..50f9ab48cbf9 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1632,7 +1632,6 @@ static int mtk_hdmi_register_audio_driver(struct device *dev)
 	if (ret)
 		return ret;
 
-	DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
 	return 0;
 }
 
-- 
2.48.1


