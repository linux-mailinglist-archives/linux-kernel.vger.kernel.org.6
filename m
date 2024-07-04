Return-Path: <linux-kernel+bounces-241434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00992927B63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E780B24599
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBC01B29C0;
	Thu,  4 Jul 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UD8Y3jj/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4391B29B3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111464; cv=none; b=dTxk5uxzGwQahca8rQ5xcf0JpyrhnxJOvpk7PKt/j6rjkkbbRlvkddLrCfPFn2XK+Up1C8xv9/Ogzn3gpeCn+hsPQTY/A9CavTAriLs/h7bKONWpAi2YXtELTgusUiLGS6EmbPYZopzeNnNdxiu7b5JTdYibypvhpnVQy04J3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111464; c=relaxed/simple;
	bh=HtDfW4RmeOzDrUSddUaG6I+IXN8ccaGkkmEOavbi1H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGez9+BOa+6CnPGQKA+98Blyi/50iVb+yVFsWNQTgsBfbHiii70ZVJef/MDDwKdazP3wzyZW7/QUPvfotuBi75DTJ6dgn/52ixKkIE6mSAfOcx/gKYGDbl70yGjGYKA+mpwJuaKqXK9qbk4X8xkV2CZeqWT+3hl2l2xfZU5v5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UD8Y3jj/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720111461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBw/J0yJYmD9f3CV3xbbj8+BC2H9ZQJrZWYrHVafND0=;
	b=UD8Y3jj//PGLcgMjqKrJWpVmK+H5One5Q2JrpAHOTTnP/ICrqD4eDniFFQ/QrY+scS4OSN
	B2+QIBr0UL6Cvs1kfOQzp4orkmYmWgGNhXFxnPfaTpR9qrrr3snOb8I4SIGWDJZDETZRGP
	12j4BJdtj+BSm0/atCYYDs3TCjUjeF4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-02gFSe2COpShW9uYbeQBpw-1; Thu, 04 Jul 2024 12:44:20 -0400
X-MC-Unique: 02gFSe2COpShW9uYbeQBpw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c97832f28eso270731a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 09:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720111458; x=1720716258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBw/J0yJYmD9f3CV3xbbj8+BC2H9ZQJrZWYrHVafND0=;
        b=ExlxqkEooh9m3ewmbIKhw+qptMK5AuzoLhx0hRLa7ocd+nCy+dx6hgKa1qi9CHVBEd
         CFSu2B5EZcG2NbL6usbr1huo0oj3Xk7sggd26+d/9drOKzQBbOTBho4k8M4zazhorn7w
         A82U8C9r6A5wAVuU/B/rCXshuh0E1EzKSbJrWjwDJ3H5jJ1ABvjRXMS+yQzSYCLYIWox
         7jeeT1+V76fr0TxOly6655aJMV2Yvg8STpYZyHK4UiuQzpUkyQQwM0khCGF4ys8iKsVB
         QrpRZ2QwbV+scTMUu2/dx1upFyGG+n5UUfyE7IZBPV5+/i805rIRtDYT6yxXqncW59+u
         qtPw==
X-Forwarded-Encrypted: i=1; AJvYcCXtI2dTg/SWYQdU4f8cvdoXodnIGO0KNd3hRYwHXU+ZTLkkSt/8AN+5DK3AFifP2hvIjsCPAUSfMscx22CT21y82wyajRJuAfw81Jcd
X-Gm-Message-State: AOJu0Yw/MqSSp6MKFHrSkB8zzF640fg5Z76OI4h5Kt1CE9XA28pvtBLa
	jhHsgLlZfwWXosm/9fD3i9ZRdQZQ4SKdQTp8GWMF4rMjHXabdhGau/fi1Q+fcUAQ3JzWUcGzmJM
	73uPjTpytF9H7IAvkfgVHgTZi4OoWUlDA68g6YxDYKfvNiwrk3ID5BPrIKaF7D3KOUYNO9w==
X-Received: by 2002:a17:90b:110e:b0:2c9:36d3:8934 with SMTP id 98e67ed59e1d1-2c99c559213mr2080768a91.1.1720111457991;
        Thu, 04 Jul 2024 09:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5ZRD9473lpYFoMcreih2hHxW/kHYYnWWxv5eMI9U+zI40J+3J6xNYuTJ4g1nRRxrgSbZtow==
X-Received: by 2002:a05:6358:2489:b0:1a5:a04d:14fa with SMTP id e5c5f4694b2df-1aa98c761a5mr253873555d.2.1720111437196;
        Thu, 04 Jul 2024 09:43:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5d8fa573fsm26424426d6.37.2024.07.04.09.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 09:43:56 -0700 (PDT)
Date: Thu, 4 Jul 2024 12:43:53 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
Message-ID: <ZobRSSOCfPW2T3Kx@x1n>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com>
 <Zoax9nwi5qmgTQR4@x1n>
 <84d4e799-90da-487e-adba-6174096283b5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84d4e799-90da-487e-adba-6174096283b5@redhat.com>

On Thu, Jul 04, 2024 at 05:23:30PM +0200, David Hildenbrand wrote:
> On 04.07.24 16:30, Peter Xu wrote:
> > Hey, David,
> > 
> 
> Hi!
> 
> > On Thu, Jul 04, 2024 at 12:44:38PM +0200, David Hildenbrand wrote:
> > > There are roughly two categories of page table walkers we have:
> > > 
> > > 1) We actually only want to walk present folios (to be precise, page
> > >     ranges of folios). We should look into moving away from the walk the
> > >     page walker API where possible, and have something better that
> > >     directly gives us the folio (page ranges). Any PTE batching would be
> > >     done internally.
> > > 
> > > 2) We want to deal with non-present folios as well (swp entries and all
> > >     kinds of other stuff). We should maybe implement our custom page
> > >     table walker and move away from walk_page_range(). We are not walking
> > >     "pages" after all but everything else included :)
> > > 
> > > Then, there is a subset of 1) where we only want to walk to a single address
> > > (a single folio). I'm working on that right now to get rid of follow_page()
> > > and some (IIRC 3: KSM an daemon) walk_page_range() users. Hugetlb will still
> > > remain a bit special, but I'm afraid we cannot hide that completely.
> > 
> > Maybe you are talking about the generic concept of "page table walker", not
> > walk_page_range() explicitly?
> > 
> > I'd agree if it's about the generic concept. For example, follow_page()
> > definitely is tailored for getting the page/folio.  But just to mention
> > Oscar's series is only working on the page_walk API itself.  What I see so
> > far is most of the walk_page API users aren't described above - most of
> > them do not fall into category 1) at all, if any. And they either need to
> > fetch something from the pgtable where having the folio isn't enough, or
> > modify the pgtable for different reasons.
> 
> Right, but having 1) does not imply that we won't be having access to the
> page table entry in an abstracted form, the folio is simply the primary
> source of information that these users care about. 2) is an extension of 1),
> but walking+exposing all (or most) other page table entries as well in some
> form, which is certainly harder to get right.
> 
> Taking a look at some examples:
> 
> * madvise_cold_or_pageout_pte_range() only cares about present folios.
> * madvise_free_pte_range() only cares about present folios.
> * break_ksm_ops() only cares about present folios.
> * mlock_walk_ops() only cares about present folios.
> * damon_mkold_ops() only cares about present folios.
> * damon_young_ops() only cares about present folios.
> 
> There are certainly other page_walk API users that are more involved and
> need to do way more magic, which fall into category 2). In particular things
> like swapin_walk_ops(), hmm_walk_ops() and most fs/proc/task_mmu.c. Likely
> there are plenty of them.
> 
> 
> Taking a look at vmscan.c/walk_mm(), I'm not sure how much benefit there
> even is left in using walk_page_range() :)

Hmm, I need to confess from a quick look I didn't yet see why the current
page_walk API won't work under p4d there.. it could be that I missed some
details.

> 
> > 
> > A generic pgtable walker looks still wanted at some point, but it can be
> > too involved to be introduced together with this "remove hugetlb_entry"
> > effort.
> 
> My thinking was if "remove hugetlb_entry" cannot wait for "remove
> page_walk", because we found a reasonable way to do it better and convert
> the individual users. Maybe it can't.
> 
> I've not given up hope that we can end up with something better and clearer
> than the current page_walk API :)

Oh so you meant you have plan to rewrite some of the page_walk API users to
use the new API you plan to propose?

It looks fine by me. I assume anything new will already taking hugetlb
folios into account, so it'll "just work" and actually reduce number of
patches here, am I right?

If it still needs time to land, I think it's also fine that it's done on
top of Oscar's.  So it may boil down to the schedule in that case, and we
may also want to know how Oscar sees this.

> 
> > 
> > To me, that future work is not yet about "get the folio, ignore the
> > pgtable", but about how to abstract different layers of pgtables, so the
> > caller may get a generic concept of "one pgtable entry" with the level/size
> > information attached, and process it at a single place / hook, and perhaps
> > hopefully even work with a device pgtable, as long as it's a radix tree.
> 
> To me 2) is an extension of 1). My thinking is that we can start with 1)
> without having to are about all details of 2). If we have to make it as
> generic that we can walk any page table layout out there in this world, I'm
> not so sure.

I still see a hope there, after all the radix pgtable is indeed a common
abstraction and it looks to me a lot of things share that structure. IIUC
one challenge of it is being fast.  So.. I don't know. But I'll be more
than happy to see it come if someone can work it out, and it just sounds
very nice too if some chunk of code can be run the same for mm/, kvm/ and
iommu/.

Thanks,

-- 
Peter Xu


