Return-Path: <linux-kernel+bounces-272537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9DE945D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FBF1F23AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D926D1E2886;
	Fri,  2 Aug 2024 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2XjONP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3711DF670;
	Fri,  2 Aug 2024 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600161; cv=none; b=YgK+MmpEVtupNLwC692dPUdcLH+cuHvXne+6EivuhnyOk4xL6Z6ZLRvaMMBHbRAp49jPXKmBmczmKBDj+0J0hMZVHZ7+BstzJ0Aie/Qbk9OSNkK8OQPvNcaaeDQjInXV4Gjl5+VNL2UBHeU/JBhA7/zlgI67JaNfNiqYhaVRP7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600161; c=relaxed/simple;
	bh=Ox56jQpv10zSiCtaYQE/iYK8oMxsBahCCNxSxZdaSvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ3YUA32ZBll8s3rvYKctSK6ai3cpUSj46B4BaFIKw6CQ53LDpovRFTalcS+JDu99QHI0g5FJUbIRv/MS7oyVwLd752Sa155hUSOKhCfHxsjmI/oRNZrxkWtZ3k2pf+L1xPxxHpOfnfil52+5B0PFZ/Co+03ZcZ3DlsPnfB1CZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2XjONP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B1FC4AF0B;
	Fri,  2 Aug 2024 12:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722600160;
	bh=Ox56jQpv10zSiCtaYQE/iYK8oMxsBahCCNxSxZdaSvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2XjONP9dcbpSo70yeYKdJah7jJNPb2awHNNwVYJWJS6nsQssTQRgweFPmk+AGIFv
	 Ff1Om9fxnxrEM9xvDnZQ+MI4hrsHpQnslcjspObtlowtwFT7/XOeSuQTbriUNEF4zY
	 sWfBfXwuC+x1og3wUYPBs3RskHy/ZdbWyxA1ks8aTRUyLBH/WyY1wlP0AqUP8z87z8
	 crk8Z+hrUW+bYWYEPyDR7uGIdZmwZSlcQBjYun+6/iUH2zRJ8dElNKfu2Zvu0uR09q
	 rRI4Bbbb587Zv11v84YuxM/Ha64SqVA7XZyIxQWo1lVk+LdXIvmB9/1cldMOpuziR2
	 L6qzJZhl358hQ==
Date: Fri, 2 Aug 2024 14:02:32 +0200
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
Message-ID: <ZqzK2LeUgX1AQP4E@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-18-dakr@kernel.org>
 <CAH5fLghO8v0wn-uCx1u_zojPLdDH_RMn4BXxLB1ZMJjfpTkbAw@mail.gmail.com>
 <ZqurvdyDD6bH4H7Y@pollux>
 <CAH5fLgga9TOtZBcJNJBgzRGSrX5JuvdbSrvdYV3w8b7gOAncPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgga9TOtZBcJNJBgzRGSrX5JuvdbSrvdYV3w8b7gOAncPA@mail.gmail.com>

On Fri, Aug 02, 2024 at 09:08:48AM +0200, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 5:37 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Thu, Aug 01, 2024 at 05:10:22PM +0200, Alice Ryhl wrote:
> > > On Thu, Aug 1, 2024 at 2:08 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > >
> > > > Currently, we can't implement `FromIterator`. There are a couple of
> > > > issues with this trait in the kernel, namely:
> > > >
> > > >   - Rust's specialization feature is unstable. This prevents us to
> > > >     optimze for the special case where `I::IntoIter` equals `Vec`'s
> > > >     `IntoIter` type.
> > > >   - We also can't use `I::IntoIter`'s type ID either to work around this,
> > > >     since `FromIterator` doesn't require this type to be `'static`.
> > > >   - `FromIterator::from_iter` does return `Self` instead of
> > > >     `Result<Self, AllocError>`, hence we can't properly handle allocation
> > > >     failures.
> > > >   - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle
> > > >     additional allocation flags.
> > > >
> > > > Instead, provide `IntoIter::collect`, such that we can at least convert
> > > > `IntoIter` into a `Vec` again.
> > > >
> > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > >
> > > I'm not convinced a collect implementation specific to IntoIter is necessary?
> >
> > For the reasons above, we can't implement `FromIterator`. At some point we may
> > want to implement our own kernel `FromIterator` trait, but that's out of scope
> > for this series.
> >
> > For now, I just want to provide a way to get a `Vec` from `IntoIter` again,
> > which without `Vec::collect` would be impossible.
> 
> If you have a need for a collect on this particular kind of iterator, then okay.

Even once we have our own `FromIterator` trait, we probably want to keep this
specific one besides the generic `collect` for optimization. With the generic
one we'd otherwise copy into a new `Vec`.

> 
> > > > +
> > > > +        // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
> > > > +        // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
> > > > +        // it as it is.
> > > > +        ptr = match unsafe { A::realloc(Some(buf.cast()), layout, flags) } {
> > >
> > > Why would you shrink it? You can just keep the capacity.
> >
> > What if the vector was pretty huge and meanwhile as advanced by a lot? I think
> > we don't want to waste those resources.
> >
> > Ideally the corresponding `Allocator` implements a proper heuristic for when to
> > actually shrink. For instance, krealloc() never shrinks, and it's probably not
> > worth it. For vrealloc() though we clearly want to shrink properly (i.e. unmap
> > and free spare pages) at some point.
> 
> The Rust Vec never shrinks unless explicitly requested. But I guess
> it's okay either way.

It actually does, see [1]. But Rust's `Vec` does it less efficiently. It either
keeps the `Vec` as it is, or creates a whole new one.

[1] https://github.com/rust-lang/rust/blob/master/library/alloc/src/vec/spec_from_iter.rs#L39

> 
> Alice
> 

