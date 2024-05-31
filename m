Return-Path: <linux-kernel+bounces-196185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB48D5897
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF82286A82
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDEE7711D;
	Fri, 31 May 2024 02:21:11 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE3D74E3D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717122071; cv=none; b=WG63gOgd9sQ0/nXYo7W8QTq97RLjgOkAVtGTaVyjo/OvU++1u9t1vY6M6QBsZjgRNb2KEOZA31jW7D54P9x/grRXvw3rSkN4J9AEMWmzPSYKqwekYhJ4fv+2zzTfcSN9LJCbD8oyvf5doz4wrfq14jLf3M+XFlOsbNBlMVJ9y+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717122071; c=relaxed/simple;
	bh=sw2BU4K4rd06eKCfpo6eaY/F5j5VUQ/efAPiPfwAyek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adXuWMXbIiX9904f01/p4NNZyRxvAgpA+oMDFoSJFWny1gnB1d7WyB8+1JSc9BR+9bYu0qCHyuHv8uHGCuQuzjZSw4j9bEkNLuTJX3PLmgEP19rLh45z+pKUQgXgCT/pt0Onu0U9H93a02S4oJKlpLifJBdcmcTzXzfsy+17mJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-12-6659340faa12
Date: Fri, 31 May 2024 11:20:57 +0900
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
Message-ID: <20240531022057.GA80728@system.software.com>
References: <8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e4f2fd-e76e-445d-b618-17a6ec692812@intel.com>
 <20240529050046.GB20307@system.software.com>
 <961f9533-1e0c-416c-b6b0-d46b97127de2@intel.com>
 <20240530005026.GA47476@system.software.com>
 <87a5k814tq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240530071847.GA15344@system.software.com>
 <871q5j1zdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240530093306.GA35610@system.software.com>
 <87wmnazrcy.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmnazrcy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsXC9ZZnoS6/SWSawa9Ofos569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2Ty2/rLzaJx6jc3j8ya5AL4oLpuU1JzMstQi
	fbsErozZJ7cxFpzQrHh8bDF7A2OrQhcjJ4eEgIlE2/stTDD26cNf2boYOThYBFQldi5QAwmz
	CahL3LjxkxnEFhHQkPi0cDl7FyMXB7NAH7PEmsWHGEESwgIhEtM+rAGbwytgIbHi8FR2EFtI
	4DezxNQ3iRBxQYmTM5+wgNjMAloSN/69ZALZxSwgLbH8HwdImFPATmLn6VVgraICyhIHth1n
	AtklIbCNXeLzhF3MEHdKShxccYNlAqPALCRjZyEZOwth7AJG5lWMQpl5ZbmJmTkmehmVeZkV
	esn5uZsYgRG5rPZP9A7GTxeCDzEKcDAq8fAGVESkCbEmlhVX5h5ilOBgVhLh/ZUOFOJNSays
	Si3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cBYyvhvWkJmzAGFN1Mm
	1N122rXk0k+5tGPX51y5f8+oZcnzf+yZTVn3trxh371dYPZa6Z/9/b+Nf/udt1999s0H+Rtf
	nT83vt/ddLzzwCXH/Q6hpyYuK/rS+rHpglfynq+CBXHSd3LvFTCXVkhu2PzjW9vqbcYsBSdP
	/Jl6fIXw8b0dShEHltToOSixFGckGmoxFxUnAgCQkp0QxAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXC5WfdrMtvEplmsKCP0WLO+jVsFp83/GOz
	+PTyAaPFiw3tjBZf1/9itnj6qY/F4vDck6wWl3fNYbO4t+Y/q8X5XWtZLXYs3cdkcenAAiaL
	470HmCzm3/vMZrF501Rmi+NTpjJa/P4BVHxy1mQWByGP7619LB47Z91l91iwqdRj8wotj8V7
	XjJ5bFrVyeax6dMkdo93586xe5yY8ZvFY97JQI/3+66yeSx+8YHJY+svO4/GqdfYPD5vkgvg
	j+KySUnNySxLLdK3S+DKmH1yG2PBCc2Kx8cWszcwtip0MXJySAiYSJw+/JWti5GDg0VAVWLn
	AjWQMJuAusSNGz+ZQWwRAQ2JTwuXs3cxcnEwC/QxS6xZfIgRJCEsECIx7cMaJhCbV8BCYsXh
	qewgtpDAb2aJqW8SIeKCEidnPmEBsZkFtCRu/HvJBLKLWUBaYvk/DpAwp4CdxM7Tq8BaRQWU
	JQ5sO840gZF3FpLuWUi6ZyF0L2BkXsUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREYX8tq/0zc
	wfjlsvshRgEORiUe3oCKiDQh1sSy4srcQ4wSHMxKIry/0oFCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjIwJO7iUGJM/63AL2x3wvV2gJz6Bd59u08UT
	H5jtTKbvN3KN3WSj+sYu+9FObUklJ8bJH82ddJTvlBtu9FJwy921T7P1gdnLOzu4/yw22JCp
	sdNX+3FQN8spb91FJUv/dvLN0NproaxjmLg7+eDxed+lvostjWhsmfr3fNzUvPM+2y+8/Lo6
	V4mlOCPRUIu5qDgRAOveGQWrAgAA
X-CFilter-Loop: Reflected

On Fri, May 31, 2024 at 09:45:33AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Thu, May 30, 2024 at 04:24:12PM +0800, Huang, Ying wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > On Thu, May 30, 2024 at 09:11:45AM +0800, Huang, Ying wrote:
> >> >> Byungchul Park <byungchul@sk.com> writes:
> >> >> 
> >> >> > On Wed, May 29, 2024 at 09:41:22AM -0700, Dave Hansen wrote:
> >> >> >> On 5/28/24 22:00, Byungchul Park wrote:
> >> >> >> > All the code updating ptes already performs TLB flush needed in a safe
> >> >> >> > way if it's inevitable e.g. munmap.  LUF which controls when to flush in
> >> >> >> > a higer level than arch code, just leaves stale ro tlb entries that are
> >> >> >> > currently supposed to be in use.  Could you give a scenario that you are
> >> >> >> > concering?
> >> >> >> 
> >> >> >> Let's go back this scenario:
> >> >> >> 
> >> >> >>  	fd = open("/some/file", O_RDONLY);
> >> >> >>  	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
> >> >> >>  	foo1 = *ptr1;
> >> >> >> 
> >> >> >> There's a read-only PTE at 'ptr1'.  Right?  The page being pointed to is
> >> >> >> eligible for LUF via the try_to_unmap() paths.  In other words, the page
> >> >> >> might be reclaimed at any time.  If it is reclaimed, the PTE will be
> >> >> >> cleared.
> >> >> >> 
> >> >> >> Then, the user might do:
> >> >> >> 
> >> >> >> 	munmap(ptr1, PAGE_SIZE);
> >> >> >> 
> >> >> >> Which will _eventually_ wind up in the zap_pte_range() loop.  But that
> >> >> >> loop will only see pte_none().  It doesn't do _anything_ to the 'struct
> >> >> >> mmu_gather'.
> >> >> >> 
> >> >> >> The munmap() then lands in tlb_flush_mmu_tlbonly() where it looks at the
> >> >> >> 'struct mmu_gather':
> >> >> >> 
> >> >> >>         if (!(tlb->freed_tables || tlb->cleared_ptes ||
> >> >> >> 	      tlb->cleared_pmds || tlb->cleared_puds ||
> >> >> >> 	      tlb->cleared_p4ds))
> >> >> >>                 return;
> >> >> >> 
> >> >> >> But since there were no cleared PTEs (or anything else) during the
> >> >> >> unmap, this just returns and doesn't flush the TLB.
> >> >> >> 
> >> >> >> We now have an address space with a stale TLB entry at 'ptr1' and not
> >> >> >> even a VMA there.  There's nothing to stop a new VMA from going in,
> >> >> >> installing a *new* PTE, but getting data from the stale TLB entry that
> >> >> >> still hasn't been flushed.
> >> >> >
> >> >> > Thank you for the explanation.  I got you.  I think I could handle the
> >> >> > case through a new flag in vma or something indicating LUF has deferred
> >> >> > necessary TLB flush for it during unmapping so that mmu_gather mechanism
> >> >> > can be aware of it.  Of course, the performance change should be checked
> >> >> > again.  Thoughts?
> >> >> 
> >> >> I suggest you to start with the simple case.  That is, only support page
> >> >> reclaiming and migration.  A TLB flushing can be enforced during unmap
> >> >> with something similar as flush_tlb_batched_pending().
> >> >
> >> > While reading flush_tlb_batched_pending(mm), I found it already performs
> >> > TLB flush for the target mm, if set_tlb_ubc_flush_pending(mm) has been
> >> > hit at least once since the last flush_tlb_batched_pending(mm).
> >> >
> >> > Since LUF also relies on set_tlb_ubc_flush_pending(mm), it's going to
> >> > perform TLB flush required, in flush_tlb_batched_pending(mm) during
> >> > munmap().  So it looks safe to me with regard to munmap() already.
> >> >
> >> > Is there something that I'm missing?
> >> >
> >> > JFYI, regarding to mmap(), I have reworked on fault handler to give up
> >> > luf when needed in a better way.
> >> 
> >> If TLB flush is always enforced during munmap(), then your solution can
> >> only avoid TLB flushing for page reclaiming and migration, not unmap.
> >
> > I'm not sure if I understand what you meant.  Could you explain it in
> > more detail?
> >
> > LUF works for only *unmapping* that happens during page reclaiming and
> > migration.  Other unmappings than page reclaiming and migration are not
> > what LUF works for.  That's why I thought flush_tlb_batched_pending()
> > could handle the pending tlb flushes in the case.
> >
> > It'd be appreciated if you explain what you meant more.
> >
> 
> In the following email, you have claimed that LUF can avoid TLB flushing
> for munmap()/mmap().

My bad.  Sorry for that confusing expression.

"give up LUF at mmap()" doesn't mean giving up applying LUF to mmap().

"give up LUF at mmap()" means giving up the pending that has been
induced by LUF, in other words, giving up the benefit by LUF because we
are going through mmap() / munmap().

I will be more careful in expressing these things.

> https://lore.kernel.org/linux-mm/20240527015732.GA61604@system.software.com/
> 
> Now, you said it can only avoid TLB flushing for page reclaiming and
> migration.

This is true.

	Byungchul

> So, to avoid confusion, I suggest you to send out a new series and make
> it explicit that it can only optimize page reclaiming and migration, but
> not munmap().  And it would be good too to add some words about how it
> interact with other TLB flushing mechanisms.
> 
> --
> Best Regards,
> Huang, Ying

