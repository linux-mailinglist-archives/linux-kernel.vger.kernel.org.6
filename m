Return-Path: <linux-kernel+bounces-534352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F081A46618
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC79119E0200
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AA721CA0F;
	Wed, 26 Feb 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grMGqdZz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118C2206B9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585200; cv=none; b=BIHtKhP3dQgSJA/ceXBnfTtiGTp4LlMlDc4nomCvwZUT1sCrsMawfMYPX+wDgvSdB7Tn/0o0NNPwpLrCRbg/GJDX/od3mEYrR06EOZM/idgmSBU3ZTXK0KzWQjDV1Bsze7t86g5VvpsiWx0cupES79kQ3d3PHLTcrXF05ZyNexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585200; c=relaxed/simple;
	bh=wTsdTF16u65/Y+CX9CdqVHfx+CEvM0urJd9YEfBYzgM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=NvFeoPz+seapBoafvr71UmLwELQBUClEU1keljUQ1O+/TssDIny/aZq+ca99HRosVEpOSyc1sixwR+SBENgBziY15axjgFWk1tClmrWILpvMwQvrNrVufr/rjw5A3WWMhqYJtueYPs5KxMOgrBS4bW6R5QCNCQT8JoB237Ykl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grMGqdZz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740585196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KGGse01WduKshosn4qjhD+SLhctCsesJ1gZiUBZo8Wc=;
	b=grMGqdZzWpzVZ/CsiqGetsj8mNHAcRZC7y3iXnfR136AvObViu6C1tGNSOKQZuMlzCnU5S
	QjoaIaspreTRaHZmnvle/9I4JiXwCi3jwmxin6Qg3ITJxTkdJ6DGADhUYtYQOBqDteVPVE
	MG3gfo+7SS/OVrc7N7n4v1DRJwfGEbA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Qa4PKM3jPom9NJF1WhOLvQ-1; Wed, 26 Feb 2025 10:53:09 -0500
X-MC-Unique: Qa4PKM3jPom9NJF1WhOLvQ-1
X-Mimecast-MFC-AGG-ID: Qa4PKM3jPom9NJF1WhOLvQ_1740585188
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f4cce15c8so3240203f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585188; x=1741189988;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGGse01WduKshosn4qjhD+SLhctCsesJ1gZiUBZo8Wc=;
        b=k3hnT5dalRCh2Jm3q0WibA8Is2eKMMvO4YyS2AmOTSmcwHi4G7DiHESRbfHSSDCZ2C
         UYHBGpERx6oNSVQXlT8xj1YSfqMm3HNN5ct27gYo2FwjSynR4vZjJYOj0asRl9O6SKKZ
         ExFfaRhsbsSgTfTAi3tc5rJH6bXMAL4giFh7smKovN6gatjDQTJkpaN7Wg2sY6rcXP71
         WaQl+i40kk8ZV2x1/Yl06cWmKFupQ9i8Z7MLa+JDOr3bYno2jhsXFUQTqb5hbxbqZCL8
         LuRDIlni/YdYY2AlqwIEegf5LpW7WR8x+p3/+CFNfQcp6OxqxAYS5RHiC1c3hyf2VY9+
         hZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRSdhOItEs3Po5HON/k5Zkq0E3JHDUtBQ3ukfC9UH5FNFQ78uZ8qcvdvL4ar+LfJ0WVhNF6Z1kAkpm5DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPxxFjeZZYOc+X2tIBAdpkUewGjkO5xudP7ebucZzh4yx2WUW
	i606mx3JLI8zTQn79KOTV4GyxNwrL5KMLUzFKcCyiObF+MXT6C06ZTatQbwxmK1QepQqVl/XHNs
	qvX1AyBu6TFY7XMHSzMd/9SymrvFROQnhEWWEV1EX5CluSOQ502udYMJAvnK6Z0pqoUFDmWM4
X-Gm-Gg: ASbGncsqMaAsssRCsMU7bGz+H4FGbKYXDGBqU84BJyzz3bgYIklDmoFBVduUTfzsQOH
	qv4q8tcAsYgq2Oo58NjwNRAIc+0AyWDlwfnNgDdyMvjVInleF0qfu2PkAkXPO4xe0/fy3OwhWG6
	mA/36BEa1vfuiRzEkltLaBSHzbOmYofnaEgyxfwAgCFxl/47qfq8pjN+hRsYMnsFLyE3QWu+H4M
	1EqSEH/AOqw5dCHLMjppuHmhYvyh5Mf2LNXoEna/pMWOyFGUxfArwC36RXFR+uJWuwbioOYJdUw
	GV3wMDwUpCcEbg10Ysu/ptGKrDA4WLyOWh19JOtCJdlW5M2SWnz1FEnsezYKsVSqb3lxcGQ7R2X
	QrmfZdNnlFOVDuYmPTNdw+dYUffT8YQIcd1mshToFtFI=
X-Received: by 2002:a5d:6d09:0:b0:38f:48ee:ddb1 with SMTP id ffacd0b85a97d-390cc605103mr7456483f8f.18.1740585188365;
        Wed, 26 Feb 2025 07:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK4zfnnR8CAu3V9h2NS2dvAP4Rwtw49YB97rud2GxFfXSFEzoPYR6faR4SOiLAE6vvHxCTvw==
X-Received: by 2002:a5d:6d09:0:b0:38f:48ee:ddb1 with SMTP id ffacd0b85a97d-390cc605103mr7456459f8f.18.1740585187971;
        Wed, 26 Feb 2025 07:53:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45? (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8667d5sm6039474f8f.20.2025.02.26.07.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 07:53:07 -0800 (PST)
Message-ID: <8dd155b4-cdf5-42b9-9865-862184339fc2@redhat.com>
Date: Wed, 26 Feb 2025 16:53:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: make page_mapped_in_vma() hugetlb walk aware
From: David Hildenbrand <david@redhat.com>
To: Jane Chu <jane.chu@oracle.com>, willy@infradead.org, peterx@redhat.com,
 akpm@linux-foundation.org, linmiaohe@huawei.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250224211445.2663312-1-jane.chu@oracle.com>
 <0e825585-3421-4fa9-8912-41b936f29fae@redhat.com>
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
In-Reply-To: <0e825585-3421-4fa9-8912-41b936f29fae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.25 16:49, David Hildenbrand wrote:
> On 24.02.25 22:14, Jane Chu wrote:
>> When a process consumes a UE in a page, the memory failure handler
>> attempts to collect information for a potential SIGBUS.
>> If the page is an anonymous page, page_mapped_in_vma(page, vma) is
>> invoked in order to
>>     1. retrieve the vaddr from the process' address space,
>>     2. verify that the vaddr is indeed mapped to the poisoned page,
>> where 'page' is the precise small page with UE.
>>
>> It's been observed that when injecting poison to a non-head subpage
>> of an anonymous hugetlb page, no SIGBUS show up; while injecting to
>> the head page produces a SIGBUS. The casue is that, though hugetlb_walk()
>> returns a valid pmd entry (on x86), but check_pte() detects mismatch
>> between the head page per the pmd and the input subpage. Thus the vaddr
>> is considered not mapped to the subpage and the process is not collected
>> for SIGBUS purpose.  This is the calling stack
>>         collect_procs_anon
>>           page_mapped_in_vma
>>             page_vma_mapped_walk
>>               hugetlb_walk
>>                 huge_pte_lock
>>                   check_pte
>>
> 
> Why can't we require callers to never pass in subpages of hugetlb pages,
> and sanity check that this is the case?

To be precise: in collect_procs_anon() pass the head page of the hugetlb 
page, or in page_mapped_in_vma(), use the head page of the folio for 
hugetlb folios.

hugetlb folios are always entirely mapped, adding logic to detect if 
sub-pages are mapped doesn't make too much sense.

-- 
Cheers,

David / dhildenb


