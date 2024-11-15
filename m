Return-Path: <linux-kernel+bounces-410634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF919CDE50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BD71F2338A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875DA1BC064;
	Fri, 15 Nov 2024 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PAIFC22J"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B81BBBCC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674037; cv=none; b=hYbTYGLu2Sh1/uWHIHkICnZa4XALdn/dJXUaH7C/VL/Rj+iq+XjEMvHXAG83Vqp3zhb5Sqk5qitPWZ3xPyKsCnH56gOd3KqzDabcOL1S/F7Xac6B+kWt57mO6qvdtpXM0ND/vHQwXm9CCU7JxKD8RPHRVLcoJ3tDYEYMryqtbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674037; c=relaxed/simple;
	bh=dOSC6eUGC/in0o9pWwfngkUERvWaWcLQ205GavFwqhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUSaXHsFmMEfu3L5LbXs7uOIz0VoWi77ojbIfOs0vzSNstRAWsd8atXz6sH8GD35FXMSTLRegsUPwWWRGrJ7hS8GYsKUWpvQNCYX9+ZsSgxhb0WRfigKgbbFQwFyG6+kdh7brZYdRyFtlZygZE0dXFS/c0sow8D75auPZg8etmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PAIFC22J; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731674032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GH0nS2nq3ekeLQm+XUvi36Oo7y7L7oC9zjgTOfOD4BI=;
	b=PAIFC22JH4MhlCMgShy7Zb4gzL9CCZ5iyW6Pf4+Jq+VOU62gyDJJrL8o/E9Sed0yiZCG4/
	2jGTHatUPYtsueFT5r28dJNk0AAVEVjn7imsYAsvOIqhpLlydG0HwuO4acng9KOJLiuY1X
	7F9ip2JLsGY3G7pzH9sma9AG5jihgSY=
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
Subject: [PATCH v3 3/3] drm/etnaviv: Improve VA, PA, SIZE alignment checking
Date: Fri, 15 Nov 2024 20:32:46 +0800
Message-Id: <20241115123246.111346-4-sui.jingfeng@linux.dev>
In-Reply-To: <20241115123246.111346-1-sui.jingfeng@linux.dev>
References: <20241115123246.111346-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Alignment checking is only needed to be done in the upper caller function.
If those address and sizes are able to pass the check, it will certainly
pass the same test in the etnaviv_context_unmap() function. We don't need
examine it more than once.

Remove redundant alignment tests, move the those useless to upper caller
function.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index ff90bf85c156..df5192083b20 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -19,12 +19,6 @@ static void etnaviv_context_unmap(struct etnaviv_iommu_context *context,
 	size_t unmapped_page, unmapped = 0;
 	size_t pgsize = SZ_4K;
 
-	if (!IS_ALIGNED(iova | size, pgsize)) {
-		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%zx\n",
-		       iova, size, pgsize);
-		return;
-	}
-
 	while (unmapped < size) {
 		unmapped_page = context->global->ops->unmap(context, iova,
 							    pgsize);
@@ -45,12 +39,6 @@ static int etnaviv_context_map(struct etnaviv_iommu_context *context,
 	size_t orig_size = size;
 	int ret = 0;
 
-	if (!IS_ALIGNED(iova | paddr | size, pgsize)) {
-		pr_err("unaligned: iova 0x%lx pa %pa size 0x%zx min_pagesz 0x%zx\n",
-		       iova, &paddr, size, pgsize);
-		return -EINVAL;
-	}
-
 	while (size) {
 		ret = context->global->ops->map(context, iova, paddr, pgsize,
 						prot);
@@ -88,6 +76,14 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context,
 
 		VERB("map[%d]: %08x %pap(%x)", i, da, &pa, bytes);
 
+		if (!IS_ALIGNED(iova | pa | bytes, SZ_4K)) {
+			dev_err(context->global->dev,
+				"unaligned: iova 0x%x pa %pa size 0x%x\n",
+				iova, &pa, bytes);
+			ret = -EINVAL;
+			goto fail;
+		}
+
 		ret = etnaviv_context_map(context, da, pa, bytes, prot);
 		if (ret)
 			goto fail;
-- 
2.34.1


