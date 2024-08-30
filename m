Return-Path: <linux-kernel+bounces-308164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BDC965816
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4A81C227BE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA181531F9;
	Fri, 30 Aug 2024 07:07:46 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE51531D0
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001665; cv=none; b=kSOT27wQlWY0K8NU45XUbhWH9DQw06iGL2eONURQPrA1DOZeLWrdSYyP3xhjYJEqwQdSFfdY6wLH6n2Qmkxz7RHbeB2h/wQ8lvz96k0D6EzPXO/gr7ylxeuT3ISdgBC5fklhL6/JuqRGNvkahoe29DSeIa5Inzjt9k6P8nVvccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001665; c=relaxed/simple;
	bh=C2zmj2WNL0OOCw1Nc46jjn7cSB11OmzpLJpR0jPsFvo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uFJt9f+ruF505JVYNAwUrXnbFtMhJvHFgizHGSCEsuZXpf6uCCR9f4XbrfmuWws3Uv1AP6zF5ZZ0I3Ma2GUrNdGhzLVogH8GAxmdOnBQ6Tpp2Nwq7rNg/qFryblmRIGfbeS/MprJcOIeD7tOxwjBc8PtHcFREiCKhIhyzK4T3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ww8HF0LktzQrBy;
	Fri, 30 Aug 2024 15:02:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id D86A8140202;
	Fri, 30 Aug 2024 15:07:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 15:07:40 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jason-jh.lin@mediatek.com>,
	<ck.hu@mediatek.com>, <amergnat@baylibre.com>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] drm/mediatek: Fix missing of_node_put() for mtk_drm_get_all_drm_priv()
Date: Fri, 30 Aug 2024 15:15:42 +0800
Message-ID: <20240830071542.3534696-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

In mtk_drm_get_all_drm_priv(), break in for_each_child_of_node() should
call of_node_put() to avoid child node resource leak, fix it.

Fixes: d761b9450e31 ("drm/mediatek: Add cnt checking for coverity issue")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Use of_node_put() to fix it.
- Update the commit message.
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 77b50c56c124..1b1d9930dcde 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -405,8 +405,10 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 		if (temp_drm_priv->mtk_drm_bound)
 			cnt++;
 
-		if (cnt == MAX_CRTC)
+		if (cnt == MAX_CRTC) {
+			of_node_put(node);
 			break;
+		}
 	}
 
 	if (drm_priv->data->mmsys_dev_num == cnt) {
-- 
2.34.1


