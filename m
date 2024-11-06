Return-Path: <linux-kernel+bounces-398551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A53A9BF2B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0C71C26741
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B120E2036ED;
	Wed,  6 Nov 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGyJjcHv"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770551DE8AE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909105; cv=none; b=t9bKb/cig/rDfUO7aLPPjOkN6TGsc0Mxhgb00LUsF7Q2RkWH/HWDyMfl4y7ls+1vnzZ/n2ogQYfTbPwT0XPgEP4Sqaagw8WUVSgvkzoKZvWGP6kDncnbmrrhVaEfSCsWy0HF2tTL1p/WGOnhUUWjkwJ+2LzTHcWkB09iUfOEtUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909105; c=relaxed/simple;
	bh=cH5OE7NX7Mz/bdUBs66w08qwMK7Qsujzly9jtp/uTs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jw6xZDkeOJpTMeLwrwxFmuk6um9WdYEivlp1HMhsInG4JQ7gU+XxFY6oFgaEcXs1OLzAGz6+6hgq5clYJ2FjJzI+MjMHnSR4f5oWtx71g5jjJJSi6anT6Jkqtd2RdZyqNm29n6TC0miiMkCFsfEOQPiys9utpQ7gxweg6AEw6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGyJjcHv; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460a8d1a9b7so250761cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730909102; x=1731513902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL4bTsX4yoJsol4u3vZrSSAIg09xmcdzQI4G8r3j4oA=;
        b=dGyJjcHvAHDgfRG3X/RgQ+bx5l3YhTieFfM7h+u6PvzEBy+fdt4/0RDso71iBRIvUN
         4uKyUZ8euqX6fEDRAU1FArMbIjqAwM9UOELJH70sJFzu6nB7rZyP2KVTgARPpvS2APvB
         z5/0DTOkEhZpuVCW8cmTWumMpLrHEIJCQZThCp6Wouo8A0IVELVLFl5IEUwImMOhoBvU
         E/z07b+C9k/4yagcuO7NziwpUnThJA13kHW7yuzOlq4i8R7WPaXaI6h4iXxz4NvYxPmj
         FEIiKIe2mBL6lYGSdc3VNWbFhg8w2wBqMCPm0dJNfiLeC4ONPnyENm0n5oGygwhfaUPk
         4W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909102; x=1731513902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL4bTsX4yoJsol4u3vZrSSAIg09xmcdzQI4G8r3j4oA=;
        b=puhl6ATEKrHWEpLjwc2QAO1y6ZN14nUBtv4af9+X3PmVUBQprY0V9NxhvMvww146Oy
         iEjmzXsHTvfejHVWXqC0O6t4shCkE+db8nKHGtlt1RO0MmL6YodDOxPpBvVGXR+pwWfm
         t7GYEX7x7rULm4CPzHYS6eWYMjleY42pATyeKmO1yeg1JMpQko3MlRjG/MAAVwZHAGu/
         Uhi0V8oSnMM019WuhK5WlVgjwLgkxjatv400eYAblu+CUhQjESIK6kQEM5rPhergrezH
         4en7UZSuMrOKPQmuPx4YJPl3xnq5twYNYDQ4v5HGnGR1Ik+B+rNR4fNMMZuVXBOftayh
         JphA==
X-Forwarded-Encrypted: i=1; AJvYcCWBM2qvS5VMisua6z6OQWd7uyVVnXIk9yLjfgd74qsBPDTsMKMVh1RBjtufFaYJrSgtrIIBjuK0H+tFfC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEaPMt4yHWzddK0vLmhBDk4xwEouxUS9cnhXV/DCc2CsWSrc/
	q0EzjCKeSaKImyxPaZPojtF2ZOUy0tDJsi/IeJgj9GbqIJcBFYSIVa8eo8Jt1Smy1KkFhCw7YmM
	QxILdExuQ4cRhkD+efpdJwvyAhbRw9gnsXQqgWgGDVWppcVACVjWKgCc=
X-Gm-Gg: ASbGnctIxQWbnnh8WKuTRD3Uz7vVMDS4W2+fmLueGB8r/8FyYTs/HS6Eca4cu4X7WmI
	2U/IyIUH/BvrJomsGol0W1h3K/PqgKgy0qXJPguhvHmI28iP+sHtJJy6ZkYT3L6g=
X-Google-Smtp-Source: AGHT+IGVuAyYxfbKNtvaZjW52zgPaDYQVeAmhHgdEdnwxmPFzOVkFKrhtvzICzMYI5c5fjUF6KVTO9JuvH8HQgPdF7Y=
X-Received: by 2002:a05:622a:612:b0:461:6e0a:6a27 with SMTP id
 d75a77b69052e-462fa6113c7mr288421cf.20.1730909102271; Wed, 06 Nov 2024
 08:05:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106004818.2174593-1-irogers@google.com> <126ebac6-fb52-4c3c-b364-0b423e164d40@linux.intel.com>
In-Reply-To: <126ebac6-fb52-4c3c-b364-0b423e164d40@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Nov 2024 08:04:51 -0800
Message-ID: <CAP-5=fV3RuvU0N_bt7R-ZMs2nX1_wfKh30PA59u3MW0TF4nzBg@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Expand metric+unit buffer size
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 7:27=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-11-05 7:48 p.m., Ian Rogers wrote:
> > Long metric names combined with units may exceed the metric_bf and
> > lead to truncation. Double metric_bf in size to avoid this.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-shadow.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shado=
w.c
> > index 8c9292aa61d3..6b531d4f58a3 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -507,7 +507,7 @@ static void generic_metric(struct perf_stat_config =
*config,
> >       if (!metric_events[i]) {
> >               if (expr__parse(&ratio, pctx, metric_expr) =3D=3D 0) {
> >                       char *unit;
> > -                     char metric_bf[64];
> > +                     char metric_bf[128];
>
> I thin there is already a MAX_EVENT_NAME.
> Can we similarly define a MAX_METRIC_NAME for it?

So in this case the buffer needs to be big enough to hold the metric
name, the unit from the scaleunit (e.g. the "%" from "100%"). I'd
prefer we used dynamic memory allocation to having hard coded limits,
just to avoid a "640K ought to be enough for anybody," moment.
Although this change is implicitly a hard coded limit, sigh. There is
also the metric only name length:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-stat.c?h=3Dperf-tools-next#n160
That looked like it was planned to be dynamically computed but then
the patch adding that never materialized - meaning "standard"
metric-only output has its own cut-off rules at 20 characters. I'd
rather wait on doing a larger cleanup and do this quick fix for now,
mainly as I have enough to do.

While we're talking metrics, I'm still looking for feedback on the
python generation of metrics. v1 was sent back in January, if v4 looks
okay some acknowledgement would be nice:
https://lore.kernel.org/lkml/CAP-5=3DfVX5wypmAAhR8LsE4nSWp5BmN_qhGf9+WCh2be=
bNcGYTg@mail.gmail.com/
Leo sent some feedback to improve some of the ARM metrics, so I can
resend the whole series. Would be nice to gather some acked-by or
other tags.

Thanks,
Ian

