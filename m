Return-Path: <linux-kernel+bounces-561929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D46A618B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA2617C9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8071F20371B;
	Fri, 14 Mar 2025 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d+uoEhMG"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436186340
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974978; cv=none; b=s0mxQ9py9hsZVLGihxBLBR07JcT8d7r6BDQ+aiCI2PnFTDtwa4oi9iEQLdTSyP2Lw4T++yADdLfHasDzEzsGvt5tbghD31m3wwrsEmuQNMM0Vi9FuJDHrhfgd2Ow1PUZ52f0mKG2997U5CweT0Zcf7DXQ3Kcel3OyV1M8A+Txxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974978; c=relaxed/simple;
	bh=rCirKjzfvYAc5wfNn20g1mquip2FF65JR86cA0xldIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYmI24s3jglvoYyM7lYew03faxHGX5KXHI/rpGuOLKRxyhxeJk1mT8c3lMIK81Rj8S4LdvS1WbkRLjGacJgA9lfiiasByBEhGxpTfncO0uscVD7S7M5GkiKNrAiuBeQYFw/TTp0oghX24SEH9Y98U/V9lU1te/WFqFA2GoMmgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d+uoEhMG; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 17:56:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741974972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BQq+xAUXw60P/WE4bsmNx/WDxIn+sXXBd4O7Hava98=;
	b=d+uoEhMG5JP4+cAPvMVU5tsk/NNKrtJjzzDxQt0oICJuSR6SVt3GPfUnoBT/gvSLdRfwCj
	bVa/b43CObA8GFyMyeLk8DWajc20Z3qYilR3LkAtRzB6x4gQZZKv4rhlBGyYFW5YVD1z4n
	3btLDqoJP/58bzLTXF4kPuiXJk47JXE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Brendan Jackman <jackmanb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
	Junaid Shahid <junaids@google.com>,
	Reiji Watanabe <reijiw@google.com>,
	Patrick Bellasi <derkling@google.com>
Subject: Re: [PATCH RFC 03/11] x86/mm: Add lookup_pgtable_in_pgd()
Message-ID: <Z9Rttphxya4VjgFX@google.com>
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
 <20250313-asi-page-alloc-v1-3-04972e046cea@google.com>
 <Z9NXkZ0_5dtqzaUB@google.com>
 <Z9Py5PX05iKhreqr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Py5PX05iKhreqr@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 14, 2025 at 09:12:04AM +0000, Brendan Jackman wrote:
> On Thu, Mar 13, 2025 at 10:09:21PM +0000, Yosry Ahmed wrote:
> > On Thu, Mar 13, 2025 at 06:11:22PM +0000, Brendan Jackman wrote:
> > > This is the same thing as lookup_address_in_pgd(), but it returns the
> > > pagetable unconditionally instead of returning NULL when the pagetable
> > > is none. This will be used for looking up and modifying pages that are
> > > *_none() in order to map memory into the ASI restricted address space.
> > > 
> > > For a [PATCH], if this logic is needed, the surrounding code should
> > > probably first be somewhat refactored. It now looks pretty repetitive,
> > > and it's confusing that lookup_address_in_pgd() returns NULL when
> > > pmd_none() but note when pte_none(). For now here's something that
> > > works.
> > 
> > My first instinct reading this is that lookup_address_in_pgd() should be
> > calling lookup_pgtable_in_pgd(), but I didn't look too closely.
> 
> Yeah. That outer function would get a "generic" PTE pointer isntead of
> a strongly-typed p4d_t/pud_t/etc. So we either need to encode
> assumptions that all the page tables have the same structure at
> different levels for the bits we care about, or we need to have a
> switch(*level) and then be careful about pgtable_l5_enabled(). I
> think the former is fine but it needs a bit of care and attention to
> ensure we don't miss anything and avoid creating
> confusion/antipatterns in the code.

Hmm another option is to have a common helper that takes in a lot of
parameters to control the exact behavior (e.g. do we check for 'none'?),
and have both lookup_pgtable_in_pgd() and lookup_address_in_pgd() call
it with different parameters.

This could avoid the need for a generic pointer, for example.

> 
> And perhaps more importantly, lookup_adress_in_pgd_attr() sets *nx and
> *rw based on the level above the entry it returns.  E.g. when it
> returns a pte_t* it sets *nx pased on pmd_flags(). I haven't looked
> into why this is.
> 
> So yeah overall it needs a bit of research and most likely needs a
> couple of prep patches. Hopefully it's possible to do it in a way that
> leaves the existing code in a clearer state.

Agreed.

> 
> Anyway, I was originally planning not to have asi_map()/asi_unmap() in
> asi.c at all, and instead just kinda make set_memory.c natively aware
> of ASI somehow. At that point I think this code is probably gonna look
> a bit different. That's something I ran out of time for and had to
> drop from the scope of this RFC. It's definitely not ideal in this
> series that e.g. page_alloc.c, asi.c, and set_memory.c are all
> implicitly coupled to one another (i.e. they are all colluding to
> ensure asi_[un]map() never has to allocate). Maybe I should've called
> this out as a TODO on the cover letter actually.

Looking forward to seeing how this would look like :)

