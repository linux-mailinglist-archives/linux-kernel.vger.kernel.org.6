Return-Path: <linux-kernel+bounces-250139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4632592F499
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7948D2846AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F012B63;
	Fri, 12 Jul 2024 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2UGuxpz"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52F10979
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720758111; cv=none; b=GyY/ickR+8euL4PbS5A97yWh4+fjDR2SDBHq24enNGI+u7Zep95f7myEQzKd6+6xJE2QjwBji4dh7KxcqOGwmoHP8eJOfxnj0SI+4gJRLFt33ge47YdtXLkbVGfmmR7QpB5g21M/I9An56kaLmjmd/bxNw91xiW674IPI6gsHN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720758111; c=relaxed/simple;
	bh=REfpCaDkLhPXU5uJQEJr5/Ju2IHI6yByQC5OEK48f5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDyc96AuC/EluAdA5X58tfGM90TKXP6ruFZnCv1zuXfmGfeEmuiEuMvt/4ja2oJIbR8uIR39X6+3PM4PCss7G6k+vnZBMTtnjq8PuKz135gxPAk4Mk3nlVSpDseVtrhxqLevVtf7hgaDS5FV2fpFxV4yaNY2eALOstOflBIghhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2UGuxpz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so1090989b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720758109; x=1721362909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bBLxjaqNYm/aQaWvWvN6K2lxER4ZUjX7/wDViAyzH0=;
        b=a2UGuxpzg4Ti2C07zYIMU43wgjIYpALRlvJ4mS525QpmSfJUxhqDbE7VgzHzhDbij2
         znf0avtt8L3BI6pzgBTzkVYpbwxeZ2aOPkUnyzweajdMn7LXRxc8EkdXx7SQyRMOj4hl
         0BCW6g8wXUq1avesDbA/h/dHrrDQPgjDIDOu+OBW4smqoeanu5x7KwY6lRlIo/rH7DQ9
         hjTs5S017xEz0UzCkdv3xxF3s8HhUhvCtwz6QSk4TAod3rYNiYww9bknsu5xO2BNPrH4
         c9U5cT++0ez4V6ZmRZOX5C1bC0D45bD7/ye0gZF6s5i4eIp7TZgvLuXmzrW8oYdY+7M+
         EqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720758109; x=1721362909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bBLxjaqNYm/aQaWvWvN6K2lxER4ZUjX7/wDViAyzH0=;
        b=gfLG8x8RLp+5wllpUxKEjec1Fo38HN7sNuXsnIRCo2t2SL+xO5JKAgGDHfzSvsCIDS
         jezXAznaXS9kSD+cyI3i3jA5bDcvfh6ktg0cSOupgJTz2gl7nbVXuAARwU/PhgEMiPko
         LlrWQeqLO700fZXLsGL41evhRBp3pVbIQZW1r5D22fXpJDL7SmcwH8YWxRuHbqi1sEU6
         Ek89Iq/5hi0tBRUHiGInB/IGEcl/wuyD1Uhz6fjsdLza92WHMjwKCoDE9brIeqbxfQza
         sb7K5BGBkQwY3CAIUUVrm1AToO1HG/4pqxWLzuS+3w3mqNY1hC3TWcX9ed5qZ1wkBgb8
         iwdw==
X-Forwarded-Encrypted: i=1; AJvYcCWV5i3tYNZSNU5zCz1hXJODd3/XwX8BrmsLaTZS1MV4DDp7DuNYa8Qfinj7GAoQGasowRuREmnuNmJ9wy2Y97E8cO7EZn360FtsDyt8
X-Gm-Message-State: AOJu0YzrbMXCKVeSCAXKOsDR1pDOD7wR+pIjhylKm1oqC0Y9UDFB/q6l
	03P4xr1pAurX2ZENe2748+6Upem6n+rE8aWKEu9ddNX4+L4I0vwU
X-Google-Smtp-Source: AGHT+IG5/dVmgjHUAUbfksEHuRudvz+2wssKf3QfELdS2lWraGP8RWFqGnn7PciJazFufV7eILtAeg==
X-Received: by 2002:a05:6a00:188b:b0:706:5daf:efa5 with SMTP id d2e1a72fcca58-70b6c8b4bdemr3288344b3a.9.1720758108940;
        Thu, 11 Jul 2024 21:21:48 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43968688sm6465867b3a.114.2024.07.11.21.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 21:21:48 -0700 (PDT)
Message-ID: <059634b2-7346-4072-b5c2-5b1180bae694@gmail.com>
Date: Fri, 12 Jul 2024 12:21:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REF PATCH v3 2/2] mm/slab: decouple the SLAB_OBJ_EXT from MEMCG
To: Suren Baghdasaryan <surenb@google.com>, roman.gushchin@linux.dev
Cc: Vlastimil Babka <vbabka@suse.cz>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Yoann Congal <yoann.congal@smile.fr>, Masahiro Yamada
 <masahiroy@kernel.org>, Petr Mladek <pmladek@suse.com>
References: <20240710054336.190410-1-alexs@kernel.org>
 <20240710054336.190410-2-alexs@kernel.org>
 <d6bfed41-4c2b-4855-bcb4-522079f19bf4@suse.cz>
 <9b1384e7-e75d-4d71-8798-0d47c33cece6@gmail.com>
 <CAJuCfpEJKLi2kzwWxdDCfSHu0gtRtLAkUrovtUpBwQhftbF+1w@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAJuCfpEJKLi2kzwWxdDCfSHu0gtRtLAkUrovtUpBwQhftbF+1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/11/24 9:55 PM, Suren Baghdasaryan wrote:
> On Thu, Jul 11, 2024 at 4:49 AM Alex Shi <seakeel@gmail.com> wrote:
>>
>>
>>
>> On 7/11/24 4:11 PM, Vlastimil Babka wrote:
>>> On 7/10/24 7:43 AM, alexs@kernel.org wrote:
>>>> From: "Alex Shi (Tencent)" <alexs@kernel.org>
>>>>
>>>> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
>>>> extensions") selected SLAB_OBJ_EXT on MEMCG just for SLAB_MATCH
>>>> memcg_data, that included SLAB_OBJ_EXT for MEMCG. In fact, I didn't see
>>>> the necessary to enable SLAB_OBJ_EXT for MEMCG.
>>>>
>>>> Let's decouple the SLAB_OBJ_EXT from MEMCG and move out
>>>> alloc_slab_obj_exts() definition from SLAB_OBJ_EXT only. To alignment
>>>> the alloc_slab_obj_exts() return 0 for good. change its return value to
>>>> '-1' for always failed with !SLAB_OBJ_EXT. Now we could save unnecessary
>>>> code from MEMCG but !SLAB_OBJ_EXT.
>>>>
>>>> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
>>>
>>> This seems just wrong to me. The memcg hooks for slab do use obj_ext. You
>>> made alloc_slab_obj_exts() return -1 and that will just fail all memcg
>>> charging (unless alloc profiling selects obj_ext). The kernel will appear to
>>> work, but memcg charging for slab won't happen at all.
>>>
>>> So no, it can't be decoupled for slab, only for pages/folios (patch 1).
>>
>> Hi Vlastimil,
>>
>> Thanks a lot for clarification! Yes, the patch isn't correct.
>>
>> Just forgive my stupidity, why the memcg needs SLAB_OBJ_EXT?
> 
> Because when CONFIG_MEMCG_KMEM=y, slabobj_ext contains obj_cgroup
> (see: https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/memcontrol.h#L1593)

Thanks for comments. 
Yes, if the obj_cg is sth we must have in MEMCG, then MEMCG should take OBJ_EXT.

> and that's used for memcg accounting. Look into this call chain:
> 
> kfree
>   slab_free
>     memcg_slab_free_hook
>       __memcg_slab_free_hook
>         obj_cgroup_uncharge> 
>>
>> And why we need to alloc_slab_obj_exts() at line 3019 with !slab_obj_exts?

I checked the history of slab for this part. It introduced
from commit 10befea91b61c ("mm: memcg/slab: use a single set of kmem_caches for all allocations")
But still don't know why !page_has_obj_cgroups followed by memcg_alloc_page_obj_cgroups. Anyone like
to give a hints?

                        page = virt_to_head_page(p[i]);
+
+                       if (!page_has_obj_cgroups(page) &&
+                           memcg_alloc_page_obj_cgroups(page, s, flags)) {
+                               obj_cgroup_uncharge(objcg, obj_full_size(s));
+                               continue;
+                       }

Thanks a lot
Alex


>> 3015         for (i = 0; i < size; i++) {
>> 3016                 slab = virt_to_slab(p[i]);
>> 3017
>> 3018                 if (!slab_obj_exts(slab) &&
>> 3019                     alloc_slab_obj_exts(slab, s, flags, false)) {
>> 3020                         obj_cgroup_uncharge(objcg, obj_full_size(s));
>> 3021                         continue;
>> 3022                 }
>>
>> Thanks!
>> Alex
>>
>>>
>>>
>>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: Yoann Congal <yoann.congal@smile.fr>
>>>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>>>> Cc: Petr Mladek <pmladek@suse.com>
>>>> ---
>>>>  init/Kconfig | 1 -
>>>>  mm/slab.h    | 6 +++---
>>>>  mm/slub.c    | 6 +++---
>>>>  3 files changed, 6 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/init/Kconfig b/init/Kconfig
>>>> index 26bf8bb0a7ce..61e43ac9fe75 100644
>>>> --- a/init/Kconfig
>>>> +++ b/init/Kconfig
>>>> @@ -965,7 +965,6 @@ config MEMCG
>>>>      bool "Memory controller"
>>>>      select PAGE_COUNTER
>>>>      select EVENTFD
>>>> -    select SLAB_OBJ_EXT
>>>>      help
>>>>        Provides control over the memory footprint of tasks in a cgroup.
>>>>
>>>> diff --git a/mm/slab.h b/mm/slab.h
>>>> index 8ffdd4f315f8..6c727ecc1068 100644
>>>> --- a/mm/slab.h
>>>> +++ b/mm/slab.h
>>>> @@ -559,9 +559,6 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>>>>      return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
>>>>  }
>>>>
>>>> -int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>> -                        gfp_t gfp, bool new_slab);
>>>> -
>>>>  #else /* CONFIG_SLAB_OBJ_EXT */
>>>>
>>>>  static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>>>> @@ -571,6 +568,9 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>>>>
>>>>  #endif /* CONFIG_SLAB_OBJ_EXT */
>>>>
>>>> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>> +                    gfp_t gfp, bool new_slab);
>>>> +
>>>>  static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>>>>  {
>>>>      return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index cc11f3869cc6..f531c2d67238 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -2075,10 +2075,10 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>>>>
>>>>  #else /* CONFIG_SLAB_OBJ_EXT */
>>>>
>>>> -static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>> -                           gfp_t gfp, bool new_slab)
>>>> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>> +                    gfp_t gfp, bool new_slab)
>>>>  {
>>>> -    return 0;
>>>> +    return -1;
>>>>  }
>>>>
>>>>  static inline void free_slab_obj_exts(struct slab *slab)
>>>

