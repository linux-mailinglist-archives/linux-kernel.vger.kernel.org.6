Return-Path: <linux-kernel+bounces-210418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0FB90436B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320351C23021
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377A571B30;
	Tue, 11 Jun 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G+EiwD4G"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539A376E9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130127; cv=none; b=d+BXq1omxR6dyOFvL7WbtJ1IZ3+WDHjuuODSaPNazQeiIEbWhZrfwd+c0x55VeSY0yolSKWsOQ9khuCpS5LqklxgO+/VPqhsUO36cgEXtJNtxuXp4CIirhkmYyC0YvdEW9J3wnlgydHOofVaqY6AnF2gL0GvGYPrVCwax8wlQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130127; c=relaxed/simple;
	bh=aZIw2wIw6HZncUZ9BiHGTY56QThK53FOhX5SS3cSeC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW9t6WEzQpctRHfuPeeRlhdNm5x/E4ArhjM7A1drc+d25F03UyUEreqCKmrOlBASKTUMRqk/bEcLF/MjdaxOFUkYetQAwfMVVzYN9jiARoiW2bFX0UZLZdbe5gqXnj6S24s8L8MsAVPELVkKgYIAArHoGlOqy/DH5Lqx+e2/v5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G+EiwD4G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v+biT19hMk3zmDJ0JM4Tlgb3u1aCfIc9jRZYIonIyMw=; b=G+EiwD4GDC9cHvXeCq1YHv7ti/
	IlYTLigKWg5uv1EP0m2ybhYhGX9h/GnK3Hq5lwa2LxVKZDbmMrx+ifr/gJD1jXzUu9Nn7REYTzNJz
	CIeTPq+SURoWmu7zjSItVG/hbpeDrAbHF6GgqvufLdPYB+c9PHtctRqIcjYqPf/xD8YBKpt03+b65
	VS1AwqXwbhM4Az0f0HjF68guIUL4sj11S3+ONs2WpSLuPfRvgAPR3KptfXUYnvicH+oYupZhxnEk5
	JtdTIvo2npekB4qU11ivs6xb9vLohXCzoj/vAbxDoXiWdmfu20hjbIlQhpIFf8JoO4djRr0qnPRdj
	R5zIZyjg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH68B-0000000Dwm0-2FcS;
	Tue, 11 Jun 2024 18:22:03 +0000
Date: Tue, 11 Jun 2024 19:22:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Bresticker <abrestic@rivosinc.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
Message-ID: <ZmiVy8iE93HGkBWv@casper.infradead.org>
References: <20240611153216.2794513-1-abrestic@rivosinc.com>
 <8040793f-e9e9-4a2e-807c-afcb310a48f5@redhat.com>
 <20240611110622.8e9892e92618ddc36bca11b7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611110622.8e9892e92618ddc36bca11b7@linux-foundation.org>

On Tue, Jun 11, 2024 at 11:06:22AM -0700, Andrew Morton wrote:
> On Tue, 11 Jun 2024 17:33:17 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > On 11.06.24 17:32, Andrew Bresticker wrote:
> > > The requirement that the head page be passed to do_set_pmd() was added
> > > in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
> > > folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
> > > finish_fault() and filemap_map_pages() paths if the page to be inserted
> > > is anything but the head page for an otherwise suitable vma and pmd-sized
> > > page.
> > > 
> > > Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()")
> > > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > > ---
> > >   mm/memory.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 0f47a533014e..a1fce5ddacb3 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4614,8 +4614,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> > >   	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
> > >   		return ret;
> > >   
> > > -	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
> > > +	if (folio_order(folio) != HPAGE_PMD_ORDER)
> > >   		return ret;
> > > +	page = &folio->page;
> > >   
> > >   	/*
> > >   	 * Just backoff if any subpage of a THP is corrupted otherwise
> > 
> > Acked-by: David Hildenbrand <david@redhat.com>
> 
> You know what I'm going to ask ;) I'm assuming that the runtime effects
> are "small performance optimization" and that "should we backport the
> fix" is "no".

We're going to stop using PMDs to map large folios unless the fault is
within the first 4KiB of the PMD.  No idea how many workloads that
affects, but it only needs to be backported as far as v6.8, so we
may as well backport it.

