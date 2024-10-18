Return-Path: <linux-kernel+bounces-370872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A749A331D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC4C2832E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAFE14E2E8;
	Fri, 18 Oct 2024 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JqfmJcNX"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD282BAEF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220330; cv=none; b=iFmS/B/r3GLffKwyloQED+h4Z/Y0flxXMxfJfgFdNcdqiY/u7UOZYWEXPuA0YA8j9OYwsvwXv367MyC3PRGbt0wYnCKKw2acqy8R+deWXQNjFLGoXMeBhgwDFQeeWeNYrQXrPmOdR3qbobL2Am9WJl9MZbJ735WNmNnNKKSVVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220330; c=relaxed/simple;
	bh=yh2do4g280QhZR8j0PLP3kWM+6HO3M6zOWaKp6SVWVg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iC2Ism4UYx1TXseOwgLfOWqVbbkDiayS6B72F4dAdtku7Gxt7ox5OVSYVqQPzhEL/+SYQcQerdbiL6TvWMlbpOc+2sKVfkN81Z37qj90W7B89QvATOED7oIObUXqsz2PioJKwDnlpg1fSKltYxWTXp44m/MyV9z1i/2bB/3QVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JqfmJcNX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea7d509e61so840945a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729220328; x=1729825128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwyzH+PQsFeYWv/1M1l2ZyltnCIO+EcAW6jhl5pXyOU=;
        b=JqfmJcNX1LANjX6NVeNTE6WHDoj9OyJ+o1swdewvWXVwESRREBP8IiEowPilnTSKXT
         dB4Ffe0ymU1mDV8NCXfyQ1eYRoLi0MQt4LcRGZ79HXWqMyuKXN4wr95pVGFITeDOm3Xl
         Ertfv8+WJMt3uz/VIWHaPWiVEuMjftZzxRbxhfcAQl4GPH1CmJdXyZGleLiMnD+kbYTG
         l79nI7BnlSIF4+oY4CMAQEpHzF9r4pbQhSszsnwrZFpdbHQkEkjqncpo5TOVNPw0gjQh
         pZ4Nhki1rqs9HkmPXKKJvM9Qc+cgVFdsLkA5VyzMtE6oR9D910TWhymuGI06dgzn3qcn
         q+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729220328; x=1729825128;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwyzH+PQsFeYWv/1M1l2ZyltnCIO+EcAW6jhl5pXyOU=;
        b=qqcRyezlNfMR0Ubvh+C6EgiZpHwif4WvTPXITi1hNxl95Lze/ooO/pRBEZ16IpDAbD
         4rBaFChFJfurF8hQ6rhBZWWRJRownhTMpUxHP45alzWThwMthDGrqOSS9OcJt/W7Si1n
         QTzGeb55uBuCNh4RwONhQIXYTNtRVHIgmx8+z/wHA/NRlr3m4xRA/j+SFAPCZOTPMAHT
         Uyp49fWjF9xfjO0hvQGhKVV719ccyr8yb+SVagFLUnozdCwEGIfo+HEil1aKX9LNvKuL
         Dexwlm2HIacwnDauRwgyf//Cf3FLN/KCJ7eCG+Ts9cPmxSxTGh5XtnjduhAbK/+2HBAk
         w7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv0HT3az+Dd9zUjb5VZpUbqROLXLP0lU6bRezgv4x53wY98NtonOy/tmZ4unZihRkh+CnQfpP2I01yBog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIwsGNr4KOQ3qcRR+1+xhSqBcqcpENBW61PdmDMM6CZwf1JaK
	hc6fcBRK5CG0zLjOlLcQsLafgIkgfAmj4KimS4n6n/tMDFXa78j+NXADFh9qVWU=
X-Google-Smtp-Source: AGHT+IGadGFVRM42mB61gyRJVOgsPCIBYVeKqm+uIwglN5rQCNOJRYXAKXI8WfaP/3JsMFJ7EZHc/A==
X-Received: by 2002:a05:6a21:478a:b0:1d9:ce8:35c1 with SMTP id adf61e73a8af0-1d92c4e064emr1358466637.11.1729220328049;
        Thu, 17 Oct 2024 19:58:48 -0700 (PDT)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5611fede6sm526840a91.30.2024.10.17.19.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 19:58:47 -0700 (PDT)
Message-ID: <32c14642-462d-4b29-bcf2-997c068d0f59@bytedance.com>
Date: Fri, 18 Oct 2024 10:58:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] mm: pgtable: try to reclaim empty PTE page in
 madvise(MADV_DONTNEED)
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: Jann Horn <jannh@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
 <6c7fe15b0434a08a287c400869f9ba434e1a8fa3.1729157502.git.zhengqi.arch@bytedance.com>
 <CAG48ez3MLMXZvkbPGZ4He2+tnOSHYxA68Sa1Hd_70-3a8K++=A@mail.gmail.com>
 <8068329c-c71c-469e-b2b7-5cb2e9d9671e@bytedance.com>
In-Reply-To: <8068329c-c71c-469e-b2b7-5cb2e9d9671e@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/18 10:53, Qi Zheng wrote:
> 
> 
> On 2024/10/18 02:43, Jann Horn wrote:
>> +arm64 maintainers in case they have opinions on the break-before-make 
>> aspects
>>

[snip]

>>> +
>>> +       pmd_clear(pmd);
>>> +
>>> +       if (ptl != pml)
>>> +               spin_unlock(ptl);
>>> +       spin_unlock(pml);
>>
>> At this point, you have cleared the PMD and dropped the locks
>> protecting against concurrency, but have not yet done a TLB flush. If
>> another thread concurrently repopulates the PMD at this point, can we
>> get incoherent TLB state in a way that violates the arm64
>> break-before-make rule?
>>
>> Though I guess we can probably already violate break-before-make if
>> MADV_DONTNEED races with a pagefault, since zap_present_folio_ptes()
>> does not seem to set "force_flush" when zapping anon PTEs...
> 
> Thanks for pointing this out! That's why I sent a separate patch
> discussing this a while ago, but unfortunately haven't gotten any
> feedback yet, please take a look:
> 
> https://lore.kernel.org/lkml/20240815120715.14516-1-zhengqi.arch@bytedance.com/

More context here: 
https://lore.kernel.org/lkml/6f38cb19-9847-4f70-bbe7-06881bb016be@bytedance.com/

> 
> Thanks!
> 
>>
>> (I realize you're only enabling this for x86 for now, but we should
>> probably make sure the code is not arch-dependent in subtle
>> undocumented ways...)
>>
>>> +       free_pte(mm, addr, tlb, pmdval);
>>> +
>>> +       return;
>>> +out_ptl:
>>> +       pte_unmap_unlock(start_pte, ptl);
>>> +       if (pml != ptl)
>>> +               spin_unlock(pml);
>>> +}
>>> -- 
>>> 2.20.1
>>>

