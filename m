Return-Path: <linux-kernel+bounces-244900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BC392AB2B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487581F225FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70B14F105;
	Mon,  8 Jul 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0pc0Vv7"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0714900C;
	Mon,  8 Jul 2024 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474157; cv=none; b=XMe2PrXGWKdd2DFEYw/lLcrdEUgrXL+cy4W7ndFgbSt6T7lG2Ghw7Z75CakUzNHLN3QqOttoSwhmng99Bf2JT/M0/GfW6rKeTk3Qc4brxN3TP6FG+PHNcAF0hlWkDDYVx1F1q68KzzslnDkaLoOdWkaL6v0aaMQagKyZv9SkhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474157; c=relaxed/simple;
	bh=xeBNkjWne9In5zATuo6T4QppMdz0GTE1KgR0eO+Y9tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL1st/5nAVltDPdfDulrFszmTGTUWUY5X7qwao+EH8PUSu64YWc5IuOYuiN9z2i/0cP7aVtyyVWqwy9qRZrHPd6lIApjSli91rrv/jmVMLXTVOoO1HliXBRdQ3YVadKLVctCd5qYGrHDA3Cj5UM8j+77tkpFtBq9au0Ho4miF48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0pc0Vv7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79f178e62d1so48358585a.1;
        Mon, 08 Jul 2024 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720474155; x=1721078955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPXeqS144wag80EgyVBckCNnTJy8NLX4sL/P+F5UtVU=;
        b=b0pc0Vv7GhD6MM/W62cqOtJFL55qJk/c6tqpNsYGQxKwxVwpRzBmgoPVpkxavBSvHo
         jYA8Ckct1tZLAmxqnrqaCqfgCActZSEedfyIIx2D7pi6qIi0+DWqg9poR5yGsHDsT9jA
         MzgUlNEolclPcldugSKF+O/bUxRDBunKomWqhxabJPXRcDjdfx8ypq/v196caI/Ny3hp
         iVcsf50LF/eDHfEsdgfVPxNBBi1BV800gHW15fgfZJ5Cpuu4QrzqNCLK83yycnEszSyO
         3m+nW185ackazDgo4MN8w1A//9dRjjRBSHOuOatAcEUqQWxJFnrPhAgEJcBKY1NjdXo7
         A8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720474155; x=1721078955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPXeqS144wag80EgyVBckCNnTJy8NLX4sL/P+F5UtVU=;
        b=s3Ouz7y6VNZammkayJDlG4w35i8SW0pDz52s7mvIqLZFs9yvjP+/HLFaUMOzbSlD0k
         LrwZGqstzzrT+7SpOC8eRoZPJJWMtTjtRDbpoTgiaJCj0nlC7nD/ezkyyBKExgbwnnxt
         k9HNQQxRFNYDQEKtyJ2GZfI29fU8r66uKizgQi0Y+iVcU8rCR8un76f2ML54oAdVXPlz
         p24918lrovmgsGb7gz01ixMO29Z9lLHhf0EDhITEoRnWMwLPOp9KlMLwM7h8iBAmZnmR
         xyNQGNNbaPGLE8LwsMV4ahM71GBjzt67rFs7C9OeLlIm950p+PcDgdRmd5ZCP+zXflnY
         2kbg==
X-Forwarded-Encrypted: i=1; AJvYcCWYZJbLqllqu6wghA477O8nqq+ordgFWVyyISX5q3umeu5pd5uv66y+RAvspka8SvT1Fu47j9zF9rhsGJUx5RI3TgJqjZW4CB/lB4HNoleq90fc6MLW/u7o1GdvGAuhSqFhRkGjusNVQTZP2Rc=
X-Gm-Message-State: AOJu0YyRz48oSZ67f5VEcjf/naiapd/tuoBH0d7ZXad+gfWjcGOn7g7z
	4xU96Slry7XSXd5FOy9dPoc15m/b1OS6YiyI8n8mc0hAfpbX/cGk
X-Google-Smtp-Source: AGHT+IFS9NsuzsGdab4p/3fKlkLxhvMyIlGAEERWcNCT3Os54UNxt4pMHNWm9FNNaThLz1S3V/AepQ==
X-Received: by 2002:a05:620a:2147:b0:79d:6579:8853 with SMTP id af79cd13be357-79f19adc8eemr72408185a.73.1720474154891;
        Mon, 08 Jul 2024 14:29:14 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190ab741sm29330385a.118.2024.07.08.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:29:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E37F0120006D;
	Mon,  8 Jul 2024 17:29:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jul 2024 17:29:13 -0400
X-ME-Sender: <xms:KFqMZvJuhiAup1oMPf5IYocfG-irCqZGfdnVIVKFCXuspeoQXPJ2BA>
    <xme:KFqMZjLF-At4HG-Gwz37ATAFcJ869Q6OpwY16o0hI412ormbnOFGoQt83mudQB8JG
    3VRcRtKOCGQXVvlYw>
X-ME-Received: <xmr:KFqMZns6j7du0fAKGHkR0D5TXimuhZ7hAju7klx7EeXuA5zh1bNp8vLPHyZzXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:KFqMZobUza5O8zuG6UkLeI6-GTVjESTnvIP2lA2WZ_0uSMrfTANLew>
    <xmx:KFqMZmalX7YAhicWnch-wCWh8lGm2Cmb4PU7be1bpVEuXvVpLrY_Jw>
    <xmx:KFqMZsCsQQSB46gp9q0BRLAG7c9WfXDhp8hhs_QpWh5_kConqJSY4Q>
    <xmx:KFqMZkafyASu7OiivRezW3-Dvt2Jio6HqV8dsebHJbNdnbVRaOGd1A>
    <xmx:KVqMZqqBvdmWF7T4Boe8hGgOafyvTECXgd3yJEnhwD4ty2c-qwTcNtH9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jul 2024 17:29:12 -0400 (EDT)
Date: Mon, 8 Jul 2024 14:27:55 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: init: add `write_[pin_]init` functions
Message-ID: <ZoxZ261bwtWCj8fn@boqun-archlinux>
References: <20240708205325.1275473-1-benno.lossin@proton.me>
 <20240708205325.1275473-2-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708205325.1275473-2-benno.lossin@proton.me>

On Mon, Jul 08, 2024 at 08:53:46PM +0000, Benno Lossin wrote:
> Sometimes it is necessary to split allocation and initialization into
> two steps. One such situation is when reusing existing allocations
> obtained via `Box::drop_contents`. See [1] for an example.
> In order to support this use case add `write_[pin_]init` functions to the
> pin-init API. These functions operate on already allocated smart
> pointers that wrap `MaybeUninit<T>`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57ad3f5bc592@proton.me/ [1]
> ---
>  rust/kernel/init.rs    | 84 ++++++++++++++++++++++++++++++------------
>  rust/kernel/prelude.rs |  2 +-
>  2 files changed, 61 insertions(+), 25 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 9608f2bd2211..35c4d9b75a97 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -1159,13 +1159,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>,
>      where
>          E: From<AllocError>,
>      {
> -        let mut this = <Box<_> as BoxExt<_>>::new_uninit(flags)?;
> -        let slot = this.as_mut_ptr();
> -        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> -        // slot is valid and will not be moved, because we pin it later.
> -        unsafe { init.__pinned_init(slot)? };
> -        // SAFETY: All fields have been initialized.
> -        Ok(unsafe { this.assume_init() }.into())
> +        <Box<_> as BoxExt<_>>::new_uninit(flags)?.write_pin_init(init)
>      }
>  
>      #[inline]
> @@ -1173,13 +1167,7 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
>      where
>          E: From<AllocError>,
>      {
> -        let mut this = <Box<_> as BoxExt<_>>::new_uninit(flags)?;
> -        let slot = this.as_mut_ptr();
> -        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> -        // slot is valid.
> -        unsafe { init.__init(slot)? };
> -        // SAFETY: All fields have been initialized.
> -        Ok(unsafe { this.assume_init() })
> +        <Box<_> as BoxExt<_>>::new_uninit(flags)?.write_init(init)
>      }
>  }
>  
> @@ -1189,13 +1177,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>,
>      where
>          E: From<AllocError>,
>      {
> -        let mut this = UniqueArc::new_uninit(flags)?;
> -        let slot = this.as_mut_ptr();
> -        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> -        // slot is valid and will not be moved, because we pin it later.
> -        unsafe { init.__pinned_init(slot)? };
> -        // SAFETY: All fields have been initialized.
> -        Ok(unsafe { this.assume_init() }.into())
> +        UniqueArc::new_uninit(flags)?.write_pin_init(init)
>      }
>  
>      #[inline]
> @@ -1203,13 +1185,67 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
>      where
>          E: From<AllocError>,
>      {
> -        let mut this = UniqueArc::new_uninit(flags)?;
> -        let slot = this.as_mut_ptr();
> +        UniqueArc::new_uninit(flags)?.write_init(init)
> +    }
> +}
> +
> +/// Smart pointer containing uninitialized memory and that can write a value.
> +pub trait InPlaceWrite<T> {
> +    /// The type `Self` turns into when the contents are initialized.
> +    type Initialized;
> +
> +    /// Use the given initializer to write a value into `self`.
> +    ///
> +    /// Does not drop the current value and considers it as uninitialized memory.
> +    fn write_init<E>(self, init: impl Init<T, E>) -> Result<Self::Initialized, E>;
> +
> +    /// Use the given pin-initializer to write a value into `self`.
> +    ///
> +    /// Does not drop the current value and considers it as uninitialized memory.
> +    fn write_pin_init<E>(self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E>;
> +}
> +
> +impl<T> InPlaceWrite<T> for Box<MaybeUninit<T>> {
> +    type Initialized = Box<T>;
> +
> +    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initialized, E> {
> +        let slot = self.as_mut_ptr();
>          // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
>          // slot is valid.
>          unsafe { init.__init(slot)? };
>          // SAFETY: All fields have been initialized.
> -        Ok(unsafe { this.assume_init() })
> +        Ok(unsafe { self.assume_init() })
> +    }
> +
> +    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E> {
> +        let slot = self.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved, because we pin it later.
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { self.assume_init() }.into())
> +    }
> +}
> +
> +impl<T> InPlaceWrite<T> for UniqueArc<MaybeUninit<T>> {
> +    type Initialized = UniqueArc<T>;
> +
> +    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initialized, E> {
> +        let slot = self.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid.
> +        unsafe { init.__init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { self.assume_init() })
> +    }
> +
> +    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E> {
> +        let slot = self.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved, because we pin it later.
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { self.assume_init() }.into())
>      }
>  }
>  
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index b37a0b3180fb..4571daec0961 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -37,6 +37,6 @@
>  
>  pub use super::{str::CStr, ThisModule};
>  
> -pub use super::init::{InPlaceInit, Init, PinInit};
> +pub use super::init::{InPlaceInit, InPlaceWrite, Init, PinInit};
>  
>  pub use super::current;
> -- 
> 2.44.0
> 
> 

