Return-Path: <linux-kernel+bounces-350272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C199029D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9441F219FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3015A868;
	Fri,  4 Oct 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU6PQ0jA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0771FAA;
	Fri,  4 Oct 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043452; cv=none; b=QMLJzgSoyXtPqDMt9BHsOtJ9Lg+kqzy4/+57TeuIg2gUme/qVHskUF6yluBaLgKiAykcJSJ+sMmDeqqqahzLvxFBnR2rfont+Vm1qBFFA02mmjQ74h6NXZjEcO4fRU/J2AqeXvMAmjrKIPDi5B+RmvLXTiBn7PMDbCyNV3s9SWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043452; c=relaxed/simple;
	bh=OEW/TsqnqgLFx9h4HePvE4V09nvFPccYDELGmyxvkzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkfVOTj/I/Kv6l29tYLUcwl4pogKyw32mTw4s9lPdiwFs7Uf8EOudQTEJ2D7WKWImv8PWSvS5QRLpW755qdaCB/1QzK3a4+Vmfz3TtXrUJijm00G7IAmQizB8dffLotQDuE66r8YJVbgz+t+fP4zOsmzDPhJJmvqV+TUCnDgml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU6PQ0jA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B609FC4CEC6;
	Fri,  4 Oct 2024 12:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728043451;
	bh=OEW/TsqnqgLFx9h4HePvE4V09nvFPccYDELGmyxvkzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LU6PQ0jAsXyGGohI/eId0raGTWH2LhKRjheq42e+U/ExabwOAq8NOU5sfkZfJxCtt
	 /lToZouDXj5jUhQQXARqXRsej4ANMMTVOMaeJigyU3pgFKDsZ0KqDoiXsOfZkcYGs/
	 0q+GNTsayXk1n7Qji5aXoUJN0NiEKyy8mRo43jJyC4sd7qeXc09Jn8TZn1pr+PiWDr
	 0IK4Kmn6Z8VJHt2c9hPuDBA1qOhxVtE+SvzjCX27txnSMfjnzqv5LgoTWef468IPCC
	 bpDZ6mTDUrP8gl9BV7EogUeDBYF5ow9G13ZjVXm/D5BtvlBbx3TYeit951PiqZMQrQ
	 J0KAZtGWaCy2g==
Date: Fri, 4 Oct 2024 14:04:03 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 11/29] rust: alloc: implement kernel `Box`
Message-ID: <Zv_Zs1fJso1-Fl2R@pollux>
References: <20241001150008.183102-1-dakr@kernel.org>
 <20241001150008.183102-12-dakr@kernel.org>
 <CANiq72nN7regVGe_FfONSKE5waG3L2xr-cdY8c0v8Y6xn297EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nN7regVGe_FfONSKE5waG3L2xr-cdY8c0v8Y6xn297EQ@mail.gmail.com>

On Fri, Oct 04, 2024 at 01:00:51AM +0200, Miguel Ojeda wrote:
> On Tue, Oct 1, 2024 at 5:01 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let x = KBox::new(24, GFP_KERNEL)?;
> > +    /// let ptr = KBox::into_raw(x);
> > +    /// let x = unsafe { KBox::from_raw(ptr) };
> 
> This is the only place that, after applying your series on top of the
> lints one (i.e. current `rust-next`), triggered a missing `// SAFETY`
> comment lint :)
> 
> If there is no new version, what do you want me to write when I apply it?

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 5d20f6112cc2..ef1add933f60 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -147,6 +147,7 @@ impl<T, A> Box<T, A>
     /// ```
     /// let x = KBox::new(24, GFP_KERNEL)?;
     /// let ptr = KBox::into_raw(x);
+    /// // SAFETY: `ptr` comes from a previous call to `KBox::into_raw`.
     /// let x = unsafe { KBox::from_raw(ptr) };
     ///
     /// assert_eq!(*x, 24);

But maybe it's better to just send a new version, to also fix the missing
`#![feature(inline_const)]` for `Vec` and missing import for `size_of` in
`ArrayLayout`.

> 
> Thanks!
> 
> Cheers,
> Miguel
> 

