Return-Path: <linux-kernel+bounces-538848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC99A49DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709543BE488
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D92702B2;
	Fri, 28 Feb 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtoqqGei"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2E1EF366;
	Fri, 28 Feb 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757425; cv=none; b=U99X1FhT69h/YWRTqyRZMHnv+leX5IOdqJH/QqS/gcxfqxvq3oaARi/BwhDaPAfKFkvdlYf7Vr2nFUC5zpp8lGzMNKMMCrKLMvsL8C71aLgyfSbvQICaMaxTYB2Rrrlw1Zq+8ZIG6cgaCTL358i3iHCF8hBcJClvyn0jQ7CQXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757425; c=relaxed/simple;
	bh=Mwxp7fWh57muJ79bmMwuri6+CFcJRk6JKHp4BpFMV0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNfTBXBg37e7hTi18crrzXeTbW0Twn+uorcfnlQmmzgO86gkV85y8ZQTISW+s1K5YpNXTfxwwHoeSSwi0qr4TZnurKp6PQQjq0JEKzZ3y84y/80d4dcWJD47U9UPNeaxvVKndox49KVNNPOy2ib8cUceTYsVsy4z0SR7PNLuIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtoqqGei; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fe5d75ff8cso592444a91.3;
        Fri, 28 Feb 2025 07:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757423; x=1741362223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb2U97DDdzxwdyEir0Iv6h63iSbnYqe/duqVh4GgZ0g=;
        b=AtoqqGeiqzgW2xFeSCYUw81Y0RDm9yxFlf9NYgfaHcdKCmrkwZOwv6lRLpPWStsg5D
         5Lq31VfhXCgeSvStqRcV4yv3ufJXllIRNS01YX7udX38UxxsHeU8QN7yTT+cWyWyIBAF
         8fE0JpIJTdCs1bZ3UXCLkrwUf1jOV1SGVBzoXHiiDS7viaI0Reb7quYPVDxS16BiDuNy
         QC6rjPHZxqNWZYbrK78YZMaua2bMUxekyM/hH2SXMzAITOhQ5+XhhDUrzdOdPUGFL0+g
         EDRmu2X6kcYs4Kt5slGoMa7ZHi+zUGYguNBdhJ4hlxBDGkfEsvuzro6iZZnMz/+oJI1M
         47/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757423; x=1741362223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb2U97DDdzxwdyEir0Iv6h63iSbnYqe/duqVh4GgZ0g=;
        b=tvnwjm98jzZT6HAXd+bgZDuZChOlhZ32s5v09MWUCN2mdXLMufT/wH6678CXvYxdRB
         dlHUUsRW0P67NUdUfjZgRWiNewb+kOvXeRLG04cyot/FDV+KtVPB6CAvrdTzueJDuXhT
         K/dfzVkThYC25o/BIwHfGvo3oNklf9OduaXg0WxOr2DYbL67FPN8/O0bjXja/ioLgtxv
         fKyfn29XSHd/zSPKNgCl/PpXDeA7oiioDyk6vusrxHZ5WPuESkBfyR5h889qMJlznAWo
         2+78w0SPCpmG2EVCHWdmm7fFlLY5BNIpQwPfLbTCHUAP7MYi+3JWS++1WSZrVag+yLya
         911g==
X-Forwarded-Encrypted: i=1; AJvYcCU1Lk9NJHdko6YpZ5GwG/D9ieWP+QfqxQdUzcbgPbONl9p7cxbWrXtG/hFCVfrEUm1ykXyFQE7Q3jP+G9Y=@vger.kernel.org, AJvYcCVaYewTndo4jbD898Kxky7t0rtRNvlJId2bQEMHkB6K/6yB8tchOOYGI3hdmmsd+wIm61EafSJCItRZdWz0ksA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdRhUHYcSPgxDSdCssIAblpkubp2uGS7TrHfgjmd/YeamilFEm
	RHv39XUUKx4/uiOYUv9GesN/AuPSNefvyZpW3OtFCxu30PAT/5uExfin7spt/QP0G2S1Qndjlzh
	9cCETC+5zhQdbjXggFycrxLsf6bk=
X-Gm-Gg: ASbGncthIdw9Ga97jSbDU6ks8d93GEo5TJQvnL+8ccb85kwoY0dakOoi9OMuHNTUDGr
	K7rjcno4dQC+7fJTJ2M4Tf4PDsR/R4ofU9/X09RDth1LxrPnB91/9DD/TtxhQh4cTPI1A7LN0C9
	XgQIxswLs=
X-Google-Smtp-Source: AGHT+IEaMRx1TPdDq9q3j9YOLGbnxNgJLGf0PUg2Nz40DrGCUiOOqKPDdHa6a84tFD9tR0ndWWK8ewFqBxC6ZNCgG9w=
X-Received: by 2002:a17:90b:3b8d:b0:2fa:6055:17e7 with SMTP id
 98e67ed59e1d1-2febac10932mr2460393a91.8.1740757423425; Fri, 28 Feb 2025
 07:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228132928.880683-1-guillaume1.gomez@gmail.com>
In-Reply-To: <20250228132928.880683-1-guillaume1.gomez@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Feb 2025 16:43:29 +0100
X-Gm-Features: AQ5f1JrudrTcjO7fEhP9TqP7zOFRXSPccW98GtWaABxTyV_YDsXX2BckGPTVAqM
Message-ID: <CANiq72mENfqG6iNjgXpq4LVEceZ4174yGhg-RB0MsMxLVed-1A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use new `--output-format=doctest` rustdoc command
 line flag to improve doctest handling.
To: Guillaume Gomez <guillaume1.gomez@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 2:29=E2=80=AFPM Guillaume Gomez
<guillaume1.gomez@gmail.com> wrote:
>
> Before this patch, the code was using very hacky methods in order to retr=
ieve
> doctests, modify them as needed and then concatenate all of them in one f=
ile.
>
> Now, with this new flag, it instead asks rustdoc to provide the doctests
> code with their associated information such as file path and line number.

Thanks for doing this (and the `rustdoc` side of it!), and welcome!

Normally in commit messages we need to give more details:

  - A Signed-off-by is required (please see for what that implies).

    https://docs.kernel.org/process/submitting-patches.html#sign-your-work-=
the-developer-s-certificate-of-origin

  - The commit message should explain the motivation, i.e. removing
the 2 unstable `rustdoc` features, and moving to the new,
intended-to-be-stable one (which one? etc.), and so on.

  - Also, a bit of context (or at least linking to it) would be good,
e.g. explaining that we were working on removing unstable features,
and that `rustdoc` provided a new flag for the kernel, ideally with
links to the relevant Rust tracking issues/PRs (typically with a
"Link: " tag), plus which version the unstable feature is available,
etc. (well, when we know for sure, i.e. I understand that we may need
to tweak it still).

Anyway, those are procedural details we can sort out later :) What is
most important I think are the following two notes, please see below.

> -       $(RUSTDOC) --test $(rust_flags) \
> +       $(RUSTDOC) --output-format=3Ddoctest $(rust_flags) \
>                 -L$(objtree)/$(obj) --extern ffi --extern kernel \
>                 --extern build_error --extern macros \
>                 --extern bindings --extern uapi \
> -               --no-run --crate-name kernel -Zunstable-options \
> +               --crate-name kernel -Zunstable-options \
>                 --sysroot=3D/dev/null \
> -               --test-builder $(objtree)/scripts/rustdoc_test_builder \
> -               $< $(rustdoc_test_kernel_quiet); \
> +               $< $(rustdoc_test_kernel_quiet) > rustdoc.json; \
> +       cat rustdoc.json | $(objtree)/scripts/rustdoc_test_builder; \
>         $(objtree)/scripts/rustdoc_test_gen

We currently support versions 1.78+, so we will need to do these
things conditionally. I can help with that, so don't worry too much
about it for the moment (e.g. we have `rustc-option` and other helpers
to pick the right flags given a version etc.).

Similarly, we will also need to tell the script whether to use the old
or the new way, too.

> +    // We replace the `Result` if needed.
> +    let doctest_code =3D doctest_code.replace(
> +        "fn main() { fn _inner() -> Result<",
> +        "fn main() { fn _inner() -> core::result::Result<",
> +    );

Hmm... I was hoping we could do something on the `rustdoc` side to
remove these hacks altogether since we are going to have a "proper
flag" for it, i.e. to avoid relying on the particular "format" of the
tests somehow.

I wrote about a bit of that here:

    https://github.com/rust-lang/rust/pull/134531#discussion_r1894610592

> +    let doctest_code =3D doctest_code.replace(
> +        "} _inner().unwrap() }",
> +        "} let test_return_value =3D _inner(); assert!(test_return_value=
.is_ok()); }",
>      );
> +    std::fs::write(path, doctest_code.as_bytes()).unwrap();
> +}

Same for this.

> +    } else {
> +        panic!("missing `format_version` field");
> +    }

`expect` maybe?

> @@ -87,8 +87,8 @@ fn find_candidates(
>
>      assert!(
>          valid_paths.len() > 0,
> -        "No path candidates found. This is likely a bug in the build sys=
tem, or some files went \
> -        away while compiling."
> +        "No path candidates found for `{file}`. This is likely a bug in =
the build system, or some \
> +        files went away while compiling.",
>      );
>
>      if valid_paths.len() > 1 {
> @@ -97,8 +97,8 @@ fn find_candidates(
>              eprintln!("    {path:?}");
>          }
>          panic!(
> -            "Several path candidates found, please resolve the ambiguity=
 by renaming a file or \
> -            folder."
> +            "Several path candidates found for `{file}`, please resolve =
the ambiguity by renaming \
> +            a file or folder."
>          );
>      }

These two bits could go in a first patch, I think, though it isn't a big de=
al.

Thanks again for getting us out of unstable in `rustdoc`!

Cheers,
Miguel

