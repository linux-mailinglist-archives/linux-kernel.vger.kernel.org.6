Return-Path: <linux-kernel+bounces-259947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88893A053
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D301F229B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B2F152164;
	Tue, 23 Jul 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdo+68J3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2EE13D609;
	Tue, 23 Jul 2024 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735756; cv=none; b=jS/ev25pnXiY+cHWx3qDi5DZgTNy9kx1xidcK9ph6VgUnc6JwazS+KGdwvSUzZmHf3ww1ZuGOumWgv7WzPZ5vqaWIHfmbMdiyGjPED7nstGJYq6F2WeAkuMwcPrFdTtMSTAYnWPYI8F/bCnZjtTOaCuoZjyRY9xj4erCtcf+47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735756; c=relaxed/simple;
	bh=3TDEs0L944G71NhsWNCAYOPRVeh/85H8RUzJ/eqZfX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4LPpy3BIOLiJomydW+YqRDoiiXGyxlbFrHf8ClalFyeRnDJG864gPk6MI3UIDtIwKSm95bqkH521207Fs5Kr/m4pGvtcnzIxWsAG70G4wUnVHKZhP13E+Uq5C7sVA+scVTWHa9AArGQhYJw9udyIdGh3c+DrX2OEeRe8a4sVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdo+68J3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564EAC4AF09;
	Tue, 23 Jul 2024 11:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721735755;
	bh=3TDEs0L944G71NhsWNCAYOPRVeh/85H8RUzJ/eqZfX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vdo+68J3DaMhzDgACOCFCQYgb4dH4TUq4so9lG/BIYPd2R01tyAbu1E7uVlKhh+96
	 h0/vLHzc1rvGJY7EKrASOiEd+ZqDYrKB4nJDFNJj9KzmeENBhuwd2fSP6q71XcHXZb
	 HaN0+4d4ATov849Q2LE/bem+PSweTYDEU/ZqxjBeZKOPGh1BFXm95JmOXLl2Ixj3Bn
	 pk6Q1py99Ytakn/VO+bJVfj0a0vDYjMNEByg+RztYiHLiv5Nds7aF6aGD2S8gND2at
	 5ajVMYhWYi5L+n0z9suY8H5jvDbDnbdu7vmHZRlWBI8KNQgCrPb8YJeLLq1JaWBpVx
	 NUazqDlkFFu3A==
Date: Tue, 23 Jul 2024 13:55:48 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, maz@kernel.org, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Message-ID: <Zp-aRJAIVI9B2pKb@pollux>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-3-dakr@kernel.org>
 <Zp9gtelmvzN5tfpS@tiehlicka>
 <Zp-JCWCPbDLkzRVw@pollux>
 <Zp-MMcf1xUgqtFGS@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp-MMcf1xUgqtFGS@tiehlicka>

On Tue, Jul 23, 2024 at 12:55:45PM +0200, Michal Hocko wrote:
> On Tue 23-07-24 12:42:17, Danilo Krummrich wrote:
> > On Tue, Jul 23, 2024 at 09:50:13AM +0200, Michal Hocko wrote:
> > > On Mon 22-07-24 18:29:24, Danilo Krummrich wrote:
> [...]
> > > > Besides that, implementing kvrealloc() by making use of krealloc() and
> > > > vrealloc() provides oppertunities to grow (and shrink) allocations more
> > > > efficiently. For instance, vrealloc() can be optimized to allocate and
> > > > map additional pages to grow the allocation or unmap and free unused
> > > > pages to shrink the allocation.
> > > 
> > > This seems like a change that is independent on the above and should be
> > > a patch on its own.
> > 
> > The optimizations you mean? Yes, I intend to do this in a separate series. For
> > now, I put TODOs in vrealloc.
> 
> No I mean, that the change of the signature and semantic should be done along with
> update to callers and the new implementation of the function itself
> should be done in its own patch.

Sorry, it seems like you lost me a bit.

There is one patch that implements vrealloc() and one patch that does the change
of krealloc()'s signature, semantics and the corresponding update to the
callers.

Isn't that already what you ask for?

> 
> [...]
> > > > +void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
> > > >  {
> > > > -	void *newp;
> > > > +	void *n;
> > > > +
> > > 
> > > 	if (!size && p) {
> > > 		kvfree(p);
> > > 		return NULL;
> > > 	}
> > > 
> > > would make this code flow slightly easier to read because the freeing
> > > path would be shared for all compbinations IMO.
> > 
> > Personally, I like it without. For me the simplicity comes from directing things
> > to either krealloc() or vrealloc(). But I'd be open to change it however.
> 
> I would really prefer to have it there because it makes the follow up
> code easier.

I don't think it does (see below).

Either way, I got notified that Andrew applied the patches to mm-unstable. How
to proceed from there for further changes, if any?

> 
> > > > +	if (is_vmalloc_addr(p))
> > > > +		return vrealloc_noprof(p, size, flags);
> > > > +
> > > > +	n = krealloc_noprof(p, size, kmalloc_gfp_adjust(flags, size));
> > > > +	if (!n) {
> > > > +		/* We failed to krealloc(), fall back to kvmalloc(). */
> > > > +		n = kvmalloc_noprof(size, flags);
> > > 
> > > Why don't you simply use vrealloc_noprof here?
> > 
> > We could do that, but we'd also need to do the same checks kvmalloc() does, i.e.
> > 
> > 	/*
> > 	 * It doesn't really make sense to fallback to vmalloc for sub page
> > 	 * requests
> > 	 */
> > 	if (ret || size <= PAGE_SIZE)
> > 		return ret;
> 
> With the early !size && p check we wouldn't right?

I think that's unrelated. Your proposed early check checks for size == 0 to free
and return early. Whereas this check bails out if we fail kmalloc() with
size <= PAGE_SIZE, because a subsequent vmalloc() wouldn't make a lot of sense.

> 
> > 
> > 	/* non-sleeping allocations are not supported by vmalloc */
> > 	if (!gfpflags_allow_blocking(flags))
> > 		return NULL;
> > 
> > 	/* Don't even allow crazy sizes */
> > 	if (unlikely(size > INT_MAX)) {
> > 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> > 		return NULL;
> > 	}
> 
> I do not see why kvrealloc should have different set of constrains than
> vrealloc in this regards.

Those constraints come from kvmalloc() and hence should also apply for
kvrealloc(). What you seem to question here is whether they should be moved from
kvmalloc() to vmalloc() (and hence implicitly to vrealloc()).

As for the gfpflags_allow_blocking() check, it seems like this one was suggested
by you for kvmalloc() [1]. It seems that some people call kvmalloc() with
GPF_ATOMIC (which seems a bit weird at a first glance, but maybe makes sense in
some generic code paths). Hence, kvrealloc() must be able to handle it as well.

As for the size > INT_MAX check, please see the discussion in commit
0708a0afe291 ("mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls").

But again, whether those checks should be moved to vmalloc() is probably a
different topic.

[1] https://lore.kernel.org/all/20220926151650.15293-1-fw@strlen.de/T/#u

> 
> > Does the kmalloc() retry through kvmalloc() hurt us enough to do that? This
> > should only ever happen when we switch from a kmalloc buffer to a vmalloc
> > buffer, which we only do once, we never switch back.
> 
> This is effectively open coding part of vrealloc without any good
> reason. Please get rid of that.
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

