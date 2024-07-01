Return-Path: <linux-kernel+bounces-235818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FB691DA10
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68AF1F22292
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCE82C6B;
	Mon,  1 Jul 2024 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drtui0UM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071084E0D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822893; cv=none; b=swPVLTprstFx4zzH+6ur+38bMAOAce6Wv/+Xk20y6m4FREDE0TNqFrU3I8wia/0uoEFKXES/Bzo8OY04d0WJE71f9KRgqA7PL4awjTZd7+1qeHAR8OC6kBucMMr6Z/GSwOmD6RoD6LOmVMs1pcxzzNwnDWa2KpWdFA0THkXGGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822893; c=relaxed/simple;
	bh=p7ktz7dlrNKb9ZMJ9u8GxENG+VyajmcO26M0wpetK+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qhmwcWLXBnl2EGVWXsNz5HWjsBqCWc0cujmVo4Fm+t93syhLcNfqDWcdLn6ZhaVO43sy6xFpyzWZxVgrhxDCkkBcDe5fNn2QkVKXIKrLheXSXVLMkdIgzDtKjVbY6H7UuXq1ApTol7W6sIKDVhAOwmIGm8j/q0J9iS3kdYHY78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drtui0UM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719822892; x=1751358892;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=p7ktz7dlrNKb9ZMJ9u8GxENG+VyajmcO26M0wpetK+g=;
  b=drtui0UM+sM9yseU0CkWvMLrRr6LWn1uBE9VXNlRW10e9EJxWKiMpUNJ
   8PF2eRc3qS+6Q0Wrqz9OGHYevcdVzo3q+E+30kfiMGJ7dkiVj2k0Q/rmF
   Kwh62aNf0eyFYUGhx420aaUOJbBuHQs/bRwt86EdFt5vqZIF96n028IM3
   QEgnm8e3oYJhxqAk4OjWTMuYLrLLWCRZOvu6Gmsxa2kw/NAhsJ3gAzoB3
   9+96mKHd6f6+4IyockKmHndXpF5GCFEdCnFtpbk5SIe/gWJDD/l+MGL2e
   sdcNFC8hFs4e71NNqKg/rdYgBPFUeN5V3QUnJorLrrx6RkAw2wzlxbhfy
   w==;
X-CSE-ConnectionGUID: BdD5CVmxSr2xm9/2MoSS+g==
X-CSE-MsgGUID: ou3dBqqTRSyR+zs/DJ0DzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="28326919"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="28326919"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 01:34:52 -0700
X-CSE-ConnectionGUID: 57dpLEkBQ6eqbP0yC6s8OQ==
X-CSE-MsgGUID: LxVWJEe3TMOY5fWZplOaFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="50397561"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 01:34:50 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Zi Yan" <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
In-Reply-To: <D2A4QLLXOM9N.1YK9YRDXMWJPX@nvidia.com> (Zi Yan's message of
	"Wed, 26 Jun 2024 13:37:15 -0400")
References: <20240620212935.656243-1-david@redhat.com>
	<20240620212935.656243-3-david@redhat.com>
	<B726B923-E023-4E56-BED1-BFA5CEF644A1@nvidia.com>
	<c8f9d6fd-310d-4b13-9871-556b6b9a47e1@redhat.com>
	<0F4ABC1D-7A26-4AE2-BCAA-3EA906FB13A7@nvidia.com>
	<9af34a6b-ca56-4a64-8aa6-ade65f109288@redhat.com>
	<D2A4QLLXOM9N.1YK9YRDXMWJPX@nvidia.com>
Date: Mon, 01 Jul 2024 16:32:58 +0800
Message-ID: <87ed8do6kl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Zi Yan" <ziy@nvidia.com> writes:

> On Wed Jun 26, 2024 at 12:49 PM EDT, David Hildenbrand wrote:
>> On 21.06.24 22:48, Zi Yan wrote:
>> > On 21 Jun 2024, at 16:18, David Hildenbrand wrote:
>> > 
>> >> On 21.06.24 15:44, Zi Yan wrote:
>> >>> On 20 Jun 2024, at 17:29, David Hildenbrand wrote:
>> >>>
>> >>>> Currently we always take a folio reference even if migration will not
>> >>>> even be tried or isolation failed, requiring us to grab+drop an additional
>> >>>> reference.
>> >>>>
>> >>>> Further, we end up calling folio_likely_mapped_shared() while the folio
>> >>>> might have already been unmapped, because after we dropped the PTL, that
>> >>>> can easily happen. We want to stop touching mapcounts and friends from
>> >>>> such context, and only call folio_likely_mapped_shared() while the folio
>> >>>> is still mapped: mapcount information is pretty much stale and unreliable
>> >>>> otherwise.
>> >>>>
>> >>>> So let's move checks into numamigrate_isolate_folio(), rename that
>> >>>> function to migrate_misplaced_folio_prepare(), and call that function
>> >>>> from callsites where we call migrate_misplaced_folio(), but still with
>> >>>> the PTL held.
>> >>>>
>> >>>> We can now stop taking temporary folio references, and really only take
>> >>>> a reference if folio isolation succeeded. Doing the
>> >>>> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
>> >>>> to how we handle MADV_PAGEOUT.
>> >>>>
>> >>>> While at it, combine the folio_is_file_lru() checks.
>> >>>>
>> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> >>>> ---
>> >>>>    include/linux/migrate.h |  7 ++++
>> >>>>    mm/huge_memory.c        |  8 ++--
>> >>>>    mm/memory.c             |  9 +++--
>> >>>>    mm/migrate.c            | 81 +++++++++++++++++++----------------------
>> >>>>    4 files changed, 55 insertions(+), 50 deletions(-)
>> >>>
>> >>> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
>> >>>
>> >>> One nit below:
>> >>>
>> >>> <snip>
>> >>>
>> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> >>>> index fc27dabcd8e3..4b2817bb2c7d 100644
>> >>>> --- a/mm/huge_memory.c
>> >>>> +++ b/mm/huge_memory.c
>> >>>> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>> >>>>    	if (node_is_toptier(nid))
>> >>>>    		last_cpupid = folio_last_cpupid(folio);
>> >>>>    	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>> >>>> -	if (target_nid == NUMA_NO_NODE) {
>> >>>> -		folio_put(folio);
>> >>>> +	if (target_nid == NUMA_NO_NODE)
>> >>>> +		goto out_map;
>> >>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> >>>> +		flags |= TNF_MIGRATE_FAIL;
>> >>>>    		goto out_map;
>> >>>>    	}
>> >>>> -
>> >>>> +	/* The folio is isolated and isolation code holds a folio reference. */
>> >>>>    	spin_unlock(vmf->ptl);
>> >>>>    	writable = false;
>> >>>>
>> >>>> diff --git a/mm/memory.c b/mm/memory.c
>> >>>> index 118660de5bcc..4fd1ecfced4d 100644
>> >>>> --- a/mm/memory.c
>> >>>> +++ b/mm/memory.c
>> >>>
>> >>> <snip>
>> >>>
>> >>>> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>> >>>>    	else
>> >>>>    		last_cpupid = folio_last_cpupid(folio);
>> >>>>    	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
>> >>>> -	if (target_nid == NUMA_NO_NODE) {
>> >>>> -		folio_put(folio);
>> >>>> +	if (target_nid == NUMA_NO_NODE)
>> >>>> +		goto out_map;
>> >>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> >>>> +		flags |= TNF_MIGRATE_FAIL;
>> >>>>    		goto out_map;
>> >>>>    	}
>> >>>
>> >>> These two locations are repeated code, maybe just merge the ifs into
>> >>> numa_migrate_prep(). Feel free to ignore if you are not going to send
>> >>> another version. :)
>> >>
>> >> I went back and forth a couple of times and
>> >>
>> >> a) Didn't want to move numa_migrate_prep() into
>> >>     migrate_misplaced_folio_prepare(), because having that code in
>> >>     mm/migrate.c felt a bit odd.
>> > 
>> > I agree after checking the actual code, since the code is just
>> > updating NUMA fault stats and checking where the folio should be.
>> > 
>> >>
>> >> b) Didn't want to move migrate_misplaced_folio_prepare() because I enjoy
>> >>     seeing the migrate_misplaced_folio_prepare() and
>> >>     migrate_misplaced_folio() calls in the same callercontext.
>> >>
>> >> I also considered renaming numa_migrate_prep(), but wasn't really able to come up with a good name.
>> > 
>> > How about numa_migrate_check()? Since it tells whether a folio should be
>> > migrated or not.
>> > 
>> >>
>> >> But maybe a) is not too bad?
>> >>
>> >> We'd have migrate_misplaced_folio_prepare() consume &flags and &target_nid, and perform the "flags |= TNF_MIGRATE_FAIL;" internally.
>> >>
>> >> What would be your take?
>> > 
>> > I would either rename numa_migrate_prep() or just do nothing. I have to admit
>> > that the "prep" and "prepare" in both function names motivated me to propose
>> > the merge, but now the actual code tells me they should be separate.
>>
>> Let's leave it like that for now. Renaming to numa_migrate_check() makes 
>> sense, and likely moving more numa handling stuff in there.
>>
>> Bit I yet have to figure out why some of the memory.c vs. huge_memory.c 
>> code differences exist, so we can unify them.
>>
>> For example, why did 33024536bafd9 introduce slightly different 
>> last_cpupid handling in do_huge_pmd_numa_page(), whereby it seems like 
>> some subtle difference in handling NUMA_BALANCING_MEMORY_TIERING? Maybe 
>> I am missing something obvious. :)
>
> It seems to me that a sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING
> check is missing in do_huge_pmd_numa_page(). So the
>
> if (node_is_toptier(nid))
>
> should be
>
> if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> node_is_toptier(nid))
>
> to be consistent with other checks. Add Ying to confirm.

Yes.  It should be so.  Sorry for my mistake and confusing.

> I also think a function like
>
> bool folio_has_cpupid(folio)
> {
>     return !(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
>     || node_is_toptier(folio_nid(folio));
> }
>
> would be better than the existing checks.

Yes.  This looks better.  Even better, we can add some comments to the
function too.

--
Best Regards,
Huang, Ying

