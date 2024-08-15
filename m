Return-Path: <linux-kernel+bounces-287710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EF2952BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015F71F2120A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AFA1BB6A6;
	Thu, 15 Aug 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KJ8J/pXm"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C593214
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712618; cv=none; b=rIVbYqQxYqdeUqsxDouqIULWAJDuPOx1ffOj+glzmAjD44O4NcAVWbLUxP0iCexd8HLQ7OTLokWxtne4ONYJSo/+YQzlwdJGgsYWLtPlat2OAM5StqcBmDXgJkuZAJ4/whGEw2+JKLQY431HrLxjCRVF2tP53bdxiZyDhNX1JfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712618; c=relaxed/simple;
	bh=82ovCvhb1Tyh9pHOR9sZr/vyvdxlbkeBt+Pryy9GisQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n4XaWU6CcyPA3wwlgdn65XU1HuLhhR1ECUY9VmJHaxz9l4getbARBTEh9b9fXAxZ8CqiwIe9uccL1nA8FrBrMzPyw39Bo/aSjR1faOrzI1FG9TvMtWwFTjKspWJurVtZsKCDl+J1IdUkpvFG9gDdD3SQEuwMrJWddJ4qQLSs5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KJ8J/pXm; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723712614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KIxXFek9GnWErg2oi1kCRegTo0ov+46L+2lXaPDEJTs=;
	b=KJ8J/pXmJ0e6DIJ5Y5+erb/enczRu6YoLS3Dh54naD4kxN7XYrjOS2KcC3wKytgZXUVMnZ
	6WDujFs0uYGoeXqfBEK40SgRagMs2iuNZE8tgswic1Ejtd/zjKmXouzPq+6jjdxwh4+kU/
	2HHiFqswCA/SOX9aeCi37RrBmaxEDrA=
From: Hao Ge <hao.ge@linux.dev>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	surenb@google.com,
	babka@suse.cz,
	kent.overstreet@linux.dev,
	kees@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] codetag: debug: mark codetags for cma pages as empty
Date: Thu, 15 Aug 2024 17:03:24 +0800
Message-Id: <20240815090324.36065-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Here are some warnning

[    1.342603] ------------[ cut here ]------------
[    1.342608] alloc_tag was not set
[    1.342623] WARNING: CPU: 0 PID: 1 at ./include/linux/alloc_tag.h:130 __free_pages+0x1a4/0x1b4
[    1.342633] Modules linked in:
[    1.342639] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc3+ #12
[    1.342645] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.342650] pc : __free_pages+0x1a4/0x1b4
[    1.342654] lr : __free_pages+0x1a4/0x1b4
[    1.342658] sp : ffff8000833dbcb0
[    1.342661] x29: ffff8000833dbcb0 x28: ffff000b34d9dac0 x27: ffff80008175f000
[    1.342669] x26: 00000000000fc000 x25: ffff800082ac6028 x24: ffff80008252e000
[    1.342675] x23: ffff0000c0660000 x22: 0000000000000000 x21: 0000000000000009
[    1.342681] x20: 0000000000000000 x19: fffffd7fc3ac0000 x18: ffffffffffffffff
[    1.342688] x17: ffff80008105bf68 x16: ffff800081841bb4 x15: 0720072007200720
[    1.342694] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
[    1.342700] x11: 0720072007200720 x10: 0720072007200720 x9 : 0720072007200720
[    1.342706] x8 : 0720072007200720 x7 : ffff80008237bad0 x6 : c0000000ffff7fff
[    1.342712] x5 : ffff80008237ba78 x4 : ffff8000820bbad0 x3 : 0000000000000001
[    1.342719] x2 : 13c63f521095dc00 x1 : 13c63f521095dc00 x0 : 0000000000000000
[    1.342725] Call trace:
[    1.342728]  __free_pages+0x1a4/0x1b4
[    1.342732]  init_cma_reserved_pageblock+0x5c/0xac
[    1.342739]  cma_init_reserved_areas+0x2b4/0x3f4
[    1.342744]  do_one_initcall+0x54/0x368
[    1.342749]  kernel_init_freeable+0x23c/0x450
[    1.342755]  kernel_init+0x2c/0x144
[    1.342760]  ret_from_fork+0x10/0x20
[    1.342764] ---[ end trace 0000000000000000 ]---

To avoid debug warnings while freeing cma pages which were not
allocated with usual allocators, mark their codetags as empty before
freeing.

Reference commit d224eb0287fb ("codetag: debug: mark codetags
for reserved pages as empty")

Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/mm_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75c3bd42799b..d7d40a8d738f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2243,6 +2243,16 @@ void __init init_cma_reserved_pageblock(struct page *page)
 		set_page_count(p, 0);
 	} while (++p, --i);
 
+	/* pages were reserved and not allocated */
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
+
 	set_pageblock_migratetype(page, MIGRATE_CMA);
 	set_page_refcounted(page);
 	__free_pages(page, pageblock_order);
-- 
2.25.1


