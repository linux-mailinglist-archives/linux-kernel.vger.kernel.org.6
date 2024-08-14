Return-Path: <linux-kernel+bounces-286557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175AB951C78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73042B20D72
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465B61B29D2;
	Wed, 14 Aug 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPESjOzH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DF1B29C5;
	Wed, 14 Aug 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644048; cv=none; b=XqyFtY1dA2VyvyAUtvud+kVyq0u/LhwuEWeKzRfla4PWdvP8Aqmx2HhqNTh5v1oJmyNnfBmLMf4gjSCOu9iz/Hv69qMBBYsWnrD9e2NfkGoPEnxfy46HgJ6K12MslxZfkeD0ws5xI4/a0pmnGEThMAAqhMRP0l4sfYzFLgqJhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644048; c=relaxed/simple;
	bh=wXCjzjCYhmAe3aX6R1ETmjfHVH5+3ZkjVKvHH6sIZ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkG9r0f9mhWM7DSC7i8tUP3lbuEI6otLBEKE2tyRL0l4hHW7eR3ODsg4SfcCKBgOAS3e6AAQWONYKfDD+Z2XrstwnJ0OHO2ZD9q/zKgqlbsZvfyHiMOkiiYIq1XuyX2cQxRKDIkleRI5EHLGq8hTGeaMLtPM9ctHNq1IELgy+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPESjOzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C78C116B1;
	Wed, 14 Aug 2024 14:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723644048;
	bh=wXCjzjCYhmAe3aX6R1ETmjfHVH5+3ZkjVKvHH6sIZ5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPESjOzHoHyNhkpIy3ROW/GUewe4r4iTT0BejXNBScOb6V9QGcyY3Yd3Xd0VqJO0O
	 7rT9jJDegjr+1rAmNxZ6DTrNrJmXugZBj6OAV1mgz5Qp7prNxC3TO54s5lTWxJdnpd
	 WZRQJSL5CNtfeISzx3SLD34C4ZUhxj3EsfdrRRDUrn8yLc54PXTtBdTPifA2YieH2L
	 L3ZuilZfvoAPyEle4gQ7PU01tIeGJaqjo8pB0aGnwqnwZ7y9WGmNo39AdmT6tn15ie
	 iNgol976SGbvuxtuMEtEXxn/K+CaQi/bDIN0P4PALLcMWcyZo8EMMEuoTY6OKzcr2W
	 knCkGtRwuP8Vg==
Date: Wed, 14 Aug 2024 16:00:40 +0200
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
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <Zry4iOGtR0nd6lNP@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-5-dakr@kernel.org>
 <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com>
 <Zryy04DvEsnxsRCj@pollux>
 <CAH5fLghsONUtxFPgD6vC139H-Uj5LDju7w5eS0JB+BnDMmfngw@mail.gmail.com>
 <Zry1qwJnPDUtp2Nw@cassiopeiae>
 <CAH5fLgjNfJyyZygWzeTyrNi8TQNAquufxFxDgJHzq6dan=b9BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjNfJyyZygWzeTyrNi8TQNAquufxFxDgJHzq6dan=b9BQ@mail.gmail.com>

On Wed, Aug 14, 2024 at 03:50:27PM +0200, Alice Ryhl wrote:
> On Wed, Aug 14, 2024 at 3:48 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Wed, Aug 14, 2024 at 03:44:56PM +0200, Alice Ryhl wrote:
> > > On Wed, Aug 14, 2024 at 3:36 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > >
> > > > On Wed, Aug 14, 2024 at 09:51:34AM +0200, Alice Ryhl wrote:
> > > > > On Mon, Aug 12, 2024 at 8:24 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > > >
> > > > > > Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
> > > > > > typically used for objects smaller than page size.
> > > > > >
> > > > > > All memory allocations made with `Kmalloc` end up in `krealloc()`.
> > > > > >
> > > > > > It serves as allocator for the subsequently introduced types `KBox` and
> > > > > > `KVec`.
> > > > > >
> > > > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > > > ---
> > > > > >  rust/helpers.c                 |  3 +-
> > > > > >  rust/kernel/alloc.rs           |  2 +-
> > > > > >  rust/kernel/alloc/allocator.rs | 63 +++++++++++++++++++++++++++++++++-
> > > > > >  3 files changed, 64 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/rust/helpers.c b/rust/helpers.c
> > > > > > index 92d3c03ae1bd..9f7275493365 100644
> > > > > > --- a/rust/helpers.c
> > > > > > +++ b/rust/helpers.c
> > > > > > @@ -193,8 +193,7 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> > > > > >
> > > > > > -void * __must_check __realloc_size(2)
> > > > > > -rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> > > > > > +void *rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> > > > > >  {
> > > > > >         return krealloc(objp, new_size, flags);
> > > > > >  }
> > > > >
> > > > > Why are the various annotations on this helper being removed?
> > > >
> > > > rust_helper_krealloc() is only called from Rust, hence neither __must_check nor
> > > > __realloc_size() should have any effect.
> > > >
> > > > I also do not apply them in subsequent commits for the vrealloc() and
> > > > kvrealloc() helpers for this reason and removed them here for consistency.
> > > >
> > > > > This deserves an explanation in the commit message.
> > > >
> > > > I can also add a separate commit for that.
> > >
> > > I think your change would be more obviously correct if you keep them.
> >
> > As in generally, or just for this patch?
> >
> > Generally, I don't think we should indicate compiler checks that actually are
> > never done.
> >
> > For this patch, yes, it's probably better to separate it.
> 
> In general. If you keep it, then I don't have to think about whether
> it affects bindgen's output. That's the main reason.

Well, it doesn't.

If we keep them, we'd consequently also need to add them for vrealloc() and
kvrealloc(). But again, they don't do anything for us, and hence are more
misleading than helpful IMO.

> 
> Alice
> 

