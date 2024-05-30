Return-Path: <linux-kernel+bounces-195080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548788D4759
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F934B21969
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F617619F;
	Thu, 30 May 2024 08:41:33 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4267E17618E
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058493; cv=none; b=OzNANEMDel++fnoC7JM+Ml6d+II4bkjCarZ+9VJ7qQhVirTlYGjy0eijUATZRVhYAyvzj3ldM2lI6jVcWW3SZ9Ock/GLGRBoolr/pzsgX2VEykGV4FyJEUYtnrx2fBc6wDNKHrBbim/TFQZX7E47EuRBaDRSf+Ic2MT05M25ADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058493; c=relaxed/simple;
	bh=d6SEGHAh5j/xWOqtoVYNYnyU7y8oecb7wT1BdiZSbDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL3JozaWlKvkf8paDrHTxF/UOfhHAslvsjBlC8fxagBOWoCthLe+Enwiiy6AuvHsz0qOS2oVcYdIhwDfTCOUATrHTx1q7BsSIzkXT3EsBUlPrlipkpx1Ms+srbY4bL/TERvO81iRqcmWCn3SlWrx5/WZ8apN8jawkydC2lgpoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-ea-66583bb57efb
Date: Thu, 30 May 2024 17:41:20 +0900
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
Message-ID: <20240530084120.GA12940@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsXC9ZZnoe5W64g0g8kX1SzmrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkAviiuGxSUnMyy1KL
	9O0SuDIaLnxgK2iSr1h67zxTA+Nz8S5GTg4JAROJz1M/ssLYT9YtZQGxWQRUJXbPnQlmswmo
	S9y48ZMZxBYR0JD4tHA5excjFwezQB+zxJrFhxhBEsICIRLTPqxhArF5BSwk2g8eAxsqJPCL
	WWLaTXWIuKDEyZlPwIYyC2hJ3Pj3EqieA8iWllj+jwMkzClgJ/H+/TewMaICyhIHth1nAtkl
	IbCNXWJ5/1wWiEMlJQ6uuMEygVFgFpKxs5CMnYUwdgEj8ypGocy8stzEzBwTvYzKvMwKveT8
	3E2MwJhcVvsnegfjpwvBhxgFOBiVeHh3fApPE2JNLCuuzD3EKMHBrCTCe2ZSaJoQb0piZVVq
	UX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRpXPKopZn1MTSu+/SXm5
	fvPJ98+NY949idK8mJcY037oQ094rO3yCRtXdc8MUypTq7dsOJ/6p83aparNVvHuo+2r2x4r
	TGB7OCf/2Ne3i38n3RFac17qVhq7jeskP96tIcs8nV43mb/IZHm8rzn/23XBtxxv5hsmFhpy
	ZPe+X8/8xEdw59pDSkosxRmJhlrMRcWJAONNZYbFAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXC5WfdrLvVOiLNYN5bMYs569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8NzT7JaXN41h83i3pr/rBbnd61ltdixdB+TxaUDC5gs
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUPHJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8SS6A
	P4rLJiU1J7MstUjfLoEro+HCB7aCJvmKpffOMzUwPhfvYuTkkBAwkXiybikLiM0ioCqxe+5M
	MJtNQF3ixo2fzCC2iICGxKeFy9m7GLk4mAX6mCXWLD7ECJIQFgiRmPZhDROIzStgIdF+8Bgr
	iC0k8ItZYtpNdYi4oMTJmU/AhjILaEnc+PcSqJ4DyJaWWP6PAyTMKWAn8f79N7AxogLKEge2
	HWeawMg7C0n3LCTdsxC6FzAyr2IUycwry03MzDHVK87OqMzLrNBLzs/dxAiMsGW1fybuYPxy
	2f0QowAHoxIP7wGJ8DQh1sSy4srcQ4wSHMxKIrxnJoWmCfGmJFZWpRblxxeV5qQWH2KU5mBR
	Euf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTBe4y0484qnvfSgvle5qs9LDo6Xr/LuBUgyzvzW
	kJpk2hfZaJB0bM3MH77nM6Rd7rf/FLn232yDtpvR0j0y6f4GHssOli18pniDVfYZX0ZHXYX8
	lJltrnGOgrsuXX56W7J0s/KuCGd7Z4sdj47OTGstvvLk3emvX53eKO+f/vmA0PK4pVvnR99Q
	YinOSDTUYi4qTgQA+e/jWqwCAAA=
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
								 ^
								 munmap()?

Do you mean munmap()?  IIUC, yes.  LUF only works for page reclaiming
and migration, but not for munmap().  When munmap()ing, LUF rather needs
to give up and perform tlb flush pended.

LUF should not optimize tlb flushes for mappings that users explicitly
change e.g. through mmap() and munmap().

	Byungchul

> Or do I miss something?
> 
> --
> Best Regards,
> Huang, Ying

