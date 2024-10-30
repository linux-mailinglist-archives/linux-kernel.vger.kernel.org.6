Return-Path: <linux-kernel+bounces-388952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5819C9B668A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D852819CF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC901F7078;
	Wed, 30 Oct 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZkVBjZE"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D31F4277
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299948; cv=none; b=bEy13kt8eqVlZqwML9pT0bCrqAk790tBpvtX6wnN6xtmOUDQ5P8p2lp6+6mDGBleQ4nl1W9DHoCU42YqmR+usTdHAYTIynpi21IJjIDh0MhoQtNYSlYNxhwkbzh5UNicCEGjHar9Xh2t2mfH9HmJ7O7golS3FDRJJugQCGJEZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299948; c=relaxed/simple;
	bh=CnqspzQJDbcEt8CN7RzD+XIZAwYYdzUkf98BJ2/Pus0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1+gwKntrYGQm0mkaCcGmO7mYFiNUdyWKP+rdS6JO0Z7235Abctq+GEzxCP37gRoXyqM/lF5lXI7j0aEyD73fqGbrVgbfpqQYZ/ul6QsLGWmVcGapLUsGJBQAx6CnMy8kqluM0MLa+y0J/dgkVoUKDIm7hNT5C7GhRVv+HlsBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZkVBjZE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so224205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730299943; x=1730904743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQVFTZ7PEDYj3PNRsJwqRC83zORWsozaW2gJdNeeReo=;
        b=BZkVBjZEtY/VSJJBGFupBKBRDt7LEdaLoHvHLcYkKRJSFWlqnW1nc71GsIKAxpmVaF
         ENLZqmI8JYg1zpRUSuBlTScCpSaW9S1jJ6JZkHcvFuXwI0Mze9F5K3wcWIk579D/d97t
         Pvlc+501d2rSEkNqoosXJ4SZ0LuLDm2WzTNyjGo3O572zBGImC+OShFO6dbiSJhP5xur
         AyPxoScQ0TBVTj8LY+u3Bwvn42hE7Lz4F7loKhD+cBF07CPZ7FPlcb3LgE4DR8rMI8ww
         f9vc62hGTWkY/L4pyxUZ17ZnAGi8mstsYAcbNuI8CfKdMW57uG4BTmBJhHIzqhN2I+r0
         zbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730299943; x=1730904743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQVFTZ7PEDYj3PNRsJwqRC83zORWsozaW2gJdNeeReo=;
        b=lE8lui6vMEE77u38rXW05L3iJNNmlwqqUj4HCAgo6rqZFxpoO9/XsPAcovxdxW2iF5
         0BlgoEr+bkM3vthpZhAOeUFAckW9dHzPZNZ+GskGTRp6VsrHT4KkAeUnp6w+v0qxvEQP
         vEpfPcjk8U/tBHRSYwqGyqYFe/unkfaD7l+K2nQQoMlx7MG+2SjWLU5PmK2NxUYyPMCN
         lwLuNZ6AUhLyIGRWom5+SuV3oOzTta/6aY8KGpbtWU0W8twoxJfhul1FMUKUIg/M6rzw
         yFS4ah0Li/HHr5vGUlW86falxSucI1E1+cdTkSOSed2dNv2AdoCJ1H1eEWEx8G+IRqhi
         ud1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpxCd3rojCMSc4fN3WP9/g9VjsYsUInuF3RcngbP+EWqfABTtzX7oG7roBzBWaPmjhfMIet7+9KhBZPvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77M4LNxQmERc1RvixjUQ5Qx1yBi/c42i3IE2P5JNSuNr5+DxF
	01zmZFhNTlI2D07lTWRpw9i5v4YVx3IGbwwf4EMiPrSxv2RIqoGTVWhYasHmWg+iVpKswKPTbPz
	soP9ZUdIoB38eisQIv8m8oToozqKfqjGxdo2Z
X-Gm-Gg: ASbGncv5z43B/FKp0iilNWFtrX2D+TQIRcdNxEYRvOU0IcEcpjvDfCA6GIOeiVJ0R8x
	pEYqd5kqesznHrOaOZVMpBFq9md0M
X-Google-Smtp-Source: AGHT+IGL5BtkrvM8HTgS2rSp77gYVDKzQwCNJqBnp5ZX5IGgEF0dDY9UEHGCgoNirzA9uBYFvA5Z8gdr6YSS/UJaDso=
X-Received: by 2002:a05:600c:3aca:b0:426:66a0:6df6 with SMTP id
 5b1f17b1804b1-431b3c4c915mr10794795e9.0.1730299943257; Wed, 30 Oct 2024
 07:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-cfi-icall-1913-v1-1-ab8a26e13733@google.com>
In-Reply-To: <20241030-cfi-icall-1913-v1-1-ab8a26e13733@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 30 Oct 2024 07:51:45 -0700
Message-ID: <CABCJKue6ZmqpkrMToF3B3_xTZDgkFKxh-CSZOJU9pt02aDd8bw@mail.gmail.com>
Subject: Re: [PATCH] cfi: tweak llvm version for HAVE_CFI_ICALL_NORMALIZE_INTEGERS
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:31=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> The llvm fix [1] did not make it for 19.0.0, but ended up getting
> backported to llvm 19.1.3 [2]. Thus, fix the version requirement to
> correctly specify which versions have the bug.
>
> Link: https://github.com/llvm/llvm-project/pull/104826 [1]
> Link: https://github.com/llvm/llvm-project/pull/113938 [2]
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202410281414.c351044e-oliver.sang@=
intel.com
> Fixes: 8b8ca9c25fe6 ("cfi: fix conditions for HAVE_CFI_ICALL_NORMALIZE_IN=
TEGERS")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  arch/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 00163e4a237c..bd9f095d69fa 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -855,14 +855,14 @@ config HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG
>         def_bool y
>         depends on $(cc-option,-fsanitize=3Dkcfi -fsanitize-cfi-icall-exp=
erimental-normalize-integers)
>         # With GCOV/KASAN we need this fix: https://github.com/llvm/llvm-=
project/pull/104826
> -       depends on CLANG_VERSION >=3D 190000 || (!GCOV_KERNEL && !KASAN_G=
ENERIC && !KASAN_SW_TAGS)
> +       depends on CLANG_VERSION >=3D 190103 || (!GCOV_KERNEL && !KASAN_G=
ENERIC && !KASAN_SW_TAGS)
>
>  config HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
>         def_bool y
>         depends on HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG
>         depends on RUSTC_VERSION >=3D 107900
>         # With GCOV/KASAN we need this fix: https://github.com/rust-lang/=
rust/pull/129373
> -       depends on (RUSTC_LLVM_VERSION >=3D 190000 && RUSTC_VERSION >=3D =
108200) || \
> +       depends on (RUSTC_LLVM_VERSION >=3D 190103 && RUSTC_VERSION >=3D =
108200) || \
>                 (!GCOV_KERNEL && !KASAN_GENERIC && !KASAN_SW_TAGS)

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

