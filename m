Return-Path: <linux-kernel+bounces-321804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6187971FAA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E5C1C22710
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA216DED5;
	Mon,  9 Sep 2024 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAbFJFLe"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0516BE0D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900913; cv=none; b=rqSp0seKbjbF9zsFDyRsDJ/EI6lkKNswu4rOvFs2ksRa18WkHTAvzH+t/OdZfNDvyYrIaO9qcwurcRLJFriK3w8LllqXAsnbJNC4Tv83dg7IJptAeR57Di//0MbMIGfxxg3n9a4mKuUfZscPmWViEUNlw42/rYP0pVfrx6x9x0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900913; c=relaxed/simple;
	bh=tTiBm/CKGp9hg1wgpgVQ3RO7yTE/WDeKZYaPu/C4DIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5g2BwOcEyt8mQ0aG3s2NpeRjeEdMJHyEZFzv6YNJDxiXaJOWOfjHv8cigBxKJcLzZ/UZ/ZLgjFz9Pgxg+dAoOzin7rQUETJhNT5Dk6TeNCM9Iu9EcT0kiiEzCdhwWlR4H2DYkDrU1N1lpX/MJGjkMkirAmxYlwClznSAVKxjC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GAbFJFLe; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d41b61178so3965ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725900910; x=1726505710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dfc30xG5uB1NlnFvfS1Ku9pHpkP/L76PKjyeSKgmbmA=;
        b=GAbFJFLefAx9FmWpLNrfEpdM8+03CTr8Hx50sokTFIXyNAleD68I+J+1ex7g7JJHiP
         R+mBdSQ+W1XPoOy39NKLpZ8v7iluPwTfbdRn2F7iFpUZiJPWMLABA6mJPxUjXGeBsUqb
         k4ialukFHYWAyOFMAvKuZ5iu94gNgHI4O+Yv/ttMAHM82JP4+XAUF2I5PW+n0NSyFY/V
         M3JkitqyXfQauwP45AqAz+SiFr5amBWj6YxjZ8geb6yggPaGlTSc8eaFyP9RU3AOkSK1
         Dj9ffzYrXeM/WgSPYku+7+9f2V+HeHxtDpUb0FnDrC/uKtUMRvIOR4J6if15bxmSbG13
         5h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725900911; x=1726505711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dfc30xG5uB1NlnFvfS1Ku9pHpkP/L76PKjyeSKgmbmA=;
        b=OINtUhYNCNMT7nc7RpTyMps5MMVRhR7mmz+kqEMfAo/oRHmGVf8Qn7DEVeOHbJ6w6k
         XhtYRHRL7626RNniCuRmSElJm6sV/zOlkxmBeMdAETjuWdBBdvEtNXfNAYZyOTcEceig
         S5jmn3Wks5hJHYLpuZyMCgm030SkpfWQvoYboXGtFhLZqBxJihcxJHt/u3SGSRPIGq24
         iH2nJOSoLIm/dC8HT5PUJ6QuXbcjoerLOfmiCuXxHsZHJIF+hwz2Px/eFp8sX04aDK6Z
         1Z5dDE1kfGygfRbN3F1kyWvy77FvDmn9QzXYwn2YBY97tZcto6SA7bb7oETXs4RpGqJx
         0TZw==
X-Forwarded-Encrypted: i=1; AJvYcCVRxlzObdXtbwu8j+mcH2kyJlu3JCj0cJzuMwPsGasLz88yeSqRi8QvuYcQ7taSRxz3tuUB4tLnqezDx9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvz22jPnEPoew1YotquS9uZRnFTBZ8+TVEJf947OA3lSnxl2P
	xO61wiz/EyXA07zGwDuhEoQ+GvfCMKYs6rWld65ng1omdrVjtC+GJhNkb2hvYbZeTIuNuOgAIyH
	dQXA8fqMBzpMAYixXbspSFM8DL0MqN/8/cR6C
X-Google-Smtp-Source: AGHT+IEKRPi/+2MK2UHrTwucksnvEBLPNuJ9uhj5FnLK/MBTSFaTXS3gLPRSRsjJZIfr35H4M+RleEyGttr9Q/je9L4=
X-Received: by 2002:a05:6e02:1a08:b0:39d:2555:aa2e with SMTP id
 e9e14a558f8ab-3a057f0f3damr6008585ab.13.1725900910323; Mon, 09 Sep 2024
 09:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908202847.176280-1-kan.liang@linux.intel.com>
In-Reply-To: <20240908202847.176280-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Sep 2024 09:54:57 -0700
Message-ID: <CAP-5=fXjH5C0H8RWULGm9UJc36mp=1rfoeBCxVVoHxe2KnGY8g@mail.gmail.com>
Subject: Re: [PATCH] perf evlist: Print hint for group
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 1:28=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> An event group is a critical relationship. There is a -g option that can
> display the relationship. But it's hard for a user to know when should
> this option be applied.
>
> If there is an event group in the perf record, print a hint to suggest
> the user apply the -g to display the group information.
>
> With the patch,
>
>  $perf record -e "{cycles,instructions},instructions" sleep 1
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.024 MB perf.data (4 samples) ]
>
>  $perf evlist
>  cycles
>  instructions
>  instructions
>  # Tip: use 'perf evlist -g' to show group information
>
>  $perf evlist -g
>  {cycles,instructions}
>  instructions
>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZttgvduaKsVn1r4p@x1/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-evlist.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
> index 818ab21c3f73..a9bd7bbef5a9 100644
> --- a/tools/perf/builtin-evlist.c
> +++ b/tools/perf/builtin-evlist.c
> @@ -36,7 +36,7 @@ static int __cmd_evlist(const char *file_name, struct p=
erf_attr_details *details
>                 .force     =3D details->force,
>         };
>         struct perf_tool tool;
> -       bool has_tracepoint =3D false;
> +       bool has_tracepoint =3D false, has_group =3D false;
>
>         perf_tool__init(&tool, /*ordered_events=3D*/false);
>         /* only needed for pipe mode */
> @@ -54,11 +54,17 @@ static int __cmd_evlist(const char *file_name, struct=
 perf_attr_details *details
>
>                 if (pos->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT)
>                         has_tracepoint =3D true;
> +
> +               if (!evsel__is_group_leader(pos))
> +                       has_group =3D true;
>         }
>
>         if (has_tracepoint && !details->trace_fields)
>                 printf("# Tip: use 'perf evlist --trace-fields' to show f=
ields for tracepoint events\n");
>
> +       if (has_group && !details->event_group)
> +               printf("# Tip: use 'perf evlist -g' to show group informa=
tion\n");
> +
>         perf_session__delete(session);
>         return 0;
>  }
> --
> 2.38.1
>

