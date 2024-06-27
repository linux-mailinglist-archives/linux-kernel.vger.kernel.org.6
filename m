Return-Path: <linux-kernel+bounces-232179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD6391A489
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D40281F15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF299145B34;
	Thu, 27 Jun 2024 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQegCkqV"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9413E40D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486337; cv=none; b=FMFe8gnipgokWzETKuzl+2lgQcLmB55qGsA+Hhl219G5lvNn3BTP/oLPgnPjxkbbi2mFRfpNSxGrgBcrG0SOwvG+C6kWNYspWzLZRA8laMuDtoqZB2djTYVY6/eVjwli4LEwf9ooINVGcYP9whpqJb7/qShqFw0HlVlD8VKv9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486337; c=relaxed/simple;
	bh=t6HMNYsgetPlyxim1FyU13ZaHtyIu+XzuSJOLwbROgU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W55WLOBDTU12DTu3UzyCFQRhcBJwXgJUKKrwFoEQtmL8m2irWuhVxt2539Oy+QQXqS9+SEDSS+NzR8hFqskUMQ6wQrOooxBvHHDYAf2+Gtn90twz7UImRqda8eKYb61bPY2IBhfGMArnGBl4pmIxAwm+PJGxKu87RUYn07P7woc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQegCkqV; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so86116521fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719486333; x=1720091133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OuPCN0p+/jjkvq2AdK3Vr7mCaGV2v3Y7d+UowOaYEYE=;
        b=cQegCkqVeZjSLF0gHe3OlzDYcpVPB3UoJqWtpyWNxNxTizUrYEbLvjKxx0RAYmFRXH
         zAdGdOmpb91U3Wt3GnPs2lLFmCF1IEe7GtTgmvk70S2IL/syuPrXN7iqQN+0hMI4cFi8
         L0K5JJ1qKqXUpEj9vpUzilkDzECuTO5jJrzfPctnDd7n4MQCs7eywAuOB8ioZvIpVkEV
         id5n47kvqmWLa4uEoM831IeNPxHzxJHGFFHaDe1TXeaUtaVBl/ttqdTcB1crLO0tsvRv
         I/UQU8VCCAImLmP/pmDMRPdNSB/usRyAegQjJgw1mzv09Ca2IoB6OyrcqWpWu6sP+tCc
         z44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719486333; x=1720091133;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OuPCN0p+/jjkvq2AdK3Vr7mCaGV2v3Y7d+UowOaYEYE=;
        b=usBA3tna82ng/T03pXo34JCtCVocXN+Vj4nYULFL5xWEwrC91V/cZLJIlnXbM7jH9b
         o+YjwxNJTBLjbW3wnfNBkAh926AHrJqLLQt1RLUbTpUu7dM6V+eU+dGqdgH6p5rJfOhG
         OeSxtGt24pi0oVJzPoBEcz+BX3FIMmVGh9ZmsfPaOYkrz82YGx+IVJUNfCrM4te8MnEI
         LQ5MXzlBd40TnwtfQF7pOoFLtfb34oHeZ+cb3E8Stvb8111R8Dc0J5NpXtEZVgEeQqa2
         Z8sRbX0DAdyXljIDPQ5dDs+kIZGHXbLsTqZH4O0gOpX/qzGqlEEnj2fuJNmFN9iXmEWJ
         3XvA==
X-Forwarded-Encrypted: i=1; AJvYcCWo/mTw9IqtXcAz1odOTlewMbzS9chCUPe9rxdXe+CVaiSK78C2l+YGSGORXXLVrDtyTti/uf9QY0CUQVPS4u+J1KM65Ans2lDarJyj
X-Gm-Message-State: AOJu0YwGSR/Odk9yCKOAGpcwnZkxD66XV7fh1iBIXXkY83Ht9PsMsHmY
	JXdsfm3tfEjnU8cxHKj1Oox8+PfyIzhHW0Ix/T5tCxitWvr4GTif
X-Google-Smtp-Source: AGHT+IGWpicF5CW0nfsyxA6FMihNzXykHpD3P/VlaBPhPnHqccGxX3TRaC1MfI9a7OuvOaoI3J10Dw==
X-Received: by 2002:a2e:8297:0:b0:2ec:174b:75bb with SMTP id 38308e7fff4ca-2ec5b38ad36mr76185751fa.28.1719486332948;
        Thu, 27 Jun 2024 04:05:32 -0700 (PDT)
Received: from ?IPV6:2001:16a2:df29:7e00:184b:b632:a7dc:1c99? ([2001:16a2:df29:7e00:184b:b632:a7dc:1c99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b65637sm21293475e9.12.2024.06.27.04.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 04:05:32 -0700 (PDT)
Message-ID: <159061bc-27b5-4127-a85d-223bed0ddfd5@gmail.com>
Date: Thu, 27 Jun 2024 14:05:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
From: Usama Arif <usamaarif642@gmail.com>
To: Yosry Ahmed <yosryahmed@google.com>, Hugh Dickins <hughd@google.com>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <12fb19d1-3e57-4880-be59-0e83cdc4b7f1@gmail.com>
 <61d19ec8-2ba7-e156-7bb7-f746dae8e120@google.com>
 <5b3e732c-d23d-41ef-ae5c-947fa3e866ab@gmail.com>
 <CAJD7tkYJVa=dd=hwqhJ8_-uzxFDaP6-GcTk3RdG_3DJouJ61AQ@mail.gmail.com>
 <cacd14a9-01fc-4844-9ac6-2e797af13c36@gmail.com>
 <CAJD7tkbYbJHWQtC8+nsyfgS2jq7S5Qyy3-1NJWa4m80VAR9GXA@mail.gmail.com>
 <167b2f11-a013-440f-b196-5d8c0ea5d9b3@gmail.com>
Content-Language: en-US
In-Reply-To: <167b2f11-a013-440f-b196-5d8c0ea5d9b3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/06/2024 21:26, Usama Arif wrote:
>
> On 24/06/2024 20:31, Yosry Ahmed wrote:
>> On Mon, Jun 24, 2024 at 10:26 AM Usama Arif <usamaarif642@gmail.com> 
>> wrote:
>>>
>>> On 24/06/2024 19:56, Yosry Ahmed wrote:
>>>> [..]
>>>>>>> -       p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
>>>>>>> +       p->zeromap = kvzalloc(DIV_ROUND_UP(maxpages, 8), 
>>>>>>> GFP_KERNEL);
>>>>>> No, 8 is not right for 32-bit kernels. I think you want
>>>>>>         p->zeromap = kvzalloc(BITS_TO_LONGS(maxpages), GFP_KERNEL);
>>>>>> but please check it carefully, I'm easily confused by such 
>>>>>> conversions.
>>>>>>
>>>>>> Hugh
>>>>> Ah yes, didnt take into account 32-bit kernel. I think its 
>>>>> supposed to be
>>>>>
>>>>>     p->zeromap = kvzalloc(BITS_TO_LONGS(maxpages) * 
>>>>> sizeof(unsigned long),
>>>>> GFP_KERNEL);
>>>> You can do something similar to bitmap_zalloc() and use:
>>>>
>>>> kvmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), GFP_KERNEL
>>>> | __GFP_ZERO)
>>>>
>>>> I don't see a kvzalloc_array() variant to use directly, but it should
>>>> be trivial to add it. I can see other users of kvmalloc_array() that
>>>> pass in __GFP_ZERO (e.g. fs/ntfs3/bitmap.c).
>>>>
>>>> , or you could take it a step further and add bitmap_kvzalloc(),
>>>> assuming the maintainers are open to that.
>>> Thanks! bitmap_kvzalloc makes most sense to me. It doesnt make sense
>>> that bitmap should only be limited to MAX_PAGE_ORDER size. I can add
>>> this patch below at the start of the series and use it in the patch for
>>> zeropage swap optimization.
>>>
>>>
>>>       bitmap: add support for virtually contiguous bitmap
>>>
>>>       The current bitmap_zalloc API limits the allocation to 
>>> MAX_PAGE_ORDER,
>>>       which prevents larger order bitmap allocations. Introduce
>>>       bitmap_kvzalloc that will allow larger allocations of bitmap.
>>>       kvmalloc_array still attempts to allocate physically 
>>> contiguous memory,
>>>       but upon failure, falls back to non-contiguous (vmalloc) 
>>> allocation.
>>>
>>>       Suggested-by: Yosry Ahmed <yosryahmed@google.com>
>>>       Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>
>> LGTM with a small fix below.
>>
>>> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
>>> index 8c4768c44a01..881c2ff2e834 100644
>>> --- a/include/linux/bitmap.h
>>> +++ b/include/linux/bitmap.h
>>> @@ -131,9 +131,11 @@ struct device;
>>>     */
>>>    unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags);
>>>    unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags);
>>> +unsigned long *bitmap_kvzalloc(unsigned int nbits, gfp_t flags);
>>>    unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, 
>>> int
>>> node);
>>>    unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t 
>>> flags, int
>>> node);
>>>    void bitmap_free(const unsigned long *bitmap);
>>> +void bitmap_kvfree(const unsigned long *bitmap);
>>>
>>>    DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
>>>
>>> diff --git a/lib/bitmap.c b/lib/bitmap.c
>>> index b97692854966..eabbfb85fb45 100644
>>> --- a/lib/bitmap.c
>>> +++ b/lib/bitmap.c
>>> @@ -727,6 +727,13 @@ unsigned long *bitmap_zalloc(unsigned int nbits,
>>> gfp_t flags)
>>>    }
>>>    EXPORT_SYMBOL(bitmap_zalloc);
>>>
>>> +unsigned long *bitmap_kvzalloc(unsigned int nbits, gfp_t flags)
>>> +{
>>> +       return kvmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned 
>>> long),
>>> +                             flags | __GFP_ZERO);
>>> +}
>>> +EXPORT_SYMBOL(bitmap_zalloc);
>> EXPORT_SYMBOL(bitmap_kvzalloc)*
>
>
> Actually, does it make more sense to change the behaviour of the 
> current APIs like below instead of above patch? Or is there an 
> expectation that the current bitmap API is supposed to work only on 
> physically contiguous bits?
>
> I believe in the kernel if the allocation/free starts with 'k' its 
> physically contiguous and with "kv" its physically contiguous if 
> possible, otherwise virtually contiguous. The bitmap functions dont 
> have either, so we could change the current implementation. I believe 
> it would not impact the current users of the functions as the first 
> attempt is physically contiguous which is how it works currently, and 
> only upon failure it would be virtual and it would increase the use of 
> current bitmap API to greater than MAX_PAGE_ORDER size allocations.
>
> Yury Norov and Rasmus Villemoes, any views on this?
>
> Thanks
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 7247e217e21b..ad771dc81afa 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -804,6 +804,7 @@ kvmalloc_array_node_noprof(size_t n, size_t size, 
> gfp_t flags, int node)
>  #define kvcalloc_node_noprof(_n,_s,_f,_node) 
> kvmalloc_array_node_noprof(_n,_s,(_f)|__GFP_ZERO,_node)
>  #define kvcalloc_noprof(...) kvcalloc_node_noprof(__VA_ARGS__, 
> NUMA_NO_NODE)
>
> +#define kvmalloc_array_node(...) 
> alloc_hooks(kvmalloc_array_node_noprof(__VA_ARGS__))
>  #define kvmalloc_array(...) 
> alloc_hooks(kvmalloc_array_noprof(__VA_ARGS__))
>  #define kvcalloc_node(...) 
> alloc_hooks(kvcalloc_node_noprof(__VA_ARGS__))
>  #define kvcalloc(...) alloc_hooks(kvcalloc_noprof(__VA_ARGS__))
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index b97692854966..272164dcbef1 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -716,7 +716,7 @@ void bitmap_fold(unsigned long *dst, const 
> unsigned long *orig,
>
>  unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
>  {
> -       return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long),
> +       return kvmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned 
> long),
>                              flags);
>  }
>  EXPORT_SYMBOL(bitmap_alloc);
> @@ -729,7 +729,7 @@ EXPORT_SYMBOL(bitmap_zalloc);
>
>  unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int 
> node)
>  {
> -       return kmalloc_array_node(BITS_TO_LONGS(nbits), 
> sizeof(unsigned long),
> +       return kvmalloc_array_node(BITS_TO_LONGS(nbits), 
> sizeof(unsigned long),
>                                   flags, node);
>  }
>  EXPORT_SYMBOL(bitmap_alloc_node);
> @@ -742,7 +742,7 @@ EXPORT_SYMBOL(bitmap_zalloc_node);
>
>  void bitmap_free(const unsigned long *bitmap)
>  {
> -       kfree(bitmap);
> +       kvfree(bitmap);
>  }
>  EXPORT_SYMBOL(bitmap_free);
>

I decided to go with just using simple kvmalloc_array for v7 [1] with 
__GFP_ZERO instead of adding a new API to bitmap or changing the 
existing API to kvmalloc/kvfree as I didnt want to make this series 
dependent of bitmap API changes and there are other places where its 
done using kvmalloc_array like ceph and ntfs3. I am happy to send a 
follow up patch after this series that changes the existing API to be kv 
if thats something the bitmap maintainers think makes sense.

[1] 
https://lore.kernel.org/all/20240627105730.3110705-1-usamaarif642@gmail.com/


