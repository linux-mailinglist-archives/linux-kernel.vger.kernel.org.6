Return-Path: <linux-kernel+bounces-377601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0B9AC11B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612A1B24EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B126158534;
	Wed, 23 Oct 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX8QZPFF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623AF156F55;
	Wed, 23 Oct 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671051; cv=none; b=EFuAhh+3ASzHJLFVj2ZEzqSMmyyUoVrzgCp8OJb8dWuFSdvrBg7qkPv7VeJ8csprbA5kReliXXr1zDWm9huKc6OcRsdEgPyoVhufI/q2LH659BEt1Nb/qB7fxiDzPas6M2LWJZZx0kifC2WvpCKvVP66rTFRNgtp9wiVlr0LlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671051; c=relaxed/simple;
	bh=8e90x0qzJsKjLeBlfStfvRpTZYDyyrZm55c0ORJ4y7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwF36APICt57f57QeGBTVpmibqGl7RYbIU/9UhirlRGwPMvdPB7icl37xM027txgo8TCzSsidNIlI3UdEd0mPgJpb4OmqCaJuzdS0Rm+M6itZnO/vz0YxZMBS3IuQXrHv2Mtr2xki0JhWm7EwzFgy6H1CQ6MAYerRl/ZMr0B1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX8QZPFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A43C4CEC6;
	Wed, 23 Oct 2024 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729671050;
	bh=8e90x0qzJsKjLeBlfStfvRpTZYDyyrZm55c0ORJ4y7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AX8QZPFFPiK+7JtxJUmZMhvNUG2IgPMFRmcW4eJ7SBVUCGU6jFcmuxZyEo4TzrwhA
	 jLMGoMWV14ADPHe9taFOUm01qHNhjPKyqO6kQMVc92cdz47j3tIlrHg0P3IlUXMF6i
	 i7GCdU1CPGFCGQuzK1vOgkdh5/d0Mlab9NkcAKpzY2orltmUZK4vt3VBBQTCr14tiu
	 AdXu2TmXJ1GP5SeC84ffYNqcpxSoEWdvL3FYGEHe4OmPKLbL2alkouCiukGkTBwpDv
	 rNuebHgUrCt02W0UsRsAwEd7t9L+IEoDOIaG93DF6SF119l9bEKwRDhy82Xh47cX8z
	 0Nd6lvD1BOpOw==
Date: Wed, 23 Oct 2024 10:10:45 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, aliceryhl@google.com, dakr@redhat.com,
	linux-kernel@vger.kernel.org, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com, boqun.feng@gmail.com
Subject: Re: [PATCH v2 1/5] rust: types: add `Owned` type and `Ownable` trait
Message-ID: <ZxivhdAkTl9xXCBs@pollux>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-2-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022224832.1505432-2-abdiel.janulgue@gmail.com>

On Wed, Oct 23, 2024 at 01:44:45AM +0300, Abdiel Janulgue wrote:
> Add the 'Owned' type, a simple smart pointer type that owns the
> underlying data.
> 
> An object implementing `Ownable' can constructed by wrapping it in
> `Owned`, which has the advantage of allowing fine-grained control
> over it's resource allocation and deallocation.
> 
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/types.rs | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index ced143600eb1..3f632916bd4d 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -429,3 +429,65 @@ pub enum Either<L, R> {
>      /// Constructs an instance of [`Either`] containing a value of type `R`.
>      Right(R),
>  }
> +
> +/// A smart pointer that owns the underlying data `T`.
> +///
> +/// This is a simple smart pointer that owns the underlying data. Typically, this would be
> +/// returned as a wrapper for `T` in `T`'s constructor.
> +/// When an object adds an option of being constructed this way, in addition to implementing
> +/// `Drop`, it implements `Ownable` as well, thus having finer-grained control in where
> +/// resource allocation and deallocation happens.
> +///
> +/// # Invariants
> +///
> +/// The pointer is always valid and owns the underlying data.
> +pub struct Owned<T: Ownable> {
> +    ptr: NonNull<T>,
> +}
> +
> +impl<T: Ownable> Owned<T> {
> +    /// Creates a new smart pointer that owns `T`.
> +    ///
> +    /// # Safety
> +    /// `ptr` needs to be a valid pointer, and it should be the unique owner to the object,
> +    /// in other words, no other entity should free the underlying data.
> +    pub unsafe fn to_owned(ptr: *mut T) -> Self {
> +	// SAFETY: Per function safety requirement.
> +	Self { ptr: unsafe { NonNull::new_unchecked(ptr) } }
> +    }

I wonder if this should just be

   pub fn new(ptr: NonNull<T>) -> Self

This way the caller could decide whether to use the fallible variant
`NonNull::new` or `NonNull::new_unchecked`.

Alternatively, you could have your own `new` and `new_unchecked` methods, but
that seems a bit redundant.

Sometimes this might be more elegant. For instance in the page code, as it is
now, you have to give up on

   let page = NonNull::new(page).ok_or(AllocError)?;

and instead have to do a NULL check by hand for the subsequent unsafe call to
`Owned::to_owned`.

> +}
> +
> +impl<T: Ownable> Deref for Owned<T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> +        // safe to dereference it.
> +        unsafe { self.ptr.as_ref() }
> +    }
> +}
> +
> +impl<T: Ownable> DerefMut for Owned<T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> +        // safe to dereference it.
> +        unsafe { self.ptr.as_mut() }
> +    }
> +}
> +
> +/// An Ownable type is a type that can be put into `Owned<T>`, and when `Owned<T>` drops,
> +/// `ptr_drop` will be called.
> +pub unsafe trait Ownable {
> +    /// # Safety
> +    /// This could only be called in the `Owned::drop` function.
> +    unsafe fn ptr_drop(ptr: *mut Self);
> +}
> +
> +impl<T: Ownable> Drop for Owned<T> {
> +    fn drop(&mut self) {
> +	// SAFETY: In Owned<T>::drop.
> +	unsafe {
> +	    <T as Ownable>::ptr_drop(self.ptr.as_mut());
> +	}
> +    }
> +}
> -- 
> 2.43.0
> 

