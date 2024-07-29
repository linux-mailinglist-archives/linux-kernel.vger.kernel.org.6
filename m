Return-Path: <linux-kernel+bounces-266260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57E893FD44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349941F22F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D41862B4;
	Mon, 29 Jul 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpDMu9Xu"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86511E49B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277393; cv=none; b=phrTSWsdFOXzLiZrZjr8zLialmZIqqiZZmh6SNsbk7o+9Wgyo4Z7GkAiIFmGqgaaRp6zUkdi9Wc2+EzfAt3maPzvKt5aYj/mXBV7dltKxNeUh9x0Kge+QgYzuB9XR2e+MCZclSaBpAwIIRbSeakc7+S98RKGBRhFnnrIKxP5Clo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277393; c=relaxed/simple;
	bh=WnNhB5hl4PWalG5K4s/yj7xgk2QRfccIU4uPfCmhzKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/od5ihDGYbAmVp+8F6882UrK4SDCKL11RoaUlMe3Ifp+CzUhMkiUTYnssyMuXzytuSBlLqWfeKh2ZfWecO4Sa3afioN+e4rEW6ows8IDVE2pIR4bBQHEvQt1KLwMp+1FZCeDN0RF8oYr+uDSEkhVAXJ11THOcr6bOwCx9ZghSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpDMu9Xu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc4aff530dso26165ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722277391; x=1722882191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wW9dLEagiP7trbFcpTZEYkzfN8YZbrgKrWxiBHYcWs=;
        b=vpDMu9XuBtviaWiy5WmCu8+qL8VNvItA/DLZ3eMTHG+aEcC/MgmRYyavTYRWSXLgLR
         PKhldQ/37h2N4rwqRNgkAo9Lt7RsCYJT+M89DWPmHCX323mGjeZ92xpBqUfMlIBfTvZ2
         WodxIVMoP8Wj2Ig0jdXMfA1pC6xO2U3DtodUo/Mi3I7qz3fZlp8dyRUAu2H0IKq5ci4g
         YSHWl6r74xn0bDU3yKKmJt2V/BU6CtMG5i+ASYy2Q61VgMJ77BNlVRbt3drkPUOV0wHt
         Urxs9tfhFK83NX42esQIEqclwe4tPszC9tljyZE0q9iSsPlnEqhNuaPzr67TYZVuLtYz
         j7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277391; x=1722882191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wW9dLEagiP7trbFcpTZEYkzfN8YZbrgKrWxiBHYcWs=;
        b=j3L3yuiDJUYnKXH7XG/DADc3t6aprQv7cS6qhuNTdOnfqNsdut7dnp1wjTuGhsdnRN
         qmiOoYci9+AHGKTldaptHhVuSgI/iLIpQWEXSc/jpBIKKfvHwhFjgg+qKVrzQqevoAIm
         J1pd9aeLq/pmQHQugIdkHW8RpkR8cS0k4wfbMjfzLvYnkFyf2JxptJZSCxHZCaFAYIuv
         9W8WEJbPX46IeJONy1tLHtjaz3fYcowmEhuPF9w71XnuUpm0goygvTm8CCUFk+Kjr91p
         9SEbXeAKFrOTh3hM/Aw1drMlcgqclyjYoIrz15R5t6u8ZYLIopAS101gqHEqX+/X8paJ
         TxrA==
X-Forwarded-Encrypted: i=1; AJvYcCW+XN4R7AUnbJ/BAiBkrAJjTUWS+iWAYa3Vo3N0Om3WOIKqUmJ/lKxK8bMfWoxZFU5XtzHOTaugfdmfNMm5Q9EgRc47ZdtrrtkIAdbk
X-Gm-Message-State: AOJu0Yx48R/82Q1o03zsp+yecIkAd78piZiiOihatX78lxgEn9LhLYRB
	yNRc1Nf1NjhO6YVQJ7yMEFUKn+W5KwoVBvF26F7wRrW+9DbenGiDdkK4/iYFz+ucLxOxYYda+TU
	LwtwufvLm07GkN7S1VFcFayzmR9BRChr7kiSH
X-Google-Smtp-Source: AGHT+IF8Ks4NgZw4ox8mnmoB3loe9bJH8mqZoWZi2P+XuTkyw/POJMltrLC1jn9h4LnhjD0VwKxRWmD/51tyw4ujO6I=
X-Received: by 2002:a17:903:2a84:b0:1f7:34e4:ebc1 with SMTP id
 d9443c01a7336-1ff34d6465fmr835425ad.5.1722277390733; Mon, 29 Jul 2024
 11:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729004127.238611-1-namhyung@kernel.org> <20240729004127.238611-3-namhyung@kernel.org>
In-Reply-To: <20240729004127.238611-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Jul 2024 11:22:59 -0700
Message-ID: <CAP-5=fVt_k=MzGUhMQzS7YRXQ7xzKEFa9+E4kV0D4BPHCNabGw@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf ftrace: Factor out check_ftrace_capable()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 5:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The check is a common part of the ftrace commands, let's move it out.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

The whole ifdefs and perf_cap__capable seemed wrong, not least as we'd
like the error message to be accurate not just when libcap is present,
so I sent out;
https://lore.kernel.org/lkml/20240729181931.2870851-1-irogers@google.com/
which I think can supersede this.

Thanks,
Ian

> ---
>  tools/perf/builtin-ftrace.c | 44 +++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 33c52ebda2fd..978608ecd89c 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -59,6 +59,22 @@ static void ftrace__workload_exec_failed_signal(int si=
gno __maybe_unused,
>         done =3D true;
>  }
>
> +static int check_ftrace_capable(void)
> +{
> +       if (!(perf_cap__capable(CAP_PERFMON) ||
> +             perf_cap__capable(CAP_SYS_ADMIN))) {
> +               pr_err("ftrace only works for %s!\n",
> +#ifdef HAVE_LIBCAP_SUPPORT
> +               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> +#else
> +               "root"
> +#endif
> +               );
> +               return -1;
> +       }
> +       return 0;
> +}
> +
>  static int __write_tracing_file(const char *name, const char *val, bool =
append)
>  {
>         char *file;
> @@ -586,18 +602,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>                 .events =3D POLLIN,
>         };
>
> -       if (!(perf_cap__capable(CAP_PERFMON) ||
> -             perf_cap__capable(CAP_SYS_ADMIN))) {
> -               pr_err("ftrace only works for %s!\n",
> -#ifdef HAVE_LIBCAP_SUPPORT
> -               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> -#else
> -               "root"
> -#endif
> -               );
> -               return -1;
> -       }
> -
>         select_tracer(ftrace);
>
>         if (reset_tracing_files(ftrace) < 0) {
> @@ -902,18 +906,6 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
>         };
>         int buckets[NUM_BUCKET] =3D { };
>
> -       if (!(perf_cap__capable(CAP_PERFMON) ||
> -             perf_cap__capable(CAP_SYS_ADMIN))) {
> -               pr_err("ftrace only works for %s!\n",
> -#ifdef HAVE_LIBCAP_SUPPORT
> -               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> -#else
> -               "root"
> -#endif
> -               );
> -               return -1;
> -       }
> -
>         trace_fd =3D prepare_func_latency(ftrace);
>         if (trace_fd < 0)
>                 goto out;
> @@ -1220,6 +1212,10 @@ int cmd_ftrace(int argc, const char **argv)
>         signal(SIGCHLD, sig_handler);
>         signal(SIGPIPE, sig_handler);
>
> +       ret =3D check_ftrace_capable();
> +       if (ret < 0)
> +               return -1;
> +
>         ret =3D perf_config(perf_ftrace_config, &ftrace);
>         if (ret < 0)
>                 return -1;
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

