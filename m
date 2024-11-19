Return-Path: <linux-kernel+bounces-414652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFAD9D2B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22CB1F25653
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32101D2B04;
	Tue, 19 Nov 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuAeIHy6"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9256E1D271A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034632; cv=none; b=POfvuKU4MURpcSsOCvuhC0ENtNxb/gK3mHtbtvatgOKehFXv+/jJG52NZNl42+BOOfwqxgr5PG6fKQWyYP02kP2KgHwJlVdCKj712cpDEZeK/U4nw0w43lZ/K2ubUgEGENUGWbyc0SDnZh5Hc9Cq9FooihC5rBN5N309HaRh3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034632; c=relaxed/simple;
	bh=06C8iL7jJR5pqVCS0NR944j586zWrc6ftYHVIU0hZgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzZmquCKK06mhx+/7HAANCe47CtR2/hZo9c0gtxUVlSJPwSZfpY5wa4zmdxTPH5GXeDrgWJqGHLvv64ji7zug5y2WJ5pG7OVIv5kdWJFayXzFNsSEOGH/0oTwzeQE8UzFosm5rNETkTn7Ooc+BxuhpOo1wDZXGqZ7aU5S6k6gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EuAeIHy6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so47871855e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732034629; x=1732639429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQNNPRvfJWv1lLSMGox/pdIABf3+bH9JsHaNFGozuek=;
        b=EuAeIHy6jTdVu3QLUe6oj8cYHqtcqgym/axyXMZXerA49iKnqgadO73xD0B2hx8xxN
         ndgYt14ICXeayx/n32RZjAWGkMkl+PSqZiLx0lWxjnmg5p7rWsSaZrRlE7HUhTpc0Hut
         QE7NDSjWpqgD864eSA/93elkIss+mY597VGtvnunNLZFfvJVnBgdDnTQBBGu+RERYNtz
         TWHIyaDPwE0jccxHXqXyVNjO2c1jAhyhDBHHT/5NU1OO6H8ZUQYXi0fxgg4HXzSHvpEL
         bbklY2kVByjuwgfTtY5M6t7p3FtLZYfMz9nquCUwYTppprMjtVsaTqh65JQH8HSwh7Yt
         2NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732034629; x=1732639429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQNNPRvfJWv1lLSMGox/pdIABf3+bH9JsHaNFGozuek=;
        b=U68nPXJgdZQfFVxxk4EIXg3sZvL5MF6Lxt1jPNy/qUs0o3pcBbaYW6KDoAC3JTisb5
         oXUP7bloZBQzLj/T+4LZdEzzt+YZRigYran2FdWuO4d7HHGVKPbvf7Y+lJgIDaVpf/j5
         wNR9aBtYiH8RkN0WH3B9DcrRP84GYoHcdQoUZFBh7pz9ukhWQkXSTnDjfNwEbOIt/4ru
         4lJP/1KYI4e4WOEnU+kigmPf1KRfEanx2MniGLJewzKZTVayusynqRn9wUAKDnHlrmba
         TuE+dxc7yrF9to937vrfoEfK22fdHxBKjIkPDpqIjsoMPGPFruuXM3Z74IJgvjW1Fqhd
         amNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIfs1S35a57ZWDCwgVBm3QRGTiIm+wgvSEA5V/53Lin84CZIWyk9TvY5Myl9S1eSl5VRRS8qvJQIZHybo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZ7sTKbIJ1iq6qZwwbjazqJGnroZwXBA+XnNhsxcToZzzAXI7
	7ZSmzcVxwgHPAbIBIwXyQqiMfTFS+2V0eehprdNfRiCbbG9S9L7jjAJLu/k5H64RTbjfu5fp5dH
	qMwjQ+7k+LGuBFW5MH5ms0LeiWoYnz+/A2gbe
X-Google-Smtp-Source: AGHT+IFGZ6eAu9UU+ZTzKYOhK/SYh97vKRs9TC+ZJNmOyXQFNM8NjB4qhcmXqz9FDTAWxohhbKptq6gxHDadcPNGhdQ=
X-Received: by 2002:a05:600c:1393:b0:431:52b7:a485 with SMTP id
 5b1f17b1804b1-432df74dcfdmr142762355e9.19.1732034628815; Tue, 19 Nov 2024
 08:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <20241118-rust-xarray-bindings-v9-2-3219cdb53685@gmail.com>
 <Zzu9SzkDoq_1YQnJ@tardis.local> <CAJ-ks9mKArX37VzhcyymDoE-MsNxNcO8VvP4n3Xu1mdfOKiuag@mail.gmail.com>
 <CAH5fLggL7MTLVv2ym_tCCKH9hQtL=GpTwXjDUQzKQX9UdT7SkA@mail.gmail.com> <CAJ-ks9k4upcSfa2HXaMrtDJ37eTNc-ZiKZdcLuEYSnWHL5Bigw@mail.gmail.com>
In-Reply-To: <CAJ-ks9k4upcSfa2HXaMrtDJ37eTNc-ZiKZdcLuEYSnWHL5Bigw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 19 Nov 2024 17:43:37 +0100
Message-ID: <CAH5fLggBZsarrRkZ1Mf5ND9-A6kCc65QRwhUW5X9nQxRJUOXrQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] rust: xarray: Add an abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 5:40=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Tue, Nov 19, 2024 at 11:28=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > On Tue, Nov 19, 2024 at 5:24=E2=80=AFPM Tamir Duberstein <tamird@gmail.=
com> wrote:
> > >
> > > On Mon, Nov 18, 2024 at 5:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.=
com> wrote:
> > > >
> > > > On Mon, Nov 18, 2024 at 11:33:36AM -0500, Tamir Duberstein wrote:
> > > > [...]
> > > > > +
> > > > > +/// A lock guard.
> > > > > +///
> > > > > +/// The lock is unlocked when the guard goes out of scope.
> > > > > +#[must_use =3D "the lock unlocks immediately when the guard is u=
nused"]
> > > > > +pub struct Guard<'a, T: ForeignOwnable> {
> > > > > +    xa: &'a XArray<T>,
> > > > > +}
> > > >
> > > > `Guard` would be `Send` if `XArray<T>` is `Sync`, however, it's
> > > > incorrect since `Guard` represents an xa_lock() held, and that's a
> > > > spin_lock, so cannot be dropped on another thread/context. `Guard`
> > > > should probably be marked as `!Send`. Or am I missing something sub=
tle
> > > > here?
> > >
> > > I didn't know about this requirement, thanks for calling it out. I
> > > have added `_not_send: PhantomData<*mut ()>` in v10.
> >
> > You can use _nts: NotThreadSafe. The type in question has landed in
> > 6.13 and is available in Linus's tree since yesterday.
>
> TIL, thanks - though it looks like the field name is still `_not_send`.
>
> How do I set the base-commit/deps such that both
> https://github.com/torvalds/linux/commit/e7572e5deaf3bc36818f19ba35ac8e0c=
454c8bac
> and https://github.com/Rust-for-Linux/linux/commit/d072acda4862f095ec9056=
979b654cc06a22cc68
> are present, given that the former is in 6.13 and the latter in
> rust-next?

Either you merge them yourself or you wait for rust-next to get merged
into Linus's branch.

Alice

