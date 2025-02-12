Return-Path: <linux-kernel+bounces-511994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E349DA33286
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF9F3A5369
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E109C205516;
	Wed, 12 Feb 2025 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGQ57XXI"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E1202C45
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399148; cv=none; b=bILnvFqAF273m1BduC+bit6Yvjotsfz07nr5l0qzI+r3Yaszqmg6bBX0VFqRnzlz8sDOGzyN4DRYunzRmSNq2PwWvvu5azFqCe3PEeiuCkMZDliqv9mIzutRw3h+w3c8DS/a8DtuqTOSayPRc3+tRZkJsFOtA9ZGbE81HDsj8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399148; c=relaxed/simple;
	bh=cRsst9VUZPQ4xjX0JjGxH/HZKO6ga8iI/0by98CXMI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIqkIKdXMUoXpVmXun4W2BGUTv94drtRyrtQXfGkwIQD9kOU/lPojUMfKH4Zv6o3y1S62xoCCSqNjoKmKTQYSobM93eCbLOZQITuUUASgWx5M9QVzIBorgLx49hdSQN8QoEdkxiUFBMA9AiwaJf2M1J0JSa55647SSSBLdP50zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGQ57XXI; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d18c325ee4so7635ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399146; x=1740003946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb8NB3DXPVSxp8ymRsumf/Gc3u9+Crn5k7jX9QVoT18=;
        b=qGQ57XXICBWt4v7pTUUjcg6HduSc4W8c5CDVU+YQVMmLAPquEmLBkBZH60DYSbJV26
         Fb6ievsf6+gqpMx6bkuJElY46OK+o9q8w3hNUzSFgOsc88Ym5DK5Y5m2uhOmIgMVDTsD
         f0g442zLMpu+H1aflzNFVXuwCwozaVMfzOO9md7KRH9cHiBaUMJcdtrEarWd6I1Qh6xp
         uvXPZIHPYfuKkm/+EBgbrHNE5CGa1rPkXcJDajYSRciOArkRVcD9qhU0GyKNG+bPGowd
         WVqNRGFW2fY3kqYMh4RO//bP6A4Elq03qvGxaTsuw80le+3Pc+SbU1fFio84JGDllNLW
         d2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399146; x=1740003946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eb8NB3DXPVSxp8ymRsumf/Gc3u9+Crn5k7jX9QVoT18=;
        b=ppFG/MvVDKxoxMKfQeLScen42BD2VMqRtob6GrlG8FrS279YU50P7jrTT1Zw91wkWA
         8QOAZaK4WceDZBHXkM9xaYaGpMgsIEuhwaPOAdov0xMMJgHK/EXLWtjNXGksd/ndX76g
         rIClRD45ugKG9Y6X8LWcOAg2QBRJ9BIm2La4sZsZdZhdWZcp2uaq39I+u0RHEXuoFQU8
         zZ1e1SJ1Biha4M5QxHSyWZD9Gh6/ymnxlaXS/01k6qZ3EYeLzqI33rC9tJcqMUW1cNCQ
         B+OamRHUPx1pmAtc9iphpu6Cbqv4RbZqWThxFcZE8a6HQJllx/CPYstTonK+NibCWkKy
         IpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOVhzPeaCCBMbiHMXibss1yViBB+vcJ8QYWPP4NS24l+csIBPQ7CZ+VfRQlp2x8Kc6YzzZzbdejbPtgok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5oCVQu1Lpch/Z0HDXopzznjHfnfgpt/uP8sa/yMNhYZxoB6t
	7J1rF8SyWpUcwM7c9wVObUPFDkeLIHjkQpBCC1Xt0aMsFVL7UmGzQJ50opnPdT1haK56ltkpLXm
	tCNRiLGTWy3/hBEm63wZ2cPP0u50xslyE6o4V
X-Gm-Gg: ASbGncs09LX0QRJL+HSxgiB759u5E9i+pEdXyNiqsQSmFHzFL37mw9s22F9ygXZjNPG
	YUeWaBoo22B6f0nwJtYeveyw0bjBHHmBIv/SjEtRT487nr7bcBek5n/ztZhUvjwTY4STdttJ2sR
	9ikDFj7K4ni13JtS95TUiKaCSq
X-Google-Smtp-Source: AGHT+IEPi18vHfc6677zYsQWxRRWLmfPS/2RcM6gJqq5aFJEzAn2ciymxv8IrOUJUOw3+je2EcPOc6fxm7v4RthHM4k=
X-Received: by 2002:a05:6e02:2405:b0:3d0:5ac6:f493 with SMTP id
 e9e14a558f8ab-3d18e1e33d2mr339635ab.5.1739399145693; Wed, 12 Feb 2025
 14:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212221445.437481-1-namhyung@kernel.org>
In-Reply-To: <20250212221445.437481-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 14:25:34 -0800
X-Gm-Features: AWEUYZkOKMbZzWVbJGyBP-A50OG1S_X-IxmfIoNOeRJjPef2U-p22t0pd2K8YnM
Message-ID: <CAP-5=fV4w=y5-mFdwa8_UAxPYJeqnFhdXjyVic88CKwP_XdmSg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Use symfs when opening debuginfo by path
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I found that it failed to load a binary using --symfs option.  Say I
> have a binary in /home/user/prog/xxx and a perf data file with it.  If I
> move them to a different machine and use --symfs, it tries to find the
> binary in some locations under symfs using dso__read_binary_type_filename=
(),
> but not the last one.
>
>   ${symfs}/usr/lib/debug/home/user/prog/xxx.debug
>   ${symfs}/usr/lib/debug/home/user/prog/xxx
>   ${symfs}/home/user/prog/.debug/xxx
>   /home/user/prog/xxx
>
> It should check ${symfs}/home/usr/prog/xxx.  Let's fix it.
>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/debuginfo.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 19acf4775d3587a4..b5deea7cbdf24620 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -125,8 +125,12 @@ struct debuginfo *debuginfo__new(const char *path)
>         dso__put(dso);
>
>  out:
> +       if (dinfo)
> +               return dinfo;
> +
>         /* if failed to open all distro debuginfo, open given binary */
> -       return dinfo ? : __debuginfo__new(path);
> +       symbol__join_symfs(buf, path);
> +       return __debuginfo__new(buf);
>  }
>
>  void debuginfo__delete(struct debuginfo *dbg)
> --
> 2.48.1.502.g6dc24dfdaf-goog
>

