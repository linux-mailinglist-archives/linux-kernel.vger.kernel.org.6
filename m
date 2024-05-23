Return-Path: <linux-kernel+bounces-187730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954838CD775
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D061C212D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117517736;
	Thu, 23 May 2024 15:42:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C4171A5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478958; cv=none; b=fwUM//FjU7J6FddA0hCqGxQIeCGZdFhhv/xS+hTdS94ndlEmkGHdoXXeemvJhE2tFI0hygjJV/gpgSQJZ23su/9RM36B9BSfQZI9/jNOmEnAtje3g8zStGKJG1yAtk60FZP8mRLznmRciHkk+4g18h1ZvsB8hlhnkgnJhUBgigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478958; c=relaxed/simple;
	bh=eB6wn8gjUExTYW1CT2bHPM8zXagHaLRwye+y24qJ/3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TapDDacTFsUsfB97gVbspBT8W1nVYiM8+rS/YZI8dWUlkaHTrZw9NDAeo3Cu+FL9qG0pfe0kHdUkNdtzzz2XK9vxGOI8DD4PJH4Jo20+CfCxZfsTNQPpV6UJP17ljqMRO/r8dZLxX/DfnX0+UOe1X6kbeTzqxA/msQnEOtL7oBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-GZZGOdmeO8u1khBLna4sLQ-1; Thu, 23 May 2024 11:42:34 -0400
X-MC-Unique: GZZGOdmeO8u1khBLna4sLQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-792ba913db8so4337185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478954; x=1717083754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DJUHcr5XyjHZyYVTluAq/1/9RFAEG9ctNajyWdm+BA=;
        b=jxQDlMkFatLZPiJvCLaKWHsQpXhhCePD7YNh76RlNsRzl7njxmYeTEI+tLqTmpTqsh
         +9Dpimu2oh9D0O117EWjZ1rLuvcNe7w7AzQszdYLc0EYKHyohwgJz0Zqjvmrhc5ZXJot
         83EgGLOgXjStu1zngiO1gZ33dncYQ0MJSDzl2Snazr9StCCWPVtyuUpdHgmNYgOJxHI6
         F+QP9boGzFELWZ4CImnh3I31DAAOgNnOX84pdS0jOHrvIx6mXCjQQFE6x8ocU7zZX+m8
         Cor42z3tkTHPY6qH25BPc2NFtH8eCeHWAIYEJRN0gtb4bAr7dn6Eq8TVO5RRshjUgILo
         5//A==
X-Forwarded-Encrypted: i=1; AJvYcCUCC+7mAIh3KArvnMt3mEiObIMTjg18eHg+rIDREXXbeHmw+MGIo3Z6at1PQIjeFVfxeaYgEiqW1mZazBcp8LUmN8XqtV2kMAjcGtyj
X-Gm-Message-State: AOJu0YyAR031bX2M1RJU4US0xZJ7f2gk0NGNstpqWonDFVVh9zGiTh01
	stoXaQ3UQrFi4pQP8uCiGhAvzEgfPMjhjFMcxe3XeZ+X0w+ew5CGzKes3Vow6RSBUBLOYI0U/k9
	19YrA5pPqS2csYOpLJqgEKllTi3qhqzpWG6Xz/VYJwwT/WvHUmWiTbe/VjWYqVw==
X-Received: by 2002:a05:622a:1a27:b0:437:ca6d:13f1 with SMTP id d75a77b69052e-43f9e0b65e2mr53726991cf.2.1716478953597;
        Thu, 23 May 2024 08:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH3UNfVh2eGLYI8tDApaDHMXs4vhJWuv4Rik2e/w+K9NC6Rn2hba4hdaQ6DHQhsIqIeNFhiA==
X-Received: by 2002:a05:622a:1a27:b0:437:ca6d:13f1 with SMTP id d75a77b69052e-43f9e0b65e2mr53726671cf.2.1716478952914;
        Thu, 23 May 2024 08:42:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0a4bdce8sm159763071cf.18.2024.05.23.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:42:32 -0700 (PDT)
Date: Thu, 23 May 2024 11:42:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>, Oscar Salvador <OSalvador@suse.com>,
	cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-36000: mm/hugetlb: fix missing hugetlb_lock for resv
 uncharge
Message-ID: <Zk9j5j-VSAOWrmg7@x1n>
References: <2024052023-CVE-2024-36000-cfc4@gregkh>
 <Zkto8rbtAUBql-78@tiehlicka>
 <Zkz4RRgfwUHPbQ5z@x1n>
 <Zk7ws6H0wwuiFAJW@tiehlicka>
 <Zk8bgS8IboS-7jQw@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zk8bgS8IboS-7jQw@localhost.localdomain>

On Thu, May 23, 2024 at 12:33:37PM +0200, Oscar Salvador wrote:
> On the theoretical part:
> 
> And we could have
> 
>      CPU0                                   CPU1
>  dequeue_huge_page_vma
>   dequeue_huge_page_node
>    move_page_to_active_list
>  release_lock
>                                            hugetlb_cgroup_pre_destroy
>                                             for_each_page_in_active_list
>                                             <-- pages empty cgroups are skipped -->
>                                              hugetlb_cgroup_move_parent
>                                              move_page_to_parent
>  hugetlb_cgroup_commit_charge <-- too late
>   page[2].lru.next = (void *)h_cg;

Would this happen with/without the patch?  IIUC the patch didn't change
this path yet on hugetlb_cgroup_commit_charge(), and AFAIU the release_lock
is always covering the commit charge, with/without my patch:

	spin_lock_irq(&hugetlb_lock);
	folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
        ...
	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
	if (deferred_reserve) {
		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
						  h_cg, folio);
	}
	spin_unlock_irq(&hugetlb_lock);

What the previous patch changed, IMHO, is when the rare race happened first
on reservation, and I think Mike used to describe that with a rich comment,
which can be against a concurrent hugetlb_reserve_pages():

	if (unlikely(map_chg > map_commit)) {
		/*
		 * The page was added to the reservation map between
		 * vma_needs_reservation and vma_commit_reservation.
		 * This indicates a race with hugetlb_reserve_pages.
		 * Adjust for the subpool count incremented above AND
		 * in hugetlb_reserve_pages for the same page.  Also,
		 * the reservation count added in hugetlb_reserve_pages
		 * no longer applies.
		 */
		long rsv_adjust;

		rsv_adjust = hugepage_subpool_put_pages(spool, 1);
		hugetlb_acct_memory(h, -rsv_adjust);
		if (deferred_reserve) {
			spin_lock_irq(&hugetlb_lock);
			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
					pages_per_huge_page(h), folio);
			spin_unlock_irq(&hugetlb_lock);
		}
	}

This should be after the point of hugetlb_cgroup_commit_charge(), and when
without the lock the problem is we can have concurrent accessor / updater
to the memcg.

However here after a 2nd look I don't even see at least the css offliner
would update the _hugetlb_cgroup_rsvd at all here.. so I'm not sure whether
a race could happen.  I meant, hugetlb_cgroup_move_parent() doesn't even
touch _hugetlb_cgroup_rsvd which is the object that can race.  It only
does:

	set_hugetlb_cgroup(folio, parent);

While in this case it's only about _hugetlb_cgroup.

It's pretty confusing to me here, doesn't it mean that when someone offline
a child_cg here we'll still leave the folio's _hugetlb_cgroup_rsvd pointing
to it, even if _hugetlb_cgroup starting to point to parent?...  I was
expecting hugetlb_cgroup_move_parent() also move the rsvd cg here too.

The other thing is, when hugetlb_cgroup_move_parent() does the cg movement,
does it need to css_put() ref on the child cg and css_tryget() on the
parent, just like what we did in __hugetlb_cgroup_charge_cgroup(), at least
for _hugetlb_cgroup?

I really don't know enough on these areas to tell, perhaps I missed
something.  But maybe any of you may have some idea..  In general, I think
besides LOCKDEP the lock is definitely needed to at least make sure things
like:

	__set_hugetlb_cgroup(folio, NULL, rsvd);
	page_counter_uncharge(),

To be an atomic op, otherwise two threads can see the old memcg
concurrently and maybe they'll uncharge counter twice.  But again currently
I don't know how that can be triggered if hugetlb_cgroup_move_parent() is
not even touching resv cg..

Thanks,

-- 
Peter Xu


