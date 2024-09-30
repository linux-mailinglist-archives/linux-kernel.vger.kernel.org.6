Return-Path: <linux-kernel+bounces-344488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21BF98AA57
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CF8282945
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76A519342B;
	Mon, 30 Sep 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJXgSy4q"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACCD7DA79;
	Mon, 30 Sep 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715239; cv=none; b=MV9OocNV80hiillPsTJXeP0dQUXUTZp/e8fOZjgqydCoYOUmo//07l7l07JZgY43/mIE5aR7S1jWnZr0EOYdzaWRMYiwfBGUjGyIVJC9P48By6nBKuClTINLRF6HOOeuhqrb6FQhT0x4tiK5VqEDTYHJLnpcsQ7RD9qpqBTZnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715239; c=relaxed/simple;
	bh=0jEjwOj39v8AX1z62M0s8y45t+nJq9agM39PaCwLVNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOz4Go7F5n5byB4EULDJrj+8RDN8Q+bdMj4Cp03pN62yVHk4FIfCmqhB+YwYG7Dsr2PCnpQuQfXSCnKh2ijkag0lFkn0uVW9M1ADrKiICL1/dLQzsonaSWWW/sCDzHumxcIryTdoxXcGOfA/YdoJp4SkZJX0nr68ct32LK3LMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJXgSy4q; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e56759e6d7so2708962eaf.3;
        Mon, 30 Sep 2024 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727715237; x=1728320037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zupUM8OlcgcmKdKkm9w6ez3z3K6N/QOFr4MtKpE12t8=;
        b=JJXgSy4q7SgONuqL+4rFAd1dMKQZYgUxEO5eSxHJ3NJD45noxGOAdW4PBrJfF3WQRI
         Igs5dEQ6bsQX77dQpCX6uuuQH3CPVsWDAE0992/dI1tsbxiY+HUa4IPzdNLacu9nLfXs
         eS6i+jUH2aJmIuaoVri9Jn6RCu0b/3USdbGDu6WficrPOcKs97iIstcs3IQa80PUtCTW
         uJz6KtMmBzW88/JEiYvLYi2f71uTJgLLoNyUjErQKs0bGlnUIaKokYBdPzVMENCMp4yO
         b4ZdI2oLXBiEZYNeawWxfmBimkgtP53qPZs4YR/gPfu0W6pcWDRlvjCke8QAnpKSjAX5
         c+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715237; x=1728320037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zupUM8OlcgcmKdKkm9w6ez3z3K6N/QOFr4MtKpE12t8=;
        b=RVj2fdyj/nmlvBE/tusvv5IKUpY1kuGfbGUQT1VqmlNJ+78KtaCQryrUqS7ZJyXiiY
         2r05f1sLEi36F7iL0WjYQo4+vKw7fwI3gXtUbMUbznksMg4x9gjpzoOrnnjvqu4vPhp6
         ju0vWAZdzbBWBUJrufHRMZ1mGFgVvKRa80SgCGgEAHTE34M804fvo/7ZLK5rUdSGOiZG
         aLEPdp/BDsHHMLNMvuTCaxEf0vL6gPj886FiwVFjGr/9sR/pDUByJKA3350H9tAcElXQ
         iEPmNR35sVF9u2DxXiSSeGtQkesZ7CO5qv0XKoZzcetd1Ou57JH9FFwVBWPUz7VUhK7q
         bUbg==
X-Forwarded-Encrypted: i=1; AJvYcCXAhFi6xUZEOpV+HGsxEHSiYMO0FEwpzdQuwtFO2o73Qu36iBv1JNAPWqFDusIMW6mD0cx7ATkuJlJLXwuqwN4=@vger.kernel.org, AJvYcCXwVDX8pbVnfZMpHOmD0XmCiii/G9PR8C5w7olHRm9yhnsHusRq3OCUF/prRIOKXdC38LGw7sHKqn+tfdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwALXfBULwHsmAJoLo4nSxq/w+xghjgB7vhET6rowgTW8rhe0Fe
	9AkjCrF3JYk3OCtRMurucOpUO7WNtDLDETiKCvOdtKZt2+uM8Px18Euq7RcWnkVYarmMYhQS8gx
	mYEY3mXwXZTWRO3lrCEBe9HJSVCE=
X-Google-Smtp-Source: AGHT+IET3vIzd6yKV2seaWJneHCfLlfg2Qk/op/xMpkFfaPUxIq0mhmLcm+mCRHwYBgisR/B9zrW2wqmpUG41ZxBd74=
X-Received: by 2002:a05:6358:8aa:b0:1bc:57cf:40bd with SMTP id
 e5c5f4694b2df-1becba07c62mr524382955d.0.1727715236749; Mon, 30 Sep 2024
 09:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930123957.49181-1-trintaeoitogc@gmail.com>
 <20240930123957.49181-2-trintaeoitogc@gmail.com> <ZvqkAuxWZIMZshN_@pollux>
 <CAM_RzfYXWJ1ePZk7-DFR4P--F1pyzWg8bnC40mbLWaHpx_aNJA@mail.gmail.com> <Zvq9OqEu0yN1Ahgq@pollux>
In-Reply-To: <Zvq9OqEu0yN1Ahgq@pollux>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Mon, 30 Sep 2024 13:53:20 -0300
Message-ID: <CAM_RzfZhMey0u75+M1-hcek6QutS6H9kctpChQ+6g3juSJy5Tg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] device: rust: change the name function
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	mcgrof@kernel.org, russ.weight@linux.dev, dakr@redhat.com, 
	a.hindborg@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Mon, Sep 30, 2024 at 10:52:27AM -0300, Guilherme Gi=C3=A1como Sim=C3=
=B5es wrote:
> > Danilo Krummrich <dakr@kernel.org> writes:
> > > > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > > > index 851018eef885..ecffaff041e0 100644
> > > > --- a/rust/kernel/device.rs
> > > > +++ b/rust/kernel/device.rs
> > > > @@ -51,7 +51,7 @@ impl Device {
> > > >      ///
> > > >      /// It must also be ensured that `bindings::device::release` c=
an be called from any thread.
> > > >      /// While not officially documented, this should be the case f=
or any `struct device`.
> > > > -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Sel=
f> {
> > > > +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<S=
elf> {
> > >
> > > As a follow-up, it probably makes sense to also change the function b=
ody to
> > > just: `unsafe { Self::as_ref(ptr) }.into()`.
> >
> > But if we change the function body that is suggested for you, the
> > function will not have your own refcount. If I don't wrong, the
> > Device::as_ref() expects the caller to have its own reference counter.
> > And if we change the behavior of function, your name don't need to be
> > changed, because your behavior will be equal the from_raw() from
> > standard library.
>
> I think you missed the `into()` above. This will convert `&'a Device` int=
o
> `ARef<Device>`, and also call `inc_ref` from the `AlwaysRefCounted` trait
> implemented for `Device`, and hence increase the reference count.

Okay, I understand now that the .into() call, also call `inc_ref` that I
was don't have knowing. This body change of the get_device() really make
sense, and I will send a v4 patch.

Thanks for this Mr. Krummrich.

