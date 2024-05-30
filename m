Return-Path: <linux-kernel+bounces-194829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE938D429E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A880B1F22042
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9CDDDA;
	Thu, 30 May 2024 01:00:11 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235F63D6A
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030810; cv=none; b=Fu0aHKVazYlLGbLkfvoAiWYxKrY48k6E6pAadgupv3TaErTm4e4jQzYbgjMVb+Qs+bHh2KKyqgNqakMYJ2MyYuDAyYtSNFuD5F426XOAXvpxie3rM1KEbMxEqhVwU7poofAj6frYcnbKVqN7ZjCoP8XkxP1++2WjmkDMtLyDDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030810; c=relaxed/simple;
	bh=/bE5uyw0HmAS3iBEmixbEKbFmNWFdcM9MDQZ5xty5NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTwekt33Er4Ul/Pg0gbpN2oULhuoqE/Lyu12sBk9WHygveOR7k2zexHlkfvBH80oEUa24s5iNbqiqzgFCrgC3jQhNjAcwBVGd+R+H9ebQXrVLCCmfLKZ05cbzmUjrEwxDpGI+R4pPdHum3rj6JLsBP0AAxWoRrjeTl1zpIBLJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-bc-6657cf93d748
Date: Thu, 30 May 2024 09:59:58 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240530005958.GB47476@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e4f2fd-e76e-445d-b618-17a6ec692812@intel.com>
 <20240529050046.GB20307@system.software.com>
 <961f9533-1e0c-416c-b6b0-d46b97127de2@intel.com>
 <20240530005026.GA47476@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530005026.GA47476@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsXC9ZZnoe7k8+FpBgtfaFvMWb+GzeLzhn9s
	Fp9ePmC0eLGhndHi6/pfzBZPP/WxWFzeNYfN4t6a/6wW53etZbXYsXQfk8WlAwuYLI73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DxyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJBfBFcdmkpOZklqUW
	6dslcGV82HmIrWCJUMW0zh2MDYyveLsYOTkkBEwkFnTtZYGxd095xQZiswioSvw/d5ERxGYT
	UJe4ceMnM4gtAmSfWrmcvYuRi4NZoJ9Z4v87EIeTQ1ggRGLahzVMIDavgIXEs4fbmUGKhECK
	Fu0+xwqREJQ4OfMJ2DZmAS2JG/9eAjVwANnSEsv/cYCEOQUsJT49PwS2WFRAWeLAtuNMIHMk
	BLaxS2x6O5UR4lJJiYMrbrBMYBSYhWTsLCRjZyGMXcDIvIpRKDOvLDcxM8dEL6MyL7NCLzk/
	dxMjMCqX1f6J3sH46ULwIUYBDkYlHt4DEuFpQqyJZcWVuYcYJTiYlUR4z0wKTRPiTUmsrEot
	yo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAWPPj0K+elJUWXJ4B3/9V
	imxyW3SQ88q5lMUVOWV58zc8vPVPVu7gw7C74jvMYr4cNfbl/ZCnYvh0jaHAij1+iZLRjs/7
	YngSdlWrpaauP/C0sWP9qd35ToE/JSewybkJss2fes99Tpe9wLK05YVxX0Nep3svfMil8fuC
	UdXFZ2KTFpa/qnrcpMRSnJFoqMVcVJwIAKHbtz3GAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXC5WfdrDv5fHiawekuSYs569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8NzT7JaXN41h83i3pr/rBbnd61ltdixdB+TxaUDC5gs
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUPHJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8SS6A
	P4rLJiU1J7MstUjfLoEr48POQ2wFS4QqpnXuYGxgfMXbxcjJISFgIrF7yis2EJtFQFXi/7mL
	jCA2m4C6xI0bP5lBbBEg+9TK5exdjFwczAL9zBL/34E4nBzCAiES0z6sYQKxeQUsJJ493M4M
	UiQEUrRo9zlWiISgxMmZT1hAbGYBLYkb/14CNXAA2dISy/9xgIQ5BSwlPj0/BLZYVEBZ4sC2
	40wTGHlnIemehaR7FkL3AkbmVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIExtqz2z8QdjF8u
	ux9iFOBgVOLhPSARnibEmlhWXJl7iFGCg1lJhPfMpNA0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK
	4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsa8cxueRnnZ/GnRXsJ2wXfqK3ebW9qWv/Mddksu
	ni5zRiHYr2OqTNnZGAlv21/3P24oLLnNF+1vYf/z3IZF+ddr9/g5Ccz0qKtg6Ngqt81TO26t
	y0Vpyf3pMczfXEKmL1vstZbDuGtJxEWDVzG54S+8K6QmOWvNlda58Sa5+WHkfqXG/aqLjiux
	FGckGmoxFxUnAgAwX/lwrQIAAA==
X-CFilter-Loop: Reflected

On Thu, May 30, 2024 at 09:50:26AM +0900, Byungchul Park wrote:
> On Wed, May 29, 2024 at 09:41:22AM -0700, Dave Hansen wrote:
> > On 5/28/24 22:00, Byungchul Park wrote:
> > > All the code updating ptes already performs TLB flush needed in a safe
> > > way if it's inevitable e.g. munmap.  LUF which controls when to flush in
> > > a higer level than arch code, just leaves stale ro tlb entries that are
> > > currently supposed to be in use.  Could you give a scenario that you are
> > > concering?
> > 
> > Let's go back this scenario:
> > 
> >  	fd = open("/some/file", O_RDONLY);
> >  	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
> >  	foo1 = *ptr1;
> > 
> > There's a read-only PTE at 'ptr1'.  Right?  The page being pointed to is
> > eligible for LUF via the try_to_unmap() paths.  In other words, the page
> > might be reclaimed at any time.  If it is reclaimed, the PTE will be
> > cleared.
> > 
> > Then, the user might do:
> > 
> > 	munmap(ptr1, PAGE_SIZE);
> > 
> > Which will _eventually_ wind up in the zap_pte_range() loop.  But that
> > loop will only see pte_none().  It doesn't do _anything_ to the 'struct
> > mmu_gather'.
> > 
> > The munmap() then lands in tlb_flush_mmu_tlbonly() where it looks at the
> > 'struct mmu_gather':
> > 
> >         if (!(tlb->freed_tables || tlb->cleared_ptes ||
> > 	      tlb->cleared_pmds || tlb->cleared_puds ||
> > 	      tlb->cleared_p4ds))
> >                 return;
> > 
> > But since there were no cleared PTEs (or anything else) during the
> > unmap, this just returns and doesn't flush the TLB.
> > 
> > We now have an address space with a stale TLB entry at 'ptr1' and not
> > even a VMA there.  There's nothing to stop a new VMA from going in,
> > installing a *new* PTE, but getting data from the stale TLB entry that
> > still hasn't been flushed.
> 
> Thank you for the explanation.  I got you.  I think I could handle the
> case through a new flag in vma or something indicating LUF has deferred
> necessary TLB flush for it during unmapping so that mmu_gather mechanism
> can be aware of it.  Of course, the performance change should be checked
> again.  Thoughts?

I will check the existing optimization of TLB flsuh more in arch level
and suggest a better way.

	Byungchul

> Thanks again.
> 
> 	Byungchul

