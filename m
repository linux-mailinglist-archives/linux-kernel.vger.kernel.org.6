Return-Path: <linux-kernel+bounces-395479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B732B9BBE81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8A12811A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8550A18D63C;
	Mon,  4 Nov 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tsNzNLon"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89141CBE82
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750655; cv=none; b=gdpzmF0fNS+eruZF28f8h1xFQIbPIDzd+G9rBeyeLk50xYFTLsKYnjJvlo7VDGnmd/XMQw/AmsIM+y1bzNVhCUmx6W81YJH1+Pl6LMuNDT1uTaUKHoX89Um5qrunO0ASdj/Rqj5RcIlVV3nXuefti3ehwtqlS36hfQRn9dT6CUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750655; c=relaxed/simple;
	bh=yu7yOiBkigc0Hizwa53zUq8IBTQvJdne6G9w2vObWbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZDH7mi55F2gr3UJob7HXIoVnyoA+hn4PjaC7zjh11RxQeLGVSuczTbTp13BRbHG3oZ9+2QJBlJ5v0gUCzDaX3eaHfEmg028GTeBUjXExvIaWymi9ci8Ck2U9rdCQzQV6ytTUXlFcxxO/8OMT2WbA8Wg8kjwN/+sjUw3guAG4mpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tsNzNLon; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730750649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+Cctltnj8jUTfRPzXWg7X11ZIlWeCkuZhPa7klvD+M=;
	b=tsNzNLonLnVwGYjHKHR5pndwa0CTcCHa1fkmIv1OZoDAGgf2SOAzTYcs1AW9APE7KXii7X
	rywSqhbS0+AEi2917D4rrYRiSnWpUHUXJlU5aNJHsE3DnmEpVI9sxJ8x3dE01Gxe7gCX2b
	ebJRVJE19zFB/IS3KSC1VwpJUZ+xfmQ=
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
Subject: [etnaviv-next v2 1/3] drm/etnaviv: Drop offset in page manipulation
Date: Tue,  5 Nov 2024 04:03:52 +0800
Message-Id: <20241104200354.656525-2-sui.jingfeng@linux.dev>
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

The 'offset' data member of the 'struct scatterlist' denotes the offset
into a SG entry in bytes. But under drm subsystem, there has nearly NO
drivers that actually tough the 'offset' data member of SG anymore.
Especially for drivers that could contact with drm/etnaviv. This means
that all DMA addresses that sg_dma_address() gives us will be PAGE_SIZE
aligned, in other words, sg->offset will  always equal to 0.

Drop those compulations about the offset of SG entries can save some
extra overhead.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 8f33f111f9e8..ddb536d84c58 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -82,8 +82,8 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context,
 		return -EINVAL;
 
 	for_each_sgtable_dma_sg(sgt, sg, i) {
-		phys_addr_t pa = sg_dma_address(sg) - sg->offset;
-		unsigned int da_len = sg_dma_len(sg) + sg->offset;
+		phys_addr_t pa = sg_dma_address(sg);
+		unsigned int da_len = sg_dma_len(sg);
 		unsigned int bytes = min_t(unsigned int, da_len, va_len);
 
 		VERB("map[%d]: %08x %pap(%x)", i, iova, &pa, bytes);
-- 
2.34.1


