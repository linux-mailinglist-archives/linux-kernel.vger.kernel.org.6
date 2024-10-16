Return-Path: <linux-kernel+bounces-366987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6AE99FD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4DC1C218D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482B31171D;
	Wed, 16 Oct 2024 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzsULDbh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A01078B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039284; cv=none; b=AI1ka0A0CIuhDj3/HclUbWuAqs53bR8b86LLocf3e7HuHIFOnlIjQPr2n0W3RoliYAa/khRiGgCylCHv64u+p+O6CGUtLAnC3cI2hc43L3ka5/YV8bVBmcgrH7oPJhDL6nuP5rxbMnOgTXU8hop0l7x9ILyxJKtzA7Es6p58RbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039284; c=relaxed/simple;
	bh=Bdstmo2yItBp026W3l2cFUA0w3hl4eeyAPQuG47t38c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BgfLWJ98hWwCa3g6HLTNdmYbX3pTBvKdcrZzNbduMIwbIzJ8uIa1ssVdXSOJ84fVSzGsix97MXBZkG0O9q43IHwzR4lAvS9HD2e3pMPRB3jNSt/2qLtO6Qb19mqGH0EoMipQmH8LsNFY3WKesO+HL20IDnJmLWPFS+waaLfhaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzsULDbh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729039283; x=1760575283;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Bdstmo2yItBp026W3l2cFUA0w3hl4eeyAPQuG47t38c=;
  b=nzsULDbh/pwUeGugPiwEZ0mvTlN8Y3HXQYpgN6KXtQsgC60PfM+9JT/0
   u/XbxXsdUlROH3absy5fefoTg0WZBPQLwgW3IqSnxDgXpTagLuRU5DoZU
   JcWbKcrpwLTamL/J7ChXh+RxgalzBsLm5/kr/5CJfpoOKMMn6nvWYjygF
   VVOQL9evbDDbluyTp7PxNAD0U50Mb7yqlpOAyth7puZ7Smfh4zRfYJZ8d
   N230YGlO16x7vzkLeV1UFsMqD60uatwCIouLx9pQh77ATYVjfqKuhIe+y
   tdhkQMUucPz3ukueyZeIm5rr8SElVUcXYqmIP8Vm9pO9oGnq2Zo6LYnZn
   A==;
X-CSE-ConnectionGUID: yu3uU0ajSzSsrvfWciTJ9A==
X-CSE-MsgGUID: 9hCjW3mpTp+JoWPPgNAUoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39100501"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="39100501"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 17:41:22 -0700
X-CSE-ConnectionGUID: pBdjQdzeSwuZo/YI7sGKww==
X-CSE-MsgGUID: qSdwtueqRcy6IxuulO7G1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78131210"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 17:41:20 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Guenter Roeck <linux@roeck-us.net>,
  Nathan Chancellor <nathan@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] resource: Remove dependency on SPARSEMEM from
 GET_FREE_REGION
In-Reply-To: <670f0209ab155_3ee2294c2@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Tue, 15 Oct 2024 17:00:09 -0700")
References: <20241015051554.294734-1-ying.huang@intel.com>
	<942d18c3-f9a8-482e-a166-c7c9d6fb28d7@redhat.com>
	<878qup94jb.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<3450df1e-dcb2-495a-8fe4-0a6e096429fd@redhat.com>
	<670f0209ab155_3ee2294c2@dwillia2-xfh.jf.intel.com.notmuch>
Date: Wed, 16 Oct 2024 08:37:47 +0800
Message-ID: <87wmi87uhw.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Dan,

Dan Williams <dan.j.williams@intel.com> writes:

> David Hildenbrand wrote:
>> On 15.10.24 10:03, Huang, Ying wrote:
>> > Hi, David,
>> > 
>> > David Hildenbrand <david@redhat.com> writes:
>> > 
>> >> On 15.10.24 07:15, Huang Ying wrote:
>> >>> We want to use the functions configured via GET_FREE_REGION in
>> >>> resource kunit tests.  However, GET_FREE_REGION depends on SPARSEMEM.
>> >>> This makes resource kunit tests cannot be built on some architectures
>> >>> lacking SPARSEMEM.  In fact, these functions doesn't depend on
>> >>> SPARSEMEM now.  So, remove dependency on SPARSEMEM from
>> >>> GET_FREE_REGION.
>> >>> Link:
>> >>> https://lore.kernel.org/lkml/20240922225041.603186-1-linux@roeck-us.net/
>> >>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> >>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>> >>> Cc: Nathan Chancellor <nathan@kernel.org>
>> >>> Cc: Arnd Bergmann <arnd@arndb.de>
>> >>> Cc: Dan Williams <dan.j.williams@intel.com>
>> >>> Cc: David Hildenbrand <david@redhat.com>
>> >>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> >>> ---
>> >>>    mm/Kconfig | 1 -
>> >>>    1 file changed, 1 deletion(-)
>> >>> diff --git a/mm/Kconfig b/mm/Kconfig
>> >>> index 4c9f5ea13271..33fa51d608dc 100644
>> >>> --- a/mm/Kconfig
>> >>> +++ b/mm/Kconfig
>> >>> @@ -1085,7 +1085,6 @@ config HMM_MIRROR
>> >>>    	depends on MMU
>> >>>      config GET_FREE_REGION
>> >>> -	depends on SPARSEMEM
>> >>>    	bool
>> >>>      config DEVICE_PRIVATE
>> >>
>> >> Added by
>> >>
>> >> commit 14b80582c43e4f550acfd93c2b2cadbe36ea0874
>> >> Author: Dan Williams <dan.j.williams@intel.com>
>> >> Date:   Fri May 20 13:41:24 2022 -0700
>> >>
>> >>      resource: Introduce alloc_free_mem_region()
>> >>
>> >> @Dan, any insight why that dependency was added?
>> > 
>> > Dan has explain it some what in the following email,
>> > 
>> > https://lore.kernel.org/lkml/66f5abd431dce_964f2294b9@dwillia2-xfh.jf.intel.com.notmuch/
>> > 
>> > This is reachable from the "Link:" tag in the patch.
>> 
>> That should be part of the patch description then :)
>
> That Link: does not really describe the history though...

Sorry.  I made a mistake here.

> The description I would add is:
>
> ---
>
> When get_free_mem_region() was introduced the only consumers were those
> looking to pass the address range to memremap_pages(). That address
> range needed to be mindful of the maximum addressable platform physical
> address which at the time only SPARSMEM defined via MAX_PHYSMEM_BITS.
>
> Given that memremap_pages() also depended on SPARSEMEM via ZONE_DEVICE,
> it was easier to just depend on that definition than invent a general
> MAX_PHYSMEM_BITS concept outside of SPARSEMEM.
>
> Turns out that decision was buggy and did not account for KASAN
> consumption of physical address space. That problem was resolved
> recently with commit ea72ce5da228 ("x86/kaslr: Expose and use the end of
> the physical memory address space"), and GET_FREE_REGION dropped its
> MAX_PHYSMEM_BITS dependency.
>
> Then commit 99185c10d5d9 ("resource, kunit: add test case for
> region_intersects()"), went ahead and fixed up the only remaining
> dependency on SPARSEMEM which was usage of the PA_SECTION_SHIFT macro
> for setting the default alignment. A PAGE_SIZE fallback is fine in the
> SPARSEMEM=n case.
>
> With those build dependencies gone GET_FREE_REGION no longer depends on
> SPARSEMEM.

This looks great!  Will use this in the patch description in the next
version.

--
Best Regards,
Huang, Ying

