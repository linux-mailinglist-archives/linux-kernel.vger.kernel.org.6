Return-Path: <linux-kernel+bounces-379719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C75E9AE2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F591C2134E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92401C9EAF;
	Thu, 24 Oct 2024 10:32:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FAD1C232D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765937; cv=none; b=bVFKT0OR20pgYfcUftXBlqe8aOrPqo2r3ZYjuyvCwtxwgyOUje/2HMPDyjZW32x+ELrpKfjAqsfP4Uly5GteHQ/1xhJ0sQmX57aqIdjlnPUOnM+Zwc+k1AU5PoTxHimBVePZJXSfE2PbzRjhhjbY7+pPvNV1CUwVIeyYaC9s6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765937; c=relaxed/simple;
	bh=NjexfDcTyLkNTBttCtkeqp8Xe3dd2O4chgtAsSDnQIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+iUxQK878wBZ/S8wmlBxtKFnaHAKUo3RjUgwcZ9Nv2+rJLRTYVZsj+zdNVNNWXH5OLY7TCoit26Q6LdeQC5IrFf28H7Okj0YCiloP8oO3cBHoxdlmvir2e3aUJVLIpYn03M70U/4bT1EOZhkHtT7tCLn7gMZQkx5QAa1GOHeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DCCC339;
	Thu, 24 Oct 2024 03:32:43 -0700 (PDT)
Received: from [10.57.88.37] (unknown [10.57.88.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B2C33F71E;
	Thu, 24 Oct 2024 03:32:11 -0700 (PDT)
Message-ID: <3027c366-2cb0-4984-8ee7-aae92fb51512@arm.com>
Date: Thu, 24 Oct 2024 11:32:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 36/57] xen: Remove PAGE_SIZE compile-time constant
 assumption
Content-Language: en-GB
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 Juergen Gross <jgross@suse.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, julien@xen.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-36-ryan.roberts@arm.com>
 <829b5662-13c0-4728-894c-b2d578681b11@arm.com>
 <alpine.DEB.2.22.394.2410221808160.3833@ubuntu-linux-20-04-desktop>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <alpine.DEB.2.22.394.2410221808160.3833@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2024 02:23, Stefano Stabellini wrote:
> +Julien
> 
> On Wed, 16 Oct 2024, Ryan Roberts wrote:
>> + Juergen Gross, Stefano Stabellini
>>
>> This was a rather tricky series to get the recipients correct for and my script
>> did not realize that "supporter" was a pseudonym for "maintainer" so you were
>> missed off the original post. Appologies!
>>
>> More context in cover letter:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>
>>
>> On 14/10/2024 11:58, Ryan Roberts wrote:
>>> To prepare for supporting boot-time page size selection, refactor code
>>> to remove assumptions about PAGE_SIZE being compile-time constant. Code
>>> intended to be equivalent when compile-time page size is active.
>>>
>>> Allocate enough "frame_list" static storage in the balloon driver for
>>> the maximum supported page size. Although continue to use only the first
>>> PAGE_SIZE of the buffer at run-time to maintain existing behaviour.
>>>
>>> Refactor xen_biovec_phys_mergeable() to convert ifdeffery to c if/else.
>>> For compile-time page size, the compiler will choose one branch and
>>> strip the dead one. For boot-time, it can be evaluated at run time.
>>>
>>> Refactor a BUILD_BUG_ON to evaluate the limit (when the minimum
>>> supported page size is selected at boot-time).
>>>
>>> Reserve enough storage for max page size in "struct remap_data" and
>>> "struct xenbus_map_node".
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>
>>> ***NOTE***
>>> Any confused maintainers may want to read the cover note here for context:
>>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>>
>>>  drivers/xen/balloon.c              | 11 ++++++-----
>>>  drivers/xen/biomerge.c             | 12 ++++++------
>>>  drivers/xen/privcmd.c              |  2 +-
>>>  drivers/xen/xenbus/xenbus_client.c |  5 +++--
>>>  drivers/xen/xlate_mmu.c            |  6 +++---
>>>  include/xen/page.h                 |  2 ++
>>>  6 files changed, 21 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>>> index 528395133b4f8..0ed5f6453af0e 100644
>>> --- a/drivers/xen/balloon.c
>>> +++ b/drivers/xen/balloon.c
>>> @@ -131,7 +131,8 @@ struct balloon_stats balloon_stats;
>>>  EXPORT_SYMBOL_GPL(balloon_stats);
>>>  
>>>  /* We increase/decrease in batches which fit in a page */
>>> -static xen_pfn_t frame_list[PAGE_SIZE / sizeof(xen_pfn_t)];
>>> +static xen_pfn_t frame_list[PAGE_SIZE_MAX / sizeof(xen_pfn_t)];
>>> +#define FRAME_LIST_NR_ENTRIES (PAGE_SIZE / sizeof(xen_pfn_t))
>>>  
>>>  
>>>  /* List of ballooned pages, threaded through the mem_map array. */
>>> @@ -389,8 +390,8 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>>>  	unsigned long i;
>>>  	struct page   *page;
>>>  
>>> -	if (nr_pages > ARRAY_SIZE(frame_list))
>>> -		nr_pages = ARRAY_SIZE(frame_list);
>>> +	if (nr_pages > FRAME_LIST_NR_ENTRIES)
>>> +		nr_pages = FRAME_LIST_NR_ENTRIES;
>>>  
>>>  	page = list_first_entry_or_null(&ballooned_pages, struct page, lru);
>>>  	for (i = 0; i < nr_pages; i++) {
>>> @@ -434,8 +435,8 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>>>  	int ret;
>>>  	LIST_HEAD(pages);
>>>  
>>> -	if (nr_pages > ARRAY_SIZE(frame_list))
>>> -		nr_pages = ARRAY_SIZE(frame_list);
>>> +	if (nr_pages > FRAME_LIST_NR_ENTRIES)
>>> +		nr_pages = FRAME_LIST_NR_ENTRIES;
>>>  
>>>  	for (i = 0; i < nr_pages; i++) {
>>>  		page = alloc_page(gfp);
>>> diff --git a/drivers/xen/biomerge.c b/drivers/xen/biomerge.c
>>> index 05a286d24f148..28f0887e40026 100644
>>> --- a/drivers/xen/biomerge.c
>>> +++ b/drivers/xen/biomerge.c
>>> @@ -8,16 +8,16 @@
>>>  bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>>>  			       const struct page *page)
>>>  {
>>> -#if XEN_PAGE_SIZE == PAGE_SIZE
>>> -	unsigned long bfn1 = pfn_to_bfn(page_to_pfn(vec1->bv_page));
>>> -	unsigned long bfn2 = pfn_to_bfn(page_to_pfn(page));
>>> +	if (XEN_PAGE_SIZE == PAGE_SIZE) {
>>> +		unsigned long bfn1 = pfn_to_bfn(page_to_pfn(vec1->bv_page));
>>> +		unsigned long bfn2 = pfn_to_bfn(page_to_pfn(page));
>>> +
>>> +		return bfn1 + PFN_DOWN(vec1->bv_offset + vec1->bv_len) == bfn2;
>>> +	}
>>>  
>>> -	return bfn1 + PFN_DOWN(vec1->bv_offset + vec1->bv_len) == bfn2;
>>> -#else
>>>  	/*
>>>  	 * XXX: Add support for merging bio_vec when using different page
>>>  	 * size in Xen and Linux.
>>>  	 */
>>>  	return false;
>>> -#endif
>>>  }
>>> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
>>> index 9563650dfbafc..847f7b806caf7 100644
>>> --- a/drivers/xen/privcmd.c
>>> +++ b/drivers/xen/privcmd.c
>>> @@ -557,7 +557,7 @@ static long privcmd_ioctl_mmap_batch(
>>>  	state.global_error  = 0;
>>>  	state.version       = version;
>>>  
>>> -	BUILD_BUG_ON(((PAGE_SIZE / sizeof(xen_pfn_t)) % XEN_PFN_PER_PAGE) != 0);
>>> +	BUILD_BUG_ON(((PAGE_SIZE_MIN / sizeof(xen_pfn_t)) % XEN_PFN_PER_PAGE_MAX) != 0);
> 
> Is there any value in keep this test? And if so, what should it look
> like? I think we should turn it into a WARN_ON:
> 
> WARN_ON(((PAGE_SIZE / sizeof(xen_pfn_t)) % XEN_PFN_PER_PAGE) != 0);
> 
> It doesn't make much sense having a BUILD_BUG_ON on a variable that can
> change?

I believe that as long as we assume sizeof(xen_pfn_t), PAGE_SIZE and
XEN_PAGE_SIZE are all power-of-two sizes, then this single build-time test
should cover all possible boot-time PAGE_SIZEs.

Logic:

If PAGE_SIZE and XEN_PAGE_SIZE are power-of-two, then XEN_PFN_PER_PAGE must also
be power-of-two. XEN_PFN_PER_PAGE_MAX is just the worst case limit.

(PAGE_SIZE_MIN / sizeof(xen_pfn_t)) is the number of xen_pfn_t that fit on
smallest page.

If you can get an integer multiple number of XEN_PFN_PER_PAGE_MAX on the
smallest page, then it remains an integer multiple as PAGE_SIZE gets bigger,
assuming it is restricted to power-of-two sizes.

Perhaps there is a floor in my logic?

I'd prefer to keep BUILD_BUG_ON where possible to avoid the additional image
size bloat and runtime costs.

Thanks,
Ryan

> 
> 
>>>  	/* mmap_batch_fn guarantees ret == 0 */
>>>  	BUG_ON(traverse_pages_block(m.num, sizeof(xen_pfn_t),
>>>  				    &pagelist, mmap_batch_fn, &state));
>>> diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
>>> index 51b3124b0d56c..99bde836c10c4 100644
>>> --- a/drivers/xen/xenbus/xenbus_client.c
>>> +++ b/drivers/xen/xenbus/xenbus_client.c
>>> @@ -49,9 +49,10 @@
>>>  
>>>  #include "xenbus.h"
>>>  
>>> -#define XENBUS_PAGES(_grants)	(DIV_ROUND_UP(_grants, XEN_PFN_PER_PAGE))
>>> +#define XENBUS_PAGES(_grants)		(DIV_ROUND_UP(_grants, XEN_PFN_PER_PAGE))
>>> +#define XENBUS_PAGES_MAX(_grants)	(DIV_ROUND_UP(_grants, XEN_PFN_PER_PAGE_MIN))
>>>  
>>> -#define XENBUS_MAX_RING_PAGES	(XENBUS_PAGES(XENBUS_MAX_RING_GRANTS))
>>> +#define XENBUS_MAX_RING_PAGES		(XENBUS_PAGES_MAX(XENBUS_MAX_RING_GRANTS))
>>>  
>>>  struct xenbus_map_node {
>>>  	struct list_head next;
>>> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
>>> index f17c4c03db30c..a757c801a7542 100644
>>> --- a/drivers/xen/xlate_mmu.c
>>> +++ b/drivers/xen/xlate_mmu.c
>>> @@ -74,9 +74,9 @@ struct remap_data {
>>>  	int mapped;
>>>  
>>>  	/* Hypercall parameters */
>>> -	int h_errs[XEN_PFN_PER_PAGE];
>>> -	xen_ulong_t h_idxs[XEN_PFN_PER_PAGE];
>>> -	xen_pfn_t h_gpfns[XEN_PFN_PER_PAGE];
>>> +	int h_errs[XEN_PFN_PER_PAGE_MAX];
>>> +	xen_ulong_t h_idxs[XEN_PFN_PER_PAGE_MAX];
>>> +	xen_pfn_t h_gpfns[XEN_PFN_PER_PAGE_MAX];
>>>  
>>>  	int h_iter;	/* Iterator */
>>>  };
>>> diff --git a/include/xen/page.h b/include/xen/page.h
>>> index 285677b42943a..86683a30038a3 100644
>>> --- a/include/xen/page.h
>>> +++ b/include/xen/page.h
>>> @@ -21,6 +21,8 @@
>>>  	((page_to_pfn(page)) << (PAGE_SHIFT - XEN_PAGE_SHIFT))
>>>  
>>>  #define XEN_PFN_PER_PAGE	(PAGE_SIZE / XEN_PAGE_SIZE)
>>> +#define XEN_PFN_PER_PAGE_MIN	(PAGE_SIZE_MIN / XEN_PAGE_SIZE)
>>> +#define XEN_PFN_PER_PAGE_MAX	(PAGE_SIZE_MAX / XEN_PAGE_SIZE)
>>>  
>>>  #define XEN_PFN_DOWN(x)	((x) >> XEN_PAGE_SHIFT)
>>>  #define XEN_PFN_UP(x)	(((x) + XEN_PAGE_SIZE-1) >> XEN_PAGE_SHIFT)
>>


