Return-Path: <linux-kernel+bounces-181335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341018C7AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96C3283198
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05C8489;
	Thu, 16 May 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kz+G+R1q"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD206FD5
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877902; cv=none; b=Q7kXXQNqAxlLHxcQ4LB7/IUPpM/QLH5SUyi2N1EEq3zocQKsAeOykXe03qkm7WnPJJCQkVKxwD/9C2kdpanZAfYhp5+gLNCAiwqvttnlIVrPuGgm5Cwm0SWqPph9V2mVex1dM3y5fWu9RxsDENOYvlpR4dOoAF+epW2c1W9I63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877902; c=relaxed/simple;
	bh=VPlsruD35JAQqV3gEarB9dVDjoQdF9uedLGs17A74Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2Se+tRNsxeGIHpd+zyxM01ROgED58jc/Z8UK0OcjYpVqRzoVykHFR5YF+M2EX+Kq6NWF1HThPN18pbK3+wtXUgIngEhC/apaQto0+Nxx5wYSVG3H0v6bkQIFrUbnaETmq4SzaecXXPbTRi8dleEkrcomh3JuLVh1GcgIh134iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kz+G+R1q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso3425ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715877900; x=1716482700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdYJOsDWTmNqWlkMdmJgsT3jwYhNIzkdpl7HU6s1mPM=;
        b=Kz+G+R1qLk3OLN6bHUcpI4zJv1tFB3tEbn8aPL+XDjyuRoPG1KIaVRuit5M1fMrenO
         Q8V1z8hdpOWSusdBAQzEuBvHZDgXezvbuIvroWFsuQy1I2Y7P/9i3JAFvQN8kDDzyilf
         PiFe5nj08ieK0xXps3j5z8OHoz5XPh3HmBYhUMKKAeEdbUmrrY9Rm4/328wX9uv3RH6X
         xXvBhK9Ljd9D/CxBAIkoUfoRGazbbExkjU7lJAqO8dqPcZrDOuYkxZUQIS2gW+tjpegD
         Y1Hs0hMcHM1GVH0E1Z52GgZm/ajOgC8bSZuNew7mfMPc8nYoLETltWZoZ5z9rGyLlNN8
         gxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715877900; x=1716482700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdYJOsDWTmNqWlkMdmJgsT3jwYhNIzkdpl7HU6s1mPM=;
        b=e3fGx+H9C8wxsfpvZdusfAGyZKdXjYh2axQR6N+DnzJ+EqSc+GHye4NaHpO7qNfZ4G
         2WRnqgXnzY3/fPUdLHSVxZNxvUUHLsdgbrOIBz2lrkm5lIOP+qHNq+PgDHPPjFQrKEWF
         h1G+czd6WhUU6TSCc1UD/AUl70Geyvai/A8zhgTZ1ASuLzlAL/PbBLCxNrSWkW5RbGnL
         1CBJekMFUps3LqzexQh5g6GGvnNeKSCo4BJ/cu+rod23w/TqnLq9E2AJnSD/2oV2/mdX
         iEgX42g6DGCcz6eXBzlUoqLitimwintfzB6f6exakUm5yBckHzfBGXUywK2YIre/oXrF
         wfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqtqivF5/uYtgnqCp7Ym1hr+w+8vRbUTii+MKDJN83NhyiBIDC7eYHioMe0NqYpp050mfqRt3TnmOT0GAg2fY1qUP2Ot/rOLZkOSed
X-Gm-Message-State: AOJu0YyAU0d+9yRhvQx/FPibXmlLBASjohCzUVQi782WnkIT7W+ukLrX
	7KMi+hUJTcDiWXyTLZ4aW5A3VtXiEqbn1WPlA9FifzhZ+xt5YkB/Bujka4PUTd3BV2GmJ0k9+Mx
	tPowGIztJiXCDAP0wNC9+F/u1/Ae15WgbCeOT
X-Google-Smtp-Source: AGHT+IFoo1JC4O175ZwyZQ3bk20utaBoBQQlTCsOymwt/4ExhPv/s5Y88E8nNj97m7jZ58XxCGj3unXFb5zKqk6ouR8=
X-Received: by 2002:a17:902:ec86:b0:1e5:5cce:7eca with SMTP id
 d9443c01a7336-1f05f660814mr12642895ad.8.1715877899735; Thu, 16 May 2024
 09:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com> <20240515054443.2824147-5-weilin.wang@intel.com>
In-Reply-To: <20240515054443.2824147-5-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 09:44:45 -0700
Message-ID: <CAP-5=fUmH74Bbbm40oqDynDQL+GUi7iFKjHKSKc5-dPafqifzA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 4/7] perf stat: Add retire latency values into the
 expr_parse_ctx to prepare for final metric calculation
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Retire latency values of events are used in metric formulas. This update =
adds
> code to process data from perf record for required retire latency values.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

In the evsel approach:
https://lore.kernel.org/lkml/20240428053616.1125891-1-irogers@google.com/
we don't need to special case tpebs events like this. I'd prefer we
went that route. My reviewed-by no longer stands.

Thanks,
Ian

> ---
>  tools/perf/util/stat-shadow.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 3466aa952442..b97d23bfeac1 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -15,6 +15,7 @@
>  #include <linux/zalloc.h>
>  #include "iostat.h"
>  #include "util/hashmap.h"
> +#include "util/intel-tpebs.h"
>
>  struct stats walltime_nsecs_stats;
>  struct rusage_stats ru_stats;
> @@ -355,6 +356,20 @@ static void print_nsecs(struct perf_stat_config *con=
fig,
>                 print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0=
);
>  }
>
> +static int prepare_retire_lat(struct expr_parse_ctx *pctx,
> +                            struct list_head *retire_lats)
> +{
> +       int ret =3D 0;
> +       struct tpebs_retire_lat *t;
> +
> +       list_for_each_entry(t, retire_lats, nd) {
> +               ret =3D expr__add_id_val(pctx, strdup(t->tpebs_name), t->=
val);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +       return ret;
> +}
> +
>  static int prepare_metric(const struct metric_expr *mexp,
>                           const struct evsel *evsel,
>                           struct expr_parse_ctx *pctx,
> @@ -369,6 +384,9 @@ static int prepare_metric(const struct metric_expr *m=
exp,
>                 double val;
>                 int source_count =3D 0;
>
> +               if (metric_events[i]->retire_lat)
> +                       continue;
> +
>                 if (evsel__is_tool(metric_events[i])) {
>                         struct stats *stats;
>                         double scale;
> @@ -486,6 +504,11 @@ static void generic_metric(struct perf_stat_config *=
config,
>                 pctx->sctx.user_requested_cpu_list =3D strdup(config->use=
r_requested_cpu_list);
>         pctx->sctx.runtime =3D runtime;
>         pctx->sctx.system_wide =3D config->system_wide;
> +       i =3D prepare_retire_lat(pctx, &config->tpebs_results);
> +       if (i < 0) {
> +               expr__ctx_free(pctx);
> +               return;
> +       }
>         i =3D prepare_metric(mexp, evsel, pctx, aggr_idx);
>         if (i < 0) {
>                 expr__ctx_free(pctx);
> --
> 2.43.0
>

