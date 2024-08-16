Return-Path: <linux-kernel+bounces-288814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8659E953F10
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9B428509E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF7226AFC;
	Fri, 16 Aug 2024 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d6souiOr"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4939FFE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772781; cv=none; b=ELcNv8oUhGrIejKOWJhnq+mM/CGUkMW/G5ZQv+I4dpd4pl104av2ZUahotKNgHSs7K16BLOtEewxaUUqhQDPaq/hcUuhn5JOx6fV/VIQ+MG29xyRnRabqKa3ZgLrPqZKsLThCL5L143kY1zjkhLSvsJCtjlLt8LK2HyxkLzFogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772781; c=relaxed/simple;
	bh=5O5lz6ZVoti+DzEdw+zf1/r9Gv9EU/sBTvdFahb0yK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVQwX6nM2lGLlHEMBhBjl9ZQaF2eSJ0TKynwMcwn02QkTG0320XAy4fS+oWWVN+HScoXMWDwl81KiYyyXlD5CeRBjgf9dey11e5cirWGXIRuixeIkkxJU9r4qe9g6J+4DDng8xBxcGgghqGPgddI1jiXtcMLaAoNBcm8gBuwHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d6souiOr; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a24c134-d4d3-20c5-45f5-4dfa961fbd73@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723772777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ubBqo0+oVYYTlRHIRRVTjqnnYWsbbJ40qKYuFY4AbQ=;
	b=d6souiOrH1xBojrfZW60RcPGoY6M1f43dWlF7lteE2CM4MC8/BtBR63kIJrPm5lvc0MnTn
	TCk+W8Ozi0vVLSRPsnPE5MlKvW8U7eXkwZP4ShyTBRx5dauS8v2PyDs8QOCnnqDl2Z5OxQ
	J230cDhC4jBDYMzgwOfbMoObOcN1ukM=
Date: Fri, 16 Aug 2024 09:45:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/slub: Add check for s->flags in the
 alloc_tagging_slab_free_hook
To: Suren Baghdasaryan <surenb@google.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, kees@kernel.org,
 kent.overstreet@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20240815072113.30288-1-hao.ge@linux.dev>
 <CAJuCfpF5v397w9+532bQzPonXzAbBwVVvuXFw3z46q0R1E7Rug@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpF5v397w9+532bQzPonXzAbBwVVvuXFw3z46q0R1E7Rug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Suren


Thank you for taking the time to review this patch.


On 8/16/24 05:00, Suren Baghdasaryan wrote:
> On Thu, Aug 15, 2024 at 12:21 AM Hao Ge <hao.ge@linux.dev> wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> When enable CONFIG_MEMCG & CONFIG_KFENCE & CONFIG_KMEMLEAK,
>> the following warning always occurs,This is because the
>> following call stack occurred:
>> mem_pool_alloc
>>      kmem_cache_alloc_noprof
>>          slab_alloc_node
>>              kfence_alloc
>>
>> Once the kfence allocation is successful,slab->obj_exts will not be empty.
>> Since in the prepare_slab_obj_exts_hook function,we perform a check for
>> s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE),the alloc_tag_add function
>> will not be called as a result.Therefore,ref->ct remains NULL.
>>
>> However,when we call mem_pool_free,since obj_ext is not empty,
>> it eventually leads to the alloc_tag_sub scenario being invoked.
>> This is where the warning occurs.
> Ok, I was trying to understand why "Once the kfence allocation is
> successful,slab->obj_exts will not be empty.". alloc_slab_obj_exts()
> has to be called to create slab->obj_exts. Normally that is done in
> prepare_slab_obj_exts_hook() which has the s->flags & (SLAB_NO_OBJ_EXT
> | SLAB_NOLEAKTRACE) check and the cache that kfence_alloc() uses here
> is the object_cache (passed from mem_pool_alloc()) which has
> SLAB_NOLEAKTRACE:
> https://elixir.bootlin.com/linux/v6.11-rc3/source/mm/kmemleak.c#L453.
> Therefore, prepare_slab_obj_exts_hook() should have skipped it and did
> not create the slab->obj_exts. So, it must have been called from
> account_slab() or __memcg_slab_post_alloc_hook() to create
> slab->obj_exts for memcg accounting in slab->obj_exts.objcg. Ok, now I
> understand why you need the CONFIG_MEMCG & CONFIG_KFENCE &
> CONFIG_KMEMLEAK combination.
> Please confirm that slab->obj_exts creation is happening the way I
> described above and for those reasons and if so, please update the
> description of this patch to explain that.

It's mostly correct, but in the context of kfence, the assignment 
actually takes place within the kfence_init_pool function.

https://elixir.bootlin.com/linux/v6.11-rc3/source/mm/kfence/core.c#L606

So in version 2, I have included this explain "because it has already 
been assigned a value in kfence_init_pool."

>> So we should add corresponding checks in the alloc_tagging_slab_free_hook.
>> For __GFP_NO_OBJ_EXT case,I didn't see the specific case where it's
>> using kfence,so I won't add the corresponding check in
>> alloc_tagging_slab_free_hook for now.
>>
>> [    3.734349] ------------[ cut here ]------------
>> [    3.734807] alloc_tag was not set
>> [    3.735129] WARNING: CPU: 4 PID: 40 at ./include/linux/alloc_tag.h:130 kmem_cache_free+0x444/0x574
>> [    3.735866] Modules linked in: autofs4
>> [    3.736211] CPU: 4 UID: 0 PID: 40 Comm: ksoftirqd/4 Tainted: G        W          6.11.0-rc3-dirty #1
>> [    3.736969] Tainted: [W]=WARN
>> [    3.737258] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>> [    3.737875] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    3.738501] pc : kmem_cache_free+0x444/0x574
>> [    3.738951] lr : kmem_cache_free+0x444/0x574
>> [    3.739361] sp : ffff80008357bb60
>> [    3.739693] x29: ffff80008357bb70 x28: 0000000000000000 x27: 0000000000000000
>> [    3.740338] x26: ffff80008207f000 x25: ffff000b2eb2fd60 x24: ffff0000c0005700
>> [    3.740982] x23: ffff8000804229e4 x22: ffff800082080000 x21: ffff800081756000
>> [    3.741630] x20: fffffd7ff8253360 x19: 00000000000000a8 x18: ffffffffffffffff
>> [    3.742274] x17: ffff800ab327f000 x16: ffff800083398000 x15: ffff800081756df0
>> [    3.742919] x14: 0000000000000000 x13: 205d344320202020 x12: 5b5d373038343337
>> [    3.743560] x11: ffff80008357b650 x10: 000000000000005d x9 : 00000000ffffffd0
>> [    3.744231] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008237bad0 x6 : c0000000ffff7fff
>> [    3.744907] x5 : ffff80008237ba78 x4 : ffff8000820bbad0 x3 : 0000000000000001
>> [    3.745580] x2 : 68d66547c09f7800 x1 : 68d66547c09f7800 x0 : 0000000000000000
>> [    3.746255] Call trace:
>> [    3.746530]  kmem_cache_free+0x444/0x574
>> [    3.746931]  mem_pool_free+0x44/0xf4
>> [    3.747306]  free_object_rcu+0xc8/0xdc
>> [    3.747693]  rcu_do_batch+0x234/0x8a4
>> [    3.748075]  rcu_core+0x230/0x3e4
>> [    3.748424]  rcu_core_si+0x14/0x1c
>> [    3.748780]  handle_softirqs+0x134/0x378
>> [    3.749189]  run_ksoftirqd+0x70/0x9c
>> [    3.749560]  smpboot_thread_fn+0x148/0x22c
>> [    3.749978]  kthread+0x10c/0x118
>> [    3.750323]  ret_from_fork+0x10/0x20
>> [    3.750696] ---[ end trace 0000000000000000 ]---
>>
>> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>>   mm/slub.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index c9d8a2497fd6..1f67621ba6dc 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2116,6 +2116,9 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>>          if (!mem_alloc_profiling_enabled())
>>                  return;
>>
>> +       if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
>> +               return;
>> +
> Please add a comment before this check saying something like:
> /* slab->obj_exts might not be NULL if it was created for MEMCG accounting. */
>
> Other than that the fix seems fine to me.
> Thanks,
> Suren.
>
OK,I have already made the modification in version 2.
>>          obj_exts = slab_obj_exts(slab);
>>          if (!obj_exts)
>>                  return;
>> --
>> 2.25.1
>>
Thanks

best regards

Hao


