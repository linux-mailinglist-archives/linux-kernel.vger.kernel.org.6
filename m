Return-Path: <linux-kernel+bounces-375456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8531D9A962C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AB21F213BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F80136E01;
	Tue, 22 Oct 2024 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oEYUtqoq"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E012CDBF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563606; cv=none; b=onaqIyxekM7WiPyUCO6g+Fg6Dz8ycDn0NQ2RthxnP+TpZJlzC/camtHXnu13f3B3RcdsWFSTPwRxnyRrWkdPtiy4xTuflxzIM9asHFQa0ZnG0uawERy129m65Y1Qw+RqkG5pYeyBoMqQ8Td2Wr5Ka8xI+ZctdJprfET4VwDMELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563606; c=relaxed/simple;
	bh=/A/JHvM+Xu6S8RrPguJX8f2DiPe2ij2hlH9qaBDm1qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7oqa0DGwiMXoRsFWemLCrpozaGfA2jmxiUo3Zi0TPhwxDmuLVtx21cqaZ660fagqpG4DtSAVFn+cY6a65QfDIvzmSobTuz6wdll0kXPIf81Whb41r6gdKtjIiVOQAdZz2yZzPNzdCMdgWF5ez3rYxdePoT/t3e0GUS41shZ5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oEYUtqoq; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f2b0d4a1-6603-4f46-79bf-5edf40429d4b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729563599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1aEVtnHrE4hISzvygYPrgxHW3Lpc9qC8PgValIZUKU=;
	b=oEYUtqoqryicx+MPWcoahuAh0u5l7rch8L1MEjq5psKQKFg9qQy+6NxPDeZrWWNGZOqff2
	LO5wEJ6E+7Mv/dNOW14I8n/F5I6JmU9CLOdVSNkFrXDRhJvj8saXyM8dN6yrxmDIaMZ6+n
	jWPtOx4yT/BbQLaDFoLZPljK/JjrmUg=
Date: Tue, 22 Oct 2024 10:19:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slub/slub_kunit:fix a panic due to __kmalloc_cache_noprof
 incorretly use
To: Suren Baghdasaryan <surenb@google.com>, xiaopeitux@foxmail.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, xiaopei01@kylinos.cn,
 gehao@kylinso.cn, xiongxin@kylinos.cn, Vlastimil Babka <vbabka@suse.cz>
References: <tencent_C1486E2FA393F0B97DD7D308336E262A3407@qq.com>
 <CAJuCfpEpxa=jPAZiu5OP=jwQw0awiYDv6x5sz6-BAmAK40iJ6w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpEpxa=jPAZiu5OP=jwQw0awiYDv6x5sz6-BAmAK40iJ6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/22/24 01:42, Suren Baghdasaryan wrote:
> On Sun, Oct 20, 2024 at 11:59 PM <xiaopeitux@foxmail.com> wrote:
>> From: Pei Xiao <xiaopei01@kylinos.cn>
>>
>> 'modprobe slub_kunit',will have a panic.The root cause is that
>> __kmalloc_cache_noprof was directly ,which resulted in no alloc_tag
>> being allocated.This caused current->alloc_tag to be null,leading to
>> a null pointer dereference in alloc_tag_ref_set.
> I think the root cause of this crash is the bug that is fixed by
> https://lore.kernel.org/all/20241020070819.307944-1-hao.ge@linux.dev/.
> Do you get this crash if you apply that fix?
Yes, this patch has resolved the panic issue.
>> Here is the log for the panic:
>> [   74.779373][ T2158] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
>> [   74.780130][ T2158] Mem abort info:
>> [   74.780406][ T2158]   ESR = 0x0000000096000004
>> [   74.780756][ T2158]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [   74.781225][ T2158]   SET = 0, FnV = 0
>> [   74.781529][ T2158]   EA = 0, S1PTW = 0
>> [   74.781836][ T2158]   FSC = 0x04: level 0 translation fault
>> [   74.782288][ T2158] Data abort info:
>> [   74.782577][ T2158]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>> [   74.783068][ T2158]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [   74.783533][ T2158]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [   74.784010][ T2158] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000105f34000
>> [   74.784586][ T2158] [0000000000000020] pgd=0000000000000000, p4d=0000000000000000
>> [   74.785293][ T2158] Internal error: Oops: 0000000096000004 [#1] SMP
>> [   74.785805][ T2158] Modules linked in: slub_kunit kunit ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle 4
>> [   74.790661][ T2158] CPU: 0 UID: 0 PID: 2158 Comm: kunit_try_catch Kdump: loaded Tainted: G        W        N 6.12.0-rc3+ #2
>> [   74.791535][ T2158] Tainted: [W]=WARN, [N]=TEST
>> [   74.791889][ T2158] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>> [   74.792479][ T2158] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   74.793101][ T2158] pc : alloc_tagging_slab_alloc_hook+0x120/0x270
>> [   74.793607][ T2158] lr : alloc_tagging_slab_alloc_hook+0x120/0x270
>>
>> [   74.794095][ T2158] sp : ffff800084d33cd0
>> [   74.794418][ T2158] x29: ffff800084d33cd0 x28: 0000000000000000 x27: 0000000000000000
>> [   74.795095][ T2158] x26: 0000000000000000 x25: 0000000000000012 x24: ffff80007b30e314
>> [   74.795822][ T2158] x23: ffff000390ff6f10 x22: 0000000000000000 x21: 0000000000000088
>> [   74.796555][ T2158] x20: ffff000390285840 x19: fffffd7fc3ef7830 x18: ffffffffffffffff
>> [   74.797283][ T2158] x17: ffff8000800e63b4 x16: ffff80007b33afc4 x15: ffff800081654c00
>> [   74.798011][ T2158] x14: 0000000000000000 x13: 205d383531325420 x12: 5b5d383734363537
>> [   74.798744][ T2158] x11: ffff800084d337e0 x10: 000000000000005d x9 : 00000000ffffffd0
>> [   74.799476][ T2158] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008219d188 x6 : c0000000ffff7fff
>> [   74.800206][ T2158] x5 : ffff0003fdbc9208 x4 : ffff800081edd188 x3 : 0000000000000001
>> [   74.800932][ T2158] x2 : 0beaa6dee1ac5a00 x1 : 0beaa6dee1ac5a00 x0 : ffff80037c2cb000
>> [   74.801656][ T2158] Call trace:
>> [   74.801954][ T2158]  alloc_tagging_slab_alloc_hook+0x120/0x270
>> [   74.802494][ T2158]  __kmalloc_cache_noprof+0x148/0x33c
>> [   74.802976][ T2158]  test_kmalloc_redzone_access+0x4c/0x104 [slub_kunit]
>> [   74.803607][ T2158]  kunit_try_run_case+0x70/0x17c [kunit]
>> [   74.804124][ T2158]  kunit_generic_run_threadfn_adapter+0x2c/0x4c [kunit]
>> [   74.804768][ T2158]  kthread+0x10c/0x118
>> [   74.805141][ T2158]  ret_from_fork+0x10/0x20
>> [   74.805540][ T2158] Code: b9400a80 11000400 b9000a80 97ffd858 (f94012d3)
>> [   74.806176][ T2158] SMP: stopping secondary CPUs
>> [   74.808130][ T2158] Starting crashdump kernel...
>>
> CC'ing Vlastimil.
> This patch essentially reverts Vlastimil's "mm, slab: don't wrap
> internal functions with alloc_hooks()" change. Please check why that
> change was needed before proceeding.
> If this change is indeed needed, please add:

Hi Suren and Vlastimil

In fact, besides the panic, there is also a warning here due to directly 
invoking__kmalloc_cache_noprof

Regarding this, do you have any suggestions?

[58162.947016] WARNING: CPU: 2 PID: 6210 at 
./include/linux/alloc_tag.h:125 alloc_tagging_slab_alloc_hook+0x268/0x27c
[58162.957721] Call trace:
[58162.957919]  alloc_tagging_slab_alloc_hook+0x268/0x27c
[58162.958286]  __kmalloc_cache_noprof+0x14c/0x344
[58162.958615]  test_kmalloc_redzone_access+0x50/0x10c [slub_kunit]
[58162.959045]  kunit_try_run_case+0x74/0x184 [kunit]
[58162.959401]  kunit_generic_run_threadfn_adapter+0x2c/0x4c [kunit]
[58162.959841]  kthread+0x10c/0x118
[58162.960093]  ret_from_fork+0x10/0x20
[58162.960363] ---[ end trace 0000000000000000 ]---


Thanks

Best regards

Hao

>
> Fixes: a0a44d9175b349 ("mm, slab: don't wrap internal functions with
> alloc_hooks()")
>
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>   include/linux/slab.h | 1 +
>>   lib/slub_kunit.c     | 2 +-
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 10a971c2bde3..0149d36cd311 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -827,6 +827,7 @@ void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
>>   void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
>>                                    int node, size_t size)
>>                                  __assume_kmalloc_alignment __alloc_size(4);
>> +#define kmalloc_cache(...)     alloc_hooks(__kmalloc_cache_noprof(__VA_ARGS__))
>>
>>   void *__kmalloc_large_noprof(size_t size, gfp_t flags)
>>                                  __assume_page_alignment __alloc_size(1);
>> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
>> index 80e39f003344..4bf38f52dbbd 100644
>> --- a/lib/slub_kunit.c
>> +++ b/lib/slub_kunit.c
>> @@ -141,7 +141,7 @@ static void test_kmalloc_redzone_access(struct kunit *test)
>>   {
>>          struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
>>                                  SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
>> -       u8 *p = __kmalloc_cache_noprof(s, GFP_KERNEL, 18);
>> +       u8 *p = kmalloc_cache(s, GFP_KERNEL, 18);
>>
>>          kasan_disable_current();
>>
>> --
>> 2.34.1
>>

