Return-Path: <linux-kernel+bounces-546601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC96A4FCB4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B313AAE7A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A597F20D514;
	Wed,  5 Mar 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgxtDRZb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F6207A25
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171607; cv=none; b=Rxu8+nsr6NVH3UbyeIlZYvVy9C4kFPwyLJx3hJ+oqDPOmYuGTj8rL7Igm9THiRhGWUygMSYROq2wAc6lOJBJw5tgDjQmr+swYbIqcmp0J58HwS0gzs4723Juk4Q6N/7Q/+sYJ+YdRVdcNKaCXbACoWBQ/WBP5UG1f9yZdJj0T8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171607; c=relaxed/simple;
	bh=GEodh96N/hMFbvMUkRs25+h3Qa1ZBZnrOl04ju1fwJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R7z93ceAnIBtuoE/E4IgmsUHvWtwzpDGNE0RQEvUBCgaa235r8tba7EcEfTDpuNGUPE8Wmc2AEHr/7y8tOCwYWIafo4xDRMYorTMtPZe7iDSYMmOY0PxrVHizj7ZLaxQ1ecY7xXujwy7W++iEIWBXEZfAGgfe/6VediMK8BE5XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgxtDRZb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741171605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9Hek7yRq/wtSkEAPYnA2mnc2+UFmv96A3d5UMG6XuPg=;
	b=RgxtDRZbmWSTAvx3XUxEqu5hpqt7h1J1uYhsqWZPQHLg9lOcxfnbTB/t+y7AT0XSHDAi5/
	TRUGg4bUL3UzmL7b4YMrCLArja/Tmln6rP5ttvUon82uhAsxPjCbYHDlKDQEhJhzvvYmpJ
	kCDnNK9cMqnv7XcyqdACRARa5jYqid8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-2ULRK7-YMHeHGTzsqe5dHw-1; Wed, 05 Mar 2025 05:46:44 -0500
X-MC-Unique: 2ULRK7-YMHeHGTzsqe5dHw-1
X-Mimecast-MFC-AGG-ID: 2ULRK7-YMHeHGTzsqe5dHw_1741171603
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so7885355e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 02:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741171603; x=1741776403;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Hek7yRq/wtSkEAPYnA2mnc2+UFmv96A3d5UMG6XuPg=;
        b=bN74BHAfDVpMh1abBVg3GQIo1wtP73f6e63tZLMJLLlSA/32lGXoZf3/9xqJL/gOSC
         yg9Tdl6GiEt+6qeh6TlilqGtLdlLX1Bwu/DEWUS4B/rrgvjJsL5BqzpgocQCoBIldqQd
         kNYIAoRgQXunJJmS+A5F3wHbewkgmJtyOdkUpFZEheL7pyF+oiHIt30mXQEs4IxGaafI
         RNejUmVOVBVYccrtoFmhgcuTfDyA8MOH+hJ7YbwGQStVs+jKc0ATKIYiw4vQWPR2Rn88
         A+vJMKpU6IFayEx0MQ97CfkwCyR6q8gQk9XEiXurKev5FZVC8MnjU32+EKKTFdE6q00Q
         GGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNV2D/HEWlQZQCsNf3/OankSnN5alZH7Pf4hl6+Q2t8J9qVuH5wshuovBP7OSf8CqKQReaOVAAfwVRPgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/EdbiPFxjuYtRa4/Zk9dAPFX1lKno5V1oD5BctmdI07jpKNE0
	Rk0fEZY/tn2xXQfPPu8QxKsdlY8r9wgHZdpUpornXWKzsR5IeZmZuo9PZx2usGw8ALeXWIi462L
	ji9C5qMyR1nQiZb6Xa1AoykqkFh2Pnr+tvjYSMCb5GqXUp8JiT64mDhuLqcdirQ==
X-Gm-Gg: ASbGnctw1pC+Qly5BuS+jOkavoVCiVLqJolJBCE2Fr/rqRLF7PdCCtAuDDtvLl7Dvdi
	g7f4g5W4mrRSdv359JsFlib2ZiUlM5yi38k/qevcTXsleyw0jyEilfvvvlZscCQqDbwzXgp5Wuj
	Zq/04srRx3N2oaFIDEmFyHxrja0/ommZd4sViwk7RGkbialcz8jiFzVEO/wKdaBQmUzvFcTRYzj
	DRJtWT+YTK3FXoKWNNFEqTX1xt5Bu6Cb/qMYO0uQCjn/Sn06EhLYYb3l4aFYb0r10jyx22Uf0nu
	iTrvicI4QnaX13Q4cwg0E3Aj198LX9IqMXprtnBLLeWvIATNYA==
X-Received: by 2002:a05:600c:35c2:b0:43b:a397:345f with SMTP id 5b1f17b1804b1-43bd2945a39mr23478465e9.11.1741171602810;
        Wed, 05 Mar 2025 02:46:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4OByu7oNh1SiBnLSXKDtowyLNgdmoAfAoBaNi7Vsjjg9e0WLIW7/7B54Ml/f2Jk3+UOp3WQ==
X-Received: by 2002:a05:600c:35c2:b0:43b:a397:345f with SMTP id 5b1f17b1804b1-43bd2945a39mr23478135e9.11.1741171602363;
        Wed, 05 Mar 2025 02:46:42 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd91338cesm96095e9.7.2025.03.05.02.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 02:46:41 -0800 (PST)
Message-ID: <8477d9ec-b9ce-4a3d-b61f-1bd44d3360a5@redhat.com>
Date: Wed, 5 Mar 2025 11:46:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] Plain dereference and READ_ONCE() in fault handler
To: Dev Jain <dev.jain@arm.com>, willy@infradead.org, ziy@nvidia.com,
 hughd@google.com, ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250305102159.96420-1-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250305102159.96420-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.25 11:21, Dev Jain wrote:
> In __handle_mm_fault(),
> 
> 1. Why is there a barrier() for the PUD logic?

Good question. It was added in

commit a00cc7d9dd93d66a3fb83fc52aa57a4bec51c517
Author: Matthew Wilcox <willy@infradead.org>
Date:   Fri Feb 24 14:57:02 2017 -0800

     mm, x86: add support for PUD-sized transparent hugepages

Maybe it was an alternative to performing a READ_ONCE(*vmf.pud).

Maybe it was done that way, because pudp_get_lockless() does not exist. 
And it would likely not be required, because on architectures where 
ptep_get_lockless() does some magic (see below, mostly 32bit), PUD THP 
are not applicable.


> 2. For the PMD logic, in the if block, we use *vmf.pmd, and in the else block
>     we use pmdp_get_lockless(); what if someone changes the pmd just when we
>     have begun processing the conditions in the if block, fail in the if block
>     and then the else block operates on a different pmd value. Shouldn't we cache
>     the value of the pmd and operate on a single consistent value until we take the
>     lock and then finally check using pxd_same() and friends?

The pmd_none(*vmf.pmd) is fine. create_huge_pmd() must be able to deal 
with races, because we are not holding any locks.

We only have to use pmdp_get_lockless() when we want to effectively 
perform a READ_ONCE(), and make sure that we read something "reasonable" 
that we can operate on, even with concurrent changes. (e.g., not read a 
garbage PFN just because of some concurrent changes)

We'll store the value in vmf.orig_pmd, on which we'll operate and try to 
detect later changes using pmd_same(). So we really want something 
consistent in there.

See the description above ptep_get_lockless(), why we cannot simply do a 
READ_ONCE on architectures where a PTE cannot be read atomically (e.g., 
8 byte PTEs on 32bit architecture).

-- 
Cheers,

David / dhildenb


