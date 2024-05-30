Return-Path: <linux-kernel+bounces-194844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A058D42F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043B9284101
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DD7168B8;
	Thu, 30 May 2024 01:33:38 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8482C8D7
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032818; cv=none; b=lGU3BgTOF/DfLYvxzYq70BR41A+cW1Yoias8kPznAH/7klqGbjJcvaJLvp0GL91aRagIqXUVO86toQitCklkdsZV/LHXREiAUrP6JuidwSfIozhO7V9JOuhZifP4BQvqWfwHsPrtb0aIIXVa3HoTe5vFczAEaYPmTNES24KG9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032818; c=relaxed/simple;
	bh=SYfCwqogxR71al9vzKVI8efU4DSZsT2yjzZtVdDawcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V69ny2OnYamdWVki3aYSOz/GXf2IbTrcNrhzyI+Hnzhl+8XMNyZ0clrpqedQzzrToMdU3JVgNv/XOZ9XoceEnFPnehubG4uF8dQVm/oHVCxGzBsZsd7G5NHWRPdQyWlBS92tqM+IHw17jqeKJj5Il0C6cfxmY04KL7J+HFuOVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-bc-6657d76941b2
Date: Thu, 30 May 2024 10:33:24 +0900
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
Message-ID: <20240530013324.GA15492@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e4f2fd-e76e-445d-b618-17a6ec692812@intel.com>
 <20240529050046.GB20307@system.software.com>
 <961f9533-1e0c-416c-b6b0-d46b97127de2@intel.com>
 <20240530005026.GA47476@system.software.com>
 <87a5k814tq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5k814tq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsXC9ZZnoW7m9fA0g7W3TCzmrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkAviiuGxSUnMyy1KL
	9O0SuDJmHAgoOCFSseHTArYGxnv8XYwcHBICJhJ7ryl3MXKCmduWXmcHCbMIqEr8/xMCEmYT
	UJe4ceMnM4gtIqAh8WnhcqASLg5mgT5miTWLDzGCJIQFQiSmfVjDBGLzClhITP+whRGkSEjg
	MLNE35kdUAlBiZMzn7CA2MwCWhI3/r1kAlnGLCAtsfwfB0iYU8BO4tiVKWAzRQWUJQ5sO84E
	MkdCYBu7xNatH1ghDpWUOLjiBssERoFZSMbOQjJ2FsLYBYzMqxiFMvPKchMzc0z0MirzMiv0
	kvNzNzEC43FZ7Z/oHYyfLgQfYhTgYFTi4T0gEZ4mxJpYVlyZe4hRgoNZSYT3zKTQNCHelMTK
	qtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2Ms7iz1D+Ye2+euOHp
	sX+ylncPeq4+kL/mjsgLrv+GdxKu6Ms+EPsed+HLnZ7/Vm96llWu/rHs7p9bZ/4UaxsdNvqS
	1jBTTW2ffayVkfVlPW3m3o/poXmTN22az82ssiqyi6MoSWrpjKWfmtlbgl5MvsKwZPXTEMbE
	8o7Zkj9urVDWeC58sCdXV4mlOCPRUIu5qDgRALZP0F7DAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXC5WfdrJt5PTzN4OJVTYs569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8NzT7JaXN41h83i3pr/rBbnd61ltdixdB+TxaUDC5gs
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUPHJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8SS6A
	P4rLJiU1J7MstUjfLoErY8aBgIITIhUbPi1ga2C8x9/FyMkhIWAisW3pdfYuRg4OFgFVif9/
	QkDCbALqEjdu/GQGsUUENCQ+LVwOVMLFwSzQxyyxZvEhRpCEsECIxLQPa5hAbF4BC4npH7Yw
	ghQJCRxmlug7swMqIShxcuYTFhCbWUBL4sa/l0wgy5gFpCWW/+MACXMK2EkcuzIFbKaogLLE
	gW3HmSYw8s5C0j0LSfcshO4FjMyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAuNrWe2fiTsY
	v1x2P8QowMGoxMN7QCI8TYg1say4MvcQowQHs5II75lJoWlCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjHnbT602rlx/pVy9vr5pWXesv/JyxdWSXw8x
	nGgwC/vvlPappnpma+Fp1oSUeVFFPU/uC4Ts2nDGf4H18fjnM2s+yiZwlTy6nlK2P78kNuxz
	h1Z7QbmAw5PuNVzMDPtuLWmMerovf2HmzhuuEo/O/Gq5MpVFMsjiupn5oop7UZkZ5yau8TrI
	rcRSnJFoqMVcVJwIAJL7ZxerAgAA
X-CFilter-Loop: Reflected

On Thu, May 30, 2024 at 09:11:45AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Wed, May 29, 2024 at 09:41:22AM -0700, Dave Hansen wrote:
> >> On 5/28/24 22:00, Byungchul Park wrote:
> >> > All the code updating ptes already performs TLB flush needed in a safe
> >> > way if it's inevitable e.g. munmap.  LUF which controls when to flush in
> >> > a higer level than arch code, just leaves stale ro tlb entries that are
> >> > currently supposed to be in use.  Could you give a scenario that you are
> >> > concering?
> >> 
> >> Let's go back this scenario:
> >> 
> >>  	fd = open("/some/file", O_RDONLY);
> >>  	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
> >>  	foo1 = *ptr1;
> >> 
> >> There's a read-only PTE at 'ptr1'.  Right?  The page being pointed to is
> >> eligible for LUF via the try_to_unmap() paths.  In other words, the page
> >> might be reclaimed at any time.  If it is reclaimed, the PTE will be
> >> cleared.
> >> 
> >> Then, the user might do:
> >> 
> >> 	munmap(ptr1, PAGE_SIZE);
> >> 
> >> Which will _eventually_ wind up in the zap_pte_range() loop.  But that
> >> loop will only see pte_none().  It doesn't do _anything_ to the 'struct
> >> mmu_gather'.
> >> 
> >> The munmap() then lands in tlb_flush_mmu_tlbonly() where it looks at the
> >> 'struct mmu_gather':
> >> 
> >>         if (!(tlb->freed_tables || tlb->cleared_ptes ||
> >> 	      tlb->cleared_pmds || tlb->cleared_puds ||
> >> 	      tlb->cleared_p4ds))
> >>                 return;
> >> 
> >> But since there were no cleared PTEs (or anything else) during the
> >> unmap, this just returns and doesn't flush the TLB.
> >> 
> >> We now have an address space with a stale TLB entry at 'ptr1' and not
> >> even a VMA there.  There's nothing to stop a new VMA from going in,
> >> installing a *new* PTE, but getting data from the stale TLB entry that
> >> still hasn't been flushed.
> >
> > Thank you for the explanation.  I got you.  I think I could handle the
> > case through a new flag in vma or something indicating LUF has deferred
> > necessary TLB flush for it during unmapping so that mmu_gather mechanism
> > can be aware of it.  Of course, the performance change should be checked
> > again.  Thoughts?
> 
> I suggest you to start with the simple case.  That is, only support page
> reclaiming and migration.  A TLB flushing can be enforced during unmap
> with something similar as flush_tlb_batched_pending().

Right.  I'm thinking to add a related code to flush_tlb_batched_pending().

	Byungchul

> --
> Best Regards,
> Huang, Ying

