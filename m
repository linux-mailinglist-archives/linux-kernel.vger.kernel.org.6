Return-Path: <linux-kernel+bounces-373749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775A9A5C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7915BB213BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC31D0F76;
	Mon, 21 Oct 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="wkRONGB/"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6D9454
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494300; cv=none; b=k19uxXFPCcUdCLulDblodUW6D/bLGSfdS3OGKfORF72uGKEokhUksfgkdTl+8iBiQzFiLAVlzgQmdvc08AOhyzWGFsi9cCkR2dpNeZPXMnXr4jQ54a/50tOnxNApVj9KldyYV7neYRYySEGCxivHor7rGyDKQUAlYKzoA21Pglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494300; c=relaxed/simple;
	bh=B820vkK+6CCW1slGtSQI79P+5XHLgJDW15iLML5/u2c=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=DHa4Tjvq33h2hIU/wFk3UKqnd5FXqQj1/YxMxQxNjp+yTM1cMYXralnBK5siQ9tiSHXVVuk6ytTMtGTaFO4I0g0WKU07IveAdElKiORFNZG8HWAceJ4sRdZ9h/AjMMGqaY3FEpXjmhfbWgU+SXTQRyO1dzGNwj+fgFl5OWqn/2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=wkRONGB/; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1729493988;
	bh=144/N2ZzvXSuwNAqNOt4nx8XXQ2rHmaeMBaqchMXVdA=;
	h=From:To:Cc:Subject:Date;
	b=wkRONGB/bV01UhZ33+QuTLHREskDPCgNj99F/jrYHYhq8grD9LilYbU1DELrr2HCI
	 Q1FqZgND1XOtqcYJ+VQBH2x2ier/jZdvH9WdGtj/GFT7kDN1BCz1wueoVeESaVwFq9
	 K5OIM13hd3fTAY1ecv2XxRrPMcUcMwyHfda1UhC0=
Received: from xiaopei-pc.. ([111.48.58.13])
	by newxmesmtplogicsvrszgpuc1-0.qq.com (NewEsmtp) with SMTP
	id EEE8CCD0; Mon, 21 Oct 2024 14:59:46 +0800
X-QQ-mid: xmsmtpt1729493986t433b4fs9
Message-ID: <tencent_C1486E2FA393F0B97DD7D308336E262A3407@qq.com>
X-QQ-XMAILINFO: MmCmH9jyqHC2n4gG4e7gexqW8tzjEJFq8/qXrF9Q5PcqxZ/kkEeOXdO0dcFAcp
	 j+u/BFL5N2Hv2NVoVLOa4z+Qu24vEpC4ifFoKFQFWs31RoYGfEnBkCxz5A1bIuvcHWSdEi3Ow9HR
	 S9hST+dKsS5JE2tL/UAoob/GjjVmmDQlfMHYPUc91XBgbFpk74znjCk5nC9fFYcRILVp5xHC8j6E
	 zntgtOlmeufc542czi9/QZwIRAV+clfazkXQCUtX1hOtgCJCVY+UlZpRnawpuAPxEM5Ss1ntaHda
	 oerT/EjpvTQfrJr/Lx9BFPvMWMdRLg5FSv6/wsrLelY7w9IbvGKITVPMyUj85NkZp/4CBnMpqeyg
	 0LCXv6GEA00iZCQpEbxW0UChafHTzlwCMuTu4PCg7bacYxrL4KOGhEvlNI/ovrevpnT85wVIwdaZ
	 bTa9Lb4VOSv6jLusnuilKKihauFWjwg8bk/M8fcvvsVX11smEGGOQG9uWYj9rtRCBAOe3IEOBGzh
	 zS1iownnWooBR2aSXfMq6OjCqe4cXgX9s2L/vrGORdZmg6ZriAnEnBt71tnQcHyxcxjZ1eQUDp6X
	 db4vSeeEtbxLTtQRQee++pHbh5k92pAtJjHO9T6IWs8lPAznDML0jUtAbdj0KcHWBQhpSIWsz383
	 syU+xgFmVzRWrdkZK+UC9KxypdRgcRDwVEbd59WjNl9mN/G0y+psLgo/4gh2OkzU+YUcmlYsV10b
	 bmr6izkA7ot5YIwFZcgOHFwiGdEPWGtlP8G4Gg26wrdQBZm2zMn1yfHOkGR48u7P6V/LHzNTaGIo
	 NmxU5xofKRcRWs0IUbethWbNARqUPcba+8MhlefES1Q+bjYOj8D8rjMh3iIf36Xmn+jWLyJkvhBQ
	 Cl+mb+MEUCwoJ6iG3BqCXAwZUYg0yfT73nwdqiVNvGiU/3hXjoluIaymfiX2+fnYhelwJPIF5SQ5
	 QRprkaHNUoxrC3/HUYpBvBwBbtHEv19CGKGBxEAMQPeFp4oAmVhKtsc1UIaB6gGZiWcd86UsNK2z
	 rLRa9H4ofITwD9skK4yrsmUIBwU2WaGRrzA2JS2oUJbsV9CqtvfKjjftDOfXx9gtlvjpSpB3R5OO
	 Et8aNv
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: xiaopeitux@foxmail.com
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	surenb@google.com,
	yuzhao@google.com
Cc: xiaopei01@kylinos.cn,
	gehao@kylinso.cn,
	xiongxin@kylinos.cn
Subject: [PATCH] slub/slub_kunit:fix a panic due to __kmalloc_cache_noprof incorretly use
Date: Mon, 21 Oct 2024 14:59:42 +0800
X-OQ-MSGID: <c9e26738d7ecb6f1b69ee5f400cc6c3ac343f19c.1729491701.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

'modprobe slub_kunit',will have a panic.The root cause is that
__kmalloc_cache_noprof was directly ,which resulted in no alloc_tag
being allocated.This caused current->alloc_tag to be null,leading to
a null pointer dereference in alloc_tag_ref_set.

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

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 include/linux/slab.h | 1 +
 lib/slub_kunit.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 10a971c2bde3..0149d36cd311 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -827,6 +827,7 @@ void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
 void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
 				  int node, size_t size)
 				__assume_kmalloc_alignment __alloc_size(4);
+#define kmalloc_cache(...)	alloc_hooks(__kmalloc_cache_noprof(__VA_ARGS__))
 
 void *__kmalloc_large_noprof(size_t size, gfp_t flags)
 				__assume_page_alignment __alloc_size(1);
diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 80e39f003344..4bf38f52dbbd 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -141,7 +141,7 @@ static void test_kmalloc_redzone_access(struct kunit *test)
 {
 	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
 				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
-	u8 *p = __kmalloc_cache_noprof(s, GFP_KERNEL, 18);
+	u8 *p = kmalloc_cache(s, GFP_KERNEL, 18);
 
 	kasan_disable_current();
 
-- 
2.34.1


