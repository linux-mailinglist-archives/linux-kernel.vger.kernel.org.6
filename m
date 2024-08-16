Return-Path: <linux-kernel+bounces-288802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023C2953EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9440E1F237D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEAE1E502;
	Fri, 16 Aug 2024 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="exhJrQZJ"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9BBA53
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772048; cv=none; b=En1EJ2jMIvHjtUmlqBvU+rsJKmqtACZKN36BiJQXb60m6kvDMUOFjctFsealC+Yifp0UFkauxg857lnprUSPk2IepucB0PUXSIiNmNkFim8hXVcelU3yyS+87jzbeeuj2to0ZN6m6iRXFLsuQL3R7Rn+Qutf3GliZLK4ieMTtqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772048; c=relaxed/simple;
	bh=5R5dXRpR6eYdb1sjisQlhRy0Qrdafnq8FVX44MzTPig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0rRE7wjqey4zRA3UOa93xblvoRBaNfPXC9cDa9UbVHM65qAxe8IpeTtK/ACjm4PNqXYI1NtL+x5KAEekDcq0HYzd/xBfxaALhHPkml3BCwSmvFSS49m4FXwKeJfTXJ/TYu21xR/EfBsCwLaQ4CXxHGReuuQNcgZ6wY8l+tWlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=exhJrQZJ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723772043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRPxcS0Hb28gbfuevEypKu5iGXP9IOHao5nXppLKMFo=;
	b=exhJrQZJe0SErKtm8EKncvJ30xbUH5sdl6vD/JuZ0cMA2n/NOskPy19TLAp8KIOYa6CqYN
	Zo3d/oVeqKWSnMGAw8uomE/NSn0AcQSC50ZVEVEGnRwzNaYY8FxaCBRyKMpOY50bQQQtkL
	jye9g2TOj2HdDwcYz1pZ5E93sh0riMo=
From: Hao Ge <hao.ge@linux.dev>
To: surenb@google.com
Cc: 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org,
	cl@linux.com,
	gehao@kylinos.cn,
	hao.ge@linux.dev,
	iamjoonsoo.kim@lge.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	vbabka@suse.cz
Subject: [PATCH v2] mm/slub: Add check for s->flags in the alloc_tagging_slab_free_hook
Date: Fri, 16 Aug 2024 09:33:36 +0800
Message-Id: <20240816013336.17505-1-hao.ge@linux.dev>
In-Reply-To: <CAJuCfpF5v397w9+532bQzPonXzAbBwVVvuXFw3z46q0R1E7Rug@mail.gmail.com>
References: <CAJuCfpF5v397w9+532bQzPonXzAbBwVVvuXFw3z46q0R1E7Rug@mail.gmail.com>
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

Once the kfence allocation is successful,slab->obj_exts will not be empty,
because it has already been assigned a value in kfence_init_pool.

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
 mm/slub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index c9d8a2497fd6..a77f354f8325 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2116,6 +2116,10 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 	if (!mem_alloc_profiling_enabled())
 		return;
 
+	/* slab->obj_exts might not be NULL if it was created for MEMCG accounting. */
+	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
+		return;
+
 	obj_exts = slab_obj_exts(slab);
 	if (!obj_exts)
 		return;
-- 
2.25.1


