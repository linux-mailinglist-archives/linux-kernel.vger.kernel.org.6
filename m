Return-Path: <linux-kernel+bounces-529865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF5BA42BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2230817B8BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BAA266B4B;
	Mon, 24 Feb 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxdP2LC4"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906CC266196
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423038; cv=none; b=sObpliOuXL68uPNCi9l+F2rVMbroxP53pk6Fccg0Z10IVM9jXJNEzOAPcmrDdVQReceE88ONTjspJl6U1YK/eoruyRk6WS9weUJGGu626IEnFbtjPW8ET0dBpaJ6P4qlCVpGOfNEQa1v2dvQxP+2FwNdqldO3fhH+FwBCnAmMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423038; c=relaxed/simple;
	bh=5CaLqSIq4mCnOOx0MhA6jcrVXhqB1DEJiNOTtn0cTGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruzgTEe8i9OnI/i8XGxsik40+Sk2com8BKcSvNNnI3ogFDnVJg3jrCbwmhPZd8QLZ61OEx+ZXjByq2D7VE9WWVt3wokSEV3mApux/wF2PXAArd65KTFL6jTJP9XKahDBZbgJt0CZ+LH8cNgYAeuRPe9G4f0f88t6u6VJiK42HgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxdP2LC4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2212222d4cdso21885ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740423036; x=1741027836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9zPz9Dl0COcxVGhQTNW8N2OAhun/SnyUt3wbyp6XG8=;
        b=VxdP2LC4bPJvxzeCXZ7n/ytoFv3tkVu6JsgyKBecDU7y+/6G5xIOtptJWTie4QruEu
         3miA30qoTNStdflA3D1YwtHXOg4Y+VxASYBXqUQeKxVoNAdfKX9XZqqhycXWL/6e57Fz
         eqS7eWsATQGlfKkPJRuvAdIUnLkHKte5hX0fFTrJEpIWb1/nVPa0LK1L6+iEF0N9iLsV
         UHpwUvGyAda6Su0Q1LGR5HErczHijtOCzw4SICS3m2QThHBiLbXtURlhntmQztqFqNUl
         cbxXWfQ/sn/8yVRp2J0Q+ZRVm64l6aUlpPXY4jR4273KE9n8B6jx+VvNDHhGFZaStCrI
         dZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423036; x=1741027836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9zPz9Dl0COcxVGhQTNW8N2OAhun/SnyUt3wbyp6XG8=;
        b=tERvfHn80vPMfRCssAQjUNalqy0jbIyTgHC/xNntk560ya4O1dhFe4GS1FipMFJQga
         D5ZevPccAzGeCSIO5MYCo8sbYPVvuei8/K7TVYChKJbQl0SafqYJJD3Djom2mo516zZj
         11mWX2UC2r0ZO7PWE5M1SFruPYoM5RzbUBleVy/yr78iFagByuq6QSL3F+FMnUdiNXuA
         BwdFbjaNOA00hmzM7mG1c0m0pIJnhiXDSJfl6uIeyWGzAgCfFjLZotrGpY8nt1oqA/EY
         SI4SmNACmHscHCkp6cpq9VnYRn/uh0kVMb1qPsZL2V3rGvbiOwiM4eTTEVEKSfEh/XgR
         GKqw==
X-Forwarded-Encrypted: i=1; AJvYcCW8wB5zh0ZGLdQU1hETi0p0bgo72hyl9lI4UCYQWF9CsAoA5TQGidh+A6/Fiu8nQjsym/FwH560ItewGVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPFtHUX90p3Q+NZQfsMPttCZbtqDeW72InWlaWNpSc1flsM8PF
	1cyGpQkb++C3jE/6LlRjM6MVb9gTtXsJMfpoD70M10IQSDAktCbdIsJQDP+/yzPxdT3uAYVAmt/
	dEkRVR1eaifPGO9dFm0Xf0xqPDgUZUM2krZNU
X-Gm-Gg: ASbGncuDj34attKE367NcMZ5gPkEjSEZ8BpwrV8EXyDvwOW3gwnxplMPc5Y7CiIjAu0
	PjqPA1BKPbxvVRNxixSNr0Er3JzGIHG7zP+HG8HlxxLyQnVK900PlLTNpocOr+zk8vEtWRM91Pd
	Gf63nYxNPWioJ+uWl9bvhOGwaDidqxf9D2tk0=
X-Google-Smtp-Source: AGHT+IF4iy7Cr6LyEEeDuwD4QeXjKkepRemJp0RPuKz+bUm+oM1sBypRaykIARZw7zxRPsFInMQ7EtobdxMm+8z6kEQ=
X-Received: by 2002:a17:903:22ce:b0:212:26e:1b46 with SMTP id
 d9443c01a7336-22307a9740cmr453145ad.23.1740423035520; Mon, 24 Feb 2025
 10:50:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627200353.1230407-1-namhyung@kernel.org> <CAP-5=fWSpM7NL7UjXZBN8WHNAE7hGe1ghQ6_DqFe2VjTCGoA7A@mail.gmail.com>
 <CAM9d7cibrW=K=GZB_zsURB1Ff6Eok7qy3rVt83VVM6pVhv+Agg@mail.gmail.com>
In-Reply-To: <CAM9d7cibrW=K=GZB_zsURB1Ff6Eok7qy3rVt83VVM6pVhv+Agg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Feb 2025 10:50:24 -0800
X-Gm-Features: AWEUYZnbjIOlvNwJafq1_Xk-12VDEFP9TXTd1RynT8x8YsqpDfDJmh1ZtcqMoB8
Message-ID: <CAP-5=fVmybd=WTKS3kvsF+VU_Lrke9hEvNyBtunAHBw-6ViZig@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf stat: Use field separator in the metric header
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 3:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Thu, Jun 27, 2024 at 1:48=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Jun 27, 2024 at 1:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > It didn't use the passed field separator (using -x option) when it
> > > prints the metric headers and always put "," between the fields.
> > >
> > > Before:
> > >   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-on=
ly true
> > >   core,cpus,%  tma_core_bound:     <<<--- here: "core,cpus," but ":" =
expected
> > >   S0-D0-C0:2:10.5:
> > >   S0-D0-C1:2:14.8:
> > >   S0-D0-C2:2:9.9:
> > >   S0-D0-C3:2:13.2:
> > >
> > > After:
> > >   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-on=
ly true
> > >   core:cpus:%  tma_core_bound:
> > >   S0-D0-C0:2:10.5:
> > >   S0-D0-C1:2:15.0:
> > >   S0-D0-C2:2:16.5:
> > >   S0-D0-C3:2:12.5:
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++------=
--
> > >  1 file changed, 29 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-di=
splay.c
> > > index 91d2f7f65df7..e8673c9f6b49 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -47,16 +47,27 @@ static int aggr_header_lens[] =3D {
> > >  };
> > >
> > >  static const char *aggr_header_csv[] =3D {
> > > -       [AGGR_CORE]     =3D       "core,cpus,",
> > > -       [AGGR_CACHE]    =3D       "cache,cpus,",
> > > -       [AGGR_DIE]      =3D       "die,cpus,",
> > > -       [AGGR_SOCKET]   =3D       "socket,cpus,",
> > > -       [AGGR_NONE]     =3D       "cpu,",
> > > -       [AGGR_THREAD]   =3D       "comm-pid,",
> > > -       [AGGR_NODE]     =3D       "node,",
> > > +       [AGGR_CORE]     =3D       "core%scpus%s",
> > > +       [AGGR_CACHE]    =3D       "cache%scpus%s",
> > > +       [AGGR_DIE]      =3D       "die%scpus%s",
> > > +       [AGGR_SOCKET]   =3D       "socket%scpus%s",
> > > +       [AGGR_NONE]     =3D       "cpu%s",
> > > +       [AGGR_THREAD]   =3D       "comm-pid%s",
> > > +       [AGGR_NODE]     =3D       "node%s",
> > >         [AGGR_GLOBAL]   =3D       ""
> > >  };
> > >
> > > +static int aggr_header_num[] =3D {
> > > +       [AGGR_CORE]     =3D       2,
> > > +       [AGGR_CACHE]    =3D       2,
> > > +       [AGGR_DIE]      =3D       2,
> > > +       [AGGR_SOCKET]   =3D       2,
> > > +       [AGGR_NONE]     =3D       1,
> > > +       [AGGR_THREAD]   =3D       1,
> > > +       [AGGR_NODE]     =3D       1,
> > > +       [AGGR_GLOBAL]   =3D       0,
> > > +};
> > > +
> > >  static const char *aggr_header_std[] =3D {
> > >         [AGGR_CORE]     =3D       "core",
> > >         [AGGR_CACHE]    =3D       "cache",
> > > @@ -1185,8 +1196,18 @@ static void print_metric_headers_csv(struct pe=
rf_stat_config *config,
> > >  {
> > >         if (config->interval)
> > >                 fputs("time,", config->output);
> > > -       if (!config->iostat_run)
> > > +       if (config->iostat_run)
> > > +               return;
> > > +
> >
> > Having a static count of commas seems somewhat error prone, perhaps:
> > ```
> > const char *header =3D aggr_header_csv[config->aggr_mode];
> > if (config->csv_sep =3D=3D ',' || !strchr(header, ',')) {
> >   fputs(config->output, header);
> > } else {
> >   char *tmp =3D strdup(header);
> >   char *p =3D tmp;
> >    while (p && *p) {
> >       if (p =3D=3D ',')
> >         *p =3D config->csv_sep;
> >      p++;
> >    }
> >   fputs(config->output, tmp);
> >   free(tmp);
> > }
> > ```
>
> Looks good.  But I think we should handle longer separators like -x ":::"=
.
> Will do in v2.

Hi Namhyung,

It looks like this has been forgotten. Did you have a v2?

Thanks,
Ian

> > I'm somewhat surprised that we have no metric tests in the stat output
> > tests like tools/perf/tests/shell/stat+csv_output.sh. Perhaps we can
> > add the following:
> > ```
> > diff --git a/tools/perf/tests/shell/lib/stat_output.sh
> > b/tools/perf/tests/shell/lib/stat_output.sh
> > index 9a176ceae4a3..a920b2d78abb 100644
> > --- a/tools/perf/tests/shell/lib/stat_output.sh
> > +++ b/tools/perf/tests/shell/lib/stat_output.sh
> > @@ -148,6 +148,14 @@ check_per_socket()
> >        echo "[Success]"
> > }
> >
> > +check_metric_only()
> > +{
> > +        echo -n "Checking $1 output: metric only "
> > +        perf stat --metric-only $2 -e instructions,cycles true
> > +        commachecker --metric-only
> > +        echo "[Success]"
> > +}
> > +
> > # The perf stat options for per-socket, per-core, per-die
> > # and -A ( no_aggr mode ) uses the info fetched from this
> > # directory: "/sys/devices/system/cpu/cpu*/topology". For
> > diff --git a/tools/perf/tests/shell/stat+csv_output.sh
> > b/tools/perf/tests/shell/stat+csv_output.sh
> > index fc2d8cc6e5e0..d6807dbab931 100755
> > --- a/tools/perf/tests/shell/stat+csv_output.sh
> > +++ b/tools/perf/tests/shell/stat+csv_output.sh
> > @@ -44,6 +44,7 @@ function commachecker()
> >        ;; "--per-die")         exp=3D8
> >        ;; "--per-cluster")     exp=3D8
> >        ;; "--per-cache")       exp=3D8
> > +        ;; "--metric-only")     exp=3D2
> >        esac
> >
> >        while read line
> > @@ -83,6 +84,7 @@ then
> >        check_per_cluster "CSV" "$perf_cmd"
> >        check_per_die "CSV" "$perf_cmd"
> >        check_per_socket "CSV" "$perf_cmd"
> > +        check_metric_only "CSV" "$perf_cmd"
> > else
> >        echo "[Skip] Skipping tests for system_wide_no_aggr, per_core,
> > per_die and per_socket since
> > socket id exposed via topology is invalid"
> > fi
> > ```
> > It is using the hard coded metrics and it looks like the header
> > printing for that is broken, but this is so often the case for stat
> > output :-(
>
> Right, I also noticed something in the header.  One more work
> item to the list.
>
> Anyway, I'll add it to the test case!
>
> Thanks,
> Namhyung
>
> >
> > > +       if (aggr_header_num[config->aggr_mode] =3D=3D 1) {
> > > +               fprintf(config->output, aggr_header_csv[config->aggr_=
mode],
> > > +                       config->csv_sep);
> > > +       } else if (aggr_header_num[config->aggr_mode] =3D=3D 2) {
> > > +               fprintf(config->output, aggr_header_csv[config->aggr_=
mode],
> > > +                       config->csv_sep, config->csv_sep);
> > > +       } else {
> > >                 fputs(aggr_header_csv[config->aggr_mode], config->out=
put);
> > > +       }
> > >  }
> > >
> > >  static void print_metric_headers_json(struct perf_stat_config *confi=
g __maybe_unused,
> > > --
> > > 2.45.2.803.g4e1b14247a-goog
> > >

