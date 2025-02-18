Return-Path: <linux-kernel+bounces-519632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE1A39FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998D91884E97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6679526A0D1;
	Tue, 18 Feb 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4ICD+62"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC3267B94
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889328; cv=none; b=Gk4LcgTFr/QzFqbkNd10nM9C30yiZS5QK4FshGTyRdotaoIb03xzp5DuqDm6hbdCt+LRFN2ZfZnhc/YgkARrVgTpN5m54JwCoFYZft3GLYuhQ2hQotxdKbVTTr1J1tL36EBj8CaLpftmiUKG4cdVzfUqr7++0tvFUTCkH8tKBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889328; c=relaxed/simple;
	bh=BZJVcic6DcAWJNzoMClc6kls9c2veIURLxuU379/2dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pK25bQ7SiWaZPKqVYG6yOqEnr4RF5D+Lzx3lMYloaXXw5scIiffIJykkwEgopN7NuHiiAzCXiTx3tSFSwdG4rfhXWKQxCqgTfr/NjE77ZXATVJbb44aFUo3MICdqGuQcY6LEDrI+2qq9bZy2iguKo+K44YOAhZOKH3B/wc8DMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4ICD+62; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739889325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2BBgcXRJrBgS4bqLk6IB+Bu0JRKwgATueMPPbzZjJrI=;
	b=O4ICD+62XP5+5+BJGGJ0EuxF3CM5/9JTzkT9MqpfJOPbUKFN+npxSaQK5fo0QPQF0s+YtD
	ZvLdTgp3j/2Vsb1pW+NmkwYwXzidwAjY4eGH0kWYtR08mYWPZK3TIil2fUt2480d4CXPGs
	TPV2vQgO8eNd7nJVpj3hQo3JVI3i4M8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-R5kqbmCJPSKPlcB6x5RnWA-1; Tue, 18 Feb 2025 09:35:24 -0500
X-MC-Unique: R5kqbmCJPSKPlcB6x5RnWA-1
X-Mimecast-MFC-AGG-ID: R5kqbmCJPSKPlcB6x5RnWA_1739889323
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f45a86efdso1205237f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889323; x=1740494123;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2BBgcXRJrBgS4bqLk6IB+Bu0JRKwgATueMPPbzZjJrI=;
        b=uVoKRrrDHo+wl5rfR45RRn1Cs0iOwBye40kwHcu5+rp5upN3WN6K6/iqvCagPOU4zX
         IG/504OxyiC1digQIPdXHk/9876in1/zxPgVrAudbSV3tJFyPASHBB4u0F91/Yg6Qkbj
         M2jHoR3L5kOR3vfacJ5s6FdK16v1QC+xahyKmsprUyLMPxO2r8qNihaSVBfG0c+tRK8c
         u2qqcFZAinvRy63m4FsJJQcsEG7rqRqUrhG79HhvZzcpqrtfe/E8KeQv28XjvR/U4pCk
         aolzPsg8fanmtBVR5RFswFImettdsomWiiKwMiiqpdepCfYSmF3Db4n/zFgeXUCMvWv1
         wjAw==
X-Forwarded-Encrypted: i=1; AJvYcCX3NLxavk5Pot1J3Ayt0ayqHB+HAIACSTkPcy7P87aRXnoS9M/m3e/X2TmeFqTN97aa3m0LzLFnkl6QiMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbxcINmw/+WPBsziPYxP9rB0s8fiTTUq5y8xnP43PQYe4Q0w1n
	TltGw6LLTRK8in8sGaY4eg9OCrmSzBJuY1UsjhjgyJYTq2QtcJ8o7EUjDGAFdFUOGS8x4MFlxnr
	DGOetwo5hScKdGRkpiJdFy9LKy4O6C5tdDBM9RyYxi9/uGvUJ7ymNzTL7QdDx2A==
X-Gm-Gg: ASbGncs7aC5S895G5qkIJEawui8XTy80L1icaff9zqcoR5s4ru5Eb0r4xp9Vk7sA8wb
	jUS3MoD72rRN7XIKezpoFBfDfmaY0inOA1SfutkWAGmzKDjYROQS3l7JkRWPGE5zvrcpmd1ZscM
	9lC0/sukMIgR+OJF05t+OCOW8zIKNneAXlePocpWaV+oFTg16uT7fBzrJGw+hPL4Rp/MEnMffKu
	AcjY7xL51jqEt6qzBT/OlF/bo4Rz/sem3g0fpJx3xlQosFdf4VwIgW0D4ZU5USo5XpxAoOY+xrl
	OD5AKV4nALKwn0Zg0GPu5O9GTMAJVIHH2ZDy58yu8p0A59+dnu7fBVy5NloODfiLTgs2P8aDHxP
	lUuRbYu92OdYWvzKjIDFQj7tygP4jSwfD
X-Received: by 2002:a5d:64c2:0:b0:38f:452f:9f89 with SMTP id ffacd0b85a97d-38f452fa26cmr7672910f8f.50.1739889322680;
        Tue, 18 Feb 2025 06:35:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECohohAOqe4JhXJYwDCfx/E8JPPIGDkcaVLHfskcflyFiuSiy2JNsExexnSee00wptapNfFA==
X-Received: by 2002:a5d:64c2:0:b0:38f:452f:9f89 with SMTP id ffacd0b85a97d-38f452fa26cmr7672875f8f.50.1739889322290;
        Tue, 18 Feb 2025 06:35:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5655sm15145789f8f.77.2025.02.18.06.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 06:35:21 -0800 (PST)
Message-ID: <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
Date: Tue, 18 Feb 2025 15:35:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
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
In-Reply-To: <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.02.25 14:05, Lorenzo Stoakes wrote:
> On Tue, Feb 18, 2025 at 01:12:05PM +0100, Vlastimil Babka wrote:
>> On 2/13/25 19:16, Lorenzo Stoakes wrote:
>>> The guard regions feature was initially implemented to support anonymous
>>> mappings only, excluding shmem.
>>>
>>> This was done such as to introduce the feature carefully and incrementally
>>> and to be conservative when considering the various caveats and corner
>>> cases that are applicable to file-backed mappings but not to anonymous
>>> ones.
>>>
>>> Now this feature has landed in 6.13, it is time to revisit this and to
>>> extend this functionality to file-backed and shmem mappings.
>>>
>>> In order to make this maximally useful, and since one may map file-backed
>>> mappings read-only (for instance ELF images), we also remove the
>>> restriction on read-only mappings and permit the establishment of guard
>>> regions in any non-hugetlb, non-mlock()'d mapping.
>>
>> Do you plan to address mlock later too? I guess somebody might find use for
>> those. Is there some fundamental issue or just that we need to define some
>> good semantics for corner cases? (i.e. if pages are already populated in the
>> mlocked area, discarding them by replacing with guard pte's goes against
>> that, so do we allow it or not?).
> 
> Yeah that's the fundamental issue with mlock, it does not interact with the
> zapping part of MADV_GUARD_INSTALL, and that is why we disallow it (but not so
> for MADV_GUARD_REMOVE, as if a VMA that contains guard regions is locked
> _afterwards_ there will be no zapping).
> 
> We could potentially expose an equivalent, as there are for other flags, a
> _LOCKED variant of the madvise() flag, like MADV_GUARD_INSTALL_LOCKED to make
> this explicit.
> 
> That is probably the most sensible option, if there is a need for this!

mlock is weird, because it assumes that memory will be faulted in in the whole VMA.

You'd likely have to populate + mlock the page when removing the guard.
Also not sure what happens if one does an mlock()/mlockall() after
already installing PTE markers.

__mm_populate() would skip whole VMAs in case populate_vma_page_range()
fails. And I would assume populate_vma_page_range() fails on the first
guard when it triggers a page fault.

OTOH, supporting the mlock-on-fault thingy should be easy. That's precisely where
MADV_DONTNEED_LOCKED originates from:

commit 9457056ac426e5ed0671356509c8dcce69f8dee0
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Thu Mar 24 18:14:12 2022 -0700

     mm: madvise: MADV_DONTNEED_LOCKED
     
     MADV_DONTNEED historically rejects mlocked ranges, but with MLOCK_ONFAULT
     and MCL_ONFAULT allowing to mlock without populating, there are valid use
     cases for depopulating locked ranges as well.


Adding support for that would be indeed nice.

-- 
Cheers,

David / dhildenb


