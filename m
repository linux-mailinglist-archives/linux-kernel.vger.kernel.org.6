Return-Path: <linux-kernel+bounces-390866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A479B7F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6C81F235A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3BA1A08AB;
	Thu, 31 Oct 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hHAHLUDd"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1819B59C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390192; cv=none; b=T9g2YxZVgpMruKDOqU4f32DMn7OT/pegtMHXTiOxcvKkiZkow7eGkhI0LloAX28qtjZW/PFDSnqI8WVvtTedLizzZL7nqKNOVMqqHu3i/HbhHmXfF5+7BBJAav8gnfTBOqWd8WiSUQuC09ZMAaVEXM9MOFs1x/jc/evfgvf4i30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390192; c=relaxed/simple;
	bh=BiDxiDH0PQD5cCk6exGvlq0C2VOXs+ukciiEL3KVru0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XhAf/UAbwbUAOBwYwNGAvXdion7+3nG3czcpIC61OdbYeuZcDfltN+i9TgmTpn7G4KYcRWSzKUul5woUd6paUZwgkmc/lwk7DT0f+4xal2re/QzxIQneuWvTwKlt3irdqRDMaCiqngMZIOv46C0RBp5fklO6ybw0KtYL0uaHRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hHAHLUDd; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730390188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ce50T52Mg3KtaLG7W7v0gI2ull5wlkcCd0a72TjlbNQ=;
	b=hHAHLUDdljPxC8yGeBEnHSwWzpimYR7nrNXjt9QnjOQdisshMN6PHiaZdEc8BzBxMrQeXG
	mJluXxeCMeCLz6xWYN5L5zNxqyNSwx0ZkT+m22af832CSJfkpqxEgy5XcsRM0OwYwgV3Td
	izWXL+6XXVhi83SGbdM77B85r1VoLBY=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [etnaviv-next v3] drm/etnaviv: Print an error message if inserting IOVA range fails
Date: Thu, 31 Oct 2024 23:56:16 +0800
Message-Id: <20241031155616.2451084-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Print an error message to help debug when such an error happens,
since there meight have other CPU page size & GPU page size combinations.

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
v3:
 - Pick up tags and resend.
 - Slightly improve commit message.
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 7e065b3723cf..47b6242e24a0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -298,8 +298,12 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 		ret = etnaviv_iommu_insert_exact(context, node, etnaviv_obj->size, va);
 	else
 		ret = etnaviv_iommu_find_iova(context, node, etnaviv_obj->size);
-	if (ret < 0)
+	if (ret) {
+		dev_err_ratelimited(context->global->dev,
+				    "Insert iova failed: 0x%llx(0x%x)\n",
+				    va, etnaviv_obj->size);
 		goto unlock;
+	}
 
 	mapping->iova = node->start;
 	ret = etnaviv_iommu_map(context, node->start, etnaviv_obj->size, sgt,
-- 
2.34.1


