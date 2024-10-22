Return-Path: <linux-kernel+bounces-376699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9FF9AB4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37694283D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14131BDA88;
	Tue, 22 Oct 2024 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TAtlxhGO"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2AC1BC091
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617894; cv=none; b=kOr/zpaNbUzFcYwUX+bwCLUPM6tKXu3vHC2UoLVpzjjUbTcD5Hvj4pgz21ssSZQolBXDPFQpCRHfFWUlGglvfLJeDGUd+kvOQcyYSkHVmI53elMKsbAD1oxJ7m+V/i5RxBgG2qGZC9lBEDvV+hL7MIzlE4sZH0YZkuNXLuncBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617894; c=relaxed/simple;
	bh=xwc23gWqC5d98YMWFqF/Xhb3SJe/ZnUf9483lyiAdvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syvBTSU3SOmTQVs8iMpC9w1+X1Hv7m5YfUyXoC8nr0/1VKCKuN5hAKAs5mEPxXYGhGSTD3VhaEXpUtGv0YsM7cymRAjZAOURi2xawM2bkpwYCrRVO84vYYbDcPZ/n5hUHfBHDLJNPfqM+tOB9YJPkGiJHLXh/Et0AEaFHRHyxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TAtlxhGO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315baec69eso54926935e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729617891; x=1730222691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEt47/5AYkkm+7sRkURZTwcxLPliTpnnCDYwMEIuRCE=;
        b=TAtlxhGOiGMbHWybwE62zXrXtGXrL4eN9G3vv58bmkoSmpyb+NSFSlFuvbdUcbsD+E
         zR3BT2AVk8p2j5k9/GJgYlzc3zdIWw7cdbdWSgNteOdOexVKHnb7UDIfUESF8yVSo45s
         qbXuxoN9z3xBrJ8J8ImlNDh78LCvhFHq93BJrWg4tCEQg1cUkdQZ9kDNy9N+lyK5kH8x
         Eopt4rCE9jRKlJpsppQHCRxAuNv6f9jmKoR8H8XseOxgvhm8r0wddzHfuAIeltGlwmHZ
         h3+wrHK2pRnNPjSIin/gWYWoAopXH8NsKW9zjOuIWWtU/Cb0R1fGQIXgqV6ZZDT1h0DI
         r0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617891; x=1730222691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEt47/5AYkkm+7sRkURZTwcxLPliTpnnCDYwMEIuRCE=;
        b=eI9LKVILP7rHoHaihF7vK/1o3G0gIVBa6RC/BW3H9p3ASLi3e2XYTG4myT+83St4qY
         1GQg18gzQdca6Hvbc78JFyG/uQNNVa5RMa/qgW5kcc68KRUdwpz3yJQIE3PCmOnNu3ZU
         hSZhkIfkSRva1xxnHc6JucLdLoOcWD++PgUcnTJYtK1MOcNuilxe86rcTx0Wtbxwo7e7
         y0bEvQX99iYEBFE5phc1bkxSuskEPsDCpFPp0cz57HCooeDLduCEqHS8TMAUQSlO5YYz
         uoFOYIMOvJmA6HHAvj4MfaB42FCYP0rlUo9eoYG+jjPwjCLQTFM7aNNjVQ9Kzq+YKNMl
         ZKPg==
X-Forwarded-Encrypted: i=1; AJvYcCWimiN7LljBdVL3rzESp9XPtaVpLCl7X/8zo5Sya67sccwZzWIDogxRsU5oj7y/Vnp+6oLXtmjwCTcEFNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIA6p5TTBg2DtZe2TOX1wci4WUYXRCk+Qk/K5GbzPiLMwml67m
	VZpOfIAPoM8yto0zDjTwz4RAX2hPju3PjygyIvLllPm0BkLmMje9+NKGP2O9uanFe7hMy8t+Usz
	YUUsvW1NZFzrMDKxY8r4kyzLF3nAn9LMDx4di
X-Google-Smtp-Source: AGHT+IGmXY2PcsYCDDDdMG2hgteb25/thWXJMg5ZQZjESPJOsd2kGa1X9jjQZfEia+y8Dt4u8IqR2iRrDoHqsyEWFJA=
X-Received: by 2002:adf:fbce:0:b0:37c:d244:bdb1 with SMTP id
 ffacd0b85a97d-37efb7af8afmr181342f8f.26.1729617890704; Tue, 22 Oct 2024
 10:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-static-mutex-v5-1-8d118a6a99b7@google.com>
 <ZxZxzjEaSZ8e_6mn@boqun-archlinux> <CAH5fLgg=Hb5NDaQQJW4SVh+hCj51bp+BzCMQs=Pg_L+_MMiZgA@mail.gmail.com>
 <ZxfWglfYr52xTIO4@Boquns-Mac-mini.local>
In-Reply-To: <ZxfWglfYr52xTIO4@Boquns-Mac-mini.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Oct 2024 19:24:38 +0200
Message-ID: <CAH5fLggv98iPAPm=PPa686osmfjqcdH9D3wD47ytCqkqbgwx7w@mail.gmail.com>
Subject: Re: [PATCH v5] rust: add global lock support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 6:44=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Oct 22, 2024 at 02:46:19PM +0200, Alice Ryhl wrote:
> > On Mon, Oct 21, 2024 at 5:23=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 01:17:23PM +0000, Alice Ryhl wrote:
> > > [...]
> > > > +///
> > > > +/// A global mutex used to protect all instances of a given struct=
.
> > > > +///
> > > > +/// ```
> > > > +/// # mod ex {
> > > > +/// # use kernel::prelude::*;
> > > > +/// kernel::sync::global_lock! {
> > > > +///     // SAFETY: Initialized in module initializer before first =
use.
> > > > +///     unsafe(uninit) static MY_MUTEX: Mutex<(), Guard =3D MyGuar=
d, LockedBy =3D LockedByMyMutex> =3D ();
> > >
> > > Thanks! This looks much better now ;-)
> > >
> > > But I still want to get rid of "LockedBy=3D", so I've tried and seems=
 it
> > > works, please see the below diff on top of your patch, I think it's
> > > better because:
> > >
> > > * Users don't to pick up the names for the locked_by type ;-)
> > > * It moves a significant amount of code out of macros.
> > > * By having:
> > >
> > >     struct MyStruct {
> > >         my_counter: GlobalLockedBy<MyGuard, u32>,
> > >     }
> > >
> > >   , it's much clear for users to see which guard is used to protected
> > >   `my_counter`.
> > >
> > > I prefer this way. Any concern about doing this?
> >
> > I think I came up with an even better way of doing it. The macro can
>
> Cool!
>
> > generate a dummy token type for the global lock, and then we can have
> > three types: GlobalLock<T>, GlobalGuard<T>, GlobalLockedBy<T> that are
> > all generic over the token type. The token type is an empty enum with
>
> Just to make sure I understand it, so let's say the token type's name is
> `TK`, you mean we have GlobalLock<T, TK>, GlobalGuard<T, TK> and
> GlobalLockedBy<S, TK>? Where T is the type protected by the static mutex
> and S is the type protected by the locked_by type?

Something along those lines, yes.

> > no contents, but implements an unsafe trait saying that there's only
> > one static using it.
> >
> > This way we also do not need the helper module, as we no longer need
> > to generate a struct with private fields.
> >
>
> Sounds good to me. Do you plan to let the user name the token type? It's
> fine to me, or do you want to name the token based on the static lock
> name?

The name of the lock has the wrong case, so we can't really reuse it.

Alice

