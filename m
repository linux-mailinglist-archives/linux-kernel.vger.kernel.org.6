Return-Path: <linux-kernel+bounces-249132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2792E76D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B172850F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111C9156993;
	Thu, 11 Jul 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwdZAoOC"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E22904
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698563; cv=none; b=J/rTRGFj544bZGQcG3PTV3/+ctw3JR0IWkOa2c/8l82f0UMMzMjAvyHyyD0cRvoZDXcu0Hpz7nX7gWypchmg/bF2vuYDH0FqcZfYKlxlUy7VDEG3RrD3FjwIS1R6+Q2G9WuIFWidel97296gl6hkRCehKo+dZ5QOtijZ97GuPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698563; c=relaxed/simple;
	bh=kJ04uJKAsfNBoIKGSgIeLa7ZTYxHEW/mRlKd40dv/Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9FjmK9kb9gYkrfTGfPsC8S/nPVEGurQKHmTcadreC8E+TJDz2cXKFr8AO/k2BTKTVnBgvElmjV/K+11PVfE2NA4SAsp7Bq1sn5aby6p6wBbU5TGvREi+GlkSIW9zM/3CFNNmrEWqfxq/gMg0ZLIsQw/FDzqtX3SiWYR9IdsqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwdZAoOC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso609564a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720698561; x=1721303361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhrnFdpHWaOjgqMVTujlKURrsv1IKQKTP4ulffg2h3M=;
        b=hwdZAoOC8zMzig7DTIxUBcD4pTtUQGm22R61yM4e7aGW4M8/JhepqT8SV26s+XwMOf
         6URDx/VUQsQDqBsQvyKD4If3tRJ33wInj8N3TmX6ObFdily6My1H5dzZsMaKo7vqTyFk
         Mmj31TOD1z/BEmSFMEQ7E8Va+8QSB0AEelMyzrJKkJnLd5MEPDqiWfSfC3zFBF1ifFt7
         92fmiG7BM6BDgfNjDC6CTVUueHzAB1MR+kk1Fu5qwQ1/9vJ6i5G/mpa5e5r4AxvbUhki
         apGfNHXk/s71kafomfaGsIdce59yDwI9eVFYPa+V3F3J2KpczF3LQtoyQgy3TiJ2Mrkf
         rFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720698561; x=1721303361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhrnFdpHWaOjgqMVTujlKURrsv1IKQKTP4ulffg2h3M=;
        b=H+ORK/xNvhhB7ySEpsdRNOVDsP7Bj7kEcYEND1AVyof1Qk0dZCANxqRLnAu6smOros
         vlpfONQHcOhQS7gDBeh8lU5SP1i5bgFHdZW74HIV+QPCfMszaBhgwuLJ6wSWbSgOCFLX
         MSSsNKoN75rVPiNop+OTPrhkmSiCKpGvmzTe8LkdwkKGbJiK3d0w1uD7urUlp5CcgnZI
         4c4dfKyQgJRvvvW2SItum6YbUmKcDHuaAdEjMhVbxkpDUX2Mfltj/odYow+V44IXzj14
         IWNmQzCvN8XqVieIVKBz6L/SBEKgsHVCgX8Jc9tOviRaesa0vC0CB8Q6i+ds9hKV1gsT
         8wDg==
X-Forwarded-Encrypted: i=1; AJvYcCVbRfHmGPHUWTJUXBGFlDSws8sqB9yHF2Ks1kI8lmOeUm1/6Vo/Cx29PHdhTJrvlvwOUKpNEFfS9OM4ozqsQeIyqcHO3098ovjNfRrW
X-Gm-Message-State: AOJu0YxjNvn6Lp2OYRbyH8D4W45pCt1D6sEB/MuVdMiEOzE9EfjTpXQQ
	I2TTzCTp+DDY7LtoxQefaNMxOvzzz09uQUMCFTiL4UMFSD7c6NuE
X-Google-Smtp-Source: AGHT+IF/g+iCJT8gjvG25jUyhrUZH0JrxEIa4asXMTOKU7E3IlhCiusL8Gnrk+EpRxwMbm4GkBA4RQ==
X-Received: by 2002:a17:90a:70c6:b0:2c8:87e:c2d9 with SMTP id 98e67ed59e1d1-2ca35d43887mr6411276a91.39.1720698560783;
        Thu, 11 Jul 2024 04:49:20 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca34e6e9c3sm5518047a91.20.2024.07.11.04.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 04:49:20 -0700 (PDT)
Message-ID: <9b1384e7-e75d-4d71-8798-0d47c33cece6@gmail.com>
Date: Thu, 11 Jul 2024 19:49:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REF PATCH v3 2/2] mm/slab: decouple the SLAB_OBJ_EXT from MEMCG
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
 <20240710054336.190410-2-alexs@kernel.org>
 <d6bfed41-4c2b-4855-bcb4-522079f19bf4@suse.cz>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <d6bfed41-4c2b-4855-bcb4-522079f19bf4@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/11/24 4:11 PM, Vlastimil Babka wrote:
> On 7/10/24 7:43 AM, alexs@kernel.org wrote:
>> From: "Alex Shi (Tencent)" <alexs@kernel.org>
>>
>> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
>> extensions") selected SLAB_OBJ_EXT on MEMCG just for SLAB_MATCH
>> memcg_data, that included SLAB_OBJ_EXT for MEMCG. In fact, I didn't see
>> the necessary to enable SLAB_OBJ_EXT for MEMCG.
>>
>> Let's decouple the SLAB_OBJ_EXT from MEMCG and move out
>> alloc_slab_obj_exts() definition from SLAB_OBJ_EXT only. To alignment
>> the alloc_slab_obj_exts() return 0 for good. change its return value to
>> '-1' for always failed with !SLAB_OBJ_EXT. Now we could save unnecessary
>> code from MEMCG but !SLAB_OBJ_EXT.
>>
>> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
> 
> This seems just wrong to me. The memcg hooks for slab do use obj_ext. You
> made alloc_slab_obj_exts() return -1 and that will just fail all memcg
> charging (unless alloc profiling selects obj_ext). The kernel will appear to
> work, but memcg charging for slab won't happen at all.
> 
> So no, it can't be decoupled for slab, only for pages/folios (patch 1).

Hi Vlastimil,

Thanks a lot for clarification! Yes, the patch isn't correct.

Just forgive my stupidity, why the memcg needs SLAB_OBJ_EXT?

And why we need to alloc_slab_obj_exts() at line 3019 with !slab_obj_exts?
3015         for (i = 0; i < size; i++) {
3016                 slab = virt_to_slab(p[i]);
3017 
3018                 if (!slab_obj_exts(slab) &&
3019                     alloc_slab_obj_exts(slab, s, flags, false)) {
3020                         obj_cgroup_uncharge(objcg, obj_full_size(s));
3021                         continue;
3022                 }  

Thanks!
Alex

> 
> 
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Yoann Congal <yoann.congal@smile.fr>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Petr Mladek <pmladek@suse.com>
>> ---
>>  init/Kconfig | 1 -
>>  mm/slab.h    | 6 +++---
>>  mm/slub.c    | 6 +++---
>>  3 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 26bf8bb0a7ce..61e43ac9fe75 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -965,7 +965,6 @@ config MEMCG
>>  	bool "Memory controller"
>>  	select PAGE_COUNTER
>>  	select EVENTFD
>> -	select SLAB_OBJ_EXT
>>  	help
>>  	  Provides control over the memory footprint of tasks in a cgroup.
>>  
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 8ffdd4f315f8..6c727ecc1068 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -559,9 +559,6 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>>  	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
>>  }
>>  
>> -int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>> -                        gfp_t gfp, bool new_slab);
>> -
>>  #else /* CONFIG_SLAB_OBJ_EXT */
>>  
>>  static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>> @@ -571,6 +568,9 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>>  
>>  #endif /* CONFIG_SLAB_OBJ_EXT */
>>  
>> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>> +			gfp_t gfp, bool new_slab);
>> +
>>  static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>>  {
>>  	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
>> diff --git a/mm/slub.c b/mm/slub.c
>> index cc11f3869cc6..f531c2d67238 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2075,10 +2075,10 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>>  
>>  #else /* CONFIG_SLAB_OBJ_EXT */
>>  
>> -static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>> -			       gfp_t gfp, bool new_slab)
>> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>> +			gfp_t gfp, bool new_slab)
>>  {
>> -	return 0;
>> +	return -1;
>>  }
>>  
>>  static inline void free_slab_obj_exts(struct slab *slab)
> 

