Return-Path: <linux-kernel+bounces-271328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC14944CEA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE48C1F234AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05E31A38D6;
	Thu,  1 Aug 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crbEof/q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83037137748
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518020; cv=none; b=aOBTjh3f2CfDscGpsmgp7bv0HpM46L7tS9PXK/RxEdtzf1XBniZlHUzIBUvQkq+riB8BewhToxjaEvD9u2C2kUIn/zrdHtjywb+bYJkegVAG1paC90RplV3y5ipGw1Wd6LVUI+0NfkGVylfi4Bza//Nm5HWeBDaVLghT0PlBN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518020; c=relaxed/simple;
	bh=EFbBCmRfAwHXtpZhw7BueD/sCdguDuEwnLfIGm161XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbkwEjdTCeHL//aElkWFuLBR3c+BzF28XaYWUMjyODBtduqsZ2iqfEkd9Eh4VvWki8B2JaVOLq15X176X3zwJcx3G9BZJRFKFJWv9sZ7gGpijAOoFAkv/H+PgMg7v1OIDfii2pac4+s9f2VG/S3eKu/jz1HbEAOYh+ILeDhNGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crbEof/q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7SxixTwboHkus+gGFT2/BDoKsnol2P5MNN8oNlftuBs=;
	b=crbEof/qoo6VSY7cOnLsL46WSHNxi7f8ta1Rx2dbObMqxRuU37KRhDy6cLNql8BtpqXOrL
	H4z4NUw9zXNPPq/I4VO7FfErjF0WuV3bPEBvByhmlr2hba7A3Rw8XZeDcY1HvtTqWvGhGq
	NSk5VDDxVE+UQoT/tiN7VKQtVL4FmTI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-jAiJSgJXMradv-fYF5WN-Q-1; Thu, 01 Aug 2024 09:13:35 -0400
X-MC-Unique: jAiJSgJXMradv-fYF5WN-Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso44807365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722518014; x=1723122814;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7SxixTwboHkus+gGFT2/BDoKsnol2P5MNN8oNlftuBs=;
        b=EBWvZjPDRvdgwzwNW2zzORLfghg3cY724XtK11zut3QUhXKmUDhCZDmPIIH/NOcsFm
         jHVvFGstnx8h452T3Ce7jP8SDhUeAg09J4J0nwuehB5I8nm+H6Q5AtmjLxn6YhQAvjIP
         tp6Aezxphmtoe7PMxiRgchV86by2IN4E27Pkqe/ghjRzVfcB+nQswLGFJC8trp8z3hxR
         Ptw9U10P3IfskYdx+w8EZyazpD1DvRSQQbqhj5oAkxtIa4w0powXuHIh++uKihyY8dXD
         hpoSjsVWtPSa+w+gCxh+YqOWzN6A4WypJJJ2if9XZJ7upGSZWNAM8EsalAXQCU8YYQ52
         NZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRh0etjTLa7fca6U8j6ce2SRGdS3vB7AYhJcxylEc9J9A6DwnMdjiiwpZcGezU3lIx1UJA+RRbmVLKcuczSLSzZ887MDtWcr72N7/p
X-Gm-Message-State: AOJu0YyMLZajWsSoNoZ28qWeT0leF7Y4PHqfusFMjlFYRLtg0kzwBXNH
	UQNOlzAd83X7LvQMibctofbwHv4r3gl1y5b1Fz4bzOi4h8GHLJ2Z8kj6xhOfyBCGZL3RRs7Gxs6
	qwz1jd+JU5wqzpzn5uQqyjSr2lJggOvC0htWmpTH8G6GV7sVQYw5DoYjuGQsgTg==
X-Received: by 2002:a05:600c:4fd2:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-428a9bdd1d6mr17023825e9.15.1722518014001;
        Thu, 01 Aug 2024 06:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkbyR5RyICgi4izmSun1UzM0RYz5RoseAbykq8o32bBspzNLvuQ6L5kNygvZZ2uF2GHIFCqA==
X-Received: by 2002:a05:600c:4fd2:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-428a9bdd1d6mr17023535e9.15.1722518013543;
        Thu, 01 Aug 2024 06:13:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282f382abcsm39296005e9.1.2024.08.01.06.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 06:13:32 -0700 (PDT)
Message-ID: <19902a48-c59b-4e3b-afc5-e792506c2fd6@redhat.com>
Date: Thu, 1 Aug 2024 15:13:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
 <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
 <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
 <92df0ee1-d3c9-41e2-834c-284127ae2c4c@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <92df0ee1-d3c9-41e2-834c-284127ae2c4c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> To dampen the tradeoff, we could do this in shmem_fault() instead? But
>>> then, this would mean that we do this in all
>>>
>>> kinds of vma->vm_ops->fault, only when we discover another reference
>>> count race condition :) Doing this in do_fault()
>>>
>>> should solve this once and for all. In fact, do_pte_missing() may call
>>> do_anonymous_page() or do_fault(), and I just
>>>
>>> noticed that the former already checks this using vmf_pte_changed().
>>
>> What I am still missing is why this is (a) arm64 only; and (b) if this
>> is something we should really worry about. There are other reasons
>> (e.g., speculative references) why migration could temporarily fail,
>> does it happen that often that it is really something we have to worry
>> about?
> 
> 
> (a) See discussion at [1]; I guess it passes on x86, which is quite
> strange since the race is clearly arch-independent.

Yes, I think this is what we have to understand. Is the race simply less 
likely to trigger on x86?

I would assume that it would trigger on any arch.

I just ran it on a x86 VM with 2 NUMA nodes and it also seems to work here.

Is this maybe related to deferred flushing? Such that the other CPU will 
by accident just observe the !pte_none a little less likely?

But arm64 also usually defers flushes, right? At least unless 
ARM64_WORKAROUND_REPEAT_TLBI is around. With that we never do deferred 
flushes.

> 
> (b) On my machine, on an average in under 10 iterations of move_pages(),
> it fails, which seems problematic to

Yes, it's a big difference compared to what I encounter.

-- 
Cheers,

David / dhildenb


