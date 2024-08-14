Return-Path: <linux-kernel+bounces-286433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B040951AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E162810A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397BC1B14E8;
	Wed, 14 Aug 2024 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbXHeAIq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F141B1419;
	Wed, 14 Aug 2024 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638591; cv=none; b=dnBhSZsPDl1tGnz0IzY+R+zmYxi59dwyI3YUiIFgz1aQ3QsDxeEL01Lq1mWlbgHrbnPrEEJIsS4YJu+YckNtyvNWajDIMo1ulKqB2zVtWcGGgYrWPxqqUAj3V/aRYpHOJ/m0Rci7lymaq35uPJtjBegYOpMr52SfXRgCbJjQ6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638591; c=relaxed/simple;
	bh=3LlbGTb9LvSez9xYIWSrKLg3gD7ng+0n0fCCGGjqAzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/0bIhL2qI2WtHfyLOcEBA+ZnT+Qiv968nrUOIVDF2IqU2u0+Uo/uZSnvzVPB92GH8h82JjGheqI8FFKSob8G6sS4cbixFAGSESiQdwfgI1dMReFe5BUfeXHIPU6XJhmHENkF23z26fXNaRmtCOoSBm17jiNUlMPE6iCPl35Fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbXHeAIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE6EC32786;
	Wed, 14 Aug 2024 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723638590;
	bh=3LlbGTb9LvSez9xYIWSrKLg3gD7ng+0n0fCCGGjqAzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbXHeAIq4z6mlPAJxN2IvSnvD+yt2Bu1jABxUKDlDZjhOvcW0rMpCfq/O2kigLrUO
	 rd23IRTDGhYxr+3vwXry5lc99AcUbb6KFbCsvyS2ddmpVrAuwqNKkBwoH1e5ssdwws
	 nXtcLlpIGSo3A3oZYsIlnUFGEASw8bB9jAB/pprY5b0eT18ppR3GxybBvbJiCi0vRQ
	 17gZRzE60NOqSxcG/VKvtd07PPTlW+ThLewv2Exor5gRdVQjJ4/mcEkZEnKaop0zcn
	 i8N9Qz248eWIAxJOOVqFEJUgj0DMiqpnxp1mkvuAvfw43yGiNjsHR39jjJribvwpzX
	 tdgdlgqmreJnw==
Date: Wed, 14 Aug 2024 14:29:43 +0200
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
Subject: Re: [PATCH v5 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <ZryjN7Rn_vZNwsZU@pollux>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-14-dakr@kernel.org>
 <CAH5fLggchaAzcRK=i=zRm7hTg6qX0yGBAyAHcO45rG-oEh-AMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggchaAzcRK=i=zRm7hTg6qX0yGBAyAHcO45rG-oEh-AMQ@mail.gmail.com>

On Wed, Aug 14, 2024 at 10:42:28AM +0200, Alice Ryhl wrote:
> On Mon, Aug 12, 2024 at 8:25 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > `Vec` provides a contiguous growable array type (such as `Vec`) with
> > contents allocated with the kernel's allocators (e.g. `Kmalloc`,
> > `Vmalloc` or `KVmalloc`).
> >
> > In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
> > kernel's GFP flags for all appropriate functions, always reports
> > allocation failures through `Result<_, AllocError>` and remains
> > independent from unstable features.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > [...]
> > +impl<T, A, const N: usize> Box<[T; N], A>
> > +where
> > +    A: Allocator,
> > +{
> > +    /// Convert a `Box<[T, N], A>` to a `Vec<T, A>`.
> > +    pub fn into_vec(b: Self) -> Vec<T, A> {
> 
> Nit: I would probably make this a From impl.

Please see my reply to patch 9 of this series.

> 
> > +#[macro_export]
> > +macro_rules! kvec {
> > +    () => (
> > +        {
> > +            $crate::alloc::KVec::new()
> > +        }
> > +    );
> > +    ($elem:expr; $n:expr) => (
> > +        {
> > +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
> > +        }
> > +    );
> > +    ($($x:expr),+ $(,)?) => (
> > +        {
> > +            match $crate::alloc::KBox::new([$($x),+], GFP_KERNEL) {
> > +                Ok(b) => Ok($crate::alloc::KBox::into_vec(b)),
> > +                Err(e) => Err(e),
> 
> Hmm. This currently generates code that:
> 
> 1. Creates the array.
> 2. Allocates the memory.
> 3. Moves the array into the box.
> 
> Whereas the stdlib macro swaps step 1 and 2. You can do the same by
> utilizing new_uninit. A sketch:
> 
> match KBox::<[_; _]>::new_uninit(GFP_KERNEL) {
>     Ok(b) => Ok(KVec::from(KBox::write(b, [$($x),+]))),
>     Err(e) => Err(e),
> }

Generally, I'm fine changing that, but what's the reason for the suggestion? It
shouldn't make a difference, does it?

> 
> > +// SAFETY: `Vec` is `Send` if `T` is `Send` because the data referenced by `self.ptr` is unaliased.
> > +unsafe impl<T, A> Send for Vec<T, A>
> > +where
> > +    T: Send,
> > +    A: Allocator,
> > +{
> > +}
> > +
> > +// SAFETY: `Vec` is `Sync` if `T` is `Sync` because the data referenced by `self.ptr` is unaliased.
> > +unsafe impl<T, A> Sync for Vec<T, A>
> > +where
> > +    T: Send,
> > +    A: Allocator,
> 
> Same comment as Box. Ditto about "unaliased". Needs `T: Sync` instead.
> 
> > +impl<T: Clone, A: Allocator> Vec<T, A> {
> > +    /// Extend the vector by `n` clones of value.
> > +    pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> Result<(), AllocError> {
> > +        self.reserve(n, flags)?;
> > +
> > +        let spare = self.spare_capacity_mut();
> > +
> > +        for item in spare.iter_mut().take(n - 1) {
> 
> You need to handle `n == 0` here.

Gonna fix.

> 
> Alice
> 

