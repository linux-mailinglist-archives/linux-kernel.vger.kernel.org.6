Return-Path: <linux-kernel+bounces-277764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2722594A616
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66631F24CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A9E1E286A;
	Wed,  7 Aug 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YezfYi3V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE61B9B2F;
	Wed,  7 Aug 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027453; cv=none; b=qc/8a4AQkdZb/WJdbqni8BQa9GmzqQhIwq/XMXT3ylMYfUd/pTl8LQCK/F5ZMlSPtDDZVCZvItF3tdtPHW0UySytwJwP/dC1/s4VDyiiGuIFtS6r4ThJMUXIYdydm/Od1w2hMJQ8KzpncvyBBIt/LQdRhFB1G8VtwTJVYDcZPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027453; c=relaxed/simple;
	bh=JOxiEarUvo73HuG9/MeZiik0i/gR0KHBA5ZXH7M+o5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDSHAIsJiMou38YEzQNRqyrBvIu6ff/LgecWdhQPHvjNscpY1owRBevfdUaqEzLm0qWTxQ0uDeNRgj5n/aihPHiEEMYS7rkFVK8qQDQRganWQAUEiokIV/IW0gGju9h/QhKdiPoB/OiBPM9PDzUhDA8RD/LJpf9GTz9FZy8q4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YezfYi3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B168BC32782;
	Wed,  7 Aug 2024 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027452;
	bh=JOxiEarUvo73HuG9/MeZiik0i/gR0KHBA5ZXH7M+o5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YezfYi3VwAeOVs3hFM+qZjdVwu4ELBBZC19dpyT2GsyplWss5iaQ1MXtIWlYz9sdz
	 bmphj3s6/5dWGU3nCNaoKglJeyn179JvGERuwK5hs/gtUBxSfHRQ+TIXbJ1hWfXMyZ
	 BeOX6OAlzlSy0T9fAb7dYgsYVhKZJGvjTy/KdlzrH6x2wFSVHdDRbdt9snNfkg+Pju
	 uwhkCrlFw7MRScfiZ9jKkklMhv13dYpalO3Dv6a1kyWtHDr1M3dcJ2d6IMbSlL5scZ
	 10xCWWReHP7H7ncq9BuFP13KunCo4ieKe6/sZoSqRx591z9GKpREyg9UlzGTr1LFrO
	 RxGnCZZkOblOg==
Date: Wed, 7 Aug 2024 12:44:04 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 09/28] rust: alloc: implement kernel `Box`
Message-ID: <ZrNP9Lx-sTupwqG1@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-10-dakr@kernel.org>
 <a1c1e273-2d40-4114-b3b9-f27c73e3d122@proton.me>
 <ZrKrMrg5E85y7jkj@pollux>
 <012f5a12-2408-4658-8318-55fa8d4285e1@proton.me>
 <CAH5fLggiSU9Ossy5gc+S_rSiX8v-JCDKPL_tRDYdjMYGfOt-0w@mail.gmail.com>
 <7f3a4ea5-79c6-4068-9a5f-0aa3a55e38cb@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f3a4ea5-79c6-4068-9a5f-0aa3a55e38cb@proton.me>

On Wed, Aug 07, 2024 at 08:01:00AM +0000, Benno Lossin wrote:
> On 07.08.24 09:51, Alice Ryhl wrote:
> > On Wed, Aug 7, 2024 at 9:49 AM Benno Lossin <benno.lossin@proton.me> wrote:
> >> On 07.08.24 01:01, Danilo Krummrich wrote:
> >>> On Tue, Aug 06, 2024 at 07:47:17PM +0000, Benno Lossin wrote:
> >>>> On 05.08.24 17:19, Danilo Krummrich wrote:
> >>>>> +impl<T, A> Box<T, A>
> >>>>> +where
> >>>>> +    T: ?Sized,
> >>>>> +    A: Allocator,
> >>>>> +{
> >>>>> +    /// Constructs a `Box<T, A>` from a raw pointer.
> >>>>> +    ///
> >>>>> +    /// # Safety
> >>>>> +    ///
> >>>>> +    /// `raw` must point to valid memory, previously allocated with `A`, and at least the size of
> >>>>> +    /// type `T`.
> >>>>
> >>>> With this requirement and the invariant on `Box`, I am lead to believe
> >>>> that you can't use this for ZSTs, since they are not allocated with `A`.
> >>>> One solution would be to adjust this requirement. But I would rather use
> >>>> a different solution: we move the dangling pointer stuff into the
> >>>> allocator and also call it when `T` is a ZST (ie don't special case them
> >>>> in `Box` but in the impls of `Allocator`). That way this can stay as-is
> >>>> and the part about ZSTs in the invariant can be removed.
> >>>
> >>> Actually, we already got that. Every zero sized allocation will return a
> >>> dangling pointer. However, we can't call `Allocator::free` with (any) dangling
> >>> pointer though.
> >>
> >> The last part is rather problematic in my opinion, since the safety
> >> requirements of the functions in `Allocator` don't ensure that you're
> >> not allowed to do it. We should make it possible to free dangling
> >> pointers that were previously "allocated" by the allocator (ie returned
> >> by `realloc`).
> >> Maybe we do need an `old_layout` parameter for that (that way we can
> >> also `debug_assert_eq!(old_layout.align(), new_layout.align())`).
> > 
> > The std allocators generally prohibit zero sized allocations, so it
> > seems sensible for us to do the same?
> 
> I never understood why they do that, the stdlib `Allocator` trait has
> all the information it needs to detect zero-sized allocations, so it
> could just return dangling pointers. I don't see the point of
> duplicating the zero-sized logic in `Box` and `Vec`...

I think it's simpler and less error prone.

Besides that, I think the stdlib `Box` allows to call `from_raw` with any random
pointer for ZST, which the allocator API can't catch.

> 
> ---
> Cheers,
> Benno
> 

