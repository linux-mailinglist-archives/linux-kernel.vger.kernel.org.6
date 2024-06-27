Return-Path: <linux-kernel+bounces-232911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C7E91AFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28941F22F12
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701F64D8AC;
	Thu, 27 Jun 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCf/c9co"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327C4D9E3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517277; cv=none; b=VS8rL3VfnG8Y+kfOJi2EBsW61eadv5EeZetEpfkukKD1h6aM5spWYxUjg5aIivaW7HhdRolF5L2uX7BsONCGJT7DNLUWNmODlnnzYuvRow26lRPgF2vHfYESfwwm1f6Ec5OeT38MXxrmb5QDUqf/6rWDkt9YrFun/7HNTr3Q6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517277; c=relaxed/simple;
	bh=0kAkK0o6XZJCAD+3AEnbv9lXRzFAHdfwRGLiKLG75cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkGKoLkkRcbnA+YduoV9i64urcMA0wX4mMbJ+RAyN6/j70/FrgpSWf/wK44ShStnJQk1SfpnvxLjRannjfccBC3bSIQxELDgbA8OjP88f9b1SjI6h87RRnKvQjzZukvkQGRDTtIceRJLu0DpSKMvkVKD/DpiEimi1CEfE0RZi4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sCf/c9co; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa4b332645so32425ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719517274; x=1720122074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GJBz5qRWyHEg+kYWarwppQLKBcrVyqnbOuru3tw6vk=;
        b=sCf/c9co2u9ZPvSCvycgOgngiwUnUYV7pg9YqOLjpIouPpVsR+LLq3n91EJwsVgdI6
         glDwu/vw8Lmg8IxnC6adyzD6QiW+Ns0VRaF0ACb2L+s9TgKsp22IaOPbmljVDdLZJRAu
         AlQncndBVf+jtEpQIUXJNaGUN6GjNMJTaTtWNAiZAD+UzphTEf2mUihPXEJpNPoi/mXl
         TEO1HOIeKNwHaI4bmur/zVjcd0GDnjx7yYp7ENjwejZENYshgczcfakKw8tRNLwfHzbI
         uEQp6hWQzfaNbO3CGIBQzICaKV/6hQRa11JsDAZGWQEfui2BbMSYCw02RRF8qCRRB1iQ
         eWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719517274; x=1720122074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GJBz5qRWyHEg+kYWarwppQLKBcrVyqnbOuru3tw6vk=;
        b=MiM92TRAizvNkEHWs3U3WXQclesyFrWWBmT7+0MZRL6WLV/rQmZ4PrdDUngPrhneq5
         eVHWxEEjq0t1nzlWp5YFn21XeShXbbID7Ia8vkQNB20qFC8R1HmjTZILM2N9XVEfB53u
         frPzzBTCCJoEgs0O86Bc22KNrZcJ/Vo8ticgnVw7yd8NiIzXwEfODZAxTZ75w3unVGo4
         yV60Z2KeoHMekRfY1GqIrjz297QwctA8VWR7wgnVwejw2Io9atpDNuhSrfzYmFRYNqms
         Hk8RcKq6Qlinsg5WfVou+EWQ4SwKqZEGWKRPEdrv36H19TdhNx5GjQDQ56dhVz0/P4xv
         q0iw==
X-Forwarded-Encrypted: i=1; AJvYcCU2nKUtcNAW2LV5D0o3nFPQP1gkqLD3T4OKuI8FvlKDE0qCLbi0pQb4zNMivIYogULsW/otpgL6iOaDp0lI7vYFfAm9sYGuu8Q3409m
X-Gm-Message-State: AOJu0Yz9rAY6TorjekiDsTo8SdjHxZ6seRNgf6AAbfD8daqudOB8FCfB
	UwVkj0/4m1stmQ458W2Rzk7DExz2XtqMsytuKY+3g69G51uC1LmN2CtkObGQRuxiE3g/mXlWsAO
	qx8SLAdqyYuuBsLwkO4AHEI3dfhOIU4SHvw43
X-Google-Smtp-Source: AGHT+IG4+Z3xJiV9ViaWtv31UpnV1skRcMhxR7k7G8ZnUoTpuU39PguHRFK808rdh7qCDZMQ9EjNKCp+2N6os6m57CQ=
X-Received: by 2002:a17:902:bd48:b0:1fa:9b24:c1d0 with SMTP id
 d9443c01a7336-1fac142b62cmr596565ad.8.1719517274063; Thu, 27 Jun 2024
 12:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627181916.1202110-1-namhyung@kernel.org>
In-Reply-To: <20240627181916.1202110-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Jun 2024 12:41:02 -0700
Message-ID: <CAP-5=fU82iBJbBOE6=hehP3JHBURfCwJi4r1Zf_StHJf4SzR_A@mail.gmail.com>
Subject: Re: [PATCH] perf report: Display pregress bar on redirected pipe data
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:19=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> It's possible to save pipe output of perf record into a file.
>
>   $ perf record -o- ... > pipe.data
>
> And you can use the data same as the normal perf data.
>
>   $ perf report -i pipe.data
>
> In that case, perf tools will treat the input as a pipe, but it can get
> the total size of the input.  This means it can show the progress bar
> unlike the normal pipe input (which doesn't know the total size in
> advance).
>
> While at it, fix the string in __perf_session__process_dir_events().
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/session.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 0ec92d47373c..5596bed1b8c8 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2050,6 +2050,7 @@ static int __perf_session__process_pipe_events(stru=
ct perf_session *session)
>  {
>         struct ordered_events *oe =3D &session->ordered_events;
>         struct perf_tool *tool =3D session->tool;
> +       struct ui_progress prog;
>         union perf_event *event;
>         uint32_t size, cur_size =3D 0;
>         void *buf =3D NULL;
> @@ -2057,9 +2058,21 @@ static int __perf_session__process_pipe_events(str=
uct perf_session *session)
>         u64 head;
>         ssize_t err;
>         void *p;
> +       bool update_prog =3D false;
>
>         perf_tool__fill_defaults(tool);
>
> +       /*
> +        * If it's from a file saving pipe data (by redirection), it woul=
d have
> +        * a file name other than "-".  Then we can get the total size an=
d show
> +        * the progress.
> +        */
> +       if (strcmp(session->data->path, "-") && session->data->file.size)=
 {
> +               ui_progress__init_size(&prog, session->data->file.size,
> +                                      "Processing events...");
> +               update_prog =3D true;
> +       }
> +
>         head =3D 0;
>         cur_size =3D sizeof(union perf_event);
>
> @@ -2131,6 +2144,9 @@ static int __perf_session__process_pipe_events(stru=
ct perf_session *session)
>         if (err)
>                 goto out_err;
>
> +       if (update_prog)
> +               ui_progress__update(&prog, size);
> +
>         if (!session_done())
>                 goto more;
>  done:
> @@ -2144,6 +2160,8 @@ static int __perf_session__process_pipe_events(stru=
ct perf_session *session)
>         err =3D perf_session__flush_thread_stacks(session);
>  out_err:
>         free(buf);
> +       if (update_prog)
> +               ui_progress__finish();
>         if (!tool->no_warn)
>                 perf_session__warn_about_errors(session);
>         ordered_events__free(&session->ordered_events);
> @@ -2523,7 +2541,7 @@ static int __perf_session__process_dir_events(struc=
t perf_session *session)
>
>         perf_tool__fill_defaults(tool);
>
> -       ui_progress__init_size(&prog, total_size, "Sorting events...");
> +       ui_progress__init_size(&prog, total_size, "Processing events...")=
;
>
>         nr_readers =3D 1;
>         for (i =3D 0; i < data->dir.nr; i++) {
> --
> 2.45.2.803.g4e1b14247a-goog
>

