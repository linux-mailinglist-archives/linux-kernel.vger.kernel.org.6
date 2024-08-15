Return-Path: <linux-kernel+bounces-287603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4B9529CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A001F239F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D117ADE3;
	Thu, 15 Aug 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BVzWtDEt"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5B4502B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706511; cv=none; b=gHa3IqJEuNHlvCRlKhfUlZoD1MNpQzKcfclYVTE7/ujIsXEQ9kjmhl+U8hCatbHbtvMZ6A+tHh3FVyQfsQbC5Xn+2N3iNoTybm+KmgtKDev/xbDsmEWqoHysCIEI7ZgEyWJ6vpQnVp4gXgZdh+of9IDBpovBepFQiPhXnaATXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706511; c=relaxed/simple;
	bh=3nCv7N/bJGgAFH32cubOSSBl6EN+osyqvORhsEkhCD4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OQg78gIBGUOQPmeg5pdz0/GmzDz+TpeBzj9nPtja0yH8o+Ky6SyWEkOEmnNwhWuxfxUhhgPtkY9GEJVBEsJUcz/wP+oFyqsplKFnOMTAXlVU2Wr6MgCZ5akGIb0U2zI/98PkKNZEUfwFgOfmzkpLcX5QHvh4vkXqiHZC2Jw1Xdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BVzWtDEt; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723706507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6L1k8kwIf+HGl+QxmcDKqyyW8jVzFtFYfbXsUufB3qI=;
	b=BVzWtDEtnr6d3Q7t+dCGnR28ooBnKJ4uUL0e6Q66yUG1p//9oOR3J5bFyWhMXSTtZgp1T+
	QNNhaxSCaiWz7RfTZVK+L6TD3+gmZZtoubTF4UgLo8wIC+GIFHjWS/yV6oMW8sV8rcFyHU
	QKAcp/JWX+8uJM7oKv4hD/JzVlvqTmk=
From: Hao Ge <hao.ge@linux.dev>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	surenb@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/slub: Add check for s->flags in the alloc_tagging_slab_free_hook
Date: Thu, 15 Aug 2024 15:21:13 +0800
Message-Id: <20240815072113.30288-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

When enable CONFIG_MEMCG & CONFIG_KFENCE & CONFIG_KMEMLEAK,
the following warning always occurs,This is because the
following call stack occurred:
mem_pool_alloc
    kmem_cache_alloc_noprof
        slab_alloc_node
            kfence_alloc

Once the kfence allocation is successful,slab->obj_exts will not be empty.
Since in the prepare_slab_obj_exts_hook function,we perform a check for
s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE),the alloc_tag_add function
will not be called as a result.Therefore,ref->ct remains NULL.

However,when we call mem_pool_free,since obj_ext is not empty,
it eventually leads to the alloc_tag_sub scenario being invoked.
This is where the warning occurs.

So we should add corresponding checks in the alloc_tagging_slab_free_hook.
For __GFP_NO_OBJ_EXT case,I didn't see the specific case where it's
using kfence,so I won't add the corresponding check in
alloc_tagging_slab_free_hook for now.

[    3.734349] ------------[ cut here ]------------
[    3.734807] alloc_tag was not set
[    3.735129] WARNING: CPU: 4 PID: 40 at ./include/linux/alloc_tag.h:130 kmem_cache_free+0x444/0x574
[    3.735866] Modules linked in: autofs4
[    3.736211] CPU: 4 UID: 0 PID: 40 Comm: ksoftirqd/4 Tainted: G        W          6.11.0-rc3-dirty #1
[    3.736969] Tainted: [W]=WARN
[    3.737258] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
[    3.737875] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.738501] pc : kmem_cache_free+0x444/0x574
[    3.738951] lr : kmem_cache_free+0x444/0x574
[    3.739361] sp : ffff80008357bb60
[    3.739693] x29: ffff80008357bb70 x28: 0000000000000000 x27: 0000000000000000
[    3.740338] x26: ffff80008207f000 x25: ffff000b2eb2fd60 x24: ffff0000c0005700
[    3.740982] x23: ffff8000804229e4 x22: ffff800082080000 x21: ffff800081756000
[    3.741630] x20: fffffd7ff8253360 x19: 00000000000000a8 x18: ffffffffffffffff
[    3.742274] x17: ffff800ab327f000 x16: ffff800083398000 x15: ffff800081756df0
[    3.742919] x14: 0000000000000000 x13: 205d344320202020 x12: 5b5d373038343337
[    3.743560] x11: ffff80008357b650 x10: 000000000000005d x9 : 00000000ffffffd0
[    3.744231] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008237bad0 x6 : c0000000ffff7fff
[    3.744907] x5 : ffff80008237ba78 x4 : ffff8000820bbad0 x3 : 0000000000000001
[    3.745580] x2 : 68d66547c09f7800 x1 : 68d66547c09f7800 x0 : 0000000000000000
[    3.746255] Call trace:
[    3.746530]  kmem_cache_free+0x444/0x574
[    3.746931]  mem_pool_free+0x44/0xf4
[    3.747306]  free_object_rcu+0xc8/0xdc
[    3.747693]  rcu_do_batch+0x234/0x8a4
[    3.748075]  rcu_core+0x230/0x3e4
[    3.748424]  rcu_core_si+0x14/0x1c
[    3.748780]  handle_softirqs+0x134/0x378
[    3.749189]  run_ksoftirqd+0x70/0x9c
[    3.749560]  smpboot_thread_fn+0x148/0x22c
[    3.749978]  kthread+0x10c/0x118
[    3.750323]  ret_from_fork+0x10/0x20
[    3.750696] ---[ end trace 0000000000000000 ]---

Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/slub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index c9d8a2497fd6..1f67621ba6dc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2116,6 +2116,9 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 	if (!mem_alloc_profiling_enabled())
 		return;
 
+	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
+		return;
+
 	obj_exts = slab_obj_exts(slab);
 	if (!obj_exts)
 		return;
-- 
2.25.1


