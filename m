Return-Path: <linux-kernel+bounces-435595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058189E79EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D599616BEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0BD83A17;
	Fri,  6 Dec 2024 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e47uUW0U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594261C548A;
	Fri,  6 Dec 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733516248; cv=none; b=nW9dm0AKgj4LVVSlCuqx0vrXh7QL37ihPlCCAytwRkJESKwvdJd4TMo7VOh62u4IzAlImjHf2wtYxB3O+RnUL9+G/vNqQwlvCNL36TfGo4mpHcXDgD/dcKCQtCw52qGCY79ApXnhYtKtL6AeTPObVOUUqGNfffSHrdue5+xhrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733516248; c=relaxed/simple;
	bh=KDmwUVqmo5/GFM8WAK/kNQMfrXHTIB5cC1zlRdTJc/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GATE4vJV0DEph0D9eiFeEKQftt6F1Cb5LF+EK2hTgF7QgO2ByltTiTx4VbD+xLVynxQ4ik3dI+5mkHS/62iIGkCbEXo5Ffl6hSTHQCbkAf3IQZgLh9G1U0rUqZhnp5e5go3B4UbEOPDSLU5NFSaViTwhsSKLFLmysr0dY0qjWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e47uUW0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEE0C4CED1;
	Fri,  6 Dec 2024 20:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733516248;
	bh=KDmwUVqmo5/GFM8WAK/kNQMfrXHTIB5cC1zlRdTJc/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e47uUW0UqS3wwJhEvQuMssxn7vLOOo9MFRzyUrWWMAMpYOHgnEwM2fnS2TgLb9+P0
	 8osQZqyVyUDLRVHvwZ5EnBV4Xo44PZH1TGY+8A44/PrL32B8K/M3UaNS9yY1y/EUin
	 fGGSKlZ4aRwux3o7DIVRMbYbqlqoVk23GaYHVYcvCK7UqhVD9hSy9ddlYE7TWaZeBR
	 HUeUK6jfpr/4/pkZfqv00b+o9clWmHl+u1zOEs7S4u7hSzn/BOkHZkepEaaZGX6Wwf
	 EuXMnna6ktOa5fH0tN1QhgwkvH2aewTEuN/BuCtXYKpPON+kIlwOifQL2akhlyUXTu
	 2eISW1FRkVHdg==
Date: Fri, 6 Dec 2024 21:17:21 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/14] rust: alloc: add `Box::into_pin`
Message-ID: <Z1Nb0dQvO0GKlMmb@pollux>
References: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
 <20241206-hrtimer-v3-v6-12-rc2-v4-10-6cb8c3673682@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-hrtimer-v3-v6-12-rc2-v4-10-6cb8c3673682@kernel.org>

On Fri, Dec 06, 2024 at 08:33:02PM +0100, Andreas Hindborg wrote:
> Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.

What do you need this function for?

There is an `impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>` already.

> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/alloc/kbox.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 9ce414361c2c6dd8eea09b11041f6c307cbc7864..1a993ec8602b37041c192458d8b6acff30769a04 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -245,6 +245,16 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
>          Ok(Self::new(x, flags)?.into())
>      }
>  
> +    /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not implement
> +    /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
> +    pub fn into_pin(boxed: Self) -> Pin<Self> {
> +        // SAFETY: `Self` is guaranteed to be the only pointer to the boxed
> +        // value. Thus, if `T: !Unpin`, `T` is guaranteed to stay pinned; there
> +        // is no way to get rid of the `Pin` and move out of the returned
> +        // `Pin<Box<T>>`.
> +        unsafe { Pin::new_unchecked(boxed) }
> +    }
> +
>      /// Forgets the contents (does not run the destructor), but keeps the allocation.
>      fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
>          let ptr = Self::into_raw(this);
> 
> -- 
> 2.46.0
> 
> 

