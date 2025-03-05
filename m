Return-Path: <linux-kernel+bounces-546988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B851A50183
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7ED16C28A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1D24A07A;
	Wed,  5 Mar 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XYZ5hYRg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1904155751
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183933; cv=none; b=U3mJvnGfvM6OZ09YOiCaTBnXfQI43EIeF1OsuUfYIrECg+RSKJUT5g99+UAUgHiW1ZH8dEk1px2NbK4QPXqifvIORDMClOqdwdGATvG5WzaY96FOvENY6SZQVKQBWi+6VMdJTd5REQXaWDY8NfFfX1ChB6enciNAFr7mGbXLMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183933; c=relaxed/simple;
	bh=grVyp7Fdfot/7x+deJ8ZpTNeP+bMnLnQMziPvywsyJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJuoW4fXZitdhEYjIeWuXseKl3e6i/sJsKRM9OKOxJB6p//oSNayherK6nHdGWgtUZq2aiJ/XwaYSiRWmfzmudUgM3MNApRn2/gejjXUg0tOWFyqeTEsBTvTqDkA5RYV0YbtBbIyUKUp1LRIKdbDXyAcINvtgRT5xElWN07Palk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XYZ5hYRg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LYtlhxVzhTyajNUxQxNY5jgj6oy4DfbsP7RDQCKcybE=; b=XYZ5hYRglm9fc5zCOcSxAK8jbb
	tQHenp906XZ1VfnkIDQVZSTspC4l+BFmKj+a1PpTAnPmBKCAYANgSGYC13wu2er4LKS1kXgxOyFmM
	732lpNwrykjBw3G7dUQ9ABVblOgn1NpBeMHpKXeYPBugXVCDLCpZqKuMjSCvrJ0irG/dpFaZLgB/X
	Pyp59hM1v5LvkWXCUsL/YnIRTJIqjGoD/Tv9iwv2/6wLn1vdZPVmflDhrs1VsFJip1tEbkQxxxRwV
	jMQdoOJwPMn+oBJyI06ap2w/ra5S16Kx7F6EAD9LELTsHit1kStmSAI2Fnl2uDeMpuDmOjoRJC7uf
	7p2ncKCA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tppTj-00000005dei-1hr5;
	Wed, 05 Mar 2025 14:12:07 +0000
Date: Wed, 5 Mar 2025 14:12:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, ziy@nvidia.com, hughd@google.com,
	ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [QUESTION] Plain dereference and READ_ONCE() in fault handler
Message-ID: <Z8hbt_Y1djSHvq7C@casper.infradead.org>
References: <20250305102159.96420-1-dev.jain@arm.com>
 <8477d9ec-b9ce-4a3d-b61f-1bd44d3360a5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8477d9ec-b9ce-4a3d-b61f-1bd44d3360a5@redhat.com>

On Wed, Mar 05, 2025 at 11:46:41AM +0100, David Hildenbrand wrote:
> On 05.03.25 11:21, Dev Jain wrote:
> > In __handle_mm_fault(),
> > 
> > 1. Why is there a barrier() for the PUD logic?
> 
> Good question. It was added in
> 
> commit a00cc7d9dd93d66a3fb83fc52aa57a4bec51c517
> Author: Matthew Wilcox <willy@infradead.org>
> Date:   Fri Feb 24 14:57:02 2017 -0800
> 
>     mm, x86: add support for PUD-sized transparent hugepages
> 
> Maybe it was an alternative to performing a READ_ONCE(*vmf.pud).

I was monkey-see, monkey-do.

Here's the corresponding code as it existed at the time:

        } else {
                pmd_t orig_pmd = *vmf.pmd;

                barrier();
                if (pmd_trans_huge(orig_pmd) || pmd_devmap(orig_pmd)) {
                        vmf.flags |= FAULT_FLAG_SIZE_PMD;

vs what I added:

        } else {
                pud_t orig_pud = *vmf.pud;

                barrier();
                if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {

At some point, somebody added pmdp_get_lockless() and did not add a
corresponding pudp_get_lockless().  And it was ... Hugh in 26e1a0c3277d

If you want to add a pudp_get_lockless(), I doubt anyone will object,
but it's probably pointless churn.

> Maybe it was done that way, because pudp_get_lockless() does not exist. And
> it would likely not be required, because on architectures where
> ptep_get_lockless() does some magic (see below, mostly 32bit), PUD THP are
> not applicable.
> 
> 
> > 2. For the PMD logic, in the if block, we use *vmf.pmd, and in the else block
> >     we use pmdp_get_lockless(); what if someone changes the pmd just when we
> >     have begun processing the conditions in the if block, fail in the if block
> >     and then the else block operates on a different pmd value. Shouldn't we cache
> >     the value of the pmd and operate on a single consistent value until we take the
> >     lock and then finally check using pxd_same() and friends?
> 
> The pmd_none(*vmf.pmd) is fine. create_huge_pmd() must be able to deal with
> races, because we are not holding any locks.
> 
> We only have to use pmdp_get_lockless() when we want to effectively perform
> a READ_ONCE(), and make sure that we read something "reasonable" that we can
> operate on, even with concurrent changes. (e.g., not read a garbage PFN just
> because of some concurrent changes)
> 
> We'll store the value in vmf.orig_pmd, on which we'll operate and try to
> detect later changes using pmd_same(). So we really want something
> consistent in there.
> 
> See the description above ptep_get_lockless(), why we cannot simply do a
> READ_ONCE on architectures where a PTE cannot be read atomically (e.g., 8
> byte PTEs on 32bit architecture).
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

