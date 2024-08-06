Return-Path: <linux-kernel+bounces-275665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE6794882D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFEE281609
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5D354645;
	Tue,  6 Aug 2024 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlA984IJ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E1A59
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722916859; cv=none; b=eXTLPQBw9JZxiWZUG4JDrRwwFyYh6IzyzfPFYSgs1IgNeoPYsJNjb+EswwCK+Sa9hU1+oDHyYJm6IH/q7hs4KywQohrQClR4tDLw5k5BsjstjYlCyfqyENLhUdh7LLI2wuOMoVUZqaeuC9Ra0rRGiJYa838WU2GEYTIDNezrKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722916859; c=relaxed/simple;
	bh=/YG+cqMHAcKCOmI0VwKPntEErgGIwmoAGGlwC/kwVzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKrel0H+xBmzhSjderJmGKYaixmOkDnjJIPWOTjQ92eJjptSwPC2YMLv1q3/3qjdmNoM9XDav6VAWlkIoLN9fdg4m9KnCZzvZeUp402Xaf6YPIRTiACAG1lb7A7J5IqfFXGCTuFXlQGY179C/VzvKij5t/BlPfkESRAdtOJCm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlA984IJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fed726aefcso91275ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 21:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722916857; x=1723521657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM6KiGYl+3RlBbld9MqyrhDhjq78ibLcAr+C8+GOgag=;
        b=VlA984IJgPUXN5EXArP+foL19/jaVQeMMHilbD0Q1xDZF6TEgnrNJtj8nUaR6ufBH6
         MVnb9IcwrJ/LQyoRFeT9oi7q7uucd1rVALhA2tGuOzzI3YzdB0n1GUkNDyx8DGbvNCDT
         1eW1Q24o1H8I6g3nyNwwMAdRW89ev3/hjBQF37dq7JtMSVTbAAl3fSONO2CGDSZi5wsR
         L5xgIVduM4KahTUXGot/o1GzWIqAx4Rc5Li+AkC82Y0EMsbB7LdjF3VozC6soqVb12nz
         lBf3OEi8afqJdvY2f/Kj//1cLwaqAnhZBSAs3fhNrtolTk105aDVqpIBfMkHJ9tM08xL
         QzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722916857; x=1723521657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM6KiGYl+3RlBbld9MqyrhDhjq78ibLcAr+C8+GOgag=;
        b=oXWbNFz4iACfSTAVdNqrKmQp2RJd/gGSvfsTtTve90DlLBnDz4AFTHeRxUJ6j7t26Y
         KRbISAk0Bv48NdstYclSi/3WJtptSr+gVI477DV5Tm2bTA5HOSeujSOBHkeRNtKTB2wB
         m6arncj0qm2EqZejq/TZcfm4mXxN+1eZQH624YoGYSYfdrjzzow9YAL2+RrtOBjLwSzs
         5RYCFBj2BkqikrMnFDZiXUgvlYSv9SWGnF7z5+A8gYX5Dr94lAnfLuQ9PyGbS9jNOqtP
         EzMqqXi4LX/QF023GiSABOoDt3FKB8okcbPnrqI1NQfIvL41Rcv2HzK53oJzVbPwESoA
         gKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4+Ptzb50SHOWZG4YIFFK7Vrfm8lBndZ8taF1hr4/lObaDJsclmA6TZ0Obvpk8u5Qy/NsjxDprToJdEfZKTlZR5SnOcm4lJQ6gGW6r
X-Gm-Message-State: AOJu0YwsTcRtuJCW94CtsGJuqjo5x71vvVUjE09pW7HX+th4dSLTJfS6
	QqKq3C8uKDLIoP/BXO/aOijQxROwYI1JBHOwV/ilsNgnxi6tc9HPrMe0RvU4q0JWI+//4SfAW0M
	rl8QH5wBSpDIDJmLM5JyMT6xzD2EMyItGspaL
X-Google-Smtp-Source: AGHT+IG4uK4NuB4L6y3A5FPVUC9CGAGBCCEO08rsVtantMSK6CWr0PdGbYYwa7g0GmzLuwQyBoLovteuLG/iO55mP44=
X-Received: by 2002:a17:903:1107:b0:1f6:8836:e43f with SMTP id
 d9443c01a7336-20077fedf2amr1069875ad.17.1722916856288; Mon, 05 Aug 2024
 21:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719081651.24853-1-eric.lin@sifive.com> <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
 <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
 <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com>
 <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com> <ZrDzBrrBPBkSKLRC@x1>
 <CAPqJEFraOmS72dQQK2ou9EoxbCKZ8m_+DhQQfPmCy6wfxfQWzQ@mail.gmail.com>
In-Reply-To: <CAPqJEFraOmS72dQQK2ou9EoxbCKZ8m_+DhQQfPmCy6wfxfQWzQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Aug 2024 21:00:44 -0700
Message-ID: <CAP-5=fXSiqQT+-mztdrV=Y6p+iPhZnmY9uqL08KrEe3bSybJxw@mail.gmail.com>
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
To: Eric Lin <eric.lin@sifive.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, vincent.chen@sifive.com, 
	greentime.hu@sifive.com, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:29=E2=80=AFPM Eric Lin <eric.lin@sifive.com> wrote=
:
>
>
> Hi Arnaldo,
>
> On Mon, Aug 5, 2024 at 11:43=E2=80=AFPM Arnaldo Carvalho de Melo <acme@ke=
rnel.org> wrote:
> >
> > On Mon, Aug 05, 2024 at 07:54:33PM +0530, Athira Rajeev wrote:
> > >
> > >
> > > > On 4 Aug 2024, at 8:36=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> w=
rote:
> > > >
> > > > Hi,
> > > >
> > > > On Sun, Jul 21, 2024 at 11:44=E2=80=AFPM Eric Lin <eric.lin@sifive.=
com> wrote:
> > > >>
> > > >> Hi Athira,
> > > >>
> > > >> On Sat, Jul 20, 2024 at 4:35=E2=80=AFPM Athira Rajeev
> > > >> <atrajeev@linux.vnet.ibm.com> wrote:
> > > >>>
> > > >>>
> > > >>>
> > > >>>> On 19 Jul 2024, at 1:46=E2=80=AFPM, Eric Lin <eric.lin@sifive.co=
m> wrote:
> > > >>>>
> > > >>>> Currently, if vendor JSON files have two duplicate event names,
> > > >>>> the "perf list" command will trigger a segfault.
> > > >>>>
> > > >>>> In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
> > > >>>> pmu_events_table__num_events() gets the number of JSON events
> > > >>>> from table_pmu->num_entries, which includes duplicate events
> > > >>>> if there are duplicate event names in the JSON files.
> > > >>>
> > > >>> Hi Eric,
> > > >>>
> > > >>> Let us consider there are duplicate event names in the JSON files=
, say :
> > > >>>
> > > >>> metric.json with: EventName as pmu_cache_miss, EventCode as 0x1
> > > >>> cache.json with:  EventName as pmu_cache_miss, EventCode as 0x2
> > > >>>
> > > >>> If we fix the segfault and proceed, still =E2=80=9Cperf list=E2=
=80=9D will list only one entry for pmu_cache_miss with may be 0x1/0x2 as e=
vent code ?
> > > >>> Can you check the result to confirm what =E2=80=9Cperf list=E2=80=
=9D will list in this case ? If it=E2=80=99s going to have only one entry i=
n perf list, does it mean there are two event codes for pmu_cache_miss and =
it can work with either of the event code ?
> > > >>>
> > > >>
> > > >> Sorry for the late reply.
> > > >> Yes, I've checked if there are duplicate pmu_cache_miss events in =
the
> > > >> JSON files, the perf list will have only one entry in perf list.
> > > >>
> > > >>> If it happens to be a mistake in json file to have duplicate entr=
y with different event code (ex: with some broken commit), I am thinking if=
 the better fix is to keep only the valid entry in json file ?
> > > >>>
> > > >>
> > > >> Yes, I agree we should fix the duplicate events in vendor JSON fil=
es.
> > > >>
> > > >> According to this code snippet [1], it seems the perf tool origina=
lly
> > > >> allowed duplicate events to exist and it will skip the duplicate
> > > >> events not shown on the perf list.
> > > >> However, after this commit e6ff1eed3584 ("perf pmu: Lazily add JSO=
N
> > > >> events"),  if there are two duplicate events, it causes a segfault=
.
> > > >>
> > > >> Can I ask, do you have any suggestions? Thanks.
> > > >>
> > > >> [1] https://github.com/torvalds/linux/blob/master/tools/perf/util/=
pmus.c#L491
> > > >>
> > > >
> > > > Kindly ping.
> > > >
> > > > Can I ask, are there any more comments about this patch? Thanks.
> > > >
> > > Hi Eric,
> > >
> > > The functions there says alias and to skip duplicate alias. I am not =
sure if that is for events
> > >
> > > Namhyung, Ian, Arnaldo
> > > Any comments here ?
> >
> > So I was trying to reproduce the problem here before looking at the
> > patch, tried a simple:
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ git diff
> > diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/cache.json b/too=
ls/perf/pmu-events/arch/x86/rocketlake/cache.json
> > index 2e93b7835b41442b..167a41b0309b7cfc 100644
> > --- a/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
> > +++ b/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
> > @@ -1,4 +1,13 @@
> >  [
> > +    {
> > +        "BriefDescription": "Counts the number of cache lines replaced=
 in L1 data cache.",
> > +        "Counter": "0,1,2,3",
> > +        "EventCode": "0x51",
> > +        "EventName": "L1D.REPLACEMENT",
> > +        "PublicDescription": "Counts L1D data line replacements includ=
ing opportunistic replacements, and replacements that require stall-for-rep=
lace or block-for-replace.",
> > +        "SampleAfterValue": "100003",
> > +        "UMask": "0x1"
> > +    },
> >      {
> >          "BriefDescription": "Counts the number of cache lines replaced=
 in L1 data cache.",
> >          "Counter": "0,1,2,3",
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ grep L1D.REPLACEMENT tools/per=
f/pmu-events/arch/x86/rocketlake/cache.json
> >         "EventName": "L1D.REPLACEMENT",
> >         "EventName": "L1D.REPLACEMENT",
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > I.e. duplicated that whole event definition:
> >
> > Did a make clean and a rebuild and:
> >
> > root@x1:/home/acme/git/pahole# perf list l1d.replacement
> >
> > List of pre-defined events (to be used in -e or -M):
> >
> >
> > cache:
> >   l1d.replacement
> >        [Counts the number of cache lines replaced in L1 data cache. Uni=
t: cpu_core]
> > root@x1:/home/acme/git/pahole# perf list > /dev/null
> > root@x1:/home/acme/git/pahole#
> >
> > No crash, can you provide instructions on how to reproduce the problem?
> >
> > I would like to use the experience to add a 'perf test' to show this
> > failing and then after the patch it passing that new test.
> >
>
> The segfault occurs when the vendor JSON files contain two events with du=
plicate names.
>
> I tried adding two duplicate events "L1D.REPLACEMENT" and "L1D_PEND_MISS.=
FB_FULL"  and the issue can be reproduced on my laptop on the x86 platform.
>
> ericl@EricL-ThinkPadX1-TW 11:11 ~/linux_src/linux/tools/perf (master)
> git diff
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json b/tools/=
perf/pmu-events/arch/x86/tigerlake/cache.json
> index f4144a1110be..71062a82699d 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> @@ -8,6 +8,24 @@
>          "SampleAfterValue": "100003",
>          "UMask": "0x1"
>      },
> +    {
> +        "BriefDescription": "Counts the number of cache lines replaced i=
n L1 data cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x51",
> +        "EventName": "L1D.REPLACEMENT",
> +        "PublicDescription": "Counts L1D data line replacements includin=
g opportunistic replacements, and replacements that require stall-for-repla=
ce or block-for-replace.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of cycles a demand request has waite=
d due to L1D Fill Buffer (FB) unavailability.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x48",
> +        "EventName": "L1D_PEND_MISS.FB_FULL",
> +        "PublicDescription": "Counts number of cycles a demand request h=
as waited due to L1D Fill Buffer (FB) unavailability. Demand requests inclu=
de cacheable/uncacheable demand load, store, lock or SW prefetch accesses."=
,
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
>      {
>          "BriefDescription": "Number of cycles a demand request has waite=
d due to L1D Fill Buffer (FB) unavailability.",
>          "Counter": "0,1,2,3",
>
> ericl@EricL-ThinkPadX1-TW 11:11 ~/linux_src/linux/tools/perf (master)
> $ ./perf list
> Segmentation fault (core dumped)

Hi Eric,

the series we were asking you to test was:
https://lore.kernel.org/linux-perf-users/20240805194424.597244-1-irogers@go=
ogle.com/
It can be convenient to use the b4 tool to grab a set of patches. It
is also in the perf-tools-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/
in the tmp.perf-tools-next branch, so you could clone that.

Having duplicate events doesn't make sense. When a sysfs event and
json event exist with the same name, the json events values override
those of the sysfs event:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dtmp.perf-tools-next#n599
Two json events doesn't have a clear meaning and which would be found
would be dependent on a binary search. To avoid the problem the linked
to series forbids duplicate events in the json and adds a build test
building all architectures json. As this would break due to duplicate
events, as your patch shows, there are json fixes for RISC-V and ARM.

Thanks,
Ian

