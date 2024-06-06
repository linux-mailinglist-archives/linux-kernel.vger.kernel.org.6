Return-Path: <linux-kernel+bounces-205040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1D78FF690
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64ABB2883DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92CF19751B;
	Thu,  6 Jun 2024 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQ1ujTTD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319AC13B583
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708656; cv=none; b=ENSu2IP/3c4QIXj6mDri4QILEEhB1AE1vGGLOoklCBjpBd8OcFqzn0EXYOXp40ReKlA+iAPhinm2rnPShDLqj6lrzprXf3PJxJ2tOdaxaGY10mRs6N7SO8nUqYs839XaF2fz7D7Ym+CRCKvctEdSDO9xVlumrA3v5jOU+cWFi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708656; c=relaxed/simple;
	bh=meiiw+QAUcLH3qK8jolHciYvX5ojB6wBcfTw6IsBjjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mp/sPuZKqCPdX4HEkZ541ZR+LTaGenh0r9Rbkdey2I/Qln+PnbatuqoVrPu8JGb7xhinjFIN8KdMLVrBLi0nsCF1c+bzE0G646In4doqRoe2YsRy+RLfw1Em0gqRKSQTt1rmFJiHbn8Xvslk6t0nmWzYbUpjgXnSSsPqAzu6xf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQ1ujTTD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717708654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O7TMXnF3uPT41GwfjC+KMQttK8xfTxrdPXb+eF1nl88=;
	b=CQ1ujTTDuM3lIKcSsAFTSYOG9xqeavwntWLENZtncRjttpe7HBfRMecX2Uni16PsrkiSAU
	tE7aS1Hm+C7DNfothVCEUlrSw+ONeSbhQZBJJlJm1I3hbvXoaYgoTnb8PW6NlV0HKUOx6R
	owO2mrjLaz+Xb9KLqqWdMiiC9rfyzjk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-uhxwkiGbMFqGPtO0T0eTFA-1; Thu, 06 Jun 2024 17:17:32 -0400
X-MC-Unique: uhxwkiGbMFqGPtO0T0eTFA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42117a61bccso12502225e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717708651; x=1718313451;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O7TMXnF3uPT41GwfjC+KMQttK8xfTxrdPXb+eF1nl88=;
        b=mWwlDc8JA4L77S6TmmQOfLShj+i/aCDEpJfYgt/ZlDzjYp1uMPyUXHpc4OXyk6CwpE
         BcUy1yS/cVHc7RQMyBRmLNZtCiVT/68mL0aN6blCauH+39Q0SJoNI4cZlm/qkAKLfPfO
         t2Rmv+3d86NtjiWmixGtg3tq7PbbZR+YqZcl9ptRhtkWiieRN4p4trARLsKHHsE2qbAw
         3cSt8m96s46G+BBFWsA9+VrArn+/6Xk4hvcpL6TFBcaQy0ydl+RN7PaDr8mjLq6EIRcC
         tCQBVOt68C5t7HWwSZC58Q/hJ37zETmyMKcqBPDYfG1kbGXMjC+x4chB3kTZXAk14kOE
         9klg==
X-Forwarded-Encrypted: i=1; AJvYcCV/yE30ZyAH/bMS0BpaTwXb/JFS85c6M4jWiuDvD1KH0JjfJLNSQArLLlCbhUv/2Q9ZN1PBRpBRcMhL2cyUzSrriQluseaR88yOUMf+
X-Gm-Message-State: AOJu0Yw/EHo7P/wz8DT0f6EQcgi1oYwdw69e5G2vdbRR73QoZVhdauGZ
	7NQo7NHOTqkllJdqi9o6ASSF3g60/BhsKlTMlBofAZOVhxTEQlbMRzr3zCi+fhxLMcWiL9F6hkS
	EjAZwLWO/M7rxemRNAkLYs7dFWig8kR1BMw6nsitmU3SeyZdOH/tic7NbcspmYw==
X-Received: by 2002:a05:600c:4f0c:b0:421:5310:c075 with SMTP id 5b1f17b1804b1-421649ea67amr6760005e9.2.1717708651517;
        Thu, 06 Jun 2024 14:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW4FIyRihO57zX7xLENRd0Isrf5IMNIqrRXZ6D1Puv3lE3zOz4D9z+XBlbSC+zPL59vA1mdw==
X-Received: by 2002:a05:600c:4f0c:b0:421:5310:c075 with SMTP id 5b1f17b1804b1-421649ea67amr6759855e9.2.1717708651046;
        Thu, 06 Jun 2024 14:17:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c7e8fsm33522985e9.38.2024.06.06.14.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 14:17:30 -0700 (PDT)
Message-ID: <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com>
Date: Thu, 6 Jun 2024 23:17:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is
 attempted
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com>
 <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.06.24 22:31, Yosry Ahmed wrote:
> On Thu, Jun 6, 2024 at 1:22 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 06.06.24 20:48, Yosry Ahmed wrote:
>>> With ongoing work to support large folio swapin, it is important to make
>>> sure we do not pass large folios to zswap_load() without implementing
>>> proper support.
>>>
>>> For example, if a swapin fault observes that contiguous PTEs are
>>> pointing to contiguous swap entries and tries to swap them in as a large
>>> folio, swap_read_folio() will pass in a large folio to zswap_load(), but
>>> zswap_load() will only effectively load the first page in the folio. If
>>> the first page is not in zswap, the folio will be read from disk, even
>>> though other pages may be in zswap.
>>>
>>> In both cases, this will lead to silent data corruption.
>>>
>>> Proper large folio swapin support needs to go into zswap before zswap
>>> can be enabled in a system that supports large folio swapin.
>>>
>>> Looking at callers of swap_read_folio(), it seems like they are either
>>> allocated from __read_swap_cache_async() or do_swap_page() in the
>>> SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so we
>>> are fine for now.
>>>
>>> Add a VM_BUG_ON() in zswap_load() to make sure that we detect changes in
>>> the order of those allocations without proper handling of zswap.
>>>
>>> Alternatively, swap_read_folio() (or its callers) can be updated to have
>>> a fallback mechanism that splits large folios or reads subpages
>>> separately. Similar logic may be needed anyway in case part of a large
>>> folio is already in the swapcache and the rest of it is swapped out.
>>>
>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>>> ---
>>>
>>> Sorry for the long CC list, I just found myself repeatedly looking at
>>> new series that add swap support for mTHPs / large folios, making sure
>>> they do not break with zswap or make incorrect assumptions. This debug
>>> check should give us some peace of mind. Hopefully this patch will also
>>> raise awareness among people who are working on this.
>>>
>>> ---
>>>    mm/zswap.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>> index b9b35ef86d9be..6007252429bb2 100644
>>> --- a/mm/zswap.c
>>> +++ b/mm/zswap.c
>>> @@ -1577,6 +1577,9 @@ bool zswap_load(struct folio *folio)
>>>        if (!entry)
>>>                return false;
>>>
>>> +     /* Zswap loads do not handle large folio swapins correctly yet */
>>> +     VM_BUG_ON(folio_test_large(folio));
>>> +
>>
>> There is no way we could have a WARN_ON_ONCE() and recover, right?
> 
> Not without making more fundamental changes to the surrounding swap
> code. Currently zswap_load() returns either true (folio was loaded
> from zswap) or false (folio is not in zswap).
> 
> To handle this correctly zswap_load() would need to tell
> swap_read_folio() which subpages are in zswap and have been loaded,
> and then swap_read_folio() would need to read the remaining subpages
> from disk. This of course assumes that the caller of swap_read_folio()
> made sure that the entire folio is swapped out and protected against
> races with other swapins.
> 
> Also, because swap_read_folio() cannot split the folio itself, other
> swap_read_folio_*() functions that are called from it should be
> updated to handle swapping in tail subpages, which may be questionable
> in its own right.
> 
> An alternative would be that zswap_load() (or a separate interface)
> could tell swap_read_folio() that the folio is partially in zswap,
> then we can just bail and tell the caller that it cannot read the
> large folio and that it should be split.
> 
> There may be other options as well, but the bottom line is that it is
> possible, but probably not something that we want to do right now.
> 
> A stronger protection method would be to introduce a config option or
> boot parameter for large folio swapin, and then make CONFIG_ZSWAP
> depend on it being disabled, or have zswap check it at boot and refuse
> to be enabled if it is on.

Right, sounds like the VM_BUG_ON() really is not that easily avoidable.

I was wondering, if we could WARN_ON_ONCE and make the swap code detect 
this like a read-error from disk.

I think do_swap_page() detects that by checking if the folio is not 
uptodate:

if (unlikely(!folio_test_uptodate(folio))) {
	ret = VM_FAULT_SIGBUS;
	goto out_nomap;
}

So maybe WARN_ON_ONCE() + triggering that might be a bit nicer to the 
system (but the app would crash either way, there is no way around it).

-- 
Cheers,

David / dhildenb


