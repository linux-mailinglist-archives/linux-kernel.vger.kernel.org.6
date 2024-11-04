Return-Path: <linux-kernel+bounces-395480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD69BBE82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09E21F22562
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5035B1D4333;
	Mon,  4 Nov 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jnbYpCw5"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE71D3628
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750657; cv=none; b=RQYyORY1tODt0Wrw8q9QvrPL3NFdQvuBD4i3F1FCPQ2iR/kAhvRHQtWQreeTsjjwxdQH72VyCzklTSTrcks4p3BbDzDAU/sSFjnzGKD40dYzz8S5pX4M0+E8KEU7JaiPY6yG515Oc45NI5fPVP9j7HgGXyGZUhqNsY0L65RHyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750657; c=relaxed/simple;
	bh=rV6m8i3NZvtr8yHXWxiKJJqbDjQUjVJlRD5EMeUBUeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FDu0X1JFHtg0QSjlhh/5UojotrqMfL9ygLJcpSqoqMpbg3QFA6wIMwTC7qAb8p53enGLxZm/1qyR9JC3ytThkAFeUJlpTC7dTEeGFDQif6RSrROxPetNXDEZ/iGc03T4L9bbMdZShy8cHTS7bldq3srlxTs/SuTe9VUnHyoKlOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jnbYpCw5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730750653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4hWc+SA0LxPrteqt2eM979LtFoCBRYmizsNb23n6NU=;
	b=jnbYpCw5slmXV2Kk/8PUqpn99ukY281IhV6AHXiVEbq5bf0tho+OMsHp7YxK8h7VvnAVnA
	ETa1b1ev0UZeeUTKgr1gqLVE8mSYc0osesM441O75Tpyu3lsiAme2BFudMuq+iU7gxcgij
	oq9oKyI5y20t9ycx+5s0brbe7A/bYkw=
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
Subject: [etnaviv-next v2 2/3] drm/etnaviv: Fix the debug log of the etnaviv_iommu_map()
Date: Tue,  5 Nov 2024 04:03:53 +0800
Message-Id: <20241104200354.656525-3-sui.jingfeng@linux.dev>
In-Reply-To: <20241104200354.656525-1-sui.jingfeng@linux.dev>
References: <20241104200354.656525-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The value of the 'iova' variable is the base GPU virtual address that is
going to be mapped, its value won't get updated when etnaviv_context_map()
is running under the "for_each_sgtable_dma_sg(sgt, sg, i) {}" loop.

Replace it with the 'da' variable, reflect the actual status that GPUVA
is being mapped.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index ddb536d84c58..05021848126e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -86,7 +86,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context,
 		unsigned int da_len = sg_dma_len(sg);
 		unsigned int bytes = min_t(unsigned int, da_len, va_len);
 
-		VERB("map[%d]: %08x %pap(%x)", i, iova, &pa, bytes);
+		VERB("map[%d]: %08x %pap(%x)", i, da, &pa, bytes);
 
 		ret = etnaviv_context_map(context, da, pa, bytes, prot);
 		if (ret)
-- 
2.34.1


