Return-Path: <linux-kernel+bounces-381186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD2D9AFBAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACACB22F83
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7761C173D;
	Fri, 25 Oct 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+QcQpMp"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C71B6CFE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843095; cv=none; b=Zpbou3Ged0TPhCtpe1w+ZYZ/kOlYYt6JXJGZx83NEd53ICe0fx0mofzKDebnWFYRJGyBhXIUZ/J0HU3cnuZcxuoAZzp+WtKR+dmzsPIatD5PPUwoiQf2UdTkmA+BnSqZYzQUDG4ciYqlc7levkdvv1aPrF89rWmR1ULPcAuwtuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843095; c=relaxed/simple;
	bh=F3OTFb+Ka41zug8DD/JcTMAO7la9WvVw47fnZrElHRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFCLq+fQFUibaC8yiYkgeS/nESaR4nHeEm4q/CJQC1Zg8TI3ihkknia2tFxlIj+vZiE/pwmJLzwBjGvqu3E/9UobVcUqzjAH9ptQB/+K3DC0CltGkKNPnUqIMnWirEL+cejpwz8eSf6qGbD6orLcEM++cgSXJgCDrbRb65glAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+QcQpMp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314f38d274so23179535e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729843092; x=1730447892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvsJwj5OC8LoQ+z+43ue0ktqi67sFQ/7TMkfuB2TfQo=;
        b=X+QcQpMp9R0Il4UDJLXKn646bF8DoYYK6PYSys4kmeM1g84HVKd7donhyxVk4yahuq
         MxxuBFyrdVbImuvWKeS/c/0gJpPzqghaLWJ5hR7/uxRsm3y5b8iri5cUrFxnpthZNzqe
         6a/Cpb3rYndPW9ZSyRJck0pLhNdenI8mG0HayCzh13WOyeDwTey5oFpyJjsNOD3TTEJe
         e8RVlzTOiekbNXRPP/cn7PCOanPChj99omTp4CKfmK4U1YzDkZ6511vGCvkmsXeXLM1r
         SC7DvUOz+z0QliPihKpb8NoabchbTmVdCgvph78vGn+dY7fepH6Ma9BH+NDosLJotqrr
         w8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843092; x=1730447892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvsJwj5OC8LoQ+z+43ue0ktqi67sFQ/7TMkfuB2TfQo=;
        b=i0VKYF2wv2VTiPxeLydRgNHGuPEnLa1BRFaBCK0rNG/4xRSsNJXv6KkmZFcjyb3Cqp
         YmrosLtvdxIdMxGAHWdInPwgneEXqZOaAzWUPp5b/Pyq3AcqZoZjMKbpl53iH7+BTKEn
         SpppWLLV/aNaTvvzF1uTv6xVW3y5oY3onQdJYUtLTKzEWS+4R5b+0uqB/d1I7qBafBix
         S/FtsFRm21dOeNUgDQ0pxdaBHP7Cj6HMUzRHmlrkLgLV9PSNAKyPOBJal67gb9LY79GB
         L0ax1/fqB5uRtuSh6f/IjsHd1X/pb4lDGcmtexpJ9xAyWfRxcMKUCalUTmxoHtZPXTNC
         i+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVphwr7HAeLcDwHnQk404qjDAwaNywR4XkKRPk9W5zy3Q6XMSFBEEzFfZmCopGhn+Tunbr0573tfw064zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7gJJYsCw0fBr9gybZEZV8IDG2+8mGoQkGU47Dh308m2j/2IZA
	nAFRBvxqsVsUUVT1S+FgoxOzQBFbsVkJDoUIVweFl1ZzvcExDMPea4ri/nXqH029qGmZbc+6mP4
	RO2ow26pdcBe0gfweNV7LN9ZRUNjcx8ATdadM
X-Google-Smtp-Source: AGHT+IF9+NCbOu+bXyKItOLR5RH+FlGastQlQIJxhsNhdaqorYjditBHdDFu9kDS7X1pMearnA6JmaII6gKT8FNLJ54=
X-Received: by 2002:a05:600c:1909:b0:42f:8229:a09e with SMTP id
 5b1f17b1804b1-4318424df6fmr95356955e9.29.1729843092034; Fri, 25 Oct 2024
 00:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-1-330d760041fa@google.com> <CALNs47tbt46VAcT5rm0Y6QBP6kc4ocBFDPOZugthPmNdaHrwPQ@mail.gmail.com>
In-Reply-To: <CALNs47tbt46VAcT5rm0Y6QBP6kc4ocBFDPOZugthPmNdaHrwPQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 25 Oct 2024 09:57:59 +0200
Message-ID: <CAH5fLgj=+aXo3sj9wKJudHYtL5pBHB8AzGS5njWEDzD0wydrOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: types: add Opaque::try_ffi_init
To: Trevor Gross <tmgross@umich.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 6:10=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> On Tue, Oct 1, 2024 at 3:23=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > This will be used by the miscdevice abstractions, as the C function
> > `misc_register` is fallible.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/types.rs | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index 9e7ca066355c..070d03152937 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -299,6 +299,22 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) ->=
 impl PinInit<Self> {
> >          }
> >      }
> >
> > +    /// Creates a fallible pin-initializer from the given initializer =
closure.
> > +    ///
> > +    /// The returned initializer calls the given closure with the poin=
ter to the inner `T` of this
> > +    /// `Opaque`. Since this memory is uninitialized, the closure is n=
ot allowed to read from it.
> > +    ///
> > +    /// This function is safe, because the `T` inside of an `Opaque` i=
s allowed to be
> > +    /// uninitialized. Additionally, access to the inner `T` requires =
`unsafe`, so the caller needs
> > +    /// to verify at that point that the inner value is valid.
> > +    pub fn try_ffi_init<E>(
> > +        init_func: impl FnOnce(*mut T) -> Result<(), E>,
> > +    ) -> impl PinInit<Self, E> {
> > +        // SAFETY: We contain a `MaybeUninit`, so it is OK for the `in=
it_func` to not fully
> > +        // initialize the `T`.
> > +        unsafe { init::pin_init_from_closure::<_, E>(move |slot| init_=
func(Self::raw_get(slot))) }
> > +    }
>
> [1] adjusts `ffi_init` to use `try_ffi_init`. Maybe this should do the sa=
me?
>
> [1]: https://lore.kernel.org/rust-for-linux/20241022213221.2383-2-dakr@ke=
rnel.org/

Ah, I wasn't able to find previous patches for this, but I guess there was =
one.

This patch has already landed in char-misc-next, so this can be a
follow-up if you want to change it.

Alice

