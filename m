Return-Path: <linux-kernel+bounces-368541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8734F9A110C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BE21C2555A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD312141A0;
	Wed, 16 Oct 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gjd9xeNy"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5250212F1B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101349; cv=none; b=qtv3z+jIxwWu2Ac6wXv6jJXWG6WCo8YWcB6Pb0Wu+pjym5luida54W4wi2/lit9yawc7RHOYvQHW3DQCeCqi8zjPr1DHhSo2+wzwa1ui+KaAfhbQYBIDbpHosALHIxY/nX5xO7C/Bj9OgpmZ7LIV6OWtIUfd8EOTwhYI3N/D6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101349; c=relaxed/simple;
	bh=FI46zlFWVI+h3vrIeU8t70yHMttMMhpJ5UEVt4s9RUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USlsokpMXk+KG/Gvr9fz8KKIoCUdsDhN+dmkbfQQQ9DuHQ6ca3O4rhlvKaLDTA5rv5cd50SLTnxGH1d2R9tmgoPkrhmSrTN1CVLlAvudkikGS0C1zVv3Ws9HMaEjSlv+Pb9jai9Ir0wv7oyI1d4o0o2mE4Hv6j8pOl8xFJbTqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gjd9xeNy; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so17055ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101347; x=1729706147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgXP4YWR78MH1/k7aqI2PhXOAzbJhF0fNu0sgKIyQXo=;
        b=Gjd9xeNy+4G+4R3iupTReK6dCoodAUAZ+bqkkzqj7ClRmaamV2Cg0GVzbftYH95ti1
         oLcvT1nXeBaDB6ZCwyTji8zJbdra9XWlB9hrsQhnnbBBLX+/xRcfirw4YA2gBZU5XvmB
         n0If/YInihpVkjxvvJ0a0Fo6jy2SzYrs5XoHbivp96ofSXjOsLEvgxaQ9Ca580b6Ydm7
         ZLXjua5DOlfY/H+Gu3/Lxojlw+SEMDzLrL+1J8oLR38Yww/ZRafU9j3i7ticN/7i1GeD
         LlVSEwQWY4DZGS8xKm6lhk4Lv2FIhjda1Hmv1p0eOTx3n2SeAqYdOkVXChtoNmFAd/Sf
         DHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101347; x=1729706147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgXP4YWR78MH1/k7aqI2PhXOAzbJhF0fNu0sgKIyQXo=;
        b=eEmDMNPPf2A1vPvw11YnS2rWjpum7uwCrif4ScdYOQ4UKqG564Dwb86uYAvBRbsdnl
         p5IOKdTscEjFXOEnUVaPW0h2ZAI41LRH14a9MCTw8JmbTxbeh9ZVAnkhRu2XXvG7A3X6
         QIyshtRp/C8hzYTKwC1F3tr644VUB07pSwHQ/VyVul4GJXbS1K7zWmY05Ihg4hVpKPg6
         bkIJ0BGP6Obbh7Ik3qdIYXykU0ALUGQP7A9vdd2bmSNN3hYMG3inCeW8/1FUQRHKPK8F
         k79AEQNEeBtcE5i6YlgYMOEJD2hf9tySiMnBLuYYLOa/B9DeODdabm3gBF0lT2dmzrHS
         cxvw==
X-Forwarded-Encrypted: i=1; AJvYcCUQY9inMEIpN390weMZOTkBTc+Qh3H2EaO9ugAsuASJIrGzhLOQVFpW+cn0k2U65NfyLxvixhjZnQROqZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOAXsNYAHayzug1yZW33kzzOKyCoEC310oql8/mjocOOI5Bbzk
	Bhn4+nwjn78Wh4uL4CY0JHN7IujpHoUPkVrFwzQ6SGJw4u5nfmnl6Z5x8Lc1KtwyEXhbchD31vA
	rueMiC5PJXFVRbZgS9VF6WtRB8nr8pKrkROk7
X-Google-Smtp-Source: AGHT+IGp8MPrwldFZ08s9nJXGPdGDOsW5oZdgQ71qP2oW4DbMjy0QMSmP4TEalVXqutw5m7JwgzOYpqvrDjOAS5ZiPI=
X-Received: by 2002:a05:6e02:b21:b0:39f:83dd:5672 with SMTP id
 e9e14a558f8ab-3a3e5909e21mr159885ab.16.1729101346643; Wed, 16 Oct 2024
 10:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011110207.1032235-1-dapeng1.mi@linux.intel.com>
 <20241011110207.1032235-2-dapeng1.mi@linux.intel.com> <Zw_56b61Ik7UFekS@google.com>
In-Reply-To: <Zw_56b61Ik7UFekS@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 10:55:33 -0700
Message-ID: <CAP-5=fWfRwxWsgqD8OUG8+2WrU5Xg+ByqGAbLED9Wf3ZQ=FURw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf x86/topdown: Refine helper arch_is_topdown_metrics()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 10:37=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Fri, Oct 11, 2024 at 11:02:07AM +0000, Dapeng Mi wrote:
> > Leverage the existed function perf_pmu__name_from_config() to check if
> > an event is topdown metrics event. perf_pmu__name_from_config() goes
> > through the defined formats and figures out the config of pre-defined
> > topdown events.
> >
> > This avoids to figure out the config of topdown pre-defined events with
> > hard-coded format strings "event=3D" and "umask=3D" and provides more
> > flexibility.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Are you ok with this now?

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/arch/x86/util/topdown.c | 39 +++++++-----------------------
> >  1 file changed, 9 insertions(+), 30 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/u=
til/topdown.c
> > index cb2c64928bc4..f63747d0abdf 100644
> > --- a/tools/perf/arch/x86/util/topdown.c
> > +++ b/tools/perf/arch/x86/util/topdown.c
> > @@ -41,43 +41,22 @@ bool arch_is_topdown_slots(const struct evsel *evse=
l)
> >       return false;
> >  }
> >
> > -static int compare_topdown_event(void *vstate, struct pmu_event_info *=
info)
> > -{
> > -     int *config =3D vstate;
> > -     int event =3D 0;
> > -     int umask =3D 0;
> > -     char *str;
> > -
> > -     if (!strcasestr(info->name, "topdown"))
> > -             return 0;
> > -
> > -     str =3D strcasestr(info->str, "event=3D");
> > -     if (str)
> > -             sscanf(str, "event=3D%x", &event);
> > -
> > -     str =3D strcasestr(info->str, "umask=3D");
> > -     if (str)
> > -             sscanf(str, "umask=3D%x", &umask);
> > -
> > -     if (event =3D=3D 0 && *config =3D=3D (event | umask << 8))
> > -             return 1;
> > -
> > -     return 0;
> > -}
> > -
> >  bool arch_is_topdown_metrics(const struct evsel *evsel)
> >  {
> > -     struct perf_pmu *pmu =3D evsel__find_pmu(evsel);
> >       int config =3D evsel->core.attr.config;
> > +     const char *name_from_config;
> > +     struct perf_pmu *pmu;
> >
> > -     if (!pmu || !pmu->is_core)
> > +     /* All topdown events have an event code of 0. */
> > +     if ((config & 0xFF) !=3D 0)
> >               return false;
> >
> > -     if (perf_pmu__for_each_event(pmu, false, &config,
> > -                                  compare_topdown_event))
> > -             return true;
> > +     pmu =3D evsel__find_pmu(evsel);
> > +     if (!pmu || !pmu->is_core)
> > +             return false;
> >
> > -     return false;
> > +     name_from_config =3D perf_pmu__name_from_config(pmu, config);
> > +     return name_from_config && strcasestr(name_from_config, "topdown"=
);
> >  }
> >
> >  /*
> > --
> > 2.40.1
> >

