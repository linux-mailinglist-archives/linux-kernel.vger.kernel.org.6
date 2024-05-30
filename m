Return-Path: <linux-kernel+bounces-195181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFEB8D4896
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB571285BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F06F313;
	Thu, 30 May 2024 09:33:20 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA7152790
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061600; cv=none; b=Afl/nBH/bsDpMbQ22PAFMxpW32vdOG4h+L0dqKMNJWsCfq6O++pwfrnUl7hrBR5Obd+byJOtBXlPeswKbtIVTFqMJLZRGADlEhAt8H9dAZnO7xDQKa2j+DYLPwsVabf4xR4TszwF9YRJ1+Us9EiaA9BmAk0KiycS0th8wwc7Brw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061600; c=relaxed/simple;
	bh=7L2bKy7UnuPng+/bpezLV7oOWxZSlx8u8PJlTUYICv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMNoZubfrfaMPM9ecR/CRABVEBwoKA2v3Pf/JQT6LkrSLlaiYksaup87bJA3tIxQBYekA7O7IJBBWrxY9J7AtRriVLNRb5+TbmLc8j5lAQNGJ4nEi5JaJldhNKD2EP+38PhDCGcb8QwUkcbFdziOL5ibgFriZ3bZdNfN0j7t+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-64-665847d8df8b
Date: Thu, 30 May 2024 18:33:07 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240530093306.GA35610@system.software.com>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q5j1zdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsXC9ZZnoe4N94g0g64vshZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnls/WXn0Tj1GpvH501yAXxRXDYpqTmZZalF
	+nYJXBkvji1lLLggX7Hv3CqmBsZtEl2MnBwSAiYSrTOOMcLYJ9aeZgKxWQRUJdasOwkWZxNQ
	l7hx4ycziC0ioCHxaeFy9i5GLg5mgT5miTWLD4EVCQuESEz7sAasmVfAQuJc63wWEFtI4Bez
	xLSb6hBxQYmTM5+AxZkFtCRu/HsJVM8BZEtLLP/HARLmFLCTeP/+G9gYUQFliQPbjjOB7JIQ
	2MYusWX3TWaIQyUlDq64wTKBUWAWkrGzkIydhTB2ASPzKkahzLyy3MTMHBO9jMq8zAq95Pzc
	TYzAmFxW+yd6B+OnC8GHGAU4GJV4eHd8Ck8TYk0sK67MPcQowcGsJMJ7ZlJomhBvSmJlVWpR
	fnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQZGw5XsWTqbNMXP7XZfLypm
	cIczdknbpVDdSUfO/MoseaF28nTUto+8ahtk1hq7hgffTtmdIen8dtmSOpkQviKfkz5vPBXW
	LbbTFIuPX6W1e2bKvJL3/7uPi89dPHHv68eHTaf9k53GcNWi95PLxBmL7Na8OxhZ966Lc/mK
	7VfPTlgX9emE2j79zUosxRmJhlrMRcWJAH6Wj1PFAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXC5WfdrHvDPSLNoO8On8Wc9WvYLD5v+Mdm
	8enlA0aLFxvaGS2+rv/FbPH0Ux+LxeG5J1ktLu+aw2Zxb81/Vovzu9ayWuxYuo/J4tKBBUwW
	x3sPMFnMv/eZzWLzpqnMFsenTGW0+P0DqPjkrMksDkIe31v7WDx2zrrL7rFgU6nH5hVaHov3
	vGTy2LSqk81j06dJ7B7vzp1j9zgx4zeLx7yTgR7v911l81j84gOTx9Zfdh6NU6+xeXzeJBfA
	H8Vlk5Kak1mWWqRvl8CV8eLYUsaCC/IV+86tYmpg3CbRxcjJISFgInFi7WkmEJtFQFVizbqT
	jCA2m4C6xI0bP5lBbBEBDYlPC5ezdzFycTAL9DFLrFl8CKxIWCBEYtqHNWDNvAIWEuda57OA
	2EICv5glpt1Uh4gLSpyc+QQsziygJXHj30ugeg4gW1pi+T8OkDCngJ3E+/ffwMaICihLHNh2
	nGkCI+8sJN2zkHTPQuhewMi8ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzDCltX+mbiD8ctl
	90OMAhyMSjy8ByTC04RYE8uKK3MPMUpwMCuJ8J6ZFJomxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwHik8dYHaaPAf9f3rH3GyrdsQ/nbt5HuGdwN9+/2
	/1rZyGBx8cTLopebtj3u+1e36rbYnAV2fMrNAlVHLKsOyUyVcfb1+XOer9yop+jDJ7+LVwz/
	W68OP3Hp67Y2Wdap1rwaBjO2RyQXtDP+Fd/oGBe5al+8t3X9Ye+4uFnuH3uKov9f0Ax6dl2J
	pTgj0VCLuag4EQDlUdi1rAIAAA==
X-CFilter-Loop: Reflected

On Thu, May 30, 2024 at 04:24:12PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Thu, May 30, 2024 at 09:11:45AM +0800, Huang, Ying wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > On Wed, May 29, 2024 at 09:41:22AM -0700, Dave Hansen wrote:
> >> >> On 5/28/24 22:00, Byungchul Park wrote:
> >> >> > All the code updating ptes already performs TLB flush needed in a safe
> >> >> > way if it's inevitable e.g. munmap.  LUF which controls when to flush in
> >> >> > a higer level than arch code, just leaves stale ro tlb entries that are
> >> >> > currently supposed to be in use.  Could you give a scenario that you are
> >> >> > concering?
> >> >> 
> >> >> Let's go back this scenario:
> >> >> 
> >> >>  	fd = open("/some/file", O_RDONLY);
> >> >>  	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
> >> >>  	foo1 = *ptr1;
> >> >> 
> >> >> There's a read-only PTE at 'ptr1'.  Right?  The page being pointed to is
> >> >> eligible for LUF via the try_to_unmap() paths.  In other words, the page
> >> >> might be reclaimed at any time.  If it is reclaimed, the PTE will be
> >> >> cleared.
> >> >> 
> >> >> Then, the user might do:
> >> >> 
> >> >> 	munmap(ptr1, PAGE_SIZE);
> >> >> 
> >> >> Which will _eventually_ wind up in the zap_pte_range() loop.  But that
> >> >> loop will only see pte_none().  It doesn't do _anything_ to the 'struct
> >> >> mmu_gather'.
> >> >> 
> >> >> The munmap() then lands in tlb_flush_mmu_tlbonly() where it looks at the
> >> >> 'struct mmu_gather':
> >> >> 
> >> >>         if (!(tlb->freed_tables || tlb->cleared_ptes ||
> >> >> 	      tlb->cleared_pmds || tlb->cleared_puds ||
> >> >> 	      tlb->cleared_p4ds))
> >> >>                 return;
> >> >> 
> >> >> But since there were no cleared PTEs (or anything else) during the
> >> >> unmap, this just returns and doesn't flush the TLB.
> >> >> 
> >> >> We now have an address space with a stale TLB entry at 'ptr1' and not
> >> >> even a VMA there.  There's nothing to stop a new VMA from going in,
> >> >> installing a *new* PTE, but getting data from the stale TLB entry that
> >> >> still hasn't been flushed.
> >> >
> >> > Thank you for the explanation.  I got you.  I think I could handle the
> >> > case through a new flag in vma or something indicating LUF has deferred
> >> > necessary TLB flush for it during unmapping so that mmu_gather mechanism
> >> > can be aware of it.  Of course, the performance change should be checked
> >> > again.  Thoughts?
> >> 
> >> I suggest you to start with the simple case.  That is, only support page
> >> reclaiming and migration.  A TLB flushing can be enforced during unmap
> >> with something similar as flush_tlb_batched_pending().
> >
> > While reading flush_tlb_batched_pending(mm), I found it already performs
> > TLB flush for the target mm, if set_tlb_ubc_flush_pending(mm) has been
> > hit at least once since the last flush_tlb_batched_pending(mm).
> >
> > Since LUF also relies on set_tlb_ubc_flush_pending(mm), it's going to
> > perform TLB flush required, in flush_tlb_batched_pending(mm) during
> > munmap().  So it looks safe to me with regard to munmap() already.
> >
> > Is there something that I'm missing?
> >
> > JFYI, regarding to mmap(), I have reworked on fault handler to give up
> > luf when needed in a better way.
> 
> If TLB flush is always enforced during munmap(), then your solution can
> only avoid TLB flushing for page reclaiming and migration, not unmap.

I'm not sure if I understand what you meant.  Could you explain it in
more detail?

LUF works for only *unmapping* that happens during page reclaiming and
migration.  Other unmappings than page reclaiming and migration are not
what LUF works for.  That's why I thought flush_tlb_batched_pending()
could handle the pending tlb flushes in the case.

It'd be appreciated if you explain what you meant more.

	Byungchul

> Or do I miss something?
> 
> --
> Best Regards,
> Huang, Ying

