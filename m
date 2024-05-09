Return-Path: <linux-kernel+bounces-174167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037948C0B11
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69DA1F213B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC2149C6D;
	Thu,  9 May 2024 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TF00JlCf"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E151494DF
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232887; cv=none; b=m9TrGGO1A4k819v9CqbKf7XK3l5klbLT7udLbaxHN9TW1LwmohxGMq+4fEV9oErsronS97TN1Ha3Oujvj65nr6ZWzdgjGmv1HTWLNnJvmfnGM0hfcj92VVnYne0UU9w/qBVycgK8CfzNU9KUcqxZDNED7vrFBrwE3Q5rTwIEheA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232887; c=relaxed/simple;
	bh=Yu/FlxoSX005QeAc+0Wxq9eAC3c4jYlWWcvVDh/Q3xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rzx3KNudKUpDnw3sNAkjdNdcfVC+E78D4U3qlviLyuePAV/WfW+jhIWzDA6IAmVhkkOaBjHLSqCoadJ28t4ETww9YipD92xDqdRtO2Kmyx73dI0DZBzELIOKHhy1swC6Ffgk7HgThV99yDvbFKpIp9AA7W0XgDbEhzhLFBCrQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TF00JlCf; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-439b1c72676so206941cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 22:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715232885; x=1715837685; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBu2+kmhThCqDtxFPgm069ky4hbWhjdpfaVsKApxqFU=;
        b=TF00JlCfbTYkykR5n5zK6Y83QnzGSlMMvq9SnwPlDtdq1HwG+KumRzV/KdMUVksVKP
         3VAyI6+KHJ84dbSsXQYm97Z2Wm3qsrjiRmNoPFAU/DrxpzxyRDgl2xgDUxmebrhPC/ZI
         J20a6B4SCdivE3YGzsnM0WZcm01CQXZZZCkHfnwEC8FjuTYhXHPdOE8JOoczIU3FXkzW
         vr9DuQ02n5Jmjmwf3yTHfNvgmLT76gdZrTHtB/E8NkdPOKI40gEPXIEqKrbPDWRbVizl
         L1M/Updb5NxdU9yZOQvJVXVlCLbQ3F6ZrJ/YBlWILUHBm6U3nyYK2l23AcPK57FWiRiB
         sRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232885; x=1715837685;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBu2+kmhThCqDtxFPgm069ky4hbWhjdpfaVsKApxqFU=;
        b=w4uGYMgmIk4ZhBRpA9MQymmCWcN5NkvXEyIzaxrEYNv4d5Sx8isvvV5u03hJ/ZrrdI
         8NPpfUhgs1JEiXEVVUcVYZPBpWrC2ypEiucOCuMOZOrTZFn0iMKB+xXDaXRWhJPut089
         JRQ9Y//LpM7fvg5AiVb+acPI3Xbgwr7uVKQt1FuIqaOnQ2jQw5FpmLX3kqW+Sefx2Bit
         4r/uhvCUXmsWS6vjLq4gnZzToQowRzb3ndsl95wQEZiVUVxAaObwV6qdpzj6W5Iykwt8
         2paFJveDLwRmXZJBGqWgbxVb85sQaR5ddbtYSx7dN9egs/6kbJ5T6VfXE/RzzfjOWS3d
         WIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW58oUu8BsLcGNbxGeVv29wUWXRs8kvUEoPRrMikF9vdr+fY7Cec3e1pPeANpMw6CXMf7a+31eDAB1f/gw5YdLTPc0/uBA3/kye3xv4
X-Gm-Message-State: AOJu0YzV1HUzzbfYUh+YWzIK/7VCKIO8isYAo1FinNSlm54OdpujIyRN
	IG2X+cfrcalJBJ7nTycYrpIqLxXVpnU+tGN72CT+VMHgH1UpNYWd2ZI0oEkkEmntLBMqW3QpCjN
	mXGCKfIKD+3WDqDNSmBfIe/HBmMpLwtSAye4i
X-Google-Smtp-Source: AGHT+IGaK7Rirp/cZH/CG/NQkJa3l//MoK0bZoUqv56E8q8HA0NLz3QmbZgxTBXtvlKFnxFS6uOdeXp85bNMcb8psmM=
X-Received: by 2002:a05:622a:1c18:b0:43d:f69d:cf3a with SMTP id
 d75a77b69052e-43df69dd298mr568601cf.8.1715232884994; Wed, 08 May 2024
 22:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509052015.1914670-1-irogers@google.com>
In-Reply-To: <20240509052015.1914670-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 22:34:33 -0700
Message-ID: <CAP-5=fW=qV=ZdU5qpfXE_E0+tU_kmcVeGC6M38nbm+Px=2aWPw@mail.gmail.com>
Subject: Re: [PATCH v1] libsubcmd: Fix parse-options memory leak
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> If a usage string is built in parse_options_subcommand, also free it.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sorry, belated:
Fixes: 901421a5bdf6 ("perf tools: Remove subcmd dependencies on strbuf")

Thanks,
Ian

> ---
>  tools/lib/subcmd/parse-options.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-op=
tions.c
> index 9fa75943f2ed..d943d78b787e 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -633,11 +633,10 @@ int parse_options_subcommand(int argc, const char *=
*argv, const struct option *o
>                         const char *const subcommands[], const char *usag=
estr[], int flags)
>  {
>         struct parse_opt_ctx_t ctx;
> +       char *buf =3D NULL;
>
>         /* build usage string if it's not provided */
>         if (subcommands && !usagestr[0]) {
> -               char *buf =3D NULL;
> -
>                 astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_=
name, argv[0]);
>
>                 for (int i =3D 0; subcommands[i]; i++) {
> @@ -679,7 +678,10 @@ int parse_options_subcommand(int argc, const char **=
argv, const struct option *o
>                         astrcatf(&error_buf, "unknown switch `%c'", *ctx.=
opt);
>                 usage_with_options(usagestr, options);
>         }
> -
> +       if (buf) {
> +               usagestr[0] =3D NULL;
> +               free(buf);
> +       }
>         return parse_options_end(&ctx);
>  }
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

