Return-Path: <linux-kernel+bounces-534928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD82A46CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C713AFA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B88256C7C;
	Wed, 26 Feb 2025 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viJwsSP/"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D02566F1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603589; cv=none; b=EHu8LISQosZGWQrJWAB2ApqqAHwaYikUfc/uERaUR2hdBMvHkrFoSLstyOFzmHaiwuFx23Q5u3KkrApaMUMkrbMEhjfKTYdmG29yw/19E9gvW3RyLyKloj0INLWVAmzxX77wJZ0ZGNjvdthyx6IE8ngsr9+gS4zExT+TXaKXas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603589; c=relaxed/simple;
	bh=N2Rf2FQCm+P8gqVxbHJ17gpvziMvAMEqa0WJiN63eFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqktTvkrXkQTsm5k/thd6pxOkq7BAJadnXaGld00HcFzcsv4DBA7GpVl0TUw/SrY2KuAjm0uaJXq8qRt6iJPALG+GUyOx85JZwg17zhPpaIORu9yhveZqNHmYHUYUDKEp8bY6nObOcXDk7nJLiS7ewgeXJaS2I/xzbSd2RMeiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viJwsSP/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22342c56242so41965ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740603586; x=1741208386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpDfAIGhp1H1pQsE6PqmIBzS1xXtlGV1blracxJrRqE=;
        b=viJwsSP/d0gxPnvN6z3gaSH2M903gwLHTZyujZ6KwE8lA7GraT6rvqct5zE+rhmu0i
         b6E+iQxltNlqCUtWdBV+ZSsheSV0vdhGWsaYnQoHoIE8CtjUZamuLT74FofRD2YFC9B6
         ONgVmfsxeR3g6IaZ7YghAeRXwrV9wPiXwpaxfGNgb0QS3RGth/iAfT3V3lvhtafNPHIK
         BW5luR85VY665bd5vt3uGLw1FBrs3Gcbng4Kr1rp0bnjB4PuSfPjf9MNJboL0dCpe7qY
         W+96II0Z+MVyIHzqiLMkE0bHA7P1GaGN4vPypwKK/Nl+sTfMxQa+sCWN0eOH1ynDlZ2s
         4rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740603586; x=1741208386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpDfAIGhp1H1pQsE6PqmIBzS1xXtlGV1blracxJrRqE=;
        b=MYBAD2p53bqLMPJs1E9XCo6bs4XgJVdS1l9p4PWEM0OdyXaALWPCg+4BkdzmfeTy08
         mgHuTxYzXzsASRcXjhiHII83a79B6M0m9vUGkdIKJd8KglB3FKkiOJnl1o7fjNe2p/GR
         KS0AC3gNTCDgaro09eHcayipGlR7LzQ0MW9NYvgmXXIYaLjD93pk31csVL5w/YHTNnpp
         7tds0w4hFsbwA9qJIuFX9m9K025rHXl0WymljI/s8G9970you+tkvLauHuqq5FDdpqGK
         0f6hhRvhYlolsJhTEcsN39wa37nC7xg9Ysxf4vooCgJ+XjSwN6JsK46kdq4EIQzBGbem
         COLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGQ9G8xNBCbwt3a2dfv7/3zRILiqDvtKCDxVKjSEXFLuMpbe6heeRhnMSrL5YkphRERiqUPmgbZTfbbjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypsgfOjfNI9Ivi91wrL5KXduBN6CSnsc9wXB/TJbxoSdk5KHkX
	7uQsKMwB7eXG8/Rw0h+7a4oqUAssepiRngemJOp8TMmQnM0qCUVepj/JrcE8IoBqXoOTuIKPbDW
	xduDJr5cwhjVWNEE5Lp2VHmgoJgQJnh//EcGi
X-Gm-Gg: ASbGncsmo4Sy9RWjxjFKVtvOXzttEtlEqCmFH/u3v2Ptij7H+HcCe/oS1YDVK9h23sa
	9HQyM9zIyx2Tww6zH5tg6wWhFFh12xyHXsXoBVH/V1hXhOZ9Pbd2fMQmftki9f3+PnmNgY1YX0F
	O4afzbU4XIwpAaL7C14szXuCOFc0+oGn9y6po=
X-Google-Smtp-Source: AGHT+IErSMhbekrHYqaP1wrOlN6DjS+bvccnZmVDEJgXkfri8fufy+RUIPZMy2DNosH+Gy44rSU6iNaTrXz1wCUUORQ=
X-Received: by 2002:a17:903:2788:b0:215:367f:2967 with SMTP id
 d9443c01a7336-2234d5a097cmr564165ad.2.1740603585776; Wed, 26 Feb 2025
 12:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226203039.1099131-1-namhyung@kernel.org>
In-Reply-To: <20250226203039.1099131-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 12:59:33 -0800
X-Gm-Features: AQ5f1Jr7nGn8m3ucAcU7Zv_Fe0QHxkl4_j87Hgs7zT3dRKWfSnQz01WeXzVqdU8
Message-ID: <CAP-5=fVh2tTD22sFrPt37OJAhOsggvt2AVwf45p_pxTa=pnVKA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Skip BPF sideband event for userspace profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	James Clark <james.clark@linaro.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The BPF sideband information is tracked using a separate thread and
> evlist.  But it's only useful for profiling kernel and we can skip it
> when users profile their application only.

nit: It may be worth noting that profiling an application implicitly
excludes the kernel samples.

> It seems it already fails to open the sideband event in that case.
> Let's remove the noise in the verbose output anyway.
>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

I wonder if the second evlist could be avoided similar to Howard's
off-CPU sample events?
I also wonder if we should make the evlist responsible for BPF and
dummy/sideband events. Having unnecessary events increases the list
size iterated over when creating sideband data, and so has a runtime
cost. Having the logic separated in places like builtin-top and
builtin-record feels suboptimal.

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c |  3 +++
>  tools/perf/builtin-top.c    |  3 +++
>  tools/perf/util/evlist.c    | 14 ++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  4 files changed, 21 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0e45bd64185403ae..cc61f5d6c599039c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2535,6 +2535,9 @@ static int __cmd_record(struct record *rec, int arg=
c, const char **argv)
>                 goto out_free_threads;
>         }
>
> +       if (!evlist__needs_bpf_sb_event(rec->evlist))
> +               opts->no_bpf_event =3D true;
> +
>         err =3D record__setup_sb_evlist(rec);
>         if (err)
>                 goto out_free_threads;
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 6440b5c1757d92ce..c284a384542ff822 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1833,6 +1833,9 @@ int cmd_top(int argc, const char **argv)
>                 goto out_delete_evlist;
>         }
>
> +       if (!evlist__needs_bpf_sb_event(top.evlist))
> +               top.record_opts.no_bpf_event =3D true;
> +
>  #ifdef HAVE_LIBBPF_SUPPORT
>         if (!top.record_opts.no_bpf_event) {
>                 top.sb_evlist =3D evlist__new();
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f0dd174e2debdbe8..43adf6b3d855771a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2594,3 +2594,17 @@ bool evlist__has_bpf_output(struct evlist *evlist)
>
>         return false;
>  }
> +
> +bool evlist__needs_bpf_sb_event(struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +
> +       evlist__for_each_entry(evlist, evsel) {
> +               if (evsel__is_dummy_event(evsel))
> +                       continue;
> +               if (!evsel->core.attr.exclude_kernel)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index adddb1db1ad2b25d..edcbf1c10e92f0c4 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -435,5 +435,6 @@ void evlist__check_mem_load_aux(struct evlist *evlist=
);
>  void evlist__warn_user_requested_cpus(struct evlist *evlist, const char =
*cpu_list);
>  void evlist__uniquify_name(struct evlist *evlist);
>  bool evlist__has_bpf_output(struct evlist *evlist);
> +bool evlist__needs_bpf_sb_event(struct evlist *evlist);
>
>  #endif /* __PERF_EVLIST_H */
> --
> 2.48.1.658.g4767266eb4-goog
>

