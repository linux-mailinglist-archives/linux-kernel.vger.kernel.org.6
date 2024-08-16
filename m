Return-Path: <linux-kernel+bounces-289362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B2B95454F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1711C20F99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B3313D89D;
	Fri, 16 Aug 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aWebtcI3"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6E83CD4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800127; cv=none; b=kNtooPL9EiCvMGzu5q0IrdJTRr0kdxaEOOnf7Nkfo823c/o5n+aGbtMEWZCYHd/kkb9rbhPLhLSLCoV00U7nC1/beoQtTp9VtSWy5NRYLgLZSc7KpgmZeRHH+j3zvoeAV6mkgsHGPYWE1CeYHGbJb8E80ejNhWYllndop4Ob6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800127; c=relaxed/simple;
	bh=oakmK+aKmPzzkbmwITb5Ei5wXJ8szQVTQ7c7wCs5K34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QX4FuGmA65E3n0qpyzyrvIrF2z201E5DMZuzo+G+nN1AT9Hs1x4ERHAu6u8RJYuG2UT4XZySmWTXEgg8D+HsLuCkWdatWaQzs2/T0+ZcPoH5cFAdNzS8+pdjVO21GDYRQv/4Q4QT4NrpTzdT1nG/WNOxwlvypDQ+rMB7RM9yBIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aWebtcI3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c2595f5c35so231466a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723800124; x=1724404924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtCmVrlxGAafWsgKl5/YAKGcZ+iOciR4h5L3r6w+vzE=;
        b=aWebtcI3ZzRzgtF6gbigdK3xKIczQO+jlaEpAL0spPM657ekiOIHgzoxwUtM2kh3Ae
         l+Q9ir5T1uTh+J249Y26Kl9g58rb1oFjL5dVHT6+ntMbIFdkgQT49BSqSxArLaGK238L
         mIMZ5OWcJqhDKOJ9diDabE6PYcuu8JUqYbH0OzKIiG4Dt7GC6GOkk4/rwcFIoPaCdJL/
         dmYSqHWQvoJ0Om8x4rnxo7pvCenN1Af3D1XSzqfD2+3OP7oIDK3L1HAjM3AOhpfgZNgQ
         sgiA3OAI3UssOtyiSsbh70y+rqriP+xXJGzVpl1+6Qd3Z+hxX7vFSn6e8WEqzunGN+oe
         Hhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723800124; x=1724404924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtCmVrlxGAafWsgKl5/YAKGcZ+iOciR4h5L3r6w+vzE=;
        b=wBq6QJTfR7FML8L2cQWAelQnucIk+vnCCvuT8nR4IHonyUUTBxvaf9mW8i5TYAW+kC
         HHjRmLpAJLXTQnhGQYzbsvt59RILEha+Fk70J1D18diRMgUX4ycL5jLUakoR9eGzkORr
         Npnk4Gfos1JuSxACTC1n8tJ8AcIB1dPPfvibVoWCMCH/s6XhS/Vt7sBeQsLCUXJvDgiS
         ETV7EKDwA0awE2TQxhdEVQd2taVWYRvGINGnSxjETJARfBIp6+YQZWVV7AFX7a5Jxo60
         nsGVrGXkmBXG4zrvbgwYOX14MH3wEqDwAuhKcQzSG00JzGiYW+FOhwIg0y2qsEGc78/Y
         53ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7uo1U6yvyUq1q/kMagJ0E0XfqQkecZljZ6n9Ut+LWxYUHbJdeQsHrz0xzQShMnZL/f7X9NaeX+fcEXSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTf2CGcWtQesS3HsrSoAlPffxc8voftamMKGwq3mA9Mq2/2uq
	voIlhNSAm43dQixNqcVfQyP7C5KlvU51Umdrwh9jk3dcqRk3sPZNWMldCaXFp4w=
X-Google-Smtp-Source: AGHT+IGT9XwetaYpGzKxUO2gEEcbAPqXHSAiilZKZwdN/lLLvJXKcLaqrWJkuf3lLTP329x8W0xo8w==
X-Received: by 2002:a05:6a21:3282:b0:1c4:c4cc:fa49 with SMTP id adf61e73a8af0-1c905075655mr1544270637.7.1723800124099;
        Fri, 16 Aug 2024 02:22:04 -0700 (PDT)
Received: from [10.4.217.215] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03795edsm21965795ad.153.2024.08.16.02.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 02:22:03 -0700 (PDT)
Message-ID: <a3862b3f-ef26-46f8-a09e-5484fe3c495b@bytedance.com>
Date: Fri, 16 Aug 2024 17:21:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] mm: pgtable: make pte_offset_map_nolock()
 return pmdval
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <d101b185eb55438b18faa2029e4303b7453bd5f5.1722861064.git.zhengqi.arch@bytedance.com>
 <0e8e0503-5796-4b61-bb5b-249e285f5d21@redhat.com>
 <39281a4d-d896-46fd-80a5-8cd547d1625f@bytedance.com>
 <0f467510-a0d0-4a98-8517-43813fa4c131@redhat.com>
 <f6c05526-5ac9-4597-9e80-099ea22fa0ae@bytedance.com>
 <f79bbfc9-bb4c-4da4-9902-2e73817dd135@redhat.com>
 <3e8253c4-9181-4027-84ee-28e1fc488f61@bytedance.com>
 <ebb35909-1c12-48e0-8788-824c5f7f629e@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ebb35909-1c12-48e0-8788-824c5f7f629e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2024/8/16 16:59, David Hildenbrand wrote:
> On 12.08.24 08:21, Qi Zheng wrote:
>> Hi David,
>>
>> On 2024/8/10 00:54, David Hildenbrand wrote:
>>> On 07.08.24 05:08, Qi Zheng wrote:
>>>> Hi David,
>>>>
>>>> On 2024/8/6 22:16, David Hildenbrand wrote:
>>>>> On 06.08.24 04:40, Qi Zheng wrote:
>>>>>> Hi David,
>>>>>>
>>>>>> On 2024/8/5 22:43, David Hildenbrand wrote:
>>>>>>> On 05.08.24 14:55, Qi Zheng wrote:
>>>>>>>> Make pte_offset_map_nolock() return pmdval so that we can 
>>>>>>>> recheck the
>>>>>>>> *pmd once the lock is taken. This is a preparation for freeing 
>>>>>>>> empty
>>>>>>>> PTE pages, no functional changes are expected.
>>>>>>>
>>>>>>> Skimming the patches, only patch #4 updates one of the callsites
>>>>>>> (collapse_pte_mapped_thp).
>>>>>>
>>>>>> In addition, retract_page_tables() and reclaim_pgtables_pmd_entry()
>>>>>> also used the pmdval returned by pte_offset_map_nolock().
>>>>>
>>>>> Right, and I am questioning if only touching these two is sufficient,
>>>>> and how we can make it clearer when someone actually has to recheck 
>>>>> the
>>>>> PMD.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Wouldn't we have to recheck if the PMD val changed in more cases 
>>>>>>> after
>>>>>>> taking the PTL?
>>>>>>>
>>>>>>> If not, would it make sense to have a separate function that
>>>>>>> returns the
>>>>>>> pmdval and we won't have to update each and every callsite?
>>>>>>
>>>>>> pte_offset_map_nolock() had already obtained the pmdval previously,
>>>>>> just
>>>>>> hadn't returned it. And updating those callsite is simple, so I think
>>>>>> there may not be a need to add a separate function.
>>>>>
>>>>> Let me ask this way: why is retract_page_tables() and
>>>>> reclaim_pgtables_pmd_entry() different to the other ones, and how 
>>>>> would
>>>>> someone using pte_offset_map_nolock() know what's to do here?
>>>>
>>>> If we acuqire the PTL (PTE or PMD lock) after calling
>>>> pte_offset_map_nolock(), it means we may be modifying the corresponding
>>>> pte or pmd entry. In that case, we need to perform a pmd_same() check
>>>> after holding the PTL, just like in pte_offset_map_lock(), to prevent
>>>> the possibility of the PTE page being reclaimed at that time.
>>>
>>> Okay, what I thought.
>>>
>>>>
>>>> If we call pte_offset_map_nolock() and do not need to acquire the PTL
>>>> afterwards, it means we are only reading the PTE page. In this case, 
>>>> the
>>>> rcu_read_lock() in pte_offset_map_nolock() will ensure that the PTE 
>>>> page
>>>> cannot be reclaimed.
>>>>
>>>>>
>>>>> IIUC, we must check the PMDVAL after taking the PTL in case
>>>>>
>>>>> (a) we want to modify the page table to turn pte_none() entries to
>>>>>        !pte_none(). Because it could be that the page table was
>>>>> removed and
>>>>>        now is all pte_none()
>>>>>
>>>>> (b) we want to remove the page table ourselves and want to check if it
>>>>>        has already been removed.
>>>>>
>>>>> Is that it?
>>>>
>>>> Yes.
>>>>
>>>>>
>>>>> So my thinking is if another function variant can make that clearer.
>>>>
>>>> OK, how about naming it pte_offset_map_before_lock?
>>>
>>> That's the issue with some of the code: for example in
>>> filemap_fault_recheck_pte_none() we'll call pte_offset_map_nolock() and
>>> conditionally take the PTL. But we won't be modifying the pages tables.
>>>
>>> Maybe something like:
>>>
>>> pte_offset_map_readonly_nolock()
>>>
>>> and
>>>
>>> pte_offset_map_maywrite_nolock()
>>>
>>> The latter would require you to pass the PMD pointer such that you have
>>> to really mess up to ignore what to do with it (check PMD same or not
>>> check PMD same if you really know what you are douing).
>>>
>>> The first would not take a PMD pointer at all, because there is no 
>>> need to.
>>
>> These two function names LGTM. Will do in the next version.
> 
> That is probably something you can send as a separate patch independent 
> of this full series.

I think it makes sense. I am analyzing whether the existing path of
calling pte_offset_map_nolock + spin_lock will be concurrent with
the path of reclaiming PTE pages in THP. If so, it actually needs to
be fixed first.

> 
> Then we might also get more review+thoughts from other folks!

I hope so!

Thanks,
Qi

> 

