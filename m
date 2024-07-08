Return-Path: <linux-kernel+bounces-244004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A620C929DC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26DF41F2305D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14F39AEB;
	Mon,  8 Jul 2024 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epwNJMbl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F412D638
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425391; cv=none; b=Ym8/OJ2qRAs1d6wSaevgPhQQCpToHRmsNXCunpTtzwzFmOAoFZrowWMzUaLz/p9+oZPWQGZy3c5lwtv+boJeLQMaw/gBn0CjdOHd52Qd6AR1xkT0T9Ru22KEIdO89JAzUQCxBeK2BK/xU5J+LbmpOpQ8FjKUxwkYOzCks1YTFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425391; c=relaxed/simple;
	bh=84/fQrEjp3YoqyX3qchL2BRVbadeAft7a99wa/pPDzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVvEP5jasbUeMaCwyRJQgr1qDWCywP4oaWeJJOEYWTKIpaeV0V+1g8iCBjLL/P6lbaFsj4NgUFXqpfnacoMCwLp8Sexrwne5P/dtlYBTZvPjeQmIDao8njVnuXvjCGoqBiKIpXmLmd6FnZpPeJQStHaQJnOIWM8HJXB/vISijCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epwNJMbl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720425388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CMc2ljlt4DMiI4aPglfAN02tbdUjIn7sPq8R8D118xs=;
	b=epwNJMblTEHNSGETXvctudPcleZoaml5w5St/jkd71LsHGuBI+bUwS1aAqdSe3jWZqCZ3E
	XRcJH665PJ/LLM96PUYJf60K0yeJQX0CiveBBytNTpJZ3DZgGTqJrgtQOIX/JhR0MDlCUp
	lG9AAlxYfliGbKZYSbjam9kcpxWpyAE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-o6IDfCiyM6OgfeupvjxcqQ-1; Mon, 08 Jul 2024 03:56:24 -0400
X-MC-Unique: o6IDfCiyM6OgfeupvjxcqQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77bfa15f92so276781866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425383; x=1721030183;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMc2ljlt4DMiI4aPglfAN02tbdUjIn7sPq8R8D118xs=;
        b=mbD+ooVqBMFn4rjKZKaKOQ/PfyYB9bFlk59YEG0kXYLchZT8Gd1XMcgp9gXoc/rywN
         7jUqLs5CUL1m7s9/ws5QlbOc8qoufzNt7lHEVIaYgCi+fFOrK0/mmV/wtI9enrsN2HsZ
         t6JZaNA3BRO1FipkGSFSLsgqqgr3QB/v33/SUnrZQwIYWaaS+T2ikYfqVCxcXZ6SDlYM
         VsPL2aglZNasT3oGmgOI/5DmeDF3Sf/fbJ4DdqWzJYEqm067rD4kZdrv45h01F8q09A+
         2RaXG25Rzvrpo7vebSzefJPVp8nHXJDPOtnsSfHbHS4vpb3+N2oVwvtMzhdBMXKbub27
         ZRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/BXBBBdXFv2AkcY9B9jRMcg/bi2ebhyPwsK6LAUNJyNCX6G9VgfEwLXNuj7VQXLWriehwFlcEIIOrA4HnL6mshMHJN29Va75BS3Z3
X-Gm-Message-State: AOJu0YyIiCQCao1LTfJYYjF5vcwXyyhr3x9P2WdQf0P1gY6faRTzNLb4
	f9yVDYWlU1VHnRaKIDIlgAGUInaOkNub6omulIvw8q+d47OIz1SHsEZfHWL6w7DaBqhDsLX5ps2
	OA0PsN/X/+zd/etUz937I9DVinB758g7r2Al+KDbQdYP72WwHHeIH63sfu2k0RQ==
X-Received: by 2002:a17:906:4556:b0:a77:b8d2:4566 with SMTP id a640c23a62f3a-a77ba72c927mr623126866b.77.1720425383417;
        Mon, 08 Jul 2024 00:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwDhwbAOT2+jYH36rgsrg8H3M7HtgM6YMwgoIpy3dUhj6MLIdOwlXjThJoWDnueuyn7b4vOQ==
X-Received: by 2002:a17:906:4556:b0:a77:b8d2:4566 with SMTP id a640c23a62f3a-a77ba72c927mr623125666b.77.1720425383010;
        Mon, 08 Jul 2024 00:56:23 -0700 (PDT)
Received: from [100.81.188.195] ([178.24.249.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77abd2b5e8sm404843766b.26.2024.07.08.00.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 00:56:22 -0700 (PDT)
Message-ID: <e84fcec1-31bc-4397-851a-da70dd754b19@redhat.com>
Date: Mon, 8 Jul 2024 09:56:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_free_pages()
To: Wei Yang <richard.weiyang@gmail.com>, rppt@kernel.org,
 akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
 mjguzik@gmail.com, tandersen@netflix.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240708010010.32347-1-richard.weiyang@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240708010010.32347-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.24 03:00, Wei Yang wrote:
> During bootup, system may need the number of free pages in the whole system
> to do some calculation before all pages are freed to buddy system. Usually
> this number is get from totalram_pages(). Since we plan to move the free
> pages accounting in __free_pages_core(), this value may not represent
> total free pages at the early stage, especially when
> CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
> 
> Instead of using raw memblock api, let's introduce a new helper for user
> to get the estimated number of free pages from memblock point of view.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: David Hildenbrand <david@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> ---
> v4: adjust comment per david's suggestion
> ---
>   include/linux/memblock.h |  1 +
>   mm/memblock.c            | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 40c62aca36ec..7d1c32b3dc12 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>   
>   phys_addr_t memblock_phys_mem_size(void);
>   phys_addr_t memblock_reserved_size(void);
> +unsigned long memblock_estimated_nr_pages(void);

^ stale name

>   phys_addr_t memblock_start_of_DRAM(void);
>   phys_addr_t memblock_end_of_DRAM(void);
>   void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e81fb68f7f88..26162902789f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1729,6 +1729,26 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>   	return memblock.reserved.total_size;
>   }
>   
> +/**
> + * memblock_estimated_nr_free_pages - return estimated number of free pages
> + * from memblock point of view
> + *
> + * During bootup, subsystems might need a rough estimate of the number of free
> + * pages in the whole system, before precise numbers are available from the
> + * buddy. Especially with CONFIG_DEFERRED_STRUCT_PAGE_INIT, the numbers
> + * obtained from the buddy might be very imprecise during bootup.
> + *
> + * While we can get the estimated number of free pages from memblock, which is
> + * good enough for estimation.

I'd drop that sentence.


Apart form that LGTM

-- 
Cheers,

David / dhildenb


