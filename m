Return-Path: <linux-kernel+bounces-320469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998CB970ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1389F1F215F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 00:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92439A933;
	Mon,  9 Sep 2024 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aR9v31CI"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9AC193
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725841811; cv=none; b=IkUHZcV8U3WXW3o3m1mtmOs7u6lSKxWgMrQyH/6KIHh1TJcZjBaWznXlMuqZhis5lyb3fnd1ja7ttJMfMq/L6L00yivYJFCr1xRYPgxz2lsRRidoyKIYDYSFPPGtSb+8Z3x4/763gNJIGYK+9rrfDYj7gairkspbxjjtiVNBC3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725841811; c=relaxed/simple;
	bh=WKgDTUCCgtaz7HK/6klsNdbV5jsdqfsckL/4sEAMpOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTxm2aiGWyRPOsMC2aH82tNGeb2eFesx9OVWlp7iWu3GqRELGX/BNWs7HppioreKHs5JXErghAOZ4HnPA9rEYwEb2MjGlymVZmU9k9mHrObJ4P0bdgxiCvVzc05fcW6nJoCeZHOr8oTnEbUaq7zMsCX8iCc2T/Ru55S5x0G6Aj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aR9v31CI; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39d41b61178so422455ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 17:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725841808; x=1726446608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzWtczCuQJEE//3oD8ytfGgUcpGMdIcjSJ+8lWxc07M=;
        b=aR9v31CIihHOIJALbkSSzzxek/F+LvbferEc4p8LSLcOX7mnv4cN9I/E+p91rjdyWa
         k+b7ssNQBSMZliS0WE0BpJtiIIWVDPHuKexETNgQJJT2RNNEswf8pxsrLSw8hov6Dvz+
         xntXmanoYl8Qx3Ym3OZeMT0Jxt6KCraQwvDujw4i7qk1ziECToS6RJAuiYToUtlNPtBy
         ldSozB86XjWPsG9SlkDGvR1mw1+zEvL76pkgyev4kNPg1hyAhPOKNkDYrA68Z+zQ/ion
         iSPaT0EQSa2g+p4xzi2OtbEMyhfrVOG9lyjuIGt8QB+AGw4sS3x194LLz8VjqQGMC96I
         7yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725841808; x=1726446608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzWtczCuQJEE//3oD8ytfGgUcpGMdIcjSJ+8lWxc07M=;
        b=GRnfCwEsrB8binO3A32tcSGsr472n2yjjI9brhH4zfwU8oIyhrXosXvvWii1DH2HbP
         Su7HiikxH+XfbUWJhoLpd14ajbEuYBdfCI5T0rgMJAGGB9mbG44PiqmEAdIvEunSLS6w
         3+ETqOOWt+Deo+1ROxx1n1rS693cSqzbJ+URgUiGRfFKIkQFjkZ2S+SSjSoro/5Wn3K0
         SzMxAsDKLaXpcjCDsbtFMJfvaz9xiwy9/Mev0M5w5gW8xfQ/U2tJPjVKiNhQZMt8ejkx
         ZewRNLJBuxtEYc54CWJHxOkbm7VwHzAPQmQmzOxujZZVSWXNW/BjbW3jiXqh4WChp5TO
         uMTw==
X-Forwarded-Encrypted: i=1; AJvYcCWW81ou+2+zRfF6B9JwC2PQSbFJKnqHHmwZkwi0T/fWpBoM9G69lJYqGxvO1lc55PyWx6xF3q5dXR3ozdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsgKCB/YRdkHA/RhcWG5b7CE/CBgVfgzlqsLqVVQiQ2vT+Mpii
	K/yOckIg+y1pxmjyJfVpOwEA61JpdwUbhUIx68CaSCOXzIzkYiElaBBZkCLvYYeRfutrNlteFgM
	5N+YEZ0c1b9cikjc0sIe/Kop7yGVLY5WtzFSb
X-Google-Smtp-Source: AGHT+IHOI75SbCP2ecalhMEuqj0tZIDEkkGR2qFHnHxzn1IVb0IipPvs9HPoy2IMKDUvyhRHHypRGtSPLWf/oCMOZvo=
X-Received: by 2002:a05:6e02:1c2e:b0:39e:68d8:2891 with SMTP id
 e9e14a558f8ab-3a0576c3222mr3552395ab.6.1725841807625; Sun, 08 Sep 2024
 17:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f01524fa4ea91c7146a41e26ceaf9dae4c127e4.1725821201.git.sam@gentoo.org>
In-Reply-To: <4f01524fa4ea91c7146a41e26ceaf9dae4c127e4.1725821201.git.sam@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 8 Sep 2024 17:29:56 -0700
Message-ID: <CAP-5=fXz81LOZA+vTGixT26R9vNSpxnCj0=0ieg8E3G4DidGdQ@mail.gmail.com>
Subject: Re: [PATCH] tools: drop nonsensical -O6
To: Sam James <sam@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 11:47=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
>
> -O6 is very much not-a-thing. Really, this should've been dropped
> entirely in 49b3cd306e60b9d889c775cb2ebb709f80dd8ae9 instead of just
> passing it for not-Clang.
>
> Just collapse it down to -O3, instead of "-O6 unless Clang, in which case
> -O3".
>
> GCC interprets > -O3 as -O3. It doesn't even interpret > -O3 as -Ofast,
> which is a good thing, given -Ofast has specific (non-)requirements for
> code built using it. So, this does nothing except look a bit daft.
>
> Remove the silliness and also save a few lines in the Makefiles according=
ly.
>
> Signed-off-by: Sam James <sam@gentoo.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> I promise I'm not completely humourless, but given it's caused
> actual workarounds to be added for Clang, I don't think this is worth kee=
ping.
>
> Plus it sort of propagates a silly myth that -O6 does anything.
>
>  tools/lib/api/Makefile     | 4 ----
>  tools/lib/subcmd/Makefile  | 4 +---
>  tools/lib/symbol/Makefile  | 4 ----
>  tools/perf/Makefile.config | 6 +-----
>  4 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> index 044860ac1ed1c..7f6396087b467 100644
> --- a/tools/lib/api/Makefile
> +++ b/tools/lib/api/Makefile
> @@ -31,11 +31,7 @@ CFLAGS :=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
>  CFLAGS +=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -U_FORTIFY_SOURCE -fPIC
>
>  ifeq ($(DEBUG),0)
> -ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS +=3D -O3
> -else
> -  CFLAGS +=3D -O6
> -endif
>  endif
>
>  ifeq ($(DEBUG),0)
> diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> index b87213263a5e0..6717b82fc5876 100644
> --- a/tools/lib/subcmd/Makefile
> +++ b/tools/lib/subcmd/Makefile
> @@ -38,10 +38,8 @@ endif
>
>  ifeq ($(DEBUG),1)
>    CFLAGS +=3D -O0
> -else ifeq ($(CC_NO_CLANG), 0)
> -  CFLAGS +=3D -O3
>  else
> -  CFLAGS +=3D -O6
> +  CFLAGS +=3D -O3
>  endif
>
>  # Treat warnings as errors unless directed not to
> diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
> index 13d43c6f92b4a..426b845edfacc 100644
> --- a/tools/lib/symbol/Makefile
> +++ b/tools/lib/symbol/Makefile
> @@ -31,11 +31,7 @@ CFLAGS :=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
>  CFLAGS +=3D -ggdb3 -Wall -Wextra -std=3Dgnu11 -U_FORTIFY_SOURCE -fPIC
>
>  ifeq ($(DEBUG),0)
> -ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS +=3D -O3
> -else
> -  CFLAGS +=3D -O6
> -endif
>  endif
>
>  ifeq ($(DEBUG),0)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index fa679db61f622..5d6b08a896150 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -238,11 +238,7 @@ endif
>
>  ifeq ($(DEBUG),0)
>  CORE_CFLAGS +=3D -DNDEBUG=3D1
> -ifeq ($(CC_NO_CLANG), 0)
> -  CORE_CFLAGS +=3D -O3
> -else
> -  CORE_CFLAGS +=3D -O6
> -endif
> +CORE_CFLAGS +=3D -O3
>  else
>    CORE_CFLAGS +=3D -g
>    CXXFLAGS +=3D -g
> --
> 2.46.0
>

