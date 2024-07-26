Return-Path: <linux-kernel+bounces-262946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F65A93CEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED93A283281
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CCD176AC0;
	Fri, 26 Jul 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syX+nY1j"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF1176ABA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979683; cv=none; b=dwJ2y9tTP/7AWX5cMN4YlJj1dzVJTRWuTReff5fjL+qGz4Wa5lmIWBZrqjSCD+cKWg2xbwRqKWefcx//tTOzblZh3FnEX2mRku5mJU4lRZi8bnoolwXGZS0S8eqNv5qqZ/7g4Dv4TydGEcahTtTDpYsUKzkn01WAd1SURDEbkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979683; c=relaxed/simple;
	bh=MqAset8Nc45mgIXZhKbsEINkaYQKExHjMptHz97Z1lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzBN0IpEpIh+ojsvp4WkgV15Dd0di+K584p+MDt45HC79cXNRjKV6QhvbVrCqyD7XYSTIv7Y45uEd+0h/O/WzsqgmjF510yAyEEgnK4k1Pt7J3GsW09Uj6gvlDFeNHyzoIwqtywSiScPmAn59bWVvJ9EXevm2y0U1gwT0yjXNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syX+nY1j; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-426526d30aaso13235115e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721979680; x=1722584480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGuZ9gW9s8hbzxTk97NuO72bufoRV/MO+7ZPtq4qR3Y=;
        b=syX+nY1jfdqJpL6/N19Zi2CS4agtdhyklacLKJVOLPYapfnGoc+7V1ZFYDP1VveEOJ
         gTdoWUGtnAiyQIzs6y4AeAeaUOdFjb4U1v9NUNYTYod9ydoqgn8mMVupA/BAcDgMUtpZ
         NM53rELibsqPx5wCqcBE212OhIISuxTyrn1Y+YzgYDNcux1NZqK+rZZFYigd6WDBn1Mi
         fOsoBxJ8o5Yvfa7RIm55bJQsMKG/bcvM+YzzLYqEUB+rN4+M/xt4DXu45HZLAkAMOtdW
         9jrQRm1CyOHeVN27umsfzCT9QXyNX4KWNoxYfkObiJJ0P5jPcCGnJSg4Jml9Xc2o77/x
         ykGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721979680; x=1722584480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGuZ9gW9s8hbzxTk97NuO72bufoRV/MO+7ZPtq4qR3Y=;
        b=TFuRhcQVwgt/sqRota9fjt0tfe6oEc26wYNU4lMJS8ca/c2xMyWbVo5clGsCToegU3
         5XASe+LIG7UygmZZsXQmHa6RWbjnFJfhwH5khEpT+wNwfNZCTTKg7/4szXApOMp5mVSY
         dJ77iFdN6ovwSNTQcjWxKOL+/0tb0jvqc6jk7S9tJJN2rTp3mP5Pk31s1d9ouANxQMeA
         LERSGGeHWKvy5Bj9aX86daOVM6ONS3Koq2beNZ0cyIK3jP/1RJ0moXPz4NtlvklXUBGu
         L9DhbNjaKyUCvNjLrcH0A98B1p+Jx0SByumepIj3NF+P+B5nNxKpSG0JFgSM9vI10LBN
         XRUw==
X-Forwarded-Encrypted: i=1; AJvYcCV2KQbJXEO8k7IzZ9zcHdJLtMTxfTh20+BzESKBeTjDpG8+kNHT77dydpv9Os9r3Y/yIGQiWZoxVaN7hLy+jn8uNXIego8Hv7kLZula
X-Gm-Message-State: AOJu0Yy2Jk9YSRXRYuja0BfFmPbe7V8zUsk033vuRBOwPvarn+97o+mZ
	2p+vxqiMkumz311PwZr6GJ+M2XPwtSkjqIG4Xa8LFV/Q3r7PNV1nbXrH9T3M05Q7bCelZqtIneC
	4O1C1YIxTGa8F52tQq9LNA9BlFHLo5hxL6Mxy
X-Google-Smtp-Source: AGHT+IGVZMl8k8xJUMNdGuAqO6mUXeTU9uHBwsDRosmfkRv3V8tmsmQD2SxE1zeG5jOc3UIamFGu5cu1XFJeRldXWMY=
X-Received: by 2002:adf:f642:0:b0:368:4e38:790c with SMTP id
 ffacd0b85a97d-36b319deb2dmr3199790f8f.14.1721979679422; Fri, 26 Jul 2024
 00:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725183325.122827-1-ojeda@kernel.org> <20240725183325.122827-6-ojeda@kernel.org>
In-Reply-To: <20240725183325.122827-6-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 26 Jul 2024 09:41:05 +0200
Message-ID: <CAH5fLgi9xN2igQK4Y8ZCU+iPVMH2RaWGQ7OO2OV-XROJba_2fw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] objtool/rust: list `noreturn` Rust functions
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 8:35=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust functions may be `noreturn` (i.e. diverging) by returning the
> "never" type, `!`, e.g.
>
>     fn f() -> ! {
>         loop {}
>     }
>
> Thus list the known `noreturn` functions to avoid such warnings.
>
> Without this, `objtool` would complain if enabled for Rust, e.g.:
>
>     rust/core.o: warning: objtool:
>     _R...9panic_fmt() falls through to next function _R...18panic_nounwin=
d_fmt()
>
>     rust/alloc.o: warning: objtool:
>     .text: unexpected end of section
>
> In order to do so, we cannot match symbols' names exactly, for two
> reasons:
>
>   - Rust mangling scheme [1] contains disambiguators [2] which we
>     cannot predict (e.g. they may vary depending on the compiler version)=
.
>
>     One possibility to solve this would be to parse v0 and ignore/zero
>     those before comparison.
>
>   - Some of the diverging functions come from `core`, i.e. the Rust
>     standard library, which may change with each compiler version
>     since they are implementation details (e.g. `panic_internals`).
>
> Thus, to workaround both issues, only part of the symbols are matched,
> instead of using the `NORETURN` macro in `noreturns.h`.
>
> Ideally, just like for the C side, we should have a better solution. For
> instance, the compiler could give us the list via something like:
>
>     $ rustc --emit=3Dnoreturns ...
>
> Link: https://rust-lang.github.io/rfcs/2603-rust-symbol-name-mangling-v0.=
html [1]
> Link: https://doc.rust-lang.org/rustc/symbol-mangling/v0.html#disambiguat=
or [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Tested-by: Alice Ryhl <aliceryhl@google.com>

