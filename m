Return-Path: <linux-kernel+bounces-312861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DFB969C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736A928588A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F5B1C9853;
	Tue,  3 Sep 2024 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goFHb/NV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E761C62AB;
	Tue,  3 Sep 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364594; cv=none; b=ANc9RbiPgx394TnC6G6oD5Sv5yc4YWPFBy2t4YckVOa5+t9yneH8Yl855JafunjfRVfiZTEQMGLdDx7axhV6zYYqukGgRjxGYg1ediDeVtfbDe+TiDI9MH3lHv2mv++gw2f7knb5IG9RrZwXHC4oIWyOp0T74MgKcY/2Y/3gbqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364594; c=relaxed/simple;
	bh=0zDsuJ5lW1nyARE4wtBvC9CZFQt76AfHnSgA1z+UpPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuBhZQsT3NhL6wM5iMvEdsG1occaUajltAQCChzGH5gxGwUL0bZiFcSlW9fvpeXWtRs2Jvh+opLOMJYtKERVqBrI6IgEfJWIAtkirXfY2n+MExFyJ3dOwnYpvemNMjW+X3pN2QTqIeOeLXNJXgFGJo+kXKf4RVYNCIEUXJuoftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goFHb/NV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C280AC4CEC4;
	Tue,  3 Sep 2024 11:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725364594;
	bh=0zDsuJ5lW1nyARE4wtBvC9CZFQt76AfHnSgA1z+UpPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goFHb/NVyfUwbKhLKJ2UYfleAJrAn+IdbWMH1igvXp2PF8viVN/lNuzaY2QUpiuBg
	 FQROMe7MCudg0NxbhRfo1WQtfo5WELXFLXoEuuKL48ZKa+Z1LEcEF+P1o7UogXw1vS
	 M4YMnaG8ZIvELBvXtVkt4WnfFJtJM38IY/b9mEucb5Mf/EJei+KdTvzZ0f2pWG7OZc
	 Rwr2jFxq07hHVIkmsLtt0a4QPCTnUxdgMpUYUHEUdx5V7EJZJjVgiP3vyBqoP1fofd
	 0xo1x31nEg2IJDYxy3hsJ5WDoqFGTODqz5JrG5eq54e/F2ZMVzSbvaqQIGgEgwsD6w
	 ViDOb23ShhGlQ==
Date: Tue, 3 Sep 2024 13:56:26 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 01/26] rust: alloc: add `Allocator` trait
Message-ID: <Ztb5arBBX2LsrFKo@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-2-dakr@kernel.org>
 <60253988-37e7-4acb-b2ae-748b30a4ac21@proton.me>
 <ZtDuf0QGfhiy5X_I@pollux.localdomain>
 <44b80095-8b03-4558-967e-138ea712f780@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44b80095-8b03-4558-967e-138ea712f780@proton.me>

On Fri, Aug 30, 2024 at 01:06:00PM +0000, Benno Lossin wrote:
> On 29.08.24 23:56, Danilo Krummrich wrote:
> > On Thu, Aug 29, 2024 at 06:19:09PM +0000, Benno Lossin wrote:
> >> On 16.08.24 02:10, Danilo Krummrich wrote:
> >>> Add a kernel specific `Allocator` trait, that in contrast to the one in
> >>> Rust's core library doesn't require unstable features and supports GFP
> >>> flags.
> >>>
> >>> Subsequent patches add the following trait implementors: `Kmalloc`,
> >>> `Vmalloc` and `KVmalloc`.
> >>>
> >>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >>
> >> We discussed this in our weekly meeting (I think ~one week ago?). If you
> >> give me a draft version of the comment that you plan to add regarding
> >> the `old_layout` parameter, I can see if I am happy with it. If I am, I
> >> would give you my RB.
> > 
> > May I propose you let me know what you would like to see covered, rather than
> > me trying to guess it. :-)
> 
> I was hoping that we put that in our meeting notes, but I failed to find
> them... I would put this in a normal comment, so it doesn't show up in the
> documentation. Preface it like implementation decision/detail:
> - Why do `Allocator::{realloc,free}` not have an `old_layout` parameter
>   like in the stdlib? (the reasons you had for that decision, like we
>   don't need it etc.)

Ok.

> - Then something along the lines of "Note that no technical reason is
>   listed above, so if you need/want to implement an allocator taking
>   advantage of that, you can change it"

I don't really want to set the conditions for this to change in the
documentation. It really depends on whether it's actually needed or the
advantage of having it is huge enough to leave the core kernel allocators with
unused arguments.

This can really only be properly evaluated case by case in a discussion.

> 
> I don't think we need a lot here. Additionally it would be very useful
> to also put this in an issue to not lose track of it.
> 
> ---
> Cheers,
> Benno
> 

