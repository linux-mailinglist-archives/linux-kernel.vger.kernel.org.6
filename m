Return-Path: <linux-kernel+bounces-247068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D092CA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E401C22B65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3716214D;
	Wed, 10 Jul 2024 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJr6rOrF"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E354FAD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591996; cv=none; b=Sq2URUjGqiT9hEL1fO80oSrCjIqsduOBDBYKOTo6wwlyTyPNFnwlxF3q8gNtbCyUwHyDesFUnS1xUEgKRooOJDZCCY+FkaLNVX81TNNgB7C1K56T1As6k2iJrq8xl1sNXQSM4XVqr8YdAnCrXWZpDnGbmUHC1zQR71wsoqycsLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591996; c=relaxed/simple;
	bh=t2YmLJcKXuKHVE4cUGVIQxRTwTa8NxInHPL+cV0H+Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJkqdlDeAPDau+/SDEwTTznHi+iVeBLRk2JAg+fdXZmPiMwr0Riak6V3JrS20kXG/LwMv394cwuRyb2RfOYZTzy+CE+sWD0q/zJjFbgyd2TVoEKR42wfpBqtVJvGuXMP0gQO40CXKXukmAXXfgGEZGuk4XLZvnnatNfLVvdjpqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJr6rOrF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb472eacf4so25515375ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720591994; x=1721196794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fliPFUQMMU4ESDuf3cphReytLRzzabwtKhkiu8ItoPc=;
        b=hJr6rOrFN/kxWlElBj1+BvfqJFbQ1v0pu2AeQ2uxHvm/VGBXh+QJKf975/t4eRsOey
         dTVAaoIW4axwkrwEn2r8yJ1UJBBYLFB70RUeP1Qlx2N2Zs9x0yFxUjZ/xl3cNnkFewLD
         NYJuxcRg8yV009fcH5j7SIbfAwHoF1BwhNv1Ek9zP3O3zupf9Veez4qZ3HHltFnNF24c
         DLtkKPrm+Jdq+xE2UDV2Yr7nkwfZWlUjMoR4mrFk+HvclfdmjvJfXsOkj6O/FUma/WlA
         Qs+ldJdapbKvjZS2XvQpC4TU9Wp8ytSu29vUZ8jQtE3WwnkvgRy58q2OhegGAknpnrVO
         w7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720591994; x=1721196794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fliPFUQMMU4ESDuf3cphReytLRzzabwtKhkiu8ItoPc=;
        b=LFbRn3r13syfgJm0WtUjp82QE5G3lKUDOgcY1CIcGIHfaQHK6KdvuUsNkibc0J8T3F
         81o/TcQmcAh2zYzv50ghhaP21yFjYhFK01wp7bWHpVOLjanneHzqhG2F0hp7Jwcy8Mf+
         wPGhOZgN3jvt4UzUt7F21cRniqEqmvn0g39ywj/NzaQIjf1urJ7xmrTHlEPPg2ARKtTc
         CSdIFk4n/469vVxXVY/rVvHiwdLjmdM+xKg2LOJcRTl1d/aC6rlaww3mf0KOohO4EAIt
         Hdf7Mk/xgtJnu/9yXcZQ6t42u1Cx8joZgFaoeki7JvCe0XdCVbkUnAwxfrpfEFcSiEIJ
         Ek+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw6XuDVuSZEKN2Lad+doPC8Hf5tUpZKQmaN41Wy5iGVaeDWTa7UJgfip8DXx2wHUJz8AJ8uskjjyEWyWHvvXavoIT3Z8kGUdlWVosI
X-Gm-Message-State: AOJu0Yz3foI7d1nbbjm173xRkDyHPbr5powKjvjjgMaYs4FIuWi3Cw/U
	+uPcbUy0jDmuIbbfrGdR76zrYBFQRGUgYKwPEc2wPdzheBDUrpjnHnTiA1JB
X-Google-Smtp-Source: AGHT+IF5ZY20tyWZvgef75ebwxVj/BmkeBDWG0TgcW31wLtjJTjLgexT/SR6pPhC/4cR5UurXotAJg==
X-Received: by 2002:a17:902:da90:b0:1f4:977e:bf with SMTP id d9443c01a7336-1fbb6d3d348mr45905515ad.19.1720591993951;
        Tue, 09 Jul 2024 23:13:13 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7980sm25804405ad.177.2024.07.09.23.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 23:13:13 -0700 (PDT)
Message-ID: <f0959ae0-64a1-496e-811f-5412d497c9e2@gmail.com>
Date: Wed, 10 Jul 2024 14:13:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REF PATCH v3 2/2] mm/slab: decouple the SLAB_OBJ_EXT from MEMCG
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Yoann Congal
 <yoann.congal@smile.fr>, Masahiro Yamada <masahiroy@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Suren Baghdasaryan <surenb@google.com>
References: <20240710054336.190410-1-alexs@kernel.org>
 <20240710054336.190410-2-alexs@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240710054336.190410-2-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/24 1:43 PM, alexs@kernel.org wrote:
> From: "Alex Shi (Tencent)" <alexs@kernel.org>
> 
> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
> extensions") selected SLAB_OBJ_EXT on MEMCG just for SLAB_MATCH
> memcg_data, that included SLAB_OBJ_EXT for MEMCG. In fact, I didn't see
> the necessary to enable SLAB_OBJ_EXT for SLAB_OBJ_EXT.
> 
> Let's decouple the SLAB_OBJ_EXT from MEMCG and move out
> alloc_slab_obj_exts() definition from SLAB_OBJ_EXT only. To alignment
> the alloc_slab_obj_exts() return 0 for good. change its return value to
> '-1' for always failed with !SLAB_OBJ_EXT. Now we could save unnecessary
> code from MEMCG but !SLAB_OBJ_EXT.

remove SLAB_OBJ_EXT from MEMCG, it introduce a new path in 
__memcg_slab_post_alloc_hook()

        for (i = 0; i < size; i++) {
                slab = virt_to_slab(p[i]);

                if (!slab_obj_exts(slab) &&
>>>                 alloc_slab_obj_exts(slab, s, flags, false)) {
                        obj_cgroup_uncharge(objcg, obj_full_size(s));
                        continue;
                }

Here alloc_slab_obj_exts() return 0 for good, that lead to 
"slab_obj_exts(slab)[off].objcg = objcg;" failed on !SLAB_OBJ_EXT.

so change the return value could fix this. and its the only new path
for this function.
Another usage of alloc_slab_obj_exts() in prepare_slab_obj_exts_hook() doesn't
exist on !SLAB_OBJ_EXT.

Thanks
Alex
> 
> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoann Congal <yoann.congal@smile.fr>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  init/Kconfig | 1 -
>  mm/slab.h    | 6 +++---
>  mm/slub.c    | 6 +++---
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 26bf8bb0a7ce..61e43ac9fe75 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -965,7 +965,6 @@ config MEMCG
>  	bool "Memory controller"
>  	select PAGE_COUNTER
>  	select EVENTFD
> -	select SLAB_OBJ_EXT
>  	help
>  	  Provides control over the memory footprint of tasks in a cgroup.
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index 8ffdd4f315f8..6c727ecc1068 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -559,9 +559,6 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>  	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
>  }
>  
> -int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> -                        gfp_t gfp, bool new_slab);
> -
>  #else /* CONFIG_SLAB_OBJ_EXT */
>  
>  static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> @@ -571,6 +568,9 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>  
>  #endif /* CONFIG_SLAB_OBJ_EXT */
>  
> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> +			gfp_t gfp, bool new_slab);
> +
>  static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>  {
>  	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> diff --git a/mm/slub.c b/mm/slub.c
> index cc11f3869cc6..f531c2d67238 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2075,10 +2075,10 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  
>  #else /* CONFIG_SLAB_OBJ_EXT */
>  
> -static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> -			       gfp_t gfp, bool new_slab)
> +int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> +			gfp_t gfp, bool new_slab)
>  {
> -	return 0;
> +	return -1;
>  }
>  
>  static inline void free_slab_obj_exts(struct slab *slab)

