Return-Path: <linux-kernel+bounces-246867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E031E92C829
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C77F1C21E28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29A48BE7;
	Wed, 10 Jul 2024 01:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUDmWOij"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAC6FBF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576722; cv=none; b=YMi/lwPoF2H8ZIk62FRbqUuiEJmH2GOP3mJrN+I1sWizXmN4d7KqFFuZ/YkvLm5fDnXCXyDGrnXl2U2/4WxCjx7Ssw1I6kHqHPqpnJ7qSnj6zc2HvYXFKHLtHKZ/WnYmmsit0ShL3RKOJGbqs9+zxipHB0jRxlS+othnDYtStX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576722; c=relaxed/simple;
	bh=zi8GPGWth1dgFrAIbiblFUOYLJgkhFgm6y9AqqK6s4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GO34PJXpprqYhOUKb/x3U0AasWRk1vIF4jMITEAiW2ySNcOzzvfuLglEREjIFA9cM30+BkuVWIR15E9OsQaWIJnPNCdec+e2U/sdchk1niaPK5yOx4pNUiMOf9wrLY8dm/sfMp5+i3QizyAEjdGA2vr6M0kCPdjOr8vGSwku910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUDmWOij; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e31d0a753so2455936fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 18:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720576720; x=1721181520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJGXsAK2YOtUbQ/sbrNck5vDbgsCGN7XuLcNE719NQI=;
        b=hUDmWOijwZDmmH8D/SjThg8LBmPwpR+g0OQMXnLVxoIEv7k7/4zQV/MJvGJfjnl+2s
         H97ttbK10JU7feitiNiNhlkVSZf2Zi2PmGf0div70CVSNNybCYFHpII1hPVdjbZJoNS6
         W/khcjWjTljoPUhVpVGvb79yJf4GgiK8UAZr4dWNS2R87fRRi/iD4ZRZqUj/aRAAT2/L
         9JHc2JupoZHjMtCvTmC2D09HsrAP8YBSb6zSuyaSne8+V0yy3QzOcwHqvqNivJX3IFxb
         MBgdcpsGUr6U0hI/Jw3O3kFcuykolk5B+5EhNZj++WdcCcUeDpvx6fmUDuyruhzYO+Xw
         kEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720576720; x=1721181520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJGXsAK2YOtUbQ/sbrNck5vDbgsCGN7XuLcNE719NQI=;
        b=CSxYBxgw54r9Jxut5HIh3UKVFyD1Lb8EGivqWhO+BrAvrV5o3oghVw8uMGu6zzBOEI
         QoMkipC5UZkQ8hYTXqFuq1F9P8Cvn6tR1CDz6+caG1ij8F5MTFCcet+/s7JWRQviWfru
         q+SZ6CHhGZXm4MXo/GF7qYysrnlOVyd7AWOdUjgnIdP16i06ICOOmgJ+tfOrpYR4QsZw
         Q1lFvJ1idP3bIxmCkzl4qhIT9ftGlqNv09abJIkKlQbHgXRy9rTj13Edh0h2kSzJDAz7
         nYxoXL7nR6wagLIlAo1w3AuKsENJTlewFhrdt/Lyprda61rST9jI/W69/Yang9/TDlkh
         M5UA==
X-Forwarded-Encrypted: i=1; AJvYcCUZWKSrwf2xTvZPblD5KYnIvKNEuLeL3Xr7n6zTUNmVdPUKMynGiXEVpKdVRU7aFEyc3w1c0vDW6Ozlqnqt1LNfXsw/ZMDCeI1SH8c0
X-Gm-Message-State: AOJu0YygAxbS1FT5fa81tKwg28+SeE7AU5/ZLJXh1vo2ldbnirYiB2tg
	axgqetfr/+U2PN7dtMtKfoA+g+JCnABAG8vxDoC6L0iQpBvmUkSz
X-Google-Smtp-Source: AGHT+IHlQY7Syqv+iiphtLLigmfPCTS/oM4wNHOH61Rsv17bdhgbPglQfSrzmn5AqOMMj1ShLFljiA==
X-Received: by 2002:a05:6870:c34c:b0:254:96ec:bc44 with SMTP id 586e51a60fabf-25eae88a6d3mr3166772fac.28.1720576719665;
        Tue, 09 Jul 2024 18:58:39 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967443sm2498915b3a.113.2024.07.09.18.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 18:58:39 -0700 (PDT)
Message-ID: <3e034d0e-5cb5-46ef-b091-9ea0b632e373@gmail.com>
Date: Wed, 10 Jul 2024 09:58:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memcg: alignment memcg_data define condition
To: alexs@kernel.org, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Yoann Congal <yoann.congal@smile.fr>,
 Suren Baghdasaryan <surenb@google.com>
References: <20240710015608.100801-1-alexs@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240710015608.100801-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ops, 
This patch failed with MEMCG && !SLAB_OBJ_EXT, please ignore this patch, I will update ASAP.

Sorry

On 7/10/24 9:56 AM, alexs@kernel.org wrote:
> From: "Alex Shi (Tencent)" <alexs@kernel.org>
> 
> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
> extensions") changed the folio/page->memcg_data define condition from
> MEMCG to SLAB_OBJ_EXT. And selected SLAB_OBJ_EXT for MEMCG, just for
> SLAB_MATCH(memcg_data, obj_exts), even no other relationship between them.
> 
> Above action make memcg_data exposed and include SLAB_OBJ_EXT for
> !MEMCG. That's incorrect in logcial and pay on code size.
> 
> So let's remove SLAB_OBJ_EXT from MEMCG and as Vlastimil Babka suggested,
> add _unused_slab_obj_ext for SLAB_MATCH for slab.obj_exts while !MEMCG.
> That could resolve the match issue, clean up the feature logical and
> save the unnessary code adding.
> 
> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoann Congal <yoann.congal@smile.fr>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/mm_types.h | 8 ++++++--
>  init/Kconfig             | 1 -
>  mm/slab.h                | 4 ++++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index ef09c4eef6d3..4ac3abc673d3 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -180,8 +180,10 @@ struct page {
>  	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
>  	atomic_t _refcount;
>  
> -#ifdef CONFIG_SLAB_OBJ_EXT
> +#ifdef CONFIG_MEMCG
>  	unsigned long memcg_data;
> +#elif defined(CONFIG_SLAB_OBJ_EXT)
> +	unsigned long _unused_slab_obj_ext;
>  #endif
>  
>  	/*
> @@ -343,8 +345,10 @@ struct folio {
>  			};
>  			atomic_t _mapcount;
>  			atomic_t _refcount;
> -#ifdef CONFIG_SLAB_OBJ_EXT
> +#ifdef CONFIG_MEMCG
>  			unsigned long memcg_data;
> +#elif defined(CONFIG_SLAB_OBJ_EXT)
> +			unsigned long _unused_slab_obj_ext;
>  #endif
>  #if defined(WANT_PAGE_VIRTUAL)
>  			void *virtual;
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
> index 3586e6183224..8ffdd4f315f8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -98,7 +98,11 @@ SLAB_MATCH(flags, __page_flags);
>  SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
>  SLAB_MATCH(_refcount, __page_refcount);
>  #ifdef CONFIG_SLAB_OBJ_EXT
> +#ifdef CONFIG_MEMCG
>  SLAB_MATCH(memcg_data, obj_exts);
> +#else
> +SLAB_MATCH(_unused_slab_obj_ext, obj_exts);
> +#endif
>  #endif
>  #undef SLAB_MATCH
>  static_assert(sizeof(struct slab) <= sizeof(struct page));

