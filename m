Return-Path: <linux-kernel+bounces-337195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A089846C4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346201C227FA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FB91A76B7;
	Tue, 24 Sep 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GihAZWbb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BFC86277;
	Tue, 24 Sep 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184715; cv=none; b=dkTPosVPxhhPH0fryq2SJYr0gDTHZCy2xsCYLTpMeJH10ynOU33X8zzC+5tbnbk35/WlUqB0U2cXAnh4WGYmH/P+ogb1B2IQRYborkeZsUE3i7Mtk3D4Th55liirSMdFzlqwZbj0gpFIUeVFiiYuvul4aVqfWiTtbNO4nPN65hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184715; c=relaxed/simple;
	bh=eBMS6DQpg+PlEzog/5kTV0gxtOL2/C511E/tO4rwAO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qs5rh1+6FA8pNWbC4gGhXwR1UWmMBafQN4b+ncle9Y3C2Mi/MHLYhUJNMhWePQfAjfd7mCKeUXosTtj48xIkXcu/EW/w5SN5vMLpgWDw9/1qXXUeMzuxdUH/kSFB/rWJv6NMnulaiMF+QHXQmi/JncYRed7mdzbGV1bZbIKkwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GihAZWbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF08C4CEC4;
	Tue, 24 Sep 2024 13:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727184714;
	bh=eBMS6DQpg+PlEzog/5kTV0gxtOL2/C511E/tO4rwAO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GihAZWbbJipVAD+i/w4emBsVDe0mvCMTwIU86Gke8HcIua2sz3THdEHa71P6aTNkD
	 2LmtUaYC0Ba5fUtTchBO53dhdwHgFvKiS9VDJDn0xs53utt/8DMth9xPhjNzkOxK5A
	 6k+5/v3hMooERNVQIFiUzuUfY9S6vIvUrwwjVH/pLJBtvI/1o4AhTqOfUwSKvPpaQI
	 1Vf6GcJEc6DJ1d1cFxS0lRWkwqdph2LbwbPoJzhdH07+FF+ueqFbVwDmWTOofN47Np
	 618eQBbus35tAfTw4stIQjzrbqOCAVgMr1T5RAr99gjxv51VcS+vLsRemAMFYxAF7B
	 fZ6YDO6oWjONQ==
Date: Tue, 24 Sep 2024 15:31:47 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] rust: alloc: pass `old_layout` to `Allocator`
Message-ID: <ZvK_Q0jsZ0cwnhQK@pollux>
References: <20240911225449.152928-2-dakr@kernel.org>
 <20240921153315.70860-1-dakr@kernel.org>
 <CAH5fLgievsJOe7QET+Wh2c0upygv-nhSnOuTN8K_QkruLwOPgA@mail.gmail.com>
 <20240923171315.64327fe7.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923171315.64327fe7.gary@garyguo.net>

On Mon, Sep 23, 2024 at 05:13:15PM +0100, Gary Guo wrote:
> On Mon, 23 Sep 2024 15:56:28 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > On Sat, Sep 21, 2024 at 5:33 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > @@ -84,11 +92,18 @@ unsafe fn call(
> > >          &self,
> > >          ptr: Option<NonNull<u8>>,
> > >          layout: Layout,
> > > +        old_layout: Layout,
> > >          flags: Flags,
> > >      ) -> Result<NonNull<[u8]>, AllocError> {
> > >          let size = aligned_size(layout);
> > >          let ptr = match ptr {
> > > -            Some(ptr) => ptr.as_ptr(),
> > > +            Some(ptr) => {
> > > +                if old_layout.size() == 0 {
> > > +                    ptr::null()
> > > +                } else {
> > > +                    ptr.as_ptr()
> > > +                }
> > > +            }  
> > 
> > This is making Allocator work with zero-sized types, which deviates
> > from std. We should not do that without a reason. What is the reason?
> > 
> > Alice
> 
> As Benno said, this makes the API closer to Rust `allocator_api`
> Allocator trait as opposed to deviation.
> 
> There's one benefit of doing this (discussed with Danilo off-list),
> which is it removes ZST special casing from caller. This RFC patch
> simplifies `Box` handling, and if we add this line to the safety doc
> 
> 	`ptr` does not need to be a pointer returned by this
> 	allocator if the layout is zero-sized.
> 
> then the `Vec` can also be simplified, removing all logics handling ZST
> specially, except for `Vec::new()` which it forges a well-aligned
> dangling pointer from nowhere.

Partially, we still need the additional `Layout` for `Allocator::free`, which
in `Vec::drop` and `IntoIter::drop` looks like this:

`let layout = Layout::array::<T>(self.cap).unwrap();`

I really dislike that this can potentially transform into `BUG()`, but that's
probably unrelated to this patch series.

> 
> Best,
> Gary
> 

