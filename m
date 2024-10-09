Return-Path: <linux-kernel+bounces-356097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE7C995C6F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EA01C22016
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C76F9E6;
	Wed,  9 Oct 2024 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bx3FeZnd"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014064C69
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434945; cv=none; b=OM1L1Qg0j7TvPA8lPqg8Xw69cFOPESDA1MzFKknb/DKc2OQvpmEQl0+ES8PRs/5XaZsBSKg0pfkVYpkkMm6MD4d35g0jdMS3gzBHVWMdJzLFB6Yc6Ule+WegNucZwnewln5EQF1OTKHpo4UbmOrctb1pbGwaD2R5W3HLTz/itYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434945; c=relaxed/simple;
	bh=Cpx7rXkTSx8ps5kFdq5cHdGaqq6HdXgYYm9h5SAMX88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/wBf05omBx7QHrLhm2SHQBclVdahdJmNZIKalffsmCH8RCIt6rIeNpbmPzE3HqByTa4Xej/GMOEO7uMxnptNoMZ7Rqe73HMJlN1mwq1uObasoBr0BlfHb/QTnFMyUqmE0ZTm7h0d+eGTbQutfOS+6h6msllEv/lXXfswJAuQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bx3FeZnd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c5b628b7cso79135ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 17:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728434943; x=1729039743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWn47q1YdrUk3zjrW3LLzHqPpTNHpFHGg0Pnci7sCN0=;
        b=bx3FeZnd6FbVD84wfCluFoJXzxhh/c7r4Dy8QyLsdESc9/ZOXZGMgpxNRZ8Kn6SFPG
         sz3x8nNxad6WLhv7BbLfIqopJf55/qRAa8AWpRuIzw8Ib/01FleJAr5A2v5QxlXkZ+/0
         O4ElJ2tzrHjBO1dE3cvGd99JJYPsoh852UAva65cQtbb1xT4oExGWZ3IvtResCxHJWpS
         PhG6zHdG3yc0ndUJeolpy6DZBBPgwE4UO0italYSBdK3WH4fg2wqH38mqYqEXjmVwIZ9
         sbbDDmSTPaRL1Uzwo+WxX1o73xmkZjVtUfC2mBpRFSfo6fmBmKiSOXjOWP9a0YXYFNJN
         L1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728434943; x=1729039743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWn47q1YdrUk3zjrW3LLzHqPpTNHpFHGg0Pnci7sCN0=;
        b=Yl/0yrU+2NcqYg2snPMYEzwl/VcoNz/FKkUsVT0ARTKhlRoudB5kfoRvov3t+jL3NB
         6DcodrB8qmbCtlCUODmxHq1m/a44RIncpkZDMjSQnxhkpuVsEY3Z89am/x12HumYU3as
         1/QwwHkPKWfZvAiskSxchgk/u6Phf1FuqXHfAdI7xw1SiGaY4hUgCjjijjIkRXVjNbc+
         DHvZAo8J9KT8iELQXHyul7BC7SOZiPVYz7xn8FkiZi2orlyO9YmKE36UzF7eybT8v6kR
         kNtq2/VPAatGcRWBJrlWog0E6pY+yJJw4wNkBqAuitU0qjXlCOWBl1ubG+ZSGwRy52cY
         OARQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdKBsscsEjPVK+UrGFuSKJuYtQV6kHhm0py/ngrh+qcqCuGa9yG5tBUmhRNTzHsn86/QbbbU1Xx4aNVlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+hAsPbcWLvzxIs56z8d/fPE9ax0sb+TJCxoj+zGx6ZO2xxGJZ
	ix/YjhC/OBJeMfSyJzD45QNIetPRyy3sLcwDaM8JB6eHpksWZqOVWgo27zJrQoij5jK7rXdoFxi
	vxiwe7PVxs2AxyVt7if5ZkCtltGF6vbmdLV/H
X-Google-Smtp-Source: AGHT+IGfkP1c7PwtfYyG1Mr3DQyh9f2R69qD+cgCgsoIan/75MTWGHIzdiSEzFhxx0fR3MEzmxETjFf/tHN9LfiuL0g=
X-Received: by 2002:a17:902:e552:b0:1f7:34e4:ebc1 with SMTP id
 d9443c01a7336-20c64b74322mr713885ad.5.1728434942876; Tue, 08 Oct 2024
 17:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009003938.254936-1-linux@treblig.org>
In-Reply-To: <20241009003938.254936-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Oct 2024 17:48:49 -0700
Message-ID: <CAP-5=fVNcMq7xjPHFE-f=LddSDz4G2cWxUGDjSuFtafVAtY6bg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Remove unused color_fwrite_lines
To: linux@treblig.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:39=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> color_fwrite_lines() was added by 2009's commit
> 8fc0321f1ad0 ("perf_counter tools: Add color terminal output support")
>
> but has never been used.
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/color.c | 28 ----------------------------
>  tools/perf/util/color.h |  1 -
>  2 files changed, 29 deletions(-)
>
> diff --git a/tools/perf/util/color.c b/tools/perf/util/color.c
> index bffbdd216a6a..e51f0a676a22 100644
> --- a/tools/perf/util/color.c
> +++ b/tools/perf/util/color.c
> @@ -93,34 +93,6 @@ int color_fprintf(FILE *fp, const char *color, const c=
har *fmt, ...)
>         return r;
>  }
>
> -/*
> - * This function splits the buffer by newlines and colors the lines indi=
vidually.
> - *
> - * Returns 0 on success.
> - */
> -int color_fwrite_lines(FILE *fp, const char *color,
> -               size_t count, const char *buf)
> -{
> -       if (!*color)
> -               return fwrite(buf, count, 1, fp) !=3D 1;
> -
> -       while (count) {
> -               char *p =3D memchr(buf, '\n', count);
> -
> -               if (p !=3D buf && (fputs(color, fp) < 0 ||
> -                               fwrite(buf, p ? (size_t)(p - buf) : count=
, 1, fp) !=3D 1 ||
> -                               fputs(PERF_COLOR_RESET, fp) < 0))
> -                       return -1;
> -               if (!p)
> -                       return 0;
> -               if (fputc('\n', fp) < 0)
> -                       return -1;
> -               count -=3D p + 1 - buf;
> -               buf =3D p + 1;
> -       }
> -       return 0;
> -}
> -
>  const char *get_percent_color(double percent)
>  {
>         const char *color =3D PERF_COLOR_NORMAL;
> diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
> index 01f7bed21c9b..aecf56dae73f 100644
> --- a/tools/perf/util/color.h
> +++ b/tools/perf/util/color.h
> @@ -39,7 +39,6 @@ int color_vsnprintf(char *bf, size_t size, const char *=
color,
>  int color_vfprintf(FILE *fp, const char *color, const char *fmt, va_list=
 args);
>  int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
>  int color_snprintf(char *bf, size_t size, const char *color, const char =
*fmt, ...);
> -int color_fwrite_lines(FILE *fp, const char *color, size_t count, const =
char *buf);
>  int value_color_snprintf(char *bf, size_t size, const char *fmt, double =
value);
>  int percent_color_snprintf(char *bf, size_t size, const char *fmt, ...);
>  int percent_color_len_snprintf(char *bf, size_t size, const char *fmt, .=
..);
> --
> 2.46.2
>

