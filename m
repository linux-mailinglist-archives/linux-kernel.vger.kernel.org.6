Return-Path: <linux-kernel+bounces-279960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C3394C3DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC621F23C83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65D1917ED;
	Thu,  8 Aug 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgF7RJxj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3E1917C4;
	Thu,  8 Aug 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139057; cv=none; b=uyrLfGGNLqr8sX9EfLXznvaG47REEn1Ij+WwTgbXyQmyhTe0dRpEMPQrNnAEE3vPYNpD5FZ4u+osy+cmMFx1UQx/f7ntkwgemBeTkcVyU0FaZYsXjFo8vfXXnQNKl251Gmb2znq+Ih1U8/u2FqcXIBAHOOn4e4eFm3+aP/+ykkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139057; c=relaxed/simple;
	bh=/IoibKIEN2iPANCmt6FqmNCj5fP9Lkngw7sQEkFdwh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr8biZc+mTz/w8Ip/18Av0i8/E8nPko2ekGifBmXxNGMPIZ2tZpMgtm697/RzeqYDbdei6gnzh4BAQmKRnZAf5P9IO0/QrDKVh/eBHjsFel7MtimxrELdeTJ80SRWZGG3XscIN87qPIgZwGWu09XZzWrrqscPTU1f3WWG/xRCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgF7RJxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD12C32782;
	Thu,  8 Aug 2024 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723139057;
	bh=/IoibKIEN2iPANCmt6FqmNCj5fP9Lkngw7sQEkFdwh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgF7RJxjk0vIZejK3wFDDxuzJKKJ2Wt7oyymYL/FEKHPutcjn0AGcacetSH6LZi9A
	 3RoPi6i5b/eNl/SLR7TMqo8K1qTwIlHt5nuHl1jEbDSd/AijcRosw+uzsRUHx4hXpd
	 I8I+EUpqosQvN6dxu/Zh6i+CxwUNqTe0rSVs2axlJTAUl8873xLcroQzM8aiaqXz11
	 hAFQgISXZQg7FdoAuZ4X9sdxqg0JkT/rS9dGmyF5PlNvlmOFbeEaGvoHbRLMdlvXqX
	 BAUmUQmRsUdITEwb/r1ns7lFKIm9aG7YfvHLB6M9OlTQgDnZVD/CaKf2LJhUKM1uqv
	 qfgTC7z308BVQ==
Date: Thu, 8 Aug 2024 19:44:09 +0200
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
Subject: Re: [PATCH v4 09/28] rust: alloc: implement kernel `Box`
Message-ID: <ZrUD6ZyfK9Kg1mrn@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-10-dakr@kernel.org>
 <a1c1e273-2d40-4114-b3b9-f27c73e3d122@proton.me>
 <ZrKrMrg5E85y7jkj@pollux>
 <012f5a12-2408-4658-8318-55fa8d4285e1@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012f5a12-2408-4658-8318-55fa8d4285e1@proton.me>

On Wed, Aug 07, 2024 at 07:49:31AM +0000, Benno Lossin wrote:
> >>> +impl<T, A> Drop for Box<T, A>
> >>> +where
> >>> +    T: ?Sized,
> >>> +    A: Allocator,
> >>> +{
> >>> +    fn drop(&mut self) {
> >>> +        let ptr = self.0.as_ptr();
> >>> +
> >>> +        // SAFETY: `ptr` is always properly aligned, dereferenceable and points to an initialized
> >>> +        // instance of `T`.
> >>> +        let size = unsafe { core::mem::size_of_val(&*ptr) };
> >>
> >> 1. `size_of_val` is not `unsafe`.
> > 
> > Right, but dereferencing the `ptr` is unsafe.
> > 
> >> 2. why not use `&*self` instead of using the raw pointer? (then move the
> >>    let binding below this line)
> > 
> > If we ever support non-ZST `Allocator`s using `self` would not always evaluate
> > to the correct size. I think evaluating the size of `T` rather than `Box<T>` is
> > the correct thing to do.
> 
> I mean use `Box::deref` (that's what `&*self` should do), you don't need

Actually, this must either be `size_of_val(&**self)` or `size_of_val::<T>(self).

`size_of_val(&*self)` should indeed resolve to `&Box<T, A>`, right?

> to repeat the same SAFETY comment when it already is wrapped by a safe
> function.
> 
> ---
> Cheers,
> Benno
> 

