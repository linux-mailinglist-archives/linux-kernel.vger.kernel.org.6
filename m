Return-Path: <linux-kernel+bounces-341518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 252C798810D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E039B2263F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E1018B475;
	Fri, 27 Sep 2024 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bKVPAOaQ"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A5B18A93A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428016; cv=none; b=nPJwIuzs+KuxArBrY2LC1cWab/OSMi+Tie9I5AWbrm66dJ12v7syNPrKGVhLNbNEuNCZD2dB64UNEFIvsX67Obor28d6tC4016ooG1XBQmmmkLx3IFd3xdNDfGj9pPNav+v3lWgOfN3NMlTTW4BZdg2R1rLfhpunodeeZ1RsuFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428016; c=relaxed/simple;
	bh=XJi4lkPN6suJ6SAQVTKbY8dUP1e7mUKYZhisWbQCV2o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jM7arWvyHZOOZeTfuwaynO8dFFAsjoi9ZGbhn6IkaerDZBCjjP/WPcw3jGaoQKHt2A89fWSbJbEmn2LRCK7WJIz46duqcKTgkv3YRGxR4j54eF/bdYe5rI5zHqAWql6Plnd5Xzo1pBZ6kfihjTEypJ2qvMZ6c9q1OGjeDBfCjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bKVPAOaQ; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=yj54tm3ptfco7bqyilauajek4y.protonmail; t=1727428012; x=1727687212;
	bh=Y/ZMKfKxXxmed7Y4nQfgv37JqGP7l9vxlakQNi8YpsM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bKVPAOaQ20srGUp6b38HUwM2Nlzq2jdqUDf+eRI+1rOBGIVUpHr3X7BwbhrXMaNvQ
	 nXr96s0CpRM11Q+SkRpdwVtp788NMwzKSeVudfLIUbY14oraKkzy0HwaVBGMSpUmjI
	 yIWYgwF8YDLcGj/Lx1v3wWumunsiKXeJw/Z6A4bF5hYpXjXhFkswn8mSC0XkaaJVbb
	 eQJ9+gq8b6d0dxooo++z/VhIZ6t4w0HM4d5NPwtM5aRUhJ2IMqsZ6fl+lUMCE7hC+a
	 J042WZeIO6lyUI3ME9z6uYcN7CiN9HBtq0XLAF/BhUwdiqP/ARWsOeVLlOebfQwEUp
	 EVNul4+43d7Gg==
Date: Fri, 27 Sep 2024 09:06:45 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: kernel test robot <lkp@intel.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, Greg KH <greg@kroah.com>, Simona Vetter <simona.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add untrusted data abstraction
Message-ID: <00ca48e4-1b4a-496d-a06b-3c12a9ef2d14@proton.me>
In-Reply-To: <CANiq72=-bV_=TUoH6gLnPwTcxROBqyrCpOpbumki_S+po1TPhQ@mail.gmail.com>
References: <20240925205244.873020-2-benno.lossin@proton.me> <202409270303.kUIAmOmY-lkp@intel.com> <42d17306-1ac6-4fc7-ab1b-69ef045039ac@proton.me> <CANiq72kXGNyLg0Ooo3Ne=KmZWBnSO9HE2tcfP=gf+WGFqnjDEg@mail.gmail.com> <1aa088b1-ca4d-4a97-b25c-96a18f62a79c@proton.me> <CANiq72=-bV_=TUoH6gLnPwTcxROBqyrCpOpbumki_S+po1TPhQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d03cb3c88484f51dc99e6d9272da316b79dd1db5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.09.24 10:39, Miguel Ojeda wrote:
> On Fri, Sep 27, 2024 at 12:15=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> Personally, I would prefer adding a symbol. Since if we allow it, then
>> it might take a long time until the code is removed once we increase the
>> minimum version.
>>
>> It would be best, if it produces an error when we raise the minimum
>> version beyond the one represented by the symbol. Is that already the
>> case?
>=20
> No -- that is a nice idea that I guess could be implemented in Kconfig
> somewhere (i.e. when checking conditions). However, one of the common
> things to do when upgrading the minimum is to review/clean the
> `*_VERSION` uses anyway (and they may occur outside Kconfig files
> too), and also sometimes one wants to upgrade a minimum without doing
> the cleanups immediately (e.g. the recently proposed GCC 8.1 upgrade).
>=20
>> Gave it a try and I also can't reproduce the error there...
>=20
> Hmm... I think CE uses the Rust-provided binaries (and I guess the
> playground too). Do you have a link ("Share" in CE)?

Here you go: https://godbolt.org/z/qE8E9M56c

The error that I get locally:

    error: unreachable pattern
     --> src/main.rs:8:9
      |
    8 |         Err(e) =3D> match e {},
      |         ^^^^^^ matches no values because `Infallible` is uninhabite=
d
      |
      =3D note: to learn more about uninhabited types, see https://doc.rust=
-lang.org/nomicon/exotic-sizes.html#empty-types
    note: the lint level is defined here
     --> src/main.rs:1:9
      |
    1 | #![deny(unreachable_patterns)]
      |         ^^^^^^^^^^^^^^^^^^^^
   =20
    error: could not compile `rust` (bin "rust") due to 1 previous error

---
Cheers,
Benno


