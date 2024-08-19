Return-Path: <linux-kernel+bounces-292635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A74695723A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF8AB23158
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB89186E26;
	Mon, 19 Aug 2024 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMm7OSnN"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2215176233;
	Mon, 19 Aug 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088393; cv=none; b=lDAw4aOv25A635S9/+MMDqYg50oK8pxK1V3VMWN6Ju9yJAKscYbYI4vk1XsTPCs68AGDrAkqIRd/NBHiY6hQtPJncvkCnednjNZNqbYV7F73VC7nP0ZPqWPy0BRF3DiD56nER789RDZPwoZhhURuBuVYcpvNSadauzmGomOXlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088393; c=relaxed/simple;
	bh=MoPdvLHesIKzB0czCR2POj913MyZHS5c+CL3vWVexwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVQTclF+st2fHWDcHGjFDziX8RULzZmNzrKiBPe6pV4+ifht6hCRl0Fx/4RRwEfmivtk6u5zAVUFJwNWjwa7QUUTh4Kcjj4E6RGKwamGaczugBPflN/QWnU9aSfFWQ6nQP/wJwj+dYn739ljfGXsaMfRp1mrSOO9R1EiONm13ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMm7OSnN; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-450059a25b9so42373651cf.0;
        Mon, 19 Aug 2024 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724088390; x=1724693190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZiLrD6YE4C/ZCUesz25irk0ZZtPLFdzHeSuDMMGBEA=;
        b=YMm7OSnNNWIrg9Gz7fPZFSWtIRbfCyuZgEvlqHbj2Zr3vnah7LhHBE8da7za2aZK5u
         Z5g+CsauFPTg/ZhXFbwqXzq7X6eISZeNB4y2efbvQCy6/ovacI1+9ify+Wkp+MFtcahD
         0jwSp7Xw+CdqEBtxniS9z3yrpzTpAZpHls+HEiC4EXQ/b7sRVdc34xIahSmTqQEqb6tZ
         /DX9qoa8U/KfEn4rtyu0H9GGLSupm2+rx69vkAd2NT0PzJGX/a+dwUeX+dEvtAxqTVK3
         VmHq4r9jqXTiFt7V++23oVdSgOtFGkVro3guTlWVc+ey2WYl503CmYu8y/whezy2bKJy
         uY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724088390; x=1724693190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZiLrD6YE4C/ZCUesz25irk0ZZtPLFdzHeSuDMMGBEA=;
        b=GRFSUHm1OX3kDaQPxqGVvHV7QCPvd6qFkOAvqdzJHdR4LRRfdLxGHu+8Elj0xBzIR2
         dFKb+j/1nAT73l/LqSUQR3RxNTgtcGjUB6/PbCBWd2FQCqMtdYkwrbWlSqDg8zCWa7B6
         YiDRYv0TSI+qSQ5bE59E9/3+xhGx5S+3ydKpCRxKiFd7kG13ReVfdfKu1WspLrGPckP+
         +UxGmapZbHsfua/SBKkEekfBoHwW//2Oh44PKvEBQd8JmcMsmK1yxCN9yYUVJg4vbA+V
         dl02hR0+OggMqCx2wd2qSZYcYiojoWQLcYS3usRQHDqcAlc15KGGhxtYfFMKe4c+svkD
         adAw==
X-Forwarded-Encrypted: i=1; AJvYcCWONuVSEBISpVvfT8kizo+793SYtLnEoE0fa3Iwq6JKFxLRp/+Wv4K73I9nYcxWoJFLwOsQDv86LOr9EPwJd7wKyIkaALiBM2zUPLf0LqFBvVfGR4SeBUo2YFPQv7Z79JLwOBrETXZj2xjgpB8=
X-Gm-Message-State: AOJu0Yyxhxa2pu10di+ecQnb4oDQZInKV4GLVmP4JlKwkiYbXdsI9cU+
	n3akxxy/fV/DrgSQ5MdTznyzL9+tRko6y63+lA0SsBJS4blkCjRu
X-Google-Smtp-Source: AGHT+IFDdIptDkzfaZx9A2Qj1MYTF20UTKDY4IPc59+IJsG+GFw190QBtULzzmsVsy3si6dMk1L6gA==
X-Received: by 2002:a05:622a:1988:b0:44f:ff65:97be with SMTP id d75a77b69052e-454e5116be5mr6296911cf.14.1724088390458;
        Mon, 19 Aug 2024 10:26:30 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd90c0sm42183801cf.7.2024.08.19.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:26:30 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 9DBAB1200070;
	Mon, 19 Aug 2024 13:26:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 Aug 2024 13:26:29 -0400
X-ME-Sender: <xms:RYDDZuJVoSqrGcSmk6nW-DqO324ZMJJG-O17eQnH_geAYfAUZjdBvQ>
    <xme:RYDDZmK5KIrV7A10UyTtxAB5vDfWTVEHVygW0EWsWuEdfR4w7L5G4PqLnaSriQsCv
    ga0YUoSaqAjX0reSA>
X-ME-Received: <xmr:RYDDZutSnUOGA7rtpZhQldDezXUjYDhDZlfJoVcDywm_wPPAtFeP06OzOfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehojhgv
    uggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnh
    efpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusgho
    rhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RYDDZjbcAqIpbKTxg-CbT9yoUfsh8DKhhmG2SzytGvgPh0oDF754HA>
    <xmx:RYDDZlYLHJ_-ek_TfXtQ54bLSRjbnjqRBgy1tsH0OFA3D33_LlM2wg>
    <xmx:RYDDZvCzTnknXu4DDdEqHZ0dBHnSRPYvorWQ0cEeB2gvVOr0gWX5rg>
    <xmx:RYDDZrbOCdA6UUH2D70lSFbraHtXyOlXnWC9AnnveLvKlkzlkcHQcg>
    <xmx:RYDDZlpUXdBvhbEnTS48DruY3a0hF6xeJ3kp3tRmuxoTSiZQwOmwA6wZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 13:26:29 -0400 (EDT)
Date: Mon, 19 Aug 2024 10:24:47 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] rust: init: add `write_[pin_]init` functions
Message-ID: <ZsN_3wJHineYUL7i@boqun-archlinux>
References: <20240819112415.99810-1-benno.lossin@proton.me>
 <20240819112415.99810-2-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819112415.99810-2-benno.lossin@proton.me>

On Mon, Aug 19, 2024 at 11:24:39AM +0000, Benno Lossin wrote:
> Sometimes it is necessary to split allocation and initialization into
> two steps. One such situation is when reusing existing allocations
> obtained via `Box::drop_contents`. See [1] for an example.
> In order to support this use case add `write_[pin_]init` functions to the
> pin-init API. These functions operate on already allocated smart
> pointers that wrap `MaybeUninit<T>`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57ad3f5bc592@proton.me/ [1]

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/init.rs    | 84 ++++++++++++++++++++++++++++++------------
>  rust/kernel/prelude.rs |  2 +-
>  2 files changed, 61 insertions(+), 25 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 771701805a97..a8068f99fcaa 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -1183,13 +1183,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::Pinne
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
> @@ -1197,13 +1191,7 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
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
> @@ -1215,13 +1203,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::Pinne
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
> @@ -1229,13 +1211,67 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
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
> 2.45.2
> 
> 
> 

