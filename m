Return-Path: <linux-kernel+bounces-569762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B12A6A74D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A7188E17C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33420204F85;
	Thu, 20 Mar 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJtOL2eT"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B717543;
	Thu, 20 Mar 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477501; cv=none; b=VLyRCbJ+qVHxu7/7srPZg9Rp8WjhkXTVR/fjGfvRL9+MVo3pT7xRCQAZoCQmZ/1XP33j4/uHCP51ldEWe9oXhM0qh3kDKZvdJa8Niw5llVfOMNhnAttqJCnZd6CXzDwLUVVORlJTN73ZlmFwwnMh31yy6GXfbZEoaUHA3lCPtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477501; c=relaxed/simple;
	bh=gtXhXyULZcdNfwfXPHD0AkWQWHSaf4vHDVcx19mRCWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2PRPyct5zze8+nYP5ZR6VX7TnMqW2wuNuZg6tdADZ0/pKEBGt66N2c0kA11XyXuYu3ApR922Nakat67/rNCE2Sc8TpmzgAV5TaLMl8K0JM0SkEkM842nafJ37kSfgO7BhzLvkdp1mqugqN9bu9uq3Gf2mLwSW2/h5Cv6Mhl8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJtOL2eT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf8632052so8366921fa.0;
        Thu, 20 Mar 2025 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742477498; x=1743082298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8B1upTZtbZECZMaoYCcCvx8y6/lnMq3mL5DnwECOj0=;
        b=EJtOL2eTgfS5Oy6u0GrdmInYEl9Hhz7QAUmwDNN4pANFE1hjA/l3yNK9M5RK68uw5k
         ngIKH+RBAzb3bPcVsbdyTSsLMH45bXUhNreOLYmW0ZhzpUQgoasVCCXNMiS6TsIJilln
         wzcg6LTt8BeNgdpaUUcSP2zr/06/G5dRhDnTEV8jqVegBCc8Pml+sxnRs6loMi3Udulp
         JKOWSkY+fj64ecOLLEKgVmm1+KCNXMzmWUFnDEgTtmlZCIlatta0dhqEJux/fPYS6J8s
         nm4AZu4idmpohQP0iJRwTPa6LAVo/GKYiOdbQtaOMVGKDaTlrntgjv0afU9bfvP6St/O
         0qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742477498; x=1743082298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8B1upTZtbZECZMaoYCcCvx8y6/lnMq3mL5DnwECOj0=;
        b=tKF0XhqxsvVqj1qX2CqZPbHlkF2vrrb+uw9ORKCEttMExVu+cKPVIIPjfKHNjAXde9
         1SuGd6SEN6bQs+iC6GrVKn1Lxt9DGAwfaRcnL94iMjbBbMlaCLn7QiB1a9iKEs4gzaAt
         DysClRg+REbSRwkZh7z/M9QPg5jdLlk1oi6xVIGF7eGP1F+LT3UsKALurvld104excf/
         HKKAngRWt8JbYfyW09aXraTKEwsbnsXcfq+ADrUq//3ybQUFsLlhHpiefv92xhuKTTsH
         LuiAbjdYLW7Q3gzAvN2JCJ6tnntgQVnRM6o3VvKE3Iy9tiVKdqWtZ9jkoe0POt26Z12e
         AjkA==
X-Forwarded-Encrypted: i=1; AJvYcCUaXoPwh+x8c+cBtyxI+gpzgP/FDZRwpjGn2I5oL5Vve9LqirA7ZmFlmT51kEwVDdtAGb7HxOnFvFo9bI5iu9M=@vger.kernel.org, AJvYcCWiSYqRbARjkmdIZWJKfapVkblP+3U2ED0LkxqBciNBiRZSPFeYB1lVsuQ5Yb2Q3Gyrfqh+9qIRpp1VX5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7cvnSXirevTRe3EmNk4IOGPYoE2HeZjVzVekTTLZiS7pfutZ
	z/dcCINofQDfKWtIOCcXaX+/RqhHMJ8yp0Y4EqUU+s16onmqMWu+xd6zI9WYt5CvQCngv5dnVJF
	BIIlG3i+xyhofU8B87k3CYTZ4V7o=
X-Gm-Gg: ASbGncsOhJHlZ+h7VHEseP12k4kRsliOmHYf5bgMHrEZLY/0Q3A3aB0du1IJNsuY+6X
	0EmFR17rdH80VEwCKSh7zHpRgdMSpmYVAtnrNqKRCL2KNQjd8TmyA0GidkVUA3JKb04u6QUlSnn
	2S1FEYYvx5eSNpNRrWY0U7xMC77u6yaMv1oRNpxYkTvg==
X-Google-Smtp-Source: AGHT+IF+nv2K/2zpOUwEE/QxhzuHy89uvxth4nsbd7sfFLeDXUvQfc5p78zdPOpVheofgfwsUmDyCbpbOTQYWOP+aIE=
X-Received: by 2002:a05:651c:399:b0:302:48fd:6922 with SMTP id
 38308e7fff4ca-30d72b64652mr11931211fa.37.1742477497597; Thu, 20 Mar 2025
 06:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-pin-init-internal-quote-v1-1-19de6a33a257@gmail.com> <D8L34IUZGXWX.D2LSS2S2NAN7@proton.me>
In-Reply-To: <D8L34IUZGXWX.D2LSS2S2NAN7@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 20 Mar 2025 09:31:00 -0400
X-Gm-Features: AQ5f1JrA7WGJHD7z0A-iUxRx5DO_fTCLp3uXTL872ztgyNau-yPu2V8hUCdS64k
Message-ID: <CAJ-ks9nTmno12ZC4DnLxV_b0NLUK5Kn5K+cRi4BEvKtveQzJjg@mail.gmail.com>
Subject: Re: [PATCH] rust: pin_init_internal: fix rust-analyzer `mod quote`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 8:16=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Thu Mar 20, 2025 at 2:35 AM CET, Tamir Duberstein wrote:
> > Replace the `#[path]` attribute with a symlink to work around a
> > limitation in rust-analyzer that requires all modules to belong to the
> > same "source root". This allows code navigation from `pin_init_internal=
`
> > to `quote` to work properly.
> >
> > Link: https://github.com/rust-lang/rust-analyzer/issues/3898
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/pin-init/internal/src/lib.rs   | 1 -
> >  rust/pin-init/internal/src/quote.rs | 1 +
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal=
/src/lib.rs
> > index babe5e878550..fdd95afe3864 100644
> > --- a/rust/pin-init/internal/src/lib.rs
> > +++ b/rust/pin-init/internal/src/lib.rs
> > @@ -20,7 +20,6 @@
> >  use proc_macro::TokenStream;
> >
> >  #[cfg(kernel)]
> > -#[path =3D "../../../macros/quote.rs"]
> >  #[macro_use]
> >  mod quote;
> >  #[cfg(not(kernel))]
> > diff --git a/rust/pin-init/internal/src/quote.rs b/rust/pin-init/intern=
al/src/quote.rs
> > new file mode 120000
> > index 000000000000..27a213d1a6ba
> > --- /dev/null
> > +++ b/rust/pin-init/internal/src/quote.rs
> > @@ -0,0 +1 @@
> > +../../../macros/quote.rs
> > \ No newline at end of file
> >
> > ---
> > base-commit: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
> > change-id: 20250319-pin-init-internal-quote-b7e15e9e8233
> >
> > Best regards,
>
> I'd rather not have this change, since this will introduce a dangling
> symlink upstream [1].
>
> [1]: https://github.com/rust-for-Linux/pin-init

I agree it's aesthetically displeasing. I'm not aware of any
alternative that fixes the development workflow of this crate in the
kernel.

