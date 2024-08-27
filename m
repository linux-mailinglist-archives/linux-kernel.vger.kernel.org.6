Return-Path: <linux-kernel+bounces-303185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BCD9608BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3031F22DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C1A1A072F;
	Tue, 27 Aug 2024 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIJ8h26v"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1719FA7A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758245; cv=none; b=M3/hgQg/zwfG13S3Qhw3rl6fk9se12impB6ywAdvTAopw8YYMvrpNd3BcDKqZvjGd4yHCQHuvcpbrR1d5CL9nXhLO/TZYRmyAXFRaSACxw37ZrxMb9bfOkalLo5AkCa6v8CWrbeDY9PAn5SiUjYJ3miiqxxtviH23urz08ZKeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758245; c=relaxed/simple;
	bh=pxwUZjIEzUdNMrTjj+dC9adH6yYFv8ZxuOHul7Of6Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBVqQuSFn5pPmJd4li4tKO10btcxwLDmTSMY2Wz47i1dzwpT9+sozF6wdlL6PKadia5NniPyQsu2hyvZF5pWzY403vBxYY2NUTzCraebenmUB9GinhkyGbslPTCkz4vLK2ccFcdxKEfJwNnOo7sxYprHqjLept0ptTvtrxurzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FIJ8h26v; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371a92d8c90so2816516f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724758242; x=1725363042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUhlT5a/QMpCNH2uUAixzmV7FXsegXG889Otbeqkao4=;
        b=FIJ8h26vi2I5p8sK4QWlV8SAJTpkpJdRmSi+WwbonbSFrRXq4YSS0n11y6Hg5vyJVp
         oiAZSolojvAFEUmWlRebnt2T6LIhKUldKSlYYJ/x7xECkPlDQwhtFhTCnjUUIaTUyh0s
         pdqFVLnpFCF1mszY5pNZ3+zRTyCnfobFOy7OzCy38X0ioIGaOKamVl78OlB5MT19FhJo
         DJYcDYtzfuM96u+gXUJhHNU0P2RhVxG9KNcR/NvdH+xi8u9FFO9cUfUuZrgEkB/mnUqr
         mzXWE5KvemRB/WIuketesPSLtLiFpviIzioqzjUIWDYdFIygyaVx0nHMPxjmuCzSOZm5
         u0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724758242; x=1725363042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUhlT5a/QMpCNH2uUAixzmV7FXsegXG889Otbeqkao4=;
        b=NlMhbVzznKVu7rLV7TR4Ngn+Z5xcm6fuz7BfyTycEONJpvesZXH9p+4qzdXfBhEAap
         KADX4njqXZbntA9IU7R7oKt1nM/LMc1w2Q+T7P6TAUgIkcEKJk8KvFmFPOgW7/3QfWaP
         jH2Cc6PYZYTQHNwPWLuD0kAfoJ2RKKRhxVWspqzxyeUtGG9fFO5WsigH7slS6d3Utw3q
         YsuR6vxP9ouTUQGTlsiUfGwTWANnyQp6RFY0mae5gDTBg99aRdcdrFkJ+j0bDHlwLvgt
         fgfEleXZDyY8p7mPUytK42JP4dL7tk5K6iWyFzX8s9p+FgoX6jpF2vpguj1zm/PK4xxh
         rpww==
X-Forwarded-Encrypted: i=1; AJvYcCVZqcCXKhp9fxWuB7x0WhMZsfmQ668aQ25cxo223Ja9pE/Vg59l1a7tzIn7K0djsJOV4EK0/b3VIv6uD7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8MVLznxE3CJ8Bhivm63ukEyPbT1BLU+WLlXq0JeRbmP9tbzT
	x8ATDSOiE4TAkN1laci3AoF5iZv0ywYU1KZTvPvELoQnlkx6f8MGBO/01CQupUIWHEaBRs2hUwF
	ZIgrgLripJaEN14rhiegS36ql9m3BwFeRKQgf
X-Google-Smtp-Source: AGHT+IH6vpUg+8mWXDKTFNmf1KdzZsxtXKssoNipDJms7hahddmniOI+sSiJNcbup7z54o3qp32hTwnfiagOWZS6Kts=
X-Received: by 2002:a5d:4fc5:0:b0:368:3f6a:1dec with SMTP id
 ffacd0b85a97d-3748c7c790emr1887630f8f.9.1724758241551; Tue, 27 Aug 2024
 04:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827100403.376389-1-ojeda@kernel.org> <CAH5fLghhgWdJHdOR7TYwGADecsqBtOF08+S4v3RimeFsqvdfuw@mail.gmail.com>
 <ab399fac-4b10-4ed9-ac28-55797a17fff2@proton.me>
In-Reply-To: <ab399fac-4b10-4ed9-ac28-55797a17fff2@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 27 Aug 2024 13:30:29 +0200
Message-ID: <CAH5fLgi1_=FhM1800xz=53OpfvF55WqBijPSvSXC7pHuFL41rA@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `stable_features` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:29=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 27.08.24 12:39, Alice Ryhl wrote:
> > On Tue, Aug 27, 2024 at 12:04=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org=
> wrote:
> >>
> >> Support for several Rust compiler versions started in commit 63b27f4a0=
074
> >> ("rust: start supporting several compiler versions"). Since we current=
ly
> >> need to use a number of unstable features in the kernel, it is a matte=
r
> >> of time until one gets stabilized and the `stable_features` lint warns=
.
> >>
> >> For instance, the `new_uninit` feature may become stable soon, which
> >> would give us multiple warnings like the following:
> >>
> >>     warning: the feature `new_uninit` has been stable since 1.82.0-dev
> >>     and no longer requires an attribute to enable
> >>       --> rust/kernel/lib.rs:17:12
> >>        |
> >>     17 | #![feature(new_uninit)]
> >>        |            ^^^^^^^^^^
> >>        |
> >>        =3D note: `#[warn(stable_features)]` on by default
> >>
> >> Thus allow the `stable_features` lint to avoid such warnings. This is
> >> the simplest approach -- we do not have that many cases (and the goal
> >> is to stop using unstable features anyway) and cleanups can be easily
> >> done when we decide to update the minimum version.
> >>
> >> An alternative would be to conditionally enable them based on the
> >> compiler version (with the upcoming `RUSTC_VERSION` or maybe with the
> >> unstable `cfg(version(...))`, but that one apparently will not work fo=
r
> >> the nightly case). However, doing so is more complex and may not work
> >> well for different nightlies of the same version, unless we do not car=
e
> >> about older nightlies.
> >>
> >> Another alternative is using explicit tests of the feature calling
> >> `rustc`, but that is also more complex and slower.
> >
> > You mention a bunch of alternatives, but I agree that this is the best
> > way forward. It's very simple. Only possible disadvantage could be if
> > we forget to remove features when raising the MSRV, but I don't think
> > that's a big risk.
>
> What even are the risks associated with enabling an already stable
> feature?

Nothing, really. Clutter?

Alice

