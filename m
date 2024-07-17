Return-Path: <linux-kernel+bounces-255273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C3C933E41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CA0281E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD40180A8E;
	Wed, 17 Jul 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEsvQ5Uj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6C2D61B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225840; cv=none; b=SW32BF4w6f+bDhh3QJpfvJUZscBKYjjkwoxZAuN3QG/CS2+qR3L+WM4ulD0HzsQCZNgBteBfBnBZ736X+rW4MojfOFJV5K8nj/Id1wx1PcMUAD2NKjdu1Jhi1S5qbJ5Gf9jR+UqoarPTORPNWpGd2H8o4B0Wd0VQv3sFVaisGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225840; c=relaxed/simple;
	bh=HxlFvh4Nzw/IKEKyWq9DtfrkwXU4yf68sm76GVCjVMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2pgbsFod8LMi9jfnEQOem+GkDg7PWwZ8FHrDQahw5cDDDbGbsjrKN2aq/hoSJ2BMkBhLcNOwJ8Hfs+lEDm6D6n7e/emoyIu6sw6s8IjT6b82WnwPXQUG2YcKQYm9cLhPHrPhJCP/QoiRmYuZ8HJG0nKsNlhw0WnXkYnu0UbTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEsvQ5Uj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721225837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AybjgpdX+v+9PD235KW36GR5rh2bKZzBZYsfPIsm4Mc=;
	b=YEsvQ5Ujs+Pzm6pdtdrJ2dQNOYS2fEF85d56KQ0u+un1PjkIpQFD46kdnZgEMMv/ksrQkZ
	ogtKxgsdMTh+ltMG5T0f9r6kgFn0X+P5rucLo5cwCHAmA+vTkHjI70zpcwUfcM5q22iTB2
	+BVBFXOHfRVSWA3DsL2NFU57lJmiYh0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-tEcND8i_OKqwuz-4U8IKGw-1; Wed, 17 Jul 2024 10:17:16 -0400
X-MC-Unique: tEcND8i_OKqwuz-4U8IKGw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3678fd1edf8so410038f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721225835; x=1721830635;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AybjgpdX+v+9PD235KW36GR5rh2bKZzBZYsfPIsm4Mc=;
        b=mvwuc8g1/xCQCr8szxO0vyGbIEPORoNAXZafH0uDYawARXYaG3Q0QjcEYSffr9uLGz
         etb2MT/1+JMmeRikg4TuR4aZ4FYfcr438FQTqwvlehBwP3e4AJOBEFlSK5ZU4OYdimjt
         Uv7jh7e8GX2RyX4N3tVerNCeDbIFeeRPo5SKa9z75X9OzwXboheI73GZkTrka21LKMUh
         K+NOrolhDcHDNqtfU7D+UmXgOlCOJ+Phv6tvGNzrV4Of7mc6YO+w7dHVi3nkREYY1Mg6
         8EPcRVBoLCUTpleGNvpYRXbHAwanaT/UzmzXu+4yzT/QhaYzIj2pJCBqiIHB/m4EqhH3
         cE7Q==
X-Gm-Message-State: AOJu0Yx0xrTokU4bW4KHGbsmfoiaGzPh5wiJZjoii6vADilkEe3mYFbt
	q4FV5B1KYcTyMZMWzwht50DF07b4yctOX6cFoI6pDwqUjDLSmKwjgIUrkjjzfTegJVJvoJz/NWD
	7a3RWtTUrPW4DDieMpFcIDqn/gUqJwcmuiJq2xyJ95Y67qrhAGGWiS9a4DuxQHA==
X-Received: by 2002:a5d:6a8c:0:b0:368:37aa:50b3 with SMTP id ffacd0b85a97d-36837aa5114mr1278337f8f.24.1721225835025;
        Wed, 17 Jul 2024 07:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnphFuCU3/s2xvd2+v3W8mDqCA/9Z7vgToEBk46u+RU/PCwUcungc0RBIN8ast5eoND1VwVA==
X-Received: by 2002:a5d:6a8c:0:b0:368:37aa:50b3 with SMTP id ffacd0b85a97d-36837aa5114mr1278305f8f.24.1721225834479;
        Wed, 17 Jul 2024 07:17:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:c00:b08b:a871:ce99:dfde? (p200300cbc7140c00b08ba871ce99dfde.dip0.t-ipconnect.de. [2003:cb:c714:c00:b08b:a871:ce99:dfde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e8e2ecsm177697035e9.21.2024.07.17.07.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:17:14 -0700 (PDT)
Message-ID: <116ca902-103d-47cb-baf0-905983baf9bb@redhat.com>
Date: Wed, 17 Jul 2024 16:17:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
To: Peter Xu <peterx@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, "x86@kernel.org" <x86@kernel.org>,
 "Tian, Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
 David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk> <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk> <ZpbDnoQxGubegtu-@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZpbDnoQxGubegtu-@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.24 21:01, Peter Xu wrote:
> On Tue, Jul 16, 2024 at 05:13:29PM +0800, Yan Zhao wrote:
>> On Mon, Jul 15, 2024 at 10:29:59PM +0800, Peter Xu wrote:
>>> On Mon, Jul 15, 2024 at 03:08:58PM +0800, Yan Zhao wrote:
>>>> On Fri, Jul 12, 2024 at 10:42:44AM -0400, Peter Xu wrote:
>>>>> This patch is one patch of an old series [1] that got reposted standalone
>>>>> here, with the hope to fix some reported untrack_pfn() issues reported
>>>>> recently [2,3], where there used to be other fix [4] but unfortunately
>>>>> which looks like to cause other issues.  The hope is this patch can fix it
>>>>> the right way.
>>>>>
>>>>> X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
>>>>> start at mmap() of device drivers, then untracked when munmap().  However
>>>>> in the current code the untrack is done in unmap_single_vma().  This might
>>>>> be problematic.
>>>>>
>>>>> For example, unmap_single_vma() can be used nowadays even for zapping a
>>>>> single page rather than the whole vmas.  It's very confusing to do whole
>>>>> vma untracking in this function even if a caller would like to zap one
>>>>> page.  It could simply be wrong.
>>>>>
>>>>> Such issue won't be exposed by things like MADV_DONTNEED won't ever work
>>>>> for pfnmaps and it'll fail the madvise() already before reaching here.
>>>>> However looks like it can be triggered like what was reported where invoked
>>>>> from an unmap request from a file vma.
>>>>>
>>>>> There's also work [5] on VFIO (merged now) to allow tearing down MMIO
>>>>> pgtables before an munmap(), in which case we may not want to untrack the
>>>>> pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
>>>>> pfn tracking information as those pfn mappings can be restored later with
>>>>> the same vma object.  Currently it's not an immediate problem for VFIO, as
>>>>> VFIO uses UC- by default, but it looks like there's plan to extend that in
>>>>> the near future.
>>>>>
>>>>> IIUC, this was overlooked when zap_page_range_single() was introduced,
>>>>> while in the past it was only used in the munmap() path which wants to
>>>>> always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
>>>>> zap_page_range() callers that act on a single VMA use separate helper") is
>>>>> the initial commit that introduced unmap_single_vma(), in which the chunk
>>>>> of untrack_pfn() was moved over from unmap_vmas().
>>>>>
>>>>> Recover that behavior to untrack pfnmap only when unmap regions.
>>>>>
>>>>> [1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
>>>>> [2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
>>>>> [3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
>>>>> [4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
>>>>> [5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com
>>>>>
>>>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>>> Cc: Andy Lutomirski <luto@kernel.org>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>>> Cc: Borislav Petkov <bp@alien8.de>
>>>>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>>>>> Cc: x86@kernel.org
>>>>> Cc: Yan Zhao <yan.y.zhao@intel.com>
>>>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>>>> Cc: Pei Li <peili.dev@gmail.com>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: David Wang <00107082@163.com>
>>>>> Cc: Bert Karwatzki <spasswolf@web.de>
>>>>> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>> ---
>>>>>
>>>>> NOTE: I massaged the commit message comparing to the rfc post [1], the
>>>>> patch itself is untouched.  Also removed rfc tag, and added more people
>>>>> into the loop. Please kindly help test this patch if you have a reproducer,
>>>>> as I can't reproduce it myself even with the syzbot reproducer on top of
>>>>> mm-unstable.  Instead of further check on the reproducer, I decided to send
>>>>> this out first as we have a bunch of reproducers on the list now..
>>>>> ---
>>>>>   mm/memory.c | 5 ++---
>>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 4bcd79619574..f57cc304b318 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>>>>>   	if (vma->vm_file)
>>>>>   		uprobe_munmap(vma, start, end);
>>>>>   
>>>>> -	if (unlikely(vma->vm_flags & VM_PFNMAP))
>>>>> -		untrack_pfn(vma, 0, 0, mm_wr_locked);
>>>>> -
>>>> Specifically to VFIO's case, looks it doesn't matter if untrack_pfn() is
>>>> called here, since remap_pfn_range() is not called in mmap() and fault
>>>> handler, and therefore (vma->vm_flags & VM_PAT) is always 0.
>>>
>>> Right when with current repo, but I'm thinking maybe we should have VM_PAT
>>> there..
>> Yes, I agree.
>>
>> But, currently for VFIO, it cannot call io_remap_pfn_range() in the fault
>> handler since vm_flags_set() requires mmap lock held for write while
>> the fault handler can only hold mmap lock for read.
>> So, it relies on ioremap()/iounmap() to reserve/de-reserve memtypes,
>> without VM_PAT being set in vma.
> 
> Right, neither vm_flags_set() nor io_remap_pfn_range() should be called in
> a fault handler.  They should only be called in mmap() phase.
> 
> When you mentioned ioremap(), it's only for the VGA device, right?  I don't
> see it's used in the vfio-pci's fault handler.
> 
>>
>>>
>>> See what reserve_pfn_range() does right now: it'll make sure only one owner
>>> reserve this area, e.g. memtype_reserve() will fail if it has already been
>>> reserved.  Then when succeeded as the first one to reserve the region,
>>> it'll make sure this mem type to also be synchronized to the kernel map
>>> (memtype_kernel_map_sync).
>>>
>>> So I feel like when MMIO disabled for a VFIO card, we may need to call
>>> reserve_pfn_range(), telling the kernel the mem type VFIO uses, even if the
>>> pgtable will be empty, and even if currently it's always UC- for now:
>>>
>>> vfio_pci_core_mmap():
>>> 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>>
>>> Then the memtype will be reserved even if it cannot be used.  Otherwise I
>>> don't know whether there's side effects of kernel identity mapping where it
>>> mismatch later with what's mapped in the userspace via the vma, when MMIO
>>> got enabled again: pgtable started to be injected with a different memtype
>>> that specified only in the vma's pgprot.
>> Current VFIO relies on pci_iomap() to reserve MMIO pfns as UC-, thus
>> no VM_PAT in vmas.
>>   
>> Calling remap_pfn_range() in the mmap() will cause problem to support
>> dynamic faulting. Looks there's still a window even with an immediate
>> unmap after mmap().
> 
> It can be conditionally injected.  See Alex's commit (not yet posted
> anywhere, only used in our internal testing so far):
> 
> https://github.com/xzpeter/linux/commit/f432e0e46c34e493943034be4cb9d6eb638f57d1
> 
>>
>> Also, calling remap_pfn_range() in mmap() may not meet the requirement of
>> drivers to dynamic switch backend resources, e.g. as what's in
>> cxl_mmap_fault(), since one remap_pfn_range() cannot reserve memtypes for
>> all backend resources at once.
>>
>> So, is there any way for the driver to reserve memtypes and set VM_PAT in
>> fault handler?
> 
> I must confess I'm not familiar with memtype stuff, and just started
> looking recently.
> 
> Per my reading so far, we have these multiple ways of doing memtype
> reservations, and no matter which API we use (ioremap / track_pfn_remap /
> pci_iomap), the same memtype needs to be used otherwise the reservation
> will fail.  Here ioremap / pci_iomap will involve one more vmap so that the
> virtual mapping will present already after the API returns.
> 
> Then here IMHO track_pfn_remap() is the one that we should still use in
> page-level mmap() controls, because so far we don't want to map any MMIO
> range yet, however we want to say "hey this VMA maps something special", by
> reserving these memtype and set VM_PAT.  We want the virtual mapping only
> later during a fault().
> 
> In short, it looks to me the right thing we should do is to manually invoke
> track_pfn_remap() in vfio-pci's mmap() hook.
> 
> 	if (!vdev->pm_runtime_engaged && __vfio_pci_memory_enabled(vdev))
> 		ret = remap_pfn_range(vma, vma->vm_start, pfn,
> 				      req_len, vma->vm_page_prot);
> 	else
>                  // TODO: manually invoke track_pfn_remap() here
> 		vm_flags_set(vma, VM_IO | VM_PFNMAP |
> 				  VM_DONTEXPAND | VM_DONTDUMP);
> 
> Then the vma is registered, and untrack_pfn() should be automatically done
> when vma unmaps (and that relies on this patch to not do that too early).
>  From that POV, I still think this patch does the right thing and should be
> merged, even if we probably have one more issue to fix as David Wang
> reported..

Especially if it only applies to OOT drivers. Do we have report from 
in-tree drivers?

I'd be curious how a previous truncation on a file can tear down a 
PFNMAP mapping -- and if there are simple ways to forbid that (if possible).

-- 
Cheers,

David / dhildenb


