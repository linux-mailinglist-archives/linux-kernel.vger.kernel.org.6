Return-Path: <linux-kernel+bounces-511933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E8A331AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6E41886684
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DD72036E5;
	Wed, 12 Feb 2025 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8HlChAu"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BC1D5143
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396308; cv=none; b=S2pQUKYeNfMwXF5x49amjwxnl1/8o7BL53Pxdrfg00sMuHhKYOJgperot6WLSypCKDwBiFUsVZrEOLf4736xy6BWx5HI7iyASoOueeNWLrYh4TAN+wzdtCUi4nfTM56n03CqiLhlChL0hd7hFwHbcNEvs0BaEmoIqtBB2iKI4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396308; c=relaxed/simple;
	bh=rs8N/GL1JM0sKBZY/muU+0DekJkqdnHQWij3XtDwrPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBhTKTEuaEhxtYkTSSttWh2HDnoLpUdcuwmaeuSdScK0L+76f8i93RmR/fEtSFSw6PZByb1S9VNL/2PlltZE4OEy/uKnsPo06p6ZRV80lNMhw0orXfIA7FJzuRNHQQv6TptreWQ1VubYd3j46ZsYpgKhJQmMFuvO1ToUjaiLkpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8HlChAu; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d147331fb5so3715ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739396306; x=1740001106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYGd3wINgKYYi8KyuxMJe+1xZs2xd7jGE3Yssdq90MA=;
        b=q8HlChAuCpMt9DJpLd1/8DlnCg/02XiRx/qHkHz+J+7Rll8Na6Szw9kb0DeJWG1pm0
         y7sQlrR2anDBXpPNJ3r01ak6TtNmU9RwimCrwpFHu0m8yew1Pidk38Cm8kzvUMEh1Xab
         Fnyos833x90+WktXGr+tIYc1Cd7dViHLD41dTcraXhXKLC5a5dc5dcC1gLhQ2+bUxGo9
         mAFK71aUAbKZXqTgd0bmMYM2QWzL86Y84ZlrCdv9y4MKc5fNFQzU7s8cBE0W6Y/umjCO
         znKpAWvMjoKlzSDmiAs/nw9hdLgDofLMYFtIbwC212Z/JN1fcXujT3FXRPyujdEQs04e
         Lbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739396306; x=1740001106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYGd3wINgKYYi8KyuxMJe+1xZs2xd7jGE3Yssdq90MA=;
        b=is84R7hYX0hbf9SyLFqza0yc7Qe3VGn+nKRNL9IVIcP913rgbHLR+qk48WkNj+kQbE
         czJcyP2tYV/cGbfw184w14IBIJNMIfE7130msgtFha6su7xMFCK1XYh1Bn47QVu+ZJiy
         MXUTeC3fvMYkxwyM94B7PrHTCNPdTSx/jJJoZVXNgmmfJj+40nEibZEcz3SqwKNUupyC
         By784BoMZ2JBAlmyqpZl4vCIv1ce+7WUJ58XKOZWETVlYxH072WQUp9JlE6FrSrAS2m4
         mo4Eaqy25Ki3jNLlTwZF9jwimBTzMUKtyEX2mwUcgBlj8VTEMNt+B49/bIPK0gUYJyji
         UDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+U6GVBci6RO5JvS3acV5x7VpQCKrL48PaxAuApXeQjhTdFAYTIJ6wPtIflSXCvhvx0A7aSzVvaBwYBkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEb3Ki810V7MkKtHM5OlEETU9Q8Rq+btBa/iYgh9YbGe6POIT
	Lr/MlzT6Mw/M6y+/6E9iYYPl6tzxUSRcUL/hVeKv3UdQOBXQEWsVumkV3/Oz19vSRS3DOag0qJi
	CfB8abNnpqqZ6+jjiFuNSDzUEVxtAGoDqzzgf
X-Gm-Gg: ASbGnctu0C6Lh+HcS4kxJN0gqwdVL9sREjpLyDCZl8eoe6cP6l5DpGHNq1bdnYQj0m6
	UVFjt+BTBK3rzAQ83WtqOaAYHdg43MSn6f4LmDMlaE0rzA+1nDZt6pc5aW8slnX3Tilohn4Z9DC
	TvWnmBTggUbvRmHy7bfKSPPl+o
X-Google-Smtp-Source: AGHT+IFkHaAQcVKqOrFRwN4yJ80hrx+BfOBW/ZZbRDPmVrhiHFq3FEkfpIAv6+GvNshJQca9GKZuXQBZp2XpA5A94vM=
X-Received: by 2002:a05:6e02:3b88:b0:3a7:683e:2fb0 with SMTP id
 e9e14a558f8ab-3d18cc8b9e4mr906985ab.6.1739396305534; Wed, 12 Feb 2025
 13:38:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212122413.1184503-1-james.clark@linaro.org> <CAP-5=fWywDB40-RgV8LaPqsoffOLdDcYkUB_LHoPvV=R8yas4w@mail.gmail.com>
In-Reply-To: <CAP-5=fWywDB40-RgV8LaPqsoffOLdDcYkUB_LHoPvV=R8yas4w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 13:38:14 -0800
X-Gm-Features: AWEUYZkCGNrWwK4dINGEiwu4h9Rf93MQLYg3MnWB9UBrfxF84934Nh0HgkDPrEY
Message-ID: <CAP-5=fV0rWEL-ewGpoDwaJ3rvbTPXSx0YTuF5p9=6+h5oUhsfg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix non-uniquified hybrid legacy events
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Robin.Murphy@arm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 9:48=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Feb 12, 2025 at 4:24=E2=80=AFAM James Clark <james.clark@linaro.o=
rg> wrote:
> >
> > Legacy hybrid events have attr.type =3D=3D PERF_TYPE_HARDWARE, so they =
look
> > like plain legacy events if we only look at attr.type. But legacy event=
s
> > should still be uniquified if they were opened on a non-legacy PMU.
> > Previously we looked at the PMU type to determine legacy vs hybrid
> > events here so revert this particular check to how it was before the
> > linked fixes commit.
> >
> > counter->pmu doesn't need to be null checked twice, in fact it is
> > required for any kind of uniquification so make that a separate check.
> >
> > This restores PMU names on hybrid systems and also changes "perf stat
> > metrics (shadow stat) test" from a FAIL back to a SKIP (on hybrid). The
> > test was gated on "cycles" appearing alone which doesn't happen on
> > here.
> >
> > Before:
> >
> >   $ perf stat -- true
> >   ...
> >      <not counted>      instructions:u                           (0.00%=
)
> >            162,536      instructions:u            # 0.58  insn per cycl=
e
> >   ...
> >
> > After:
> >
> >  $ perf stat -- true
> >  ...
> >      <not counted>      cpu_atom/instructions/u                  (0.00%=
)
> >            162,541      cpu_core/instructions/u   # 0.62  insn per cycl=
e
> >  ...
> >
> > Fixes: 357b965deba9 ("perf stat: Changes to event name uniquification")
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> >  tools/perf/util/stat-display.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index e65c7e9f15d1..eae34ba95f59 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -1688,12 +1688,17 @@ static void evsel__set_needs_uniquify(struct ev=
sel *counter, const struct perf_s
> >                 return;
> >         }
> >
> > -       if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.a=
ttr.type !=3D PERF_TYPE_RAW) {
> > +       if (!counter->pmu) {
>
> Thanks James, I wish I had a hybrid laptop so I didn't keep breaking
> things like this. I'm uncomfortable using an evsel having/not-having a
> PMU as an indication of whether uniquification is necessary. It is
> kind of a side-effect of parsing whether the PMU variable is non-NULL,
> it'd kind of be nice to stop things using `evsel->pmu` directly and
> switch them to `evsel__find_pmu(evsel)`, in the future maybe legacy
> events will get the core PMU, a tracepoint PMU, etc. so we'd never
> expect this variable to be NULL.
>
> Your commit message gives me enough to think about what the issue is,
> so let me give it some thought.

I wonder we should just hoist the hybrid test earlier:
```
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.=
c
index e65c7e9f15d1..e852ac0d9847 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1688,6 +1688,12 @@ static void evsel__set_needs_uniquify(struct
evsel *counter, const struct per
f_s
               return;
       }

+       if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
+               /* Unique hybrid counters necessary. */
+               counter->needs_uniquify =3D true;
+               return;
+       }
+
       if  (counter->core.attr.type < PERF_TYPE_MAX &&
counter->core.attr.type !=3D PERF_TYPE_RAW) {
               /* Legacy event, don't uniquify. */
               return;
@@ -1705,12 +1711,6 @@ static void evsel__set_needs_uniquify(struct
evsel *counter, const struct per
f_s
               return;
       }

-       if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
-               /* Unique hybrid counters necessary. */
-               counter->needs_uniquify =3D true;
-               return;
-       }
-
       /*
        * Do other non-merged events in the evlist have the same name? If s=
o
        * uniquify is necessary.

```

The hybrid test is unfortunately expensive at it needs to search for
>1 core PMU, which means loading all sysfs PMUs. I think we're already
paying the cost though.

Could you check this works James?

Thanks,
Ian

> Thanks!
> Ian
>
> > +               /* evsel__uniquify_counter() uses counter->pmu for the =
name */
> > +               return;
> > +       }
> > +
> > +       if (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type !=
=3D PERF_TYPE_RAW) {
> >                 /* Legacy event, don't uniquify. */
> >                 return;
> >         }
> >
> > -       if (counter->pmu && counter->pmu->is_core &&
> > +       if (counter->pmu->is_core &&
> >             counter->alternate_hw_config !=3D PERF_COUNT_HW_MAX) {
> >                 /* A sysfs or json event replacing a legacy event, don'=
t uniquify. */
> >                 return;
> > --
> > 2.34.1
> >

