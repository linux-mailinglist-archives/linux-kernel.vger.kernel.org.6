Return-Path: <linux-kernel+bounces-410631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF269CDE46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F601F23067
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084761B6D11;
	Fri, 15 Nov 2024 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oPtQRaP1"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8D2D05D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674023; cv=none; b=MXgB/w5KnLBD+W0AcsbRLSp51dcZRh/+v26wkw6igNU00OAfxXT2B6m7WdRcSvRyWrGL458HKHQkgZ7AsVM42HZYAgPg9HvFrUY9Y+HtBaetx06BBRdug+m/xvBeHe5Zt+ZEQPHc74g2iImExw3jdVZwTVy3HqWWbNfHk8jN7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674023; c=relaxed/simple;
	bh=RcM02kQdODpNrXfaUdcRy6gH7ddc3eCg6+eHuFDzWYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gQBL7yOr16fbpfJWNdzEFW/wJbJnznewUa0MaOGzdNjKV1foN+ztw0FJfJfU/UyNMQsdKl8uvYuRpnZwjtungpKE1PSh/uv9TOZxk86xeC6DaQVY4HKEs6oCXnGDbd/1etc+LUUYfPFu5z9Zk68Y3zGOlgrHPwZIdcvJ5PheL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oPtQRaP1; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731674018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aWRaGv2mUFRTnGJy+AZNP75OOPCHZDmd98dp1bDXSU4=;
	b=oPtQRaP15bI36dIMRzYi74JF9vKHs8mHaUNEsObPSIBjF2/Wn/rEXh79r5+tr0orrqwgvz
	lrmB8N0KDRk/fsrkIXCYBbAF0NAVWHGSLoX+KxxVJ4eo+Jn4ABh/Ehef4d/CtCg4Q8Lj8K
	+QUvuPytQ6pDY5b028CgR2ltcqG5z1Y=
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
Subject: [PATCH v3 0/3] drm/etnaviv: Trivial mmu map and ummap cleanups
Date: Fri, 15 Nov 2024 20:32:43 +0800
Message-Id: <20241115123246.111346-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The 'sg->offset' denotes the offset into a page in bytes, but under drm
subsystem, there has NO drivers that etnaviv can contact that actually
touch the 'offset' data member of SG anymore. This means that all DMA
addresses that sg_dma_address() gives us will be PAGE_SIZE aligned, in
other words, sg->offset will always equal to 0.

But if 'sg->offset != 0' really could happens, then the current implement
might be not correct. Previous commits[1] fix the 'sg->offset == 0' cases
effectively, below is a simple illustration.

       One CPU page       Another one CPU page
  +----+----+----+----+   +----+----+----+----+
  ||||||              |   ||||||              |
  +----+----+----+----+   +----+----+----+----+
  ^    ^                  ^    ^
  |    |                  |    |
  |    | .----------------'    |
  |    | |    .----------------'
  |    | |    |
  +----+ +----+ +----+
  |||||| |||||| |    |  GPU pages, each one is SZ_4K
  +----+ +----+ +----+
            Correct implementation.

--------------------------------------------------------------

       One CPU page       Another one CPU page
  +----+----+----+----+   +----+----+----+----+
  |///////////////////|   ||||||              |
  +----+----+----+----+   +----+----+----+----+
  ^                   ^   ^    ^
  |                   |   |    |
  |      .------------|---'    |
  |      |    .-------|--------'
  |      |    |       |
  |      +----+       |
  |      ||||||       |
  |      +----+       |
  |       IOVA        |  GPUVA range collision if use 'sg_dma_len(sg)'
  +----+ +----+-------+  directly to map. Because 'sg_dma_len(sg)' is
  |////|/|////////////|  frequently larger than SZ_4K.
  +----+ +----+-------+
            Wrong implementation.

If we map the address range with respect to the size of the backing memory,
it will occupy GPUVA ranges that doesn't belong to. Which results in GPUVA
range collision for different buffers.

Patch 0001 of this series give a fix, patch 0002 and 0003
do trivial cleanup which eliminates unnecessary overheads.

v2 -> v3
	* Reword and improve commit message
v1 -> v2
	* Reword and fix typos and mistakes

v1 Link: https://patchwork.freedesktop.org/series/140589/

Sui Jingfeng (3):
  drm/etnaviv: Drop the offset in page manipulation
  drm/etnaviv: Fix the debug log  of the etnaviv_iommu_map()
  drm/etnaviv: Improve VA, PA, SIZE alignment checking

 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
2.34.1


