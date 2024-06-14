Return-Path: <linux-kernel+bounces-214246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA39081D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D4C1F24994
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CA145A00;
	Fri, 14 Jun 2024 02:45:33 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E3E374FE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333132; cv=none; b=Q17+FlDbZpvyQeFYxEPuC1lynngB5eU6VUzKJxp5YVy8Z5HZ1eSbSLGVwF5HhKP2jL92XVZXDjltPekdGs7NDzR4LP9zWfWVJ2Au/4pBckJJug0/P9OfvsdkFpdFuVOZEtb+J0U613jlc4K4Ma59sZed2bJ0ryO7Z/asGHSk4ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333132; c=relaxed/simple;
	bh=Q6drMV6EJgFGpI9rIuu/40gnRhRRxuf/lwLuY6sM5tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSPXqDCdgUPH9kmpYKUA6tQ+nWZaJMrStFx79E+h94v7RNQY8R+kijgn7sWzLoI0rI8nXhq19pk8eBYFJpl6USnugqN3/TTZ5jUU9JtAwqx/KRSOiOdrtUYwv1mQH2gwEcnSBIUTHPwV3wOhJCz59HYrjLMLgSAZKipRNexTZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-18-666baec31553
Date: Fri, 14 Jun 2024 11:45:18 +0900
From: Byungchul Park <byungchul@sk.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Byungchul Park <lkml.byungchul.park@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
Message-ID: <20240614024518.GB47085@system.software.com>
References: <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
 <35866f91-7d96-462a-aa0a-ac8a6b8cbcf8@redhat.com>
 <196481bb-b86d-4959-b69b-21fda4daae77@intel.com>
 <Zl320dWODSYw-PgV@casper.infradead.org>
 <20240604003448.GA26609@system.software.com>
 <Zmb-ZZHbeNNjcs68@tiehlicka>
 <20240611005523.GA4384@system.software.com>
 <Zmg7GXK1SGFJNdge@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmg7GXK1SGFJNdge@tiehlicka>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsXC9ZZnke7hddlpBtOWWFnMWb+GzeLzhn9s
	Fp9ePmC0eLGhndHi6/pfzBZPP/WxWFzeNYfN4t6a/6wWRzs3MVuc37WW1WLH0n1MFvf7HCwu
	HVjAZHG89wCTxfx7n9ksNm+aymxxfMpURovfP4C6Ts6azOIg7PG9tY/FY+esu+weCzaVemxe
	oeWxeM9LJo9NqzrZPDZ9msTu8e7cOXaPEzN+s3jMOxno8X7fVTaP9Vuusnhs/WXn0Tj1GpvH
	501yAfxRXDYpqTmZZalF+nYJXBnTj7xnLjilUrH4zEWWBsY7kl2MnBwSAiYSc3r62GDsDx2d
	LCA2i4CqRNv7CWBxNgF1iRs3fjKD2CICShJdm3cCxbk4mAX+M0v8mHcMrEhYoEDi1YRJ7CA2
	r4CFxPXW9WCDhAROM0vcf2oIEReUODnzCVicWUBL4sa/l0xdjBxAtrTE8n8cIGFOAU2Jy58/
	g40RFVCWOLDtOBPILgmBY+wS805PYoY4VFLi4IobLBMYBWYhGTsLydhZCGMXMDKvYhTKzCvL
	TczMMdHLqMzLrNBLzs/dxAiM12W1f6J3MH66EHyIUYCDUYmH1+NZVpoQa2JZcWXuIUYJDmYl
	Ed5ZC4FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGDec
	UHJfuOXayzvaD5SnxS4+YlmesyF1u/nr2EqxyG/LwlbqfOgO2rORg7NBd+nKn7J3LuVqqTXs
	+N+6XiWKhefaK1/Ri4fmOPc9ft0f8qz0i5qdEPu7+a561wz+P9x0aSlr+s8mqTz5mUx7E83M
	nre/3OOocl5A5PDKg9+mXJr1JX7plNWfHvEpsRRnJBpqMRcVJwIAdm4/+9MCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsXC5WfdrHt4XXaawY8ZMhZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFofnnmS1uLxrDpvFvTX/WS2Odm5itji/ay2rxY6l+5gs
	7vc5WFw6sIDJ4njvASaL+fc+s1ls3jSV2eL4lKmMFr9/AHWdnDWZxUHE43trH4vHzll32T0W
	bCr12LxCy2PxnpdMHptWdbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8li/5SqL
	x9Zfdh6NU6+xeXzeJBcgEMVlk5Kak1mWWqRvl8CVMf3Ie+aCUyoVi89cZGlgvCPZxcjJISFg
	IvGho5MFxGYRUJVoez+BDcRmE1CXuHHjJzOILSKgJNG1eSdQnIuDWeA/s8SPecfAioQFCiRe
	TZjEDmLzClhIXG9dDzZISOA0s8T9p4YQcUGJkzOfgMWZBbQkbvx7ydTFyAFkS0ss/8cBEuYU
	0JS4/Pkz2BhRAWWJA9uOM01g5J2FpHsWku5ZCN0LGJlXMYpk5pXlJmbmmOoVZ2dU5mVW6CXn
	525iBEbfsto/E3cwfrnsfohRgINRiYfX41lWmhBrYllxZe4hRgkOZiUR3lkLgUK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2M+htj9DeExnqxHKh+sc5a
	53exN8deDsc1V+uYjy8Vj5Baz3GLNfj0s+0HV994E2nceJPPKlrtY9n9ZbW3RDNcQidVTLOf
	+bub71SHj9PPyzJ9/2/vPfAoXeHx4gQnr51vJzdt1/65LWb77sIFhbr7rpdzJC55cq5CWmHS
	3MU8O83qNB9zT9jfrcRSnJFoqMVcVJwIAB6WDw66AgAA
X-CFilter-Loop: Reflected

On Tue, Jun 11, 2024 at 01:55:05PM +0200, Michal Hocko wrote:
> On Tue 11-06-24 09:55:23, Byungchul Park wrote:
> > On Mon, Jun 10, 2024 at 03:23:49PM +0200, Michal Hocko wrote:
> > > On Tue 04-06-24 09:34:48, Byungchul Park wrote:
> > > > On Mon, Jun 03, 2024 at 06:01:05PM +0100, Matthew Wilcox wrote:
> > > > > On Mon, Jun 03, 2024 at 09:37:46AM -0700, Dave Hansen wrote:
> > > > > > Yeah, we'd need some equivalent of a PTE marker, but for the page cache.
> > > > > >  Presumably some xa_value() that means a reader has to go do a
> > > > > > luf_flush() before going any farther.
> > > > > 
> > > > > I can allocate one for that.  We've got something like 1000 currently
> > > > > unused values which can't be mistaken for anything else.
> > > > > 
> > > > > > That would actually have a chance at fixing two issues:  One where a new
> > > > > > page cache insertion is attempted.  The other where someone goes to look
> > > > > > in the page cache and takes some action _because_ it is empty (I think
> > > > > > NFS is doing some of this for file locks).
> > > > > > 
> > > > > > LUF is also pretty fundamentally built on the idea that files can't
> > > > > > change without LUF being aware.  That model seems to work decently for
> > > > > > normal old filesystems on normal old local block devices.  I'm worried
> > > > > > about NFS, and I don't know how seriously folks take FUSE, but it
> > > > > > obviously can't work well for FUSE.
> > > > > 
> > > > > I'm more concerned with:
> > > > > 
> > > > >  - page goes back to buddy
> > > > >  - page is allocated to slab
> > > > 
> > > > At this point, tlb flush needed will be performed in prep_new_page().
> > > 
> > > But that does mean that an unaware caller would get an additional
> > > overhead of the flushing, right? I think it would be just a matter of
> > 
> > pcp for locality is already a better source of side channel attack.  FYI,
> > tlb flush gets barely performed only if pending tlb flush exists.
> 
> Right but rare and hard to predict latencies are much worse than
> consistent once.

No doubt it'd be the best if we keep things consistent as long as
possible.  How consistent *we require* it would be, matters.  Lemme know
criteria for that if any.  I will check it.

> > > time before somebody can turn that into a side channel attack, not to
> > > mention unexpected latencies introduced.
> > 
> > Nope.  The pending tlb flush performed in prep_new_page() is the one
> > that would've done already with the vanilla kernel.  It's not additional
> > tlb flushes but it's subset of all the skipped ones.
> 
> But those skipped once could have happened in a completely different
> context (e.g. a different process or even a diffrent security domain),
> right?

Right.

> > It's worth noting all the existing mm reclaim mechaisms have already
> > introduced worse unexpected latencies.
> 
> Right, but a reclaim, especially direct reclaim, are expected to be
> slow. It is much different to see spike latencies on system with a lot
> of memory.

Talking about rt system?  In rt system, the system should prevent its
memory from being reclaimed, IMHO, since these will add unexpected
latencies.

Reclaim and migrations alreay introduce unexpected latencies themselves.
Why does only latencies by luf matter?  I'm asking to understand what
you mean, in order to fix luf if any.

   vanilla
   -------
   alloc_page() {
      ...
      preempted by kswapd or direct reclaim {
         ...
         reclaim
            unmap file pages
   	 tlb shootdown
         ...
         migration
            unmap pages
   	 tlb shootdown
         ...
      }
      ...
      interrupted by tlb shootdown from other CPUs {
         ...
      }
      ...
      prep_new_page() {
         ...
      }
   }
   
   with luf
   --------
   alloc_page() {
      ...
      preempted by kswapd or direct reclaim {
         ...
         reclaim
            unmap file pages
   	 (skip tlb shootdown)
         ...
         migration
            unmap pages
   	 (skip tlb shootdown)
         ...
      }
      ...
      interrupted by tlb shootdown from other CPUs {
         ...
      }
      ...
      prep_new_page() {
         ...
         /*
          * This can be tlb shootdown skipped in this context or others.
          */
         tlb shootdown with much smaller cpumask
         ...
      }
   }

I really want to understand why only latentcies introduced in luf
matter?  Why does not latencies already introduced in vanilla matter?

	Byungchul

> -- 
> Michal Hocko
> SUSE Labs

