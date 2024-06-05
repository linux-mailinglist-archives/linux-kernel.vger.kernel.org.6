Return-Path: <linux-kernel+bounces-202931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CFF8FD325
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1450B286870
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820A188CDE;
	Wed,  5 Jun 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UQRXnT0y"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752AD188CD1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606248; cv=none; b=uOQyKQBqR5sFkTOBMJXrqzUaOfLDE0y8S503YsT0pctvy/3ZJjXlcjZamAsmIxaJSZQpl0rquGklyF72ZvpFV9AzFSchPB1D6iQRsnOewWDYHJElgB+qlMhigXy0lkZMn2zdu5kP64xHOZN5ZDEVUOi/H9n+xjf4uloMBCGksoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606248; c=relaxed/simple;
	bh=rn22rgV/+4N/k6+hZ8EN8fGz0X09E6tz/BF8d70bBkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jSh/cdAp5rs7UBu5HNWFc7Oa1AMzvCORlJ512TZZvtFlfXlq+wGTayUXAkvwnEu91XyXt7oUJQV/N4fD6veMTpM2tgJm4f3x6Ev6VWx7Nw4pKztLpMlD9rJo8McW31CjdfalNwNf1Z9j5nPFl9XD662Akffn/fPUJdqzp/Zrh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UQRXnT0y; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717606245;
	bh=rn22rgV/+4N/k6+hZ8EN8fGz0X09E6tz/BF8d70bBkI=;
	h=From:Date:Subject:To:Cc:From;
	b=UQRXnT0y8rT7OOFPfI77fSfMEOgn+D0WBLZRM9L3723QaUghV8BZH690prWHfrG5O
	 8fhiTaV82s+4J4eHM/o0nrYI1UEgaB0BlSu+m2mzQH5siGVSjxdUHGtUq/lQMwDBz3
	 IhoufMtuktQns06jD4yAzyTHaPZ3BfjFn2DNrTxXlgAkTzhT8K0F/YRsm4AgrOPoHn
	 S2dUtJp/TQEDiplx1TOQXwH0KNgY8HrDTDk1UBFq326TrpahA3gCeWf39K+AM+9mX7
	 7gAkEqMpilaRBluurczL1IO77EG+v0EdGzaqwKImCbmGATOdeyF3gScOcvGKrQ4Yxd
	 Z/GwoG7d1uJMQ==
Received: from [192.168.1.250] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6C8E1378219B;
	Wed,  5 Jun 2024 16:50:42 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 05 Jun 2024 12:50:25 -0400
Subject: [PATCH] drm/mediatek: Don't print error if EDEFER_PROBE returned
 on component_add
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240605-mtk-disp-rdma-dev-err-probe-v1-1-91259e1d3a93@collabora.com>
X-B4-Tracking: v=1; b=H4sIAFCXYGYC/x3MwQpAQBAG4FfRnE3tCsWryGHZH5OwzUpK3t3m+
 F2+hyJUEKnNHlJcEuXYE2ye0bi4fQaLT6bCFKWpTcXbubKXGFj95tjjYqhy0GMAY2pGa5x1jQW
 lISgmuf+969/3A7NVTa5tAAAA
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Use dev_err_probe() in the component_add() error path to prevent
printing an error when the probe is deferred. This was observed on
mt8195 with the disp-rdma driver:

  mediatek-disp-rdma 1c002000.rdma: Failed to add component: -517

But the same pattern is used across many other drivers, so update them
all.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c         | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c       | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_color.c       | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c       | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_merge.c       | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c         | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c        | 2 +-
 drivers/gpu/drm/mediatek/mtk_ethdr.c            | 2 +-
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c         | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index 3ce8f32b06d5..892dc40458fb 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -197,7 +197,7 @@ static int mtk_disp_aal_probe(struct platform_device *pdev)
 
 	ret = component_add(dev, &mtk_disp_aal_component_ops);
 	if (ret)
-		dev_err(dev, "Failed to add component: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to add component\n");
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index df35e90dd25f..fc273ebdbcd2 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -182,7 +182,7 @@ static int mtk_disp_ccorr_probe(struct platform_device *pdev)
 
 	ret = component_add(dev, &mtk_disp_ccorr_component_ops);
 	if (ret)
-		dev_err(dev, "Failed to add component: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to add component\n");
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index 7f0085be5671..c2c374e9a8e3 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -126,7 +126,7 @@ static int mtk_disp_color_probe(struct platform_device *pdev)
 
 	ret = component_add(dev, &mtk_disp_color_component_ops);
 	if (ret)
-		dev_err(dev, "Failed to add component: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to add component\n");
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index ca8d1f3aca03..ec926b32c34d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -287,7 +287,7 @@ static int mtk_disp_gamma_probe(struct platform_device *pdev)
 
 	ret = component_add(dev, &mtk_disp_gamma_component_ops);
 	if (ret)
-		dev_err(dev, "Failed to add component: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to add component\n");
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
index 77c057e0e671..2f6a605542d5 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
@@ -354,7 +354,7 @@ static int mtk_disp_merge_probe(struct platform_device *pdev)
 
 	ret = component_add(dev, &mtk_disp_merge_component_ops);
 	if (ret != 0)
-		dev_err(dev, "Failed to add component: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to add component\n");
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index b552a02d7eae..ffdc9ca5b6f5 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -555,7 +555,7 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
 	ret = component_add(dev, &mtk_disp_ovl_component_ops);
 	if (ret) {
 		pm_runtime_disable(dev);
-		dev_err(dev, "Failed to add component: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to add component\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 02dd7dcdfedb..c9d6f2b39e92 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -612,7 +612,7 @@ static int mtk_disp_ovl_adaptor_probe(struct platform_device *pdev)
 	ret = component_add(dev, &mtk_disp_ovl_adaptor_comp_ops);
 	if (ret != 0) {
 		pm_runtime_disable(dev);
-		dev_err(dev, "Failed to add component: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to add component\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 7b1a6e631200..ac83e89e39d2 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -373,7 +373,7 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 	ret = component_add(dev, &mtk_disp_rdma_component_ops);
 	if (ret) {
 		pm_runtime_disable(dev);
-		dev_err(dev, "Failed to add component: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to add component\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 156c6ff547e8..25b305bff97e 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -341,7 +341,7 @@ static int mtk_ethdr_probe(struct platform_device *pdev)
 
 	ret = component_add(dev, &mtk_ethdr_component_ops);
 	if (ret)
-		dev_notice(dev, "Failed to add component: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to add component\n");
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
index 925cbb7471ec..3a0944bee134 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
@@ -324,7 +324,7 @@ static int mtk_mdp_rdma_probe(struct platform_device *pdev)
 	ret = component_add(dev, &mtk_mdp_rdma_component_ops);
 	if (ret != 0) {
 		pm_runtime_disable(dev);
-		dev_err(dev, "Failed to add component: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to add component\n");
 	}
 	return ret;
 }

---
base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
change-id: 20240605-mtk-disp-rdma-dev-err-probe-ef9c10a1a91e

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


