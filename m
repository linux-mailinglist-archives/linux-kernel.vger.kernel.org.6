Return-Path: <linux-kernel+bounces-256553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECD2935019
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F74F1C2169A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DCA1448E7;
	Thu, 18 Jul 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ndl+M5U8"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349580BFC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317512; cv=none; b=f5reOc8lK4w5LqYiyzORg5/VA6KYsvSd0kpsuyhTgZD2ajeQV6idlqtwuXqhrp6jjSEbCRkBWOV/6XU1cUL22a92L55yEUbPDzGvLN47RL9FY0Lph+5//qysBDJ0uCVtMNzFlg5UQJg0mtmOh/NB7SughKDvQNC/njIxBErgM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317512; c=relaxed/simple;
	bh=+iYCEV4jnUP+xMe0ntI8OP1dBwqyZjF6AplmoGAlDRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xv2SQmZXPA/uNzNdKvlLf0h8ZnHjSgXCI/t37GRx9lzb7U8T2RpiK4Xw3NkIL7BqHZu22ZsFwIDQvKgtrZDjP5CfENEGAsaAue7qUPJOILQA2vIf0KmzuhXgHEbh89/f/+GUXQOfh42cD/hoqhXhtzRSoDSVem5xGdWFdgcL2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ndl+M5U8; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-447f8aa87bfso183431cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721317509; x=1721922309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1TIacI7GtvAJO8Y15W9fPDXH2ieEjKop8QJs+VMXnA=;
        b=Ndl+M5U8S9IrB7H/c6kIH5GSxcWL88nvhZLQ1UchDkQSO6RoBxVouz9hTu0c+aF/DY
         lelaKMqXiZv6wMO9mvwsoQcFrnC6s/j3aR39SEHb1hk2678Fylo7eaAXX/UQHPUBx22c
         WngiVJe3ECVLmlVvQzw1Q3GIU+Vg66GEdIEG7y2o+D58xLH7E5NyXnJr4qdVpIZYbaZo
         vCApbeE+zF/yzFIDdHjYaCuNSMwKZUejvtkyswbXN5fKz1LNXgi7EkrvNvCPiZM/RtT+
         tdOVHisud9G30BOrFRKYYR5WA8W1C9k4r1jt6Rbolcwo6p7SJSs9NQEfvSj5nTieYULy
         1Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721317509; x=1721922309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1TIacI7GtvAJO8Y15W9fPDXH2ieEjKop8QJs+VMXnA=;
        b=RUxNouQkPKvUtwZ7cOxsdh4mSaoi5Q+SxQ2CwuuxjQWN+xm1C4WcThE/ggq7aCaGKQ
         fChDvDnOhOMAWYJV7Dugiu25vxyRxyqk2g+QA3jO8ZeYDgxBUx5cVJX3b7jgfPj8q5NF
         HHOZsoJ/bPBJL8/XgORjKDZK/CZZ2VxGKF4DPioZl8hep9yvcNATif6gcVhyQNZr1WlB
         o5L6z1vWGfV07Ue1p/aW4Oq7t10RV7jUw8+VOdSWIU08X8zYG0ucavK68Xq05udlmF2q
         w6MT5LvtglZ/cL4rHpol+p0zYa16d5zjEB35cZB1I0Ybsz15RyxNf2hJ2t1vPclVEbjI
         P9KA==
X-Gm-Message-State: AOJu0Yy4nA+bcEvbwxASxlEa75vv2ZdqcIlAdM4afqYw5zflaZdQhncs
	OMXjoqw4N7y3bMuym013VDSLwdccledj0mHXkXdmE3Fggrymxx+zDrbrd6pUFOLrF+uSSbW96XG
	DbKKcjxkDr2OxvzwZTL7b73+FgwJOhq7I3+JB
X-Google-Smtp-Source: AGHT+IEvc46D6GqoAanelEA1ZPr2HWAK5uEFLCCXFpZ9Egj2KviVkDj9kSEH/ZP/2etoP4j1QH+RJmJeg9YMh71gSJQ=
X-Received: by 2002:a05:622a:5196:b0:447:dd54:2cd4 with SMTP id
 d75a77b69052e-44f96aa05d2mr1652561cf.22.1721317508578; Thu, 18 Jul 2024
 08:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718143009.197851-1-m.liska@foxlink.cz>
In-Reply-To: <20240718143009.197851-1-m.liska@foxlink.cz>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jul 2024 08:44:57 -0700
Message-ID: <CAP-5=fXPC+pXmJCpvkr5x2Ae1hdKeL7Cd6Uak+7mn+uG+R8yVQ@mail.gmail.com>
Subject: Re: [PATCH] perf script: add --addr2line option
To: m.liska@foxlink.cz
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, Martin Liska <martin.liska@hey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 7:30=E2=80=AFAM <m.liska@foxlink.cz> wrote:
>
> From: Martin Liska <martin.liska@hey.com>
>
> Similarly to other subcommands (like report, top), it would be handy to
> provide a path for addr2line command.

Thanks Martin, lgtm but you did put a Signed-off-by tag in your commit
message. There is an option in git commit and git format-patch to add
this for you.

> ---
>  tools/perf/Documentation/perf-script.txt |  3 +++
>  tools/perf/builtin-script.c              | 10 +++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index ff086ef05a0c..5abb960c4960 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -369,6 +369,9 @@ OPTIONS
>  --demangle-kernel::
>         Demangle kernel symbol names to human readable form (for C++ kern=
els).
>
> +--addr2line=3D<path>::
> +       Path to addr2line binary.
> +
>  --header
>         Show perf.data header.
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..301ea1c98e36 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3897,7 +3897,7 @@ int cmd_script(int argc, const char **argv)
>         };
>         struct utsname uts;
>         char *script_path =3D NULL;
> -       const char *dlfilter_file =3D NULL;
> +       const char *dlfilter_file =3D NULL, *addr2line_path =3D NULL;
>         const char **__argv;
>         int i, j, err =3D 0;
>         struct perf_script script =3D {
> @@ -4052,6 +4052,8 @@ int cmd_script(int argc, const char **argv)
>                         "Enable symbol demangling"),
>         OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>                         "Enable kernel symbol demangling"),
> +       OPT_STRING(0, "addr2line", &addr2line_path, "path",

Thinking out loud. I'm kind of wondering why we use a local variable
and not just &symbol_conf.addr2line_path here. I see you've used the
same logic that is elsewhere like builtin-top.c, so I think it is
okay.

Thanks,
Ian

> +                       "addr2line binary to use for line numbers"),
>         OPT_STRING(0, "time", &script.time_str, "str",
>                    "Time span of interest (start,stop)"),
>         OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
> @@ -4138,6 +4140,12 @@ int cmd_script(int argc, const char **argv)
>             itrace_synth_opts.callchain_sz > scripting_max_stack)
>                 scripting_max_stack =3D itrace_synth_opts.callchain_sz;
>
> +       if (addr2line_path) {
> +               symbol_conf.addr2line_path =3D strdup(addr2line_path);
> +               if (!symbol_conf.addr2line_path)
> +                       return -ENOMEM;
> +       }
> +
>         /* make sure PERF_EXEC_PATH is set for scripts */
>         set_argv_exec_path(get_argv_exec_path());
>
> --
> 2.45.2
>

