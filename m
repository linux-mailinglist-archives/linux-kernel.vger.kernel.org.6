Return-Path: <linux-kernel+bounces-342789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ED5989309
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043C42858C9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ABA22F1C;
	Sun, 29 Sep 2024 04:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="O6kx7enY"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4533981
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727584835; cv=none; b=UV0GYrO+2DVsYpVI37Ho9EyjZJ3hdqnviSlpG0BfrDX9QcTwPFkpzB2YwOs//5FL2dQfNHBOUFDir3AO4En1+mX4CKYBIlBMyc6ZWGQ0sarjcGodbxaozRrR/Kjzk/LwLSAgxLrbRjHDYoFpMp69R38Fao35FiTn6pqdQkI6R+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727584835; c=relaxed/simple;
	bh=gEGnP0STUu3Lpzltu3JSxCW2N1DRULTC36U1Qhm75Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJDqzoJBV+oiZnmM5SJR6qyoHCpZcGYQHAlxjCgeW7bF2NZf4h81TmrZnKN02aHSC6OP8Kkd+pvrDUGw1jShnj+kgGVG+nNJjcEv/KISOlddnoR/KdaYckff+NLDsHm0DvqIcJU6lWBX7v6WpVk0v0c/IcXJs/pLHpno7XVYyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=O6kx7enY; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e260b747fdcso1249859276.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727584833; x=1728189633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VV2YxyLVgm/A21lFnrbUS0xzE5yvl49iPMLTKyEnGNo=;
        b=O6kx7enYpPalJffa9dWJOiyO/4Tvcq4h44mWqv8vKPn0SsCmb4iZF5X96f4S9BmCem
         bw8TLoG1a5/xOQjp/yHVYI9ZXL9i919TzXQrn3JJy06ge47igQYKT1CNy1b7BoZRf+lV
         7eAxgH4whMmqbZpQxCgqjZP/UVbErPrhfc6LSupOS4oMiLZVfs0wgGfkbkyLItg8UQ4u
         mvfna2k6XmEWhEY8+rCg4JpcqkEvdf+SKCviN8L7wl0RGPYeRjzmav1IGaG7JEBGloPx
         Nc46Wie8IsHqdU0rlWEk2yYXQu1pMOT1AUn+QVoq5rGgc7HbeObiLNhFIRiZEmasWyda
         06hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727584833; x=1728189633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VV2YxyLVgm/A21lFnrbUS0xzE5yvl49iPMLTKyEnGNo=;
        b=p+9zju92H3aaA3xGXiBQDDCGsFQlKgiUY/SBEjKdFfBGNP9+Ls+60phmUGnqSzFRVg
         4eM8kzCrr7XAuB1Y3rUip3vSTvfr1zAB+nsExd3a4z6K+HX+cmHlfA+XwApwTy4KQAWi
         13hQjNhRRJ400ytbLgPNX7z4r/G+uyYefP2YtokD3Zoz3a/LKy5L0jdwpaJG6aCaAWPm
         +YCFmD+WyS0DfE4aH2Nnx/AH8lE9cFjCJDIJq9Rsmt0x+/tmTlVyL3jAjDnHOUYm7z+C
         Na3zrMwY4P+CocEqKUUGKT/i5rOz+Whmz83JgdbTIhYkgaUjEBXvjRKUer94h5blYd1/
         57eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVErQ5eP+XzuJUjERehfaMeDtCkosqvfjs8u8OSJVideAlFOxuOrIOjk5t0pBcew2pyng/0pXfCMfEwm4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf84hZvwVANgaayijYQeBt88o2+jGzDMJrZjluuLAH+WjN2ezM
	Wkl3AHbNurElYtYzvkD7768Ws8ZTq7AMhSBb5AyowS8hDFeYxzyP9kElBihEZlwZo9EDPrhdjqf
	j4B0o2fMql98VgXW36m3NaOeHV8oNaYDnqlk0hA==
X-Google-Smtp-Source: AGHT+IE4B4r6X5b8t4Dk7RmIMj8MQORtpJ9++eFIxvMdYYJl/soJ9aCmoTuPzU+LqekFU43oyGbJtCB5UAMgPSvpC74=
X-Received: by 2002:a05:6902:2493:b0:e25:d0c9:b0c6 with SMTP id
 3f1490d57ef6-e2604b5f2bemr5869513276.11.1727584833057; Sat, 28 Sep 2024
 21:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-9-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-9-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:40:22 -0400
Message-ID: <CALNs47uC43vixDMt935BB-fuDJEKFE-SPFmSQp4Nt3v+O9wfbQ@mail.gmail.com>
Subject: Re: [PATCH 08/19] rust: enable `rustdoc::unescaped_backticks` lint
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
> In Rust 1.71.0, `rustdoc` added the `unescaped_backticks` lint, which
> detects what are typically typos in Markdown formatting regarding inline
> code [1], e.g. from the Rust standard library:
>
>     /// ... to `deref`/`deref_mut`` must ...
>
>     /// ... use [`from_mut`]`. Specifically, ...
>
> It does not seem to have almost any false positives, from the experience
> of enabling it in the Rust standard library [2], which will be checked
> starting with Rust 1.82.0. The maintainers also confirmed it is ready
> to be used.
>
> Thus enable it.
>
> Link: https://doc.rust-lang.org/rustdoc/lints.html#unescaped_backticks [1=
]
> Link: https://github.com/rust-lang/rust/pull/128307 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

> +# Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` s=
hould
> +# not be needed -- see https://github.com/rust-lang/rust/pull/128307.
> +rustdoc-core: private skip_flags =3D -Wrustdoc::unescaped_backticks

Maybe we should use something like FIXME(msrv) so things like this are
easy to find?

