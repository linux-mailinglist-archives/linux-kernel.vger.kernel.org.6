Return-Path: <linux-kernel+bounces-390194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843D29B76BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3937B1F22B41
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A600818DF6B;
	Thu, 31 Oct 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzzTOIio"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F78F5C;
	Thu, 31 Oct 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364651; cv=none; b=HDbEYukaezx5ca81GAPWC556hX5Loe+bKZn66fLonTG+6s6Ik9qpOMqErZxlwYTYeFxKBOqxjwOOqskZ6PLPBGqezgZAk07Bzasncj9fVsK4LHA3a/tLB+rwazIbF85REZhM7QjjhVPP1llqJyZ70Fpg2KcLZfASU2IRdDJ93ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364651; c=relaxed/simple;
	bh=uDyTxObPZQhe/Lb4VIdpRaXVBtmoGytmy4ea0Z8chBk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=gGeGESQyh9kuQx/WzNuQ0hUuWXTSGmChvla9JnggweFuYfIo6670w7do9O6UJ8TzNpwOXcV4nKao/RodjC0brzANXGArCjygYftcgPf1Jmwu0KFoOJocYJSQpaST+BNwl1ct9Zeld/eJNCiIGnMx46Fz7dRRkE1POeRWGfwnW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzzTOIio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9638DC4CEC3;
	Thu, 31 Oct 2024 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730364650;
	bh=uDyTxObPZQhe/Lb4VIdpRaXVBtmoGytmy4ea0Z8chBk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:From;
	b=KzzTOIioPnYOHCLHWILID2exXZcX6Ib0PDdDcY1jtUD+QU5dMyYtd1JQR0PSJUdOV
	 sQ3nGVMJjfnL1YhNj/FVgmB9yp+n8qASVceYUVtP0mCkZSDYiDKDaoqPHJP3xdPO2J
	 /mIhf2sSJXAXe/vRoMpoRbKkPGPYF9Scipx3HB6loCkUesS3dn8S8b/h6jh8kjMULP
	 BnTJ8M13Nofqs4DXPfo9ljQfoyp3WTBmHf+vcI2pqU+E3LBJCYa067QIxR4M/UXnXd
	 jV0IDAGCs35XljJKGvQg+JXOr/hV3HSCJ2DVzdHTVaSqqvJ+X10XyGfDx5p/FERnOt
	 7e2FuL3MmLJeA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?us-ascii?Q?=3D=3Futf-8=3FQ=3FBj=3DC3=3DB6rn=3F=3D?=
 Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] rust: arc: use `NonNull::new_unchecked`
In-Reply-To: <20241030-borrow-mut-v1-1-8f0ceaf78eaf@gmail.com> (Tamir
	Duberstein's message of "Wed, 30 Oct 2024 16:46:38 -0400")
Date: Thu, 31 Oct 2024 09:27:43 +0100
Message-ID: <87jzdopthc.fsf@kernel.org>
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
	<4Gt8heJcUIL12zJWx8G_MkgF3vZQPoFAEagztu_-UzAVBIVIx_qJn6E7bWdq3QMKQ4n3GcuXitfXwY5HMxX7KQ==@protonmail.internalid>
	<20241030-borrow-mut-v1-1-8f0ceaf78eaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> There is no need to check (and panic on violations of) the safety
> requirements on `ForeignOwnable` functions. Avoiding the check is
> consistent with the implementation of `ForeignOwnable` for `Box`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/sync/arc.rs | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index db9da352d588f65348aa7a5204abbb165b70197f..4857230bd8d410bcca97b2081c3ce2f617ee7921 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -337,9 +337,9 @@ fn into_foreign(self) -> *const core::ffi::c_void {
>      }
>
>      unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
> -        // By the safety requirement of this function, we know that `ptr` came from
> -        // a previous call to `Arc::into_foreign`.
> -        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
> +        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
> +        // call to `Self::into_foreign`.
> +        let inner = unsafe { NonNull::new_unchecked(ptr as _) };

Please use an explicit cast.

>
>          // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
>          // for the lifetime of the returned value.
> @@ -347,10 +347,14 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
>      }
>
>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
> +        // call to `Self::into_foreign`.
> +        let inner = unsafe { NonNull::new_unchecked(ptr as _) };

Please use an explicit cast.

> +
>          // SAFETY: By the safety requirement of this function, we know that `ptr` came from
>          // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
>          // holds a reference count increment that is transferrable to us.
> -        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
> +        unsafe { Self::from_inner(inner) }
>      }
>  }

Otherwise lgtm.

Best regards,
Andreas


