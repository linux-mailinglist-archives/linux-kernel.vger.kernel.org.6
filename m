Return-Path: <linux-kernel+bounces-275035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A44947FD8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3298F281FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0278315B995;
	Mon,  5 Aug 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2WPeNYA"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8A15ECC9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877339; cv=none; b=RuimoVCEK1oNRj2yleoltpWWUZ9lYXxJRsI279G4xEXC4V8E0WFup6Ob7XyDdxXVUsq4BMxRSeMw2+gGHHLcb/thQTPOrxWp1Ee9hclCTUHkZcqHNQpalPe4O4bWelQ/qEy5ClUbiJ0kPSKsZ/kZf8IjcxWNM3UIy2F7mAB8I1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877339; c=relaxed/simple;
	bh=19Xbyp30ka3bZuzbZAGIii+2gP58eKfwkWeWowKUdNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJ/cRLkECbE25bVpr/r22koqND2+pxXmqbYz3gltiDxCdorGKrDM/wp19+5XhC2z5Ny6AZS95kKU9gjh7FHLm2pCTchTpQ+csmU7SfM9mzUjdYNTwYmpx6H6ZOat2GnVEJxL/35O3Df4h0nBGzLl44t2urwPiqBC1Q1ncF31Jd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2WPeNYA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fed726aefcso7005ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722877337; x=1723482137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWvKCUh7bOGmcaHoseqdSWuzrxHK/pnJXfmBrsfjO6A=;
        b=E2WPeNYAv3ORmSe1MJbQD+fLxEOOPi9iHxXF7MH4QQ+5k6xV8LckKS4Ma7cBOSzh0S
         6Md4K3EKn4QxumcIWajpXX5NXF5MU70Mf0DYpTm1cS1eEx2Jw3yqdvpPDPyOruZO6xNW
         7rAiGlsbUMbDhPQULoWfLg7TJ/KYHAWLCJ7WhqJyYI6gSvGVfgPFf1MCp202eyNBUl7+
         M7Ved2eNblB+9u9OCUrXalEbdl7o8e4JKF01D75+Fy1TlFeUuYKT9d9J8iIGprMZpiH9
         HgkzK3tJ6fe+X7K1gYqxktEq8/VAwBI8u2vOqu1qyi+AP9/ulSh7+1vpmogs2Z2EZGuG
         8EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877337; x=1723482137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWvKCUh7bOGmcaHoseqdSWuzrxHK/pnJXfmBrsfjO6A=;
        b=vUMEfICdwPJltvuwHKa3dgd+DIUewKpYFguFzuloqkslf2xWNXFYKySW+7sFFQ1xHc
         C+mKDSv33RcPYj2WbcSSL66reAMkHb0mxlAVD/CQuj8/XSBjiCN4//SUH0AEktbeCByf
         RcsU2OmiB30UBxWmfFkCSj/H1MUDagnlJ64D8L7EYJHVMiRVN0smd2QBT6fvyyIRz5QT
         Bs5wBYyfuvTFkbti1Fictnl6pVpI/Uxzdzdh8EVKs8Qlqlg+jvhV95HYFnuJMpcVnXCy
         o8Iz+boH1sbIMJ3/Bnrq+5fiWqTn1Qnz5MY3hNKLhJbnljvEKcbPhBFgsIMAmdLM2xaf
         Wi4A==
X-Forwarded-Encrypted: i=1; AJvYcCVNOgRsjCDTh/y+2ELVcmvzZdpOMGeoL9r3l+mIx0iGGOX9ho5rRYfxyU0VVQ35fu26mn/AjJOU93RkZwS5Ql5YoDptAh4ew7EzLniK
X-Gm-Message-State: AOJu0YwtmAAFGlPYQqILveZNu3mKCwPBYTwdozEUaEgEh8em4KsXvkHj
	QSR/8Fvl5l7C/s/dldFRWMQOBhdVvduvmcbAnTtWBoIj48a6asevWpn12957MeNqjX2fTCPomCm
	rrMFCnxEaZUnOFbMZ11JOBjkFNcPZp7NENX0n
X-Google-Smtp-Source: AGHT+IFTnFZHHFXzIDfetJsh0O+CLQV00jcPUiQJwNq+5obXgjukp8W2bXqNHeG0Y51mHYQdBpcgZby+eEuxUhe8x9E=
X-Received: by 2002:a17:902:e5c6:b0:1fb:1006:980f with SMTP id
 d9443c01a7336-1ff6b23cce3mr5195125ad.16.1722877336164; Mon, 05 Aug 2024
 10:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719081651.24853-1-eric.lin@sifive.com> <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
 <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
 <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com> <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com>
In-Reply-To: <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Aug 2024 10:02:04 -0700
Message-ID: <CAP-5=fVttTnWV7KpiaxNjyiDXt9Uf5zZEm4v5V4mGXMyRr6nSg@mail.gmail.com>
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Eric Lin <eric.lin@sifive.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, vincent.chen@sifive.com, 
	greentime.hu@sifive.com, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 7:24=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 4 Aug 2024, at 8:36=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> wrote=
:
> >
> > Hi,
> >
> > On Sun, Jul 21, 2024 at 11:44=E2=80=AFPM Eric Lin <eric.lin@sifive.com>=
 wrote:
> >>
> >> Hi Athira,
> >>
> >> On Sat, Jul 20, 2024 at 4:35=E2=80=AFPM Athira Rajeev
> >> <atrajeev@linux.vnet.ibm.com> wrote:
> >>>
> >>>
> >>>
> >>>> On 19 Jul 2024, at 1:46=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> w=
rote:
> >>>>
> >>>> Currently, if vendor JSON files have two duplicate event names,
> >>>> the "perf list" command will trigger a segfault.
> >>>>
> >>>> In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
> >>>> pmu_events_table__num_events() gets the number of JSON events
> >>>> from table_pmu->num_entries, which includes duplicate events
> >>>> if there are duplicate event names in the JSON files.
> >>>
> >>> Hi Eric,
> >>>
> >>> Let us consider there are duplicate event names in the JSON files, sa=
y :
> >>>
> >>> metric.json with: EventName as pmu_cache_miss, EventCode as 0x1
> >>> cache.json with:  EventName as pmu_cache_miss, EventCode as 0x2
> >>>
> >>> If we fix the segfault and proceed, still =E2=80=9Cperf list=E2=80=9D=
 will list only one entry for pmu_cache_miss with may be 0x1/0x2 as event c=
ode ?
> >>> Can you check the result to confirm what =E2=80=9Cperf list=E2=80=9D =
will list in this case ? If it=E2=80=99s going to have only one entry in pe=
rf list, does it mean there are two event codes for pmu_cache_miss and it c=
an work with either of the event code ?
> >>>
> >>
> >> Sorry for the late reply.
> >> Yes, I've checked if there are duplicate pmu_cache_miss events in the
> >> JSON files, the perf list will have only one entry in perf list.
> >>
> >>> If it happens to be a mistake in json file to have duplicate entry wi=
th different event code (ex: with some broken commit), I am thinking if the=
 better fix is to keep only the valid entry in json file ?
> >>>
> >>
> >> Yes, I agree we should fix the duplicate events in vendor JSON files.
> >>
> >> According to this code snippet [1], it seems the perf tool originally
> >> allowed duplicate events to exist and it will skip the duplicate
> >> events not shown on the perf list.
> >> However, after this commit e6ff1eed3584 ("perf pmu: Lazily add JSON
> >> events"),  if there are two duplicate events, it causes a segfault.
> >>
> >> Can I ask, do you have any suggestions? Thanks.
> >>
> >> [1] https://github.com/torvalds/linux/blob/master/tools/perf/util/pmus=
.c#L491
> >>
> >
> > Kindly ping.
> >
> > Can I ask, are there any more comments about this patch? Thanks.
> >
> Hi Eric,
>
> The functions there says alias and to skip duplicate alias. I am not sure=
 if that is for events

Fwiw, I'm trying to get rid of the term alias it should mean event.
For some reason the code always referred to events as aliases as
exemplified by:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dtmp.perf-tools-next#n55
But it is possible to have an "alias" (different) name for a PMU and
I'm sure for other things too. So the term alias is ambiguous and
these things are events, so let's just call them events to be most
intention revealing.

> Namhyung, Ian, Arnaldo
> Any comments here ?

I'll take a look.

Thanks,
Ian

> Thank
> Athira
>
> >
> > Regards,
> > Eric Lin
> >
> >> Regards,
> >> Eric Lin
> >>
> >>> Thanks
> >>> Athira
> >>>
> >>>>
> >>>> perf_pmu__for_each_event() adds JSON events to the pmu->alias
> >>>> list and copies sevent data to the aliases array. However, the
> >>>> pmu->alias list does not contain duplicate events, as
> >>>> perf_pmu__new_alias() checks if the name was already created.
> >>>>
> >>>> When sorting the alias data, if there are two duplicate events,
> >>>> it causes a segfault in cmp_sevent() due to invalid aliases in
> >>>> the aliases array.
> >>>>
> >>>> To avoid such segfault caused by duplicate event names in the
> >>>> JSON files, the len should be updated before sorting the aliases.
> >>>>
> >>>> Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> >>>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> >>>> ---
> >>>> tools/perf/util/pmus.c | 5 +++--
> >>>> 1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> >>>> index b9b4c5eb5002..e38c3fd4d1ff 100644
> >>>> --- a/tools/perf/util/pmus.c
> >>>> +++ b/tools/perf/util/pmus.c
> >>>> @@ -443,7 +443,7 @@ void perf_pmus__print_pmu_events(const struct pr=
int_callbacks *print_cb, void *p
> >>>> {
> >>>> struct perf_pmu *pmu;
> >>>> int printed =3D 0;
> >>>> - int len;
> >>>> + size_t len, j;
> >>>> struct sevent *aliases;
> >>>> struct events_callback_state state;
> >>>> bool skip_duplicate_pmus =3D print_cb->skip_duplicate_pmus(print_sta=
te);
> >>>> @@ -474,8 +474,9 @@ void perf_pmus__print_pmu_events(const struct pr=
int_callbacks *print_cb, void *p
> >>>> perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
> >>>> perf_pmus__print_pmu_events__callback);
> >>>> }
> >>>> + len =3D state.index;
> >>>> qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
> >>>> - for (int j =3D 0; j < len; j++) {
> >>>> + for (j =3D 0; j < len; j++) {
> >>>> /* Skip duplicates */
> >>>> if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
> >>>> continue;
> >>>> --
> >>>> 2.43.2
>
>

