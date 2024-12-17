Return-Path: <linux-kernel+bounces-449510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92369F500C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1D9168544
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0344F1FC0FE;
	Tue, 17 Dec 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bpuaXE48"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37F1FBEA4;
	Tue, 17 Dec 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450271; cv=none; b=h7eHGZ0BIbgqpIsMsvo8gnQ7v0AQfwKmRUNqLpSi/tz2hAPMQPa9WQWKMRN91ITy+zCIEJNvy0MteQgEqgDvx9k6jN4styoi7WMfVsyV9Ck1RlDoYtpRtpIG/ruUTVbbEZoNC5zbW3+DVtcY0P6SURhtKksjZf3H0+tof01/aTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450271; c=relaxed/simple;
	bh=K3NExiNqHDr/dH0KkasiqAHlrrm5EPcA/B5tJUWXD5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3jScn8rok5FCayCf2M0eyHDWy941hvbmYYzhLLqLX7DBHXTKM3AxQ4w/1SiIVnSMXhqRBN4kjm8SuDpprPADRlGRyioRjCpWOA3aVVs31yAaPkhQoDE7owD+MmLBLEVgqtgCmca7IeNqWRYvjuFz9LhMbDBeyPcymy3Kae+ZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bpuaXE48; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734450268;
	bh=K3NExiNqHDr/dH0KkasiqAHlrrm5EPcA/B5tJUWXD5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpuaXE48nGNtBHXtgMR0j7EMyBgsvcNAvTnh3/bLBSKGp6d2u8W8LGH6+kxrAW+Nr
	 plgoWmNb46qrN9DzWucPbKlM+ayuniMNAo0p+T5LazKUgb6ROHroMtsNr280cdC8so
	 aAmENhxodxLywM5v5raZUOOexlWkcTTwY/sPaRGWHg5jYxteU9ZpnVjEIBbtHUMs/J
	 4Voxf689aa95Zxo3+4Gug/Gb7/TQfbb9gjPaTpncnv8Z3aF26Avht4WUmAJAdZAAzb
	 U6PCVTQsGbS8s6z9Slm6mN8U+ILBxW++CiIWPHVieE6vc6yj6fX0Xw6+ChuruBqIBE
	 q7eA6sPJW8DkA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C4A1717E37B0;
	Tue, 17 Dec 2024 16:44:26 +0100 (CET)
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
	dmitry.baryshkov@linaro.org
Subject: [PATCH v3 26/33] drm/mediatek: mtk_hdmi: Cleanup function mtk_hdmi_resume()
Date: Tue, 17 Dec 2024 16:43:38 +0100
Message-ID: <20241217154345.276919-27-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
References: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index dbcb9fb09edd..6c9d046809b2 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1705,15 +1705,8 @@ static __maybe_unused int mtk_hdmi_suspend(struct device *dev)
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
2.47.0


