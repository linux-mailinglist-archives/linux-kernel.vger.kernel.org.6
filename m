Return-Path: <linux-kernel+bounces-231975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362EE91A10E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40199B21187
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC22E7347E;
	Thu, 27 Jun 2024 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="prMdhjOb"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3DC23BE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475280; cv=none; b=EfyqOILi1/NjUYPRoHRdUvgVhUmBWLYA2Q6gm3ptVsR7tDFoD9eEbYAmO9jeqRGI1oByTqLO9l80SG5qN/UiEGbcIHROHnlNUSJ+YwTjpx3zfW8nzX7QrB8etgEaZXNF8vQX+5zOGvw3e6XiRNX7dMt8kXqj18+gkUqVbrcOUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475280; c=relaxed/simple;
	bh=WzWaF+SIRKUEAx5vm5g0h95ocaVJLLHn5c//mzNW8dk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdalctNZrIA4iic10jftdAsDRx8jBi2zBLhDESFCpq4fsDjp8GynEjpnbMFgHNkS40KJgTnbH+STfbZjpNUDSE2k9LXxGp58LrDEfxaXAHRfefuHkWBDg7NI2XT//+PcjKEzlHdsRaRbJKtBxrWeiAYskDMj1YhIhAYCA2O914U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=prMdhjOb; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: minchan@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719475275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qk1uUCNTkSFH7biQuWiNk/WtpQApJrMKSj8t5jy2L9Y=;
	b=prMdhjObneMqmY2jva8GFCZsP3n12mpBu2Rxgv91T1w+M9vi0E9OM0dp2fDXaN3ihBydAt
	HefswZUzOVRiAfFFc9aLvsjRB9Cg4GWmChSV3X3LRpMPIlFMNCnTMRAHqWbdjA/vhEOPLj
	pu7TzfAWCnxSNICAuXajabNjUHkZG+w=
X-Envelope-To: senozhatsky@chromium.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: chengming.zhou@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev
Subject: [PATCH 1/2] mm/zsmalloc: fix class per-fullness zspage counts
Date: Thu, 27 Jun 2024 15:59:58 +0800
Message-Id: <20240627075959.611783-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We always use insert_zspage() and remove_zspage() to update zspage's
fullness location, which will account correctly.

But this special async free path use "splice" instead of remove_zspage(),
so the per-fullness zspage count for ZS_INUSE_RATIO_0 won't decrease.

Fix it by decreasing when iterate over the zspage free list.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/zsmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index fec1a39e5bbe..7fc25fa4e6b3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1883,6 +1883,7 @@ static void async_free_zspage(struct work_struct *work)
 
 		class = zspage_class(pool, zspage);
 		spin_lock(&class->lock);
+		class_stat_dec(class, ZS_INUSE_RATIO_0, 1);
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&class->lock);
 	}
-- 
2.20.1


