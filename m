Return-Path: <linux-kernel+bounces-556383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77647A5C5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990E4189C047
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8E425EF8B;
	Tue, 11 Mar 2025 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOF7z/0r"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720F25E81D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706105; cv=none; b=obeA1o1JA3Z7RTFP+b4Z9khQER3AFUaWA9b6dj7bUXUK2jvEhUnL9e8V1azyzMeMfnLR3VOMfj/lY6EtUEUp9PlzszUQ2d2AdPkn2HUm65tD8tb53heKMHjO6ccDheTotMLQPUtyy06Sk2pMduusIzvruhfsl48rVed0U9XgTNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706105; c=relaxed/simple;
	bh=CIC1HfwbtMyb1d03RzVbKpgNIfgLun1cSM2Jmv2uWqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYTvFR8I9CVIBS6JIb23ai+BjyAVrNuTjWAmb5EYS/nMwPntoJUxlNfs41nHIMBFm2w0YOnirUuOFa6qb+h7dxkYC5tAf3WasOjxSgZ9xxh/KFogIPW+OBeO+JSL0j1c8ZVtnCRVFLZvjbqTcSDJZ4pjd3aSLr6aWEwqGzpLlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOF7z/0r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242aca53efso160055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741706102; x=1742310902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebOSxF/5fwPL3lrIbCMPyxIcROUcLKuMWeB60GH42RQ=;
        b=uOF7z/0rr5uw1QLhYB47PD+Cdzmat2kIobcvWlVTO1uiTiy7wb6cVP6M91AXgJotX+
         2uUwP8IAlH6e22g2dy3vSOzE5l204Id5z54xBlEnyl8Wlzql8RdowgNJmhq7Hdfo3baQ
         Lxxx2+D4Z0cA0ZZyucs1Jm/bN6OYDf7PAnP0BIiXY7YjNuLsjuAAacQhefZFYgZi4K6v
         DtbmpZVmnQwsxc2yDPAzay+vcN/gujgc+HWi+3vm7hEnQ3JqXhNtTS7BLSzUwGAJZIsX
         F4m2uv0a4BIOcF1I3l9xfWCkebuY1One+XV0qCWVyRmdzQY+W0QyuOxChZ4RJaRuFn5h
         KP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706102; x=1742310902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebOSxF/5fwPL3lrIbCMPyxIcROUcLKuMWeB60GH42RQ=;
        b=mIkxAbi9L1LqgaR0Bx81wdMbBb9Ize6bUHd58y/4kiu7RDRNPTSqdRtx0v3hSJd88i
         FC33NG85tta93r66czYduKOrcuymFSPJxy2nqCIrDcMn/mhIjLrozvh+OyBEQ1nU3/SG
         HtIkobIHOL1rpIUDNsAtuUEMw9tdNGPLOtHsjVXFJgTKoamYm2VjvPnQ1GskjCODKzJQ
         khzXAImamSyMmjKThpMofZDSlVZZ4BlYcDHvwMmLV9YzqHGq4KPrHVK8qHuM6Y0iJuZk
         nse8aPeFaPU51gB7LmZkdNVeWeNvz4T2xPVE+3j/xmqtt1DvSQPLo9Cq3Ue38ezBdNl/
         yt0g==
X-Forwarded-Encrypted: i=1; AJvYcCV8qMsr/W+uu7QbgTMEovqC9mEkk53pmfVj/Zj60/U40MPTpKSaLNi9ZDskGU1vkXPA469ra0j+cJ+H47g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCrQ9PZ0r/mLZ7cmgfoiX2MeYl1btj1O9Ji7iHS+fpEE25rLr
	OXqWRrOMyLdBPLqueDtHSwcZRtjvR8DWHqLuVSB4IP0vIF6bugt/RrlmIha0iGbxMZFYyC9wk2a
	XDuWApDLNK7eeDPGU7S4hw/GE4838MCmHJxsd
X-Gm-Gg: ASbGnct5E+ES6llP+kQz6u+CvCK8U8+8iadtwSkGIc/1K2r82FjNA1EP3wFVjVlqTkk
	MDyouTZoPoousnXkLTbQfOHr4ccUMOIhMSTp8PdWhq28w+uICRPQ//9W0yLUpM6mfXcmD1NpFq1
	0GGQ+vKbEfSY+2brsiFn1G16qQu0Q=
X-Google-Smtp-Source: AGHT+IGLZt2DwtbPv+FxZ6g8sbHYe9XResEjVPXwNdeCHuxTOxWinhKYbZcjXbHKzHjqslvvOC3bHt+D4HVHVNNauk4=
X-Received: by 2002:a17:902:db0b:b0:220:c905:689f with SMTP id
 d9443c01a7336-2254782c6ccmr7268995ad.25.1741706102160; Tue, 11 Mar 2025
 08:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
 <20250304-james-perf-hybrid-list-v1-2-a363ffac283c@linaro.org>
 <CAP-5=fX+aSDLMDL3DMNCQ4tDuhaZPv-L6OgfOso3q5wf7anoGg@mail.gmail.com>
 <12da919e-5674-4b12-a51d-ed767cc0b1ac@linaro.org> <CAP-5=fWVw499hZ7WM7A+vUmxALX7M-kYXoEehQkv-fh6qHOoOg@mail.gmail.com>
 <39f7e3ae-d274-4de4-8b8e-bcf1ad6f0932@linaro.org>
In-Reply-To: <39f7e3ae-d274-4de4-8b8e-bcf1ad6f0932@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Mar 2025 08:14:49 -0700
X-Gm-Features: AQ5f1Jo9gCuDkvV5R8FYim2_RNO_j8IsokMHyiyMmLP-FYCK5mI3m9FTT7avot4
Message-ID: <CAP-5=fU8LWyKrxn==ieO+dOCyvDML5Qnf23K=5bqHdHMvGx-eA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf list: Collapse similar events across PMUs
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:13=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 07/03/2025 5:35 pm, Ian Rogers wrote:
> > On Fri, Mar 7, 2025 at 6:08=E2=80=AFAM James Clark <james.clark@linaro.=
org> wrote:
> >>
> >>
> >>
> >> On 05/03/2025 9:40 pm, Ian Rogers wrote:
> >>> On Tue, Mar 4, 2025 at 5:50=E2=80=AFAM James Clark <james.clark@linar=
o.org> wrote:
> >>>>
> >>>> Instead of showing multiple line items with the same event name and
> >>>> description, show a single line and concatenate all PMUs that this
> >>>> event can belong to.
> >>>>
> >>>> Don't do it for json output. Machine readable output doesn't need to=
 be
> >>>> minimized, and changing the "Unit" field to a list type would break
> >>>> backwards compatibility.
> >>>>
> >>>> Before:
> >>>>    $ perf list -v
> >>>>    ...
> >>>>    br_indirect_spec
> >>>>          [Branch speculatively executed,indirect branch. Unit: armv8=
_cortex_a53]
> >>>>    br_indirect_spec
> >>>>          [Branch speculatively executed,indirect branch. Unit: armv8=
_cortex_a57]
> >>>>
> >>>> After:
> >>>>
> >>>>    $ perf list -v
> >>>>    ...
> >>>>    br_indirect_spec
> >>>>          [Branch speculatively executed,indirect branch. Unit: armv8=
_cortex_a53,armv8_cortex_a57]
> >>>>
> >>>> Signed-off-by: James Clark <james.clark@linaro.org>
> >>>> ---
> >>>>    tools/perf/builtin-list.c      |  2 ++
> >>>>    tools/perf/util/pmus.c         | 75 +++++++++++++++++++++++++++++=
++++++++-----
> >>>>    tools/perf/util/print-events.h |  1 +
> >>>>    3 files changed, 70 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> >>>> index fed482adb039..aacd7beae2a0 100644
> >>>> --- a/tools/perf/builtin-list.c
> >>>> +++ b/tools/perf/builtin-list.c
> >>>> @@ -516,6 +516,7 @@ int cmd_list(int argc, const char **argv)
> >>>>                   .print_event =3D default_print_event,
> >>>>                   .print_metric =3D default_print_metric,
> >>>>                   .skip_duplicate_pmus =3D default_skip_duplicate_pm=
us,
> >>>> +               .collapse_events =3D true
> >>>
> >>> So collapse_events is put in the callbacks but isn't a callback. I
> >>> think skipping duplicates and collapsing are the same thing, I'd
> >>> prefer it if there weren't two terms for the same thing. If you prefe=
r
> >>> collapsing as a name then default_skip_duplicate_pmus can be
> >>> default_collapse_pmus.
> >>>
> >>
> >> I can use the existing callback and rename it. That does have the effe=
ct
> >> of disabling this behavior in verbose mode which may be useful or may =
be
> >> unexpected to some people. But it seems pretty 50/50 so fewer callback=
s
> >> are probably better.
> >>
> >>>>           };
> >>>>           const char *cputype =3D NULL;
> >>>>           const char *unit_name =3D NULL;
> >>>> @@ -574,6 +575,7 @@ int cmd_list(int argc, const char **argv)
> >>>>                           .print_event =3D json_print_event,
> >>>>                           .print_metric =3D json_print_metric,
> >>>>                           .skip_duplicate_pmus =3D json_skip_duplica=
te_pmus,
> >>>> +                       .collapse_events =3D false
> >>>>                   };
> >>>>                   ps =3D &json_ps;
> >>>>           } else {
> >>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> >>>> index 4d60bac2d2b9..cb1b14ade25b 100644
> >>>> --- a/tools/perf/util/pmus.c
> >>>> +++ b/tools/perf/util/pmus.c
> >>>> @@ -453,17 +453,50 @@ static int cmp_sevent(const void *a, const voi=
d *b)
> >>>>           /* Order by PMU name. */
> >>>>           if (as->pmu =3D=3D bs->pmu)
> >>>>                   return 0;
> >>>> -       return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
> >>>> +       ret =3D strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +
> >>>> +       /* Order by remaining displayed fields for purposes of dedup=
lication later */
> >>>> +       ret =3D strcmp(as->scale_unit ?: "", bs->scale_unit ?: "");
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +       ret =3D !!as->deprecated - !!bs->deprecated;
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +       ret =3D strcmp(as->desc ?: "", bs->desc ?: "");
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +       return strcmp(as->long_desc ?: "", bs->long_desc ?: "");
> >>>>    }
> >>>>
> >>>> -static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent =
*b)
> >>>> +enum dup_type {
> >>>> +       UNIQUE,
> >>>> +       DUPLICATE,
> >>>> +       SAME_TEXT
> >>>> +};
> >>>> +
> >>>> +static enum dup_type pmu_alias_duplicate_type(struct sevent *a, str=
uct sevent *b)
> >>>>    {
> >>>>           /* Different names -> never duplicates */
> >>>>           if (strcmp(a->name ?: "//", b->name ?: "//"))
> >>>> -               return false;
> >>>> +               return UNIQUE;
> >>>> +
> >>>> +       /* Duplicate PMU name and event name -> hide completely */
> >>>> +       if (strcmp(a->pmu_name, b->pmu_name) =3D=3D 0)
> >>>> +               return DUPLICATE;
> >>>> +
> >>>> +       /* Any other different display text -> not duplicate */
> >>>> +       if (strcmp(a->topic ?: "", b->topic ?: "") ||
> >>>> +           strcmp(a->scale_unit ?: "", b->scale_unit ?: "") ||
> >>>> +           a->deprecated !=3D b->deprecated ||
> >>>> +           strcmp(a->desc ?: "", b->desc ?: "") ||
> >>>> +           strcmp(a->long_desc ?: "", b->long_desc ?: "")) {
> >>>> +               return UNIQUE;
> >>>> +       }
> >>>>
> >>>> -       /* Don't remove duplicates for different PMUs */
> >>>> -       return strcmp(a->pmu_name, b->pmu_name) =3D=3D 0;
> >>>> +       /* Same display text but different PMU -> collapse */
> >>>> +       return SAME_TEXT;
> >>>>    }
> >>>>
> >>>>    struct events_callback_state {
> >>>> @@ -501,6 +534,21 @@ static int perf_pmus__print_pmu_events__callbac=
k(void *vstate,
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> +static void concat_pmu_names(char *pmu_names, size_t size, const ch=
ar *a, const char *b)
> >>>> +{
> >>>> +       size_t len =3D strlen(pmu_names);
> >>>> +       size_t added;
> >>>> +
> >>>> +       if (len)
> >>>> +               added =3D snprintf(pmu_names + len, size - len, ",%s=
", b);
> >>>> +       else
> >>>> +               added =3D snprintf(pmu_names, size, "%s,%s", a, b);
> >>>> +
> >>>> +       /* Truncate with ... */
> >>>> +       if (added > 0 && added + len >=3D size)
> >>>> +               sprintf(pmu_names + size - 4, "...");
> >>>> +}
> >>>> +
> >>>>    void perf_pmus__print_pmu_events(const struct print_callbacks *pr=
int_cb, void *print_state)
> >>>>    {
> >>>>           struct perf_pmu *pmu;
> >>>> @@ -510,6 +558,7 @@ void perf_pmus__print_pmu_events(const struct pr=
int_callbacks *print_cb, void *p
> >>>>           struct events_callback_state state;
> >>>>           bool skip_duplicate_pmus =3D print_cb->skip_duplicate_pmus=
(print_state);
> >>>>           struct perf_pmu *(*scan_fn)(struct perf_pmu *);
> >>>> +       char pmu_names[128] =3D {0};
> >>>>
> >>>>           if (skip_duplicate_pmus)
> >>>>                   scan_fn =3D perf_pmus__scan_skip_duplicates;
> >>>> @@ -539,12 +588,21 @@ void perf_pmus__print_pmu_events(const struct =
print_callbacks *print_cb, void *p
> >>>>           qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
> >>>>           for (int j =3D 0; j < len; j++) {
> >>>>                   /* Skip duplicates */
> >>>> -               if (j < len - 1 && pmu_alias_is_duplicate(&aliases[j=
], &aliases[j + 1]))
> >>>> -                       goto free;
> >>>> +               if (j < len - 1) {
> >>>> +                       enum dup_type dt =3D pmu_alias_duplicate_typ=
e(&aliases[j], &aliases[j + 1]);
> >>>> +
> >>>> +                       if (dt =3D=3D DUPLICATE) {
> >>>> +                               goto free;
> >>>> +                       } else if (print_cb->collapse_events && dt =
=3D=3D SAME_TEXT) {
> >>>> +                               concat_pmu_names(pmu_names, sizeof(p=
mu_names),
> >>>> +                                                aliases[j].pmu_name=
, aliases[j+1].pmu_name);
> >>>> +                               goto free;
> >>>> +                       }
> >>>> +               }
> >>>
> >>> I think a label called 'free' is a little unfortunate given the
> >>> function called free.
> >>> When I did things with sevent I was bringing over previous `perf list=
`
> >>> code mainly so that the perf list output before and after the changes
> >>> was identical. I wonder if this logic would be better placed in the
> >>> callback like default_print_event which already maintains state
> >>> (last_topic) to optionally print different things. This may better
> >>> encapsulate the behavior rather than the logic being in the PMU code.
> >>>
> >>
> >> Yeah I can have a look at putting it in one of the callbacks. But in t=
he
> >> end builtin-list.c is the only user of perf_pmus__print_pmu_events()
> >> anyway so makes you wonder if the whole thing can be moved to
> >> builtin-list and open coded without the callbackyness.
> >
> > I wanted to hide some of the innards of pmus, so I think that's the
> > reason it is as it is. The whole `sevent` was pre-existing and
> > maintained so that the output was the same.
> >
>
> Looking at this a bit more it is possible to move all of
> perf_pmus__print_pmu_events() (including its dependencies and perf list
> specifics) out of pmus.c into print-events.c without exposing any new
> innards of pmus. Only struct pmu_event_info would be used, but that's
> not private and is already used elsewhere.
>
> It's difficult to do this change only in the print_event callback
> because it relies on having the _next_ event, not the previous event.
> We're already tracking last_topic, and if we start passing all the
> next_* items too it gets a bit unmanageable.
>
> If it's all moved then doing display specific processing across the
> whole list becomes quite easy.

I'm not sure I follow all of this. If things can be moved to a more
obvious location, printing code in print-events.c, and we maintain
encapsulation then that sounds great to me. I'm not clear on the next
event issue. My hope with the print routines in builtin-list.c was
that anyone could come along and add another for whatever rendering
took their fancy. I didn't want it to be like the logic in
stat-display.c, where there are multiple levels of call backs, global
state, odd things like passing NULL meaning display column headers,
and the whole thing being a confusing rats nest where a change nearly
always ripples through and breaks something somewhere. Particularly
compare the json output in stat-display.c and builtin-list.c, my hope
was that builtin-list.c would be the model for reimplementing the
stat-display.c one. Others may have different opinions.

Thanks,
Ian

