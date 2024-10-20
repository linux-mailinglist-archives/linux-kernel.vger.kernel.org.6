Return-Path: <linux-kernel+bounces-373147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B420D9A52F9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0371C211FE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FC21CABF;
	Sun, 20 Oct 2024 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IvRPNWaD"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A761426C
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729408132; cv=none; b=jZBy/ppouV5IHn6bP7XySHXQc+/Elq6nhKjzklRVu9C0yzyfm1QJbrVt0LDc7Zcugq9SwPpmcfotIX+ET+F34ejWlu/EOYtvg50kiA0WpDlutnx/RHzLYZ20diYXMlCMbvXn/77X4XqBmeUVRoVoK9LyQdiO0Cu6ahJw1ZdcYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729408132; c=relaxed/simple;
	bh=QMiL4cA0pX0cwFCg2aR5P5zopBl0Q/7Gl3PjWIlvw9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TXEKalKE7xpPMxvhitQRlkCdhhj3rF+qjtAns/TfHRhO+rYDGFp7v8dWSOis0tz1bBJLmdyf0WCigfpa7JvzJ/xySIPx3DlYkFlJU81voKM8FKwyEZPukCWHj26h/RDgJOmJ2RHHhKwLQBkHMpmKu7ZLE8bDsvtoN993DAVJhhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IvRPNWaD; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729408128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqIdPb7NeBf33hzfhwQNcfLF0EmzG7i1fDU5vSLYBC4=;
	b=IvRPNWaDmJOH8b9my6/BQXYfg6P491lWbqyLXriDEALj5L9ZfvuMwEDXL1s1UPPwfQ1QtR
	LInLiDNVXgCB5Asi8zG2uepate5c7akcTaoSHGkLNx6U9HI32tXtlIdmNUDMLymxbY49GH
	RL2jBcxqBdAcZcVEh1s4eUDvHSXHwok=
From: Hao Ge <hao.ge@linux.dev>
To: surenb@google.com,
	kent.overstreet@linux.dev,
	akpm@linux-foundation.org
Cc: yuzhao@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v3] mm/codetag: fix null pointer check logic for ref and tag
Date: Sun, 20 Oct 2024 15:08:19 +0800
Message-Id: <20241020070819.307944-1-hao.ge@linux.dev>
In-Reply-To: <20241018152925.138341-1-hao.ge@linux.dev>
References: <20241018152925.138341-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

When we compile and load lib/slub_kunit.c,it will cause a panic.

The root cause is that __kmalloc_cache_noprof was directly called
instead of kmem_cache_alloc,which resulted in no alloc_tag being
allocated.This caused current->alloc_tag to be null,leading to a
null pointer dereference in alloc_tag_ref_set.

Despite the fact that my colleague Pei Xiao will later fix the code
in slub_kunit.c,we still need fix null pointer check logic for ref
and tag to avoid panic caused by a null pointer dereference.

Here is the log for the panic:

[   74.779373][ T2158] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
[   74.780130][ T2158] Mem abort info:
[   74.780406][ T2158]   ESR = 0x0000000096000004
[   74.780756][ T2158]   EC = 0x25: DABT (current EL), IL = 32 bits
[   74.781225][ T2158]   SET = 0, FnV = 0
[   74.781529][ T2158]   EA = 0, S1PTW = 0
[   74.781836][ T2158]   FSC = 0x04: level 0 translation fault
[   74.782288][ T2158] Data abort info:
[   74.782577][ T2158]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   74.783068][ T2158]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   74.783533][ T2158]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   74.784010][ T2158] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000105f34000
[   74.784586][ T2158] [0000000000000020] pgd=0000000000000000, p4d=0000000000000000
[   74.785293][ T2158] Internal error: Oops: 0000000096000004 [#1] SMP
[   74.785805][ T2158] Modules linked in: slub_kunit kunit ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle 4
[   74.790661][ T2158] CPU: 0 UID: 0 PID: 2158 Comm: kunit_try_catch Kdump: loaded Tainted: G        W        N 6.12.0-rc3+ #2
[   74.791535][ T2158] Tainted: [W]=WARN, [N]=TEST
[   74.791889][ T2158] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[   74.792479][ T2158] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   74.793101][ T2158] pc : alloc_tagging_slab_alloc_hook+0x120/0x270
[   74.793607][ T2158] lr : alloc_tagging_slab_alloc_hook+0x120/0x270
[   74.794095][ T2158] sp : ffff800084d33cd0
[   74.794418][ T2158] x29: ffff800084d33cd0 x28: 0000000000000000 x27: 0000000000000000
[   74.795095][ T2158] x26: 0000000000000000 x25: 0000000000000012 x24: ffff80007b30e314
[   74.795822][ T2158] x23: ffff000390ff6f10 x22: 0000000000000000 x21: 0000000000000088
[   74.796555][ T2158] x20: ffff000390285840 x19: fffffd7fc3ef7830 x18: ffffffffffffffff
[   74.797283][ T2158] x17: ffff8000800e63b4 x16: ffff80007b33afc4 x15: ffff800081654c00
[   74.798011][ T2158] x14: 0000000000000000 x13: 205d383531325420 x12: 5b5d383734363537
[   74.798744][ T2158] x11: ffff800084d337e0 x10: 000000000000005d x9 : 00000000ffffffd0
[   74.799476][ T2158] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008219d188 x6 : c0000000ffff7fff
[   74.800206][ T2158] x5 : ffff0003fdbc9208 x4 : ffff800081edd188 x3 : 0000000000000001
[   74.800932][ T2158] x2 : 0beaa6dee1ac5a00 x1 : 0beaa6dee1ac5a00 x0 : ffff80037c2cb000
[   74.801656][ T2158] Call trace:
[   74.801954][ T2158]  alloc_tagging_slab_alloc_hook+0x120/0x270
[   74.802494][ T2158]  __kmalloc_cache_noprof+0x148/0x33c
[   74.802976][ T2158]  test_kmalloc_redzone_access+0x4c/0x104 [slub_kunit]
[   74.803607][ T2158]  kunit_try_run_case+0x70/0x17c [kunit]
[   74.804124][ T2158]  kunit_generic_run_threadfn_adapter+0x2c/0x4c [kunit]
[   74.804768][ T2158]  kthread+0x10c/0x118
[   74.805141][ T2158]  ret_from_fork+0x10/0x20
[   74.805540][ T2158] Code: b9400a80 11000400 b9000a80 97ffd858 (f94012d3)
[   74.806176][ T2158] SMP: stopping secondary CPUs
[   74.808130][ T2158] Starting crashdump kernel...

Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v3: Modify the code logic based on Suren's suggestions.
    Update title and commit message due to code logic change.
    Add Suggested-by: Suren Baghdasaryan <surenb@google.com>
    Add Acked-by: Yu Zhao <yuzhao@google.com>

v2: Modify the errors in the title and commit message.
    Remove the empty lines that were mistakenly added in version v1.
---
 include/linux/alloc_tag.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 1f0a9ff23a2c..941deffc590d 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -135,18 +135,21 @@ static inline void alloc_tag_sub_check(union codetag_ref *ref) {}
 #endif
 
 /* Caller should verify both ref and tag to be valid */
-static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
+static inline bool __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
 {
 	alloc_tag_add_check(ref, tag);
 	if (!ref || !tag)
-		return;
+		return false;
 
 	ref->ct = &tag->ct;
+	return true;
 }
 
-static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
+static inline bool alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
 {
-	__alloc_tag_ref_set(ref, tag);
+	if (unlikely(!__alloc_tag_ref_set(ref, tag)))
+		return false;
+
 	/*
 	 * We need in increment the call counter every time we have a new
 	 * allocation or when we split a large allocation into smaller ones.
@@ -154,12 +157,13 @@ static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *t
 	 * counter because when we free each part the counter will be decremented.
 	 */
 	this_cpu_inc(tag->counters->calls);
+	return true;
 }
 
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
 {
-	alloc_tag_ref_set(ref, tag);
-	this_cpu_add(tag->counters->bytes, bytes);
+	if (likely(alloc_tag_ref_set(ref, tag)))
+		this_cpu_add(tag->counters->bytes, bytes);
 }
 
 static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
-- 
2.25.1


