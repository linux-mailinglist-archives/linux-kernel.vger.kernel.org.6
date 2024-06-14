Return-Path: <linux-kernel+bounces-214311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2179082A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F48E1C214A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5493146A8E;
	Fri, 14 Jun 2024 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E23AktRk"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CCD3D64
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336987; cv=none; b=jkksWKblwsun3EJyBls6Wj/tMDIpGATDYrW/F8G2ujPCknhELytjTL39w/dfyCOiu7/9FiF3/d3S3jFpIZyTiJsS/mEwQKijm5XLH4AN2FmMWEXMhroD95OLQB6iZ6ys7hZ2KwjWb27jPR70WxXvuAftFeimSi03rgvQFFMrLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336987; c=relaxed/simple;
	bh=uNgzFzKSxOCYvkUdq4IxHA0B40AXGdIDP1FqUP8p1ok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qo7Y83zqklEzeRwSQP8ME2zwk5mrsp3ZjVUf4iKD1VXG1QYqfCZcjDXfy0wuMl9nUvC7GCjl/5LlOP0a8gzJ2wG1ixcXMVW584SAn0x6MOjBSzQDIyRR9lmn3EDkt4aFMkfQ90QRR8mkDhyq+uVGYuJZdrRsUCQF80xmGdBd68U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E23AktRk; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 208504802a0111efa54bbfbb386b949c-20240614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3Wg+cfzFV869KNlYc3FkYfypiH8tKZlabSpmjEIudDw=;
	b=E23AktRk6fWgaY3HW3Hw4BIid+eVEJwBntVUYTfPuSsWMNx4GVWH57fKAGeZ4IN0zBVfPs1LGcg1KECTTy596JL/cCmzIdIwT9MemgpM/1FWSE0XVw7r2bavqMWO/L618c8PRhYThBPOmP1erp6qJpzMxDs8ATHQhQ/QIUH0KLM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:9a5c05b8-1f1c-43a7-80b0-71e5d93ea029,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:03cb1285-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 208504802a0111efa54bbfbb386b949c-20240614
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1279164298; Fri, 14 Jun 2024 11:49:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jun 2024 11:49:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jun 2024 11:49:38 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Nancy
 . Lin" <nancy.lin@mediatek.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH] drm/mediatek: Remove less-than-zero comparison of an unsigned value
Date: Fri, 14 Jun 2024 11:49:37 +0800
Message-ID: <20240614034937.23978-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Fix a Coverity error that less-than-zero comparison of an unsigned value
is never true.

Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT8195")
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index 17b036411292..a66e46d0b45e 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -593,7 +593,7 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	int ret;
 #endif
 
-	if (comp_id < 0 || comp_id >= DDP_COMPONENT_DRM_ID_MAX)
+	if (comp_id >= DDP_COMPONENT_DRM_ID_MAX)
 		return -EINVAL;
 
 	type = mtk_ddp_matches[comp_id].type;
-- 
2.18.0


