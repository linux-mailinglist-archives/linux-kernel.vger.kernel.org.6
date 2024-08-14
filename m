Return-Path: <linux-kernel+bounces-286520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEDA951BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886201C21902
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30FF1B29B9;
	Wed, 14 Aug 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcJxRaaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8D1B1437;
	Wed, 14 Aug 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642588; cv=none; b=YeI5wha+d00KxsdP9uDCYMP/gsWHLwUKlEqMDH1ZKabp1yNJ2yUFgF5m3MmS1GVpKGOquLTqjamM4BfdMNArRCYrWUc50NO4aZQJbQz669nJex8E9doE9MWflEiW1nZ0EDxbfQagXdaGxscJVsGVFZPpB3Vj1yL+aZ2lgOZ2pfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642588; c=relaxed/simple;
	bh=6tnhxY9G9+UJBXYcSgog9jSluJDuRzIzD3yGkv90H6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4S11p4/UXMUlTbMRh0vUSF3bNvLJmhB+9A8MBzSIuIo2HzmHtH7dDRhofinWpQDcHCWclbqeznUf0Ag4otIK8J8ghh7pBdmtndpg7mxHJ9kjXq7jejqNbaYpbq+cgerlK4DFFUOQIjgGtpRK71X9QSFYB3T2YVbpCW2jdciLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcJxRaaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F5AC32786;
	Wed, 14 Aug 2024 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723642587;
	bh=6tnhxY9G9+UJBXYcSgog9jSluJDuRzIzD3yGkv90H6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcJxRaaXjB340O42WzVrf1BF1Oia0r4FIw3tzbo0OnZ0AOhNqAzoLWF1Hv8cw+VKd
	 hl4PEG0MzqlTNQTxUj//jNKOZamK/1W2hifDbyT3fwZFm19r6yngsAtEU4+DmzJgQ2
	 3KGIdSZ4q2h0qU1iNUV2G6chXfNpoBUNDq13ZYwXvYaVrtwHYbH0HQB6pzm+++LRhR
	 T5zako2jV2WbP3kkvFxYxCjc7ZixFZ/POel4P1DGYdOhQkvmjC7ApyedyBCMCChuwR
	 nHzukmIhfniXAiFUknhrZtY17waN3Fq5E/yVioUJn/KfX0FHh50Yxj4WdMbQU2zviv
	 9D75A4RcFbyIQ==
Date: Wed, 14 Aug 2024 15:36:19 +0200
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
Message-ID: <Zryy04DvEsnxsRCj@pollux>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-5-dakr@kernel.org>
 <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com>

On Wed, Aug 14, 2024 at 09:51:34AM +0200, Alice Ryhl wrote:
> On Mon, Aug 12, 2024 at 8:24 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
> > typically used for objects smaller than page size.
> >
> > All memory allocations made with `Kmalloc` end up in `krealloc()`.
> >
> > It serves as allocator for the subsequently introduced types `KBox` and
> > `KVec`.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/helpers.c                 |  3 +-
> >  rust/kernel/alloc.rs           |  2 +-
> >  rust/kernel/alloc/allocator.rs | 63 +++++++++++++++++++++++++++++++++-
> >  3 files changed, 64 insertions(+), 4 deletions(-)
> >
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 92d3c03ae1bd..9f7275493365 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -193,8 +193,7 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> >
> > -void * __must_check __realloc_size(2)
> > -rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> > +void *rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> >  {
> >         return krealloc(objp, new_size, flags);
> >  }
> 
> Why are the various annotations on this helper being removed?

rust_helper_krealloc() is only called from Rust, hence neither __must_check nor
__realloc_size() should have any effect.

I also do not apply them in subsequent commits for the vrealloc() and
kvrealloc() helpers for this reason and removed them here for consistency.

> This deserves an explanation in the commit message.

I can also add a separate commit for that.

> 
> Alice
> 

