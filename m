Return-Path: <linux-kernel+bounces-388864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71FB9B6564
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF61F225BF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06B41EF0B9;
	Wed, 30 Oct 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY4xOLpk"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF41EABA4;
	Wed, 30 Oct 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297661; cv=none; b=CKUxbgtpFivaRKQq4Wh3DLsInHfo93qgbSQTjd5st3OifBsfSRr0hOhBFOJeKu6Vf/BPP2PE3Gl9e/KCh3K+EYCSvQvzSAP273TiV8l9Nu7mzid8hosOFXklyKMQdhfSGJh2m9rfFElmL5s9llXOikqX/KUSm+WGXLaFJuje3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297661; c=relaxed/simple;
	bh=lm82dG4gEMFUUwjiq5PdNc9pfTbs1IPJ2CYyR+z76lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8SBs6xuWC3MapGzk5WZCA+ir0rRCZCIFNRvyVBZuDGMNfLU/Vi8nVkRi/dGQxFoGNYpZatzTHKOORu6lqqnNzmeLIKNzo6/aTXMNDpuBTKM7tE0WrEVfsRQ/Wi27WnqiVqOMz8MgDdsYnxx0tgWvkfmfZVf+9Hlm04zgoDmpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY4xOLpk; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso64504841fa.0;
        Wed, 30 Oct 2024 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730297657; x=1730902457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjEYIiKosyIkwaGCSTQKyunT1Lv7dxar/a+ft9/60k0=;
        b=hY4xOLpkB0N5U2lPdZkeF28s1o901OyRdyICFajaPSrpdLNICj/OCOkL8qvh5h9A2h
         dxJT6QKw02l9jHwrMyxr7uzYfmlRv9m8UDWpjgTWE9PhucnvHHuFUnbYBc6EjL4d3bEv
         3t3bMUKYQk6wnUrVUfwHF9D+RriJ7DdHfZ7uIjUmkdm8m5dfqbcSRrac4AOr38xfqUOa
         9v5wpgCvv813qBYaFoi+0LLGL47AafwHtmouES1dT+8BNbrYFvb2+AzA7rrg9TAXwQIW
         6Bwza4IlE0qaL+d1nTT41DIVzrX0zHZrZPseksZvSwuFmjbu5EHfF2UbLLwZvPcx4Heu
         nCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297657; x=1730902457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjEYIiKosyIkwaGCSTQKyunT1Lv7dxar/a+ft9/60k0=;
        b=kt5Yrzh5wHiIxzJMeb8lq1rdbuaXWzqki8ARB4mdYR3ZyyoorLHcd6LgUOwYLAiOfL
         Ah8RWHrZ8U+MdTYIuvasTTbo/28BrTCd0aiNdPjRHh5KOLy0Bmuq6pv6G2f5clF5hwWT
         vfAMUuwqTDotcD+HwpcFyczjfiylm3CvaE+sZ+lbLifnURbaJrqmESuwTBkFrhYcluCX
         UElmWeP4ZUc/5xtdJBb2b2gogGuINb6fVZxYTzNTN1xeZtobmu4VvMYhNfgPlO/vl/4r
         D8UWoU8TLMPdmqsgJH1yXf3j+8hxcy2OQl+AJJ8f0HXriiZsNLtJj95eDDKhGjYsPDRS
         JESw==
X-Forwarded-Encrypted: i=1; AJvYcCU2JxYxF0Q0+KI+rYk/c/1Qmnekp5tKdKCRUIEDzrIlhykh0oA46ZjQEnMeyLiAGhojPdjyJe4KXjYzbkX1ci0=@vger.kernel.org, AJvYcCWQ4wD4Olu3Iy9nnlqkuu8v/tZaIVXCgAxEN4akvfggdRBJFTIGoagwEaRMuHn76HPxMQoo0dWgv5BMfEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMw8OxsbbAesI2qQCZ/lYi16Hh4lTqvYU+WlrUMu6s45cVDDiC
	FjvsigQZuH3Fg7DnC8eUCeT+Bn+6X02ytp0K/gSgdCZmduvyz3L96KYx9QzkaOvq6QVaZlufjIG
	4BHCmpPInQN4TJV/8qWfzvJjynZM=
X-Google-Smtp-Source: AGHT+IGdMnV/z71AQCWEOuBcJ9BI2pfv9dIvw2BJ2X9O2ZlhjIti22LPzo+oXDns9q2mEY122Yj6P6Hohr1Ta1EbEzs=
X-Received: by 2002:a2e:a543:0:b0:2fb:61c0:103 with SMTP id
 38308e7fff4ca-2fcbdf63825mr81608301fa.4.1730297656743; Wed, 30 Oct 2024
 07:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-bindgen-libclang-warn-v1-1-3a7ba9fedcfe@google.com>
In-Reply-To: <20241030-bindgen-libclang-warn-v1-1-3a7ba9fedcfe@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Oct 2024 10:13:40 -0400
Message-ID: <CAJ-ks9=8Bo94Fg_By956ce8X0r-6xBWGO_Ka+rCQ2h3tF2nkRA@mail.gmail.com>
Subject: Re: [PATCH] rust: warn when using libclang >=19.1 with bindgen <0.70
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 9:41=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> When testing a clang upgrade with Rust Binder, I encountered a build
> failure caused by bindgen not translating some symbols related to
> tracepoints. This was caused by commit 2e770edd8ce1 ("[libclang] Compute
> the right spelling location") changing the behavior of a function
> exposed by libclang. Bindgen fixed the regression in commit 600f63895f73
> ("Use clang_getFileLocation instead of clang_getSpellingLocation").
>
> However, the regression fix is only available in bindgen versions 0.70.0
> or later. This means that when older bindgen versions are used with new
> versions of libclang, bindgen may do the wrong thing, which could lead
> to a build failure.
>
> I encountered the bug with some header files related to tracepoints, but
> it could also cause build failures in other circumstances. Thus, always
> emit a warning when using an old bindgen with a new libclang so that
> other people do not have to spend time chasing down the same bug as me.
>
> If you encounter this warning, it is recommended that you upgrade
> bindgen to 0.70 or later.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  scripts/rust_is_available.sh | 12 ++++++++++++

Might be time to rename this script - in another patch of course.

>  1 file changed, 12 insertions(+)
>
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index 5262c56dd674..30695612a0d7 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -225,6 +225,18 @@ if [ "$bindgen_libclang_cversion" -lt "$bindgen_libc=
lang_min_cversion" ]; then
>         exit 1
>  fi
>
> +if [ "$bindgen_libclang_cversion" -ge 190100 ] && [ "$rust_bindings_gene=
rator_cversion" -lt 7000 ]; then
> +       echo >&2 "***"
> +       echo >&2 "*** You're using libclang version 19.1+ together with a=
 version of the"
> +       echo >&2 "*** Rust bindings generator '$BINDGEN' from before vers=
ion 0.70. This"

Maybe `version >=3D 19.1` and `version < 0.70` would be clearer than
`version 19.1+` and `before version 0.70` respectively.

> +       echo >&2 "*** combination has a known bug that may lead to build =
failures."
> +       echo >&2 "*** (https://github.com/rust-lang/rust-bindgen/pull/282=
4)"
> +       echo >&2 "***   Your bindgen version:  $rust_bindings_generator_v=
ersion"
> +       echo >&2 "***   Your libclang version: $bindgen_libclang_version"
> +       echo >&2 "***"
> +       warning=3D1
> +fi
> +
>  # If the C compiler is Clang, then we can also check whether its version
>  # matches the `libclang` version used by the Rust bindings generator.
>  #
>
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241030-bindgen-libclang-warn-cebf97ea3506
>
> Best regards,
> --
> Alice Ryhl <aliceryhl@google.com>
>
>

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

