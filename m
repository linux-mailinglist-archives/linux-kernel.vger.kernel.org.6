Return-Path: <linux-kernel+bounces-430133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA039E2CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C69163304
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E618DF81;
	Tue,  3 Dec 2024 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZbYSgf4Z"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D1C2500A8;
	Tue,  3 Dec 2024 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256505; cv=none; b=dYWOqRraVOj2aRtsU/+mMV/YGspY62+j9QZlIzsaNfspkeLW585Yqn8rZURIQU1ZKQ52trPWQuBtNr/zRJbxsiY6eQnrMYViMUwpsJVIGtJ3yjXbtYavfr/YPx2o0tzi2l4WitX6YP5e7abTl7KZIRJrp1W155WAuAfzwtceqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256505; c=relaxed/simple;
	bh=nMuqNASdDvXJ7RQQnLGP4ZYna4CqD0GHPdKOd8h24RU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LEfnUQ1jMaCEprKWmggwrGFO3RGK+F7FvkamexXOSOryRHMpx/SSbt/CgCTkop/GW7sDcMg6qJ+t/QzAqnCFk3Xu4d40ACHsun9jy8uLghQG92bHIs9Ajy4y6jwN3+vriHDLPzBLJmK1DaAkXbcjAApNdlGloCerJHIcK0Y52iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZbYSgf4Z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733256500;
	bh=nMuqNASdDvXJ7RQQnLGP4ZYna4CqD0GHPdKOd8h24RU=;
	h=From:Date:Subject:To:Cc:From;
	b=ZbYSgf4Zo1i9VrUp7UXd5QcS7atcnIODtz9GHmtYQ09YmVXT6of71Rh8K3g79PXbG
	 kziOpE5jN2nm/wQR6O1UleZj0LuJEPug4/j42PIsdusXRR0twS5TfMDz75gDkEKv4r
	 gZgRgPe0gpjj/JIqWPk1hUnUZu2voIUsnGXgCFBeCEL4LXhXeaZ4p9NXsqP4t14XjP
	 jgh1xMEZ/OTNd3LwF3AZKzvpCt+Nz60xnhNF9/KHdin0mLbsewVq3+Z+uYi7TII/li
	 2HJJlF0kFNbJXfCq7nd+uJRRDRGfzXU6jOULFq2Owgy4xLz+dPGGwa387JTyLxl4os
	 Krk0yLG0S81dQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1005])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 42EA617E1091;
	Tue,  3 Dec 2024 21:08:18 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 03 Dec 2024 17:07:54 -0300
Subject: [PATCH] ASoC: mediatek: mt8188: Enable apll1 clock during reg rw
 to prevent hang
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241203-mt8188-afe-fix-hang-disabled-apll1-clk-v1-1-07cdd7760834@collabora.com>
X-B4-Tracking: v=1; b=H4sIABplT2cC/x2NwQrCMBAFf6Xs2QfdVDD4K+Jhk2x0MdaSFBFK/
 93ocWCY2ahpNW10Hjaq+rZmr7kDHwaKd5lvCkudyY3uyG6c8Fw9ew/Jimwf/BwkaxKKJshSCiO
 WB8IUmU/exSCZemyp2vX/6HLd9y+aqKzAeAAAAA==
X-Change-ID: 20241203-mt8188-afe-fix-hang-disabled-apll1-clk-b3c11782cbaf
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Currently, booting the Genio 700 EVK board with the MT8188 sound
platform driver configured as a module (CONFIG_SND_SOC_MT8188=m) results
in a system hang right when the HW registers for the audio controller
are read:

  mt8188-audio 10b10000.audio-controller: No cache defaults, reading back from HW

The hang doesn't occur with the driver configured as builtin as then the
unused clocks are still enabled.

Enable the apll1 clock during register read/write to prevent the hang.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
index e69c1bb2cb239596dee50b166c20192d5408be10..fb8cf286df3f02ac076528b898fd0d7a708ec1ea 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
@@ -587,6 +587,8 @@ int mt8188_afe_enable_reg_rw_clk(struct mtk_base_afe *afe)
 	mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A1SYS_HP]);
 	mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A1SYS]);
 
+	mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_APMIXED_APLL1]);
+
 	return 0;
 }
 
@@ -594,6 +596,8 @@ int mt8188_afe_disable_reg_rw_clk(struct mtk_base_afe *afe)
 {
 	struct mt8188_afe_private *afe_priv = afe->platform_priv;
 
+	mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_APMIXED_APLL1]);
+
 	mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A1SYS]);
 	mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A1SYS_HP]);
 	mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE]);

---
base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
change-id: 20241203-mt8188-afe-fix-hang-disabled-apll1-clk-b3c11782cbaf

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


