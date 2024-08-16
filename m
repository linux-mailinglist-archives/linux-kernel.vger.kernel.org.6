Return-Path: <linux-kernel+bounces-289458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E87D95466C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11A2B2339D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B042174EF0;
	Fri, 16 Aug 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RKX0YJgb"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CA1741F8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802495; cv=none; b=g+Vl2yWiGFGVpBbr2LN3YeLVNOoD2CT8yrUNAS95scMSTWUcPItDvZDRGgeNqLZGfwFC6FnruLNK0evDEsvJk7mr6IoaCkf9pOCMiC1WPHPDULlyUs6FPO9KBnC6D7UuY2uvBQR5v2xghe3fIljwDF+LFvARJdjgbC8XZ6iKzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802495; c=relaxed/simple;
	bh=MZG3ZLBSSjRav2Xt3WnJFaID/5oO/PDGBtkB0OJlUkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIox/srW9chTcxfDmIAwV6MQc6I2bC5yJzEKkX525/USHoJYybvm8jVQhol4lRbE5fTEPZb4ZW6i9qjGLFrr5Dn2l7nYh18b7rNlwn6soJIXR/ziVJAfYodLqmSeuCxGAHKbEOse+Jr42OS0BJp5yk4qOlDJSXu01VuBzL9rNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RKX0YJgb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d21b41907so62571b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723802492; x=1724407292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IMWTPRSAk9N52PXD8ydpMbUch6FgKKveeU8k/beHs8=;
        b=RKX0YJgb4wM+t6DQBF/kztyvlTPRu7YNnJKeH75cCMvpPtd5Sc08MlYAKuTUBytq4Z
         Nl1uSpIT3ZL3tXVtrS6HBcyjKu5JqZ03fgySQtqm1YyUnPsm1Sf2ymqeatSSOIFVzWBG
         vyPqSS8kOo5+lFGzzun99/QgQzsUH/WfVZzak4Gx2KtpqiKJaRQMhPdC+SvnxKR/JNl+
         qFvVbepbCXX4amcBQLvIsGJ4NexBd6Z5ZbhYHtWX0omxjHFsVj1uU1tXwvuNpiLSdXXK
         nsec30o8RHcOjQ3TP7DqBvGmad/+5+zIL9nlm8XTrR2572tb3xf30+78KA5Lmi+FIChm
         vgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723802492; x=1724407292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IMWTPRSAk9N52PXD8ydpMbUch6FgKKveeU8k/beHs8=;
        b=KEv4KinN37ZohUW/lGRkUJWHdhNPfORry0dYxYGpqtlIfuCf/N0y7ffShvobEVca01
         CFOibi2RzA9/pXV4zewE/gbxUC1LwoSYQNS4vIblce/4+WggI+DsZuhJE5aB24GTEL1B
         cvGrgura+ycTKRbAOqHJkiEL03SIdqe89Ajlcyjh+fBFUNNmGPh+wJRCDZCugO1q4Wgl
         H/behtUEFmWuDBrmwuMV70zDHtzexAoa6RxmGZjS0AuhXnX5+XEsWsqQQ4DtaI9u3Bu7
         sOtvX9LZmnIkdjYk9zdlzdAuspSLLimP1gFEqwJhW+HMVS2UXROe4Fzhiekhno2Hu40O
         1Dbg==
X-Forwarded-Encrypted: i=1; AJvYcCUhIM2U+rBrEnFrIpxS2yvndtEKE3blJxlG10eEk5+cbeqdzRLF0BU7xvySBISYTfJbUcVUzcnLGJg1IJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTjxsOICYSliYf50xFwecCBvYzCRzkm8bTEx5uHaJlozJznme
	YD6ASdjQOjJV+EA9dcZQLftpyd5xpw1XibImxhfprSWjvu4cQ9CrsRLheFr4Luc=
X-Google-Smtp-Source: AGHT+IGn7siiYZKSdptG0iTW/5aC2xIy3KY1wn6ID5R2LIvd9qecVPoNESLmMsoDkUCKVWscblbfog==
X-Received: by 2002:a05:6a21:3282:b0:1c4:c4cc:fa49 with SMTP id adf61e73a8af0-1c905075655mr1591320637.7.1723802492470;
        Fri, 16 Aug 2024 03:01:32 -0700 (PDT)
Received: from [10.4.217.215] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d97f97sm1416941a91.50.2024.08.16.03.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 03:01:31 -0700 (PDT)
Message-ID: <860f45d7-4d75-4d67-bf2a-51f6000cd185@bytedance.com>
Date: Fri, 16 Aug 2024 18:01:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/7] mm: pgtable: try to reclaim empty PTE pages in
 zap_page_range_single()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <9fb3dc75cb7f023750da2b4645fd098429deaad5.1722861064.git.zhengqi.arch@bytedance.com>
 <2659a0bc-b5a7-43e0-b565-fcb93e4ea2b7@redhat.com>
 <42942b4d-153e-43e2-bfb1-43db49f87e50@bytedance.com>
 <b0b39543-498d-4b08-a864-b05be45f617d@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <b0b39543-498d-4b08-a864-b05be45f617d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/16 17:22, David Hildenbrand wrote:
> On 07.08.24 05:58, Qi Zheng wrote:
>> Hi David,
>>
> 
> Really sorry for the slow replies, I'm struggling with a mixture of 
> public holidays, holiday and too many different discussions (well, and 
> some stuff I have to finish myself).
> 
>> On 2024/8/6 22:40, David Hildenbrand wrote:
>>> On 05.08.24 14:55, Qi Zheng wrote:
>>>> Now in order to pursue high performance, applications mostly use some
>>>> high-performance user-mode memory allocators, such as jemalloc or
>>>> tcmalloc. These memory allocators use madvise(MADV_DONTNEED or 
>>>> MADV_FREE)
>>>> to release physical memory, but neither MADV_DONTNEED nor MADV_FREE 
>>>> will
>>>> release page table memory, which may cause huge page table memory 
>>>> usage.
>>>>
>>>> The following are a memory usage snapshot of one process which actually
>>>> happened on our server:
>>>>
>>>>           VIRT:  55t
>>>>           RES:   590g
>>>>           VmPTE: 110g
>>>>
>>>> In this case, most of the page table entries are empty. For such a PTE
>>>> page where all entries are empty, we can actually free it back to the
>>>> system for others to use.
>>>>
>>>> As a first step, this commit attempts to synchronously free the 
>>>> empty PTE
>>>> pages in zap_page_range_single() (MADV_DONTNEED etc will invoke 
>>>> this). In
>>>> order to reduce overhead, we only handle the cases with a high
>>>> probability
>>>> of generating empty PTE pages, and other cases will be filtered out, 
>>>> such
>>>> as:
>>>
>>> It doesn't make particular sense during munmap() where we will just
>>> remove the page tables manually directly afterwards. We should limit it
>>> to the !munmap case -- in particular MADV_DONTNEED.
>>
>> munmap directly calls unmap_single_vma() instead of
>> zap_page_range_single(), so the munmap case has already been excluded
>> here. On the other hand, if we try to reclaim in zap_pte_range(), we
>> need to identify the munmap case.
>>
>> Of course, we could just modify the MADV_DONTNEED case instead of all
>> the callers of zap_page_range_single(), perhaps we could add a new
>> parameter to identify the MADV_DONTNEED case?
> 
> See below, zap_details might come in handy.
> 
>>
>>>
>>> To minimze the added overhead, I further suggest to only try reclaim
>>> asynchronously if we know that likely all ptes will be none, that is,
>>
>> asynchronously? What you probably mean to say is synchronously, right?
>>
>>> when we just zapped *all* ptes of a PTE page table -- our range spans
>>> the complete PTE page table.
>>>
>>> Just imagine someone zaps a single PTE, we really don't want to start
>>> scanning page tables and involve an (rather expensive) walk_page_range
>>> just to find out that there is still something mapped.
>>
>> In the munmap path, we first execute unmap and then reclaim the page
>> tables:
>>
>> unmap_vmas
>> free_pgtables
>>
>> Therefore, I think doing something similar in zap_page_range_single()
>> would be more consistent:
>>
>> unmap_single_vma
>> try_to_reclaim_pgtables
>>
>> And I think that the main overhead should be in flushing TLB and freeing
>> the pages. Of course, I will do some performance testing to see the
>> actual impact.
>>
>>>
>>> Last but not least, would there be a way to avoid the walk_page_range()
>>> and simply trigger it from zap_pte_range(), possibly still while holding
>>> the PTE table lock?
>>
>> I've tried doing it that way before, but ultimately I did not choose to
>> do it that way because of the following reasons:
> 
> I think we really should avoid another page table walk if possible.
> 
>>
>> 1. need to identify the munmap case
> 
> We already have "struct zap_details". Maybe we can extend that to 
> specify what our intention are (either where we come from or whether we 
> want to try ripping out apge tables directly).
> 
>> 2. trying to record the count of pte_none() within the original
>>      zap_pte_range() loop is not very convenient. The most convenient
>>      approach is still to loop 512 times to scan the PTE page.
> 
> Right, the code might need some reshuffling. As we might temporary drop 
> the PTL (break case), fully relying on everything being pte_none() 
> doesn't always work.
> 
> We could either handle it in zap_pmd_range(), after we processed a full 
> PMD range. zap_pmd_range() knows for sure whether the full PMD range was 
> covered, even if multiple zap_pte_range() calls were required.
> 
> Or we could indicate to zap_pte_range() the original range. Or we could 
> make zap_pte_range() simply handle the retrying itself, and not get 
> called multiple times for a single PMD range.
> 
> So the key points are:
> 
> (a) zap_pmd_range() should know for sure whether the full range is
>      covered by the zap.
> (b) zap_pte_range() knows whether it left any entries being (IOW, it n
>      never ran into the "!should_zap_folio" case)
> (c) we know whether we temporarily had to drop the PTL and someone might
>      have converted pte_none() to something else.
> 
> Teaching zap_pte_range() to handle a full within-PMD range itself sounds 
> cleanest.

Agree.

> 
> Then we can handle it fully in zap_pte_range():
> 
> (a) if we had to leave entries behind (!pte_none()), no need to try
>      ripping out the page table.

Yes.

> 
> (b) if we didn't have to drop the PTL, we can remove the page table
>      without even re-verifying whether the entries are pte_none(). We

If we want to remove the PTE page, we must hold the pmd lock (for
clearing pmd entry). To prevent ABBA deadlock, we must first release the
pte lock and then re-acquire the pmd lock + pte lock. Right? If so, then
rechecking pte_none() is unavoidable. Unless we hold the pmd lock + pte
lock in advance to execute the original code loop.

>      know they are. If we had to drop the PTL, we have to re-verify at
>     least the PTEs that were not zapped in the last iteration.
> 
> 
> So there is the chance to avoid pte_none() checks completely, or minimze 
> them if we had to drop the PTL.
> 
> Anything I am missing? Please let me know if anything is unclear.
> 
> Reworking the retry logic for zap_pte_range(), to be called for a single 
> PMD only once is likely the first step.

Agree, will do.

> 
>> 3. still need to release the pte lock, and then re-acquire the pmd lock
>>      and pte lock.
> 
> Yes, if try-locking the PMD fails.
> 

