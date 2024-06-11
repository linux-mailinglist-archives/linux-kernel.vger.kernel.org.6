Return-Path: <linux-kernel+bounces-210555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EB9904585
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395C0286780
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176C1420B8;
	Tue, 11 Jun 2024 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Thu2Lc5g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEA1879
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136450; cv=none; b=HAwX2TbLR2vAiUu8VHU5oCM4KIGO3zqcDNtA8v/5E7lpNSQ8x1xyw4TUX5DHkEc20t/ZR3mE3igFFECdSOpq/UKGFLbqmsDCX07pj4GM1BANOvUpzkFMj/R3BsrOqhXeet14iOvaOpIls83pfX8eHXJXNK0hZKr5cW7ZcArfHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136450; c=relaxed/simple;
	bh=DG9vo/TGCvMC6IRGF/KFN1oVAg3uKyYRvrG//+CxZaU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dd3YGTvRpM4btRann1F50w4yGGKzOImvaHEbisQ5+o3koC+cCLLbdFQifidFDJUXGSconeoKEENU9KM9Ej+gJ1jhu6WJJ24D+pW1IMvT1Z4Zw3QnWMaYByqOVifchysxHANkXSG4nU5ImbvvJSeuFFeWMHICKP99nIQQntpLcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Thu2Lc5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9921C2BD10;
	Tue, 11 Jun 2024 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718136449;
	bh=DG9vo/TGCvMC6IRGF/KFN1oVAg3uKyYRvrG//+CxZaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Thu2Lc5gQVhk9sw9DKVi+PFqf5BEYPlIHGic73ofQJ/f65R9OYtoAh8p5nGgW6f2g
	 Prjd4WzfOw+X7iK4Aoeqj7B4R86dlrJbqAOZQp3hszmBs7d1vT/i52ufuzBCoqF98A
	 NxfRYSXeRcrwBfQy701uL6t9cpzE6IEHcY3UAOAc=
Date: Tue, 11 Jun 2024 13:07:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, Andrew Bresticker
 <abrestic@rivosinc.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
Message-Id: <20240611130729.d53cbcd1767f917b47540cca@linux-foundation.org>
In-Reply-To: <ZmiVy8iE93HGkBWv@casper.infradead.org>
References: <20240611153216.2794513-1-abrestic@rivosinc.com>
	<8040793f-e9e9-4a2e-807c-afcb310a48f5@redhat.com>
	<20240611110622.8e9892e92618ddc36bca11b7@linux-foundation.org>
	<ZmiVy8iE93HGkBWv@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 19:22:03 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Jun 11, 2024 at 11:06:22AM -0700, Andrew Morton wrote:
> > On Tue, 11 Jun 2024 17:33:17 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> > > On 11.06.24 17:32, Andrew Bresticker wrote:
> > > > The requirement that the head page be passed to do_set_pmd() was added
> > > > in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
> > > > folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
> > > > finish_fault() and filemap_map_pages() paths if the page to be inserted
> > > > is anything but the head page for an otherwise suitable vma and pmd-sized
> > > > page.
> > > > 
> > > > Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()")
> > > > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > > > ---
> > > >   mm/memory.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 0f47a533014e..a1fce5ddacb3 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -4614,8 +4614,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> > > >   	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
> > > >   		return ret;
> > > >   
> > > > -	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
> > > > +	if (folio_order(folio) != HPAGE_PMD_ORDER)
> > > >   		return ret;
> > > > +	page = &folio->page;
> > > >   
> > > >   	/*
> > > >   	 * Just backoff if any subpage of a THP is corrupted otherwise
> > > 
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > 
> > You know what I'm going to ask ;) I'm assuming that the runtime effects
> > are "small performance optimization" and that "should we backport the
> > fix" is "no".
> 
> We're going to stop using PMDs to map large folios unless the fault is
> within the first 4KiB of the PMD.  No idea how many workloads that
> affects, but it only needs to be backported as far as v6.8, so we
> may as well backport it.

OK, thanks, I pasted the above text and added the cc:stable.

I didn't move it into the hotfixes queue - it's a non-trivial
behavioral change and extra test time seems prudent(?).

