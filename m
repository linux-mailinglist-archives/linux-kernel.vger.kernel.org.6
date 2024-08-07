Return-Path: <linux-kernel+bounces-277716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575594A537
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FE528304C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464F1D4152;
	Wed,  7 Aug 2024 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt1qAxU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0320F1C7B92;
	Wed,  7 Aug 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025643; cv=none; b=fK3Va8EaB73Lmy2cy3KTRW3Ww1wswqhYBslRGp2jYSWuyvvaz5ZnFa00Ir3fOVxLnOUcczqz7EN6gRkLUxTKnhud8MVX4vZj2Z4BJZPhl/RxjhQhdo69tVu0Cql0FpnM053sWMiKSnF+hIqXZpI8JqobCS9bYScMXZQEN/30CM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025643; c=relaxed/simple;
	bh=cXFScknOCcXsw5mApjuf4qGj6WwS+8PmUpSIsPwrrSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfaWjXTnfmsgvxegDFFbuJuLztaGjkyN50z1hQUncpl3Owz5kz0CoYWUJu3gF9pOwWXovIsPQM9InnWJsdacLUIHCDohEZCQTPj1fqGzhI2yglAHZyz1mzjdBDuRRno+ovIGRXqFlj7L6PXm1mbp30zk7d1wIsL8N7E/kMn5s5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt1qAxU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF8EC32782;
	Wed,  7 Aug 2024 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723025642;
	bh=cXFScknOCcXsw5mApjuf4qGj6WwS+8PmUpSIsPwrrSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qt1qAxU/np729XtXNzr44kscc53wJNUCcU3++RzVyVEeBKAF3t2UCEQwV2aNP69+n
	 LeODvE0EDy2vV63n5wx2XGwcGK2L5o6Mww2vih+J5lvy1fAh1vqhsIplkkZJ4uWg/0
	 5pJUoMZXu0lkyKF3AwFAUeWqDfUxSjCcham2wvKoitSb28GHF1owMMLNYkIU3TB5JL
	 GjrjSHU1XEVH/Dy5JRa3xOcCQg1xeJ0A1T12xSGH62YQGh4Aht+7nl0TCePdX64ilW
	 YaIbTvZ/mzcaKLqYjRGevWxIcXngVQy8tezWScfENM5JUMU0STh8gzIEdn4Wv6OVqr
	 5lYxYj37LhJrw==
Date: Wed, 7 Aug 2024 12:13:55 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 08/28] rust: types: implement `Unique<T>`
Message-ID: <ZrNI4_z4v4pKroaR@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-9-dakr@kernel.org>
 <ff0826af-9430-4653-abe8-25fb80cd0e97@proton.me>
 <ZrKt7K68W1Jh6nhr@pollux>
 <f3457432-dc83-4a19-b75a-88b914430733@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3457432-dc83-4a19-b75a-88b914430733@proton.me>

On Wed, Aug 07, 2024 at 07:27:43AM +0000, Benno Lossin wrote:
> On 07.08.24 01:12, Danilo Krummrich wrote:
> > On Tue, Aug 06, 2024 at 05:22:21PM +0000, Benno Lossin wrote:
> >> On 05.08.24 17:19, Danilo Krummrich wrote:
> >>> +impl<T: Sized> Unique<T> {
> >>> +    /// Creates a new `Unique` that is dangling, but well-aligned.
> >>> +    ///
> >>> +    /// This is useful for initializing types which lazily allocate, like
> >>> +    /// `Vec::new` does.
> >>> +    ///
> >>> +    /// Note that the pointer value may potentially represent a valid pointer to
> >>> +    /// a `T`, which means this must not be used as a "not yet initialized"
> >>> +    /// sentinel value. Types that lazily allocate must track initialization by
> >>> +    /// some other means.
> >>> +    #[must_use]
> >>> +    #[inline]
> >>> +    pub const fn dangling() -> Self {
> >>> +        Unique {
> >>> +            pointer: NonNull::dangling(),
> >>> +            _marker: PhantomData,
> >>> +        }
> >>> +    }
> >>
> >> I think I already asked this, but the code until this point is copied
> >> from the rust stdlib and nowhere cited, does that work with the
> >> licensing?
> >>
> >> I also think that the code above could use some improvements:
> >> - add an `# Invariants` section with appropriate invariants (what are
> >>   they supposed to be?)
> >> - Do we really want this type to be public and exported from the kernel
> >>   crate? I think it would be better if it were crate-private.
> >> - What do we gain from having this type? As I learned recently, the
> >>   `Unique` type from `core` doesn't actually put the `noalias` onto
> >>   `Box` and `Vec`. The functions are mostly delegations to `NonNull`, so
> >>   if the only advantages are that `Send` and `Sync` are already
> >>   implemented, then I think we should drop this.
> > 
> > I originally introduced it for the reasons described in [1], but mainly to make
> > clear that the owner of this thing also owns the memory behind the pointer and
> > the `Send` and `Sync` stuff you already mentioned.
> 
> I would prefer if we make that explicit, since it is rather error-prone
> when creating new pointer types (and one should have to think about
> thread safety).

Again, fine for me. If no one else has objections I'll just drop `Unique`.

> 
> ---
> Cheers,
> Benno
> 
> > If no one else has objections we can also just drop it. Personally, I'm fine
> > either way.
> > 
> > [1] https://docs.rs/rust-libcore/latest/core/ptr/struct.Unique.html
> 

