Return-Path: <linux-kernel+bounces-201890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E1D8FC4BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9429E2835C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC218C342;
	Wed,  5 Jun 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/KE6LOR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956461922D6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573232; cv=none; b=RrbT9nBnk9Ncm4h9D3WI4G6XGNBn296bLGoEdyUWtLoL+QPMw8BTQGHAC4Rv/0nkNT3EEsLJEY0SgnZ8KRHea7QZ7hZ2if+sScQY2DutfsYI9gDb1oKvWGrm7d7oM1kr20lIxCgcoIeG/10rU+YQu6W4g0s8T2UlT9MAVkh5Sxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573232; c=relaxed/simple;
	bh=qADIR6ORQw/fm1uTzhK/je8tF5siq7OcH2X3hxvRTOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Znd21wC5kqx18i4vb5iVYFyDiD3ajHn2M2fs5whXM5eJUOxcMiBEHBS7XCI052S9IjCITWHTj4o8qJXmpBAWCoGksQ2KH7y0xLTvmogk7m+U+AV3YImIV4QKGPGu0YxR8Nx8eAOiFGiY9HlORoUT1vOzRA7kW7e17xB6vlgp450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/KE6LOR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717573229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1Mk6pxK/P+/uflenmaP8kxKi0Pdp/e6NzQ2LqaFWMk8=;
	b=U/KE6LORZ/98d2Ftg1teLDEPFlps8wmHP70NMbEV9L1jJYw8PcAThgs0AhBXkvUXt/6qWt
	N9DtVXUdAcSevJPtTSKaT2zTGeoWUY1LNKGS9hThVFeunnlbwbNwjGjjLRgnAcMKNgcfc/
	H5SbYKlcGopXb3wPdCVGEtUgtz1RGLg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-SDblyTfeOS2TP8AGoKs_Vw-1; Wed, 05 Jun 2024 03:40:27 -0400
X-MC-Unique: SDblyTfeOS2TP8AGoKs_Vw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dcd39c6ebso351015f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573226; x=1718178026;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Mk6pxK/P+/uflenmaP8kxKi0Pdp/e6NzQ2LqaFWMk8=;
        b=csv4lT+Pn0ozlHetHFegyzssCoHjQjhJDFDXxbcZpRMZnWBrN3q/rad6sNoOW4OgU8
         KsM7YYwXeeUAtCSH98C62HtrRJ2sD9AR9GGPgUMmmIurwR67Tsd/DzS5VYg01gRfuaxQ
         uvOCDETtzX1obqvGpT0F8Zt4YTvomzS6sl9BfhQjFA8IGaO1T1f9IAsVPqvaJOabYlLE
         ZUU2zeA8jUvT36AR2v7Bam5MAp+knM2Rfs1LL0QQk7XyFlyXYzFVEmBvkBVQhKB9FqHm
         To4radh9vP/GiN8dv0WAGdc72ZbR0PmQa8K9I70/3y5fgSIHmov/n2/9d7IAT1hX98Ab
         lpRg==
X-Forwarded-Encrypted: i=1; AJvYcCXck78hBuzyqaYgI27kKYdvELA/K2ckIDCsCvCLV7YTz1XgygINXZWmdv7wxpCuSIdjupG1DRe125zfnUR76q/NEYAFUxig+zFvVMB5
X-Gm-Message-State: AOJu0Yy5ddi1p1fgS35Vdp1+rVSCp6od5HHZWdHtqdpauuh3dLJFrdhA
	QDKaPRxmK5jm3/UVQuYBI2kI+WLhG4EF5bVtDczqfY6lBf7oC2YEUnx/g635lGOlAKap88GSxuf
	XFt/zYVO/8xhWZYXxB72AAMBqxe9op+4BRSq3sXzEi06tQeMsckp87b+66ZGP1A==
X-Received: by 2002:a05:600c:5122:b0:421:4b0a:5006 with SMTP id 5b1f17b1804b1-4214b0a5ffemr37008155e9.7.1717573226647;
        Wed, 05 Jun 2024 00:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE95xI+qkWNi3MAbQeX07vqqOoB+/KqwXLrl8ByA50EGxitf+n3yI74FnHdiLQjcw9O5x70yg==
X-Received: by 2002:a05:600c:5122:b0:421:4b0a:5006 with SMTP id 5b1f17b1804b1-4214b0a5ffemr37007885e9.7.1717573226133;
        Wed, 05 Jun 2024 00:40:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158135ea8sm10253185e9.37.2024.06.05.00.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 00:40:25 -0700 (PDT)
Message-ID: <4a354a51-96d8-4243-a977-3ebdc58fd8bc@redhat.com>
Date: Wed, 5 Jun 2024 09:40:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm/ksm: skip subpages of compound pages
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-3-alexs@kernel.org>
 <8d3a60d5-06c5-4df4-aeda-2fbec45a8ae0@redhat.com>
 <b3e242b5-c589-47fd-9a02-1e488bed9d15@gmail.com>
 <00dcd224-6333-4f1e-9087-bdb5024ac236@redhat.com>
 <9f4f6f0e-81e8-4bd0-9f20-412a543a452d@gmail.com>
 <3d2ad8a3-30c6-41d6-841b-e8c376d01da3@redhat.com>
 <cf5a0d4a-5291-4d4c-92e5-9340dfa4e8ac@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cf5a0d4a-5291-4d4c-92e5-9340dfa4e8ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.06.24 05:58, Alex Shi wrote:
> 
> 
> On 6/4/24 9:14 PM, David Hildenbrand wrote:
>> On 04.06.24 15:10, Alex Shi wrote:
>>>
>>>
>>> On 6/4/24 6:43 PM, David Hildenbrand wrote:
>>>>>>>
>>>>>>> @@ -2680,7 +2685,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>>>>>>                  }
>>>>>>>      next_page:
>>>>>>>                  put_page(*page);
>>>>>>> -            ksm_scan.address += PAGE_SIZE;
>>>>>>> +            ksm_scan.address += nr * PAGE_SIZE;
>>>>>>>                  cond_resched();
>>>>>>>              }
>>>>>>>          }
>>>>>>
>>>>>> You might be jumping over pages that don't belong to that folio. What you would actually want to do is somehow use folio_pte_batch() to really know the PTEs point at the same folio, so you can skip them. But that's not that easy when using follow_page() ...
>>>>>>
>>>>>> So I suggest dropping this change for now.
>>>>>>
>>>>>
>>>>> Hi David,
>>>>>
>>>>> Forgive my stupidity, where I jump over normal page that not to belong to the folio?
>>>>
>>>> IIUC, you assume that the folio is fully mapped by all PTEs that could span it, and that follow_page() would give you the head page, correct?
>>>>
>>>> As a simple example, assume only a single page of a large folio is still mapped, which could be any tail page. You couldn't jump over any PTEs.
>>>>
>>>> Or am I missing something?
>>>
>>> Uh, thanks for explanations. for what's we concerned, the following code could take care of the FULL or ERR pages. And it still keep the step of single page.
>>>                           page = follow_page(vma, ksm_scan.address, FOLL_GET);
>>>                           if (IS_ERR_OR_NULL(page)) {
>>>                                   ksm_scan.address += PAGE_SIZE;
>>>                                   cond_resched();
>>>                                   continue;
>>>                           }
>>> And after the above code, step folio_nr_pages on address should be safe, isn't it?
>>
>> Not sure if I follow. Let me try explaining once again:
>>
>> Assume a PTE maps some tail page of the large anonymous folio. The other PTEs around it map some other anonymous folios, not pages of that large anonymous folio.
> 
> 
> Sorry, David,
> 
> Do you meaning there are 2 folio pages, in a same vma, in their address, 'ksm_scan.address', would be overlapped in a folio size space?
> If so, that do out of my expect. I do have no idea of this thing. Could you give me more hints of this problem or how things work on it in current kernel?

We do fully support partially mapping of THPs/large folios. That means, 
you could map a single page of a large pagecache folio and the other 
PTEs could map anonymous folios (due to COW).

Simply because follow_page() returned a page of a large folio doesn't 
generally say that the PTEs around it map the same large folio.

-- 
Cheers,

David / dhildenb


