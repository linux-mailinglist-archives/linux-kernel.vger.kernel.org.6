Return-Path: <linux-kernel+bounces-250288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1992F622
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0571C225A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897FE13CAA3;
	Fri, 12 Jul 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TzHN4FOj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ktejf1MQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TzHN4FOj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ktejf1MQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5652129CF4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769251; cv=none; b=I9Z0mzcvQ+nGXVC0SDlrLl+xBRlPvrjabUsnq33AwOA6pW5xHIq6ia77YL8zdHv7rug09LYqwG0tjgFztYfsAtotLfoviumIAm9VDRZAKxBhFwoevh4ZW5C3kCy2Tia+wA0Z9mMXsRFgB1oq2ODcSmW2ru77wGhA/iiKWc5rXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769251; c=relaxed/simple;
	bh=KvNfG3UJg1ExDI20lCPN31V8d/e4QihFnfRvGO6Mjb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7XN9S6RfHuX6lgUnxUJDH1Ifk526lzCVfozfzYYH4YEvbeGgJNrDzFgXKvoCx9fWlCLqUX6B6Mc5CUoKF8UeIDdUJqy1v2zALhujaDmHTsCkTkxowGH0sn1BPyc0WzO+ATrPUuVfQCD3DIJXWETcftXQk/TV9arcSZhdSBzJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TzHN4FOj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ktejf1MQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TzHN4FOj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ktejf1MQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B83021A71;
	Fri, 12 Jul 2024 07:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720769246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DvthTor+YFtVMrev6WjZWdVOY1YPsknUux5qfyinkEA=;
	b=TzHN4FOjZGy6tpzyUkFxVKlBxds5Efz8DtyuJGCypiRe7zdmVUDHArJP+HssHMuZ3ur69J
	28s/kgS4OamtGWNdVMLkbPtgi16wYEscVaFq7+amVnzbwC0zDgRskKwzULVKUdmZHFjUJj
	0jOMls7jS49HFkJRFG43j7ZMnEjUtws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720769246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DvthTor+YFtVMrev6WjZWdVOY1YPsknUux5qfyinkEA=;
	b=ktejf1MQ+P9aLAfCOszEgaW6tRUPOtdrghe2Lj95NMN+jPFpQq6OPRYH2rvG54buqMHlTL
	YZHK214djyZ65VCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TzHN4FOj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ktejf1MQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720769246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DvthTor+YFtVMrev6WjZWdVOY1YPsknUux5qfyinkEA=;
	b=TzHN4FOjZGy6tpzyUkFxVKlBxds5Efz8DtyuJGCypiRe7zdmVUDHArJP+HssHMuZ3ur69J
	28s/kgS4OamtGWNdVMLkbPtgi16wYEscVaFq7+amVnzbwC0zDgRskKwzULVKUdmZHFjUJj
	0jOMls7jS49HFkJRFG43j7ZMnEjUtws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720769246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DvthTor+YFtVMrev6WjZWdVOY1YPsknUux5qfyinkEA=;
	b=ktejf1MQ+P9aLAfCOszEgaW6tRUPOtdrghe2Lj95NMN+jPFpQq6OPRYH2rvG54buqMHlTL
	YZHK214djyZ65VCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06C2C13686;
	Fri, 12 Jul 2024 07:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2wpQAd7akGZkcQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 12 Jul 2024 07:27:26 +0000
Message-ID: <659f204e-de5c-441a-90de-4a7cbfcabe69@suse.cz>
Date: Fri, 12 Jul 2024 09:27:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REF PATCH v3 2/2] mm/slab: decouple the SLAB_OBJ_EXT from MEMCG
Content-Language: en-US
To: Alex Shi <seakeel@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 roman.gushchin@linux.dev
Cc: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Yoann Congal <yoann.congal@smile.fr>, Masahiro Yamada
 <masahiroy@kernel.org>, Petr Mladek <pmladek@suse.com>
References: <20240710054336.190410-1-alexs@kernel.org>
 <20240710054336.190410-2-alexs@kernel.org>
 <d6bfed41-4c2b-4855-bcb4-522079f19bf4@suse.cz>
 <9b1384e7-e75d-4d71-8798-0d47c33cece6@gmail.com>
 <CAJuCfpEJKLi2kzwWxdDCfSHu0gtRtLAkUrovtUpBwQhftbF+1w@mail.gmail.com>
 <059634b2-7346-4072-b5c2-5b1180bae694@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <059634b2-7346-4072-b5c2-5b1180bae694@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B83021A71
X-Spam-Flag: NO
X-Spam-Score: 1.00
X-Spam-Level: *
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.00 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com,google.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.com,google.com,lge.com,gmail.com,kvack.org,vger.kernel.org,infradead.org,smile.fr,suse.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spamd-Bar: +

On 7/12/24 6:21 AM, Alex Shi wrote:
> 
> 
> On 7/11/24 9:55 PM, Suren Baghdasaryan wrote:
>> On Thu, Jul 11, 2024 at 4:49 AM Alex Shi <seakeel@gmail.com> wrote:
>>>
>>>
>>>
>>> On 7/11/24 4:11 PM, Vlastimil Babka wrote:
>>>> On 7/10/24 7:43 AM, alexs@kernel.org wrote:
>>>>> From: "Alex Shi (Tencent)" <alexs@kernel.org>
>>>>>
>>>>> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
>>>>> extensions") selected SLAB_OBJ_EXT on MEMCG just for SLAB_MATCH
>>>>> memcg_data, that included SLAB_OBJ_EXT for MEMCG. In fact, I didn't see
>>>>> the necessary to enable SLAB_OBJ_EXT for MEMCG.
>>>>>
>>>>> Let's decouple the SLAB_OBJ_EXT from MEMCG and move out
>>>>> alloc_slab_obj_exts() definition from SLAB_OBJ_EXT only. To alignment
>>>>> the alloc_slab_obj_exts() return 0 for good. change its return value to
>>>>> '-1' for always failed with !SLAB_OBJ_EXT. Now we could save unnecessary
>>>>> code from MEMCG but !SLAB_OBJ_EXT.
>>>>>
>>>>> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
>>>>
>>>> This seems just wrong to me. The memcg hooks for slab do use obj_ext. You
>>>> made alloc_slab_obj_exts() return -1 and that will just fail all memcg
>>>> charging (unless alloc profiling selects obj_ext). The kernel will appear to
>>>> work, but memcg charging for slab won't happen at all.
>>>>
>>>> So no, it can't be decoupled for slab, only for pages/folios (patch 1).
>>>
>>> Hi Vlastimil,
>>>
>>> Thanks a lot for clarification! Yes, the patch isn't correct.
>>>
>>> Just forgive my stupidity, why the memcg needs SLAB_OBJ_EXT?
>> 
>> Because when CONFIG_MEMCG_KMEM=y, slabobj_ext contains obj_cgroup
>> (see: https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/memcontrol.h#L1593)
> 
> Thanks for comments. 
> Yes, if the obj_cg is sth we must have in MEMCG, then MEMCG should take OBJ_EXT.
> 
>> and that's used for memcg accounting. Look into this call chain:
>> 
>> kfree
>>   slab_free
>>     memcg_slab_free_hook
>>       __memcg_slab_free_hook
>>         obj_cgroup_uncharge> 
>>>
>>> And why we need to alloc_slab_obj_exts() at line 3019 with !slab_obj_exts?
> 
> I checked the history of slab for this part. It introduced
> from commit 10befea91b61c ("mm: memcg/slab: use a single set of kmem_caches for all allocations")
> But still don't know why !page_has_obj_cgroups followed by memcg_alloc_page_obj_cgroups. Anyone like
> to give a hints?
> 
>                         page = virt_to_head_page(p[i]);
> +
> +                       if (!page_has_obj_cgroups(page) &&
> +                           memcg_alloc_page_obj_cgroups(page, s, flags)) {
> +                               obj_cgroup_uncharge(objcg, obj_full_size(s));
> +                               continue;
> +                       }

I'm not sure I understand your question. The code is trying to charge the
allocation to a memcg and use the objext.memcg to associate that memcg to
the object so it can be properly uncharged when freeing.
When it's the first object in the particular slab page to be charged, the
objext may not be yet allocated, so it has has to be allocated at that point.

> Thanks a lot
> Alex
> 
> 
>>> 3015         for (i = 0; i < size; i++) {
>>> 3016                 slab = virt_to_slab(p[i]);
>>> 3017
>>> 3018                 if (!slab_obj_exts(slab) &&
>>> 3019                     alloc_slab_obj_exts(slab, s, flags, false)) {
>>> 3020                         obj_cgroup_uncharge(objcg, obj_full_size(s));
>>> 3021                         continue;
>>> 3022                 }
>>>
>>> Thanks!
>>> Alex
>>>
>>>>
>>>>
>>>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>>>> Cc: Yoann Congal <yoann.congal@smile.fr>
>>>>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>>>>> Cc: Petr Mladek <pmladek@suse.com>
>>>>> ---
>>>>>  init/Kconfig | 1 -
>>>>>  mm/slab.h    | 6 +++---
>>>>>  mm/slub.c    | 6 +++---
>>>>>  3 files changed, 6 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/init/Kconfig b/init/Kconfig
>>>>> index 26bf8bb0a7ce..61e43ac9fe75 100644
>>>>> --- a/init/Kconfig
>>>>> +++ b/init/Kconfig
>>>>> @@ -965,7 +965,6 @@ config MEMCG
>>>>>      bool "Memory controller"
>>>>>      select PAGE_COUNTER
>>>>>      select EVENTFD
>>>>> -    select SLAB_OBJ_EXT
>>>>>      help
>>>>>        Provides control over the memory footprint of tasks in a cgroup.
>>>>>
>>>>> diff --git a/mm/slab.h b/mm/slab.h
>>>>> index 8ffdd4f315f8..6c727ecc1068 100644
>>>>> --- a/mm/slab.h
>>>>> +++ b/mm/slab.h
>>>>> @@ -559,9 +559,6 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>>>>>      return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
>>>>>  }
>>>>>
>>>>> -int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>>> -                        gfp_t gfp, bool new_slab);
>>>>> -
>>>>>  #else /* CONFIG_SLAB_OBJ_EXT */
>>>>>
>>>>>  static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>>>>> @@ -571,6 +568,9 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>>>>>
>>>>>  #endif /* CONFIG_SLAB_OBJ_EXT */
>>>>>
>>>>> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>>> +                    gfp_t gfp, bool new_slab);
>>>>> +
>>>>>  static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>>>>>  {
>>>>>      return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
>>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>>> index cc11f3869cc6..f531c2d67238 100644
>>>>> --- a/mm/slub.c
>>>>> +++ b/mm/slub.c
>>>>> @@ -2075,10 +2075,10 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>>>>>
>>>>>  #else /* CONFIG_SLAB_OBJ_EXT */
>>>>>
>>>>> -static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>>> -                           gfp_t gfp, bool new_slab)
>>>>> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>>> +                    gfp_t gfp, bool new_slab)
>>>>>  {
>>>>> -    return 0;
>>>>> +    return -1;
>>>>>  }
>>>>>
>>>>>  static inline void free_slab_obj_exts(struct slab *slab)
>>>>


