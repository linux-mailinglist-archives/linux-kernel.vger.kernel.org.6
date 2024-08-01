Return-Path: <linux-kernel+bounces-271526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0806944F6E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBCC1C238FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3C1B32A1;
	Thu,  1 Aug 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2g7XPaS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3A21A0B;
	Thu,  1 Aug 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526661; cv=none; b=pPNBiQlz1Pe3eZLK2FXLaGRCivdrohqJEJ5/MVuTDCCpFPcWb1Xac2l084qDrR3zyoFu9lucuInHDbYM6QntKWW2NaK0qH4fNXRfc2HNzf1eGfr17bVTFOaw3BLL/TfteoylvZh8Badwhos1eeHvDDeEMZmH8HnH9Kaf7Zz9Jwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526661; c=relaxed/simple;
	bh=eVLalnnIMUfT3DQM+7CU8nlT5DrlvzT2NV18fgmDEnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thp/nIP1jpOYIRLf05ywY9cptCloE37aCohJ8YSsZ7vNqbW8r6bG08xnVP2IMrZI+Djp5sh/gJXXNuxAgaXapsL4nrTPIFNAoB9KObZwqzsYNdGckgx1ZBj5s41pOxxAyovRoTdZnkI2MzdWIdLFfuvWUPzr8C7V3xPLOFQlO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2g7XPaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC277C32786;
	Thu,  1 Aug 2024 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722526660;
	bh=eVLalnnIMUfT3DQM+7CU8nlT5DrlvzT2NV18fgmDEnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2g7XPaSWegFc9Wbo2iye2lo+3VGPXt+ax9u/+NNrxtCic7cXtfZcLQm+MkcL5gAU
	 5pIfNlOf9AH22KT7r2GVRetDNNvMMw2rfI5RrCQuc74edkz1FoYGSZmlx3d0+vNIHm
	 7vDwYhDUt9wSJCkwE9ikljdM86BEKT/zB+ZUETT37D4xl3fo2pfOfWlN/H9wkDZPvU
	 n10TXL4GCZCvMZ/4MHLTJnKy/JRSmCqunR1hDjxlzIug0TaNdiydAOj1LjmE2lnLwP
	 H5d57AXKlX58UG20Ub3Cpfkna0nz7ktXNKX9yekaQJhDhyxYhzCerWiv3DMh9CEL6X
	 UXrWwTC49DQKA==
Date: Thu, 1 Aug 2024 17:37:33 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 17/25] rust: alloc: implement `collect` for `IntoIter`
Message-ID: <ZqurvdyDD6bH4H7Y@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-18-dakr@kernel.org>
 <CAH5fLghO8v0wn-uCx1u_zojPLdDH_RMn4BXxLB1ZMJjfpTkbAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghO8v0wn-uCx1u_zojPLdDH_RMn4BXxLB1ZMJjfpTkbAw@mail.gmail.com>

On Thu, Aug 01, 2024 at 05:10:22PM +0200, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 2:08 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > Currently, we can't implement `FromIterator`. There are a couple of
> > issues with this trait in the kernel, namely:
> >
> >   - Rust's specialization feature is unstable. This prevents us to
> >     optimze for the special case where `I::IntoIter` equals `Vec`'s
> >     `IntoIter` type.
> >   - We also can't use `I::IntoIter`'s type ID either to work around this,
> >     since `FromIterator` doesn't require this type to be `'static`.
> >   - `FromIterator::from_iter` does return `Self` instead of
> >     `Result<Self, AllocError>`, hence we can't properly handle allocation
> >     failures.
> >   - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle
> >     additional allocation flags.
> >
> > Instead, provide `IntoIter::collect`, such that we can at least convert
> > `IntoIter` into a `Vec` again.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> I'm not convinced a collect implementation specific to IntoIter is necessary?

For the reasons above, we can't implement `FromIterator`. At some point we may
want to implement our own kernel `FromIterator` trait, but that's out of scope
for this series.

For now, I just want to provide a way to get a `Vec` from `IntoIter` again,
which without `Vec::collect` would be impossible.

> 
> > +
> > +        // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
> > +        // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
> > +        // it as it is.
> > +        ptr = match unsafe { A::realloc(Some(buf.cast()), layout, flags) } {
> 
> Why would you shrink it? You can just keep the capacity.

What if the vector was pretty huge and meanwhile as advanced by a lot? I think
we don't want to waste those resources.

Ideally the corresponding `Allocator` implements a proper heuristic for when to
actually shrink. For instance, krealloc() never shrinks, and it's probably not
worth it. For vrealloc() though we clearly want to shrink properly (i.e. unmap
and free spare pages) at some point.

> 
> Alice
> 

