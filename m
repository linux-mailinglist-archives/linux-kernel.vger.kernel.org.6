Return-Path: <linux-kernel+bounces-563017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E01CA635B7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 13:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEBB3ABB0A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEF21A83FF;
	Sun, 16 Mar 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMCKlgFm"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D019CD17;
	Sun, 16 Mar 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742129864; cv=none; b=k5Gqld7EbuPzfM0YCQIMI1daxwVWJlNfnyk502HW9D/BiYfHMEOm1KXaSQlvRcHJWlN6nK6/V/p09WI/k6VNqtyK3nljac/+PV74R58aERHToFjAvnT2ea1oaGWjY8rLeCsAY+lt/h7gjw3rouAoL8NKTyBuqJY5pPOV2tQqgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742129864; c=relaxed/simple;
	bh=qyO49BsrB+oWu2FE3bZEmtR4e4T5f7YS5toUZHn3w8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lj2PW9ip7Q6LuUUNPOsIpUYmhN/StWRpL+RBa/VgVK1WoluEYRnCOMP5J6VL6fX9A2c6r4jzJ5VawsGdZHsLMBpr3JaiTTHdyK6IS9TRmbJP3/oxdf2P+0A0hVpElfDjHGetT4UX7C9h1MQfDDjCh5ByNOKAtMS9LOr9rThQT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMCKlgFm; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a59so39637121fa.0;
        Sun, 16 Mar 2025 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742129861; x=1742734661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JY3+gZvsQCAKPjn/35sGgpLKMuRQJgJmL55nCwysRs=;
        b=ZMCKlgFmm4O+zWICNqIFQcgtAnAPVVfAKOweOgDjVp7t805zM9mu2YhZV5HNrTT5W4
         XzUxnsJMSIyuKJ/q0MVg6vwG7YLqC530Iu8hx6eYZrDKwXLLdvS41ChaU9iit3O32q62
         9UrGMqam3V9GE3gL1R1acfYRYrLzyouonsvWxJJd+f5tahlG5SpwMekX/gqG2HOV9BuG
         IiEbazPNJUUGNFp2u0JWLqsHgtGRZzMAq/FLoN3MbH9uSsbxXpawZxcjWQsFMok5IRPB
         vv8Mtz8/b/R0/f09IWamuWXNqO9D3zxoYUTfwirGBE3A+D8BWGaCIrIuGOeZLSG5JAf0
         Evfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742129861; x=1742734661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JY3+gZvsQCAKPjn/35sGgpLKMuRQJgJmL55nCwysRs=;
        b=HrCYMG0FWQkAwA0OvWqiBP4GuMjLFL9h6Gm8WFYSw6EBTdYpL8kbZ07xd7HqsVfbPK
         /GnXJqfSRoIrtHvpjt5RpS4PRMoa4OAQJ7sJl1YQllBYrp9puAWfqUtdT4ro88iMjy6z
         Yc7ToVpGhuRzpHnTl/1wcLdP0zDdjLmZmzl2CkLMArKGZvf9K8vCFHyOmN8uIuoGS4KR
         u/K2xqRA1qcAkl6SeQHFPF3ybU9fuUlphNHBvS7aGpwxGq/+GtA7fQHtUyDSVTcOqWne
         gdvz8qRD8YChrG/1/blnQJSBjW5M5XOdy4QdHKqmWTi0NhhMG87rkOb2/5s5m7UD8EjN
         uy1w==
X-Forwarded-Encrypted: i=1; AJvYcCUOfHer0eSNnIfn/MFVuvcuyigLU4lEqT4HB7y6Fbp0ToLwJ7DcLHUd5gtO5LBSM5uuQpw/Pl7UqdBucCI=@vger.kernel.org, AJvYcCWcKLF518PEzMXzzH/+sDRkPCxerGeThrb60Ai1rJsx0xm7UBgJGbSZE2eDcSos7h4Sg7BPzLhOmT99FjAfn3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJ/E129v4sx4+I/C55o8QOdKgDtGK3nvHsxzMGmVcE/fo1wsP
	q/zFeA9sXbKGfVhNijdrhHvpc9NZV/mSrmWG8Dd1P7OGjW1OF7+CPcZHcKgPpmATECXnkeEcs7z
	DaGtn1fVifKIi8jgioWAc0J+C81s=
X-Gm-Gg: ASbGncvnjlK8tcxRIwXK9F56fz8NZmRl6Z+gCjy1IvUoNvvzNZSICoJzc8oBAxQGV4w
	Gbnziyd7GkFbPmwoNq89DaeLiWldh0328nbaJpHroUJ3tP6Cc7fcNy21nMU2PoyrnE0v+7+41gt
	BTBcerWr0sDoZbMcqmztCkqKCwOBfy4vD5q6pIr483d0ikkk2Cx+QjlQAw/+Xs
X-Google-Smtp-Source: AGHT+IFTL5w+to2vvj7wboKx55x/7iOZBQbyy0jqpqrGkj+hkmPD1Sq0AwcDFIImS2z5PzdSCWpEK5G9N7GDEBZag0Q=
X-Received: by 2002:a05:6512:4029:b0:545:2d4d:36de with SMTP id
 2adb3069b0e04-549c3922a93mr3691443e87.31.1742129860905; Sun, 16 Mar 2025
 05:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316061429.817126-1-contact@antoniohickey.com> <20250316061429.817126-17-contact@antoniohickey.com>
In-Reply-To: <20250316061429.817126-17-contact@antoniohickey.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Mar 2025 08:57:04 -0400
X-Gm-Features: AQ5f1JppUsEbWsUorvGmyhZZ80Nk2uVHUVqf2xCQCmDZIU7XuhyuJYf6g7hD4OM
Message-ID: <CAJ-ks9kMeb2xFaUOu=L3JYq7V7FsFjmDkbJieiUN0cdK9hhWnw@mail.gmail.com>
Subject: Re: [PATCH v4 16/16] rust: clippy: disable `addr_of[_mut]!` macros
To: Antonio Hickey <contact@byte-forge.io>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Antonio Hickey <contact@antoniohickey.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 2:38=E2=80=AFAM Antonio Hickey <contact@byte-forge.=
io> wrote:
>
> With the `raw_ref_op` feature enabled we no longer want to
> allow use of `addr_of!` and `addr_of_mut!` macros.
>
> We instead want to use `&raw` and `&raw mut` to get raw
> pointers to a place.
>
> Note that this lint isn't currently reliable, but we enable
> it nevertheless because:
> 1. Document that one shouldn't use the `addr_of[_mut]!` macros.
> 2. When the lint becomes useful we will already have it enabled.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Link: https://github.com/rust-lang/rust-clippy/issues/11431
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> ---
>  .clippy.toml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/.clippy.toml b/.clippy.toml
> index 815c94732ed7..95c73959f039 100644
> --- a/.clippy.toml
> +++ b/.clippy.toml
> @@ -8,4 +8,8 @@ disallowed-macros =3D [
>      # The `clippy::dbg_macro` lint only works with `std::dbg!`, thus we =
simulate
>      # it here, see: https://github.com/rust-lang/rust-clippy/issues/1130=
3.
>      { path =3D "kernel::dbg", reason =3D "the `dbg!` macro is intended a=
s a debugging tool" },
> +    # With `raw_ref_op` feature enabled we no longer want to allow use o=
f `addr_of!`
> +    # and `addr_of_mut!` macros, but instead use `&raw` or `&raw mut`.
> +    { path =3D "core::ptr::addr_of_mut", reason =3D "use `&raw mut` inst=
ead `addr_of_mut!`" },
> +    { path =3D "core::ptr::addr_of", reason =3D "use `&raw` instead `add=
r_of!`" },
>  ]
> --
> 2.48.1

Consider using the word "disallow" rather than "disable" in the
subject line of this commit, given that this is the word used in the
clippy config.

