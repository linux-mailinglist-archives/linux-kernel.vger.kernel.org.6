Return-Path: <linux-kernel+bounces-312808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24365969BE7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DA11F23ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0916B1A42C2;
	Tue,  3 Sep 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKorwkrY"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B35195
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363262; cv=none; b=lvJ9HdyKJAgY5t4woA4UJwHggmfnZ5OK8T6JYyRJSYw6GdWrvi+0MLmb4nysxlIqvAkAPbTmUiJTE/BLlB/gKVLg0bwOr+h7Uox+ycnuN2dl0bCGlpO12jX85fzQoZSDfvyP75g8hLyy8O4rYm+ryhii/dgTfqVmbb4qYa0Svhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363262; c=relaxed/simple;
	bh=46XNmUR45khZvA8eAYqDcdhPS16b5Y3YseKtzeiIWkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egLnh5Bb7kCOU1Dyak6PigHlNVoSHOQGOXs4oU+O/wSoEB1y42xWn2iNWohTjlzkekrKjsbxxotMuR8ifbtSNs6sandFgkFZCntPqpyJI3J66Nluve5K2wmVsSt8S8jLwlQdRWsz3xS/2hkEvCMLeNTYy6UoRsVywVwk+A58GzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKorwkrY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bbe908380so31621315e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 04:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725363259; x=1725968059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46XNmUR45khZvA8eAYqDcdhPS16b5Y3YseKtzeiIWkQ=;
        b=hKorwkrYB33irTBYcLr7LQdDbZR3NChYrs/alfmQkEToIDUspe5MO3QNc7/B027sl5
         Wm1WtnaZC+dN1QqCFvA141ay2M/rcTaphhir4rDCDAfQR16skewqNHce+OYTA31Y533a
         lsAIOIww9wOzJuYu0ehV636/cUTKvmaegcFfVkJfWtjO1YEv/yWZG8v53qvM62/NOIgV
         eTUsV8mFnYdvXYeaGSiKB6skrUxSIqh+z+V9yERQwhHuJ1TO20Qv86acQxIW5w36F6+U
         7y0hEGnDyBOkuFZIzQJsYchjvEOkl8k4EXT369x3Ia9qoes2HOdS4YnWim0RErN4Hldy
         pFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363259; x=1725968059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46XNmUR45khZvA8eAYqDcdhPS16b5Y3YseKtzeiIWkQ=;
        b=Ij2acXXJ6dgJZlkkMsVdL4RgdrpCV8L4R400KQPif1L6BosV3vnhiryXuLJL2OxwJz
         YOi+aJTpGAwQ4EsclWakhFKI51lvxife/pUXB0M0Csw8TOawMd14wujQoAcQVas6Roio
         ixH/jRhs/QBRlC9zNN7B8IDmVG81AQKKnRVQSeG1URQDYJTa3CDflPTn7BevUW3ozRFO
         oerCXmW8r5/sROLTPGz3sMw3HNr37J+qszrW6rwhdtXlcWRX4fn1eLFeba7tSIqMEcBA
         CdIn3C8nBI+HP0oKJ/OTzdA9lwSlr1SfoYkDWRry60T3rcTRQRyr3+KTdc33eCccwX3K
         E5UA==
X-Forwarded-Encrypted: i=1; AJvYcCVYX8AJi5uDrQ52e5+B7xcyi7lJ9a/refsT7XjdG9afuVF6SfQ9fsTOpirEGGpSZFbYHinTixHCKNHXjQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ZCWk/Gi6c7AbVoHiHSX8LmPCPyBqEly4a3sKEkU6mN5lGk7p
	ne5R5ctw+5wJZQ7P9epS6CohZaif5D80Ch0tOnNZ8ab4Z0oBa9peNxHv3iuROSdv9Lr4cqZXzXY
	WiqgEUdu0/jj5gCU9o+PFKoo/KOjrOwLgM9zQ
X-Google-Smtp-Source: AGHT+IFuNzVuMjoZGRoZLPtdEPPXHkmFSmRBW7NyYXKHWBhqV12O7T7xt9BawC+YUzC3UzRWxXIuVp1OKWsiC9kNggs=
X-Received: by 2002:a05:600c:34c6:b0:426:6921:e3e5 with SMTP id
 5b1f17b1804b1-42bdc64e47fmr67490965e9.24.1725363258825; Tue, 03 Sep 2024
 04:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903091700.172734-1-benno.lossin@proton.me>
 <20240903091700.172734-2-benno.lossin@proton.me> <CAH5fLgjicT5O77UviXUPxc0-O7nQO4J+M3Nfo+6Mm-DVGQBhMg@mail.gmail.com>
 <ca2e865a-f0a2-488e-ab0b-53ef5c4e95b3@proton.me>
In-Reply-To: <ca2e865a-f0a2-488e-ab0b-53ef5c4e95b3@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Sep 2024 13:34:05 +0200
Message-ID: <CAH5fLgj+U_9_GsFk5cJw_t6UdOsZsQkBtRz5cG-iHgTuj=qY7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: require `Sync` for `Backend::GuardState`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:06=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 03.09.24 11:32, Alice Ryhl wrote:
> > On Tue, Sep 3, 2024 at 11:17=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> `Guard<T, B>` implements `Sync` when `T` is `Sync`. Since this does no=
t
> >> depend on `B`, creating a `Guard` that is `Sync`, but with `!Sync` sta=
te
> >> is possible. This is a soundness issue, thus add the bounds to the
> >> respective impls.
> >>
> >> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> >
> > Right now, a `&Guard<T, B>` has exactly the same powers as &T, as the
> > only thing you can do on the guard with only a shared reference is
> > deref to a &T. So the bounds are correct as they are, unless new APIs
> > are added (which seems unlikely?).
>
> Right, but I thought it was strange not to require that. Since that
> would be the default behavior of the `Sync` auto-trait. And the only
> reason why we have to implement `Sync` is because we want it to be
> `!Send` with the `PhantomData<*mut ()>`.
>
> All of our locks currently use `()` as the guard state, so we don't lose
> anything.
>
> Maybe it might make sense to instead have a marker type that is `!Send`
> but `Sync` that can be used here instead, since then we could avoid the
> `unsafe impl Sync`.

I think it's actually quite reasonable to `unsafe impl Sync` for lock
guards. The lock guard in std is also rather special in regards to its
Sync implementation, since it also has a situation where Send deals
with special details of the guard, but Sync does not.

Alice

