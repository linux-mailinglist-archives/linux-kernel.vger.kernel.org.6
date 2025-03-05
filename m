Return-Path: <linux-kernel+bounces-547592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7637A50B61
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33741892604
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A0C1A23B1;
	Wed,  5 Mar 2025 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAYsqsU4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E61F9421
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202553; cv=none; b=t6S3+hOOM9hd27gSyYCeVHXZip4p8yvPphwNL+QoDSnjVVkFS1go5GermW6k7Dcfq+msjoDIQ6qSBycC5OOJv8LlxQT+vLCodcpo0TUXF+5yAwbbvu+TUCRyJno+I3nw/H8ppLOVDEfzKXmxCUbmGyMj2uia/v98GL7ZTf/e0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202553; c=relaxed/simple;
	bh=HdQsPTRd989+hkfShuv3Ys9GNVMQwiup5e3AtilmTRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mI6lgbaTR+At7noRVtto8BH7QZs2nAZmDoFNcV6S9fkCg5o24zKsuaLl6ZjeBVHcq9TX/4TaiksS/8n/+IBMvmLeQu9mkoFSfdq0q/wFDZdMNj9RPsQx68iMTMv0xIB2OqM/elsk8MSPcB8htzyQBUYqsvYGtTXVZnGjxLIIjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAYsqsU4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741202550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qSCeDmqIs0mapPQVCkqXEI9hpBAb0U2gsY/JPXiiuPQ=;
	b=iAYsqsU4jbcT4CYzoRWkc36KOX+bzh/PvPXldGfVC46PQkyFeEhvVClA6LtaQqgKTJ84K3
	bO8wXItJoE6V3oEOA0AO0Iow9hmRq4k7pXB3Xeq3do8ftOoVl5GWogiAfiyNgylWfTe9vo
	UmxxTiu9s6mhtiS61kSVsY/b5SeHzPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-BtboedsKNdyQAiTZnD8ybg-1; Wed, 05 Mar 2025 14:22:29 -0500
X-MC-Unique: BtboedsKNdyQAiTZnD8ybg-1
X-Mimecast-MFC-AGG-ID: BtboedsKNdyQAiTZnD8ybg_1741202548
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390e27150dbso6901036f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202548; x=1741807348;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qSCeDmqIs0mapPQVCkqXEI9hpBAb0U2gsY/JPXiiuPQ=;
        b=fi2kS6PROdtTjr+IbbraoNQtRaIIkxf2CkcH0H9mMdSakBzIow8/Fj9du/jiXMyUBR
         oRrW0BgeqSVijqP9ICj70fwLE5FdXAaShfPhlzNFlWHEhkTuatCOR/g4q2WfhF5CKO0h
         tcPfL5unyja91nEVlmohACIkY+5rXFnDCvhnQI9oy5bb1te2moMOXKc1IVDkK/oSLLYg
         +qS3KuWUIBBgPjdHWhG1Vu+FZyw7K3tIRi7tMty91PuVmkFCT3qKvBTtPWXZ4jyzE7Fj
         fyiI5qAfrLkq8TlbSwb+G9NtIpp9B8o45cioB/XgmPMYhUq1etQFa22C87wZMz4tLjcw
         ojJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLJa1MGhJ0eM5c4Zq1nE+13MYA6pUBPpjghrCOdImPUK0q457PD0dwifHODc+GSEBZUO5le1Hw/ujvT5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYhfwciEECOk050qewPQqQlZOI/29EXiqk1IrHz1ExkR7Bs5eb
	D5o8Mib5GWfyXWKcTC8+vup1i5nlT/aC1XsZl3nBZVwuv1obXlk8RJBiRe+VN9EqATbpIW2EYbi
	HqZLeqj+SCWG8n9d4g4CElP3Jq1QvpYLugJ3KB3CiAhjYvkETpk/Hlp6KNc0suw==
X-Gm-Gg: ASbGncsD2M9WprFMm2opYJpsnmZRINZSLrp13Y7ewfKxcBceqJu72tVs6ZBthwYeGh1
	V1LH7YhqRAGtFfgaogyZEIkbJ4JNafsR/dOhQSD5Jt2Wh6IQ9ON2Q1cvqCLAKotq7Cg/5btvLC7
	7inE3433NA5qgoFSx3SXRvT9VyDZnYBDLNuMakl6yMhAfs0fH2HDnlwtqSjkuygn6W3368S+GiT
	vXOPPGqfipxP3uC8iKou7fdKHhs3rsQVpGe5I8170IHZYPelaQkhRXJLY2HpoAtFKHuY3G82ZEh
	1iswtnFhD8w0E1vyTONDzcWDpvuYY2f55Sltp8Tzr8Bp
X-Received: by 2002:a05:6000:381:b0:390:ffa8:35ab with SMTP id ffacd0b85a97d-3911f738603mr4189442f8f.21.1741202547729;
        Wed, 05 Mar 2025 11:22:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKsRg0PtZ6BbY8yExiYwcY+eae4zmrkVNGVZSyudYptXMi30iBw+2oe72L6T0Q827KA8sDrA==
X-Received: by 2002:a05:6000:381:b0:390:ffa8:35ab with SMTP id ffacd0b85a97d-3911f738603mr4189417f8f.21.1741202547312;
        Wed, 05 Mar 2025 11:22:27 -0800 (PST)
Received: from [192.168.3.141] (p5b0c63d5.dip0.t-ipconnect.de. [91.12.99.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795983sm21731893f8f.6.2025.03.05.11.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:22:26 -0800 (PST)
Message-ID: <fece385c-f054-4dc0-a3fe-f2b4e2b07d05@redhat.com>
Date: Wed, 5 Mar 2025 20:22:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Xu <peterx@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
 <Z8HlL4FopVjeveaJ@x1.local>
 <60f148db-7586-4154-a909-d433bad39794@efficios.com>
 <Z8I5iU6y_nVmCZk6@x1.local>
 <72810548-b917-49b7-b7ef-043c6b395d31@efficios.com>
 <8cae1e56-239f-4f67-a18c-b4f4d09f40d0@redhat.com>
 <08506527-5d0b-44c7-9d09-a4d53b2fda2d@efficios.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <08506527-5d0b-44c7-9d09-a4d53b2fda2d@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.03.25 15:06, Mathieu Desnoyers wrote:
> On 2025-03-03 15:49, David Hildenbrand wrote:
>> On 03.03.25 21:01, Mathieu Desnoyers wrote:
>>> On 2025-02-28 17:32, Peter Xu wrote:
>>>> On Fri, Feb 28, 2025 at 12:53:02PM -0500, Mathieu Desnoyers wrote:
>>>>> On 2025-02-28 11:32, Peter Xu wrote:
>>>>>> On Fri, Feb 28, 2025 at 09:59:00AM -0500, Mathieu Desnoyers wrote:
>>>>>>> For the VM use-case, I wonder if we could just add a userfaultfd
>>>>>>> "COW" event that would notify userspace when a COW happens ?
>>>>>>
>>>>>> I don't know what's the best for KSM and how well this will work,
>>>>>> but we
>>>>>> have such event for years..  See UFFDIO_REGISTER_MODE_WP:
>>>>>>
>>>>>> https://man7.org/linux/man-pages/man2/userfaultfd.2.html
>>>>>
>>>>> userfaultfd UFFDIO_REGISTER only seems to work if I pass an address
>>>>> resulting from a mmap mapping, but returns EINVAL if I pass a
>>>>> page-aligned address which sits within a private file mapping
>>>>> (e.g. executable data).
>>>>
>>>> Yes, so far sync traps only supports RAM-based file systems, or
>>>> anonymous.
>>>> Generic private file mappings (that stores executables and libraries)
>>>> are
>>>> not yet supported.
>>>>
>>>>>
>>>>> Also, I notice that do_wp_page() only calls handle_userfault
>>>>> VM_UFFD_WP when vm_fault flags does not have FAULT_FLAG_UNSHARE
>>>>> set.
>>>>
>>>> AFAICT that's expected, unshare should only be set on reads, never
>>>> writes.
>>>> So uffd-wp shouldn't trap any of those.
>>>>
>>>>>
>>>>> AFAIU, as it stands now userfaultfd would not help tracking COW faults
>>>>> caused by stores to private file mappings. Am I missing something ?
>>>>
>>>> I think you're right.  So we have UFFD_FEATURE_WP_ASYNC that should
>>>> work on
>>>> most mappings.  That one is async, though, so more like soft-dirty.  It
>>>> might be doable to try making it sync too without a lot of changes
>>>> based on
>>>> how async tracking works.
>>>
>>> I'm looking more closely at admin-guide/mm/pagemap.rst and it appears to
>>> be a good fit. Here is what I have in mind to replace the ksmd scanning
>>> thread for the VM use-case by a purely user-space driven scanning:
>>>
>>> Within qemu or similar user-space process:
>>>
>>> 1) Track guest memory with the userfaultfd UFFD_FEATURE_WP_ASYNC
>>> feature and
>>>       UFFDIO_REGISTER_MODE_WP mode.
>>>
>>> 2) Protect user-space memory with the PAGEMAP_SCAN ioctl
>>> PM_SCAN_WP_MATCHING flag
>>>       to detect memory which stays invariant for a long time.
>>>
>>> 3) Use the PAGEMAP_SCAN ioctl with PAGE_IS_WRITTEN to detect which
>>> pages are written to.
>>>       Keep track of memory which is frequently modified, so it can be
>>> left alone and
>>>       not write-protected nor merged anymore.
>>>
>>> 4) Whenever pages stay invariant for a given lapse of time, merge them
>>> with the new
>>>       madvise(2) KSM_MERGE behavior.
>>>
>>> Let me know if that makes sense.
>>
>> Note that one of the strengths of ksm in the kernel right now is that we
>> write-protect + try-deduplicate only when we are fairly sure that we can
>> deduplicate (unstable tree), and that the interaction with THPs / large
>> folios is fairly well thought-through.
>>
>> Also note that, just because data hasn't been written in some time
>> interval, doesn't mean that it should be deduplicated and result in CoW
>> on next write access.
> 
> Right. This tracking of address range access pattern would have to be
> implemented in user-space.
> 
>> One probably would have to mimic what the KSM implementation in the
>> kernel does, and built something like the unstable tree, to find
>> candidates where we can actually deduplciate. Then, have a way to not-
>> deduplicate if the content changed.
> 
> With madvise MADV_MERGE, there is no need to "unmerge". The merge
> write-protects the page and merges its content at the time of the
> MADV_MERGE with exact duplicates, and keeps that write protected page in
> a global hash table indexed by checksum.

Right, and that's a real problem.

> 
> However, unlike KSM, it won't track that range on an ongoing basis.
> 
> "Unmerging" the page is done naturally by writing to the merged address
> range. Because it is write-protected, this will trigger COW, and will
> therefore provide a new anonymous page to the process, thus "unmerging"
> that page.
> 
> It's really just up to userspace to track COW faults and figure out
> that it really should not try to merge that range anymore, based on the
> the access pattern monitored through write-protection faults.
> 

Just to be clear, what you described here is very likely not 
performance-wise any feasible replacement for the in-tree ksm for the VM 
use case (again, the thing that was primarily invented for VMs).

-- 
Cheers,

David / dhildenb


