Return-Path: <linux-kernel+bounces-350167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F789900CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D85281A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5448314C582;
	Fri,  4 Oct 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i96KRLQI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B914A609
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037282; cv=none; b=g9AMJ0DK1GfarJe42edAlWCp0Vv7JKaYcD9NiW4m9YDzlQPdetg30pzSv/lnuRLxgUrnYNNua/jLQuOG5me8yS74tC8+Sd3n+wIOeC2NtWyc0lCKhKOASuinIzJRwaoFHsuhqClhoOIWVJfgMEmAUbmOP1aGGNOOZR4I0erQrT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037282; c=relaxed/simple;
	bh=lYFiNt9nmnAQqQ6uDn5FswnQ4PPGAo0L/6uvXle2yMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzjrSOY5qVj9EqmHgdR3dCLk0DzUO4yuubXgQbaD3dUhvvy8cmatLI/lEOlyT3QcCI8SDXL38ypch8ghaLK2W5RzluCDfEGM9eAY6MEOCDxAFMZIpY/llSHM46PEMdnYtYxSedjqZfDjiE6vbsNeaEZB0L4lBLj0VP9iBkmYAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i96KRLQI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728037279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ItcLhmC8kaffrLJ2Dm6Z6QEFSQlbuw+pIggrwFvXTZY=;
	b=i96KRLQIp4yzBRlYncwkUiWYK+j4y+QmKS2ZwMlN4jL54Ug7YahVYoHWG3cSNfNMZGz8xs
	JKof6a1UF3I3GGrR4m3iQlmJOBYSRP9LhkPQknYYM4XvqD1xSuZ6MleCtiKESLs9OdNAv2
	rnEeBmhEy9ke7Odmfy8Bht4zirWW99o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-9GQcmmFvMNuLPBvy0AcgEQ-1; Fri, 04 Oct 2024 06:21:18 -0400
X-MC-Unique: 9GQcmmFvMNuLPBvy0AcgEQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so18626875e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 03:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037277; x=1728642077;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ItcLhmC8kaffrLJ2Dm6Z6QEFSQlbuw+pIggrwFvXTZY=;
        b=vEWuK/rM3+LJkuLh9lzYCJsTi807IkIl871ZqRXB3/Wxmaw2nxDpbaT1wbO/jE3Gjk
         QHTtF3rvLx1PoE7UeepsP8ZWsnSYgTFsjPpoHnj6AaaJy2QBSBSZ9Tea7I1bgMD7+0Sy
         HbCGWyu7rPFMdFNGg0jHb7objmefV9z3GzptMD+zmqS1OOqegej3B2UJkr+SbYXzFZnU
         c9xdSD1ZDjakm+JIgyN0Ot0V4Fcs/7aFu4g7X7WbVSMtQm9MZIrI3w+a6DYrONnI0s+o
         g4P8UC3/MV7B7WN1OpavDsXmpIei0NtOQCrlikFXPcSvsLK5kMHNJBgCDcjtP2j0/vCx
         Szfg==
X-Forwarded-Encrypted: i=1; AJvYcCXGoKZKIe55vUv8iCYd3E3CeeDNml7FlGqGwBENVMaACQypIrrkuEGRSnyExHKIVvrAWnKMPX1nzZzvGtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegKF7YUJTgnX/KseKSodfCvhpMy2j0QBUayySuu6PlC536e5j
	ixSvSJyw1CePLBGro8cqh8qWJpR+Cu0qgBIHesDgyPPv9tmAoj/FFZ36tnPkhm1GLlds4mhUGSQ
	LnI4rciUWuTM38nFNwo5SynYHTA/zw4P/75hkWpLvD+avWvQapy27UR5Zm63Bhun+6qI/eIgM
X-Received: by 2002:a05:600c:3ba9:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-42f85a6e0c0mr21343035e9.1.1728037277050;
        Fri, 04 Oct 2024 03:21:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERgQ2dFRFh8SMJSUJsxcC2XaIZK0l7gMRKVSU3qIssWcQj3uzeBu4dUWeVBnCQvBjb+K7xgA==
X-Received: by 2002:a05:600c:3ba9:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-42f85a6e0c0mr21342735e9.1.1728037276515;
        Fri, 04 Oct 2024 03:21:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:d00:a1ab:bff4:268f:d7c5? (p200300cbc7140d00a1abbff4268fd7c5.dip0.t-ipconnect.de. [2003:cb:c714:d00:a1ab:bff4:268f:d7c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d672sm12081605e9.28.2024.10.04.03.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 03:21:16 -0700 (PDT)
Message-ID: <22d1cfbf-b195-4343-b87b-493cb3d2843b@redhat.com>
Date: Fri, 4 Oct 2024 12:21:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
To: Dan Williams <dan.j.williams@intel.com>, Yang Shi <shy828301@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
References: <20240930055112.344206-1-ying.huang@intel.com>
 <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
 <8734lgpuoi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHbLzkp_SyRBR+JsxMwM_qKpF=8+TU=36hDY6TuKMHdnLnyxAg@mail.gmail.com>
 <66ff297119b92_964f2294c6@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHbLzkoR1pT1NEL7qAYi+JXOsB7O0FnHyHFOJ+4eZf9vf5K6Wg@mail.gmail.com>
 <66ff5dd3b9128_964fe294ca@dwillia2-xfh.jf.intel.com.notmuch>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <66ff5dd3b9128_964fe294ca@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.10.24 05:15, Dan Williams wrote:
> Yang Shi wrote:
>> On Thu, Oct 3, 2024 at 4:32 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>>
>>> Yang Shi wrote:
>>>> On Mon, Sep 30, 2024 at 4:54 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>
>>>>> Hi, David,
>>>>>
>>>>> Thanks a lot for comments!
>>>>>
>>>>> David Hildenbrand <david@redhat.com> writes:
>>>>>
>>>>>> On 30.09.24 07:51, Huang Ying wrote:
>>>>>>> On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
>>>>>>> hot-added must be checked for compatibility by TDX.  This is currently
>>>>>>> implemented through memory hotplug notifiers for each memory_block.
>>>>>>> If a memory range which isn't TDX compatible is hot-added, for
>>>>>>> example, some CXL memory, the command line as follows,
>>>>>>>     $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
>>>>>>> will report something like,
>>>>>>>     bash: echo: write error: Operation not permitted
>>>>>>> If pr_debug() is enabled, the error message like below will be shown
>>>>>>> in the kernel log,
>>>>>>>     online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
>>>>>>> Both are too general to root cause the problem.  This will confuse
>>>>>>> users.  One solution is to print some error messages in the TDX memory
>>>>>>> hotplug notifier.  However, memory hotplug notifiers are called for
>>>>>>> each memory block, so this may lead to a large volume of messages in
>>>>>>> the kernel log if a large number of memory blocks are onlined with a
>>>>>>> script or automatically.  For example, the typical size of memory
>>>>>>> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
>>>>>>> will be logged.
>>>>>>
>>>>>> ratelimiting would likely help here a lot, but I agree that it is
>>>>>> suboptimal.
>>>>>>
>>>>>>> Therefore, in this patch, the whole hot-adding memory range is
>>>>>>> checked
>>>>>>> for TDX compatibility through a newly added architecture specific
>>>>>>> function (arch_check_hotplug_memory_range()).  If rejected, the memory
>>>>>>> hot-adding will be aborted with a proper kernel log message.  Which
>>>>>>> looks like something as below,
>>>>>>>     virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX
>>>>>>> for TDX compatibility.
>>>>>>>> The target use case is to support CXL memory on TDX enabled systems.
>>>>>>> If the CXL memory isn't compatible with TDX, the whole CXL memory
>>>>>>> range hot-adding will be rejected.  While the CXL memory can still be
>>>>>>> used via devdax interface.
>>>>>>
>>>>>> I'm curious, why can that memory be used through devdax but not
>>>>>> through the buddy? I'm probably missing something important :)
>>>>>
>>>>> Because only TDX compatible memory can be used for TDX guest.  The buddy
>>>>> is used to allocate memory for TDX guest.  While devdax will not be used
>>>>> for that.
>>>>
>>>> Sorry for chiming in late. I think CXL also faces the similar problem
>>>> on the platform with MTE (memory tagging extension on ARM64). AFAIK,
>>>> we can't have MTE on CXL, so CXL has to stay as dax device if MTE is
>>>> enabled.
>>>>
>>>> We should need a similar mechanism to prevent users from hot-adding
>>>> CXL memory if MTE is on. But not like TDX I don't think we have a
>>>> simple way to tell whether the pfn belongs to CXL or not. Please
>>>> correct me if I'm wrong. I'm wondering whether we can find a more
>>>> common way to tell memory hotplug to not hot-add some region. For
>>>> example, a special flag in struct resource. off the top of my head.
>>>>
>>>> No solid idea yet, I'm definitely seeking some advice.
>>>
>>> Could the ARM version of arch_check_hotplug_memory_range() check if MTE
>>> is enabled in the CPU and then ask the CXL subsystem if the address range is
>>> backed by a topology that supports MTE?
>>
>> Kernel can tell whether MTE is really enabled. For the CXL part, IIUC
>> that relies on the CXL subsystem is able to tell whether that range
>> can support MTE or not, right? Or CXL subsystem tells us whether the
>> range is CXL memory range or not, then we can just refuse MTE for all
>> CXL regions for now. Does CXL support this now?
> 
> So the CXL specification has section:
> 
>      8.2.4.31 CXL Extended Metadata Capability Register
> 
> ...that indicates if the device supports "Extended Metadata" (EMD).
> However, the CXL specification does not talk about how a given hosts
> uses the extended metadata capabilities of a device. That detail would
> need to come from an ARM platform specification.
> 
> Currently CXL subsystem does nothing with this since there has been no
> need to date, but I would expect someone from the ARM side to plumb this
> detection into the CXL subsystem.
> 
>>> However, why would it be ok to access CXL memory without MTE via devdax,
>>> but not as online page allocator memory?
>>
>> CXL memory can be onlined as system ram as long as MTE is not enabled.
>> It just can be used as devdax device if MTE is enabled.
> 
> Do you mean the kernel only manages MTE for kernel pages, but with user
> mapped memory the application will need to implicitly know that
> memory-tagging is not available?
> 
> I worry about applications that might not know that their heap is coming
> from a userspace memory allocator backed by device-dax rather than the
> kernel.

I recall that MTE is requested by user space via mprotect(). If we end 
up with memory that is not taggable, we would have to fail the 
operation, which is not desirable.

This is what we want to avoid, so if MTE is enabled, all memory in the 
buddy should be taggable.

> 
>>> If the goal is to simply deny any and all non-MTE supported CXL region
>>> from attaching then that could probably be handled as a modification to
>>> the "cxl_acpi" driver to deny region creation unless it supports
>>> everything the CPU expects from "memory".
>>
>> I'm not quite familiar with the details in CXL driver. What did you
>> mean "deny region creation"? As long as the CXL memory still can be
>> used as devdax device, it should be fine.
> 
> Meaning that the CXL subsytem knows how to, for a given address range, figure
> out the members and geometry of the CXL devices that contribute to that
> range (CXL region). It would be straightforward to add EMD to that
> enumeration and flag the CXL region as not online-capable if the CPU has
> MTE enabled but no EMD capability.

If it's really just CXL memory we are worrying about, we could pass a 
flag to add_memory_driver_managed(), and passing that to our callback here.

Not sure if that is the most reliable way of handling it :) What about 
other ways of hotplugging memory besides CXL? Are we sure, they are/will 
be providing taggable memory?

-- 
Cheers,

David / dhildenb


