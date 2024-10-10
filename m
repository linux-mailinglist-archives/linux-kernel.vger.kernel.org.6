Return-Path: <linux-kernel+bounces-359679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8F998EED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB18E1F21E65
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA1F1E0B98;
	Thu, 10 Oct 2024 17:52:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1944E1CB528
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582761; cv=none; b=Dlpp8gQ5pUNaKrCCWcR92h6zmwMEmzri9+/pVFI7s4WBK7JeFA3R0UDopj3LqxBiSyRSHRHZfW549Gr1oi1K25GQ5pIQwqKIUBR+16ZJcyNY2D48UpY4V/fCsdasrahEqhQC6rThGLcITBjZkbrw9LO54806YsTgiJah6DSsxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582761; c=relaxed/simple;
	bh=nkR+dqjugye+Oq/MJtUePSitxjSCpxOYsZauwnjQ+ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g09BeVHFdDrpYUS6VcR52gngx4SphF4lVH4KMGMUnTdbc0msP4jnJYvgpfpHvZTZodXl/M7dC7FlfG0euSu3MqaO9xsIJp4BmAH+QQ1duvMayDY1ejimcOr+HESCexbkT4Or11LneQ3D0Rxl65iQtSIjXRNHD0eqL7QkTuVKibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3AC8497;
	Thu, 10 Oct 2024 10:53:07 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D773F58B;
	Thu, 10 Oct 2024 10:52:35 -0700 (PDT)
Message-ID: <d84975b6-1c47-4290-92a3-a1dae180355a@arm.com>
Date: Thu, 10 Oct 2024 18:52:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
Content-Language: en-GB
To: Yang Shi <shy828301@gmail.com>, Dan Williams <dan.j.williams@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand
 <david@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
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
 <CAHbLzkqBCfWOXEtafPnuQSj3B3OHGEPAxPs8ycDuX-a5aVgVjg@mail.gmail.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <CAHbLzkqBCfWOXEtafPnuQSj3B3OHGEPAxPs8ycDuX-a5aVgVjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi guys,

On 04/10/2024 16:46, Yang Shi wrote:
> On Thu, Oct 3, 2024 at 8:15 PM Dan Williams <dan.j.williams@intel.com> wrote:
>> Yang Shi wrote:
>>> On Thu, Oct 3, 2024 at 4:32 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>>> Yang Shi wrote:
>>>>> On Mon, Sep 30, 2024 at 4:54 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>>
>>>>>> Hi, David,
>>>>>>
>>>>>> Thanks a lot for comments!
>>>>>>
>>>>>> David Hildenbrand <david@redhat.com> writes:
>>>>>>
>>>>>>> On 30.09.24 07:51, Huang Ying wrote:
>>>>>>>> On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
>>>>>>>> hot-added must be checked for compatibility by TDX.  This is currently
>>>>>>>> implemented through memory hotplug notifiers for each memory_block.
>>>>>>>> If a memory range which isn't TDX compatible is hot-added, for
>>>>>>>> example, some CXL memory, the command line as follows,
>>>>>>>>    $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
>>>>>>>> will report something like,
>>>>>>>>    bash: echo: write error: Operation not permitted
>>>>>>>> If pr_debug() is enabled, the error message like below will be shown
>>>>>>>> in the kernel log,
>>>>>>>>    online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
>>>>>>>> Both are too general to root cause the problem.  This will confuse
>>>>>>>> users.  One solution is to print some error messages in the TDX memory
>>>>>>>> hotplug notifier.  However, memory hotplug notifiers are called for
>>>>>>>> each memory block, so this may lead to a large volume of messages in
>>>>>>>> the kernel log if a large number of memory blocks are onlined with a
>>>>>>>> script or automatically.  For example, the typical size of memory
>>>>>>>> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
>>>>>>>> will be logged.
>>>>>>>
>>>>>>> ratelimiting would likely help here a lot, but I agree that it is
>>>>>>> suboptimal.
>>>>>>>
>>>>>>>> Therefore, in this patch, the whole hot-adding memory range is
>>>>>>>> checked
>>>>>>>> for TDX compatibility through a newly added architecture specific
>>>>>>>> function (arch_check_hotplug_memory_range()).  If rejected, the memory
>>>>>>>> hot-adding will be aborted with a proper kernel log message.  Which
>>>>>>>> looks like something as below,
>>>>>>>>    virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX
>>>>>>>> for TDX compatibility.
>>>>>>>>> The target use case is to support CXL memory on TDX enabled systems.
>>>>>>>> If the CXL memory isn't compatible with TDX, the whole CXL memory
>>>>>>>> range hot-adding will be rejected.  While the CXL memory can still be
>>>>>>>> used via devdax interface.
>>>>>>>
>>>>>>> I'm curious, why can that memory be used through devdax but not
>>>>>>> through the buddy? I'm probably missing something important :)
>>>>>>
>>>>>> Because only TDX compatible memory can be used for TDX guest.  The buddy
>>>>>> is used to allocate memory for TDX guest.  While devdax will not be used
>>>>>> for that.
>>>>>
>>>>> Sorry for chiming in late. I think CXL also faces the similar problem
>>>>> on the platform with MTE (memory tagging extension on ARM64). AFAIK,
>>>>> we can't have MTE on CXL, so CXL has to stay as dax device if MTE is
>>>>> enabled.
>>>>>
>>>>> We should need a similar mechanism to prevent users from hot-adding
>>>>> CXL memory if MTE is on. But not like TDX I don't think we have a
>>>>> simple way to tell whether the pfn belongs to CXL or not. Please
>>>>> correct me if I'm wrong. I'm wondering whether we can find a more
>>>>> common way to tell memory hotplug to not hot-add some region. For
>>>>> example, a special flag in struct resource. off the top of my head.
>>>>>
>>>>> No solid idea yet, I'm definitely seeking some advice.
>>>>
>>>> Could the ARM version of arch_check_hotplug_memory_range() check if MTE
>>>> is enabled in the CPU and then ask the CXL subsystem if the address range is
>>>> backed by a topology that supports MTE?
>>>
>>> Kernel can tell whether MTE is really enabled. For the CXL part, IIUC
>>> that relies on the CXL subsystem is able to tell whether that range
>>> can support MTE or not, right? Or CXL subsystem tells us whether the
>>> range is CXL memory range or not, then we can just refuse MTE for all
>>> CXL regions for now. Does CXL support this now?
>>
>> So the CXL specification has section:
>>
>>     8.2.4.31 CXL Extended Metadata Capability Register
>>
>> ...that indicates if the device supports "Extended Metadata" (EMD).
>> However, the CXL specification does not talk about how a given hosts
>> uses the extended metadata capabilities of a device. That detail would
>> need to come from an ARM platform specification.
>>
>> Currently CXL subsystem does nothing with this since there has been no
>> need to date, but I would expect someone from the ARM side to plumb this
>> detection into the CXL subsystem.
> 
> Yeah, it should be a good way to let the kernel know whether CXL
> supports memory tagging or not.

On its own I don't think its enough - there would need to be some kind of capability in
both the CXL root-port and the device to say that MTE tags are sent in that metadata
field. If both support it, then the device memory supports MTE.

(I'll poke the standards people to see if this is something they already have in the
 works...)


>>>> However, why would it be ok to access CXL memory without MTE via devdax,
>>>> but not as online page allocator memory?

>>> CXL memory can be onlined as system ram as long as MTE is not enabled.
>>> It just can be used as devdax device if MTE is enabled.

This makes sense to me.

We can print a warning that 'arm64.nomte' should be passed on the command line if the CXL
memory is more important than MTE and the hardware can't support both.


>> Do you mean the kernel only manages MTE for kernel pages, but with user
>> mapped memory the application will need to implicitly know that
>> memory-tagging is not available?
> 
> I think the current assumption is that all buddy memory (can be used
> by userspace) should be taggable. And memory tagging is only supported
> for anonymous mapping and tmpfs. I'm adding hugetlbfs support. But any
> memory backed by the real backing store doesn't have memory tagging
> support.

Hopefully there are no assumptions here! -
Documentation/arch/arm64/memory-tagging-extension.rst says anonymous mappings can have
PROT_MTE set.

The arch code requires all memory to support MTE if the CPUs support it.


>> I worry about applications that might not know that their heap is coming
>> from a userspace memory allocator backed by device-dax rather than the
>> kernel.
> 
> IIUC, memory mapping from device-dax is a file mapping, right? If so,
> it is safe. If it is not, I think it is easy to handle. We can just
> reject any VM_MTE mapping from DAX.

That should already be the case. (we should check!)

Because devdax is already a file-mapping, user-space can't expect MTE to work.
While some library may not know the memory came from devdax - whoever wrote the
malloc()/free() implementation will have known they were using devdax - this is where the
decisions to use MTE and what tag to use is made.

I don't think this adds a new broken case.


>>>> If the goal is to simply deny any and all non-MTE supported CXL region
>>>> from attaching then that could probably be handled as a modification to
>>>> the "cxl_acpi" driver to deny region creation unless it supports
>>>> everything the CPU expects from "memory".
>>>
>>> I'm not quite familiar with the details in CXL driver. What did you
>>> mean "deny region creation"? As long as the CXL memory still can be
>>> used as devdax device, it should be fine.
>>
>> Meaning that the CXL subsytem knows how to, for a given address range, figure
>> out the members and geometry of the CXL devices that contribute to that
>> range (CXL region). It would be straightforward to add EMD to that
>> enumeration and flag the CXL region as not online-capable if the CPU has
>> MTE enabled but no EMD capability.
> 
> It sounds like a good way to me.

From your earlier description, EMD may not be enough - and this would depend on the
root-port (or at least the host side decoders) to support this too. I'll poke the spec
people...


Thanks,

James

