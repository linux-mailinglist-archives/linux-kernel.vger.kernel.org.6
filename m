Return-Path: <linux-kernel+bounces-227778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002B4915675
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7571F2257F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E5019FA92;
	Mon, 24 Jun 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZB7+UH1"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1519EEDF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253597; cv=none; b=SjRz4fVeoTw1d7f5N9MssHs4UAHmf1+Xpb5mms1fWD9fizfG6lxZZojzA39/ysSVVLPOoyxbujgYVTsNxxWrxoUSqaZv1Uu/ODVersr2rqcmS7dg0eZr73aEqSSGfXdq6/DmzsB/2iTluYw6qIF+OppBoE/EzIL3TuD9UKgR4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253597; c=relaxed/simple;
	bh=w6b0ZTUpHKOFIbi2XbpEQ+xiKcLlbCdJY6Y9N+k9OPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E23akzo4410Swm4JN3e6PF73Vr0JJLFJm4uynUThUzRj0Rl1MzftaaSsD+Uvxa8lMStfCMo6+l4GebiPbk6c/EzknATJHGZtj7opATbT+556BwMGIHqnzFgCX2x8D2gQchN+ZyYLfnlhyOa1L8jPl4iE0cOkuPE0NqKJCgKBGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZB7+UH1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdf4bc083so3255931e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719253594; x=1719858394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QY3hLjglDBcIn3zXNfyok4jWrdOzSelcx/I3VKtoZU=;
        b=CZB7+UH1/FTx9rekQu3PPDGnYbpqQzDSfIToqBUp72jAIxwjaAlq0vM0JcMrFufjWu
         6vC6D/EX+D7Ajuxc11OVIY6eI1p2HffociSCpLt88/YD3eLpcjkka306PgCQl2s62ga1
         oYZwutA58b3b9jvl765PIiugqz45nJPKPs1bndAyCttk3LW5USikpmb9rqyphCi5oAvi
         NAf/WX9Vi+rH1CD4aj01oS9S054d8a9FBUVowVjUHlolXZQhRAREYuwfOf5ioq4+qULl
         f4hIP2ofr6pBbJeG3+ITmWjINX8HaonFAd2Z5c5ZafbfOf8SjQFDnLyMdTbuaszEPpoC
         DAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719253594; x=1719858394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QY3hLjglDBcIn3zXNfyok4jWrdOzSelcx/I3VKtoZU=;
        b=K0IVVX/ut7UZpIQqAJwg0io8ZilHnP+eSnSUwS7wof8MLb0NdCYXfc2wlZpP6wsv5c
         N+OqiF5NHChNYyAwnM6corFityezBNvHSpByief6Xi2TR/5IXaVX9SuAB4Lvia8o+H82
         73L2C7otHRAopRyb9YS9UIHwLRBlkWxjV4RPq0Ud7GQtbmk7OfV4wzPN+UUWQyw0ryxW
         vNovAF/AxfVZnMZcllYuLLBvkzOcAgrLi6z6SS0A5CGTgETvKr+fEyrI6GUaeVfMuQq7
         SNnGny6gakAcIyv9EpOVg8fL+FgEWd8t9uIyqKnmbwUabPnKhdkjXEQkWqFwDCYkEPj5
         iXFw==
X-Forwarded-Encrypted: i=1; AJvYcCVBs5jR7qsV7Kkcy8Yml8fo3GhuB6yg8AaKvSITtd5D0rYqoU5BmIkJBbg1JOyzH61ERhJgkldrBBaHGMw0ykExXTC+vGzL8bBtBaM/
X-Gm-Message-State: AOJu0YwBA4XynwzMErtBgfLEcP/tIWeP3fHFBjSgFL5ORiW6o6M0tZmM
	zoXV8VgsrDAONuZ9bc6TDd4vBbkGG8KQphJrFcjEqlnu8lNmEfnf
X-Google-Smtp-Source: AGHT+IE4h3ga/z+Y+Sd3WyTIsGf+yCxLn2kq84TioTsOo+/QrFFHZbpbPJkF+2UXnFPTlTeyZyLVMA==
X-Received: by 2002:a05:6512:6c3:b0:52c:83c2:9670 with SMTP id 2adb3069b0e04-52ce0646e8bmr4740430e87.69.1719253593248;
        Mon, 24 Jun 2024 11:26:33 -0700 (PDT)
Received: from ?IPV6:2001:16a2:df66:b900:46d:aa3:6645:bcd8? ([2001:16a2:df66:b900:46d:aa3:6645:bcd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d1fdsm149929305e9.7.2024.06.24.11.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 11:26:32 -0700 (PDT)
Message-ID: <167b2f11-a013-440f-b196-5d8c0ea5d9b3@gmail.com>
Date: Mon, 24 Jun 2024 21:26:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
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
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <12fb19d1-3e57-4880-be59-0e83cdc4b7f1@gmail.com>
 <61d19ec8-2ba7-e156-7bb7-f746dae8e120@google.com>
 <5b3e732c-d23d-41ef-ae5c-947fa3e866ab@gmail.com>
 <CAJD7tkYJVa=dd=hwqhJ8_-uzxFDaP6-GcTk3RdG_3DJouJ61AQ@mail.gmail.com>
 <cacd14a9-01fc-4844-9ac6-2e797af13c36@gmail.com>
 <CAJD7tkbYbJHWQtC8+nsyfgS2jq7S5Qyy3-1NJWa4m80VAR9GXA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkbYbJHWQtC8+nsyfgS2jq7S5Qyy3-1NJWa4m80VAR9GXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/06/2024 20:31, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 10:26 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> On 24/06/2024 19:56, Yosry Ahmed wrote:
>>> [..]
>>>>>> -       p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
>>>>>> +       p->zeromap = kvzalloc(DIV_ROUND_UP(maxpages, 8), GFP_KERNEL);
>>>>> No, 8 is not right for 32-bit kernels. I think you want
>>>>>         p->zeromap = kvzalloc(BITS_TO_LONGS(maxpages), GFP_KERNEL);
>>>>> but please check it carefully, I'm easily confused by such conversions.
>>>>>
>>>>> Hugh
>>>> Ah yes, didnt take into account 32-bit kernel. I think its supposed to be
>>>>
>>>>     p->zeromap = kvzalloc(BITS_TO_LONGS(maxpages) * sizeof(unsigned long),
>>>> GFP_KERNEL);
>>> You can do something similar to bitmap_zalloc() and use:
>>>
>>> kvmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), GFP_KERNEL
>>> | __GFP_ZERO)
>>>
>>> I don't see a kvzalloc_array() variant to use directly, but it should
>>> be trivial to add it. I can see other users of kvmalloc_array() that
>>> pass in __GFP_ZERO (e.g. fs/ntfs3/bitmap.c).
>>>
>>> , or you could take it a step further and add bitmap_kvzalloc(),
>>> assuming the maintainers are open to that.
>> Thanks! bitmap_kvzalloc makes most sense to me. It doesnt make sense
>> that bitmap should only be limited to MAX_PAGE_ORDER size. I can add
>> this patch below at the start of the series and use it in the patch for
>> zeropage swap optimization.
>>
>>
>>       bitmap: add support for virtually contiguous bitmap
>>
>>       The current bitmap_zalloc API limits the allocation to MAX_PAGE_ORDER,
>>       which prevents larger order bitmap allocations. Introduce
>>       bitmap_kvzalloc that will allow larger allocations of bitmap.
>>       kvmalloc_array still attempts to allocate physically contiguous memory,
>>       but upon failure, falls back to non-contiguous (vmalloc) allocation.
>>
>>       Suggested-by: Yosry Ahmed <yosryahmed@google.com>
>>       Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>
> LGTM with a small fix below.
>
>> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
>> index 8c4768c44a01..881c2ff2e834 100644
>> --- a/include/linux/bitmap.h
>> +++ b/include/linux/bitmap.h
>> @@ -131,9 +131,11 @@ struct device;
>>     */
>>    unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags);
>>    unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags);
>> +unsigned long *bitmap_kvzalloc(unsigned int nbits, gfp_t flags);
>>    unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int
>> node);
>>    unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int
>> node);
>>    void bitmap_free(const unsigned long *bitmap);
>> +void bitmap_kvfree(const unsigned long *bitmap);
>>
>>    DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
>>
>> diff --git a/lib/bitmap.c b/lib/bitmap.c
>> index b97692854966..eabbfb85fb45 100644
>> --- a/lib/bitmap.c
>> +++ b/lib/bitmap.c
>> @@ -727,6 +727,13 @@ unsigned long *bitmap_zalloc(unsigned int nbits,
>> gfp_t flags)
>>    }
>>    EXPORT_SYMBOL(bitmap_zalloc);
>>
>> +unsigned long *bitmap_kvzalloc(unsigned int nbits, gfp_t flags)
>> +{
>> +       return kvmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long),
>> +                             flags | __GFP_ZERO);
>> +}
>> +EXPORT_SYMBOL(bitmap_zalloc);
> EXPORT_SYMBOL(bitmap_kvzalloc)*


Actually, does it make more sense to change the behaviour of the current 
APIs like below instead of above patch? Or is there an expectation that 
the current bitmap API is supposed to work only on physically contiguous 
bits?

I believe in the kernel if the allocation/free starts with 'k' its 
physically contiguous and with "kv" its physically contiguous if 
possible, otherwise virtually contiguous. The bitmap functions dont have 
either, so we could change the current implementation. I believe it 
would not impact the current users of the functions as the first attempt 
is physically contiguous which is how it works currently, and only upon 
failure it would be virtual and it would increase the use of current 
bitmap API to greater than MAX_PAGE_ORDER size allocations.

Yury Norov and Rasmus Villemoes, any views on this?

Thanks

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7247e217e21b..ad771dc81afa 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -804,6 +804,7 @@ kvmalloc_array_node_noprof(size_t n, size_t size, 
gfp_t flags, int node)
  #define kvcalloc_node_noprof(_n,_s,_f,_node) 
kvmalloc_array_node_noprof(_n,_s,(_f)|__GFP_ZERO,_node)
  #define kvcalloc_noprof(...) kvcalloc_node_noprof(__VA_ARGS__, 
NUMA_NO_NODE)

+#define kvmalloc_array_node(...) 
alloc_hooks(kvmalloc_array_node_noprof(__VA_ARGS__))
  #define kvmalloc_array(...) 
alloc_hooks(kvmalloc_array_noprof(__VA_ARGS__))
  #define kvcalloc_node(...) alloc_hooks(kvcalloc_node_noprof(__VA_ARGS__))
  #define kvcalloc(...) alloc_hooks(kvcalloc_noprof(__VA_ARGS__))
diff --git a/lib/bitmap.c b/lib/bitmap.c
index b97692854966..272164dcbef1 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -716,7 +716,7 @@ void bitmap_fold(unsigned long *dst, const unsigned 
long *orig,

  unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
  {
-       return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long),
+       return kvmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long),
                              flags);
  }
  EXPORT_SYMBOL(bitmap_alloc);
@@ -729,7 +729,7 @@ EXPORT_SYMBOL(bitmap_zalloc);

  unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int 
node)
  {
-       return kmalloc_array_node(BITS_TO_LONGS(nbits), sizeof(unsigned 
long),
+       return kvmalloc_array_node(BITS_TO_LONGS(nbits), sizeof(unsigned 
long),
                                   flags, node);
  }
  EXPORT_SYMBOL(bitmap_alloc_node);
@@ -742,7 +742,7 @@ EXPORT_SYMBOL(bitmap_zalloc_node);

  void bitmap_free(const unsigned long *bitmap)
  {
-       kfree(bitmap);
+       kvfree(bitmap);
  }
  EXPORT_SYMBOL(bitmap_free);


