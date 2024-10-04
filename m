Return-Path: <linux-kernel+bounces-350164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C8C9900B4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942B31F24CCA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2190A14A4D0;
	Fri,  4 Oct 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJBI1mOq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B36146A83
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037016; cv=none; b=VW+a3Af92AIGEHuRamI6EPE4n27gIJcl0F0t9XpKPkGiPhCezgidnQ6wiFsrfYh5pHPY+tJFOzIq5ztx2ugKDceFJLJ88DuIT9J/qNvgBzyhO+JatMyskDq/nnHyTEIYzQs0WJRXnZz+G71yuyELVMz97c7RXNN76J3R70c4Hl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037016; c=relaxed/simple;
	bh=cq9jFgrOfqAx20FwhuUVZ3cnLf/ZA0L0QQwQk850CEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVojmRcM3sD0p7abeT+2roeR8jEBzD8TrYaxwng0IPtLi2YKfF3Xovx1cVUPv1qs81Ns1na+Hiqi2uvweHY1A4f9EB5gjzCFoF8BSZdGjkw/6CyQcDUp0/OgUzk0F32Xh85i9MVjklHOsA6+UoIDDcqdIqu1s+Vy1W5COGC4FRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJBI1mOq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728037013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N6GdPppOtfNFlPAW8QqgLW9SMnDwDrKhqWMr9Q52wtc=;
	b=gJBI1mOqtSeD28x+ALnwHOy6AIBAvHvRef3kk56cVZaeBqMpRnw1SfRLwvPu3dyV9t2iPA
	7pWbZtmlHE41iHhVRhufKs608dU7HLnXGuVY4PrOLohA068kw82zgshZx9B+a72AflA6xW
	rOgX2UEDYgPDNRk/gvDKgik8rpE3kjg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-BLGDvzwsM_OpsnuuSjkCEA-1; Fri, 04 Oct 2024 06:16:52 -0400
X-MC-Unique: BLGDvzwsM_OpsnuuSjkCEA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37cd23c9226so1279131f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 03:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037011; x=1728641811;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N6GdPppOtfNFlPAW8QqgLW9SMnDwDrKhqWMr9Q52wtc=;
        b=e091O9bQ1IdlqK64VqXABm4of6cwvbCOyWDrnQaBC4DnAp9fKz/7nF+C/952EqT8ev
         0abn5ftLEOe8ddwzZXyVs8lMIBzBARb7MUFVvXpZmI4OW1aD7vHr6p3rN7MuZ1ynXe0y
         o9lwzYFqIhk6A7yTtWlICy0eZGaUBJxKfNg7Rv/ciiVsAHN2YEVhViFrdHZ9i//Rx9MY
         wZqHmHPxBT3EEWh/SqAM/dKhG0zb/WIHo4ezP46UfLR074Jn1+sLBUgMkaH+3bIqOIu/
         jFrngwgVimwtLXQXX27BUad3znGXcKImf2fQM2E4Mv808PuZSFh1WxOPOTeYWwax2l+L
         y44A==
X-Forwarded-Encrypted: i=1; AJvYcCXWMHN6jBJ8VFvJzUSKIOxVA7b3Dm0/4so65djflmyNob1Oy4OGJ1EVVGQ8K0s4QCFYbljLc2JJbumDboE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcugRyAS+eFhMPcoV+0asa3O/eiWFVJMxOYi0f5rkgMOrIZ65Z
	Zw5EyUSwoRE0CC9slXIvJWgAnfiqon7ZO5aeiWAJKKF8Nz2L79hySJnrwOo1VpJd582guyLKAMt
	pdg6gRCM15PlohH8LhndHiiNS521vhGxy7BVa1oWjJa+1RWvBDMkiQ/T9hMP7eA==
X-Received: by 2002:a5d:6712:0:b0:37c:cbc8:d278 with SMTP id ffacd0b85a97d-37d0f720694mr1484688f8f.31.1728037010938;
        Fri, 04 Oct 2024 03:16:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtZyajR3+mxi/ZK+zxsj1WAEzIlwoFAl8KsGpsQtrVS19gXMrixju930maqzL3ETEmhJDRzQ==
X-Received: by 2002:a5d:6712:0:b0:37c:cbc8:d278 with SMTP id ffacd0b85a97d-37d0f720694mr1484663f8f.31.1728037010564;
        Fri, 04 Oct 2024 03:16:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:d00:a1ab:bff4:268f:d7c5? (p200300cbc7140d00a1abbff4268fd7c5.dip0.t-ipconnect.de. [2003:cb:c714:d00:a1ab:bff4:268f:d7c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082a6992sm2944433f8f.68.2024.10.04.03.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 03:16:50 -0700 (PDT)
Message-ID: <4865b333-60c2-4bad-850d-5f8550f5a59e@redhat.com>
Date: Fri, 4 Oct 2024 12:16:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
To: Dan Williams <dan.j.williams@intel.com>, Huang Ying
 <ying.huang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, linux-coco@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Kai Huang <kai.huang@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>
References: <20240930055112.344206-1-ying.huang@intel.com>
 <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
 <66fb9a89dd814_964fe294ed@dwillia2-xfh.jf.intel.com.notmuch>
 <c9dcdc44-7031-4541-96a2-70a071accb61@redhat.com>
 <66fbade318730_964f2294d1@dwillia2-xfh.jf.intel.com.notmuch>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <66fbade318730_964f2294d1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.10.24 10:08, Dan Williams wrote:
> David Hildenbrand wrote:
>> On 01.10.24 08:45, Dan Williams wrote:
>>> David Hildenbrand wrote:
>>>> On 30.09.24 07:51, Huang Ying wrote:
>>>>> On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
>>>>> hot-added must be checked for compatibility by TDX.  This is currently
>>>>> implemented through memory hotplug notifiers for each memory_block.
>>>>> If a memory range which isn't TDX compatible is hot-added, for
>>>>> example, some CXL memory, the command line as follows,
>>>>>
>>>>>      $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
>>>>>
>>>>> will report something like,
>>>>>
>>>>>      bash: echo: write error: Operation not permitted
>>>>>
>>>>> If pr_debug() is enabled, the error message like below will be shown
>>>>> in the kernel log,
>>>>>
>>>>>      online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
>>>>>
>>>>> Both are too general to root cause the problem.  This will confuse
>>>>> users.  One solution is to print some error messages in the TDX memory
>>>>> hotplug notifier.  However, memory hotplug notifiers are called for
>>>>> each memory block, so this may lead to a large volume of messages in
>>>>> the kernel log if a large number of memory blocks are onlined with a
>>>>> script or automatically.  For example, the typical size of memory
>>>>> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
>>>>> will be logged.
>>>>
>>>> ratelimiting would likely help here a lot, but I agree that it is
>>>> suboptimal.
>>>>
>>>>>
>>>>> Therefore, in this patch, the whole hot-adding memory range is checked
>>>>> for TDX compatibility through a newly added architecture specific
>>>>> function (arch_check_hotplug_memory_range()).  If rejected, the memory
>>>>> hot-adding will be aborted with a proper kernel log message.  Which
>>>>> looks like something as below,
>>>>>
>>>>>      virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX for TDX compatibility.
>>>>    > > The target use case is to support CXL memory on TDX enabled systems.
>>>>> If the CXL memory isn't compatible with TDX, the whole CXL memory
>>>>> range hot-adding will be rejected.  While the CXL memory can still be
>>>>> used via devdax interface.
>>>>
>>>> I'm curious, why can that memory be used through devdax but not through
>>>> the buddy? I'm probably missing something important :)
>>>
>>> TDX requires memory that supports integrity and encryption. Until
>>> platforms and expanders with a technology called CXL TSP arrives, CXL
>>> memory is not able to join the TCB.
>>>
>>> The TDX code for simplicity assumes that only memory present at boot
>>> might be capable of TDX and that everything else is not.
>>
>> So is there ever a chance where add_memory() would actually work now
>> with TDX? Or can we just simplify and unconditionally reject
>> add_memory() if TDX is enabled?
> 
> Only if the memory address range is enumerated by the platform firmware
> (mcheck) at boot time.
> 
> This will eventually be possible with the CXL dynamic-capacity (DCD)
> capability once CXL TSP arrives. In that scenario the CXL DCD expander
> is brought into the TCB at boot time and assigned a fixed address range
> where future memory could arrive. I.e. the CXL device is brought into
> the TCB at boot, but the memory it provides can arrive later.
> 
>>> Confidential VMs use guest_mem_fd to allocate memory, and that only
>>> pulls from the page allocator as a backend.
>>>
>>> This ability to use devdax in an offline mode is a hack to not
>>
>> Thanks, I was missing the "hack" of it, and somehow (once again) assumed
>> that we would be hotplugging memory into confidential VMs.
> 
> When / if dynamic capacity and this security-protocol for CXL arrives
> that may yet happen. For now it is safe to block adding anything which
> mcheck does not like which is everything but memory present at boot
> (is_tdx_memory()).

Makes sense, thanks!

-- 
Cheers,

David / dhildenb


