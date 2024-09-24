Return-Path: <linux-kernel+bounces-337199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392AB9846D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0001C22982
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB81A76CC;
	Tue, 24 Sep 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2+rlZZe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786CD1A3A9C;
	Tue, 24 Sep 2024 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184870; cv=none; b=kWcY4XN9PZ4+JgabcBgrlxRFHqpmj+M9CK6d95WHXk6XSaQLkDuqGpHdOD88Hv8HLJULrF3sqAVc9mfXPkKV/Gx+JmpbKfavowFuiSVuuI7enpIC20Dsd/10cG/rRsaKG7TISXapa8A5QcLftx9Uk6qveaJoElmTnbpqj9XFOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184870; c=relaxed/simple;
	bh=ZiYYKfmJ5vH00JsyhtVmMRwhMywgsH7w/7D/dUatEl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpNVa8/nRNzi+SFjq9zi4qEOKsEizi1kyXulD5IgxRwLa8m5EMInzw9Lbgxer5WD3iBMIazHMJ8jC7zVJA1jExuktMPdqG7WIBA4JiZ/SRb1NWUZDEK+q9TXpMJ5Bg5vQiZbB/WY6UgGL0GgOgYcL95/MD18fJ0pOo64kxrM1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2+rlZZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE7BC4CEC4;
	Tue, 24 Sep 2024 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727184870;
	bh=ZiYYKfmJ5vH00JsyhtVmMRwhMywgsH7w/7D/dUatEl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2+rlZZe1k6PohuN1dUgAaiPsxtEy2akMWJwENm04rWB1sHT4VomnkbhDfZanAmhV
	 WagEIZR+iUqLksIG2sB7tsvrbhgKPQtql1fRZDSxYsV9BCk6SWph6A727ZhYC5XPp9
	 c2hgSPCxr95ElgUSdqxBcqSVqR9FBshu2SKw/TGLxEazAx/gtGsWi85cZ2aRM/s870
	 v9CLO4fftVHyfnXF9343X9CT9sKbsRisHUwcvRjh8LbJVXO9lE3FnPShEgHsMSt/Ms
	 jMM4NGHQ+D3WomuVtnWGN3JJux765ziFtgBmHQJ4Jdxp0JCspIqv1itARF5KTFpWJ3
	 ZF//pawXCfxDA==
Date: Tue, 24 Sep 2024 15:34:22 +0200
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
Message-ID: <ZvK_3kE7m56J9NPU@pollux>
References: <20240911225449.152928-2-dakr@kernel.org>
 <20240921153315.70860-1-dakr@kernel.org>
 <CAH5fLgievsJOe7QET+Wh2c0upygv-nhSnOuTN8K_QkruLwOPgA@mail.gmail.com>
 <20240923171315.64327fe7.gary@garyguo.net>
 <ZvK_Q0jsZ0cwnhQK@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvK_Q0jsZ0cwnhQK@pollux>

On Tue, Sep 24, 2024 at 03:31:55PM +0200, Danilo Krummrich wrote:
> On Mon, Sep 23, 2024 at 05:13:15PM +0100, Gary Guo wrote:
> > On Mon, 23 Sep 2024 15:56:28 +0200
> > Alice Ryhl <aliceryhl@google.com> wrote:
> > 
> > > On Sat, Sep 21, 2024 at 5:33 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > @@ -84,11 +92,18 @@ unsafe fn call(
> > > >          &self,
> > > >          ptr: Option<NonNull<u8>>,
> > > >          layout: Layout,
> > > > +        old_layout: Layout,
> > > >          flags: Flags,
> > > >      ) -> Result<NonNull<[u8]>, AllocError> {
> > > >          let size = aligned_size(layout);
> > > >          let ptr = match ptr {
> > > > -            Some(ptr) => ptr.as_ptr(),
> > > > +            Some(ptr) => {
> > > > +                if old_layout.size() == 0 {
> > > > +                    ptr::null()
> > > > +                } else {
> > > > +                    ptr.as_ptr()
> > > > +                }
> > > > +            }  
> > > 
> > > This is making Allocator work with zero-sized types, which deviates
> > > from std. We should not do that without a reason. What is the reason?
> > > 
> > > Alice
> > 
> > As Benno said, this makes the API closer to Rust `allocator_api`
> > Allocator trait as opposed to deviation.
> > 
> > There's one benefit of doing this (discussed with Danilo off-list),
> > which is it removes ZST special casing from caller. This RFC patch
> > simplifies `Box` handling, and if we add this line to the safety doc
> > 
> > 	`ptr` does not need to be a pointer returned by this
> > 	allocator if the layout is zero-sized.
> > 
> > then the `Vec` can also be simplified, removing all logics handling ZST
> > specially, except for `Vec::new()` which it forges a well-aligned
> > dangling pointer from nowhere.
> 
> Partially, we still need the additional `Layout` for `Allocator::free`, which
> in `Vec::drop` and `IntoIter::drop` looks like this:
> 
> `let layout = Layout::array::<T>(self.cap).unwrap();`

Adding in the diff:

-        // If `cap == 0` we never allocated any memory in the first place.
-        if self.cap != 0 {
-            // SAFETY: `self.ptr` was previously allocated with `A`.
-            unsafe { A::free(self.ptr.cast()) };
-        }
+        // This can never fail; since this `Layout` is equivalent to the one of the original
+        // allocation.
+        let layout = Layout::array::<T>(self.cap).unwrap();
+
+        // SAFETY: `self.ptr` was previously allocated with `A`.
+        unsafe { A::free(self.ptr.cast(), layout) };

> 
> I really dislike that this can potentially transform into `BUG()`, but that's
> probably unrelated to this patch series.
> 
> > 
> > Best,
> > Gary
> > 

