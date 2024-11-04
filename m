Return-Path: <linux-kernel+bounces-395506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAB99BBEDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E33282B78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849C1F666D;
	Mon,  4 Nov 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjFO3h9C"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606531F5847
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752623; cv=none; b=NFtltkz8w+xG2Dj4S/ToCEHVKQ17cNE1GGNz43+hBrSwBR66R++CMULlNn4xREBZNrqLkHBmpEjTxZepcx7rnG9Er628//0RvMVH5wbzB1xc5FtHN7om85h9bgaECznL9s6vBm2SjuUT7ZbTIbQ7zFSIv4BVCPX4POWALahAuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752623; c=relaxed/simple;
	bh=4nBRmUtbA108cfLj2oSnAsY8P82ZupaRNwnNsR+3/5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/Va+qW40OpupiXCuHVFnG8+h8Qebfyoc64Q7boVOXxZUcY/HyKzYB7FupyNokVCvZJpzusEScyAsJ+DkVzseWTv9n8boBxlGCavu0rrgSNHm1FwRmqEJnt38T+v3FDFY6MBXZah00pJwwzcVaxx+o0qYMEl7OOzgI8/WCd8EG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjFO3h9C; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso44505ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730752619; x=1731357419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjVDRx6oH+xeW6jQUK0g6WGli8hpIwXPydX3YYIiQho=;
        b=sjFO3h9C7KSRCegTLvegsh3crfCEKRTKKwRus67oxBcpkeXH6EZf0tC5Kh1MmcRb7E
         msju2noJhhfVkKXf3nAKfQFN1cmJjX2fBn5mtkr00HUOSpWry81lStqWvkamzyqUMI+X
         ckSWUyHARLYy2/KNo3/gGni+ccdnLI/qIxJsLccJy8SWAYbxZNXyslud4+FKwlCN8JNM
         LwLCGbg9+E+IOFI32P+MQwKVhsTow0NbYrJaWjuTut4xVqcYr6CtZthbb4ktei4Z1jlE
         pI0V974ncjNVsssOBJ2DlLghhoRe4ec5DJ2EdNs5ni4su5wRwGH1aNINe5FxHxdAu1Tz
         /nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752619; x=1731357419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjVDRx6oH+xeW6jQUK0g6WGli8hpIwXPydX3YYIiQho=;
        b=l88RgYaNEbSVg49FSJ5dmH5uP+L3Yu8a8ZA6N5ShL1e4yES3NlAPUmVy7RolBjH2D6
         CJoCiTmEhcw0Id1le1Vq4OTJ1LBB/jyUXcblw8PVVUrTLV7AUDJLQCswuFFVpXEjjx8z
         7nZDP2jYl8hqemv0BETjMAcggG1t4Cskxy2MwqwqiJaWFyQEtQXE0WfyQgG2IeJKQjDb
         jzAS605nJK3P0+PTCHxN30mSvAcyQyfXq88T8VdkxRgtd2JXTf10nndNgWumegdCX5yE
         dTBbWChP/hRLOHtO0Mls5oU8+s0CcJcadrki1y9nitmGmqQf4b3ylIQcutnmdOvqI7bI
         Xn7A==
X-Forwarded-Encrypted: i=1; AJvYcCU3eX+AsLLZpeOTJ0yHYCZUziFaNh5FcpmUxdoHDH45DeOXkDtk6gbcN4/+MgfIqEKz8y2zoEMaGc2oPlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzdrxBsdi+ZOTcKeuRp3XejbWCtws6PzeLihApcFQyU4R1XXjf
	Ic9SVq90JBtOvP87CvngBOiOTXDuM6a/K3Xj/Fuy8KzqnmZaYOyToV/8Var9G3axRZK81jM1JxK
	XJg8y0gkC0py3UR1LDEhA1Zl17zG306xekhqW
X-Gm-Gg: ASbGncvilbsOrwpDfnP/CF1LeDXu0sP5PiQFG+mQ/gqfCGa4c2s1funceDhd7/DanwJ
	7HWZ1T1MtocOpF5IVSgSOycavVTg4vVLYeYT/igYA8JWjSXtnSNzIM99wMcZ8Kg==
X-Google-Smtp-Source: AGHT+IESkicvZoSSZrcJAJpL2CY40Vg5qDWTWVmcUyR/sBcGeJfCyGZQrc40LU+36/ln0l+5dHy3kQgKyy9BNSbN0Bg=
X-Received: by 2002:a05:6e02:12b4:b0:3a6:b318:3b99 with SMTP id
 e9e14a558f8ab-3a6daa9e751mr627685ab.27.1730752619348; Mon, 04 Nov 2024
 12:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103142302.230370-1-linux@treblig.org>
In-Reply-To: <20241103142302.230370-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 12:36:48 -0800
Message-ID: <CAP-5=fXNJ_QbEA20eusx7EDqp=pQgVdW_+-w1T=vsrzH4BGjpw@mail.gmail.com>
Subject: Re: [PATCH] perf: event: Remove deadcode
To: linux@treblig.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 6:23=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> event_format__print() last use was removed by 2017's
> commit 894f3f1732cb ("perf script: Use event_format__fprintf()")
>
> evlist__find_tracepoint_by_id() last use was removed by 2012's
> commit e60fc847cefa ("perf evlist: Remove some unused methods")
>
> evlist__set_tp_filter_pid() last use was removed by 2017's
> commit dd1a50377c92 ("perf trace: Introduce filter_loop_pids()")
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evlist.c            | 18 ------------------
>  tools/perf/util/evlist.h            |  2 --
>  tools/perf/util/trace-event-parse.c |  6 ------
>  tools/perf/util/trace-event.h       |  3 ---
>  4 files changed, 29 deletions(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f14b7e6ff1dc..4b992a3f2985 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -362,19 +362,6 @@ __weak int arch_evlist__add_default_attrs(struct evl=
ist *evlist,
>         return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
>  }
>
> -struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int i=
d)
> -{
> -       struct evsel *evsel;
> -
> -       evlist__for_each_entry(evlist, evsel) {
> -               if (evsel->core.attr.type   =3D=3D PERF_TYPE_TRACEPOINT &=
&
> -                   (int)evsel->core.attr.config =3D=3D id)
> -                       return evsel;
> -       }
> -
> -       return NULL;
> -}
> -
>  struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, con=
st char *name)
>  {
>         struct evsel *evsel;
> @@ -1199,11 +1186,6 @@ int evlist__set_tp_filter_pids(struct evlist *evli=
st, size_t npids, pid_t *pids)
>         return ret;
>  }
>
> -int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid)
> -{
> -       return evlist__set_tp_filter_pids(evlist, 1, &pid);
> -}
> -
>  int evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, p=
id_t *pids)
>  {
>         char *filter =3D asprintf__tp_filter_pids(npids, pids);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index bcc1c6984bb5..ff73908e2178 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -144,7 +144,6 @@ int __evlist__set_tracepoints_handlers(struct evlist =
*evlist,
>         __evlist__set_tracepoints_handlers(evlist, array, ARRAY_SIZE(arra=
y))
>
>  int evlist__set_tp_filter(struct evlist *evlist, const char *filter);
> -int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid);
>  int evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_=
t *pids);
>
>  int evlist__append_tp_filter(struct evlist *evlist, const char *filter);
> @@ -152,7 +151,6 @@ int evlist__append_tp_filter(struct evlist *evlist, c=
onst char *filter);
>  int evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid);
>  int evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, p=
id_t *pids);
>
> -struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int i=
d);
>  struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, con=
st char *name);
>
>  int evlist__add_pollfd(struct evlist *evlist, int fd);
> diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-=
event-parse.c
> index f0332bd3a501..d97830cdbd7e 100644
> --- a/tools/perf/util/trace-event-parse.c
> +++ b/tools/perf/util/trace-event-parse.c
> @@ -116,12 +116,6 @@ void event_format__fprintf(struct tep_event *event,
>         trace_seq_destroy(&s);
>  }
>
> -void event_format__print(struct tep_event *event,
> -                        int cpu, void *data, int size)
> -{
> -       return event_format__fprintf(event, cpu, data, size, stdout);
> -}
> -
>  /*
>   * prev_state is of size long, which is 32 bits on 32 bit architectures.
>   * As it needs to have the same bits for both 32 bit and 64 bit architec=
tures
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.=
h
> index bbf8b26bc8da..0e5133f1b910 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -42,9 +42,6 @@ struct tep_event *trace_event__tp_format_id(int id);
>  void event_format__fprintf(struct tep_event *event,
>                            int cpu, void *data, int size, FILE *fp);
>
> -void event_format__print(struct tep_event *event,
> -                        int cpu, void *data, int size);
> -
>  int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned lon=
g size);
>  int parse_event_file(struct tep_handle *pevent,
>                      char *buf, unsigned long size, char *sys);
> --
> 2.47.0
>

