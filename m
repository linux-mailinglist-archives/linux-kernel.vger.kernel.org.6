Return-Path: <linux-kernel+bounces-294247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B9958B30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80080283EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E019DF85;
	Tue, 20 Aug 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWys7NSB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F2919597F;
	Tue, 20 Aug 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167593; cv=none; b=d3CQetGPg5wlRm65YwQXkQTziEyu1SR+n2c2ftSnU4urHsRIZswsMbSl8qGEhbVl6Aw96TfvFY7uvTRG3qihM5CjR/l+3joCpuZ2CHL4La6rxK7M9yy35YPVXSYiArcfZiFfEqpliWsJN0C1zjfxgtHYK1sGVG4SSD0+arixPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167593; c=relaxed/simple;
	bh=QNCaR6LGJ2I9wGtXHAIBeh+5vulqhXUYZz960F2jNZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtEvMGb+isPZvKvzHxnuuFMD17x0eL8SKZuQX/OJqXXLAwGeMVo7boO4XLKL0vtiK/WEMPy+r6rOFJv4xWDXmtmvpDxVEyIi2l7b+zS5oNs1X2mmc2RmGMUnDFVD9WGfM7nBUyyCzlM5MUZi2NG1NcNtvRysYrqSqQ1EGBMav/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWys7NSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550E5C4AF10;
	Tue, 20 Aug 2024 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724167590;
	bh=QNCaR6LGJ2I9wGtXHAIBeh+5vulqhXUYZz960F2jNZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWys7NSBNJSgrSjoMP+h/PT9z5JD7m5k5AyKawIb3CG3fmdbkP08c2+Aro5cSNGTO
	 UuRrwJ2+WAu8jA1LC75dwI+xrf09NxvDoXpVQ9K01EPywgR+frN3ItgC9CLhErttXh
	 D1RitefdcksiSXkjDE2XI2GsdaeyHA83/WyuT2X1uzKPdAoj+ptbecqPZIPSAfpRqF
	 YsUOlxVQhFn1YN+CERW+jLRKlS/u0Cwjl75Mh9WIZ/IF1vAiC9z8GLldgSLmZlAXcx
	 uOTMn8gPCNzSFNFlGIU5ujFDQspodaPc0Hdir3cNJJ0HuGC9U2Kc0/bmTyoOPg0nU/
	 pSXhQEOzh70WA==
Date: Tue, 20 Aug 2024 17:26:22 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <ZsS1njIt0Mp9pWok@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-10-dakr@kernel.org>
 <CAH5fLggUzUuiVuKOYmvo1fAcXGpsHUiRKx6DTg2cgkMe2YcF4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggUzUuiVuKOYmvo1fAcXGpsHUiRKx6DTg2cgkMe2YcF4g@mail.gmail.com>

On Tue, Aug 20, 2024 at 11:47:45AM +0200, Alice Ryhl wrote:
> On Fri, Aug 16, 2024 at 2:13 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > `Box` provides the simplest way to allocate memory for a generic type
> > with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> > `KVmalloc`.
> >
> > In contrast to Rust's `Box` type, the kernel `Box` type considers the
> > kernel's GFP flags for all appropriate functions, always reports
> > allocation failures through `Result<_, AllocError>` and remains
> > independent from unstable features.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Overall looks good to me, but I have a question:
> 
> > +impl<T: 'static, A> ForeignOwnable for Box<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    type Borrowed<'a> = &'a T;
> > +    type BorrowedMut<'a> = &'a mut T;
> > [..]
> > +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> &'a mut T {
> > +        // SAFETY: The safety requirements of this method ensure that the pointer is valid and that
> > +        // nothing else will access the value for the duration of 'a.
> > +        unsafe { &mut *ptr.cast_mut().cast() }
> > +    }
> 
> Where does this come from? It looks like you've based the series on
> top of [1], but I dropped that patch a long time ago, and I don't see
> it in rust-dev anymore.

I comes from me rebasing onto rust-dev. When Boqun asked me to resolve the merge
conflicts a few days ago, this patch was in rust-dev. I think it disappeared two
days ago or so.

@Bonqun: Need to me to rebase again?

- Danilo

> 
> Alice
> 
> [1]: https://lore.kernel.org/all/20230710074642.683831-1-aliceryhl@google.com/
> 

