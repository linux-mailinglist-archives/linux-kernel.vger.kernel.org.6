Return-Path: <linux-kernel+bounces-188489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7F28CE2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754E9282C92
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295991292E1;
	Fri, 24 May 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvOmlvkR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB529AB
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540853; cv=none; b=Wh+A1r3+N7EM63xSeHuwJ7QlSnGTkx1RenTxHOu4XqD1yO1Cr9nVfvFY1/75rnkopKAM1BIDaaRQvEnIuc3JR75XMudt31/ueQMdrq3pkF4Y9Dwawjq+xsU9UkzFVfDmDVm8fh52oV81T4deM8UOdQMVtCfV7hMEHE5YSSI63Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540853; c=relaxed/simple;
	bh=FAXY6q/KqLfozRRhaLeHqYjWrboj5rE0C/VoQK4TuAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vzc7NpkKT0f6H+LeGvLk0KWXJ+GcMavgaIZlM6ZfqmnDFOa9PDGHduPK0tfy51c4d74PSBbJp/gWAnP5l1vxM5UJESj261i3ZpUIy6DV0PEovo8qBZrEH+GAKlmAY5+kmz9nNR3d8JfszMC/PeAM6sZ0xomzGHV5k5CAztsreAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvOmlvkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D5AC2BBFC;
	Fri, 24 May 2024 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716540852;
	bh=FAXY6q/KqLfozRRhaLeHqYjWrboj5rE0C/VoQK4TuAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvOmlvkR9omRAL+z5koDiA3lYIQCIzzOy/epDpUKdm+tiQ1JCLW5RIMUy/ckma01o
	 p6Bz7FcGd+1Nr8WqCJx/ppZgVN8SXBJ9HwdcqEyJaZhDLhxw6vT6iag8ESefjwzbLD
	 0biPP5VDtEdR70LAIPqOH/mJtFsZzszR0Uaa6eRJidBl6hjzAoWhLgp8Uz9j5gwE52
	 YReQahWGnm6P5od6pbkSxEDPenbZX4pLb4Ebmq9/OX+kmlDDMq1DuEMOmnGBGvMZf+
	 pf9RVOM+GzlLeE3kljkvuwdHyrZaEEZtxThTibHUXNp50tgycfTK0YoffR+PaBhpWo
	 QgjTO6359DUfw==
Date: Fri, 24 May 2024 11:52:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH RFC 3/6] mm/zsmalloc: use a proper page type
Message-ID: <ZlBVRXfZxDJjIIBd@kernel.org>
References: <20240522210341.1030552-1-david@redhat.com>
 <20240522210341.1030552-4-david@redhat.com>
 <2563ea6b-7c65-46a0-adf3-552f2e863c94@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2563ea6b-7c65-46a0-adf3-552f2e863c94@redhat.com>

On Thu, May 23, 2024 at 04:55:44PM +0200, David Hildenbrand wrote:
> On 22.05.24 23:03, David Hildenbrand wrote:
> > Let's clean it up: use a proper page type and store our data (offset
> > into a page) in the lower 16 bit as documented.
> > 
> > We'll have to restrict ourselves to <= 64KB base page size (so the offset
> > fits into 16 bit), which sounds reasonable. Unfortunately, we don't have
> > any space to store it elsewhere for now.
> > 
> > Based on this, we should do a proper "struct zsdesc" conversion, as
> > proposed in [1].
> > 
> > This removes the last _mapcount/page_type offender.
> > 
> > [1] https://lore.kernel.org/all/20231130101242.2590384-1-42.hyeyoo@gmail.com/
> > 
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >   include/linux/page-flags.h |  3 +++
> >   mm/Kconfig                 |  1 +
> >   mm/zsmalloc.c              | 23 +++++++++++++++++++----
> >   3 files changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index ed9ac4b5233d..ccaf16656de9 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -959,6 +959,7 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
> >   #define PG_guard	0x00080000
> >   #define PG_hugetlb	0x00100800
> >   #define PG_slab		0x00200000
> > +#define PG_zsmalloc	0x00400000
> >   #define PageType(page, flag)						\
> >   	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> > @@ -1073,6 +1074,8 @@ FOLIO_TYPE_OPS(hugetlb, hugetlb)
> >   FOLIO_TEST_FLAG_FALSE(hugetlb)
> >   #endif
> > +PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
> > +
> >   /**
> >    * PageHuge - Determine if the page belongs to hugetlbfs
> >    * @page: The page to test.
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index b4cb45255a54..0371d79b1b75 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -190,6 +190,7 @@ config ZSMALLOC
> >   	tristate
> >   	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
> >   	depends on MMU
> > +	depends on PAGE_SIZE_LESS_THAN_256KB # we want <= 64KB
> >   	help
> >   	  zsmalloc is a slab-based memory allocator designed to store
> >   	  pages of various compression levels efficiently. It achieves
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index b42d3545ca85..6f0032e06242 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -20,7 +20,8 @@
> >    *	page->index: links together all component pages of a zspage
> >    *		For the huge page, this is always 0, so we use this field
> >    *		to store handle.
> > - *	page->page_type: first object offset in a subpage of zspage
> > + *	page->page_type: PG_zsmalloc, lower 16 bit locate the first object
> > + *		offset in a subpage of a zspage
> >    *
> >    * Usage of struct page flags:
> >    *	PG_private: identifies the first component page
> > @@ -450,14 +451,22 @@ static inline struct page *get_first_page(struct zspage *zspage)
> >   	return first_page;
> >   }
> > +static inline void reset_first_obj_offset(struct page *page)
> > +{
> > +	page->page_type |= 0xffff;
> > +}
> > +
> >   static inline unsigned int get_first_obj_offset(struct page *page)
> >   {
> > -	return page->page_type;
> > +	return page->page_type & 0xffff;
> >   }
> >   static inline void set_first_obj_offset(struct page *page, unsigned int offset)
> >   {
> > -	page->page_type = offset;
> > +	BUILD_BUG_ON(PAGE_SIZE & ~0xffff);
> 
> Buildbot is correctly complaining with PAGE_SIZE=64KiB.
> 
> We must check BUILD_BUG_ON((PAGE_SIZE -1) & ~0xffff);

Won't 

BUILD_BUG_ON(PAGE_SIZE > SZ_64K)

be clearer?
 
> -- 
> Cheers,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.

