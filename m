Return-Path: <linux-kernel+bounces-356065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3647995BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88391C210C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CEE218588;
	Tue,  8 Oct 2024 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUhXOnud"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32415216439
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430432; cv=none; b=WBWqTf4r25iUfILbK5ejdQoHfnwaYQwGVng06PQebhSYMrOhmbYurs6xRxx06mYU3jv2U8C2Nnee3/jJ+tErI7jMTnoUykqdku+1tdhPU5DoMRDqL5y9LckY2DJCu6bHg/HvHQsLDHaruLsbGSvC9pcra3Hp4KToazDj5bWdYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430432; c=relaxed/simple;
	bh=d07x/Y6C1iI6lK99A3UROkBoeJl9oKGIPcEveOiNYnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbrdRcXzdkPESZ/uDqiL4KXMz/0AHVLN+zFwwy2/tjRlwSkcynjibv9LSUAEkQNxAN/zm33dTFUQiDQl4GhRKTiJNOpOD+9nPD9BCAwcZkZmkSDuS0aPCgsIytZRMU4Pr1E1fC+Hq/cdjRnc360UMVlUJvvtDjHcapmGipCoa5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUhXOnud; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4601a471aecso29231cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728430430; x=1729035230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeLI0iUkXUyybbpSQG2xEHD5VlIOemulh+VGYKcugg0=;
        b=DUhXOnudkmDeBE7OsgvVckXpgefV6I1DOa4NuBZPO5eCv47mvFW6QTsTtApKY9PPBR
         cpEcb8K3liXIKvWNRCQ88PEBBWmXCmX1cJONEmlJkBmoFnFP59lTIDu48AQBZ4xiteiB
         hK4LTr2xmy+s97JaEYEhF/4kCWdpa1gVbbh5EFgeAy51tb9WMRw9ljsaiqntgEmEsqnn
         lAfTlU/e3hS7JJ3Dw63NiydsdQwfDvRSXVkdkimBDFYKcj+9HpuvS2Bp17S6MmBcAVqF
         oNbJYL2ODtYsyHZUgduJJDtgROP+PUPWqrb35bz8SOf/Q4iwl18QHyBbn61WNPU3HvgQ
         /y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728430430; x=1729035230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeLI0iUkXUyybbpSQG2xEHD5VlIOemulh+VGYKcugg0=;
        b=gyASYEh3VP3Ern3xRAJoTY+WfjBbdm5My5I3Cqded01bRwMwkqLkG/HAa2dQziXQ3J
         MPjbfPlJK+uCV6ZR9juKk2uAUCHbHp8Qr5khcAJXlBli2QYxidYFnioT4Im/iQUzlbth
         33Goq9HnMkbferyKHVBkXse4//BI3BfPIP7JfWQM5hNYEy61cKEKQSwZBwpBWDnWiRVX
         3kAiO9mge+nW8yCPVuLTc66PBylK7uNhxOdl7Rfg+KeSnNefdTEkm0AOl6R669pPG/93
         f7HLKPSwdvEcLZnVuqtfaiOuayXSdwjKc0TEdETLSHt7mNqJJ9y6gMeryQ8fAwrmzgye
         mGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUzASIJIpkFo21UdVHacAJ66hQ8P9OC42TrKOPFs2FDvF+sSKvovpis2lbnMBMK3WPb7voIEZ1yrO5fDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4n6Htp2Gobh52/9JMaYkYAhApZYpylxuk82C+8Q7LyozDQEMW
	Rty/h9duq1O4P0DxJ3RQzxQxzyzKtLQmvFqDblhjORfaA5S+FqE+P/lnvCCxjMVF7hlZfSbrgfs
	GxMMPgKMkvVC+Zu9HwXExhvRQM2VCHUGf6SZC
X-Google-Smtp-Source: AGHT+IE6ZXXpGm9HDy2/sV1TQYVQsXPj3Jhbm2MOccl+vdMN9kP41dvo3cMMR+q6utFMzt8mGNzXn1zXooRiv72elYA=
X-Received: by 2002:a05:622a:47c9:b0:45e:fd06:1992 with SMTP id
 d75a77b69052e-45fc8c3e482mr617711cf.27.1728430430052; Tue, 08 Oct 2024
 16:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com> <20241004234120.1495209-5-irogers@google.com>
 <3fb7cc3fab054ad5b2af8a5ae5fd7dbdace774a2.camel@linux.intel.com>
In-Reply-To: <3fb7cc3fab054ad5b2af8a5ae5fd7dbdace774a2.camel@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Oct 2024 16:33:36 -0700
Message-ID: <CAP-5=fWXsOTTuEcM+AnYHeEZEaiy1u4w21DoNO87HaXjjbTRwA@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] perf stat: Drop metric-unit if unit is NULL
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 4:27=E2=80=AFPM Tim Chen <tim.c.chen@linux.intel.com=
> wrote:
>
> On Fri, 2024-10-04 at 16:41 -0700, Ian Rogers wrote:
> > Avoid cases like:
> > ```
> > $ perf stat -a -M topdownl1 -j -I 1000
> > ...
> > {"interval" : 11.127757275, "counter-value" : "85715898.000000", "unit"=
 : "", "event" : "IDQ.MITE_UOPS", "event-runtime" : 988376123, "pcnt-runnin=
g" : 100.00, "metric-value" : "0.000000", "metric-unit" : "(null)"}
> > ...
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-display.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index e392ee5efb45..9b65968e37d1 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -470,8 +470,9 @@ static void print_metric_json(struct perf_stat_conf=
ig *config __maybe_unused,
> >       struct outstate *os =3D ctx;
> >       FILE *out =3D os->fh;
> >
> > -     fprintf(out, "\"metric-value\" : \"%f\", ", val);
> > -     fprintf(out, "\"metric-unit\" : \"%s\"", unit);
> > +     fprintf(out, "\"metric-value\" : \"%f\"", val);
> > +     if (unit)
> > +             fprintf(out, ", \"metric-unit\" : \"%s\"", unit);
>
> I think if there's no metric unit, we should skip printing metric value a=
s a metric
> of 0 has no meaning.

Makes sense to me too. It requires some test fixing to make work. I'll
take a look.

Thanks,
Ian

> >       if (!config->metric_only)
> >               fprintf(out, "}");
> >  }
>

