Return-Path: <linux-kernel+bounces-518003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260CA38885
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC413B635A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563F322D4E5;
	Mon, 17 Feb 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LKnX9YrQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C522C339;
	Mon, 17 Feb 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807409; cv=none; b=AnA8dppxm22jrDG/JONEjgTkENDpf+BkeADA/ICjHaEUresHplyLw00bFZjqRfyHlAA2VM4NkK8bzBO0A/Xvzt35HfuTsc78cfuQrWIrKviSKht3D0AvNOlfdXIgJZtM8yzfEM7VGjPHnA5LrF8EGTyFgeuQt2/BxQX68ycCAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807409; c=relaxed/simple;
	bh=yWBPoUIEixtFs29StdrtKv0VWCZxwUg8b5BuEvXACso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsdENyPUaL0VFabvykDPzAcqhNFK88nQU04LanCwJxgUsQedk12pIxBPea3tXbcpBKF8uVs4YxtbPcjBGaqdTdQ+CQfsp0jq6CpvEC/8ayEnXua9KXVI5ykKdh+ISoR5ZY0tB8QChDPMQ93eaNQVPwE2ae45OIst+/GRjwtpOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LKnX9YrQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807406;
	bh=yWBPoUIEixtFs29StdrtKv0VWCZxwUg8b5BuEvXACso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LKnX9YrQJdeWLLF7QrXVFNtvF3s63a1Auwh90DHOJLzGWrgF6jMR6/qRFaHqJAtNy
	 AG+6Ofe5xdnI4h3UE5s/funIxpqg0UPNIIGfnSewp7ap7hhZMGIYDkP4KsKGxBwR/h
	 3dxXkidRcnLeAR3C4iJz5zGjP3ck/6nFr5vvzakVEjlL5p90a6PqFUopr7EREcjxXF
	 wqw3BqeI7M1/IF+tiRV8WD5cBn3JR6S5V/mHOcHYjtdfVGYJeH+aSXUmUAR2BFQLGG
	 Bb6O6p7x+ZIZZHdVLtkpaAwqiiTbp7saXoWpiQh4vt2aXrscdDr4ngIA3AAiSFdCSj
	 oHlE0vRecsEZg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C95F17E1507;
	Mon, 17 Feb 2025 16:50:05 +0100 (CET)
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
Subject: [PATCH v7 33/43] drm/mediatek: mtk_hdmi: Cleanup function mtk_hdmi_resume()
Date: Mon, 17 Feb 2025 16:48:26 +0100
Message-ID: <20250217154836.108895-34-angelogioacchino.delregno@collabora.com>
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

Remove the error print in case of mtk_hdmi_clk_enable_audio()
failures: since the APIs will already print on their own, having
one in there is redundant.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 50f9ab48cbf9..2614561e2634 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1704,15 +1704,8 @@ static __maybe_unused int mtk_hdmi_suspend(struct device *dev)
 static __maybe_unused int mtk_hdmi_resume(struct device *dev)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
-	int ret = 0;
 
-	ret = mtk_hdmi_clk_enable_audio(hdmi);
-	if (ret) {
-		dev_err(dev, "hdmi resume failed!\n");
-		return ret;
-	}
-
-	return 0;
+	return mtk_hdmi_clk_enable_audio(hdmi);
 }
 
 static SIMPLE_DEV_PM_OPS(mtk_hdmi_pm_ops, mtk_hdmi_suspend, mtk_hdmi_resume);
-- 
2.48.1


