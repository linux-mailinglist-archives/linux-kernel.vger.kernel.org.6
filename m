Return-Path: <linux-kernel+bounces-275270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA942948295
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02C3282D14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3717E16C69D;
	Mon,  5 Aug 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nv5r0B+l"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3416A397
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887318; cv=none; b=CxG0Y7AZnACCV4USRx1CcWkWeRiKubF21LeXbl4jZD5xEJlhmRaWLAeb5oCRIAL+/POABykYoglTPzOLVXRAGm2E+8jBbYhCi5LT9w0nNZUwvoPIO8LPo5cjCMg7R+FUR/2Ho8LX1WSIR4cErfj4cA4OBW3lCGGC4QexuJl48fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887318; c=relaxed/simple;
	bh=Dr57dJtQ38Gbe8CPMfmBqTXW8AJCnClRmVh6ulllSQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp3iGKtMjnPOIF4LKx0B8gZn+i6PNLAsKRGAE7zif6BM5qvy6jyqh7G5nG6QHPfV8wySuFNGQmUX1d+3/pL0mSw6cCUb5Gt6lzGOI61xZssytm8by8oleLoHchKKuC9yDxZ8vKGtQy/JTKytHRRZip0S+kbwh0TZjZKXGWUJtN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nv5r0B+l; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39b33a68ec5so6475ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887316; x=1723492116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hvhgLue4AXt3dLDPL8T2PtC1iyTJfy9ADyuT3yI42s=;
        b=nv5r0B+lIn66In6KvS1s/xks991mWvHTS1gdhHl0unEGW+i+cV3/NsJnjpdZ106THl
         q/OywDeq2PpXzIrhzJuq1O2mu0PBGth+AC6bub6ipTB5Fs2+TkxgpIw/NKFUaqjZyeVM
         fYRfQ5e3qK5w+a3vEw5LpY64QLQ0vK1kXZMHhRujUgYZg/Qa9zCuJgoO3to4zs/gKO/3
         rYfu+uX5iL5J8p1hq+aCJLgjuEIEHDQl7XH1uxhlNdN4t4PQyzUU1dgEjZEYLuklDqXk
         hTrJVsCZXX9/YgXqkmw7m+c/CK68W/VjVbdGxtV2bIVTNCaU+NCO+n3n8SlomwaEzE8e
         1JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887316; x=1723492116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hvhgLue4AXt3dLDPL8T2PtC1iyTJfy9ADyuT3yI42s=;
        b=cy0hFxlNpGB5RyIgIpZYzn2v6ShMsobNUWT635odIzt6xzF6XPG1P9DdCMf+c1hlIB
         gNqT19Rgw2Cur/e5ACjnkWtbczwj54INojXM1/rxrDEtTmZPTfsNJcvsLGAu/83A7pex
         Rq/n5cwovVRUGYGI36t/BNHuvWbQbqm/FTLuAdBT30uuAFG5PcL3LhxRnpBWPRR6ER6h
         SQLh+QUl8SC00j8DrrZM9o/qhwzmD8RVPIbzClDW6ydmOMxUqrSV2P9C1jsOE3SZNA8B
         fQumSm8Her4UgmcBZioSFJdzrVztKW1PExbQ/HALZv3SPDH8nU/JSdR/SIpThBoZQpCR
         xPiA==
X-Forwarded-Encrypted: i=1; AJvYcCUAS8X4EDmwf26Wlv0NMVm7xY4G5wbq0H5ngnxNGQQ3O50ZfUL6T8cmt+S4RP5TGM8QDkYnBCjgov2tLM9FL53B54BbU+6lkqT9j+I+
X-Gm-Message-State: AOJu0YzTImPEpazR/rEjXNpxZ1O5BcxgQWswxPScxy6bSZ4KbS5LGvpB
	ecLutfA3yy6KyMLYWo98mydoF2X5KKCe2bfpb3xcWX0KgGc4gwLvKhzf1+E2vNQeK7TNSEzpAfO
	7h0tncnUVQEKpfOA7R/jZzmRyRQGhTegRk6GN
X-Google-Smtp-Source: AGHT+IFn5+kKCxI/nl9AkTKa63lL7L4m2qmQ/sMNbcWxnI5E+FUJZwcXcZyyOHTL0R7C+tAVQk3Ac2006YgtQuZNbuI=
X-Received: by 2002:a92:ab12:0:b0:381:24d7:7cc6 with SMTP id
 e9e14a558f8ab-39b487a3dfamr429695ab.3.1722887315679; Mon, 05 Aug 2024
 12:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719081651.24853-1-eric.lin@sifive.com> <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
 <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
 <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com>
 <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com> <CAP-5=fVttTnWV7KpiaxNjyiDXt9Uf5zZEm4v5V4mGXMyRr6nSg@mail.gmail.com>
In-Reply-To: <CAP-5=fVttTnWV7KpiaxNjyiDXt9Uf5zZEm4v5V4mGXMyRr6nSg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Aug 2024 12:48:23 -0700
Message-ID: <CAP-5=fU13UYkXZVOcJP+xiRLhDDRycJn=P1wnJi4KnB9KGdpkQ@mail.gmail.com>
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

On Mon, Aug 5, 2024 at 10:02=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Aug 5, 2024 at 7:24=E2=80=AFAM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
> >
> >
> >
> > > On 4 Aug 2024, at 8:36=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> wro=
te:
> > >
> > > Hi,
> > >
> > > On Sun, Jul 21, 2024 at 11:44=E2=80=AFPM Eric Lin <eric.lin@sifive.co=
m> wrote:
> > >>
> > >> Hi Athira,
> > >>
> > >> On Sat, Jul 20, 2024 at 4:35=E2=80=AFPM Athira Rajeev
> > >> <atrajeev@linux.vnet.ibm.com> wrote:
> > >>>
> > >>>
> > >>>
> > >>>> On 19 Jul 2024, at 1:46=E2=80=AFPM, Eric Lin <eric.lin@sifive.com>=
 wrote:
> > >>>>
> > >>>> Currently, if vendor JSON files have two duplicate event names,
> > >>>> the "perf list" command will trigger a segfault.
> > >>>>
> > >>>> In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
> > >>>> pmu_events_table__num_events() gets the number of JSON events
> > >>>> from table_pmu->num_entries, which includes duplicate events
> > >>>> if there are duplicate event names in the JSON files.
> > >>>
> > >>> Hi Eric,
> > >>>
> > >>> Let us consider there are duplicate event names in the JSON files, =
say :
> > >>>
> > >>> metric.json with: EventName as pmu_cache_miss, EventCode as 0x1
> > >>> cache.json with:  EventName as pmu_cache_miss, EventCode as 0x2
> > >>>
> > >>> If we fix the segfault and proceed, still =E2=80=9Cperf list=E2=80=
=9D will list only one entry for pmu_cache_miss with may be 0x1/0x2 as even=
t code ?
> > >>> Can you check the result to confirm what =E2=80=9Cperf list=E2=80=
=9D will list in this case ? If it=E2=80=99s going to have only one entry i=
n perf list, does it mean there are two event codes for pmu_cache_miss and =
it can work with either of the event code ?
> > >>>
> > >>
> > >> Sorry for the late reply.
> > >> Yes, I've checked if there are duplicate pmu_cache_miss events in th=
e
> > >> JSON files, the perf list will have only one entry in perf list.
> > >>
> > >>> If it happens to be a mistake in json file to have duplicate entry =
with different event code (ex: with some broken commit), I am thinking if t=
he better fix is to keep only the valid entry in json file ?
> > >>>
> > >>
> > >> Yes, I agree we should fix the duplicate events in vendor JSON files=
.
> > >>
> > >> According to this code snippet [1], it seems the perf tool originall=
y
> > >> allowed duplicate events to exist and it will skip the duplicate
> > >> events not shown on the perf list.
> > >> However, after this commit e6ff1eed3584 ("perf pmu: Lazily add JSON
> > >> events"),  if there are two duplicate events, it causes a segfault.
> > >>
> > >> Can I ask, do you have any suggestions? Thanks.
> > >>
> > >> [1] https://github.com/torvalds/linux/blob/master/tools/perf/util/pm=
us.c#L491
> > >>
> > >
> > > Kindly ping.
> > >
> > > Can I ask, are there any more comments about this patch? Thanks.
> > >
> > Hi Eric,
> >
> > The functions there says alias and to skip duplicate alias. I am not su=
re if that is for events
>
> Fwiw, I'm trying to get rid of the term alias it should mean event.
> For some reason the code always referred to events as aliases as
> exemplified by:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/pmu.c?h=3Dtmp.perf-tools-next#n55
> But it is possible to have an "alias" (different) name for a PMU and
> I'm sure for other things too. So the term alias is ambiguous and
> these things are events, so let's just call them events to be most
> intention revealing.
>
> > Namhyung, Ian, Arnaldo
> > Any comments here ?
>
> I'll take a look.

The problematic events all come from copy pasting ArchStdEvent. It
feels better to have an invariant that events appear once so I sent
out a series to clean this up:
https://lore.kernel.org/linux-perf-users/20240805194424.597244-1-irogers@go=
ogle.com/
If you could test and add a tested-by tag that'd be great!

Thanks,
Ian

