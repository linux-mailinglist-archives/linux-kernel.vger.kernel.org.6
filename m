Return-Path: <linux-kernel+bounces-249134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EB892E772
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A7B22655
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AD1156F2D;
	Thu, 11 Jul 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTaUHIxg"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885D2904
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698699; cv=none; b=fpoPmDGyUJUO+awA9bOC+EN578T8x1IAgo0DUiCW1PhXpuuW9+0/z0nTBkDE73gLTIsFFbctvh9HZUEv/4Ms2aXEBGEhiGS+ozbOM5igp1QMplF56CFIJ5tOqDtqycNsZ1DGxfeUby9JqwxbjVEHp4iQ3eJNY7gH4srazOLPIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698699; c=relaxed/simple;
	bh=hIGxdsVsxLIgmob+0fE5KxXGXuFHJzLVCg6wQsfjRVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTaDc8RLUz9aqE+t2vVUzvXbbo2gCm6HwbsAEE1Z8xueqtUImoCgKm1EBpn2Gt5UBB/XhxHKFCU5eADpsbfJyA3uAjzpXNyA8LLFcVWWlmHUiV8SUkcRr6RZ5HvvOHoSkifHiOX7UMqzbOuZNRpOh9XB923eN+sYWLUxzbVMNxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTaUHIxg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c96187b3d1so591177a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720698698; x=1721303498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJJrseQEfg3j3LJ1tOzOpDcKnIMoClUQKxX10P83OEY=;
        b=PTaUHIxgUbUMh42t5fCI1ON0pT/W8pEloHox8nqZbaeqiBhBnlQAZNRu7nXQviwge6
         Bn2lM1CnRbNEgPmjQjdMhvX4A6MEL98r/WjZx0xydgc2kEk5zoidakrasWsN5srrQkZY
         bupNa6992grb/vOcXHuxqRk6bMqKt2YwrT9Q50ZsN5pTIB224nX+beH6MvItS43aODoR
         dVV9FeCsM+yPkK5tBPZUZZi/4j/bB4ilYgyxsv2PovwYGino7topIzDbGdbadglO1zVD
         DAPQJnrRYSwL+mwXgVB7DiuYlL+uOgLwbRiBDpH3puB9Dodwl9xJg8qWyfJmcFDTJFV2
         Qc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720698698; x=1721303498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJJrseQEfg3j3LJ1tOzOpDcKnIMoClUQKxX10P83OEY=;
        b=Ttumnhkw6hg0LyEm8HquAHfIKmLbi4GPAOP9SBGbozaS/zttrEniDnaNsBTrdk4NCz
         jjb9JOgLplkpreyo9WPi8oFsznJVrGLGcFuzTl7gt1mmKYHW9tZMjGvT8P/trhLSmjSq
         X8u3rqIjdAOd1TMfCIWL/vqFKbUjggF7dhFlJXoNHKQmWQu9Ze5fvv9kmCw3XvrtInJN
         KhHTl6B8rq16fsOSEjhBnhF4xJ892XSL464r55DLpI4yjoVwbCQlN5ZhWxdcEV3NnG8Q
         LS2cp/mOPekSjdQ7HEJgjaJBmU8N4KcrDmlNYqPZMd1f+nC0k2kyvU9N1px09fwtOZ0b
         jBjA==
X-Forwarded-Encrypted: i=1; AJvYcCXfx38wrxTRR+JPCBjv4kwjoP+1bzRlQL4bMASUfmz7S9i0qNinFyxlo/zEfOB0zdTF9WDUw9HI+Vgw1Hq1CVfM4X5SxQTdZiFlzbbe
X-Gm-Message-State: AOJu0YzaE4iDY7CSXDejW+J3A6mv8pRKv90KLXmoZmBAGP/5Sk8mm1g0
	paLbiY6vHt8CPhuN7p72HrvrMmDg74/A4DAanYsADdtjrC1kaKAx
X-Google-Smtp-Source: AGHT+IEHNNn4a8XKmxXct+hWuMn/VO2hl+aQXm6B1er+w5jDgCHCa7OkH5FnK4dd5BvS+GN1rLzMNA==
X-Received: by 2002:a17:90a:7e0e:b0:2c9:7e9c:9637 with SMTP id 98e67ed59e1d1-2ca35c2a6dcmr6426513a91.13.1720698697629;
        Thu, 11 Jul 2024 04:51:37 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca34e854ddsm5505815a91.25.2024.07.11.04.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 04:51:37 -0700 (PDT)
Message-ID: <a0990d1f-ef25-4eae-98e5-6e65c8643313@gmail.com>
Date: Thu, 11 Jul 2024 19:51:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/memcg: alignment memcg_data define condition
To: Vlastimil Babka <vbabka@suse.cz>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Yoann Congal
 <yoann.congal@smile.fr>, Masahiro Yamada <masahiroy@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Suren Baghdasaryan <surenb@google.com>
References: <20240710054336.190410-1-alexs@kernel.org>
 <42afbce8-7746-438f-ba3a-c997a2c702e5@suse.cz>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <42afbce8-7746-438f-ba3a-c997a2c702e5@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/11/24 4:13 PM, Vlastimil Babka wrote:
> On 7/10/24 7:43 AM, alexs@kernel.org wrote:
>> From: "Alex Shi (Tencent)" <alexs@kernel.org>
>>
>> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
>> extensions") changed the folio/page->memcg_data define condition from
>> MEMCG to SLAB_OBJ_EXT. And selected SLAB_OBJ_EXT for MEMCG, just for
>> SLAB_MATCH(memcg_data, obj_exts), even no other relationship between them.
>>
>> Above action make memcg_data exposed and include SLAB_OBJ_EXT for
>> !MEMCG. That's incorrect in logcial and pay on code size.
>>
>> As Vlastimil Babka suggested, let's add _unused_slab_obj_ext for
>> SLAB_MATCH for slab.obj_exts while !MEMCG. That could resolve the match
>> issue, clean up the feature logical. And decouple the SLAB_OBJ_EXT from
>> MEMCG in next patch.
>>
>> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Yoann Congal <yoann.congal@smile.fr>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Petr Mladek <pmladek@suse.com>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> ---
>> v1->v3: take Vlastimil's suggestion and move SLAB_OBJ_EXT/MEMCG decouple
>> to 2nd patch.
>> ---
>>  include/linux/mm_types.h | 8 ++++++--
>>  mm/slab.h                | 4 ++++
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index ef09c4eef6d3..4ac3abc673d3 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -180,8 +180,10 @@ struct page {
>>  	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
>>  	atomic_t _refcount;
>>  
>> -#ifdef CONFIG_SLAB_OBJ_EXT
>> +#ifdef CONFIG_MEMCG
>>  	unsigned long memcg_data;
>> +#elif defined(CONFIG_SLAB_OBJ_EXT)
>> +	unsigned long _unused_slab_obj_ext;
>>  #endif
>>  
>>  	/*
>> @@ -343,8 +345,10 @@ struct folio {
>>  			};
>>  			atomic_t _mapcount;
>>  			atomic_t _refcount;
>> -#ifdef CONFIG_SLAB_OBJ_EXT
>> +#ifdef CONFIG_MEMCG
>>  			unsigned long memcg_data;
>> +#elif defined(CONFIG_SLAB_OBJ_EXT)
>> +			unsigned long _unused_slab_obj_ext;
>>  #endif
>>  #if defined(WANT_PAGE_VIRTUAL)
>>  			void *virtual;
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 3586e6183224..8ffdd4f315f8 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -98,7 +98,11 @@ SLAB_MATCH(flags, __page_flags);
>>  SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
>>  SLAB_MATCH(_refcount, __page_refcount);
>>  #ifdef CONFIG_SLAB_OBJ_EXT
>> +#ifdef CONFIG_MEMCG
>>  SLAB_MATCH(memcg_data, obj_exts);
>> +#else
>> +SLAB_MATCH(_unused_slab_obj_ext, obj_exts);
>> +#endif
>>  #endif
> 
> Why not also #ifdef / #elif like above, instead of this nesting?

Uh, it works too if MEMCG/SLAB_OBJ_EXT decoupled.
but right, it could be written with #ifdef/#elif.

Thanks
Alex
> 
>>  #undef SLAB_MATCH
>>  static_assert(sizeof(struct slab) <= sizeof(struct page));
> 

