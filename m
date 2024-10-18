Return-Path: <linux-kernel+bounces-372051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9F9A43D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0532F1C23B69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD7202656;
	Fri, 18 Oct 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RCR8TQBh"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBD201273
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268794; cv=none; b=I5nScwPYt+4zq5p3jL7p11Rd6RdMfO0jBUwJUjlRs32xVRk1yTVv6K4ay6i3g4o9ywE9+4LN76sO3AdtUAsre+rkB6PMI5i1HcKEkBM8/bA60Z4zSG4rko7TXKiJmJ+c5uoymkSGYq2Xk1QVxnWZjqYprqenJxVvKV4nIjJT0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268794; c=relaxed/simple;
	bh=HRTZaXDBrFUAoRnNeGJRP0l2UpgCPoD1h3PvuB7mPqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAuYq+5Q6+uVpmvoQW7NZX6GBaS6bIM91X39LhCn9Nzdl108JkSXU+KKbxE4qEoUcLTAH45IPvUF1wqoMYfP9DK/pMufG9PEvAQv9M/smgfsKUQNoKetrV1rzAUQw0OEeF0YphtzJoULhn1Ddh6sca+vXblKEEROk9waHlTphTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RCR8TQBh; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729268788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZFNty+4MUqUulapojItD8daiL/iVPa2dufUpuuxdUk=;
	b=RCR8TQBhzi5rMo3TV7meFY54D3RTlAQuvL5ba0WLsRC6gKuMmzzxcH5OCdsZtSUTCPPZEZ
	2C3RPRvy0ycgvapMQCaP72+tRzfbpY8hVqB/Prkj0rkO1jZhjsSuUZfJREZBr+7GJiuS2t
	qZINTFwYD55eWF8JSTIMCt7gJ8hlz1o=
From: Hao Ge <hao.ge@linux.dev>
To: surenb@google.com,
	kent.overstreet@linux.dev,
	akpm@linux-foundation.org
Cc: yuzhao@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] mm/codetag: move ref and tag null pointer check to alloc_tag_add
Date: Sat, 19 Oct 2024 00:25:59 +0800
Message-Id: <20241018162559.143548-1-hao.ge@linux.dev>
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
in slub_kunit.c,we still need to move the null pointer check for ref
and tag to alloc_tag_add here.
It is sufficient for us to issue a warning to the user;
It should not lead to a panic.

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
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: Modify the errors in the title and commit message.
    Remove the empty lines that were mistakenly added in version v1.
---
 include/linux/alloc_tag.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 1f0a9ff23a2c..8603e3a9df10 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -137,10 +137,6 @@ static inline void alloc_tag_sub_check(union codetag_ref *ref) {}
 /* Caller should verify both ref and tag to be valid */
 static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
 {
-	alloc_tag_add_check(ref, tag);
-	if (!ref || !tag)
-		return;
-
 	ref->ct = &tag->ct;
 }
 
@@ -158,6 +154,10 @@ static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *t
 
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
 {
+	alloc_tag_add_check(ref, tag);
+	if (!ref || !tag)
+		return;
+
 	alloc_tag_ref_set(ref, tag);
 	this_cpu_add(tag->counters->bytes, bytes);
 }
-- 
2.25.1


