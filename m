Return-Path: <linux-kernel+bounces-195003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334D38D45EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB631F228A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C99142E60;
	Thu, 30 May 2024 07:19:06 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E01F1C6B2
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053546; cv=none; b=tLTFRtjV1WG+A6iS8isUgmKwQ/yk0WV2SxmMuSiINAAW6uLdJURuimMFyy4pspWa2HpDWew1FLvSRIY4sP9710oALy7uKyan25KLXGFIII0iLoiyfUcGGHXmfN7uIu9ybhTwPL11oPqhCKkkbA7z1E3ixY6fz/DDeDj1rUOX564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053546; c=relaxed/simple;
	bh=03Kur33G3pe5wMVo8g1FerhGv3CMmf5VEPLSYIk9zco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR504B/HCUlah4kSmNdoyJhXJiJulIyR7wjLU86pTFkx947iM88cdqN2zjq12tsKneHkwRWsvmlT2JIY8v5/G7tSnBAseKbzP00qIsKgXebhbizcxlPn1XNJ9TJZFfHo3bUCU5mFYkKJKdya+8lAWL4ldB7bz2hiiOuHD64IdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-8c-6658285c933b
Date: Thu, 30 May 2024 16:18:47 +0900
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
Message-ID: <20240530071847.GA15344@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsXC9ZZnkW6sRkSawe00iznr17BZfN7wj83i
	08sHjBYvNrQzWnxd/4vZ4umnPhaLy7vmsFncW/Of1eL8rrWsFjuW7mOyuHRgAZPF8d4DTBbz
	731ms9i8aSqzxfEpUxktfv8AKj45azKLg6DH99Y+Fo+ds+6yeyzYVOqxeYWWx+I9L5k8Nq3q
	ZPPY9GkSu8e7c+fYPU7M+M3iMe9koMf7fVfZPLb+svNonHqNzePzJrkAvigum5TUnMyy1CJ9
	uwSujAutU9gLtkpUvD90gaWB8btQFyMnh4SAicTvq2fZYOxdu58zg9gsAqoSV/88Zwex2QTU
	JW7c+AkWFxHQkPi0cDlQnIuDWaCPWWLN4kOMIAlhgRCJaR/WMIHYvAIWEucf7wQrEhI4zCzR
	d2YHVEJQ4uTMJywgNrOAlsSNfy+B4hxAtrTE8n8cIGFOATuJY1emgM0UFVCWOLDtOBPIHAmB
	TewSz6bfZYa4VFLi4IobLBMYBWYhGTsLydhZCGMXMDKvYhTKzCvLTczMMdHLqMzLrNBLzs/d
	xAiMyWW1f6J3MH66EHyIUYCDUYmHd8en8DQh1sSy4srcQ4wSHMxKIrxnJoWmCfGmJFZWpRbl
	xxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamCcLy/UyDszb+epZWqLfgt7
	KIqdujjNmWWWTlNGR3no7YdbZNNKpTOuuKdc0/KK4nua25zpJbpU5o7Uz5Na9oubt0zPe2vX
	pfNxXur0mZE7X9i+ibiw6t6JO/p7P762WsS0JOSWXarBZL+HYfzr/iZ5PPmo0JHu/4q3u4vh
	ZMquh/Vxa5Mm75dTYinOSDTUYi4qTgQA6vu2XMUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXC5WfdrBujEZFmMHm1psWc9WvYLD5v+Mdm
	8enlA0aLFxvaGS2+rv/FbPH0Ux+LxeG5J1ktLu+aw2Zxb81/Vovzu9ayWuxYuo/J4tKBBUwW
	x3sPMFnMv/eZzWLzpqnMFsenTGW0+P0DqPjkrMksDkIe31v7WDx2zrrL7rFgU6nH5hVaHov3
	vGTy2LSqk81j06dJ7B7vzp1j9zgx4zeLx7yTgR7v911l81j84gOTx9Zfdh6NU6+xeXzeJBfA
	H8Vlk5Kak1mWWqRvl8CVcaF1CnvBVomK94cusDQwfhfqYuTkkBAwkdi1+zkziM0ioCpx9c9z
	dhCbTUBd4saNn2BxEQENiU8LlwPFuTiYBfqYJdYsPsQIkhAWCJGY9mENE4jNK2Ahcf7xTrAi
	IYHDzBJ9Z3ZAJQQlTs58wgJiMwtoSdz49xIozgFkS0ss/8cBEuYUsJM4dmUK2ExRAWWJA9uO
	M01g5J2FpHsWku5ZCN0LGJlXMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBMbYsto/E3cwfrns
	fohRgINRiYf3gER4mhBrYllxZe4hRgkOZiUR3jOTQtOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
	83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGBkCn3u3q8t5pk947pUekuXzeb6AEGexXqHq4ls9
	TEzcD/caZ3Zw+vqtEHLp5t8+SyjENqflzpc7HwJF78k98rCOuubDlpCwQy27bNmU1xv1Ax23
	RSv8Pv+oKXht5UXTA64NhS+nlE7vn540YZrr9sZbgiyN+wpPuB5onFJ9OvnxrK+/3D53KbEU
	ZyQaajEXFScCAEWhZeCtAgAA
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

While reading flush_tlb_batched_pending(mm), I found it already performs
TLB flush for the target mm, if set_tlb_ubc_flush_pending(mm) has been
hit at least once since the last flush_tlb_batched_pending(mm).

Since LUF also relies on set_tlb_ubc_flush_pending(mm), it's going to
perform TLB flush required, in flush_tlb_batched_pending(mm) during
munmap().  So it looks safe to me with regard to munmap() already.

Is there something that I'm missing?

JFYI, regarding to mmap(), I have reworked on fault handler to give up
luf when needed in a better way.

	Byungchul

> --
> Best Regards,
> Huang, Ying

