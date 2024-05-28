Return-Path: <linux-kernel+bounces-192265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F68D1AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30061F21CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080516D324;
	Tue, 28 May 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gonCXJrq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792EB16D4F6;
	Tue, 28 May 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898428; cv=none; b=Mvn/wKkfwiCR4rkuPmumlvA7/Dzt6UjQqRWkjxRGP6Ngq8MZVBN1pFlc/aEGZHYz1+frQMc9o4/fxNCHRAWbQlMVFq9OswbDjkrcOfFE/F9fz3ltfT48gMIsOaSPMx4cbeRJuakAvsQ7lN+RBzDYD2NNf94AF11feaopuNX9pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898428; c=relaxed/simple;
	bh=nKtngOUkxmWaPqar5JgjG3IBkkipwOdA3ROroNHL/aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QOg+B99V3Lz2HvR9pmKnkndxTkxOs5HBRPsNXHnG8uNXCakxYjgPsQmkdBGvekeiXNU+4PTbWQuAICO5BvcrorEjkg/kQmcp59y2UZNMdzWTwO3NqDissUH2Yrlvc7dHZH+fgco8+h4uIYBzWKtgM64gf+kdUfy3ycdRUqpfOFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gonCXJrq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716898422;
	bh=nKtngOUkxmWaPqar5JgjG3IBkkipwOdA3ROroNHL/aI=;
	h=From:To:Cc:Subject:Date:From;
	b=gonCXJrqhop1ymsorfF8bZvgEGrrzb0BEjGJPfEd3oIcReACkpkMfUeb/StwqVGyH
	 KZ3OYGabrFUTAvTSDGfpl5xtDRIPYOQXJ6ua7c+iCVj994M/kLfY0vnsvYjYQ6uX2C
	 wr3wGCoJpYnpQbqSQvrboDP/URYpusD3YzeGhT3uOGo4ExSTPN8Qf/MBKL8qVTGzhV
	 VvFq6iA6c3oKTIb2I1i62RHyXp5kJOGT/0ayf6S60GfC+PiWVB7grqyNh60NpJGLos
	 Xtkll1+TTbr4O9+WJtYggQ2WR8CdfeWKUVt9RlCEx/J/S+HoRwqFpxdcCwTevB714q
	 juo/Jl46/Ocnw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0213C378042B;
	Tue, 28 May 2024 12:13:41 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: quic_jjohnson@quicinc.com,
	mturquette@baylibre.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] clk: mediatek: Add a module description where missing
Date: Tue, 28 May 2024 14:13:13 +0200
Message-ID: <20240528121320.160685-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a MODULE_DESCRIPTION() on all drivers that miss it to avoid
modpost warnings.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt2701-aud.c           | 2 ++
 drivers/clk/mediatek/clk-mt2701-bdp.c           | 2 ++
 drivers/clk/mediatek/clk-mt2701-eth.c           | 2 ++
 drivers/clk/mediatek/clk-mt2701-g3d.c           | 2 ++
 drivers/clk/mediatek/clk-mt2701-hif.c           | 2 ++
 drivers/clk/mediatek/clk-mt2701-img.c           | 2 ++
 drivers/clk/mediatek/clk-mt2701-mm.c            | 2 ++
 drivers/clk/mediatek/clk-mt2701-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt2701.c               | 2 ++
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c    | 2 ++
 drivers/clk/mediatek/clk-mt2712-bdp.c           | 2 ++
 drivers/clk/mediatek/clk-mt2712-img.c           | 2 ++
 drivers/clk/mediatek/clk-mt2712-jpgdec.c        | 2 ++
 drivers/clk/mediatek/clk-mt2712-mfg.c           | 2 ++
 drivers/clk/mediatek/clk-mt2712-mm.c            | 2 ++
 drivers/clk/mediatek/clk-mt2712-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt2712-venc.c          | 2 ++
 drivers/clk/mediatek/clk-mt2712.c               | 2 ++
 drivers/clk/mediatek/clk-mt6765-audio.c         | 2 ++
 drivers/clk/mediatek/clk-mt6765-cam.c           | 2 ++
 drivers/clk/mediatek/clk-mt6765-img.c           | 2 ++
 drivers/clk/mediatek/clk-mt6765-mipi0a.c        | 2 ++
 drivers/clk/mediatek/clk-mt6765-mm.c            | 2 ++
 drivers/clk/mediatek/clk-mt6765-vcodec.c        | 2 ++
 drivers/clk/mediatek/clk-mt6765.c               | 2 ++
 drivers/clk/mediatek/clk-mt6779-aud.c           | 3 ++-
 drivers/clk/mediatek/clk-mt6779-cam.c           | 3 ++-
 drivers/clk/mediatek/clk-mt6779-img.c           | 2 ++
 drivers/clk/mediatek/clk-mt6779-ipe.c           | 2 ++
 drivers/clk/mediatek/clk-mt6779-mfg.c           | 2 ++
 drivers/clk/mediatek/clk-mt6779-mm.c            | 2 ++
 drivers/clk/mediatek/clk-mt6779-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt6779-venc.c          | 2 ++
 drivers/clk/mediatek/clk-mt6779.c               | 2 ++
 drivers/clk/mediatek/clk-mt6795-mm.c            | 2 +-
 drivers/clk/mediatek/clk-mt6797-img.c           | 2 ++
 drivers/clk/mediatek/clk-mt6797-mm.c            | 2 ++
 drivers/clk/mediatek/clk-mt6797-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt6797-venc.c          | 2 ++
 drivers/clk/mediatek/clk-mt6797.c               | 2 ++
 drivers/clk/mediatek/clk-mt7622-aud.c           | 2 ++
 drivers/clk/mediatek/clk-mt7622-eth.c           | 2 ++
 drivers/clk/mediatek/clk-mt7622-hif.c           | 2 ++
 drivers/clk/mediatek/clk-mt7629-eth.c           | 2 ++
 drivers/clk/mediatek/clk-mt7629-hif.c           | 2 ++
 drivers/clk/mediatek/clk-mt7629.c               | 2 ++
 drivers/clk/mediatek/clk-mt7981-apmixed.c       | 2 ++
 drivers/clk/mediatek/clk-mt7981-eth.c           | 2 ++
 drivers/clk/mediatek/clk-mt7981-infracfg.c      | 2 ++
 drivers/clk/mediatek/clk-mt7981-topckgen.c      | 2 ++
 drivers/clk/mediatek/clk-mt7986-apmixed.c       | 2 ++
 drivers/clk/mediatek/clk-mt7986-topckgen.c      | 2 ++
 drivers/clk/mediatek/clk-mt7988-apmixed.c       | 2 ++
 drivers/clk/mediatek/clk-mt7988-infracfg.c      | 2 ++
 drivers/clk/mediatek/clk-mt7988-topckgen.c      | 2 ++
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c    | 2 ++
 drivers/clk/mediatek/clk-mt8167-aud.c           | 2 ++
 drivers/clk/mediatek/clk-mt8167-img.c           | 2 ++
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c        | 2 ++
 drivers/clk/mediatek/clk-mt8167-mm.c            | 2 ++
 drivers/clk/mediatek/clk-mt8167-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt8167.c               | 2 ++
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c    | 2 ++
 drivers/clk/mediatek/clk-mt8183-audio.c         | 2 ++
 drivers/clk/mediatek/clk-mt8183-cam.c           | 2 ++
 drivers/clk/mediatek/clk-mt8183-img.c           | 2 ++
 drivers/clk/mediatek/clk-mt8183-ipu0.c          | 2 ++
 drivers/clk/mediatek/clk-mt8183-ipu1.c          | 2 ++
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c       | 2 ++
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c      | 2 ++
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c        | 2 ++
 drivers/clk/mediatek/clk-mt8183-mm.c            | 2 ++
 drivers/clk/mediatek/clk-mt8183-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt8183-venc.c          | 2 ++
 drivers/clk/mediatek/clk-mt8183.c               | 2 ++
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c    | 2 ++
 drivers/clk/mediatek/clk-mt8186-cam.c           | 2 ++
 drivers/clk/mediatek/clk-mt8186-img.c           | 2 ++
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c  | 2 ++
 drivers/clk/mediatek/clk-mt8186-infra_ao.c      | 2 ++
 drivers/clk/mediatek/clk-mt8186-ipe.c           | 2 ++
 drivers/clk/mediatek/clk-mt8186-mdp.c           | 2 ++
 drivers/clk/mediatek/clk-mt8186-mfg.c           | 2 ++
 drivers/clk/mediatek/clk-mt8186-mm.c            | 2 ++
 drivers/clk/mediatek/clk-mt8186-topckgen.c      | 2 ++
 drivers/clk/mediatek/clk-mt8186-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt8186-venc.c          | 2 ++
 drivers/clk/mediatek/clk-mt8186-wpe.c           | 2 ++
 drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c | 2 ++
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c    | 2 ++
 drivers/clk/mediatek/clk-mt8188-cam.c           | 3 ++-
 drivers/clk/mediatek/clk-mt8188-ccu.c           | 3 ++-
 drivers/clk/mediatek/clk-mt8188-img.c           | 3 ++-
 drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c  | 2 ++
 drivers/clk/mediatek/clk-mt8188-infra_ao.c      | 2 ++
 drivers/clk/mediatek/clk-mt8188-ipe.c           | 2 ++
 drivers/clk/mediatek/clk-mt8188-mfg.c           | 2 ++
 drivers/clk/mediatek/clk-mt8188-peri_ao.c       | 2 ++
 drivers/clk/mediatek/clk-mt8188-topckgen.c      | 2 ++
 drivers/clk/mediatek/clk-mt8188-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt8188-vdo0.c          | 2 ++
 drivers/clk/mediatek/clk-mt8188-vdo1.c          | 2 ++
 drivers/clk/mediatek/clk-mt8188-venc.c          | 3 ++-
 drivers/clk/mediatek/clk-mt8188-vpp0.c          | 2 ++
 drivers/clk/mediatek/clk-mt8188-vpp1.c          | 2 ++
 drivers/clk/mediatek/clk-mt8188-wpe.c           | 3 ++-
 drivers/clk/mediatek/clk-mt8192-aud.c           | 2 ++
 drivers/clk/mediatek/clk-mt8192-cam.c           | 2 ++
 drivers/clk/mediatek/clk-mt8192-img.c           | 2 ++
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c  | 2 ++
 drivers/clk/mediatek/clk-mt8192-ipe.c           | 2 ++
 drivers/clk/mediatek/clk-mt8192-mdp.c           | 2 ++
 drivers/clk/mediatek/clk-mt8192-mfg.c           | 2 ++
 drivers/clk/mediatek/clk-mt8192-mm.c            | 2 ++
 drivers/clk/mediatek/clk-mt8192-msdc.c          | 2 ++
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c      | 2 ++
 drivers/clk/mediatek/clk-mt8192-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt8192-venc.c          | 2 ++
 drivers/clk/mediatek/clk-mt8192.c               | 2 ++
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c    | 2 ++
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c    | 2 ++
 drivers/clk/mediatek/clk-mt8195-cam.c           | 2 ++
 drivers/clk/mediatek/clk-mt8195-ccu.c           | 2 ++
 drivers/clk/mediatek/clk-mt8195-img.c           | 2 ++
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c  | 2 ++
 drivers/clk/mediatek/clk-mt8195-infra_ao.c      | 2 ++
 drivers/clk/mediatek/clk-mt8195-ipe.c           | 2 ++
 drivers/clk/mediatek/clk-mt8195-mfg.c           | 2 ++
 drivers/clk/mediatek/clk-mt8195-peri_ao.c       | 2 ++
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c      | 2 ++
 drivers/clk/mediatek/clk-mt8195-topckgen.c      | 2 ++
 drivers/clk/mediatek/clk-mt8195-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt8195-vdo0.c          | 2 ++
 drivers/clk/mediatek/clk-mt8195-vdo1.c          | 2 ++
 drivers/clk/mediatek/clk-mt8195-venc.c          | 2 ++
 drivers/clk/mediatek/clk-mt8195-vpp0.c          | 2 ++
 drivers/clk/mediatek/clk-mt8195-vpp1.c          | 2 ++
 drivers/clk/mediatek/clk-mt8195-wpe.c           | 2 ++
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c    | 2 ++
 drivers/clk/mediatek/clk-mt8365-apu.c           | 2 ++
 drivers/clk/mediatek/clk-mt8365-cam.c           | 2 ++
 drivers/clk/mediatek/clk-mt8365-mfg.c           | 2 ++
 drivers/clk/mediatek/clk-mt8365-mm.c            | 2 ++
 drivers/clk/mediatek/clk-mt8365-vdec.c          | 2 ++
 drivers/clk/mediatek/clk-mt8365-venc.c          | 2 ++
 drivers/clk/mediatek/clk-mt8365.c               | 2 ++
 146 files changed, 291 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 27eecb6d3a53..15859132c769 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -165,4 +165,6 @@ static struct platform_driver clk_mt2701_aud_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_aud_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2701 audio clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index b25703ec8dc0..e203dca70786 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -106,4 +106,6 @@ static struct platform_driver clk_mt2701_bdp_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_bdp_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2701 BDP clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 056d1e8459da..f6e1fdc9ee0a 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -60,4 +60,6 @@ static struct platform_driver clk_mt2701_eth_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_eth_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2701 Ethernet clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index d25687f6c9b4..5e04975433ea 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -57,4 +57,6 @@ static struct platform_driver clk_mt2701_g3d_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_g3d_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2701 GPU g3d clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index cbd5ece3e9e9..c7b38d066403 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -57,4 +57,6 @@ static struct platform_driver clk_mt2701_hif_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_hif_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2701 HIFSYS clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index 2768360b213e..ce13b79a7994 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -54,4 +54,6 @@ static struct platform_driver clk_mt2701_img_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_img_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2701 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index 2b990b5a0422..903592be56b5 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -87,4 +87,6 @@ static struct platform_driver clk_mt2701_mm_drv = {
 	.id_table = clk_mt2701_mm_id_table,
 };
 module_platform_driver(clk_mt2701_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2701 MultiMedia ddp clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index 57711b953b7f..591091fb2151 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -59,4 +59,6 @@ static struct platform_driver clk_mt2701_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2701 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 12d9560eb4ba..1e88ad8b93f4 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -1037,4 +1037,6 @@ static int __init clk_mt2701_init(void)
 }
 
 arch_initcall(clk_mt2701_init);
+
+MODULE_DESCRIPTION("MediaTek MT2701 main clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
index 43272dc744c7..66987d205eee 100644
--- a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
@@ -163,4 +163,6 @@ static struct platform_driver clk_mt2712_apmixed_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_apmixed_drv)
+
+MODULE_DESCRIPTION("MediaTek MT2712 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index 1b54b1f3808d..93c5453e4392 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -76,4 +76,6 @@ static struct platform_driver clk_mt2712_bdp_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_bdp_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2712 BDP clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index 1fecc0f68f0e..84abd0515fd2 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -54,4 +54,6 @@ static struct platform_driver clk_mt2712_img_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_img_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2712 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index 019080d6d0f0..89be9082adba 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -50,4 +50,6 @@ static struct platform_driver clk_mt2712_jpgdec_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_jpgdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2712 JPEG Decoder clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index 39161516cf21..f7e0d0ebf665 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -49,4 +49,6 @@ static struct platform_driver clk_mt2712_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_mfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2712 GPU mfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 15cb61fe2d2f..248529d3134d 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -128,4 +128,6 @@ static struct platform_driver clk_mt2712_mm_drv = {
 	.id_table = clk_mt2712_mm_id_table,
 };
 module_platform_driver(clk_mt2712_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2712 MultiMedia ddp clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index e1dd38fc2b3c..a063f1f0aa52 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -62,4 +62,6 @@ static struct platform_driver clk_mt2712_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2712 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index ef6608a5db38..5b15df0a26f5 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -51,4 +51,6 @@ static struct platform_driver clk_mt2712_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_venc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2712 Video Encoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index a8d12a1210fc..91af45160aa4 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1000,4 +1000,6 @@ static struct platform_driver clk_mt2712_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2712 main clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
index 901bf793c272..3e481c697eff 100644
--- a/drivers/clk/mediatek/clk-mt6765-audio.c
+++ b/drivers/clk/mediatek/clk-mt6765-audio.c
@@ -76,4 +76,6 @@ static struct platform_driver clk_mt6765_audio_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_audio_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6765 audio clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-cam.c b/drivers/clk/mediatek/clk-mt6765-cam.c
index 19cedfa832bc..fed9c789d9fa 100644
--- a/drivers/clk/mediatek/clk-mt6765-cam.c
+++ b/drivers/clk/mediatek/clk-mt6765-cam.c
@@ -57,4 +57,6 @@ static struct platform_driver clk_mt6765_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_cam_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6765 Camera clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-img.c b/drivers/clk/mediatek/clk-mt6765-img.c
index 16e20c61932e..34bb89ffd2dd 100644
--- a/drivers/clk/mediatek/clk-mt6765-img.c
+++ b/drivers/clk/mediatek/clk-mt6765-img.c
@@ -53,4 +53,6 @@ static struct platform_driver clk_mt6765_img_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_img_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6765 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-mipi0a.c b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
index cc5bb0c95f08..957eb494fee5 100644
--- a/drivers/clk/mediatek/clk-mt6765-mipi0a.c
+++ b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
@@ -50,4 +50,6 @@ static struct platform_driver clk_mt6765_mipi0a_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_mipi0a_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6765 Camera clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-mm.c b/drivers/clk/mediatek/clk-mt6765-mm.c
index fc5842e13b78..099540fcfc76 100644
--- a/drivers/clk/mediatek/clk-mt6765-mm.c
+++ b/drivers/clk/mediatek/clk-mt6765-mm.c
@@ -79,4 +79,6 @@ static struct platform_driver clk_mt6765_mm_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6765 MultiMedia clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-vcodec.c b/drivers/clk/mediatek/clk-mt6765-vcodec.c
index d6e036795b0a..64f3451d0aee 100644
--- a/drivers/clk/mediatek/clk-mt6765-vcodec.c
+++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
@@ -52,4 +52,6 @@ static struct platform_driver clk_mt6765_vcodec_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_vcodec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6765 Video Codec clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 9c7f7407d798..d53731e7933f 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -873,4 +873,6 @@ static int __init clk_mt6765_init(void)
 }
 
 arch_initcall(clk_mt6765_init);
+
+MODULE_DESCRIPTION("MediaTek MT6765 main clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-aud.c b/drivers/clk/mediatek/clk-mt6779-aud.c
index 66ae6421e27e..3d23b8e29af6 100644
--- a/drivers/clk/mediatek/clk-mt6779-aud.c
+++ b/drivers/clk/mediatek/clk-mt6779-aud.c
@@ -110,6 +110,7 @@ static struct platform_driver clk_mt6779_aud_drv = {
 		.of_match_table = of_match_clk_mt6779_aud,
 	},
 };
-
 module_platform_driver(clk_mt6779_aud_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6779 audio clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-cam.c b/drivers/clk/mediatek/clk-mt6779-cam.c
index 7b1a40d891ad..e76b2c4f548e 100644
--- a/drivers/clk/mediatek/clk-mt6779-cam.c
+++ b/drivers/clk/mediatek/clk-mt6779-cam.c
@@ -61,6 +61,7 @@ static struct platform_driver clk_mt6779_cam_drv = {
 		.of_match_table = of_match_clk_mt6779_cam,
 	},
 };
-
 module_platform_driver(clk_mt6779_cam_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6779 Camera clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-img.c b/drivers/clk/mediatek/clk-mt6779-img.c
index 1c53209f60a9..0c5971f3966a 100644
--- a/drivers/clk/mediatek/clk-mt6779-img.c
+++ b/drivers/clk/mediatek/clk-mt6779-img.c
@@ -55,4 +55,6 @@ static struct platform_driver clk_mt6779_img_drv = {
 };
 
 module_platform_driver(clk_mt6779_img_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6779 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-ipe.c b/drivers/clk/mediatek/clk-mt6779-ipe.c
index 784bc08ace5e..9c1a9f1b0f3e 100644
--- a/drivers/clk/mediatek/clk-mt6779-ipe.c
+++ b/drivers/clk/mediatek/clk-mt6779-ipe.c
@@ -57,4 +57,6 @@ static struct platform_driver clk_mt6779_ipe_drv = {
 };
 
 module_platform_driver(clk_mt6779_ipe_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6779 Image Processing Engine clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-mfg.c b/drivers/clk/mediatek/clk-mt6779-mfg.c
index 040e4c45fa5f..3cc82b59117f 100644
--- a/drivers/clk/mediatek/clk-mt6779-mfg.c
+++ b/drivers/clk/mediatek/clk-mt6779-mfg.c
@@ -52,4 +52,6 @@ static struct platform_driver clk_mt6779_mfg_drv = {
 };
 
 module_platform_driver(clk_mt6779_mfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6779 GPU mfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/clk-mt6779-mm.c
index 5e17e441f679..97d437a6f98f 100644
--- a/drivers/clk/mediatek/clk-mt6779-mm.c
+++ b/drivers/clk/mediatek/clk-mt6779-mm.c
@@ -106,4 +106,6 @@ static struct platform_driver clk_mt6779_mm_drv = {
 };
 
 module_platform_driver(clk_mt6779_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6779 MultiMedia mdp/ddp clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-vdec.c b/drivers/clk/mediatek/clk-mt6779-vdec.c
index a411c23512b7..a9122e627aa5 100644
--- a/drivers/clk/mediatek/clk-mt6779-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6779-vdec.c
@@ -64,4 +64,6 @@ static struct platform_driver clk_mt6779_vdec_drv = {
 };
 
 module_platform_driver(clk_mt6779_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6779 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-venc.c b/drivers/clk/mediatek/clk-mt6779-venc.c
index f14512d284d6..2cd032648eb1 100644
--- a/drivers/clk/mediatek/clk-mt6779-venc.c
+++ b/drivers/clk/mediatek/clk-mt6779-venc.c
@@ -55,4 +55,6 @@ static struct platform_driver clk_mt6779_venc_drv = {
 };
 
 module_platform_driver(clk_mt6779_venc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6779 Video Encoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index ffedb1fe3c67..819253b97a02 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1330,4 +1330,6 @@ static int __init clk_mt6779_init(void)
 }
 
 arch_initcall(clk_mt6779_init);
+
+MODULE_DESCRIPTION("MediaTek MT6779 main clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6795-mm.c b/drivers/clk/mediatek/clk-mt6795-mm.c
index ced6e310d694..dd1708d689dc 100644
--- a/drivers/clk/mediatek/clk-mt6795-mm.c
+++ b/drivers/clk/mediatek/clk-mt6795-mm.c
@@ -97,5 +97,5 @@ static struct platform_driver clk_mt6795_mm_drv = {
 };
 module_platform_driver(clk_mt6795_mm_drv);
 
-MODULE_DESCRIPTION("MediaTek MT6795 MultiMedia clocks driver");
+MODULE_DESCRIPTION("MediaTek MT6795 MMSYS clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797-img.c b/drivers/clk/mediatek/clk-mt6797-img.c
index e1c1ee692a1d..0ec0cf2154dc 100644
--- a/drivers/clk/mediatek/clk-mt6797-img.c
+++ b/drivers/clk/mediatek/clk-mt6797-img.c
@@ -50,4 +50,6 @@ static struct platform_driver clk_mt6797_img_drv = {
 	},
 };
 module_platform_driver(clk_mt6797_img_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6797 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index 5b0a77530b62..f5701e965792 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -100,4 +100,6 @@ static struct platform_driver clk_mt6797_mm_drv = {
 	.id_table = clk_mt6797_mm_id_table,
 };
 module_platform_driver(clk_mt6797_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6797 MultiMedia clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797-vdec.c b/drivers/clk/mediatek/clk-mt6797-vdec.c
index 0ed6710ab88e..c967d5e25c7d 100644
--- a/drivers/clk/mediatek/clk-mt6797-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6797-vdec.c
@@ -61,4 +61,6 @@ static struct platform_driver clk_mt6797_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt6797_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6797 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797-venc.c b/drivers/clk/mediatek/clk-mt6797-venc.c
index 93d1da7423fe..f6fac5db65b0 100644
--- a/drivers/clk/mediatek/clk-mt6797-venc.c
+++ b/drivers/clk/mediatek/clk-mt6797-venc.c
@@ -52,4 +52,6 @@ static struct platform_driver clk_mt6797_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt6797_venc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6797 Video Encoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index f12d4e9ff0bb..fb59e71af58e 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -708,4 +708,6 @@ static int __init clk_mt6797_init(void)
 }
 
 arch_initcall(clk_mt6797_init);
+
+MODULE_DESCRIPTION("MediaTek MT6797 main clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 42bade71e2f8..b7bf626e4d14 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -156,4 +156,6 @@ static struct platform_driver clk_mt7622_aud_drv = {
 	},
 };
 module_platform_driver(clk_mt7622_aud_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7622 audio clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 62fdf127e77d..fa4876317a8d 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -86,4 +86,6 @@ static struct platform_driver clk_mt7622_eth_drv = {
 	},
 };
 module_platform_driver(clk_mt7622_eth_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7622 Ethernet clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index b4a520ce362c..8e57582454c2 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -98,4 +98,6 @@ static struct platform_driver clk_mt7622_hif_drv = {
 	},
 };
 module_platform_driver(clk_mt7622_hif_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7622 HIF clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 1bfedc988cfe..29ea93abaac5 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -157,4 +157,6 @@ static struct platform_driver clk_mt7629_eth_drv = {
 };
 
 builtin_platform_driver(clk_mt7629_eth_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7629 Ethernet clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index dd1be946a8f0..96d1a82ad75f 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -93,4 +93,6 @@ static struct platform_driver clk_mt7629_hif_drv = {
 	},
 };
 module_platform_driver(clk_mt7629_hif_drv);
+
+MODULE_DESCRIPTION("MediaTek MT2701 HIF clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index b8a1f01bc974..baf94e7bea37 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -698,4 +698,6 @@ static int clk_mt7629_init(void)
 }
 
 arch_initcall(clk_mt7629_init);
+
+MODULE_DESCRIPTION("MediaTek MT7629 main clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7981-apmixed.c b/drivers/clk/mediatek/clk-mt7981-apmixed.c
index 98739877f430..e8211eb4e09e 100644
--- a/drivers/clk/mediatek/clk-mt7981-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7981-apmixed.c
@@ -99,4 +99,6 @@ static struct platform_driver clk_mt7981_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt7981_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7981 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7981-eth.c b/drivers/clk/mediatek/clk-mt7981-eth.c
index fb1a8c9242ef..e8cb247db0ce 100644
--- a/drivers/clk/mediatek/clk-mt7981-eth.c
+++ b/drivers/clk/mediatek/clk-mt7981-eth.c
@@ -114,4 +114,6 @@ static struct platform_driver clk_mt7981_eth_drv = {
 	},
 };
 module_platform_driver(clk_mt7981_eth_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7981 Ethernet clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7981-infracfg.c b/drivers/clk/mediatek/clk-mt7981-infracfg.c
index 18bf4e8be457..b2b055151297 100644
--- a/drivers/clk/mediatek/clk-mt7981-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
@@ -204,4 +204,6 @@ static struct platform_driver clk_mt7981_infracfg_drv = {
 	},
 };
 module_platform_driver(clk_mt7981_infracfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7981 infracfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
index 493aa11d3a17..72f2f4f30e85 100644
--- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
@@ -420,4 +420,6 @@ static struct platform_driver clk_mt7981_topckgen_drv = {
 	},
 };
 module_platform_driver(clk_mt7981_topckgen_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7981 top clock generators driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
index 7f807fbdfcb9..93751abe6be8 100644
--- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -97,4 +97,6 @@ static struct platform_driver clk_mt7986_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt7986_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7986 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index 84bc24511504..b644b4ca4710 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -313,4 +313,6 @@ static struct platform_driver clk_mt7986_topckgen_drv = {
 	},
 };
 module_platform_driver(clk_mt7986_topckgen_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7986 top clock generators driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7988-apmixed.c b/drivers/clk/mediatek/clk-mt7988-apmixed.c
index baf9564351a3..63d33a78cb48 100644
--- a/drivers/clk/mediatek/clk-mt7988-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7988-apmixed.c
@@ -111,4 +111,6 @@ static struct platform_driver clk_mt7988_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt7988_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7988 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
index c8c023afe3e5..6c2bebabb4de 100644
--- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
@@ -295,4 +295,6 @@ static struct platform_driver clk_mt7988_infracfg_drv = {
 	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt7988_infracfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7988 infracfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7988-topckgen.c b/drivers/clk/mediatek/clk-mt7988-topckgen.c
index 760f8e0d2f26..7300e9694582 100644
--- a/drivers/clk/mediatek/clk-mt7988-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7988-topckgen.c
@@ -322,4 +322,6 @@ static struct platform_driver clk_mt7988_topckgen_drv = {
 	},
 };
 module_platform_driver(clk_mt7988_topckgen_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7988 top clock generators driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
index fca41f50d6ba..adf576786696 100644
--- a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
@@ -142,4 +142,6 @@ static struct platform_driver clk_mt8167_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt8167_apmixed_drv)
+
+MODULE_DESCRIPTION("MediaTek MT8167 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index a5181f4eb34a..d1a42ff549c1 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -61,4 +61,6 @@ static struct platform_driver clk_mt8167_audsys_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_audsys_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8167 audio clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 02fa52d8aabb..888ac3bdeacb 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -53,4 +53,6 @@ static struct platform_driver clk_mt8167_imgsys_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_imgsys_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8167 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index a5b5ee7ac805..e873766f130c 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -51,4 +51,6 @@ static struct platform_driver clk_mt8167_mfgcfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_mfgcfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8167 GPU mfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index 9b0c6b3343b9..38deedffaacf 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -92,4 +92,6 @@ static struct platform_driver clk_mt8167_mm_drv = {
 	.id_table = clk_mt8167_mm_id_table,
 };
 module_platform_driver(clk_mt8167_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8167 MultiMedia clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index 1e1e76743180..c3c892bb8334 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -60,4 +60,6 @@ static struct platform_driver clk_mt8167_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8167 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index 270221c6e6e8..5c94995f859c 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -894,4 +894,6 @@ static struct platform_driver clk_mt8167_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_drv);
+
+MODULE_DESCRIPTION("MediaTek MTì8167 main clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
index 2b261c0e2b61..551adbfd7ac9 100644
--- a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
@@ -192,4 +192,6 @@ static struct platform_driver clk_mt8183_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt8183_apmixed_drv)
+
+MODULE_DESCRIPTION("MediaTek MT8183 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index 716b26825ef0..30a20e8ba84b 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -108,4 +108,6 @@ static struct platform_driver clk_mt8183_audio_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_audio_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 audio clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-cam.c b/drivers/clk/mediatek/clk-mt8183-cam.c
index b0f8e4242a63..f16c3aa3c911 100644
--- a/drivers/clk/mediatek/clk-mt8183-cam.c
+++ b/drivers/clk/mediatek/clk-mt8183-cam.c
@@ -58,4 +58,6 @@ static struct platform_driver clk_mt8183_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_cam_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 Camera clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-img.c b/drivers/clk/mediatek/clk-mt8183-img.c
index 6e177d2e8872..32ee6a1867fc 100644
--- a/drivers/clk/mediatek/clk-mt8183-img.c
+++ b/drivers/clk/mediatek/clk-mt8183-img.c
@@ -58,4 +58,6 @@ static struct platform_driver clk_mt8183_img_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_img_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu0.c b/drivers/clk/mediatek/clk-mt8183-ipu0.c
index 0b61c7af8aea..dc2916c4e0dc 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu0.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu0.c
@@ -51,4 +51,6 @@ static struct platform_driver clk_mt8183_ipu_core0_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_ipu_core0_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 Pri. Image Processing Unit clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu1.c b/drivers/clk/mediatek/clk-mt8183-ipu1.c
index 544b1ca0e1c5..9c63e4c592d0 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu1.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu1.c
@@ -51,4 +51,6 @@ static struct platform_driver clk_mt8183_ipu_core1_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_ipu_core1_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 Sec. Image Processing Unit clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
index 7f53674f393c..54a50eda1719 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
@@ -49,4 +49,6 @@ static struct platform_driver clk_mt8183_ipu_adl_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_ipu_adl_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 Image Processing Unit ADL driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
index fb03ad2d8f6a..99a817d3be6c 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
@@ -118,4 +118,6 @@ static struct platform_driver clk_mt8183_ipu_conn_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_ipu_conn_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 Image Processing Unit Bus clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index ba504e19d420..c89c3d58fedc 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -50,4 +50,6 @@ static struct platform_driver clk_mt8183_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_mfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 GPU mfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 8aaddcfee568..59acf1e2951b 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -102,4 +102,6 @@ static struct platform_driver clk_mt8183_mm_drv = {
 	.id_table = clk_mt8183_mm_id_table,
 };
 module_platform_driver(clk_mt8183_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 MultiMedia clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediatek/clk-mt8183-vdec.c
index aa0cf6e765a5..384270566db4 100644
--- a/drivers/clk/mediatek/clk-mt8183-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
@@ -67,4 +67,6 @@ static struct platform_driver clk_mt8183_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-venc.c b/drivers/clk/mediatek/clk-mt8183-venc.c
index a8e0220902ae..8f36688dfa14 100644
--- a/drivers/clk/mediatek/clk-mt8183-venc.c
+++ b/drivers/clk/mediatek/clk-mt8183-venc.c
@@ -54,4 +54,6 @@ static struct platform_driver clk_mt8183_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_venc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8183 Video Encoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 934d5a15acfc..27eee4ef2c0f 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -906,4 +906,6 @@ static struct platform_driver clk_mt8183_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_drv)
+
+MODULE_DESCRIPTION("MediaTek MT8183 main clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
index fff64a8fd557..6f7127003e4f 100644
--- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
@@ -192,4 +192,6 @@ static struct platform_driver clk_mt8186_apmixed_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-cam.c b/drivers/clk/mediatek/clk-mt8186-cam.c
index effd2900d2e8..0082f0d9286b 100644
--- a/drivers/clk/mediatek/clk-mt8186-cam.c
+++ b/drivers/clk/mediatek/clk-mt8186-cam.c
@@ -89,4 +89,6 @@ static struct platform_driver clk_mt8186_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_cam_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 Camera clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-img.c b/drivers/clk/mediatek/clk-mt8186-img.c
index 71b0571e6351..0583a18805ce 100644
--- a/drivers/clk/mediatek/clk-mt8186-img.c
+++ b/drivers/clk/mediatek/clk-mt8186-img.c
@@ -67,4 +67,6 @@ static struct platform_driver clk_mt8186_img_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_img_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
index 871b8ff4c287..2994e88a275e 100644
--- a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
@@ -66,4 +66,6 @@ static struct platform_driver clk_mt8186_imp_iic_wrap_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_imp_iic_wrap_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 I2C Wrapper clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-infra_ao.c b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
index c490f1a310f8..2a0548ff5209 100644
--- a/drivers/clk/mediatek/clk-mt8186-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
@@ -238,4 +238,6 @@ static struct platform_driver clk_mt8186_infra_ao_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_infra_ao_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 infracfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-ipe.c b/drivers/clk/mediatek/clk-mt8186-ipe.c
index 60739e225cb6..77bdd2806517 100644
--- a/drivers/clk/mediatek/clk-mt8186-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8186-ipe.c
@@ -54,4 +54,6 @@ static struct platform_driver clk_mt8186_ipe_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_ipe_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 Image Processing Engine clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-mdp.c b/drivers/clk/mediatek/clk-mt8186-mdp.c
index 9a335f2285ce..fb47d6bacf7f 100644
--- a/drivers/clk/mediatek/clk-mt8186-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8186-mdp.c
@@ -79,4 +79,6 @@ static struct platform_driver clk_mt8186_mdp_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_mdp_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 Multimedia Data Path clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-mfg.c b/drivers/clk/mediatek/clk-mt8186-mfg.c
index 7618dad9e0e0..64cdee1fddd4 100644
--- a/drivers/clk/mediatek/clk-mt8186-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8186-mfg.c
@@ -48,4 +48,6 @@ static struct platform_driver clk_mt8186_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_mfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 GPU mfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index 44ed504a8069..403566187e64 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -78,4 +78,6 @@ static struct platform_driver clk_mt8186_mm_drv = {
 	.id_table = clk_mt8186_mm_id_table,
 };
 module_platform_driver(clk_mt8186_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 MultiMedia clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index 8e385d6bfef2..eb9f51e77ca8 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -732,4 +732,6 @@ static struct platform_driver clk_mt8186_topck_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_topck_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 top clock generators driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-vdec.c b/drivers/clk/mediatek/clk-mt8186-vdec.c
index 0b814e8e107f..25465704ddfb 100644
--- a/drivers/clk/mediatek/clk-mt8186-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8186-vdec.c
@@ -87,4 +87,6 @@ static struct platform_driver clk_mt8186_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-venc.c b/drivers/clk/mediatek/clk-mt8186-venc.c
index 9493e51af3e2..647dd66a3ce0 100644
--- a/drivers/clk/mediatek/clk-mt8186-venc.c
+++ b/drivers/clk/mediatek/clk-mt8186-venc.c
@@ -50,4 +50,6 @@ static struct platform_driver clk_mt8186_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_venc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 Video Encoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-wpe.c b/drivers/clk/mediatek/clk-mt8186-wpe.c
index a0174eabef4a..47f96e088361 100644
--- a/drivers/clk/mediatek/clk-mt8186-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8186-wpe.c
@@ -50,4 +50,6 @@ static struct platform_driver clk_mt8186_wpe_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_wpe_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 Warp Engine clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c b/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
index 1dc3d2bad42d..5ac035bbe684 100644
--- a/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
+++ b/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
@@ -47,4 +47,6 @@ static struct platform_driver clk_mt8188_adsp_audio26m_drv = {
 	},
 };
 module_platform_driver(clk_mt8188_adsp_audio26m_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 AudioDSP clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
index 41ab4d6896a4..85d573d96081 100644
--- a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
@@ -152,4 +152,6 @@ static struct platform_driver clk_mt8188_apmixed_drv = {
 	},
 };
 module_platform_driver(clk_mt8188_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-cam.c b/drivers/clk/mediatek/clk-mt8188-cam.c
index f78f564aa27e..a6a6581f0461 100644
--- a/drivers/clk/mediatek/clk-mt8188-cam.c
+++ b/drivers/clk/mediatek/clk-mt8188-cam.c
@@ -115,6 +115,7 @@ static struct platform_driver clk_mt8188_cam_drv = {
 		.of_match_table = of_match_clk_mt8188_cam,
 	},
 };
-
 module_platform_driver(clk_mt8188_cam_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 Camera clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-ccu.c b/drivers/clk/mediatek/clk-mt8188-ccu.c
index 428dcc4818c2..9532fc652f01 100644
--- a/drivers/clk/mediatek/clk-mt8188-ccu.c
+++ b/drivers/clk/mediatek/clk-mt8188-ccu.c
@@ -45,6 +45,7 @@ static struct platform_driver clk_mt8188_ccu_drv = {
 		.of_match_table = of_match_clk_mt8188_ccu,
 	},
 };
-
 module_platform_driver(clk_mt8188_ccu_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 Camera Control Unit clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-img.c b/drivers/clk/mediatek/clk-mt8188-img.c
index 76c64a8992a4..00ad6d7884ae 100644
--- a/drivers/clk/mediatek/clk-mt8188-img.c
+++ b/drivers/clk/mediatek/clk-mt8188-img.c
@@ -107,6 +107,7 @@ static struct platform_driver clk_mt8188_imgsys_main_drv = {
 		.of_match_table = of_match_clk_mt8188_imgsys_main,
 	},
 };
-
 module_platform_driver(clk_mt8188_imgsys_main_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c
index 66946784cdba..7b713f4cd662 100644
--- a/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c
@@ -79,4 +79,6 @@ static struct platform_driver clk_mt8188_imp_iic_wrap_drv = {
 };
 
 module_platform_driver(clk_mt8188_imp_iic_wrap_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 I2C Wrapper clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-infra_ao.c b/drivers/clk/mediatek/clk-mt8188-infra_ao.c
index f590178737cb..face3e191464 100644
--- a/drivers/clk/mediatek/clk-mt8188-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8188-infra_ao.c
@@ -220,4 +220,6 @@ static struct platform_driver clk_mt8188_infra_ao_drv = {
 	},
 };
 module_platform_driver(clk_mt8188_infra_ao_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 infracfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-ipe.c b/drivers/clk/mediatek/clk-mt8188-ipe.c
index 54fe6b689b47..fa439af34359 100644
--- a/drivers/clk/mediatek/clk-mt8188-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8188-ipe.c
@@ -49,4 +49,6 @@ static struct platform_driver clk_mt8188_ipe_drv = {
 };
 
 module_platform_driver(clk_mt8188_ipe_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 Image Processing Engine clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-mfg.c b/drivers/clk/mediatek/clk-mt8188-mfg.c
index 1c8ef4c6820f..ec562e7d459d 100644
--- a/drivers/clk/mediatek/clk-mt8188-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8188-mfg.c
@@ -46,4 +46,6 @@ static struct platform_driver clk_mt8188_mfgcfg_drv = {
 };
 
 module_platform_driver(clk_mt8188_mfgcfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 GPU mfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-peri_ao.c b/drivers/clk/mediatek/clk-mt8188-peri_ao.c
index a8214e42b8e5..e4339885b062 100644
--- a/drivers/clk/mediatek/clk-mt8188-peri_ao.c
+++ b/drivers/clk/mediatek/clk-mt8188-peri_ao.c
@@ -56,4 +56,6 @@ static struct platform_driver clk_mt8188_peri_ao_drv = {
 	},
 };
 module_platform_driver(clk_mt8188_peri_ao_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 pericfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
index f7ec599b20af..2ccc8a1c98f9 100644
--- a/drivers/clk/mediatek/clk-mt8188-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
@@ -1354,4 +1354,6 @@ static struct platform_driver clk_mt8188_topck_drv = {
 	},
 };
 module_platform_driver(clk_mt8188_topck_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 top clock generators driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-vdec.c b/drivers/clk/mediatek/clk-mt8188-vdec.c
index db5855d133ac..bf388997c3f8 100644
--- a/drivers/clk/mediatek/clk-mt8188-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8188-vdec.c
@@ -89,4 +89,6 @@ static struct platform_driver clk_mt8188_vdec_drv = {
 };
 
 module_platform_driver(clk_mt8188_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-vdo0.c b/drivers/clk/mediatek/clk-mt8188-vdo0.c
index d252e198678c..935371fbf1d2 100644
--- a/drivers/clk/mediatek/clk-mt8188-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8188-vdo0.c
@@ -104,4 +104,6 @@ static struct platform_driver clk_mt8188_vdo0_drv = {
 	.id_table = clk_mt8188_vdo0_id_table,
 };
 module_platform_driver(clk_mt8188_vdo0_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 Video Output 0 clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-vdo1.c b/drivers/clk/mediatek/clk-mt8188-vdo1.c
index 7b72d54086db..fb24c9026fd8 100644
--- a/drivers/clk/mediatek/clk-mt8188-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8188-vdo1.c
@@ -151,4 +151,6 @@ static struct platform_driver clk_mt8188_vdo1_drv = {
 	.id_table = clk_mt8188_vdo1_id_table,
 };
 module_platform_driver(clk_mt8188_vdo1_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 Video Output 1 clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-venc.c b/drivers/clk/mediatek/clk-mt8188-venc.c
index 5b1713908ed2..4df8d4e05159 100644
--- a/drivers/clk/mediatek/clk-mt8188-venc.c
+++ b/drivers/clk/mediatek/clk-mt8188-venc.c
@@ -51,6 +51,7 @@ static struct platform_driver clk_mt8188_venc1_drv = {
 		.of_match_table = of_match_clk_mt8188_venc1,
 	},
 };
-
 module_platform_driver(clk_mt8188_venc1_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 Video Encoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-vpp0.c b/drivers/clk/mediatek/clk-mt8188-vpp0.c
index e7b02b26fefb..310792108793 100644
--- a/drivers/clk/mediatek/clk-mt8188-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8188-vpp0.c
@@ -111,4 +111,6 @@ static struct platform_driver clk_mt8188_vpp0_drv = {
 	.id_table = clk_mt8188_vpp0_id_table,
 };
 module_platform_driver(clk_mt8188_vpp0_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 Video Processing Pipe 0 clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-vpp1.c b/drivers/clk/mediatek/clk-mt8188-vpp1.c
index e8f0f7eca097..0aa10aaa0292 100644
--- a/drivers/clk/mediatek/clk-mt8188-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8188-vpp1.c
@@ -106,4 +106,6 @@ static struct platform_driver clk_mt8188_vpp1_drv = {
 	.id_table = clk_mt8188_vpp1_id_table,
 };
 module_platform_driver(clk_mt8188_vpp1_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 Video Processing Pipe 1 clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8188-wpe.c b/drivers/clk/mediatek/clk-mt8188-wpe.c
index f394ec049872..fbac440363cc 100644
--- a/drivers/clk/mediatek/clk-mt8188-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8188-wpe.c
@@ -100,6 +100,7 @@ static struct platform_driver clk_mt8188_wpe_drv = {
 		.of_match_table = of_match_clk_mt8188_wpe,
 	},
 };
-
 module_platform_driver(clk_mt8188_wpe_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8188 Warp Engine clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index 5bce67bf701d..b438ebad998d 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -118,4 +118,6 @@ static struct platform_driver clk_mt8192_aud_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_aud_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 audio clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-cam.c b/drivers/clk/mediatek/clk-mt8192-cam.c
index a2c0142273a8..3eed4a7b6d8e 100644
--- a/drivers/clk/mediatek/clk-mt8192-cam.c
+++ b/drivers/clk/mediatek/clk-mt8192-cam.c
@@ -106,4 +106,6 @@ static struct platform_driver clk_mt8192_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_cam_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 Camera clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-img.c b/drivers/clk/mediatek/clk-mt8192-img.c
index ee52b5b748e7..13a435332752 100644
--- a/drivers/clk/mediatek/clk-mt8192-img.c
+++ b/drivers/clk/mediatek/clk-mt8192-img.c
@@ -69,4 +69,6 @@ static struct platform_driver clk_mt8192_img_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_img_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
index a97b6e8d97ac..45585f2edd50 100644
--- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
@@ -118,4 +118,6 @@ static struct platform_driver clk_mt8192_imp_iic_wrap_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_imp_iic_wrap_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 I2C Wrapper clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-ipe.c b/drivers/clk/mediatek/clk-mt8192-ipe.c
index 56ce58ac01ad..da2e2d83cd25 100644
--- a/drivers/clk/mediatek/clk-mt8192-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8192-ipe.c
@@ -56,4 +56,6 @@ static struct platform_driver clk_mt8192_ipe_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_ipe_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 Image Processing Engine clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-mdp.c b/drivers/clk/mediatek/clk-mt8192-mdp.c
index bad2f3d439f5..be674d6c31d7 100644
--- a/drivers/clk/mediatek/clk-mt8192-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8192-mdp.c
@@ -81,4 +81,6 @@ static struct platform_driver clk_mt8192_mdp_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_mdp_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 Multimedia Data Path clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-mfg.c b/drivers/clk/mediatek/clk-mt8192-mfg.c
index 666b401e778c..2da969f4ca6b 100644
--- a/drivers/clk/mediatek/clk-mt8192-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8192-mfg.c
@@ -51,4 +51,6 @@ static struct platform_driver clk_mt8192_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_mfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 GPU mfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index b294184c5183..2b9c1c4524c2 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -100,4 +100,6 @@ static struct platform_driver clk_mt8192_mm_drv = {
 	.id_table = clk_mt8192_mm_id_table,
 };
 module_platform_driver(clk_mt8192_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 MultiMedia clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
index 52d6f0babf12..bc5ce987b76c 100644
--- a/drivers/clk/mediatek/clk-mt8192-msdc.c
+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
@@ -63,4 +63,6 @@ static struct platform_driver clk_mt8192_msdc_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_msdc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 MMC/SD Controller clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
index 72c8a8722b11..e017d30a8832 100644
--- a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
@@ -49,4 +49,6 @@ static struct platform_driver clk_mt8192_scp_adsp_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_scp_adsp_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 SCP AudioDSP clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-vdec.c b/drivers/clk/mediatek/clk-mt8192-vdec.c
index cc514068bcdb..fcb34b1dcdab 100644
--- a/drivers/clk/mediatek/clk-mt8192-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8192-vdec.c
@@ -93,4 +93,6 @@ static struct platform_driver clk_mt8192_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-venc.c b/drivers/clk/mediatek/clk-mt8192-venc.c
index 9f6fff2dd753..98d58a9397cd 100644
--- a/drivers/clk/mediatek/clk-mt8192-venc.c
+++ b/drivers/clk/mediatek/clk-mt8192-venc.c
@@ -52,4 +52,6 @@ static struct platform_driver clk_mt8192_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_venc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 Video Encoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index e395c04632bc..bce2298ebc8d 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1029,4 +1029,6 @@ static struct platform_driver clk_mt8192_drv = {
 	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8192_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8192 main clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 44a4c85a67ef..049ae8123e34 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -230,4 +230,6 @@ static struct platform_driver clk_mt8195_apmixed_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index 79762bc85cd7..b1b562e44cb4 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -110,4 +110,6 @@ static struct platform_driver clk_mt8195_apusys_pll_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_apusys_pll_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 AI Processing Unit PLL clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-cam.c b/drivers/clk/mediatek/clk-mt8195-cam.c
index 24cd6a2092b6..7c8f77817616 100644
--- a/drivers/clk/mediatek/clk-mt8195-cam.c
+++ b/drivers/clk/mediatek/clk-mt8195-cam.c
@@ -142,4 +142,6 @@ static struct platform_driver clk_mt8195_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_cam_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 Camera clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-ccu.c b/drivers/clk/mediatek/clk-mt8195-ccu.c
index 24dab128507a..f78afd7b6ade 100644
--- a/drivers/clk/mediatek/clk-mt8195-ccu.c
+++ b/drivers/clk/mediatek/clk-mt8195-ccu.c
@@ -50,4 +50,6 @@ static struct platform_driver clk_mt8195_ccu_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_ccu_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 Camera Control Unit clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-img.c b/drivers/clk/mediatek/clk-mt8195-img.c
index c7dc3e9d133d..a59c082ef522 100644
--- a/drivers/clk/mediatek/clk-mt8195-img.c
+++ b/drivers/clk/mediatek/clk-mt8195-img.c
@@ -96,4 +96,6 @@ static struct platform_driver clk_mt8195_img_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_img_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 imgsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
index 94912d45509e..54557f1b0681 100644
--- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -66,4 +66,6 @@ static struct platform_driver clk_mt8195_imp_iic_wrap_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_imp_iic_wrap_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 I2C Wrapper clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index dfba6eb61ccf..165fe92c6f61 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -240,4 +240,6 @@ static struct platform_driver clk_mt8195_infra_ao_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_infra_ao_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 infracfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-ipe.c b/drivers/clk/mediatek/clk-mt8195-ipe.c
index 21e76e5ad376..38a23d88370b 100644
--- a/drivers/clk/mediatek/clk-mt8195-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8195-ipe.c
@@ -51,4 +51,6 @@ static struct platform_driver clk_mt8195_ipe_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_ipe_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 Image Processing Engine clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
index 4951574abf2a..e19968eeb346 100644
--- a/drivers/clk/mediatek/clk-mt8195-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
@@ -49,4 +49,6 @@ static struct platform_driver clk_mt8195_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_mfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 GPU mfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-peri_ao.c b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
index 39069aaf6bcd..fc341030f10b 100644
--- a/drivers/clk/mediatek/clk-mt8195-peri_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
@@ -62,4 +62,6 @@ static struct platform_driver clk_mt8195_peri_ao_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_peri_ao_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 pericfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
index 2b94d75be295..1f37bde97d90 100644
--- a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
@@ -47,4 +47,6 @@ static struct platform_driver clk_mt8195_scp_adsp_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_scp_adsp_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 SCP AudioDSP clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 8f713a3341a9..704498c40349 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1361,4 +1361,6 @@ static struct platform_driver clk_mt8195_topck_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_topck_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 top clock generators driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vdec.c b/drivers/clk/mediatek/clk-mt8195-vdec.c
index d266a6d3b603..9e4cc1a82cbe 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdec.c
@@ -104,4 +104,6 @@ static struct platform_driver clk_mt8195_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 34fc318c146c..6e9c3ef19502 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -113,4 +113,6 @@ static struct platform_driver clk_mt8195_vdo0_drv = {
 	.id_table = clk_mt8195_vdo0_id_table,
 };
 module_platform_driver(clk_mt8195_vdo0_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 Video Output 0 clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index e400631e1dbe..422e5729386c 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -140,4 +140,6 @@ static struct platform_driver clk_mt8195_vdo1_drv = {
 	.id_table = clk_mt8195_vdo1_id_table,
 };
 module_platform_driver(clk_mt8195_vdo1_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 Video Output 1 clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-venc.c b/drivers/clk/mediatek/clk-mt8195-venc.c
index 93093fadfd0d..db7a6ce97ed0 100644
--- a/drivers/clk/mediatek/clk-mt8195-venc.c
+++ b/drivers/clk/mediatek/clk-mt8195-venc.c
@@ -69,4 +69,6 @@ static struct platform_driver clk_mt8195_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_venc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 Video Encoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
index 81725fcb3a72..77d9aaf47a25 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
@@ -106,4 +106,6 @@ static struct platform_driver clk_mt8195_vpp0_drv = {
 	.id_table = clk_mt8195_vpp0_id_table,
 };
 module_platform_driver(clk_mt8195_vpp0_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 Video Processing Pipe 0 clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
index 867fde4e575b..18ca8f1d9538 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
@@ -104,4 +104,6 @@ static struct platform_driver clk_mt8195_vpp1_drv = {
 	.id_table = clk_mt8195_vpp1_id_table,
 };
 module_platform_driver(clk_mt8195_vpp1_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 Video Processing Pipe 1 clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-wpe.c b/drivers/clk/mediatek/clk-mt8195-wpe.c
index 7324738179a4..9c45a2fed0ce 100644
--- a/drivers/clk/mediatek/clk-mt8195-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8195-wpe.c
@@ -143,4 +143,6 @@ static struct platform_driver clk_mt8195_wpe_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_wpe_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8195 Warp Engine clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-apmixedsys.c b/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
index 9b0bc5daeac0..f41b991a0178 100644
--- a/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
@@ -163,4 +163,6 @@ static struct platform_driver clk_mt8365_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt8365_apmixed_drv)
+
+MODULE_DESCRIPTION("MediaTek MT8365 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-apu.c b/drivers/clk/mediatek/clk-mt8365-apu.c
index 4f10ce1531d2..934060e6d9e9 100644
--- a/drivers/clk/mediatek/clk-mt8365-apu.c
+++ b/drivers/clk/mediatek/clk-mt8365-apu.c
@@ -53,4 +53,6 @@ static struct platform_driver clk_mt8365_apu_drv = {
 	},
 };
 module_platform_driver(clk_mt8365_apu_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8365 AI Processing Unit clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-cam.c b/drivers/clk/mediatek/clk-mt8365-cam.c
index fe428a4f1d37..c8fe5f5bb06c 100644
--- a/drivers/clk/mediatek/clk-mt8365-cam.c
+++ b/drivers/clk/mediatek/clk-mt8365-cam.c
@@ -55,4 +55,6 @@ static struct platform_driver clk_mt8365_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt8365_cam_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8365 Camera clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-mfg.c b/drivers/clk/mediatek/clk-mt8365-mfg.c
index 4a590284f7e2..5355f725363d 100644
--- a/drivers/clk/mediatek/clk-mt8365-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8365-mfg.c
@@ -61,4 +61,6 @@ static struct platform_driver clk_mt8365_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8365_mfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8365 GPU mfg clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 3f62ec750733..8201949bfdae 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -92,4 +92,6 @@ static struct platform_driver clk_mt8365_mm_drv = {
 	.id_table = clk_mt8365_mm_id_table,
 };
 module_platform_driver(clk_mt8365_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8365 MultiMedia clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-vdec.c b/drivers/clk/mediatek/clk-mt8365-vdec.c
index 233924837c3b..1be0b3faa2c3 100644
--- a/drivers/clk/mediatek/clk-mt8365-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8365-vdec.c
@@ -61,4 +61,6 @@ static struct platform_driver clk_mt8365_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8365_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8365 Video Decoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-venc.c b/drivers/clk/mediatek/clk-mt8365-venc.c
index cc063f18e56b..4228ddec5657 100644
--- a/drivers/clk/mediatek/clk-mt8365-venc.c
+++ b/drivers/clk/mediatek/clk-mt8365-venc.c
@@ -50,4 +50,6 @@ static struct platform_driver clk_mt8365_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt8365_venc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8365 Video Encoders clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index ac45e4cc9bcd..485b525b8acd 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -812,4 +812,6 @@ static struct platform_driver clk_mt8365_drv = {
 	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8365_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8365 main clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.45.1


