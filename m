Return-Path: <linux-kernel+bounces-196170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD4C8D585D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED09B246A8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA36134BC;
	Fri, 31 May 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chafA5M6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E681E33DF
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120052; cv=none; b=BONeVIhw82BZfIHoIVZda87qZB/nmLJVPYjCgE2JeOL5cZ70EssgcTkTtNeb85mtu0A2HpmmlIPIz9GPE5k3b9brltopVoG0OyBp0PKmSMrvfAYuRukBvrMzc9A1pY75VMyGzdVkONAOHpIXI08q9soZSBRt2HHauY5laG7voN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120052; c=relaxed/simple;
	bh=bRLXaD0t9oBTss9DDyeGZGopPy1q6rqAwm3aGhuXiBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rVL+5KzN0kQGpvbbq9rrY1kfJMHYpCbdzTyLBTkR8DhsJl28s/+Ce333LEUEeexi1yM8YlSRVgHnrCPkl2yWsJqVxpkl0yQE6Ity1jSm1wPBYkb9DgdckokoII1UdjcSgllipGfiY0aopHoQDQ8LU26rnUce7XFfsTrxirKZAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chafA5M6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717120051; x=1748656051;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bRLXaD0t9oBTss9DDyeGZGopPy1q6rqAwm3aGhuXiBE=;
  b=chafA5M6BLn4QauLDm5r+mfLRdsqG9kysuAZDwcqcXMSZzREHgOtWjOg
   itQ7l8hnuOWcUBFN8hgX1Z0jO+xXi90bszXY4oSFgDTeK4o0WJP2Z0L4Y
   zOt0PRadxht2FPSMvdQeYJfdA6PnbPBCcIgILSk1s8wSMk2F0cEr6IJjq
   IyhhynFcJeLFZ9x0TagcEj6xIyx6E1ifq1KEbBbWQrBM4stIieBW1pHJu
   Ot0MOgbtxEK+1wukWPkqRAwszuggb5LOM6gOjveefoO+MwCCFJ/KLhjxa
   TuxeUw0xMBx/0H0Mw42/ts/moGK+P9iqN+F05ie2LtvJLZQLumFKwcQUz
   Q==;
X-CSE-ConnectionGUID: FmcApWTbRtm1bW33MCKTTQ==
X-CSE-MsgGUID: P79gYVikRYaSibXM3uu44Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31142754"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31142754"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:47:30 -0700
X-CSE-ConnectionGUID: 8bXyluNQQ5iUZIhU/5+CYw==
X-CSE-MsgGUID: mdxGSkWESN2KkwjT+/CaNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36579659"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:47:25 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: Dave Hansen <dave.hansen@intel.com>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <kernel_team@skhynix.com>,
  <akpm@linux-foundation.org>,  <vernhao@tencent.com>,
  <mgorman@techsingularity.net>,  <hughd@google.com>,
  <willy@infradead.org>,  <david@redhat.com>,  <peterz@infradead.org>,
  <luto@kernel.org>,  <tglx@linutronix.de>,  <mingo@redhat.com>,
  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,  <rjgolo@gmail.com>
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
In-Reply-To: <20240530093306.GA35610@system.software.com> (Byungchul Park's
	message of "Thu, 30 May 2024 18:33:07 +0900")
References: <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
	<20240527015732.GA61604@system.software.com>
	<8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<44e4f2fd-e76e-445d-b618-17a6ec692812@intel.com>
	<20240529050046.GB20307@system.software.com>
	<961f9533-1e0c-416c-b6b0-d46b97127de2@intel.com>
	<20240530005026.GA47476@system.software.com>
	<87a5k814tq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240530071847.GA15344@system.software.com>
	<871q5j1zdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240530093306.GA35610@system.software.com>
Date: Fri, 31 May 2024 09:45:33 +0800
Message-ID: <87wmnazrcy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> On Thu, May 30, 2024 at 04:24:12PM +0800, Huang, Ying wrote:
>> Byungchul Park <byungchul@sk.com> writes:
>> 
>> > On Thu, May 30, 2024 at 09:11:45AM +0800, Huang, Ying wrote:
>> >> Byungchul Park <byungchul@sk.com> writes:
>> >> 
>> >> > On Wed, May 29, 2024 at 09:41:22AM -0700, Dave Hansen wrote:
>> >> >> On 5/28/24 22:00, Byungchul Park wrote:
>> >> >> > All the code updating ptes already performs TLB flush needed in a safe
>> >> >> > way if it's inevitable e.g. munmap.  LUF which controls when to flush in
>> >> >> > a higer level than arch code, just leaves stale ro tlb entries that are
>> >> >> > currently supposed to be in use.  Could you give a scenario that you are
>> >> >> > concering?
>> >> >> 
>> >> >> Let's go back this scenario:
>> >> >> 
>> >> >>  	fd = open("/some/file", O_RDONLY);
>> >> >>  	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
>> >> >>  	foo1 = *ptr1;
>> >> >> 
>> >> >> There's a read-only PTE at 'ptr1'.  Right?  The page being pointed to is
>> >> >> eligible for LUF via the try_to_unmap() paths.  In other words, the page
>> >> >> might be reclaimed at any time.  If it is reclaimed, the PTE will be
>> >> >> cleared.
>> >> >> 
>> >> >> Then, the user might do:
>> >> >> 
>> >> >> 	munmap(ptr1, PAGE_SIZE);
>> >> >> 
>> >> >> Which will _eventually_ wind up in the zap_pte_range() loop.  But that
>> >> >> loop will only see pte_none().  It doesn't do _anything_ to the 'struct
>> >> >> mmu_gather'.
>> >> >> 
>> >> >> The munmap() then lands in tlb_flush_mmu_tlbonly() where it looks at the
>> >> >> 'struct mmu_gather':
>> >> >> 
>> >> >>         if (!(tlb->freed_tables || tlb->cleared_ptes ||
>> >> >> 	      tlb->cleared_pmds || tlb->cleared_puds ||
>> >> >> 	      tlb->cleared_p4ds))
>> >> >>                 return;
>> >> >> 
>> >> >> But since there were no cleared PTEs (or anything else) during the
>> >> >> unmap, this just returns and doesn't flush the TLB.
>> >> >> 
>> >> >> We now have an address space with a stale TLB entry at 'ptr1' and not
>> >> >> even a VMA there.  There's nothing to stop a new VMA from going in,
>> >> >> installing a *new* PTE, but getting data from the stale TLB entry that
>> >> >> still hasn't been flushed.
>> >> >
>> >> > Thank you for the explanation.  I got you.  I think I could handle the
>> >> > case through a new flag in vma or something indicating LUF has deferred
>> >> > necessary TLB flush for it during unmapping so that mmu_gather mechanism
>> >> > can be aware of it.  Of course, the performance change should be checked
>> >> > again.  Thoughts?
>> >> 
>> >> I suggest you to start with the simple case.  That is, only support page
>> >> reclaiming and migration.  A TLB flushing can be enforced during unmap
>> >> with something similar as flush_tlb_batched_pending().
>> >
>> > While reading flush_tlb_batched_pending(mm), I found it already performs
>> > TLB flush for the target mm, if set_tlb_ubc_flush_pending(mm) has been
>> > hit at least once since the last flush_tlb_batched_pending(mm).
>> >
>> > Since LUF also relies on set_tlb_ubc_flush_pending(mm), it's going to
>> > perform TLB flush required, in flush_tlb_batched_pending(mm) during
>> > munmap().  So it looks safe to me with regard to munmap() already.
>> >
>> > Is there something that I'm missing?
>> >
>> > JFYI, regarding to mmap(), I have reworked on fault handler to give up
>> > luf when needed in a better way.
>> 
>> If TLB flush is always enforced during munmap(), then your solution can
>> only avoid TLB flushing for page reclaiming and migration, not unmap.
>
> I'm not sure if I understand what you meant.  Could you explain it in
> more detail?
>
> LUF works for only *unmapping* that happens during page reclaiming and
> migration.  Other unmappings than page reclaiming and migration are not
> what LUF works for.  That's why I thought flush_tlb_batched_pending()
> could handle the pending tlb flushes in the case.
>
> It'd be appreciated if you explain what you meant more.
>

In the following email, you have claimed that LUF can avoid TLB flushing
for munmap()/mmap().

https://lore.kernel.org/linux-mm/20240527015732.GA61604@system.software.com/

Now, you said it can only avoid TLB flushing for page reclaiming and
migration.

So, to avoid confusion, I suggest you to send out a new series and make
it explicit that it can only optimize page reclaiming and migration, but
not munmap().  And it would be good too to add some words about how it
interact with other TLB flushing mechanisms.

--
Best Regards,
Huang, Ying

