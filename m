Return-Path: <linux-kernel+bounces-342785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF6989305
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D300C1F22C44
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2122B224F0;
	Sun, 29 Sep 2024 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="E0cyAM3N"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A63C30
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727584419; cv=none; b=RTpHjpyyB5ii93qx7aunTnrJyEKO0Q7xv2jfAjUTECz3z4TehTPBi1lW0eloAw1kXyMnotpvQ19/Rs818AB1gcF6TlMYqanOLYKpCbUwR4ClDHshIFuIuY1BYb+bXN2sDeXPQG87yDec0cjGlOkDOhZHiyvTcDsdPFTe9AX4MR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727584419; c=relaxed/simple;
	bh=ACdDOapy307eX83VoYT35p6yFmufcMowrIriJWNRkuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxjUwKt6lqJf6lF/vnByZsHqFipP47o96y3yyZLh4cTV8DnnAn6A7DScY07EXJGQcjfulvx/AVJ3BpMRbIXHgCACkN60cBfTiKt/4jyFHI/dba5mluMLUvtKxKVLp9Uio6nOkHlSF5KwVtM4mL+ic1VNz+txj85uL6v69UK8ygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=E0cyAM3N; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6dbc5db8a31so25568527b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727584416; x=1728189216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crMih/hO2yN7TpUZlSd9hsKUsXMFO0eCIYsluTrMHvg=;
        b=E0cyAM3NXXktHCSD1nR+BTwNwE0AvjqnlK7+FsrorYhlGwusZVz6+ixxGAfy88mxxL
         kwttfTL8YwD0gbUZzAq5xiLRPqRO3+nIcPYTUxRhk+cwQzpsXn6K9rSP1J5mIer4wu9w
         kQsLNYJyKnWtlPArE4mgEvW4s6OL/T59egbaKedCj5btPudITQmMuBrJE+rOae9s8uJX
         6Qxxn7ykjRQvONmQD/vcslnujIxjF75IdQScNW51vSdXTqkJZlc+toB0O/+KkHT7XIGp
         DAgTYp5zqN0WB4HgIexCNHaI4n8MC+JBafyV5RmhynMFcAZqyp3oQ4HqWgy2U3aBHqP8
         RulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727584416; x=1728189216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crMih/hO2yN7TpUZlSd9hsKUsXMFO0eCIYsluTrMHvg=;
        b=UfbUsu5u7it9E1yKra47SRC4vQs69mv6JLacTXZqhDy2/e6fti3pqpqO+t1oJKw0G9
         dMjshksUAjqwnE0+mNbAHr9EFKdoBDvb0S4TGjTprW/gHtSE2eYjT9fL6Zfy6pZLPmFM
         dUzGU450PkI+R4va8dLrYI7Kerj4q4FVYX6JPx/OUEjiUdILiPNKZIq3nM32ZH99tsUH
         1d/iqEcQkl4SyN60lqqmNnJRGjYLcFGuJ+t6vlTRmaY+p8MDkBr45TlKdnkbLU2tC+D9
         OQFrll8wmRKPkMxIAvRoZl+aE7FxC6TcBcf1dEXs+4ju1JkHMuwb7jTAjQxdoC2ZRcuY
         7ACw==
X-Forwarded-Encrypted: i=1; AJvYcCUmvdLm3e020/XV6MDcX0ksXPRQkJScohkEv/WQmhBIJxvCY5OkaWZ0mLkq2JxJwPIRbZT1JpTKejSHyZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2fZTM5TuUB2q1KuusJMpiAgWdODQuFJuxrnLzPZUQhA8h1aF
	j9o/mOL4QuZlztAE1YmKGp9DWJSJNdTK9wbxoF1i/hI5wblsLSNANSYgUgY/Pmx5tolK0Zlm8vn
	koqTH/XXOiZlQloaD78/sffQVWW7Ljy8lybZFBw==
X-Google-Smtp-Source: AGHT+IFTzOwIWznLgsvN4UDZ43A97KAtmUIMJ7FDriGjQqSZbDChpH70YRjNmpxoRB1v+fFdhx7P3G/OtX/gEQL2QBw=
X-Received: by 2002:a05:690c:c07:b0:6d6:afe9:d818 with SMTP id
 00721157ae682-6e22eda1e00mr78513967b3.6.1727584416245; Sat, 28 Sep 2024
 21:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-5-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-5-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:33:25 -0400
Message-ID: <CALNs47udN4_Gr2KHDapwWAmY=ixoJN+-9apAShVT7qFcKdK23Q@mail.gmail.com>
Subject: Re: [PATCH 04/19] rust: enable `clippy::undocumented_unsafe_blocks` lint
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Checking that we are not missing any `// SAFETY` comments in our `unsafe`
> blocks is something we have wanted to do for a long time, as well as
> cleaning up the remaining cases that were not documented [1].
>
> Back when Rust for Linux started, this was something that could have
> been done via a script, like Rust's `tidy`. Soon after, in Rust 1.58.0,
> Clippy implemented the `undocumented_unsafe_blocks` lint [2].
>
> Even though the lint has a few false positives, e.g. in some cases where
> attributes appear between the comment and the `unsafe` block [3], there
> are workarounds and the lint seems quite usable already.
>
> Thus enable the lint now.
>
> We still have a few cases to clean up, so just allow those for the moment
> by writing a `TODO` comment -- some of those may be good candidates for
> new contributors.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/351 [1]
> Link: https://rust-lang.github.io/rust-clippy/master/#/undocumented_unsaf=
e_blocks [2]
> Link: https://github.com/rust-lang/rust-clippy/issues/13189 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

> @@ -277,6 +279,8 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<=
*mut T> {
>      if unsafe { bindings::IS_ERR(const_ptr) } {
>          // SAFETY: The FFI function does not deref the pointer.
>          let err =3D unsafe { bindings::PTR_ERR(const_ptr) };
> +
> +        #[allow(clippy::unnecessary_cast)]
>          // CAST: If `IS_ERR()` returns `true`,
>          // then `PTR_ERR()` is guaranteed to return a
>          // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
> @@ -286,7 +290,6 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<=
*mut T> {
>          //
>          // SAFETY: `IS_ERR()` ensures `err` is a
>          // negative value greater-or-equal to `-bindings::MAX_ERRNO`.
> -        #[allow(clippy::unnecessary_cast)]
>          return Err(unsafe { Error::from_errno_unchecked(err as core::ffi=
::c_int) });
>      }

There are a couple places where the attributes move like this - did
this come from an older clippy version? clippy used to warn about this
but accepts it by default since [1]. (Still works of course, I just
think it looks nicer to have the attributes next to their statements).

Either way:

Reviewed-by: Trevor Gross <tmgross@umich.edu>

[1]: https://github.com/rust-lang/rust-clippy/pull/11170

