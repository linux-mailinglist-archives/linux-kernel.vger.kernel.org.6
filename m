Return-Path: <linux-kernel+bounces-199786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF88FA5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB4E1C231F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7AF13CF8E;
	Mon,  3 Jun 2024 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+eJNPLo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4071386BB;
	Mon,  3 Jun 2024 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454624; cv=none; b=fxW+da5OVa8Zp/6wyaZh310m0ay78nolQxpdvKwl8G3l+p1bML8xaFm033N//BHbtf20bVR40V91Bn4UHCPatBfYeBSixckRvmOvF/Vp5aL9TFKghcb4HYqjG3kVRfDNzm+VdoPGHdhXY65iekv+hnUoHVrvxv37FANPkVxk4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454624; c=relaxed/simple;
	bh=1yw7gSqbFSXrARpAS72usJpHUWEMMH2uFpKbrQr3PJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpKWXD7s3euVkbOAYZBGFgICmjYytzDINhaDD3IJoJeMeInbOBKsGDK0YlzABP0pkqE3iJjUisvw3HRAciMaDbIL9lmMItRUJZrnGIvMfc2ktVaXz5LTc3J1dRv7cHRm6m2O5YQxeuNfVEAnDbBfx07d9pueq2IhbYgpki4dM8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+eJNPLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC41C2BD10;
	Mon,  3 Jun 2024 22:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454624;
	bh=1yw7gSqbFSXrARpAS72usJpHUWEMMH2uFpKbrQr3PJA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=q+eJNPLoIR7Uk/hOs9/yOZFaVZO3lc7QatTXswLXf8C/hdw7RSWU4J5bpBj8teu4m
	 ulMPnuPREUGbtkdDcQu3ve2Z3GCfbQs4qxOWJWc9rfhLai9R/kUztsnEmi7XimGU5d
	 /eL3EYpUXsFc8BXesjqGGXe42ZMGfdmmVwd6majcTc1rtN4Cfdq1ijIo0DQIfdEsVL
	 L28HG8ZxYV2GXHJ2N55NQsRs0+evGSyO8Gum1lmbssqWGi2FR0AdCRt+u4O3xRiggr
	 EUMu7FWmMkhnjQWEmoJnA+MJvYQQrmgkkisyyGTLjZOecQ8h2Fsj7hFhsip+PDxc+n
	 voL+70dpAvRHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E15ECCE0886; Mon,  3 Jun 2024 15:43:43 -0700 (PDT)
Date: Mon, 3 Jun 2024 15:43:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
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
Message-ID: <821cf1d6-92b9-4ac4-bacc-d8f2364ac14f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZlpcRnuZUEYJJ0JA@x1n>
 <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
 <CAHbLzkoB+oFTxtVYpeXQvko2q9HUVzUYrr83S6M6PUmXDQpkag@mail.gmail.com>
 <0edfcfed-e8c4-4c46-bbce-528c07084792@redhat.com>
 <Zl3cakfiRsPQDb8q@x1n>
 <8da12503-839d-459f-a2fa-4abd6d21935d@redhat.com>
 <Zl4m-sAhZknHOHdb@x1n>
 <9d9a5730-161b-4a9d-a696-1cf6d0c5123c@redhat.com>
 <Zl4vlGJsbHiahYil@x1n>
 <54ce029f-b16f-4607-bdf1-a1efe904029a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ce029f-b16f-4607-bdf1-a1efe904029a@redhat.com>

On Mon, Jun 03, 2024 at 11:05:44PM +0200, David Hildenbrand wrote:
> On 03.06.24 23:03, Peter Xu wrote:
> > On Mon, Jun 03, 2024 at 10:37:55PM +0200, David Hildenbrand wrote:
> > > > > try_get_folio() is all about grabbing a folio that might get freed
> > > > > concurrently. That's why it calls folio_ref_try_add_rcu() and does
> > > > > complicated stuff.
> > > > 
> > > > IMHO we can define it.. e.g. try_get_page() wasn't defined as so.
> > > > 
> > > > If we want to be crystal clear on that and if we think that's what we want,
> > > > again I would suggest we rename it differently from try_get_page() to avoid
> > > > future misuses, then add documents. We may want to also even assert the
> > > 
> > > Yes, absolutely.
> > > 
> > > > rcu/irq implications in try_get_folio() at entrance, then that'll be
> > > > detected even without TINY_RCU config.
> > > > 
> > > > > 
> > > > > On !CONFIG_TINY_RCU, it performs a folio_ref_add_unless(). That's
> > > > > essentially a atomic_add_unless(), which in the worst case ends up being a
> > > > > cmpxchg loop.
> > > > > 
> > > > > 
> > > > > Stating that we should be using try_get_folio() in paths where we are sure
> > > > > the folio refcount is not 0 is the same as using folio_try_get() where
> > > > > folio_get() would be sufficient.
> > > > > 
> > > > > The VM_BUG_ON in folio_ref_try_add_rcu() really tells us here that we are
> > > > > using a function in the wrong context, although in our case, it is safe to
> > > > > use (there is now BUG). Which is true, because we know we have a folio
> > > > > reference and can simply use a simple folio_ref_add().
> > > > > 
> > > > > Again, just like we have folio_get() and folio_try_get(), we should
> > > > > distinguish in GUP whether we are adding more reference to a folio (and
> > > > > effectively do what folio_get() would), or whether we are actually grabbing
> > > > > a folio that could be freed concurrently (what folio_try_get() would do).
> > > > 
> > > > Yes we can.  Again, IMHO it's a matter of whether it will worth it.
> > > > 
> > > > Note that even with SMP and even if we keep this code, the
> > > > atomic_add_unless only affects gup slow on THP only, and even with that
> > > > overhead it is much faster than before when that path was introduced.. and
> > > > per my previous experience we don't care too much there, really.
> > > > 
> > > > So it's literally only three paths that are relevant here on the "unless"
> > > > overhead:
> > > > 
> > > >     - gup slow on THP (I just added it; used to be even slower..)
> > > > 
> > > >     - vivik's new path
> > > > 
> > > >     - hugepd (which may be gone for good in a few months..)
> > > > IMHO none of them has perf concerns.  The real perf concern paths is
> > > > gup-fast when pgtable entry existed, but that must use atomic_add_unless()
> > > > anyway.  Even gup-slow !thp case won't regress as that uses try_get_page().
> > > 
> > > My point is primarily that we should be clear that the one thing is
> > > GUP-fast, and the other is for GUP-slow.
> > 
> > Yes, understood.
> > 
> > > 
> > > Sooner or later we'll see more code that uses try_grab_page() to be
> > > converted to folios, and people might naturally use try_grab_folio(), just
> > > like we did with Vivik's code.
> > > 
> > > And I don't think we'll want to make GUP-slow in general using
> > > try_grab_folio() in the future.
> > > 
> > > So ...
> > > 
> > > > 
> > > > So again, IMHO the easist way to fix this WARN is we drop the TINY_RCU bit,
> > > > if nobody worries on UP perf.
> > > > 
> > > > I don't have a strong opinion, if any of us really worry about above three
> > > > use cases on "unless" overhead, and think it worthwhile to add the code to
> > > > support it, I won't object. But to me it's adding pain with no real benefit
> > > > we could ever measure, and adding complexity to backport too since we'll
> > > > need a fix for as old as 6.6.
> > > 
> > > ... for the sake of fixing this WARN, I don't primarily care. Adjusting the
> > > TINY_RCU feels wrong because I suspect somebody had good reasons to do it
> > > like that, and it actually reported something valuable (using the wrong
> > > function for the job).
> > > 
> > > In any case, if we take the easy route to fix the WARN, I'll come back and
> > > clean the functions here up properly.
> > 
> > Definitely, then there can also be some measurements which will be even
> > better.  I mean, if the diff is minimal, we can be clearer on the path we
> > choose; while if it shows improvements we have more solid results than
> > predictions and discussions.
> > 
> > Yes I do worry about the UP change too, hence I sincerely was trying to
> > collect some feedback.  My current guess is the UP was still important in
> > 2008 when the code first wrote, and maybe it changed over the 16 years. I
> > just notice Nicolas wrote it; I know he's still active so I've added him
> > into the loop too.
> > 
> > Just for easier reference, the commit introduced the UP change is:
> > 
> > commit e286781d5f2e9c846e012a39653a166e9d31777d
> > Author: Nicholas Piggin <npiggin@gmail.com>
> > Date:   Fri Jul 25 19:45:30 2008 -0700
> > 
> >      mm: speculative page references
> > 
> > +static inline int page_cache_get_speculative(struct page *page)
> > +{
> > +       VM_BUG_ON(in_interrupt());
> > +
> > +#if !defined(CONFIG_SMP) && defined(CONFIG_CLASSIC_RCU)
> > +# ifdef CONFIG_PREEMPT
> > +       VM_BUG_ON(!in_atomic());
> > +# endif
> > +       /*
> > +        * Preempt must be disabled here - we rely on rcu_read_lock doing
> > +        * this for us.
> > +        *
> > +        * Pagecache won't be truncated from interrupt context, so if we have
> > +        * found a page in the radix tree here, we have pinned its refcount by
> > +        * disabling preempt, and hence no need for the "speculative get" that
> > +        * SMP requires.
> > +        */
> > +       VM_BUG_ON(page_count(page) == 0);
> > +       atomic_inc(&page->_count);
> > +
> > +#else
> > +       if (unlikely(!get_page_unless_zero(page))) {
> > +               /*
> > +                * Either the page has been freed, or will be freed.
> > +                * In either case, retry here and the caller should
> > +                * do the right thing (see comments above).
> > +                */
> > +               return 0;
> > +       }
> > +#endif
> > +       VM_BUG_ON(PageTail(page));
> > +
> > +       return 1;
> > +}
> > 
> > Thanks,
> > 
> 
> I chased it further to:
> 
> commit 8375ad98cc1defc36adf4a77d9ea1e71db51a371
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon Apr 29 15:06:13 2013 -0700
> 
>     vm: adjust ifdef for TINY_RCU
>     There is an ifdef in page_cache_get_speculative() that checks for !SMP
>     and TREE_RCU, which has been an impossible combination since the advent
>     of TINY_RCU.  The ifdef enables a fastpath that is valid when preemption
>     is disabled by rcu_read_lock() in UP systems, which is the case when
>     TINY_RCU is enabled.  This commit therefore adjusts the ifdef to
>     generate the fastpath when TINY_RCU is enabled.
> 
> 
> Where Paul explicitly restored that fastpath for TINY_RCU instead of removing that code.
> 
> So maybe Paul can comment if that is still worth having. CCing him.

It is currently an atomic operation either way, though the folio_ref_add()
avoids full ordering, but that is immaterial on x86.  Some say that it is
in the noise on server-class ARMv8 as well, though they have also said
a great many things in the past.  But if that is true, the big benefit
of the TINY_RCU check is that folio_ref_try_add_rcu() is guaranted not
to fail in that case (single CPU with preemption disabled).  Except that
everyone has to check the return value anyway, right?

So the usual advice, unsatisfying though it might be, is to remove that
#ifdef and see if anyone notices.

After all, both 2013 and 2008 were quite some time ago.  ;-)

							Thanx, Paul

