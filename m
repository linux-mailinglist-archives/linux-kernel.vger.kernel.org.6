Return-Path: <linux-kernel+bounces-277588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E80494A369
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167EA1F2133B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B71CCB32;
	Wed,  7 Aug 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzjZGlae"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CA1CB304
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020647; cv=none; b=DMGH4JomUdhVglQuUqht210LrIK2FVvvfkdB7RwbA28Xevyu9AKhprdk7XZFPbVNKotQ9OcxWif29j23iElXC+GDze1UMT7BuqyngHtd8e6R6oDVVVReTNIDttNfljPBuRzh46LyjkGiDwWHF9yJCb28jdWcet30B8/H7h7FpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020647; c=relaxed/simple;
	bh=0UtNcQiBJHj5NT3vENREIzfZcUewciu8UD/RmQsY0WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/S8KxZUhwEJYTm/J6Fy0Rr0rMS7SwIgJAKhB8H680J7AbGEeLJj4qiapv/Fi0mRInJ1zgJzu1zzIEeAwyeOPbaJx/y1yxHiM3MmVi5pi1QDLy5ub49ylMZhsYC+iYIW2T8utwB98355BEPxq8O1UOPslBBrfKLQ1GtCZdKCd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GzjZGlae; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f136e23229so16154241fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723020644; x=1723625444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6uGG/bPgpOPhR7OkqXBHMSIeIgp9LFX//Nhl/4vdqg=;
        b=GzjZGlaeBVpzHighw8MHNjfOWpidJfcdKgNPykjrbsmaMXelJPExRjFoYlInPR+W8U
         DNkwkBWDrxQRMhvmk+TH3+TMCHZF4g4lL+xjtJ4TGfMnXCt1L8G8Wo/wjIfHcxWO2AVL
         iRfaQSsl37T1dEb9ODAgvzLWEyuYL30nPSzwq9PjyxtdqexvHiYVsUjp6UFr75mRZQ10
         RNfAWzJ2nmAYgjjLAl/P8lKHuDBVCjx0yDXqi9jjctPWJWBvPA5EQEG4IU6onjGA2afW
         vy1WBeqka9JfMXScinDzeMwJuZ7UBOnlES6prUz36YmGHwVLo7yypu/FijzZGf2ptRmc
         c47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723020644; x=1723625444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6uGG/bPgpOPhR7OkqXBHMSIeIgp9LFX//Nhl/4vdqg=;
        b=eAHVJ/KWSwmxJZpUOnNDWeuOy6sQMDDnV3z5hk7XOkXQ0qTxn6aMviKyDypwIYywkn
         eGP6wXUnU+lmCkhOeQ9azoqgbI/okceL3Gof/CvRqpdCcuuQTYTS49Lc4DCQ6QWDLXOY
         MTav0TcSWzYD4GZrvzKBve0D1j3ldr8eYENJiVkQlthyhETZF116ahilMJz6xMalz526
         GYU5py6PD2KXPg/qvxGMO4E87ttS+RL7HkTCWCFRhUPRHGKYaP8geKZO8xeEfu7sKjPa
         qG7YbNf1fvyREb9AziBY++YKWtQvhf5u7up6zX7zMdFdttHtaqcpRiT6NMSIp6AaCg4T
         RtKg==
X-Forwarded-Encrypted: i=1; AJvYcCUaEtslI3R7oI2BXCUDX9RvKZ95C3XVDURNKb0C4dXPLuwg0VwMk/K1uXBTg3DX5HUxC9MbgY8JK0XcQKUKyYCgjTHdpskWHptIBt0M
X-Gm-Message-State: AOJu0Yx/6fdPytm8KYipv/14js1aR/6bqG/T9/QzsAmFt38Tqr/R/ke4
	hAm3LOFeeST6vFBGG4PJirnFqRrRrlt6JCWmhwtxhPgoN09TvsiNdqHKI5P2fCk+t4Ql/UUmpo4
	VN7xY0JrTj2q/BSV8TdkXUHh8MLdI51RGjMH6
X-Google-Smtp-Source: AGHT+IGccCHlno0tQbb4yPLv0HzWQPlEIf88SJrHYSG7o6Dmgd4Psom8noOTBXPXyYsqb4J1FgwIajAF4YxG75Q1TCk=
X-Received: by 2002:a2e:91d0:0:b0:2ef:1c0f:d490 with SMTP id
 38308e7fff4ca-2f15ab0c2a1mr126113241fa.39.1723020644050; Wed, 07 Aug 2024
 01:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
 <20240725-alice-file-v8-3-55a2e80deaa8@google.com> <4bf5bf3b-88f4-4ee4-80fd-c566428d9f69@proton.me>
 <CAH5fLgi0MGUhbD0WV99NtU+08HCJG+LYMtx+Ca4gwfo9FR+hTw@mail.gmail.com> <ZrJ5kORJHsITlxr6@boqun-archlinux>
In-Reply-To: <ZrJ5kORJHsITlxr6@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 10:50:32 +0200
Message-ID: <CAH5fLgj2XEvjourzW4aoRDQwMGkKTNiE7Wu9FVRrG=7ae1hiWA@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] rust: file: add Rust abstraction for `struct file`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:30=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> On Tue, Aug 06, 2024 at 10:48:11AM +0200, Alice Ryhl wrote:
> [...]
> > > > +    /// Returns the flags associated with the file.
> > > > +    ///
> > > > +    /// The flags are a combination of the constants in [`flags`].
> > > > +    #[inline]
> > > > +    pub fn flags(&self) -> u32 {
> > > > +        // This `read_volatile` is intended to correspond to a REA=
D_ONCE call.
> > > > +        //
> > > > +        // SAFETY: The file is valid because the shared reference =
guarantees a nonzero refcount.
> > > > +        //
> > > > +        // FIXME(read_once): Replace with `read_once` when availab=
le on the Rust side.
> > >
> > > Do you know the status of this?
> >
> > It's still unavailable.
> >
>
> I think with our own Atomic API, we can just use atomic_read() here:
> yes, I know that to make this is not a UB, we need the C side to also do
> atomic write on this `f_flags`, however, my reading of C code seems to
> suggest that FS relies on writes to this field is atomic, therefore
> unless someone is willing to convert all writes to `f_flags` in C into
> a WRITE_ONCE(), nothing more we can do on Rust side. So using
> atomic_read() is the correct thing to begin with.

Huh? The C side uses atomic reads for this?

Alice

