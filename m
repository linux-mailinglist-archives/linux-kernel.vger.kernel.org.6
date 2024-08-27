Return-Path: <linux-kernel+bounces-303118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D996079F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8689C1C221FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E73719E7C7;
	Tue, 27 Aug 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yYi4W1cp"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FE1494AC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755174; cv=none; b=Mj1QfGFWfdK/Ler0lvK0otdjDzHK1QAFaQRzyVUwvV1iPGNl1SiLvek5k7dRkuB7DwseY8CV2WMA38d0Cs5x8R85XCel0nJo3lb2LwEnFaFpo3ajkJlF9Tch+l83JKdwzS21pgroTV+aJ7l9G/bw4+tlbPdWAd/rwuyJY60Roys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755174; c=relaxed/simple;
	bh=Krl2s3CHllIaroW+buwqKSPfUyxcPPJnsqrI9JgGizk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPwWUAcfS/R/wriGA/45HG8z3pM3BsNNilZm4Ru9BStiNjSxkGh+HjQpQ5jY2x9hdHg6Iv0qgBn1KxFSZVr9gp3sZTe2CCIVvnH/EKIVblqiJUzlfKEw6kCoSGLciVJprDVF8gwHcQVRKeB7PQLHhECF93aJ2jyHBP6rlIIb1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yYi4W1cp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so43997225e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724755170; x=1725359970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ/AMf/f0BPD7kSB4wPHV1IGoJvc8aNqKoPFMzaiaSI=;
        b=yYi4W1cpPBSe9Lf8Yt4cKsbaa+TElfHTZf5J9JicOT3138+hNpzh+HyvE2/7WvROu5
         VdQuwy1ebkboQYm1cRadg0XJ1Hf31KPsAxnuMFSy2qjTUnjNm5JVaQe5g4vvJPU9aNj3
         M3KamsZz04CgBYETNHLB5kZLwNWTAPaLxmL2UVxouwQCVfPsmtBiOTzNwJVtsZdahNGE
         H5QmUvjJelzIbfVuNHW54Kmz99Jv+ygQtO19KJtHC+eJJHC2qMo0yZxwOqqAaan6tSJ1
         P5Mrp2dAhuLIDb/hFkz4xDAbJb4xGT5pw0O3TLNb2AP4XOUUq25fl5OsH2lX8YGcYV1N
         YZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724755170; x=1725359970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ/AMf/f0BPD7kSB4wPHV1IGoJvc8aNqKoPFMzaiaSI=;
        b=rbuLKTR/xRwR0sMKwPqno31VPjcy4/9lmh5CvJ7b1Xp3a5rmWn4Ed45vJ1V77nSehl
         hKrD48tkKQr+ITP1cx2ySIyj4jL56OWDT0KA8c2sVUNsI+dKx//t6qD9Gx7vS9i/M26G
         c3ZAEq8H00QNAcUXFIihJWH8D2D3sJE7J3B2jTyAyi8Md7+xqXs2CCqD2O62iLtRAldh
         WMfZ10pGPdUvOERUzPiFQqEjXtnsmw6st4xXZ+1rXsEaDQLR6ZFgbvxy9wHXPD999dkm
         8llUrxmjwRcFK6ggBj/xD+x4vysSkcQRXTmAbU/91Gq28RWgThkkjEOfISvp5ygZf8q5
         Tz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7J1POwbsD8xk6LGOu903EemlUD33RONe2qhaQYpj803fPaHEN1a/dXbLNUh6YD9L8z+ux88YxdlktUsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya7zmjpFrCNPwMHqhciuSakJCkGxMqkb83l6LZXE30DkK9RUQA
	tTy+KFRwYxFeXspMz8RkjmF3w687NgMfstnSVpihl+EuPtdWtkf1T9lMqAZZk5hP537M4Jjfzhh
	yTykJUaZQA7X71CNseks+Hq2T9rZqSrYGkUpK
X-Google-Smtp-Source: AGHT+IHZQa+zNFYjSW5F1k/S5mySXKcAJ5QsmY1xuqJWgAZl36ax55MXXxAtLtxRs+kQBknpyHe623QMj1Zwqpe5flA=
X-Received: by 2002:a05:600c:1c95:b0:428:52a:3580 with SMTP id
 5b1f17b1804b1-42acd542433mr89374015e9.3.1724755169961; Tue, 27 Aug 2024
 03:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827100403.376389-1-ojeda@kernel.org>
In-Reply-To: <20240827100403.376389-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 27 Aug 2024 12:39:18 +0200
Message-ID: <CAH5fLghhgWdJHdOR7TYwGADecsqBtOF08+S4v3RimeFsqvdfuw@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `stable_features` lint
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:04=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Support for several Rust compiler versions started in commit 63b27f4a0074
> ("rust: start supporting several compiler versions"). Since we currently
> need to use a number of unstable features in the kernel, it is a matter
> of time until one gets stabilized and the `stable_features` lint warns.
>
> For instance, the `new_uninit` feature may become stable soon, which
> would give us multiple warnings like the following:
>
>     warning: the feature `new_uninit` has been stable since 1.82.0-dev
>     and no longer requires an attribute to enable
>       --> rust/kernel/lib.rs:17:12
>        |
>     17 | #![feature(new_uninit)]
>        |            ^^^^^^^^^^
>        |
>        =3D note: `#[warn(stable_features)]` on by default
>
> Thus allow the `stable_features` lint to avoid such warnings. This is
> the simplest approach -- we do not have that many cases (and the goal
> is to stop using unstable features anyway) and cleanups can be easily
> done when we decide to update the minimum version.
>
> An alternative would be to conditionally enable them based on the
> compiler version (with the upcoming `RUSTC_VERSION` or maybe with the
> unstable `cfg(version(...))`, but that one apparently will not work for
> the nightly case). However, doing so is more complex and may not work
> well for different nightlies of the same version, unless we do not care
> about older nightlies.
>
> Another alternative is using explicit tests of the feature calling
> `rustc`, but that is also more complex and slower.

You mention a bunch of alternatives, but I agree that this is the best
way forward. It's very simple. Only possible disadvantage could be if
we forget to remove features when raising the MSRV, but I don't think
that's a big risk.

(You could potentially pass -Astable_features only when the Rust
compiler is not the lowest supported version.)

> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

