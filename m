Return-Path: <linux-kernel+bounces-273910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60ED946F79
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FD51C20BD7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8E60B8A;
	Sun,  4 Aug 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mOZFEhQq"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9EA934
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722784011; cv=none; b=pnKploftbtbmptp4kVCLSTTUIses+rr0CdvXuxaFiBJdPM4pQRZ1q6ZwoFgoMQFEbhBMFZVHv7G5BTzABduZjQrDSoljnTpO60ZZLZWqE/EbrmzBxuvzYBcsKBMAV0Lgx2oMPddPYUmX2D9d/rwwCcrQoZkxEAAvtnU1eG7re30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722784011; c=relaxed/simple;
	bh=7o2CbQ5M5VplzpINhdgvlhzIhLoaAvpBzWOXo6fCLL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3pNVVHbwvZQt2thRcWzVgmvdHuE00wKg7s+frkFU6i2NtbmZ9Ivex5rcjcikVx6k4JBpr+BKeaa0Sq1S9JE4964MUUjSy4F4ZablgAIAtLdM6TLnuRuzmrupsA3hCYo6Hea5prw9C/4KUXlWhJnEDrmQefX4zxaiJusduR3IX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mOZFEhQq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f025b94e07so122684001fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722784008; x=1723388808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQrCWp4OKK3+4deiYD4tlmq/nQtsx0T40/K2NKppM94=;
        b=mOZFEhQqOm//xD6kVhWQDMKLe9TRin+f4j9wmc/YbIeW1qGR/jWAy8Rqz1f/zhNrkY
         qYEwKRa7WamBT79Ejw6WtP28wfPdajVLL7KbqPuB7ukU82xDUHHzF5JTMSx+zi65fJWl
         NdQxHLceDRlZXg0DpWSD3jIydUAzYdNIkwTIfWhYM1mL0VCfDx5D3XuZZ95vSiBjrwOX
         MqqTGnueeBo9fDPE8esxZaHPHAvQv8bjp7TbOGwxK1C0vXnclc3PO4wMexPr3f3OHc96
         RCwpxLYp7R6HhG3ZbsWwySGYkO48De0BJwY0B873N9GOhnNIXAPl9w7nCktuRuzVN2yQ
         CCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722784008; x=1723388808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQrCWp4OKK3+4deiYD4tlmq/nQtsx0T40/K2NKppM94=;
        b=uO41mxq/a5rm8kW4VE1vMiZr1m5Vps0dq9r/40vWqNHPhL9HP9qgSNptJbSvOMbecy
         aIVPjNKg7LYqfkfuaylbOFKivNMZqNFJSEAgcol44uwt/RrsfcPgLXsphYz1T0mQudSt
         GU7GKdq3dy5piE1rUNATKYS4/iLCPKFyLq/qgRJw8E0EJWOHniV6v7cZ7k05eePYpFsz
         7iUeGtkAg5fIcbSDP+hUQumZDNLuTTIGeWZAkYBSK9+Zxupb3kmpcAkInFXE8iLtQDgR
         qAFri537To5pRFtCt1FTPHBTcY4DgTT/wqS7+c2fyY1ss11Yc44IdHoqkK11SJ54Gsd9
         UtVw==
X-Forwarded-Encrypted: i=1; AJvYcCUfF8jJwgNK1XPGI/yMnQWf+L0ZvVMxhtDjIPgIR9XQLrK8aaaaUtgtovTMSyBS01dXDxJiLNArzPvgrmocoB9ueNNJcckshMGZ6/jf
X-Gm-Message-State: AOJu0YysQe+gNNdBsH35pmeXCkloBp1mzTPeTmLRs42glznRTCS8rbgW
	amBOipQvcOATDBjQBArhyBXKQLia9MBsL2oKsud8Xt4C6PZECxxshhX57+i2VH4B4Voh1HN75Ih
	m+W3Di7JNeMfGgcj3doGO0zi2KfRTho1UvGcT/g==
X-Google-Smtp-Source: AGHT+IGc7VLuH0x7LzkjPJKoBbtGsdNPJ6msqbLAQ/TihoPa5KnqLDpmmDtfWXMvB3VYYYY5/sXnYC83XdOQkVqHiWA=
X-Received: by 2002:a2e:2418:0:b0:2ef:3258:4961 with SMTP id
 38308e7fff4ca-2f15aa9919cmr58377721fa.15.1722784007404; Sun, 04 Aug 2024
 08:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719081651.24853-1-eric.lin@sifive.com> <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
 <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
In-Reply-To: <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
From: Eric Lin <eric.lin@sifive.com>
Date: Sun, 4 Aug 2024 23:06:36 +0800
Message-ID: <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com>
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, vincent.chen@sifive.com, 
	greentime.hu@sifive.com, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 21, 2024 at 11:44=E2=80=AFPM Eric Lin <eric.lin@sifive.com> wro=
te:
>
> Hi Athira,
>
> On Sat, Jul 20, 2024 at 4:35=E2=80=AFPM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
> >
> >
> >
> > > On 19 Jul 2024, at 1:46=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> wr=
ote:
> > >
> > > Currently, if vendor JSON files have two duplicate event names,
> > > the "perf list" command will trigger a segfault.
> > >
> > > In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
> > > pmu_events_table__num_events() gets the number of JSON events
> > > from table_pmu->num_entries, which includes duplicate events
> > > if there are duplicate event names in the JSON files.
> >
> > Hi Eric,
> >
> > Let us consider there are duplicate event names in the JSON files, say =
:
> >
> > metric.json with: EventName as pmu_cache_miss, EventCode as 0x1
> > cache.json with:  EventName as pmu_cache_miss, EventCode as 0x2
> >
> > If we fix the segfault and proceed, still =E2=80=9Cperf list=E2=80=9D w=
ill list only one entry for pmu_cache_miss with may be 0x1/0x2 as event cod=
e ?
> > Can you check the result to confirm what =E2=80=9Cperf list=E2=80=9D wi=
ll list in this case ? If it=E2=80=99s going to have only one entry in perf=
 list, does it mean there are two event codes for pmu_cache_miss and it can=
 work with either of the event code ?
> >
>
> Sorry for the late reply.
> Yes, I've checked if there are duplicate pmu_cache_miss events in the
> JSON files, the perf list will have only one entry in perf list.
>
> > If it happens to be a mistake in json file to have duplicate entry with=
 different event code (ex: with some broken commit), I am thinking if the b=
etter fix is to keep only the valid entry in json file ?
> >
>
> Yes, I agree we should fix the duplicate events in vendor JSON files.
>
> According to this code snippet [1], it seems the perf tool originally
> allowed duplicate events to exist and it will skip the duplicate
> events not shown on the perf list.
> However, after this commit e6ff1eed3584 ("perf pmu: Lazily add JSON
> events"),  if there are two duplicate events, it causes a segfault.
>
> Can I ask, do you have any suggestions? Thanks.
>
> [1] https://github.com/torvalds/linux/blob/master/tools/perf/util/pmus.c#=
L491
>

Kindly ping.

Can I ask, are there any more comments about this patch? Thanks.


Regards,
Eric Lin

> Regards,
> Eric Lin
>
> > Thanks
> > Athira
> >
> > >
> > > perf_pmu__for_each_event() adds JSON events to the pmu->alias
> > > list and copies sevent data to the aliases array. However, the
> > > pmu->alias list does not contain duplicate events, as
> > > perf_pmu__new_alias() checks if the name was already created.
> > >
> > > When sorting the alias data, if there are two duplicate events,
> > > it causes a segfault in cmp_sevent() due to invalid aliases in
> > > the aliases array.
> > >
> > > To avoid such segfault caused by duplicate event names in the
> > > JSON files, the len should be updated before sorting the aliases.
> > >
> > > Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> > > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > > ---
> > > tools/perf/util/pmus.c | 5 +++--
> > > 1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > > index b9b4c5eb5002..e38c3fd4d1ff 100644
> > > --- a/tools/perf/util/pmus.c
> > > +++ b/tools/perf/util/pmus.c
> > > @@ -443,7 +443,7 @@ void perf_pmus__print_pmu_events(const struct pri=
nt_callbacks *print_cb, void *p
> > > {
> > > struct perf_pmu *pmu;
> > > int printed =3D 0;
> > > - int len;
> > > + size_t len, j;
> > > struct sevent *aliases;
> > > struct events_callback_state state;
> > > bool skip_duplicate_pmus =3D print_cb->skip_duplicate_pmus(print_stat=
e);
> > > @@ -474,8 +474,9 @@ void perf_pmus__print_pmu_events(const struct pri=
nt_callbacks *print_cb, void *p
> > > perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
> > > perf_pmus__print_pmu_events__callback);
> > > }
> > > + len =3D state.index;
> > > qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
> > > - for (int j =3D 0; j < len; j++) {
> > > + for (j =3D 0; j < len; j++) {
> > > /* Skip duplicates */
> > > if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
> > > continue;
> > > --
> > > 2.43.2
> > >
> > >
> >

