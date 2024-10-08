Return-Path: <linux-kernel+bounces-355387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBCE995195
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B934A1F25D74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E181E0DEA;
	Tue,  8 Oct 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KhNtMd+9"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709D1E04BF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397474; cv=none; b=KqMN9PNewf3dzxH6u2A+ipHR6XwpCY3hC3VdR/SIHod7ID6IoVgD+OlYVnVVHHQQ+mSm+GhKqLR2rPm45lO6lv4KD8XN9PbJS18oXiT17Tif+3zKpSXD/q9ngxRAjI7swD4repPcBQUmUVHiboAVqWIheSX1DnlV3D0CkX56BEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397474; c=relaxed/simple;
	bh=ie53Rqu0p0p5Q7qB7cRsGyaHkBLuhapsKf0BBTl/N2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNRlajy9zSF/miWOyvFcCh1wBojg82Z8g6oCb+2lRqXaUPv5NhL7al1wfAAV8Ym75RsDf0EWb1eOZKNCacz991cAsOIb64zF/j4K/1tNf5ZOowWrbVb6pcWtDR/oGeJH6XftnsIftWgcy6nSryZn0ksCfBG55n9UN/lUEaYy5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KhNtMd+9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42e5e758093so50293545e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728397471; x=1729002271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iI48V9hbHM/hfCZ0F7BwPhazsI3Vlms6ZGs7WY+S/2s=;
        b=KhNtMd+9Yqh0tSHcc0yq5KFnrokoVtHlO6bH7/xDP3/N5h0gZ5Gjqn7FDmQOYnZQdm
         zmqGeP0nnfINcFNb44yTVcss4Cr3LCAnotrEYEoG+YjWpzXhNfnjLDAs/GKgh+SLbwD5
         nvh/ko2+MabdCylLp29D22iLMyuLVNjzHLBgR5Z/x0g10rx5jxK8nOUSOgzuXVD+6voy
         6HJE2tQ71tOk0jLqwoTQExI1qyQGJIeP5HVkFxJKqtZFLsorR8wMsrEzxd6HioThRWFk
         iOKNMKlgvHtlg4X9PAtyZWDoQeXwpfPHP2c1tKDhffcT/8KwGyGlfn08HFgG30awkTaj
         uZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397471; x=1729002271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iI48V9hbHM/hfCZ0F7BwPhazsI3Vlms6ZGs7WY+S/2s=;
        b=VhB3lXdO2XpoUdNnOg4e4HMfCb5s1VPqEgC92Bv8uXlzReXzlOFDMCtfAuHJL7oUcv
         2OTb6d1d0mvrLQLm6NyM6qEDM19LZBFHL0wUhvDbA5NOwPYoezXvDkN0kYHurbU2QiYd
         WDQHPl8d6G8R1a1FCQmiT4A+ZfKoMeAkkqY1t5O02USalwx6SC+YLQ98LHV5PiR451lw
         /llbB2JeU3fEdBsYvuSd3NN/+fRqdjz7M/ydcfWHMT/xCzpH504KFcz11PbhMCkHhCCJ
         hm3/We9y441sARaMGw7MEl+T3//cwYo0rBxYGHNTPTxKVP+BT0REf+c+o42GNZsTS2fB
         HSFg==
X-Forwarded-Encrypted: i=1; AJvYcCVSaHhb+m2vHmaQ97PVT/8+gihWQSLoGcdlCbkNpng9Q5EwTHplLGinBhjUudSxml8xC6Cia6t3LMiJE3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyUt8dQGXZBJf6IICT+8xoF7lf0pda2qjtdOjWXuGkfTuOKI2J
	RIeHt6aQ9SZYw/pazSlJzMwWKeVKyImk53fh+EW9ba6blLUERbPYVhO+rS7nehTfWVTKhPOzr1k
	j+L55FNxSI4MZPJDJkflHQXP0H+izQCPLGKEW
X-Google-Smtp-Source: AGHT+IFqb8vzJcF3MljPcuDJmH7CI/WUdIuIbv0HGGdZgod4f5Iy4iGbgYewcH5OpIoFQ0Hz/dOI8gyf2RkTC2m7ljU=
X-Received: by 2002:a5d:40cc:0:b0:37c:cf84:4d9e with SMTP id
 ffacd0b85a97d-37d0e8df41cmr7926081f8f.38.1728397471099; Tue, 08 Oct 2024
 07:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-rustc-option-bootstrap-v1-1-9eb06261d4f7@google.com>
In-Reply-To: <20241008-rustc-option-bootstrap-v1-1-9eb06261d4f7@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 8 Oct 2024 16:24:17 +0200
Message-ID: <CAH5fLgieyO79OnLbFik5awASQub0VDErZmbrcQECDr-e41_ohg@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: add RUSTC_BOOTSTRAP to rustc-option
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:49=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> When using unstable features with the Rust compiler, you must either use
> a nightly compiler release or set the RUSTC_BOOTSTRAP environment
> variable. Otherwise, the compiler will emit a compiler error. This
> environment variable is missing when rustc-option is executed, so add
> the environment variable.
>
> This change is necessary to avoid two kinds of problems:
>
> 1. When using rustc-option to test whether a -Z flag is available, the
>    check will always fail, even if the flag is available.
> 2. If KBUILD_RUSTFLAGS happens to contain any -Z flags from the
>    environment, even if unrelated to the flag being tested, then all
>    invocations of rustc-option everywhere will fail.
>
> I was not actually able to trigger the second kind of problem with the
> makefiles that exist today, but it seems like it could easily start
> being a problem due to complicated interactions between changes. It is
> better to fix this now so it doesn't surprise us later.
>
> I added the flag under try-run as this seemed like the easiest way to
> make sure that the fix applies to all variations of rustc-option,
> including new ones added in the future.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

It should be "export". Also, this doesn't seem to be sufficient at
all. Now I'm running into this error:

make[1]: Entering directory '/home/aliceryhl/lout'
warning: ignoring --out-dir flag due to -o flag

error[E0463]: can't find crate for `std`
  |
  =3D note: the `aarch64-unknown-none` target may not be installed
  =3D help: consider downloading the target with `rustup target add
aarch64-unknown-none`
  =3D help: consider building the standard library from source with
`cargo build -Zbuild-std`

error: aborting due to 1 previous error; 1 warning emitted

For more information about this error, try `rustc --explain E0463`.

I think this patch is going to need more work. Sorry for sending it prematu=
rely.

Alice

