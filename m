Return-Path: <linux-kernel+bounces-523669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189AFA3D9D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CBA17E86E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064D1F542E;
	Thu, 20 Feb 2025 12:21:03 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4F1F1523
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054062; cv=none; b=LioAy8oAaPbXkkq/xuZa+s/fO5CgW9SvSvQLhTuBdEckM+GtlCr7g2Gnb61XkYrgCU0NJUfFGfXuSTUl3QMRCxxbUobb4IPTl7mz5vy+kdePPnqpixjo37PrYiQA0e8odjvVwmVCZZ1cu0ONs4u6bSERKVLtejE21LXIyvUCi5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054062; c=relaxed/simple;
	bh=qhK5o+lkXp3UJdFlZGJX3m74glatOzIKBp7MSSmUjyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sqi2LKud7PzwqnLZ3/zIVg//lym1pjpJ9/AnACyWMAbgbgRdShUvEU1Ne4CaDoK1CxMmZPKW/hrJobvgLVQTTju35WfyAC+8BZb3mQlrAaJ725NQCrh+1zf3eE8v127s+SeGaWOw23h+wVERw7a59xNEnCdEp0oxPHpj5bQrVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-f4-67b71e250467
Date: Thu, 20 Feb 2025 21:20:48 +0900
From: Byungchul Park <byungchul@sk.com>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20250220122048.GA8305@system.software.com>
References: <20250220052027.58847-1-byungchul@sk.com>
 <20250220103223.2360-1-hdanton@sina.com>
 <20250220114920.2383-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220114920.2383-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsXC9ZZnoa6q3PZ0g03TlC0O/HzOYnF51xw2
	i3tr/rM6MHts+jSJ3WPSC3ePz5vkApijuGxSUnMyy1KL9O0SuDIeP/jJXPBbqmLRiVXsDYwP
	RLoYOTkkBEwkfj46yw5jr2xoYAWxWQRUJd5O/scEYrMJqEvcuPGTGcQWEVCW6LwwC6yGWcBf
	YsKtDSwgtrBAhMSTQyfA6nkFzCV+3TwOVi8k0M0oseZZOkRcUOLkzCcsEL1aEjf+vQSq5wCy
	pSWW/+MACXMKmEr0H1nECGKLAq06sO04UAkX0Gk/WSX+LmmAulNS4uCKGywTGAVmIRk7C8nY
	WQhjFzAyr2IUyswry03MzDHRy6jMy6zQS87P3cQIDM5ltX+idzB+uhB8iFGAg1GJh3dG67Z0
	IdbEsuLK3EOMEhzMSiK8bfVb0oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1O
	TS1ILYLJMnFwSjUwFsZmSDeJJnwp6/u8KaaC+X6RwTwbjtunS+8ezPp51Z/r4MKEhy/1VMSN
	JL54C8080vDcaMae6YsrvLJUYpgljvU95H38bvEFn92Tvz1WLfnlLDAn+crrA3GGmv5yfrOb
	JuXdEw1I4mtbvEHPrm/7xGdSdzZO2vaj1MCzrH1q20+Wx+fCFs89q8RSnJFoqMVcVJwIAFUS
	jP1KAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsXC5WfdrKsqtz3d4MMfCYsDP5+zWByee5LV
	4vKuOWwW99b8Z3Vg8dj0aRK7x6QX7h6LX3xg8vi8SS6AJYrLJiU1J7MstUjfLoEr4/GDn8wF
	v6UqFp1Yxd7A+ECki5GTQ0LARGJlQwMriM0ioCrxdvI/JhCbTUBd4saNn8wgtoiAskTnhVlg
	NcwC/hITbm1gAbGFBSIknhw6AVbPK2Au8evmcbB6IYFuRok1z9Ih4oISJ2c+YYHo1ZK48e8l
	UD0HkC0tsfwfB0iYU8BUov/IIkYQWxRo1YFtx5kmMPLOQtI9C0n3LITuBYzMqxhFMvPKchMz
	c0z1irMzKvMyK/SS83M3MQJDbVntn4k7GL9cdj/EKMDBqMTD++Dx1nQh1sSy4srcQ4wSHMxK
	Irxt9VvShXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhhX
	ZPp5RDfbaKyr234xZtls07V+SRUzd90R3Pcuwdx69dYlsy9oHRKcJPrgxNl/NnukPogISZsZ
	zT+Vpn3t/sUYVtUrz5+IxIhzrX7myZq6smBB2youocfuIcHBEeqMTipfHdbo52QeXM7oFmD6
	ZP1aP19ft1OSjzNOffPcrxi4+vXOGYbZQUJKLMUZiYZazEXFiQAE6RAjMQIAAA==
X-CFilter-Loop: Reflected

On Thu, Feb 20, 2025 at 07:49:19PM +0800, Hillf Danton wrote:
> On Thu, 20 Feb 2025 20:09:35 +0900 Byungchul Park wrote:
> > On Thu, Feb 20, 2025 at 06:32:22PM +0800, Hillf Danton wrote:
> > > On Thu, 20 Feb 2025 14:20:01 +0900 Byungchul Park <byungchul@sk.com>
> > > > To check luf's stability, I ran a heavy LLM inference workload consuming
> > > > 210GiB over 7 days on a machine with 140GiB memory, and decided it's
> > > > stable enough.
> > > > 
> > > > I'm posting the latest version so that anyone can try luf mechanism if
> > > > wanted by any chance.  However, I tagged RFC again because there are
> > > > still issues that should be resolved to merge to mainline:
> > > > 
> > > >    1. Even though system wide total cpu time for TLB shootdown is
> > > >       reduced over 95%, page allocation paths should take additional cpu
> > > >       time shifted from page reclaim to perform TLB shootdown.
> > > > 
> > > >    2. We need luf debug feature to detect when luf goes wrong by any
> > > >       chance.  I implemented just a draft version that checks the sanity
> > > >       on mkwrite(), kmap(), and so on.  I need to gather better ideas
> > > >       to improve the debug feature.
> > > > 
> > > > ---
> > > > 
> > > > Hi everyone,
> > > > 
> > > > While I'm working with a tiered memory system e.g. CXL memory, I have
> > > > been facing migration overhead esp. tlb shootdown on promotion or
> > > > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > > > migration through hinting fault can be avoided thanks to Huang Ying's
> > > > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > > > is inaccessible").
> > > > 
> > > > However, it's only for migration through hinting fault.  I thought it'd
> > > > be much better if we have a general mechanism to reduce all the tlb
> > > > numbers that we can apply to any unmap code, that we normally believe
> > > > tlb flush should be followed.
> > > > 
> > > > I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), that defers tlb
> > > > flush until folios that have been unmapped and freed, eventually get
> > > > allocated again.  It's safe for folios that had been mapped read-only
> > > > and were unmapped, as long as the contents of the folios don't change
> > > > while staying in pcp or buddy so we can still read the data through the
> > > > stale tlb entries.
> > > >
> > > Given pcp or buddy, you are opening window for use after free which makes
> > > no sense in 99% cases.
> > 
> > Just in case that I don't understand what you meant and for better
> > understanding, can you provide a simple and problematic example from
> > the u-a-f?
> > 
> Tell us if it is illegal to commit rape without pregnancy in your home town?

Memory overcommit also looked cheating to someone like you.  You
definitely think it'd be totally non-sense that each task believes it
can use its own full virtual space.

We say uaf is illegal only when it can cause access the free area
without *appropriate permission*.

> PS defering flushing tlb [1,2] is no go.

I will check this shortly.

	Byungchul
> 
> Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
> [1] https://lore.kernel.org/lkml/20250127155146.GB25757@willie-the-truck/
> [2] https://lore.kernel.org/lkml/xhsmhwmdwihte.mognet@vschneid-thinkpadt14sgen2i.remote.csb/

