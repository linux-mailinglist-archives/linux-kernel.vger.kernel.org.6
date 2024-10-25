Return-Path: <linux-kernel+bounces-382308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA89F9B0C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CD61C21216
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FAB189F45;
	Fri, 25 Oct 2024 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lG6FcQkz"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD320C316
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878722; cv=none; b=jeodSRw6/+OjIGFnwftbYgqEOAe56NwFQiZ3SYFxNhjnjdPYw6Nix1ULZKTPuTQJjOVVVaQ0qnYZRQmPYblTMBFyoaqFiUqTIJemqvoOL5K3cBeDNtVs42s94gocXyErfuqHC1bIf6mYRyPJ67ikUD3ST11pQ7YhxS0fHA0zCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878722; c=relaxed/simple;
	bh=vtarnjOYYX/1uYCgZ9+nm8GB83PBVAlYa7TrUXmbPEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qkCqJ9zSCWb287lvNNziflYCrarDnh1Lu1aM4iBN1pspEU0WN3Yoc+a48Zn81EiGKpdkYjDjautckmIk9p0DypgHZiwhz25f8B0SN8IMIk4pJrg3saFIVKehEbQp+kXYdYl/hqZiFvlhkboIJgNqU63tz1gHBfK34aSUiy+XCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lG6FcQkz; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729878717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0VAovJZnv81E9jN21fLB7KRqTnaLqZovtOnStvkrsto=;
	b=lG6FcQkzWOhTOyl2YtmtCf5w+WUyJwCRe6b/tzxgu/2mpJT9AT3aXo+dLaQorkjoCpnXlk
	4iMmsPvM7qIMsCYZvfq6qvC94wqdBtHDocDDQ+3B1BKb176cRTKWIPBtRSSupSZ9LaVYq/
	0WrcSD7RvVZcOqD6RpPqqPH5yPhe8Do=
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
Subject: [PATCH] drm/etnaviv: Drop the 'struct etnaviv_iommu_global::pta_lock' data member
Date: Sat, 26 Oct 2024 01:51:36 +0800
Message-Id: <20241025175136.414054-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because it is not get used, drop it.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
index c01a147f0dfd..7f8ac0178547 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
@@ -61,7 +61,6 @@ struct etnaviv_iommu_global {
 			/* P(age) T(able) A(rray) */
 			u64 *pta_cpu;
 			dma_addr_t pta_dma;
-			struct spinlock pta_lock;
 			DECLARE_BITMAP(pta_alloc, ETNAVIV_PTA_ENTRIES);
 		} v2;
 	};
-- 
2.34.1


