Return-Path: <linux-kernel+bounces-247799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8492892D4AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E9D1C21235
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0AD194131;
	Wed, 10 Jul 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvG1DpIo"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CFB18FA14
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624060; cv=none; b=qCBaSADkSQA4hP3y4f2Kdda2GJjqWNl0oBAKpZq8b8Hj3M7W9Gd2M+cxjBlqm67bAMsNEbH+G0O/qab9RZ21cow1LQLBSPtjjZnMZ0rl+VAkK2WFRsPVBrDOi+Vxu23fQ9nDW92zAItMgHhwju+P9uytnGtpufBHXamKwClc7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624060; c=relaxed/simple;
	bh=vcdY9MUN5ZYdD+0dlB3pMyvklIPqAlqyJqfrffSbRRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlvVklacuQ08iI5wkcYE66sAOMBnysrzoHgLU8kXi+NFEnbvxH7ZRqvE+zzIlavqqNv5xRXz4Dzvaxun/E6O9BBIr7Xx9iuaTiH2iFWy+brc/KFS5REUi0f/Rna1WEERNWWMFAy4+Dyf21JIR+DrKlSW1cdUWx/Gy7Sf92b8kmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gvG1DpIo; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-447f8aa87bfso447601cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720624056; x=1721228856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5dgbGRorkiVAKVlp8pxM+M8gBnLAiXQeIsnSMwLS+Y=;
        b=gvG1DpIoTfGwkOxhaLSUq+thLUw0BWjdujqKXQnjs8sodGGp7fGaE9n0rqN5TSqj2p
         EaFT0A2Ko1sZms2TxpFG/eGa2hIc09348u1nP3q5uiZEw6jaaej2uw1Z4ZvPxrsTRH0w
         Nu4ZIkxQ29waZegpqF2Uicrmz8mBQ57jwv52RWH2VV5gg51f3OxeRXAoWcCaMioABpzx
         lGIROdxAGhHfdZabuC6RvY622qVqFVbcP1d0BtHWqIokMBwpArQfFHevHH6a0jpzCoUW
         VYlpiiOKiUKZcoXYcSZ8tFXrYFTDwweZrGUghvmGlsX750u1k0oButDbTe8leSpZa9xh
         6ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624056; x=1721228856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5dgbGRorkiVAKVlp8pxM+M8gBnLAiXQeIsnSMwLS+Y=;
        b=hy40jlvpC9fo5YBRajkGp16L1JDZtKple02aMGlOZ9rauaWJIWxhklktCEtAgn9gnG
         Jyou6qaSMDOwNhXj5v7Ukfd7/0E0U9sNxUNIXPQAouZEdkFip5rLXo+Zpm4ciFcnsMRN
         edPmpBLmkMEq2B27nqhliviKYYismAV45i6+xP++Q4eft1hUcd4dRG3muiqhlsow41kK
         YR4rc+YTot4z6I46z/itptE6D408y6doWYHYmw4gOhMeQNtGtlZk8tRm3LYSbAJ0nZRA
         0z0lNhUYgLWS5r+0h9CtEnTsToIC+tJXocK2LPOszg4Bjsw4JLZH5/5olVYCiiZNYmUR
         1OqA==
X-Forwarded-Encrypted: i=1; AJvYcCWD+YpyvGHpSrPSNWE6ln2yFzaOloqueOybdLH/AWDX3HwU4y9atPBug1fVeyuRDP2mPExya0Qf2VeGIYoksypkdxxK04p6AZkhRF3k
X-Gm-Message-State: AOJu0YwcxfV8W1Hc9gB2rDYRfMJ8xvXqbPLkxLPoEKp9q8eUZ3NHJ6zk
	P/b1Om2LoWg0SOtO/CSF7u2Vgx6IlAT503vAEwsGNV99imdOicQ2aHxOkXjTx+kdW+n+RSQoOYv
	084R20RlV1cGf//t64Crwl7/WFdoYo0Lvlgt7
X-Google-Smtp-Source: AGHT+IGUH2nK2xcoFXiC07fLg1WSH8kZWE9jVRC1F0SAx2p4Pnt+AS8ShMAk1LHq6s1BiNkwxfcndS6qd9jvqgJHE2k=
X-Received: by 2002:ac8:72d7:0:b0:447:e847:486 with SMTP id
 d75a77b69052e-44b16c85d3fmr3032061cf.3.1720624056102; Wed, 10 Jul 2024
 08:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
 <20240708144204.839486-4-dapeng1.mi@linux.intel.com> <CAP-5=fVPb4JGR3RxfPBGrihrra8bFzdJfFt2iASSs2xHOy=U4g@mail.gmail.com>
 <4d39856e-396d-4a48-9ca3-2e1a574f50d7@linux.intel.com> <CAP-5=fW65kxuABBJVAzKwoyBWW92_jkndWgY+4u9s3OGj_UkEg@mail.gmail.com>
 <afea2a93-0769-4ce5-ab59-2693d2d2f344@linux.intel.com>
In-Reply-To: <afea2a93-0769-4ce5-ab59-2693d2d2f344@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jul 2024 08:07:24 -0700
Message-ID: <CAP-5=fUP1O+VnH+7PaZtEgsFUFOpjo-tRtmAyVjG=Q4GFToR7g@mail.gmail.com>
Subject: Re: [Patch v2 3/5] perf x86/topdown: Don't move topdown metrics
 events when sorting events
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:40=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 7/10/2024 6:37 AM, Ian Rogers wrote:
> > On Mon, Jul 8, 2024 at 9:18=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.int=
el.com> wrote:
> >>
> >> On 7/8/2024 11:08 PM, Ian Rogers wrote:
> >>> On Mon, Jul 8, 2024 at 12:40=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.i=
ntel.com> wrote:
> >>>> when running below perf command, we say error is reported.
> >>>>
> >>>> perf record -e "{slots,instructions,topdown-retiring}:S" -vv -C0 sle=
ep 1
> >>>>
> >>>> ------------------------------------------------------------
> >>>> perf_event_attr:
> >>>>   type                             4 (cpu)
> >>>>   size                             168
> >>>>   config                           0x400 (slots)
> >>>>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENT=
IFIER
> >>>>   read_format                      ID|GROUP|LOST
> >>>>   disabled                         1
> >>>>   sample_id_all                    1
> >>>>   exclude_guest                    1
> >>>> ------------------------------------------------------------
> >>>> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 5
> >>>> ------------------------------------------------------------
> >>>> perf_event_attr:
> >>>>   type                             4 (cpu)
> >>>>   size                             168
> >>>>   config                           0x8000 (topdown-retiring)
> >>>>   { sample_period, sample_freq }   4000
> >>>>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENT=
IFIER
> >>>>   read_format                      ID|GROUP|LOST
> >>>>   freq                             1
> >>>>   sample_id_all                    1
> >>>>   exclude_guest                    1
> >>>> ------------------------------------------------------------
> >>>> sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
> >>>> sys_perf_event_open failed, error -22
> >>>>
> >>>> Error:
> >>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument=
) for event (topdown-retiring).
> >>>>
> >>>> The reason of error is that the events are regrouped and
> >>>> topdown-retiring event is moved to closely after the slots event and
> >>>> topdown-retiring event needs to do the sampling, but Intel PMU drive=
r
> >>>> doesn't support to sample topdown metrics events.
> >>>>
> >>>> For topdown metrics events, it just requires to be in a group which =
has
> >>>> slots event as leader. It doesn't require topdown metrics event must=
 be
> >>>> closely after slots event. Thus it's a overkill to move topdown metr=
ics
> >>>> event closely after slots event in events regrouping and furtherly c=
ause
> >>>> the above issue.
> >>>>
> >>>> Thus delete the code that moving topdown metrics events to fix the
> >>>> issue.
> >>> I think this is wrong. The topdown events may not be in a group, such
> >>> cases can come from metrics due to grouping constraints, and so they
> >>> must be sorted together so that they may be gathered into a group to
> >>> avoid the perf event opens failing for ungrouped topdown events. I'm
> >>> not understanding what these patches are trying to do, if you want to
> >>> prioritize the event for leader sampling why not modify it to compare
> >> Per my understanding, this change doesn't break anything. The events
> >> regrouping can be divided into below several cases.
> >>
> >> a. all events in a group
> >>
> >> perf stat -e "{instructions,topdown-retiring,slots}" -C0 sleep 1
> >> WARNING: events were regrouped to match PMUs
> >>
> >>  Performance counter stats for 'CPU(s) 0':
> >>
> >>         15,066,240      slots
> >>          1,899,760      instructions
> >>          2,126,998      topdown-retiring
> >>
> >>        1.045783464 seconds time elapsed
> >>
> >> In this case, slots event would be adjusted as the leader event and al=
l
> >> events are still in same group.
> >>
> >> b. all events not in a group
> >>
> >> perf stat -e "instructions,topdown-retiring,slots" -C0 sleep 1
> >> WARNING: events were regrouped to match PMUs
> >>
> >>  Performance counter stats for 'CPU(s) 0':
> >>
> >>          2,045,561      instructions
> >>         17,108,370      slots
> >>          2,281,116      topdown-retiring
> >>
> >>        1.045639284 seconds time elapsed
> >>
> >> In this case, slots and topdown-retiring are placed into a group and s=
lots
> >> is the group leader. instructions event is outside the group.
> >>
> >> c. slots event in group but topdown metric events outside the group
> >>
> >> perf stat -e "{instructions,slots},topdown-retiring"  -C0 sleep 1
> >> WARNING: events were regrouped to match PMUs
> >>
> >>  Performance counter stats for 'CPU(s) 0':
> >>
> >>         20,323,878      slots
> >>          2,634,884      instructions
> >>          3,028,656      topdown-retiring
> >>
> >>        1.045076380 seconds time elapsed
> >>
> >> In this case, topdown-retiring event is placed into previous group and
> >> slots is adjusted to leader event.
> >>
> >> d. multiple event groups
> >>
> >> perf stat -e "{instructions,slots},{topdown-retiring}"  -C0 sleep 1
> >> WARNING: events were regrouped to match PMUs
> >>
> >>  Performance counter stats for 'CPU(s) 0':
> >>
> >>         26,319,024      slots
> >>          2,427,791      instructions
> >>          2,683,508      topdown-retiring
> >>
> >>        1.045495830 seconds time elapsed
> >>
> >> In this case, the two groups are merged to one group and slots event i=
s
> >> adjusted as leader.
> >>
> >> The key point of this patch is that it's unnecessary to move topdown
> >> metrics events closely after slots event. It's a overkill since Intel =
core
> >> PMU driver doesn't require that. Intel PMU driver just requires topdow=
n
> >> metrics events are in a group where slots event is the group leader, a=
nd
> >> worse the movement for topdown metrics events causes the issue in the
> >> commit message mentioned.
> >>
> >> This patch doesn't block to regroup topdown metrics event. It just rem=
oves
> >> the unnecessary movement for topdown metrics events.
> > But you will get the same behavior because of the non-arch dependent
> > force group index - I guess you don't care as the sample read only
> > happens when you have a group.
> >
> > I'm thinking of cases like (which admittedly is broken):
> > ```
> > $ perf stat -e "{slots,instructions},cycles,topdown-fe-bound" -a sleep =
0.1
> > [sudo] password for irogers:
> >
> > Performance counter stats for 'system wide':
> >
> >     2,589,345,900      slots
> >       852,492,838      instructions
> >       583,525,372      cycles
> >   <not supported>      topdown-fe-bound
> >
> >       0.103930790 seconds time elapsed
> > ```
>
> I run the upstream code (commit 73e931504f8e0d42978bfcda37b323dbbd1afc08)
> without this patchset, I see same issue.
>
> perf stat -e "{slots,instructions},cycles,topdown-fe-bound" -a sleep 0.1
>
>  Performance counter stats for 'system wide':
>
>        262,448,922      slots
>         29,630,373      instructions
>         43,891,902      cycles
>    <not supported>      topdown-fe-bound
>
>        0.150369560 seconds time elapsed
>
> #perf -v
> perf version 6.10.rc6.g73e931504f8e
>
> This issue is not caused by this patchset.

I agree, but I think what is broken above was caused by the forced
grouping change that I did for Andi. The point of your change here is
to say that topdown events don't need to be moved while sorting, but
what should be happening here is just that. topdown-fe-bound should be
moved into the group with slots and instructions so it isn't "<not
supported>". So yes the current code has issues, but that's not the
same as saying we don't need to move topdown events, we do so that we
may group them better.

Thanks,
Ian

> > As the slots event is grouped there's no force group index on it, we
> > want to shuffle the topdown-fe-bound into the group so we want it to
> > compare as less than cycles - ie we're comparing topdown events with
> > non topdown events and trying to shuffle the topdown events first.
>
> Current evlist__cmp() won't really swap the order of cycles and
> topdown-fe-bound.
>
> if (lhs_sort_idx !=3D rhs_sort_idx)
>         return lhs_sort_idx - rhs_sort_idx;
>
> When comparing cycles and topdown-fe-bound events, lhs_sort_idx is 2 and
> rhs_sort_idx is 3, so the swap won't happen.
>
> So the event sequence after sorting is still "slots, instructions ,cycles=
,
> topdown-fe-bound". Both cycles and topdown-fe-bound events won't be place=
d
> into the group.
>
>
> >
> > Thanks,
> > Ian
> >
> >
> >
> >>> first?
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>>> ---
> >>>>  tools/perf/arch/x86/util/evlist.c | 5 -----
> >>>>  1 file changed, 5 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86=
/util/evlist.c
> >>>> index 332e8907f43e..6046981d61cf 100644
> >>>> --- a/tools/perf/arch/x86/util/evlist.c
> >>>> +++ b/tools/perf/arch/x86/util/evlist.c
> >>>> @@ -82,11 +82,6 @@ int arch_evlist__cmp(const struct evsel *lhs, con=
st struct evsel *rhs)
> >>>>                         return -1;
> >>>>                 if (arch_is_topdown_slots(rhs))
> >>>>                         return 1;
> >>>> -               /* Followed by topdown events. */
> >>>> -               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown=
_metrics(rhs))
> >>>> -                       return -1;
> >>>> -               if (!arch_is_topdown_metrics(lhs) && arch_is_topdown=
_metrics(rhs))
> >>>> -                       return 1;
> >>>>         }
> >>>>
> >>>>         /* Default ordering by insertion index. */
> >>>> --
> >>>> 2.40.1
> >>>>

