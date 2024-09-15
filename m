Return-Path: <linux-kernel+bounces-329879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71580979706
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEF82822DC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302401C6F73;
	Sun, 15 Sep 2024 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bl8B3+sb"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3771C57BB
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409533; cv=none; b=XRiRA26ebFOiJ5rIlVLkNnbLFdybl32aTiir75lhgW/x6ZNpw5Kka+h7vHq3AXp4SxF/HqiHIeqzDSkvte+dZCZLDjZOted1S+3dvPq4BFrxSnYh4G1B5ZZxVPKyObjg6WeB07l1vR/zPq1bXVi4/UnYjal5UygSSZptRTgprJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409533; c=relaxed/simple;
	bh=r5zBW4jZUhZNWoMWeQalIZceyQXecUyHiGiXyQHzAs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFizKCsxK4VuIeTpOeEtWTNA/v12jm7IcsAazwZeNwqGaA2aBih+/Vv91UjuLVkmVutqZlNXGNW6XWY4u2kLXNFcgQ0/jpHp67NYjZ6LeWQ5QyXWS3ThDjSFduLr9d2t2snDoieNuk97SC2LcyJeAbNcIWHwTxbojOeWfHeRBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bl8B3+sb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so2179015f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726409530; x=1727014330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yxz5nmGRzq4N/sr7E3GVipIykhiwk1dNJyYW68ELoro=;
        b=Bl8B3+sb90meq3NlhAtcvAzOzGjPzim9doMwgsMF2hElf/eGMKH5J68dATgQOcozOi
         spDqaL5skQpIBa91NON63BBjn8oHUogo0ZiDb568Z29cB+AyDC83ZoQNFUCiNgXjCHcF
         l/QXavsh4VBvnEBosFMsin7go17aoR0IN/t71dwzVOd2qjBrealxxN1522MNnGjeqnQZ
         C+YNsksXNtW3ya8H9KYDdHRPsQNveueoj2cX5k5gdvue1mkDNXuS5/TR2FW2lmCdENgn
         ayehZKTwg13OJdkGVOoD10DYtjnMJ0OFHEQCSIgeHHjgp72XoTuQaLiGbcxWAY4Bmes0
         sSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726409530; x=1727014330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yxz5nmGRzq4N/sr7E3GVipIykhiwk1dNJyYW68ELoro=;
        b=jKavYS8qHoWiYfKVXkfLvF1doczT16IhVaG7kmfNivyBacBr4pxWPFPHHC/nFnPRqW
         06V3nRH1ygTo83H034c8wnd1nLePuepSD82K0VFg7hu8hisQJwxCwOl3iejSbbrGlUlv
         OFgpKJNZYbP9fG/xM9GKC8sDZCbviDdvpsq3VpchmG/63I4Vbd8QScgfFPU7fttYLSb6
         D8Yx/85zJCVcDY31ft2a30nHF9YHNiOnkoksw1Xdm+zcMRgEI0yNi1vLPRytg4g5yM7T
         XB5HsPRrpPWj7hX8FWLpoD29DqXO8GpWhAQe13y6dLpAJX8zOm094w0E2HnyQ0Ar7zt4
         Vv3w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ7Cfg3FZUGtkSFmgMFdN1MRk4uGteP3t07l8j6GL3iA3YKXMDIlw2uMHxrc8EzITWdyUDWVEsC+G6YeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzucqI2V+MFZNr0RB3p49khx3HSThki7yGBP6B1CIogHwUayywS
	VP52jccTg3NNnyO1aOywnV72r84TRTBMcyTfIkOV+ps606TDSzibvRvwbrgnNZYJG3SMJONhSOy
	E47RxFI0WDYxOnuGHzMG8qrJW8u0TOpdjwnIh
X-Google-Smtp-Source: AGHT+IFYx2WRh//19q1aLbfgfstbMz/qJ1WyjNFbXNIv7xjFUNkkC/3NbCERqsrU73d4amcIy29/C9nVSzXq8QueaWA=
X-Received: by 2002:adf:f6c6:0:b0:374:baf1:41cb with SMTP id
 ffacd0b85a97d-378c2cfedebmr6870954f8f.4.1726409529945; Sun, 15 Sep 2024
 07:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com>
 <ZuSIPIHn4gDLm4si@phenom.ffwll.local> <ZuUtFQ9zs6jJkasD@boqun-archlinux> <20240915144853.7f85568a.gary@garyguo.net>
In-Reply-To: <20240915144853.7f85568a.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 15 Sep 2024 16:11:57 +0200
Message-ID: <CAH5fLggoz5gdgOpEiXu7u9hPXjLLeSv9An6jaq0am0-dG7+ohw@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: fix incorrect Sync bounds for LockedBy
To: Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 3:49=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Fri, 13 Sep 2024 23:28:37 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
>
> > Hmm.. I think it makes more sense to make `access()` requires `where T:
> > Sync` instead of the current fix? I.e. I propose we do:
> >
> >       impl<T, U> LockedBy<T, U> {
> >           pub fn access<'a>(&'a self, owner: &'a U) -> &'a T
> >           where T: Sync {
> >               ...
> >           }
> >       }
> >
> > The current fix in this patch disallows the case where a user has a
> > `Foo: !Sync`, but want to have multiple `&LockedBy<Foo, X>` in differen=
t
> > threads (they would use `access_mut()` to gain unique accesses), which
> > seems to me is a valid use case.
> >
> > The where-clause fix disallows the case where a user has a `Foo: !Sync`=
,
> > a `&LockedBy<Foo, X>` and a `&X`, and is trying to get a `&Foo` with
> > `access()`, this doesn't seems to be a common usage, but maybe I'm
> > missing something?
>
> +1 on this. Our `LockedBy` type only works with `Lock` -- which
> provides mutual exclusion rather than `RwLock`-like semantics, so I
> think it should be perfectly valid for people to want to use `LockedBy`
> for `Send + !Sync` types and only use `access_mut`. So placing `Sync`
> bound on `access` sounds better.

I will add the `where` bound to `access`.

> There's even a way to not requiring `Sync` bound at all, which is to
> ensure that the owner itself is a `!Sync` type:
>
>         impl<T, U> LockedBy<T, U> {
>             pub fn access<'a, B: Backend>(&'a self, owner: &'a Guard<U, B=
>) -> &'a T {
>                 ...
>             }
>         }
>
> Because there's no way for `Guard<U, B>` to be sent across threads, we
> can also deduce that all caller of `access` must be from a single
> thread and thus the `Sync` bound is unnecessary.

Isn't Guard Sync? Either way, it's inconvenient to make Guard part of
the interface. That prevents you from using it from within
`&self`/`&mut self` methods on the owner.

Alice

