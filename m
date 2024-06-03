Return-Path: <linux-kernel+bounces-199721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0174C8D8B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC5628CB43
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA4413BC38;
	Mon,  3 Jun 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBCZZ1v+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72513B7AA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448812; cv=none; b=YJxMSs6Ik2ZGyzFmVVT+ZWO0x7lt86326eggwYPM+cZaGH3WM8ARAJUxB8F6dKlten4L0snqU2LqI9jTBxReTIa0TbmoZD+jGSbdE1DtIdevmlNre6SyyVW6aWQAlaYE155Ek2JQVrNNpAeuQ4SDQrsC2fXUiR3scOOobISpiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448812; c=relaxed/simple;
	bh=HFAYt0puR53CWQ6Pgn+7Lo+EGQ8Qqo707WzU7YvmSA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYYganQg13Z/VkAhuh9bquEGUKsU58AtAwARqR9jYVeULA6Htsvo7JaQcKZ8RW5cDGIjWKcTvzHvOd+WTRPCUKZmkVvqAee5fFZUGR05B366aqfds5u01RoTghS5lOVpuy0h6ABo8yr6gmewu6gCLixtOEcxghIuwmsnjLwnsbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBCZZ1v+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717448809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mpP1bV7IatGdUBDoGBtNKggDenXs8Jb/0Iy96M5NTo=;
	b=ZBCZZ1v+OG7THhmB3fgBLO4MEgObvF69jsJfl/DHkFnmqaZLiQnPbFWdiOmXJpqSPUlm2k
	8yJSh7G42Dr6uQWaC5Px7fxNaKRiOhwwn0G5G+gQvJFb1a1Ww+Pu6nKNTwxCHKLW5lWe6f
	Axt4rZ8SVaFOA8b+0gNDbAznGm6i288=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-eXUHnjq7PYCqcoDNIEFBxg-1; Mon, 03 Jun 2024 17:06:47 -0400
X-MC-Unique: eXUHnjq7PYCqcoDNIEFBxg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3d1ca308617so252679b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 14:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717448807; x=1718053607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mpP1bV7IatGdUBDoGBtNKggDenXs8Jb/0Iy96M5NTo=;
        b=MvVml09X1kCgCEHuieRw6b6F7tf1T6id+EdUK79f8FtbxbE1rr8abXFxEav4DFavPW
         G5yHR9U9BphZJ7QEGswuoULdwqA2mfBDMIqk78bk1Ae7PtgOEflQJga8xAbEPjxUBhLG
         nEBQfOCDZxxEcMzwBpP1m2i4gnCL8Jt6s0xHHVVk02qtD1isxIHM0lU6m/6yd5J4wxhs
         oim2jU5WNz4pg3dEe/+KiGSYXOg24k5JXlZfwkdPTn2rLkxmIPhdltFYwUsL7eSBChAn
         mV0xPZ3eBt4rYsxqERQduzYfAMMDhQ1Z5IxsKjdZK5J5bm3JidiMiu4Trf9jz0jrJXHp
         cpDA==
X-Forwarded-Encrypted: i=1; AJvYcCXwSKPY8+RRQZWz7nhrhPnlMM7EGv2y4DExx5s6GX98CH96EjySdBRg9gxRLPW24CCYZ6Y3iAoL027r8RNlIxYmajF56lEbFkq+fKTK
X-Gm-Message-State: AOJu0YyZiTMEqg1joFpdkm+97f8MTmKh4De1dyy2s1pekZBOxsbJhRsE
	Q43KZEBfPLQ4k3k2YuXAwRp6T4GFw/m3A5QxNfSMsnb7kAdGCf8LnoIUOQ/YqLyGiYpiCbMHtvn
	nQ7RSp2iJMPgPDsbiC6sC3QkUruEaIM5xH/aLk2byDjiqVtloFbYSUV0TZY8OOQ==
X-Received: by 2002:a05:6808:1512:b0:3d1:e2e4:5125 with SMTP id 5614622812f47-3d1e31e37dbmr12179447b6e.0.1717448806753;
        Mon, 03 Jun 2024 14:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8jB6meUwwpNA02EeXQJDBrJdfBASmS7Fy8XgHkACdk5SzpeO5m7B+8abySuaYnkZeZlgyWA==
X-Received: by 2002:a05:6808:1512:b0:3d1:e2e4:5125 with SMTP id 5614622812f47-3d1e31e37dbmr12179416b6e.0.1717448806034;
        Mon, 03 Jun 2024 14:06:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afb70d5741sm16591106d6.137.2024.06.03.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 14:06:45 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:06:43 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Yang Shi <shy828301@gmail.com>,
	kernel test robot <oliver.sang@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
Message-ID: <Zl4wY68a5QI8Ph6w@x1n>
References: <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com>
 <ZlpcRnuZUEYJJ0JA@x1n>
 <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
 <CAHbLzkoB+oFTxtVYpeXQvko2q9HUVzUYrr83S6M6PUmXDQpkag@mail.gmail.com>
 <0edfcfed-e8c4-4c46-bbce-528c07084792@redhat.com>
 <Zl3cakfiRsPQDb8q@x1n>
 <8da12503-839d-459f-a2fa-4abd6d21935d@redhat.com>
 <Zl4m-sAhZknHOHdb@x1n>
 <9d9a5730-161b-4a9d-a696-1cf6d0c5123c@redhat.com>
 <Zl4vlGJsbHiahYil@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zl4vlGJsbHiahYil@x1n>

[Copy Nicolas for real]

On Mon, Jun 03, 2024 at 05:03:16PM -0400, Peter Xu wrote:
> On Mon, Jun 03, 2024 at 10:37:55PM +0200, David Hildenbrand wrote:
> > > > try_get_folio() is all about grabbing a folio that might get freed
> > > > concurrently. That's why it calls folio_ref_try_add_rcu() and does
> > > > complicated stuff.
> > > 
> > > IMHO we can define it.. e.g. try_get_page() wasn't defined as so.
> > > 
> > > If we want to be crystal clear on that and if we think that's what we want,
> > > again I would suggest we rename it differently from try_get_page() to avoid
> > > future misuses, then add documents. We may want to also even assert the
> > 
> > Yes, absolutely.
> > 
> > > rcu/irq implications in try_get_folio() at entrance, then that'll be
> > > detected even without TINY_RCU config.
> > > 
> > > > 
> > > > On !CONFIG_TINY_RCU, it performs a folio_ref_add_unless(). That's
> > > > essentially a atomic_add_unless(), which in the worst case ends up being a
> > > > cmpxchg loop.
> > > > 
> > > > 
> > > > Stating that we should be using try_get_folio() in paths where we are sure
> > > > the folio refcount is not 0 is the same as using folio_try_get() where
> > > > folio_get() would be sufficient.
> > > > 
> > > > The VM_BUG_ON in folio_ref_try_add_rcu() really tells us here that we are
> > > > using a function in the wrong context, although in our case, it is safe to
> > > > use (there is now BUG). Which is true, because we know we have a folio
> > > > reference and can simply use a simple folio_ref_add().
> > > > 
> > > > Again, just like we have folio_get() and folio_try_get(), we should
> > > > distinguish in GUP whether we are adding more reference to a folio (and
> > > > effectively do what folio_get() would), or whether we are actually grabbing
> > > > a folio that could be freed concurrently (what folio_try_get() would do).
> > > 
> > > Yes we can.  Again, IMHO it's a matter of whether it will worth it.
> > > 
> > > Note that even with SMP and even if we keep this code, the
> > > atomic_add_unless only affects gup slow on THP only, and even with that
> > > overhead it is much faster than before when that path was introduced.. and
> > > per my previous experience we don't care too much there, really.
> > > 
> > > So it's literally only three paths that are relevant here on the "unless"
> > > overhead:
> > > 
> > >    - gup slow on THP (I just added it; used to be even slower..)
> > > 
> > >    - vivik's new path
> > > 
> > >    - hugepd (which may be gone for good in a few months..)
> > > IMHO none of them has perf concerns.  The real perf concern paths is
> > > gup-fast when pgtable entry existed, but that must use atomic_add_unless()
> > > anyway.  Even gup-slow !thp case won't regress as that uses try_get_page().
> > 
> > My point is primarily that we should be clear that the one thing is
> > GUP-fast, and the other is for GUP-slow.
> 
> Yes, understood.
> 
> > 
> > Sooner or later we'll see more code that uses try_grab_page() to be
> > converted to folios, and people might naturally use try_grab_folio(), just
> > like we did with Vivik's code.
> > 
> > And I don't think we'll want to make GUP-slow in general using
> > try_grab_folio() in the future.
> > 
> > So ...
> > 
> > > 
> > > So again, IMHO the easist way to fix this WARN is we drop the TINY_RCU bit,
> > > if nobody worries on UP perf.
> > > 
> > > I don't have a strong opinion, if any of us really worry about above three
> > > use cases on "unless" overhead, and think it worthwhile to add the code to
> > > support it, I won't object. But to me it's adding pain with no real benefit
> > > we could ever measure, and adding complexity to backport too since we'll
> > > need a fix for as old as 6.6.
> > 
> > ... for the sake of fixing this WARN, I don't primarily care. Adjusting the
> > TINY_RCU feels wrong because I suspect somebody had good reasons to do it
> > like that, and it actually reported something valuable (using the wrong
> > function for the job).
> > 
> > In any case, if we take the easy route to fix the WARN, I'll come back and
> > clean the functions here up properly.
> 
> Definitely, then there can also be some measurements which will be even
> better.  I mean, if the diff is minimal, we can be clearer on the path we
> choose; while if it shows improvements we have more solid results than
> predictions and discussions.
> 
> Yes I do worry about the UP change too, hence I sincerely was trying to
> collect some feedback.  My current guess is the UP was still important in
> 2008 when the code first wrote, and maybe it changed over the 16 years. I
> just notice Nicolas wrote it; I know he's still active so I've added him
> into the loop too.
> 
> Just for easier reference, the commit introduced the UP change is:
> 
> commit e286781d5f2e9c846e012a39653a166e9d31777d
> Author: Nicholas Piggin <npiggin@gmail.com>
> Date:   Fri Jul 25 19:45:30 2008 -0700
> 
>     mm: speculative page references
> 
> +static inline int page_cache_get_speculative(struct page *page)
> +{
> +       VM_BUG_ON(in_interrupt());
> +
> +#if !defined(CONFIG_SMP) && defined(CONFIG_CLASSIC_RCU)
> +# ifdef CONFIG_PREEMPT
> +       VM_BUG_ON(!in_atomic());
> +# endif
> +       /*
> +        * Preempt must be disabled here - we rely on rcu_read_lock doing
> +        * this for us.
> +        *
> +        * Pagecache won't be truncated from interrupt context, so if we have
> +        * found a page in the radix tree here, we have pinned its refcount by
> +        * disabling preempt, and hence no need for the "speculative get" that
> +        * SMP requires.
> +        */
> +       VM_BUG_ON(page_count(page) == 0);
> +       atomic_inc(&page->_count);
> +
> +#else
> +       if (unlikely(!get_page_unless_zero(page))) {
> +               /*
> +                * Either the page has been freed, or will be freed.
> +                * In either case, retry here and the caller should
> +                * do the right thing (see comments above).
> +                */
> +               return 0;
> +       }
> +#endif
> +       VM_BUG_ON(PageTail(page));
> +
> +       return 1;
> +}
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


