Return-Path: <linux-kernel+bounces-265315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F126393EF61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD60B2284F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49AE13A88D;
	Mon, 29 Jul 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XuYwTP3X"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CE913774A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240297; cv=none; b=OkJB1dBBbL3XBogbiUH85G6Ggw0lfXcbzRtYkWCdL3mfe12jpcCcAuLz9VlJd7qWCeGWOcRP5C/U9Kh5bpwEcFFm98aIaqNMFJcJiYSSZhy71Z8mFjZihFz30eo3FQNu3sokZLdpQpOlcdLan0H3XIGCEL6um7brXVBDnGFDn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240297; c=relaxed/simple;
	bh=da1G5TUq+re5ySQ028P0r8fCT5KPY/sxd/Lpcy/13n4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VXTGMFgJu0UU80VUtTV86iiFqgwqsAYmFSHTl/29ZQVm4I3VrF0+mGyc8UF1BTeX3z9GydaobtswqkAE5MgcliFcxrwPNhbsiZ7jl1/ZUlewtBUTikzZxAkS4qmc0B4mIcg9VxNzMiciyVT7bfP4R8YF4f/gCtZzDclD5JL3s4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XuYwTP3X; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722240291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3tVz4BFyaI14oqW+O7DXBLdBOOgI2JMFxMa2wntnSZM=;
	b=XuYwTP3X/SdP2Q5XXdxn7aPntDKX/BhQluIrnSkfQRQ72tJ8IX64oNuDEQugRL6jf/tR2W
	W+K9s8o61kk6zSlEAHvcMho+gxw7tcwL7PKkp9iHadUlW3nBYikwOLiScxJbvI4XHcClcm
	AXLpJFaWFZ2Gn12NSyruZD9wYuujtfE=
From: Hao Ge <hao.ge@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/cma: Change the addition of totalcma_pages in the cma_init_reserved_mem
Date: Mon, 29 Jul 2024 16:04:31 +0800
Message-Id: <20240729080431.70916-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Replace the unnecessary division calculation with cma->count
when update the value of totalcma_pages.

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 3e9724716bad..95d6950e177b 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -202,7 +202,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	cma->order_per_bit = order_per_bit;
 	*res_cma = cma;
 	cma_area_count++;
-	totalcma_pages += (size / PAGE_SIZE);
+	totalcma_pages += cma->count;
 
 	return 0;
 }
-- 
2.25.1


