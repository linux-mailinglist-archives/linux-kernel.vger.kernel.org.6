Return-Path: <linux-kernel+bounces-244921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AB092AB81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671D3281403
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C5B14F11C;
	Mon,  8 Jul 2024 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZruS5U54"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815F7345B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720475457; cv=none; b=t2eYNwMiGIwKM+D3qlZZkQ52oBUohdt9+H5zuWpys2kcn1SbZkmPPZehqv9qsCUzAmlG0oiatrAZhJPiTkZrrTzqAgjNw8ZBLuP0BXklJ3JT3k4IK2ZQ/uObAkRr9AIcRCU5/WVlLTmtTYmH5v1xQhROkHLfJqH0Je6C3JzbcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720475457; c=relaxed/simple;
	bh=CGhJ++WMMJldXOYCgNnryvzCnalvDx/0i19ERCrU6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0Pl9ddydWe5bVquBNW9oqj1E8WMAex68Xve+fE2dhsVGUa+hpA8sfTI99a2eW6p8gYpZGlz7vMUNnxXRutGitCid+gaRxpa7GeYttpJ5QL+mYpUqRi6wYgTA/EdxDROfo81l1K7vD1NdYSAEw4T9rFkjFyqMUmME7MjyGW5Ozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZruS5U54; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720475454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XseuSPGkDJ27OOmizeaAYkdaDU09mgUt9vN5WdBaaf0=;
	b=ZruS5U54FfpHs85/mOUW7TDsgxYgjaJngItaTAtWJA8bQJ0lkWLmJ0mV698fc1WDY26d0Q
	AUoofdIkBYCsULN9x0J5KLZqQw9RJIq81dEN9WH+eqA4LA10GIjZPF1FjslqOrKoe54Gli
	U08AjMYAbue73cCXrcKQfZhwKF+kVK8=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-co7-elyrOlyGe3BA_EPDcw-1; Mon, 08 Jul 2024 17:50:53 -0400
X-MC-Unique: co7-elyrOlyGe3BA_EPDcw-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-48ff6aa3d8cso270871137.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720475453; x=1721080253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XseuSPGkDJ27OOmizeaAYkdaDU09mgUt9vN5WdBaaf0=;
        b=srVxdA4xufuTSeFHE+hFamzmHPEyAurh6VjuKTN+z+WrJrZNCzNzjNaz4+tW0mSfRw
         SKoj7RYJkXOOeQoLW8U7H8IyMQdSM5WvY/qMJSjNef8edAzH51i9ER2VUnhVrLNiQR0d
         9eEhz3FEfFxWKjnF1/wgy3V3bsRKjeTX1phLHiXM/5HHJ6kprD5Vj1w/XZikq5RRm+Iw
         6SjP3VrBOsfpgvrGQjn6kyfC10G4VRglMvUGdE6ZdbXghw8r+dBxLQBHq/1Rr907gmLN
         c39xfU9tJdWm3+6RtkyqofnUwvt9ahlrhXbtFRdM3mxW9QBVLtVhkKQz3S4fPZKHmoXV
         rbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2uBNwzFLwBNrI7nO8rJiD0cljDkY2XGqAQ0ktI1X8sGIdyr9aME9OGGQr6F7gWmfE3A0j1XLDGLn9UKH8bA8N5bTfVX/aFasejR/7
X-Gm-Message-State: AOJu0YzPrA+w+bu7GbBSxpmDtRejavAudaRWaeyhv+RhAtlUcR+NMzeT
	IBcK6tg6RR7mBFwp2hqNMKLmkcJzJqTUe5jdWN7vucA9w6scsrqCZICdLm5hFWuj3EocXK6dIt8
	Wddqm21KtprOCg6WfGfrAMDPnH/5TjBi2i8prKCc+V89fMqkU8fVCOgrjHvm5IQ==
X-Received: by 2002:a05:6102:549e:b0:48f:e729:f476 with SMTP id ada2fe7eead31-4903220c4c2mr771714137.2.1720475452864;
        Mon, 08 Jul 2024 14:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXeSjvMFB80yk4vNSDELW45skeRc2NPeBOJ3FpTQYCg15myh1f/p8d//jJWxYNCrhNEEK1vw==
X-Received: by 2002:a05:6102:549e:b0:48f:e729:f476 with SMTP id ada2fe7eead31-4903220c4c2mr771706137.2.1720475452543;
        Mon, 08 Jul 2024 14:50:52 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b522fesm3533721cf.51.2024.07.08.14.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:50:51 -0700 (PDT)
Date: Mon, 8 Jul 2024 17:50:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Huang Ying <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm/migrate: fix kernel BUG at
 mm/compaction.c:2761!
Message-ID: <ZoxfOZ48v-lrOcyb@x1n>
References: <46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com>
 <ZowLTDJG_i2ILmx7@x1n>
 <BF97E908-8FC9-43FD-909B-845994FB36E8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BF97E908-8FC9-43FD-909B-845994FB36E8@nvidia.com>

On Mon, Jul 08, 2024 at 12:39:10PM -0400, Zi Yan wrote:
> On 8 Jul 2024, at 11:52, Peter Xu wrote:
> 
> > On Tue, Jun 11, 2024 at 10:06:20PM -0700, Hugh Dickins wrote:
> >> I hit the VM_BUG_ON(!list_empty(&cc->migratepages)) in compact_zone();
> >> and if DEBUG_VM were off, then pages would be lost on a local list.
> >>
> >> Our convention is that if migrate_pages() reports complete success (0),
> >> then the migratepages list will be empty; but if it reports an error or
> >> some pages remaining, then its caller must putback_movable_pages().
> >>
> >> There's a new case in which migrate_pages() has been reporting complete
> >> success, but returning with pages left on the migratepages list: when
> >> migrate_pages_batch() successfully split a folio on the deferred list,
> >> but then the "Failure isn't counted" call does not dispose of them all.
> >>
> >> Since that block is expecting the large folio to have been counted as 1
> >> failure already, and since the return code is later adjusted to success
> >> whenever the returned list is found empty, the simple way to fix this
> >> safely is to count splitting the deferred folio as "a failure".
> >>
> >> Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
> >> Signed-off-by: Hugh Dickins <hughd@google.com>
> >> ---
> >> A hotfix to 6.10-rc, not needed for stable.
> >>
> >>  mm/migrate.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -1654,7 +1654,12 @@ static int migrate_pages_batch(struct list_head *from,
> >>
> >>  			/*
> >>  			 * The rare folio on the deferred split list should
> >> -			 * be split now. It should not count as a failure.
> >> +			 * be split now. It should not count as a failure:
> >> +			 * but increment nr_failed because, without doing so,
> >> +			 * migrate_pages() may report success with (split but
> >> +			 * unmigrated) pages still on its fromlist; whereas it
> >> +			 * always reports success when its fromlist is empty.
> >> +			 *
> >>  			 * Only check it without removing it from the list.
> >>  			 * Since the folio can be on deferred_split_scan()
> >>  			 * local list and removing it can cause the local list
> >> @@ -1669,6 +1674,7 @@ static int migrate_pages_batch(struct list_head *from,
> >>  			if (nr_pages > 2 &&
> >>  			   !list_empty(&folio->_deferred_list)) {
> >>  				if (try_split_folio(folio, split_folios) == 0) {
> >> +					nr_failed++;
> >>  					stats->nr_thp_split += is_thp;
> >>  					stats->nr_split++;
> >>  					continue;
> >> -- 
> >> 2.35.3
> >>
> >>
> >
> > We probably hit the same issue in our testbeds, but in the other
> > migrate_misplaced_folio() path, which contains the BUG_ON() rather than
> > VM_BUG_ON().  Looks like this patch can also fix that.
> >
> > When looking at that, I wonder whether we overlooked one more spot where we
> > mostly always use putback_movable_pages() for migrate failures, but didn't
> > in migrate_misplaced_folio().  I feel like it was overlooked but want to
> > check with all of you here, as I do think the folio can already be split
> > when reaching here too. So I wonder whether below would make sense as a fix
> > from that POV.
> >
> > ===8<===
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index e10d2445fbd8..20da2595527a 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2615,14 +2615,8 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
> >         nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
> >                                      NULL, node, MIGRATE_ASYNC,
> >                                      MR_NUMA_MISPLACED, &nr_succeeded);
> > -       if (nr_remaining) {
> > -               if (!list_empty(&migratepages)) {
> > -                       list_del(&folio->lru);
> > -                       node_stat_mod_folio(folio, NR_ISOLATED_ANON +
> > -                                       folio_is_file_lru(folio), -nr_pages);
> > -                       folio_putback_lru(folio);
> > -               }
> > -       }
> > +       if (nr_remaining && !list_empty(&migratepages))
> > +               putback_movable_pages(&migratepages);
> >         if (nr_succeeded) {
> >                 count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> >                 if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
> > ===8<===
> 
> If the original folio is large and split without migrating all subpages,
> not migrated sub pages will be left on migratepages list. list_del(&folio->lru)
> can remove the first subpage from a wrong list, if it is migrated, and loses
> the rest. It is not a problem before, since MR_NUMA_MISPLACED prevents the
> folio from being split.
> 
> The fix looks good to me.

Thanks, Zi.  Let me send a formal patch then.

-- 
Peter Xu


