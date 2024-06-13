Return-Path: <linux-kernel+bounces-212953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F409068C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E3E1C2415F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7570D84D03;
	Thu, 13 Jun 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iD6YySQ3"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB2381C4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271159; cv=none; b=VXJg5xHtBsPFIlUA2mmgYRZLI5S5pS8k0OPHTFQO8AsB5900kly3T/hTE2QWQmQfysubcb3mfa+bfE8h6UMPdRrwgh1n7D+d1cyvTAVlH0QOtvfwNA612NrPSDCLGk19BthGirDNsq0J6cyxG+gOqMN3qckSiKEnCq3g4Jvdov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271159; c=relaxed/simple;
	bh=8daAuNTWkQPXp9NVB+V4Lx6lezYM/eZE2pCm1YvCXcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBK4NSaafwudyZqe5jeox0kHE15qwtTXMKMQBvqC6M/nJClgJjmeqtxTivSaAUlC5oW46W66P/dpmZRG+JLAgtVxjrTyyDnkOWGA5JrSu47XD3/gs6D+Frs8lZVTJGCx4M/l56n/vliQYcvKaSBMUDtT5tsRjnSFDVgxTfyoxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iD6YySQ3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f64a3e5d6fso564115ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718271156; x=1718875956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ST1cCivPhMFN53Rm65k70JPSTUTIoB61iuRO5jRUrI=;
        b=iD6YySQ3VTOlQZZva/L0Um1zsPW0NdHEyt0mFx+HKNfgNg9QXTC/T17qe2jI1Z3B6/
         SiTv377GXqMaWEZ0oWrCKCT1Mq12Y/u5QVef7BDbRn9NDeGCtkrtDsOviQ2XuF4YqW/u
         QpGt7SWlKqFX10m9SKhB3HsbUAEOETBqySCeNRg9VXxHrJjxmUNCkjmMuKJbZjRFqcue
         ukTAiTMmNsZKREzBJssiKmtGjRwxoYgtTG8F75IEWiSMPAdshIEioDRJ1z/i2P2+fgKI
         ViKOb94E+UUmt/asW97UUgxLpNJ/ueiHygXQbF2PpLPxw8w4Xqz/0nYcm7um2RUr4OGe
         sNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718271156; x=1718875956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ST1cCivPhMFN53Rm65k70JPSTUTIoB61iuRO5jRUrI=;
        b=wlxRP8OOvk2+Lx8uLs77ZGbqjyOguGMn2iYkex7fYVNW6kg9h1MojIloHhqZaptXTx
         j2Due8N8C1Zy5+krInrtj7iqacVoa8rDaMDosroYOCzLicxAnWK7CTHqRE3+FgtmIhAi
         upnSEmjN/6wWLpx81c8YOjF9NXrDGxJ/xzNPFF7l5r+AlGlaeOOpu3UhheUDhxykSwUC
         qzRbiacCUXm906SIhoFj+Qpy4GXT+4/lsPouR7yPaB+q5nJnXypdFlCve1DSMXM/m1ph
         StljaYcX29kfHi0Q8+oQBAo1ggO3t3Z0ZIRCv0BURqXbc3A9Fw+FK3CqZ66raA1YWSP1
         Ufgg==
X-Forwarded-Encrypted: i=1; AJvYcCWmbmHnHKEpMAxh/qR+0qMt0MxqaMW5vGmurjzkUYPVCaRx3ER+gOWR/pHgOxoeX6XFj9nfMts+H+Yne9oQ2wsAwWjNmdprbIuD1+El
X-Gm-Message-State: AOJu0YyZq93kGKITLSSVEeHdx5ELEjYmLm3ViLU/oeA36GSSkwLSvnQO
	jfOMekaQFnh4RV9kdzfJibMSJhsK4bDQj4qWqAY/s0xWSRG2YncGiTA+Cfh3RqQ=
X-Google-Smtp-Source: AGHT+IHNgM8CZ35kGrHdPnwg9elcRUwx1Uix+OiDO+zmRbp69PP6whHf/TrJP9NaKX2VA1DFmQYGyw==
X-Received: by 2002:a05:6a20:dd9e:b0:1b5:ae2c:c730 with SMTP id adf61e73a8af0-1b8a9c5107cmr3926222637.3.1718271156437;
        Thu, 13 Jun 2024 02:32:36 -0700 (PDT)
Received: from [10.84.144.49] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedcf36b93sm731870a12.18.2024.06.13.02.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 02:32:36 -0700 (PDT)
Message-ID: <efac94f6-2fb3-4682-a894-7c8ffac18d20@bytedance.com>
Date: Thu, 13 Jun 2024 17:32:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
 <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

Thanks for such a quick reply!

On 2024/6/13 17:04, David Hildenbrand wrote:
> On 13.06.24 10:38, Qi Zheng wrote:
>> Hi all,

[...]

> 
> 
>> 3. Implementation
>> =================
>>
>> For empty user PTE pages, we don't actually need to free it 
>> immediately, nor do
>> we need to free all of it.
>>
>> Therefore, in this patchset, we register a task_work for the user 
>> tasks to
>> asyncronously scan and free empty PTE pages when they return to user 
>> space.
>> (The scanning time interval and address space size can be adjusted.)
> 
> The question is, if we really have to scan asynchronously, or if would 
> be reasonable for most use cases to trigger a madvise(MADV_PT_RECLAIM) 
> every now and then. For virtio-mem, and likely most memory allocators, 
> that might be feasible, and valuable independent of system-wide 
> automatic scanning.

Agree, I also think it is possible to add always && madvise modes
simliar to THP.

> 
>>
>> When scanning, we can filter out some unsuitable vmas:
>>
>>      - VM_HUGETLB vma
>>      - VM_UFFD_WP vma
> 
> Why is UFFD_WP unsuitable? It should be suitable as long as you make 
> sure to really only remove page tables that are all pte_none().

Got it, I mistakenly thought pte_none() covered pte marker case until
I saw pte_none_mostly().

> 
>>      - etc
>> And for some PTE pages that spans multiple vmas, we can also skip.
>>
>> For locking:
>>
>>      - use the mmap read lock to traverse the vma tree and pgtable
>>      - use pmd lock for clearing pmd entry
>>      - use pte lock for checking empty PTE page, and release it after 
>> clearing
>>        pmd entry, then we can capture the changed pmd in 
>> pte_offset_map_lock()
>>        etc after holding this pte lock. Thanks to this, we don't need 
>> to hold the
>>        rmap-related locks.
>>      - users of pte_offset_map_lock() etc all expect the PTE page to 
>> be stable by
>>        using rcu lock, so use pte_free_defer() to free PTE pages.
> 
> I once had a protoype that would scan similar to GUP-fast, using the 
> mmap lock in read mode and disabling local IRQs and then walking the 
> page table locklessly (no PTLs). Only when identifying an empty page and 
> ripping out the page table, it would have to do more heavy locking (back 
> when we required the mmap lock in write mode and other things).

Maybe mmap write lock is not necessary, we can protect it using pmd lock
&& pte lock as above.

> 
> I can try digging up that patch if you're interested.

Yes, that would be better, maybe it can provide more inspiration!

> 
> We'll have to double check whether all anon memory cases can *properly* 
> handle pte_offset_map_lock() failing (not just handling it, but doing 
> the right thing; most of that anon-only code didn't ever run into that 
> issue so far, so these code paths were likely never triggered).

Yeah, I'll keep checking this out too.

> 
> 
>> For the path that will also free PTE pages in THP, we need to recheck 
>> whether the
>> content of pmd entry is valid after holding pmd lock or pte lock.
>>
>> 4. TODO
>> =======
>>
>> Some applications may be concerned about the overhead of scanning and 
>> rebuilding
>> page tables, so the following features are considered for 
>> implementation in the
>> future:
>>
>>      - add per-process switch (via prctl)
>>      - add a madvise option (like THP)
>>      - add MM_PGTABLE_SCAN_DELAY/MM_PGTABLE_SCAN_SIZE control (via 
>> procfs file)
>> Perhaps we can add the refcount to PTE pages in the future as well, 
>> which would
>> help improve the scanning speed.
> 
> I didn't like the added complexity last time, and the problem of 
> handling situations where we squeeze multiple page tables into a single 
> "struct page".

OK, except for refcount, do you think the other three todos above are 
still worth doing?

Thanks,
Qi

> 

