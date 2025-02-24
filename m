Return-Path: <linux-kernel+bounces-528363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C33A416EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024A31710FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDECA241671;
	Mon, 24 Feb 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4U48zGR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705B27453;
	Mon, 24 Feb 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384500; cv=none; b=qLwwqvBMmAdgg5u4Oic7ukZJugoA0zx1YUmr4/o+G9++18+k9bxX49vkvxCLsWVS/uACwFP2Wymtip8kNcIZrRpwmjLg23vp26CkCMGXfUd0hf6PbTnvMQveTHHw3g9qY0HpCO3+Pt8oWXIZpINkJG9r/mPNpUHH5RR958php3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384500; c=relaxed/simple;
	bh=1oTcQ9B9UWI2JXHrdtNmloGlEojxNB4930GlWltLit0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fOPtynIhoxbrcZhtXGJbtrDh1EM4eph2GBTzaYg69jyuoM1UxmVNkMedne9omiU4VhkNu3xUlJXqLUysZTZoorubltGR/JgzSajnTnrxGhRxCWunZ+XT2YfibhoE8Aeqicsj7xczvBDt7SoWc/OOMwvY5f2HY/wLAVh7j/779dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4U48zGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B776C4CED6;
	Mon, 24 Feb 2025 08:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740384499;
	bh=1oTcQ9B9UWI2JXHrdtNmloGlEojxNB4930GlWltLit0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q4U48zGRGUATADJ5sVGS7QHOT2kBfxtnUk78ZluIipuXhbasGCpMdSe22VmkB9KWo
	 7V0I58wZUqvMQat9I6c5a1DU11he/kRymuWS/dH4MegNSy1l5NSIidOo1rkXRPCCFL
	 GWhcV7dd+UQZYjO6LJzDQuXMoAXJU+osoReP50lAgteEZJ4FJJy3O5ipgsI9GiN7ha
	 0BVxPlZ0wHyXdDVew2xyALYYB73XBrD8sTkZzcp0sIi8UYI2F4nLinxZ4+WMwdvwFI
	 zQ+WGhUL02AGkfub1gXAY1NOBGE/YN3pDSL4IILBycce4yZA0Pc5foEbY6bhHYqlmZ
	 0sXkWMPHBSO0Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,  rust-for-linux@vger.kernel.org,  Peter
 Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Will
 Deacon <will@kernel.org>,  Waiman Long <longman@redhat.com>,  Miguel Ojeda
 <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno
 Lossin <benno.lossin@proton.me>,  Alice Ryhl <aliceryhl@google.com>,
  Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: sync: lock: Add an example for Guard::lock_ref()
In-Reply-To: <20250223072114.3715-1-boqun.feng@gmail.com> (Boqun Feng's
	message of "Sat, 22 Feb 2025 23:21:14 -0800")
References: <20250223072114.3715-1-boqun.feng@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 24 Feb 2025 09:08:09 +0100
Message-ID: <87wmdf22ae.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boqun Feng <boqun.feng@gmail.com> writes:

> To provide examples on usage of `Guard::lock_ref()` along with the unit
> test, an "assert a lock is held by a guard" example is added.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> This depends on Alice's patch:
>
> 	https://lore.kernel.org/all/20250130-guard-get-lock-v1-1-8ed87899920a@google.com/
>
> I'm also OK to fold this in if Alice thinks it's fine.
>
>  rust/kernel/sync/lock.rs | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 3701fac6ebf6..6d868e35b0a3 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -201,6 +201,30 @@ unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
>  
>  impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
>      /// Returns the lock that this guard originates from.
> +    ///
> +    /// # Examples
> +    ///
> +    /// The following example shows how to use [`Guard::lock_ref()`] to assert the corresponding
> +    /// lock is held.
> +    ///
> +    /// ```
> +    /// # use kernel::{new_spinlock, stack_pin_init, sync::lock::{Backend, Guard, Lock}};
> +    ///
> +    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lock<T, B>) {
> +    ///     // Address-equal means the same lock.
> +    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
> +    /// }

This seems super useful. Perhaps add this method as part of the lock api
instead of just having it in the example?


Best regards,
Andreas Hindborg




