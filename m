Return-Path: <linux-kernel+bounces-269790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4709436EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E951F22370
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C2615FA6D;
	Wed, 31 Jul 2024 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZfbnbOL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3701607AC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456875; cv=none; b=bJNQLruAw4L0BcDGt7SunJhNPxW12jQXHh4BN6iKbriamREiDoAXV0S7Xf5X2wYlfe2jnhVXTGL2dWTWLddZlPCDDzZr64Rb3L4NDxhe5s5Z11E55uqTK3xBaUO6z0XdBOfpGWmN13NjVEaqrRaIwelBjty4atG8mjy2+FFkcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456875; c=relaxed/simple;
	bh=k+eFhFAkd2vbO659Tkl+hTXfqcSphbMfOWrLbcB5eNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDGA0nWpGymLo+czK7xRd5OWfaMbHQAf4YWMM+yDa7nEtNuoopdLacRmZXDOxgP3+sAbVJJ86YWwERPREfsRV/UPJIgdFdDc5D/PwWyH/iE959K40O5YFjkIbR1cxNXGamzWi6rGcKo5E47QO3ysO+jRAQDm71kHeMun9xnVV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZfbnbOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D64AC116B1;
	Wed, 31 Jul 2024 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456874;
	bh=k+eFhFAkd2vbO659Tkl+hTXfqcSphbMfOWrLbcB5eNc=;
	h=From:To:Cc:Subject:Date:From;
	b=MZfbnbOLcSYQGS24wxSinYk6YtSp0qohSW2c5/24M5tddywbO9PAtzykrouOjTy4L
	 KPQlvQIXqEPfjLgFJs4f9pai9XBTo6qJhoWhGyt10ACc+ne+hLMHNLqITK9AjXEHFK
	 mXGDl+9zpsVytZg72GXAWXAvGzsYMTWrmDXb7d672b367bk4tOk6Fs+z2or9J0HQ1h
	 x5caTkdc2jxd0NhTEFqU5AHLvY2zTnc6t/bDjiEQrO1TdNF4MDHiSX9eKfpc6aNy0m
	 0dvdWV/uukIpgYG9KtWz/ac58lruxw2JsryNEcP/4hfjCbysG5lM+dLAdziuvKWG0S
	 f8ixPWOmooAwA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm: mediatek: Drop unnecessary check for property presence
Date: Wed, 31 Jul 2024 14:13:56 -0600
Message-ID: <20240731201407.1838385-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_property_read_u32() returns -EINVAL if a property is not present, so
the preceeding check for presence with of_find_property() can be
dropped. Really, what the errno is shouldn't matter. Either the property
can be read and used or it can't and is ignored.

This is part of a larger effort to remove callers of of_find_property()
and similar functions. of_find_property() leaks the DT struct property
and data pointers which is a problem for dynamically allocated nodes
which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 634bbba5d43f..07243f372260 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -341,14 +341,11 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 		dev_dbg(dev, "get mediatek,gce-client-reg fail!\n");
 #endif
 
-	if (of_find_property(dev->of_node, "mediatek,rdma-fifo-size", &ret)) {
-		ret = of_property_read_u32(dev->of_node,
-					   "mediatek,rdma-fifo-size",
-					   &priv->fifo_size);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to get rdma fifo size\n");
-	}
+	ret = of_property_read_u32(dev->of_node,
+				   "mediatek,rdma-fifo-size",
+				   &priv->fifo_size);
+	if (ret && (ret != -EINVAL))
+		return dev_err_probe(dev, ret, "Failed to get rdma fifo size\n");
 
 	/* Disable and clear pending interrupts */
 	writel(0x0, priv->regs + DISP_REG_RDMA_INT_ENABLE);
-- 
2.43.0


