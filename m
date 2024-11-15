Return-Path: <linux-kernel+bounces-410632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B759CDE4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B131F23070
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78291BCA0C;
	Fri, 15 Nov 2024 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TvhwZEUd"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452E1B0F24
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674028; cv=none; b=Zk9a9YNKQM+lLX0Iz7U2Jvm0LeIWDke8zgQDWmjkYqVCOk5xqAxm+0aT5YgxmVCgaCANkDzNu30K8AZgav+Bfx8Aw2+S6gQYdUO8aYJAHF0ixXrE7+vUyKqZOwpYmzle8HoWucHo9TjdtQERQDDsM37JCkZbhazIOltg8CIEBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674028; c=relaxed/simple;
	bh=p1FBURnBl3WmoZ6QfnFAvJt2S5vJOEikeqPxrbq9oU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFCrk5XDEsSWXtuD+ElnVaY36jPFTmVjBEmpMRf4eOtLmFdR+y22LfnViaNaFL3v1RCvCGde2Sgg5j5Pqy0LXWiLhpfZMYkI8kaEOozZ5EYo2pT4FcM6ZeIUjPyA5TeGDWb7Wa2AFj3M7iOrUVFErmGMz7waO5Mz9400YN1Liwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TvhwZEUd; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731674023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFm/QsqGtNpOQ5SfKjk7QqN4kTAcwma8p9hnqSEIdIw=;
	b=TvhwZEUdErRZSOAllia1psVl6aQXD4WEscpoQXA5ebV9ZcfBj5NHRKWvdRc428Wc4268bW
	9OB95aE1FjavmQYR3MdwO/a4JiQswaPBDKdZJte4MA3tdBXJD475cvi3oQRNLz90qhDjPD
	TOq2mPpmMQOBaWL45IFaIBe2qZqMOdQ=
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
Subject: [PATCH v3 1/3] drm/etnaviv: Drop the offset in page manipulation
Date: Fri, 15 Nov 2024 20:32:44 +0800
Message-Id: <20241115123246.111346-2-sui.jingfeng@linux.dev>
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

The etnaviv driver, both kernel space and user space, assumes that GPU page
size is 4KiB. Its IOMMU map/unmap 4KiB physical address range once a time.
If 'sg->offset != 0' is true, then the current implementation will map the
IOVA to a wrong area, which may lead to coherency problem. Picture 0 and 1
give the illustration, see below.

  PA start drifted
  |
  |<--- 'sg_dma_address(sg) - sg->offset'
  |               .------ sg_dma_address(sg)
  |              |  .---- sg_dma_len(sg)
  |<-sg->offset->|  |
  V              |<-->|    Another one cpu page
  +----+----+----+----+   +----+----+----+----+
  |xxxx|         ||||||   |||||||||||||||||||||
  +----+----+----+----+   +----+----+----+----+
  ^                   ^   ^                   ^
  |<---   da_len  --->|   |                   |
  |                   |   |                   |
  |    .--------------'   |                   |
  |    | .----------------'                   |
  |    | |                   .----------------'
  |    | |                   |
  |    | +----+----+----+----+
  |    | |||||||||||||||||||||
  |    | +----+----+----+----+
  |    |
  |    '--------------.  da_len = sg_dma_len(sg) + sg->offset, using
  |                   |  'sg_dma_len(sg) + sg->offset' will lead to GPUVA
  +----+ ~~~~~~~~~~~~~+  collision, but min_t(unsigned int, da_len, va_len)
  |xxxx|              |  will clamp it to correct size. But the IOVA will
  +----+ ~~~~~~~~~~~~~+  be redirect to wrong area.
  ^
  |             Picture 0: Possibly wrong implementation.
GPUVA (IOVA)

--------------------------------------------------------------------------

                 .------- sg_dma_address(sg)
                 |  .---- sg_dma_len(sg)
  |<-sg->offset->|  |
  |              |<-->|    another one cpu page
  +----+----+----+----+   +----+----+----+----+
  |              ||||||   |||||||||||||||||||||
  +----+----+----+----+   +----+----+----+----+
                 ^    ^   ^                   ^
                 |    |   |                   |
  .--------------'    |   |                   |
  |                   |   |                   |
  |    .--------------'   |                   |
  |    | .----------------'                   |
  |    | |                   .----------------'
  |    | |                   |
  +----+ +----+----+----+----+
  |||||| ||||||||||||||||||||| The first one is SZ_4K, the second is SZ_16K
  +----+ +----+----+----+----+
  ^
  |           Picture 1: Perfectly correct implementation.
GPUVA (IOVA)

If sg->offset != 0 is true, IOVA will be mapped to wrong physical address.
Either because there doesn't contain the data or there contains wrong data.
Strictly speaking, the memory area that before sg_dma_address(sg) doesn't
belong to us, and it's likely that the area is being used by other process.

Because we don't want to introduce confusions about which part is visible
to the GPU, we assumes that the size of GPUVA is always 4KiB aligned. This
is very relaxed requirement, since we already made the decision that GPU
page size is 4KiB (as a canonical decision). And softpin feature is landed,
Mesa's util_vma_heap_alloc() will certainly report correct length of GPUVA
to kernel with desired alignment ensured.

With above statements agreed, drop the "offset in page" manipulation will
return us a correct implementation at any case.

Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 7e065b3723cf..c786df840a18 100644
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


