Return-Path: <linux-kernel+bounces-402229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E010D9C253C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B521C21875
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2EE1AA1C5;
	Fri,  8 Nov 2024 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGq7vzHX"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D41A9B52
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092415; cv=none; b=WpEY+JPtD0B62uv6CNZB89EI4euUCZzcQOQXuUzY8nZGBZK3lo6FNjnnygxUdDZXaSkw7iISu1okll9UO2GVx3WvV7ilO7HRSYBsC9yvMPOB+1mKuPXzMHgCakFukM4SrDVh+on9YFf38QqZ0KCNr+peIcale6j+raYOtO6PdyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092415; c=relaxed/simple;
	bh=WqYp6yg5pPwKFS2C+i3dSgKmWNxHXbSzx1xoi1gpdu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkJNs3oyw3jPijSARLTyPrDyPDpojYJYvgLJiDjHUw37rA6T3ORSEM0mDiBY8fvAfrr3KncT1P0VsF/Rh4C+N27gGZidGpWUO7y9Qtiq/D/1eT//yrquUJeka8ml1lN75sUf2RHu1GfNRKMvdCTSk5PhS1AAhmfcBfigkDOlIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UGq7vzHX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c87b0332cso15155ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731092412; x=1731697212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgUoiaIvwmd0dqXDVNwJZBRERye992Iv81OIK7UWxZo=;
        b=UGq7vzHXLDJoWsP7B5Djcx/Z+CfNjIp5tjpOsgqeIiR0kBgE8FwN72lhCMZhqnKp5y
         NKVVhnK1BGm7dzleYSOCEzXEu80EXpI3X1R5SC0QcjR8qoe1mxhBSi2+x9x0+4YXEe8J
         qA8qD4rSHt6iPRDbHUEUQD6Fdt3WUXO+E41B1YbIxY0MGOLJE35Z1o3/vMoNiWITFFiu
         8mdV8afJg910GxgBmvSrMpUYgT6MT5lAsJjBK2fo5CR4GXZ09aaabvFAzsJNXM0yJy7I
         ctwI4xDNcwcqD23P7eJLWm9nuX6JJD1S/s430VgJqbkD+J2F1ReQTBb4ZVmSNOBWWg70
         d7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731092412; x=1731697212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgUoiaIvwmd0dqXDVNwJZBRERye992Iv81OIK7UWxZo=;
        b=DSpuKGr5NE/pblqqz61MIAOUA0XzRY3bPxWASWkO5QFHfOHeYG0lu8BgeFfmh502PR
         VgTaZCmyqphh+RpcIEpgegEKT8hoFzgMdzjO39HvX06jSBip2+HUABwF81T/XNTVuLMh
         zrbSop8I1SSM59cybALmB8ziOZLLJLAi4jkIvRGUTfiYZnwvnaROUd2bYAMuK/1FWKyG
         NUiGrqYHvYo307HlL5ppNsm2ivXAS3qtDlIWiGbMlkRKKo39hiJc4JauhXbdlnsRj0KS
         CMyDvyJssfMIW60LUc1MaNAQ0ys9+VKb1RXQ44uqHNlqBuFugsFPeisz5O0XCdB1Ft14
         eHnw==
X-Forwarded-Encrypted: i=1; AJvYcCUsj3Vz44Nx3JENSYyLMTY+S6OqIA9zZrgCRtAjr/JxMkegIgooxNCsCmJZP5zlUW7mbkpMyB6n/0LRuHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4c7zvI+NMWlOQhXmtfcvfOHfQcdn+A7zmI8htMYZzpc9Wv6lL
	R2IpteTwrA0AABiaDzHLlcq1ETgN560apx8dRWUCxkC/d69PblQ5H13NDS89NvGBcEnqEw0xJgr
	pSujUmrojNWVoM1pRCRx77MO3fUJzjr5y+z4M
X-Gm-Gg: ASbGncvjjbvBw1LKOtdZ90PANewPI6AufptGGVIlX9FzKR+i4GWYT+WkUfKP3vlq66F
	f/JCpKejRtUAeFpoZ7v5vrhJbEbPxhvgS
X-Google-Smtp-Source: AGHT+IGbkZj+JMTOqmjdWQBlay0wkfJ4YtvQ+jjTvTX1drjgAdh01rmyeaMVQcVNM/9W5ndlugybvJQ8F6IRVI5txY0=
X-Received: by 2002:a17:902:f908:b0:20b:b52:3f7c with SMTP id
 d9443c01a7336-2118df7660fmr108525ad.18.1731092411428; Fri, 08 Nov 2024
 11:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com> <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
 <78eb729c-7594-460f-9d79-97fb683d8b5e@linaro.org> <CAHBxVyFXWpczMmWJbpWoLUjQ4nfNC2_h1yZqSd7kSr6N8Rvm5Q@mail.gmail.com>
In-Reply-To: <CAHBxVyFXWpczMmWJbpWoLUjQ4nfNC2_h1yZqSd7kSr6N8Rvm5Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 8 Nov 2024 10:59:59 -0800
Message-ID: <CAP-5=fV23r-_yVvGP3n5gjH8uZ2rEXmbZEwxr2wF+bpg=m745A@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-riscv@lists.infradead.org, beeman@rivosinc.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:38=E2=80=AFAM Atish Kumar Patra <atishp@rivosinc.=
com> wrote:
>
> On Fri, Nov 8, 2024 at 4:16=E2=80=AFAM James Clark <james.clark@linaro.or=
g> wrote:
> >
> >
> >
> > On 07/11/2024 18:51, Ian Rogers wrote:
> > > On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@google.co=
m> wrote:
> > >>
> > >> At the RISC-V summit the topic of avoiding event data being in the
> > >> RISC-V PMU kernel driver came up. There is a preference for sysfs/JS=
ON
> > >> events being the priority when no PMU is provided so that legacy
> > >> events maybe supported via json. Originally Mark Rutland also
> > >> expressed at LPC 2023 that doing this would resolve bugs on ARM Appl=
e
> > >> M? processors, but James Clark more recently tested this and believe=
s
> > >> the driver issues there may not have existed or have been resolved. =
In
> > >> any case, it is inconsistent that with a PMU event names avoid legac=
y
> > >> encodings, but when wildcarding PMUs (ie without a PMU with the even=
t
> > >> name) the legacy encodings have priority.
> > >>
> > >> The patch doing this work was reverted in a v6.10 release candidate
> > >> as, even though the patch was posted for weeks and had been on
> > >> linux-next for weeks without issue, Linus was in the habit of using
> > >> explicit legacy events with unsupported precision options on his
> > >> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> > >> where ARM decided to call the events bus_cycles and cycles, the latt=
er
> > >> being also a legacy event name. ARM haven't renamed the cycles event
> > >> to a more consistent cpu_cycles and avoided the problem. With these
> > >> changes the problematic event will now be skipped, a large warning
> > >> produced, and perf record will continue for the other PMU events. Th=
is
> > >> solution was proposed by Arnaldo.
> > >>
> > >> Two minor changes have been added to help with the error message and
> > >> to work around issues occurring with "perf stat metrics (shadow stat=
)
> > >> test".
> > >>
> > >> The patches have only been tested on my x86 non-hybrid laptop.
> > >
> > > Hi Atish and James,
> > >
> > > Could I get your tags for this series?
> > >
>
> Hi Ian,
> Thanks for your patches. It definitely helps to have a clean slate
> implementation
> for the perf tool. However, I have some open questions about other use ca=
ses
> that we discussed during the RVI Summit.

Thanks Atish, could I get your acked/reviewed/tested tags?

Ian

> > > The patches were originally motivated by wanting to make the behavior
> > > of events parsed like "cycles" match that of "cpu/cycles/", the PMU i=
s
> > > wildcarded to "cpu" in the first case. This was divergent because of
> > > ARM we switched from preferring legacy (type =3D PERF_TYPE_HARDWARE,
> > > config =3D PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=3D<core PMU'=
s
> > > type>, config=3D<encoding from event>) when a PMU name was given. Thi=
s
> > > aligns with RISC-V wanting to use json encodings to avoid complexity
> > > in the PMU driver.
> > >
> >
> > I couldn't find the thread, but I remember fairly recently it was
> > mentioned that RISC-V would be supporting the legacy events after all,
> > maybe it was a comment from Atish? I'm not sure if that changes the
> > requirements for this or not?
> >
> > I still can't really imagine how tooling would work if every tool has t=
o
> > maintain the mappings of basic events like instructions and branches.
> > For example all the perf_event_open tests in ltp use the legacy events.
> >
>
> No it has not changed. While this series helps to avoid clunky vendor
> specific encodings
> in the driver for perf tool, I am still unsure how we will manage
> other applications
> (directly passing legacy events through perf_event_open or
> perf_evlist__open) will work.
>
> I have only anecdotal data about folks relying perf legacy events
> directly to profile
> their application. All of them use mostly cycle/instruction events though=
.
> Are there any users who use other legacy events directly without perf too=
l ?
>
> If not, we may have only cycle/instruction mapping in the driver and
> rely on json for everything else.
> The other use case is virtualization. I have been playing with these
> patches to find a clean solution to
> enable all the use cases. If you have any other ideas, please let me know=
.
>
> > And wouldn't porting existing software to RISC-V would be an issue if i=
t
> > doesn't behave in a similar way to what's there already?
> >
> > > James, could you show the neoverse with the cmn PMU behavior for perf
> > > record of "cycles:pp" due to sensitivities there.
> > >
> >
> > Yep I can check this on Monday.
> >
> > > Thanks,
> > > Ian
> > >
> >
> >
> > >
> > >
> > >
> > >> Ian Rogers (4):
> > >>    perf evsel: Add pmu_name helper
> > >>    perf stat: Fix find_stat for mixed legacy/non-legacy events
> > >>    perf record: Skip don't fail for events that don't open
> > >>    perf parse-events: Reapply "Prefer sysfs/JSON hardware events ove=
r
> > >>      legacy"
> > >>
> > >>   tools/perf/builtin-record.c    | 22 +++++++---
> > >>   tools/perf/util/evsel.c        | 10 +++++
> > >>   tools/perf/util/evsel.h        |  1 +
> > >>   tools/perf/util/parse-events.c | 26 +++++++++---
> > >>   tools/perf/util/parse-events.l | 76 +++++++++++++++++-------------=
----
> > >>   tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
> > >>   tools/perf/util/pmus.c         | 20 +++++++--
> > >>   tools/perf/util/stat-shadow.c  |  3 +-
> > >>   8 files changed, 145 insertions(+), 73 deletions(-)
> > >>
> > >> --
> > >> 2.47.0.163.g1226f6d8fa-goog
> > >>

