Return-Path: <linux-kernel+bounces-309835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA1D9670E1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB14B1F252B2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662817C7AF;
	Sat, 31 Aug 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5YTvYi8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8675917B401
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725100160; cv=none; b=Jx4sKPa4YHhggEeeKUshfyvLmJ3ip2fmdjo3xP+ycXTtQ/84PVMEzvXib8hD56EJc6nKp2N5tBrWlt1dnSaAjDN1HSrUxl/JHIn5gwJ7GVYAog5B91BsJLPRafoSbMpCvKSy86wHeCp8gFd+g/DmjsaHREx6FgqRHl6eTP++rlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725100160; c=relaxed/simple;
	bh=NbHzSpYKnIkTR52Sv91CDXQKCSGg2wPwHy9DXdFvwdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfIaEkTwm+yDgu0ea905u2jrcMExbIQwrLqbzAoXHIdEYtfwpzLxctGz7tHPg3Nqw+KkWXdkSNh0dFT7CGkAbCDFaVmRAE/0H0cu6WCbUbxjbhFqeSk8U3kghPN1PZ/NXRjSBeJ0w++EEiv8TTr8665hPELlu5vcsUTxd8QSmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5YTvYi8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725100157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FrbIITwVcetzf9SQghNcwaEpm4866gXGozxQ3snQfAc=;
	b=H5YTvYi8NuvC2XoUO3N9UhYFK5pZ6gUtYRHwcUZadOekl3d0GGhsLlDDLgR08xde+RDWf4
	skWjRS3WyDSrSnZrht/51Jz+AoDIrCD6959uCthYp+7bPd4/yArsBMUGLBlE8HrZjQUmCc
	j1VDm4jnqciHXIYN88G+6E7LdnbQI7I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-94Kgu_GpM-q8q_Klc2wCVA-1; Sat, 31 Aug 2024 06:29:15 -0400
X-MC-Unique: 94Kgu_GpM-q8q_Klc2wCVA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42c7a5563cfso2427495e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725100154; x=1725704954;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FrbIITwVcetzf9SQghNcwaEpm4866gXGozxQ3snQfAc=;
        b=hy/vV4vh1XlroC2x4KKnZ45UH2akGpxTHvKmdzHu+aAoT9UBrwbOuMpg+fk+dlqENn
         dSvZL8qf8drmjtoP/dBRPRv29sVioImeRsqyK00bqkPyF07U+TngoWQ2RQXHiu4d2pXq
         Bh0sf0pVIZeGv/kqiMZydOOypJ7cujRc3m0S+RsthuCCYriHmW/YEHf888AxhkGpWIFv
         W6qok9zFuRDiXzYy8AM6ZnOEGl3hCIdESJR80mumszknUk6pMjjR5FmoPDxCecbLuszC
         Uyv0yJrSqtf8Od96NQGAKmfwSBW4b3Gjj+1nZSb8p0Vf5oEzEZRzbey6lsqjwHG2PcOx
         4DTA==
X-Forwarded-Encrypted: i=1; AJvYcCVVKj23sOZA2HgK0aRDkCPDI/s7VoB+SxJSp0Z+F3NvIj5Cfiga2s6KUHp/SjhhYEKyybPj+LuLYoLtCnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYsDek9TmyXupm7iOiBxyC3OW0V0HVke1k7/oOeCiQ05KH8N7z
	qB9tvFoN50WoyN2rb9hDjCB17C88TrS4uSBkn8s8qAtAK6KuXbUTDAW/JP8+2gDV/tUAKesuHQa
	FntqX2//u53dPKWQdKJ8K5xvf+Zr344AjpxsnoqVYXtG+ry7hbiWe+sS72bLcuQ==
X-Received: by 2002:a05:600c:4585:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42bb01bfbdemr74410305e9.18.1725100154282;
        Sat, 31 Aug 2024 03:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAM5aUb/RrIahwDOIk1OJwl1CK2O+IP3X2EUvQEn/8oV4OgVRuvCJ6WkztHU1d37U5gf49Sg==
X-Received: by 2002:a05:600c:4585:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42bb01bfbdemr74409925e9.18.1725100153379;
        Sat, 31 Aug 2024 03:29:13 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6ee6.dip0.t-ipconnect.de. [91.12.110.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b9d54f98sm2702991f8f.69.2024.08.31.03.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 03:29:12 -0700 (PDT)
Message-ID: <36933711-ae0f-468c-93bd-d6a67d974c9d@redhat.com>
Date: Sat, 31 Aug 2024 12:29:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: entirely reuse the whole anon mTHP in do_wp_page
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Chuanhua Han <hanchuanhua@oppo.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kalesh Singh <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>
References: <20240831092339.66085-1-21cnbao@gmail.com>
 <d0b826c1-8577-46f8-8e4c-ca2b72554819@redhat.com>
 <CAGsJ_4ynOeOaRb3=xBc1uETn9oLTkSpZGoEYGpTeJ1F4uqB7bA@mail.gmail.com>
 <b7853f0f-7044-4c49-931c-c61900229b19@redhat.com>
 <CAGsJ_4wwg-f32e=xSHn+Rxv5k7H6VXhUu3+v_ZOShL_mGn2Xew@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wwg-f32e=xSHn+Rxv5k7H6VXhUu3+v_ZOShL_mGn2Xew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31.08.24 12:21, Barry Song wrote:
> On Sat, Aug 31, 2024 at 10:07 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 31.08.24 11:55, Barry Song wrote:
>>> On Sat, Aug 31, 2024 at 9:44 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 31.08.24 11:23, Barry Song wrote:
>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>
>>>>> On a physical phone, it's sometimes observed that deferred_split
>>>>> mTHPs account for over 15% of the total mTHPs. Profiling by Chuanhua
>>>>> indicates that the majority of these originate from the typical fork
>>>>> scenario.
>>>>> When the child process either execs or exits, the parent process should
>>>>> ideally be able to reuse the entire mTHP. However, the current kernel
>>>>> lacks this capability and instead places the mTHP into split_deferred,
>>>>> performing a CoW (Copy-on-Write) on just a single subpage of the mTHP.
>>>>>
>>>>>     main()
>>>>>     {
>>>>>     #define SIZE 1024 * 1024UL
>>>>>             void *p = malloc(SIZE);
>>>>>             memset(p, 0x11, SIZE);
>>>>>             if (fork() == 0)
>>>>>                     exec(....);
>>>>>            /*
>>>>>          * this will trigger cow one subpage from
>>>>>          * mTHP and put mTHP into split_deferred
>>>>>          * list
>>>>>          */
>>>>>         *(int *)(p + 10) = 10;
>>>>>         printf("done\n");
>>>>>         while(1);
>>>>>     }
>>>>>
>>>>> This leads to two significant issues:
>>>>>
>>>>> * Memory Waste: Before the mTHP is fully split by the shrinker,
>>>>> it wastes memory. In extreme cases, such as with a 64KB mTHP,
>>>>> the memory usage could be 64KB + 60KB until the last subpage
>>>>> is written, at which point the mTHP is freed.
>>>>>
>>>>> * Fragmentation and Performance Loss: It destroys large folios
>>>>> (negating the performance benefits of CONT-PTE) and fragments memory.
>>>>>
>>>>> To address this, we should aim to reuse the entire mTHP in such cases.
>>>>>
>>>>> Hi David,
>>>>>
>>>>> I’ve renamed wp_page_reuse() to wp_folio_reuse() and added an
>>>>> entirely_reuse argument because I’m not sure if there are still cases
>>>>> where we reuse a subpage within an mTHP. For now, I’m setting
>>>>> entirely_reuse to true only for the newly supported case, while all
>>>>> other cases still get false. Please let me know if this is incorrect—if
>>>>> we don’t reuse subpages at all, we could remove the argument.
>>>>
>>>> See [1] I sent out this week, that is able to reuse even without
>>>> scanning page tables. If we find the the folio is exclusive we could try
>>>> processing surrounding PTEs that map the same folio.
>>>>
>>>> [1] https://lkml.kernel.org/r/20240829165627.2256514-1-david@redhat.com
>>>
>>> Great! It looks like I missed your patch again. Since you've implemented this
>>> in a better way, I’d prefer to use your patchset.
>>
>> I wouldn't say better, just more universally. And while taking care of
>> properly sync'ing the mapcount vs. refcount :P
>>
>>>
>>> I’m curious about how you're handling ptep_set_access_flags_nr() or similar
>>> things because I couldn’t find the related code in your patch 10/17:
>>>
>>> [PATCH v1 10/17] mm: COW reuse support for PTE-mapped THP with CONFIG_MM_ID
>>>
>>> Am I missing something?
>>
>> The idea is to keep individual write faults as fast as possible. So the
>> patch set keeps it simple and only reuses a single PTE at a time,
>> setting that one PAE and mapping it writable.
> 
> I got your point, thanks! as anyway the mTHP has been exclusive,
> so the following nr-1 minor page faults will set their particular PTE
> to writable one by one.

Yes, assuming you would get these page faults, and assuming you would 
get them in the near future.

> 
>>
>> As the patch states, it might be reasonable to optimize some cases,
>> maybe also only on some architectures. For example to fault-around and
>> map the other ones writable as well. It might not always be desirable
>> though, especially not for larger folios.
> 
> as anyway, the mTHP has been entirely exclusive, setting all PTEs
> directly to writable should help reduce nr - 1 minor page faults and
> ideally help reduce CONTPTE unfold and fold?

Yes, doing that on CONTPTE granularity would very likely make sense. For 
anything bigger than that, I am not sure.

Assuming we have a 1M folio mapped by PTEs. Trying to fault-around in 
aligned CONTPTE granularity likely makes sense. Bigger than that, I am 
not convinced.

> 
> What is the downside to doing that? I also don't think mapping them
> all together will waste memory?

No, it's all about increasing the latency of individual write faults.

-- 
Cheers,

David / dhildenb


