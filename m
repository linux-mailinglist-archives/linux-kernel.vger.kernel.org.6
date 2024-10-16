Return-Path: <linux-kernel+bounces-367973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1886A9A08F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98A4B283F1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184442071E7;
	Wed, 16 Oct 2024 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEZDFPs4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1472076B0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080097; cv=none; b=iR8rF/JKBEHqJFzWtrVaYa/cXcJrJpFKQE3NmsNXtsy6eMs49/jxRPmo0WcIDY+mgO8k1abAkbsxT5o+eJTuTHtXBL5eH22MVHBbTxvYhVa1nU39TgmDIMjNKWy68chZe05kAgB5yPVR2LNH2Kk8fwluEhbedmjXXB3pJMRiNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080097; c=relaxed/simple;
	bh=0wvAIZuJtVKXK3ZNWEeGI+f35fphWLLFON9Xv00nJtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqmNjXi2/4OeYZ9EL1CI0xZ28GtBMfqq0ZVmRKaNp7p1XPuxOCK/59KfQyjk8lu283hXCUZgoTPvkkm/l/yySIaMd7gLTok+4BzLfSpKQBNap2fnU9E7Ha4nioEZrjlSvOsUVSbONlzad9Vx2sjM4Ea94wFBRT0qAluXaE79yZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEZDFPs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90725C4CEC5;
	Wed, 16 Oct 2024 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729080096;
	bh=0wvAIZuJtVKXK3ZNWEeGI+f35fphWLLFON9Xv00nJtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEZDFPs4oMQkuFmLAxFf9PGNhUSf+WbpaQp7U9Wu8VCYlBZy5+PXB9Ik9HsYa6peW
	 jEbE+tfQw6WVBzH8VHTkWLuHdLYOFfTiSKxa5HAi7v79gvU/vPsxQN/OgRgQKVpVNl
	 KmliJIIHPyVNBRaBhe1pWea5wFBQphkT2BZEEwlwy3dzvWu8GMiuW9AY0govJlA4t2
	 XuyZ7oTF+MVN+gsIOyNirYaZuAACHQ3Go4mRUZJi5MQp2jW2Pr36vWayqTf9zMRwY7
	 J1nM5HjwLkApUIi4+2g9EMI4VjEvf+TvJIm+Inri5Nn4Vk3mzoC+w3fWvDE2zSnBOY
	 qAPC+mB9vkl9Q==
Date: Wed, 16 Oct 2024 14:57:59 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Su Hua <suhua.tanke@gmail.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, suhua <suhua1@kingsoft.com>
Subject: Re: [PATCH v1] memblock: Initialized the memory of memblock.reserve
 to the MIGRATE_MOVABL
Message-ID: <Zw-qR3fcOnXHRMf8@kernel.org>
References: <20240925110235.3157-1-suhua1@kingsoft.com>
 <Zvkalqx12KRjXPAE@kernel.org>
 <CALe3CaBWQtGWVUnmW7Kkc7ayEEhqf=Xye0d1MymHn8c5qtx+GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALe3CaBWQtGWVUnmW7Kkc7ayEEhqf=Xye0d1MymHn8c5qtx+GA@mail.gmail.com>

Hi,

On Sat, Oct 12, 2024 at 11:55:31AM +0800, Su Hua wrote:
> Hi Mike
> 
> Thanks for your advice and sorry for taking so long to reply.

Please don't top-post on the Linux kernel mailing lists
 
> I looked at the logic again. deferred_init_pages is currently used to
> handle all (memory &&! reserved) area memblock，and put that memory in
> buddy.
> Change it to also handle reserved memory may involve more code
> changes. I wonder if I can change the commit message: This patch is
> mainly to
> make the migration type to MIGRATE_MOVABLE when the reserve type page
> is initialized, regardless of whether CONFIG_DEFERRED_STRUCT_PAGE_INIT
> is set or not?
> 
> When not set CONFIG_DEFERRED_STRUCT_PAGE_INIT， initializes memblock of
> reserve type to MIGRATE_MOVABLE by default at memmap_init initializes
> memory.

This should be more clearly emphasized in the commit message.
 
> Sincerely yours，
> Su
> 
> 
> Mike Rapoport <rppt@kernel.org> 于2024年9月29日周日 17:18写道：
> >
> > On Wed, Sep 25, 2024 at 07:02:35PM +0800, suhua wrote:
> > > After sparse_init function requests memory for struct page in memblock and
> > > adds it to memblock.reserved, this memory area is present in both
> > > memblock.memory and memblock.reserved.
> > >
> > > When CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set. The memmap_init function
> > > is called during the initialization of the free area of the zone, this
> > > function calls for_each_mem_pfn_range to initialize all memblock.memory,
> > > excluding memory that is also placed in memblock.reserved, such as the
> > > struct page metadata that describes the page, 1TB memory is about 16GB,
> > > and generally this part of reserved memory occupies more than 90% of the
> > > total reserved memory of the system. So all memory in memblock.memory is
> > > set to MIGRATE_MOVABLE according to the alignment of pageblock_nr_pages.
> > > For example, if hugetlb_optimize_vmemmap=1, huge pages are allocated, the
> > > freed pages are placed on buddy's MIGRATE_MOVABL list for use.
> >
> > Please make sure you spell MIGRATE_MOVABLE and MIGRATE_UNMOVABLE correctly.
> >
> > > When CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, only the first_deferred_pfn range
> > > is initialized in memmap_init. The subsequent free_low_memory_core_early
> > > initializes all memblock.reserved memory but not MIGRATE_MOVABL. All
> > > memblock.memory is set to MIGRATE_MOVABL when it is placed in buddy via
> > > free_low_memory_core_early and deferred_init_memmap. As a result, when
> > > hugetlb_optimize_vmemmap=1 and huge pages are allocated, the freed pages
> > > will be placed on buddy's MIGRATE_UNMOVABL list (For example, on machines
> > > with 1TB of memory, alloc 2MB huge page size of 1000GB frees up about 15GB
> > > to MIGRATE_UNMOVABL). Since the huge page alloc requires a MIGRATE_MOVABL
> > > page, a fallback is performed to alloc memory from MIGRATE_UNMOVABL for
> > > MIGRATE_MOVABL.
> > >
> > > Large amount of UNMOVABL memory is not conducive to defragmentation, so
> > > the reserved memory is also set to MIGRATE_MOVABLE in the
> > > free_low_memory_core_early phase following the alignment of
> > > pageblock_nr_pages.
> > >
> > > Eg：
> > > echo 500000 > /proc/sys/vm/nr_hugepages
> > > cat /proc/pagetypeinfo
> > >
> > > before：
> > > Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
> > > …
> > > Node    0, zone   Normal, type    Unmovable     51      2      1     28     53     35     35     43     40     69   3852
> > > Node    0, zone   Normal, type      Movable   6485   4610    666    202    200    185    208     87     54      2    240
> > > Node    0, zone   Normal, type  Reclaimable      2      2      1     23     13      1      2      1      0      1      0
> > > Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> > > Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
> > > Unmovable ≈ 15GB
> > >
> > > after：
> > > Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
> > > …
> > > Node    0, zone   Normal, type    Unmovable      0      1      1      0      0      0      0      1      1      1      0
> > > Node    0, zone   Normal, type      Movable   1563   4107   1119    189    256    368    286    132    109      4   3841
> > > Node    0, zone   Normal, type  Reclaimable      2      2      1     23     13      1      2      1      0      1      0
> > > Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> > > Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
> > >
> > > Signed-off-by: suhua <suhua1@kingsoft.com>
> > > ---
> > >  mm/mm_init.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > index 4ba5607aaf19..e0190e3f8f26 100644
> > > --- a/mm/mm_init.c
> > > +++ b/mm/mm_init.c
> > > @@ -722,6 +722,12 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
> > >               if (zone_spans_pfn(zone, pfn))
> > >                       break;
> > >       }
> > > +
> > > +     if (pageblock_aligned(pfn)) {
> > > +             set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE);
> > > +             cond_resched();

No need to call cond_resched() here

> > > +     }
> > > +
> > >       __init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> > >  }
> > >  #else
> > > --
> > > 2.34.1
> > >
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.

