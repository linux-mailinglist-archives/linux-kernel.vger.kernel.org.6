Return-Path: <linux-kernel+bounces-242308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEE9928685
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95392874A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8B513D276;
	Fri,  5 Jul 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZLTGy9v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1764E143C48
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174581; cv=none; b=gKoGGtR5qvXp+dnIxA3Dl56nbISh7gJOJ/pVNpvKmtrVrlo677pfaOidpFB2zds2ahatD5Fyal3/lFPUxufqNIc0Zrnl7eCrtaeLucX71CWSa86/R0eHhogqzqH2RUK91YJRgzPir0WeMKys7uG2LYA74AU49xhGdxcRu2i7TRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174581; c=relaxed/simple;
	bh=jHGNOsJS2+MlOkpIWkssmyx7/+mHWakhaoPwGNhk2f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaesGCzMndMI50aGkpoJ/RqF5ZBE4nBmtq/9zA4Pe6otnLT/aHGeeK6LPWVRQNP9vnhDf1MyZuAEfgBQdCJ0iqbrqSPUAvXmh5FtS8ZTbjyx8UTGyUkJv3+FxcYsGa1BjonYTNBX0p1l/VRK+HerpS9zMiILfvGuaEN5K3rYzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZLTGy9v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720174578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8HhAj3uN2f5wqUuSvzkEv2Tp8Mprq+INTWt2qsAJxvw=;
	b=ZZLTGy9vRnkdox7l7gTc9xg9GLs2/2eeYlysF2w9U0jXPMzF9BlWyzjuW/GfSzTqAGhHYh
	tUGm97CwXpXoOThl9xyUWGqUiLnK900TVPC0jcxMW87lfBYWz7nXKXyaLkAQTd+K+T5210
	SxljGtAgrI/aL7dtbkpZD2fO4u8LzTE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-ZkSTwFKaNQSImpffkgHFCQ-1; Fri, 05 Jul 2024 06:16:17 -0400
X-MC-Unique: ZkSTwFKaNQSImpffkgHFCQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52ea3c7dfdcso969063e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174576; x=1720779376;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8HhAj3uN2f5wqUuSvzkEv2Tp8Mprq+INTWt2qsAJxvw=;
        b=W6H/IQW29V+drbKxcz+GJQiWleebhcPJzdeWQZvgECs8863eXnxwaeyJWEfkSRiiy/
         YWd+rvRk6u0E9voidDIcJl37pqFIxDDBx5X2SML69pubtblfkCQ79LTjIM4tA4uUJVF8
         Zw29f5I+Ie+fcKZYyFchXCpJLqV5GMWhXN7sM1oMR02X94oa6MEfeKuBXsAKQH9djakB
         hhgjnbX9pQswejodBDI4/mHWgd+Cc0O4vPUoBZawhRqqCIGoY31msqsSJEpX5lX5Li/m
         q5fxF/uD3SzyFjiZzo82XjDXzHBhKQ0+tdamJxKLeBWdHKtD7YsIaXOFg6NILLcBBrLh
         OMnA==
X-Forwarded-Encrypted: i=1; AJvYcCX+zMvaPc+X+KHJQNIwJcbEI8ckQike25iH7ZP5Qvie5aJk5QQUTQbPlYHC/RGTEZixacTtha3b4eG6HaZYaZLBgXSWEoa37OhRmx3Y
X-Gm-Message-State: AOJu0YzKm2YGhhNiV/ToRQaesr0pro19tuMu5y7rGemv+4iB4sH1RFoM
	RyR3S9GwJeOIMzFuQMdAIJ+ue3gAB087oL0zdw11/qB1b0NthoLcjwNbIOUMokggaQ5BdySnE7S
	i/7AmXSC8Q2l/yjyIprsuQQJDWtfuXAsBFjgkIDRhC3KqgBDt0IaLXiSUq4Y5xQ==
X-Received: by 2002:a05:6512:312a:b0:52c:ccb4:ec70 with SMTP id 2adb3069b0e04-52ea0632f20mr2856205e87.22.1720174575955;
        Fri, 05 Jul 2024 03:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr7D2FteQNEou0Sxfgna0BKaIEgBVar9F6VuRTAz61Bz68giJVx7Ma1fkOVReOmjhWHDaGqQ==
X-Received: by 2002:a05:6512:312a:b0:52c:ccb4:ec70 with SMTP id 2adb3069b0e04-52ea0632f20mr2856185e87.22.1720174575493;
        Fri, 05 Jul 2024 03:16:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:b500:3ed7:a1c7:447e:2279? (p200300cbc702b5003ed7a1c7447e2279.dip0.t-ipconnect.de. [2003:cb:c702:b500:3ed7:a1c7:447e:2279])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a0593e2asm3250680f8f.15.2024.07.05.03.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 03:16:15 -0700 (PDT)
Message-ID: <1f10c189-73c3-45fd-b249-88884f3dc3a9@redhat.com>
Date: Fri, 5 Jul 2024 12:16:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_pages()
To: Mike Rapoport <rppt@kernel.org>, Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
 mjguzik@gmail.com, tandersen@netflix.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240703005151.28712-1-richard.weiyang@gmail.com>
 <Zoe4XN-gKJnjJtzi@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zoe4XN-gKJnjJtzi@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.07.24 11:09, Mike Rapoport wrote:
> On Wed, Jul 03, 2024 at 12:51:49AM +0000, Wei Yang wrote:
>> Instead of using raw memblock api, we wrap a new helper for user.
> 
> The changelog should be more elaborate and explain why this function is
> needed.
>   
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>   include/linux/memblock.h |  1 +
>>   mm/memblock.c            | 19 +++++++++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 40c62aca36ec..7d1c32b3dc12 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>>   
>>   phys_addr_t memblock_phys_mem_size(void);
>>   phys_addr_t memblock_reserved_size(void);
>> +unsigned long memblock_estimated_nr_pages(void);
>>   phys_addr_t memblock_start_of_DRAM(void);
>>   phys_addr_t memblock_end_of_DRAM(void);
>>   void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index e81fb68f7f88..c1f1aac0459f 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1729,6 +1729,25 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>>   	return memblock.reserved.total_size;
>>   }
>>   
>> +/**
>> + * memblock_estimated_nr_pages - return number of pages from memblock point of
>> + * view
> 
> This function returns the estimate for free pages, not the number of pages
> in RAM.
> 
> How about memblock_estimated_nr_free_pages()?

I was just about to comment exactly that. Agreed!

-- 
Cheers,

David / dhildenb


