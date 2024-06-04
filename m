Return-Path: <linux-kernel+bounces-200674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83438FB355
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C347DB218FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0328146591;
	Tue,  4 Jun 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMCmZCxy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0498BF7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506875; cv=none; b=PsHDF/X5xykt2UostJ5mcKNax0eAXAxG7l0Jmf2n45L8S8ZhamUTs/btXFnVtma1+LIVRBbJ/PA+so5xnZf9QUZs2j1JIUdcepo4PEoPNaQIW7SktB9tJu/llY6uJdbWw+3r/yDupBcfNZQsNgt3iG/YE+rcwMXb1Ea4OW0UgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506875; c=relaxed/simple;
	bh=xFq6rC/NfxmfGTWLn6azWFOoOM3m+tOW3yOJT3C9yA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A5FxoNwUEkOrzRy5mKKADH/Ht6eHaVTsZJGuAOwHZgqYdEbT7bdunbn5g0Xkz/8QCKsc/8yiIUAR90GD3Kt7GK9Ccyt6IBU01weGn3uEJ41DY5bqpL1uMiK1rgj4oy1ji7KBZqq3Nd/oAfJdezlcwROgJQgkGrKOQlxAZxbF9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMCmZCxy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717506872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LQiuJa6XjEMGh17HerZFZUVv0NCVs36LUrZfs91xsUU=;
	b=TMCmZCxy0dPTSTcJj7sirYz1LozUKxSu4I4vLAz5deEOxlXvRCWY06WuEoTMG8KDM+um90
	xpSEfKgL+MMBbuJbGl+ghNAfMKSM13ta1QG5Qm0Adu7yDEHhQ7HNgFt+5u36yOg5aq5ww+
	XwwWBfW0i5znVkQ2S1FDUpANrw3kjts=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-tQTLBkO3NnyIHL3TTXfNJg-1; Tue, 04 Jun 2024 09:14:30 -0400
X-MC-Unique: tQTLBkO3NnyIHL3TTXfNJg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42117a61bccso42619455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506869; x=1718111669;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQiuJa6XjEMGh17HerZFZUVv0NCVs36LUrZfs91xsUU=;
        b=kQeyO3PFxiMMNMv0wxF0duzrMs82321c9rUzw18ddAMzP+TvGo/+bBe3oE3625t1QD
         YqnqEB1l+Z2SaDVef5U3IR2Bb2fq//o9dwHk5wmgEgK4+Z4UpS2nG4Hraw0eAVq7qo3e
         fNCj4oT2lZD24dknX7v6I1ESVXdsvd5VTCAOF7qMhkJjQ+SfbYWx+xJHzAMEKqPyXZGw
         70nkfRrmn1RfNLEUzjQSAJV0ub9kwEJo5GwXHC7+8ceci+m+m9LDLc9S2G7m1xymMfS1
         o5rXIVdCVbhlH8H2SN3ieUTagv698woFhR+jDk/6cTP42OPLBXA/mwRyBizYzjM9MsEa
         77AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUaSSoX1+W4MhW0EDtNFXjvkm1NM1iatDA6H231ceUB33nUbiavU1/+1HsvPXT8AlQSyxfC2n/y5d24n+TZHVd5YuMHRqQyN99hzdB
X-Gm-Message-State: AOJu0YyNCSzHkrlcqx/j5WFUb0TFMhgWFtqnJcvOqVxKVrNFtH8HkDQl
	PT36GhR8ArH2BgSdSVtVGMMM69f0eXFw+oVGY5HSJOsbu6jYbbb0yXZbLJvOgLvLyhw3A1fMCpI
	8RKs9l19rHyA9oUqfTNtZfKytkfz8VUdNeht4EEssuxQ0HyIiWWNDXUtLVAs2DA==
X-Received: by 2002:a7b:ce10:0:b0:421:2a14:3132 with SMTP id 5b1f17b1804b1-4212e0a52c3mr100630245e9.25.1717506869329;
        Tue, 04 Jun 2024 06:14:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5wn67LsGXw7ypMf8z9AKW2X8rC2HJnPZGHC9fa6Le3AhDS/bTwE5fFsT6+1/khMWDkAeS4g==
X-Received: by 2002:a7b:ce10:0:b0:421:2a14:3132 with SMTP id 5b1f17b1804b1-4212e0a52c3mr100630005e9.25.1717506868895;
        Tue, 04 Jun 2024 06:14:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d94f1sm11446657f8f.49.2024.06.04.06.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 06:14:28 -0700 (PDT)
Message-ID: <3d2ad8a3-30c6-41d6-841b-e8c376d01da3@redhat.com>
Date: Tue, 4 Jun 2024 15:14:27 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9f4f6f0e-81e8-4bd0-9f20-412a543a452d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.06.24 15:10, Alex Shi wrote:
> 
> 
> On 6/4/24 6:43 PM, David Hildenbrand wrote:
>>>>>
>>>>> @@ -2680,7 +2685,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>>>>                 }
>>>>>     next_page:
>>>>>                 put_page(*page);
>>>>> -            ksm_scan.address += PAGE_SIZE;
>>>>> +            ksm_scan.address += nr * PAGE_SIZE;
>>>>>                 cond_resched();
>>>>>             }
>>>>>         }
>>>>
>>>> You might be jumping over pages that don't belong to that folio. What you would actually want to do is somehow use folio_pte_batch() to really know the PTEs point at the same folio, so you can skip them. But that's not that easy when using follow_page() ...
>>>>
>>>> So I suggest dropping this change for now.
>>>>
>>>
>>> Hi David,
>>>
>>> Forgive my stupidity, where I jump over normal page that not to belong to the folio?
>>
>> IIUC, you assume that the folio is fully mapped by all PTEs that could span it, and that follow_page() would give you the head page, correct?
>>
>> As a simple example, assume only a single page of a large folio is still mapped, which could be any tail page. You couldn't jump over any PTEs.
>>
>> Or am I missing something?
> 
> Uh, thanks for explanations. for what's we concerned, the following code could take care of the FULL or ERR pages. And it still keep the step of single page.
>                          page = follow_page(vma, ksm_scan.address, FOLL_GET);
>                          if (IS_ERR_OR_NULL(page)) {
>                                  ksm_scan.address += PAGE_SIZE;
>                                  cond_resched();
>                                  continue;
>                          }
> And after the above code, step folio_nr_pages on address should be safe, isn't it?

Not sure if I follow. Let me try explaining once again:

Assume a PTE maps some tail page of the large anonymous folio. The other 
PTEs around it map some other anonymous folios, not pages of that large 
anonymous folio.

Without looking at the other PTEs you don't know how much you can skip.

-- 
Cheers,

David / dhildenb


