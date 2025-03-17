Return-Path: <linux-kernel+bounces-563799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9299AA648B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6AC3A3795
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5AA22CBC9;
	Mon, 17 Mar 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FdSzgX5n"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F7229B28
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205892; cv=none; b=tIqE92iadAXvvhI66c1vHjYM/B2ch5OnG7C+Nx0TbnugBiY2VxQG1JBha6NUdMI1KP65vPFpraX7RFokC2XZq3p5wKKxwpVvM37WwTyM7e4AlJ5Q0kYF+NvHb334gFUdrArMnVk00ddQuRBKQK3e5YGwGL4HEfkKxgvKUmQgG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205892; c=relaxed/simple;
	bh=mfcz0UcfGs3DF2HBz70r0C6E2WxcbrZP7tC3ehoHffc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvHHMLqoXqDsvk4dNrurqzrgr3EMMXfcrp071TnVlQw71i0zRQjNhY5vB7FXB3EuWTOO9pTWyOO5wTjrosKWkU5Rj2Yhq3IvNI7WxoL2H2/KbWCRsqewi6Uz5x97VV12oXTSFAzMRMIAny5s9t4dnTLpeaOWiAtvRlPeoMZThwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FdSzgX5n; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742205888; x=1742465088;
	bh=X64bhhRxkKSZobTY1XuwYles7p5HPACCYx5U3xbdp6E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FdSzgX5nz82ivuXKaoTfUFKksmvznabh+uKjlWoo6JHYS+Uu9/yrK97/1AYq0+s9r
	 PxCpTeqpgu5LYv+vKYIpUoP0QTwNU9SYpkBo31aB1H7z5IQS5UHRa9WkX253JnVY9D
	 5gCnV7wEugAOUZr0tjpVNgmie7Mzc9ie+plQtdYD7YPf/6Q+KsajRGz2S2+3mZlz4Y
	 vRlNKhpOhBrQG2O7ETKTrfSeK91swH0buX9IQlfRERjYdANt+/RyUHS8X7MTh1uqAC
	 jmw3Ru9ILRwIF6WEFftjjdDTmyvcmXRAFacVdDAkweXOhYo7gP9JSUVZHdm1oFpu6v
	 24+F5SenmjdXQ==
Date: Mon, 17 Mar 2025 10:04:40 +0000
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
In-Reply-To: <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com> <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c9a8fbc4be49e5953b6e26208dabda8377fc9252
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> Add `Vec::dec_len` that reduces the length of the receiver. This method
> is intended to be used from methods that remove elements from `Vec` such
> as `truncate`, `pop`, `remove`, and others. This method is intentionally
> not `pub`.

I think it should be `pub`. Otherwise we're loosing functionality
compared to now. If one decides to give the raw pointer to some C API
that takes ownership of the pointer, then I want them to be able to call
`dec_len` manually.=20

>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kvec.rs | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index d43a1d609434..5d604e04b9a5 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -195,6 +195,21 @@ pub unsafe fn inc_len(&mut self, additional: usize) =
{
>          self.len +=3D additional;
>      }
> =20
> +    /// Decreases `self.len` by `count`.
> +    ///
> +    /// Returns a mutable reference to the removed elements.

s/reference/slice/

I would also mention here that the elements won't be dropped when the
user doesn't do that manually using the slice. So explain that this is a
low-level operation and `clear` or `truncate` should be used instead
where possible.

> +    ///
> +    /// # Safety
> +    ///
> +    /// - `count` must be less than or equal to `self.len`.

I also think that we should use saturating_sub instead and then not have
to worry about this. (It should still be documented in the function
though). That way this can also be a safe function.

---
Cheers,
Benno

> +    unsafe fn dec_len(&mut self, count: usize) -> &mut [T] {
> +        debug_assert!(count <=3D self.len());
> +        self.len -=3D count;
> +        // SAFETY: The memory between `self.len` and `self.len + count` =
is guaranteed to contain
> +        // `self.len` initialized elements of type `T`.
> +        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr().add(self.le=
n), count) }
> +    }
> +
>      /// Returns a slice of the entire vector.
>      #[inline]
>      pub fn as_slice(&self) -> &[T] {



