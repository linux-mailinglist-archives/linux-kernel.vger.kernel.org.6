Return-Path: <linux-kernel+bounces-404888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC069C49CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72BA288D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDCB1B4F07;
	Mon, 11 Nov 2024 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aOgucyH7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6E15887C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368337; cv=none; b=ZpSssPXIwEfXkTPIQa6pPFpCnJ0UF7f0BDWzk+EiEpCTKR2P5VBsQBVArxsXQE/3WsBUKce6o+Qq3SGl5z7gArAhJa7gwO2vJIakdDNFrk2cmNG6HXBFcFmqDFipFIda3wnAgbjod5cqiztnL2Ky7YK6xG/KH7A15PQswhJv6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368337; c=relaxed/simple;
	bh=dm/hQwp5MqqL2oSDhczxwDhJHWAhtjMwN4dvDZXDm3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCH+hHFkTtIPy6ZPNXSngx2y27iTsREH8PRrh9qv4IerQ1rHRSWICIrRcMDtpBnzlSyNFI0ti80/D1eLsx+RyYIo9K5DoU68xnFVPW6j4haiFieEy9c9hIaDxBd4RMQ/EJZN+w5uzR0iZeph4fvJ8GAZFw2x0VPdOMO0kO3Sy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aOgucyH7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e5130832aso3879896b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731368335; x=1731973135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8yRTg2gxlhT6ZNwbfYt7zd1cKOPlVMlYaS9QEirCAw=;
        b=aOgucyH7DwXbYQa15nQ4/ja5xGyVVXpAEo7+RpM+XhALxF52V07id3teD9KQHov6mL
         HgpbwKHm0mj4aU0zswZkoqaI5ddtuoI67CZpKwHhgDP0q1lbOzrorGu2ozncHriwJjZJ
         JJxNjRWACO3j7kkHRQP+nFhNJEgj1hDtrcsTAuYt1gmHW0gbxCEuyyg9VrzK9x+F5+3v
         T1MWt5SOLt/mxEw42oTCXTJdjAYuCioz4OoA6LPxTbAy6AsAihpa69JNE5LMC+pmNLE4
         UY6L03hBhn4pJMeHTa+41M88jgcinVEU0FFKy2rLOVILj7lfPPgcsdrUnK2Qs11vmqf7
         MPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368335; x=1731973135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8yRTg2gxlhT6ZNwbfYt7zd1cKOPlVMlYaS9QEirCAw=;
        b=oOjAEgh2GSfwKeYw/HlsexFTKqdLEK8eYQhT/DiK0dvGnM2Fp8rydwkJcZ//e+V/nZ
         8RCBiWMhq7LPJxhnAxisbdKLUWR9QRIsP++olzNS4S49nAXO/lXae45oLYyHrz9qR5k+
         N4VXFkGM5L3Y941yCjwCdTAaWy8vD9LVFiH1Ma395OBUcTtsB+kZn5/H4S2omgYBA/dh
         gckGNMTbbm8KA9OLdIhKIQHKuVd910A440yT606Fn3WZWpj8sTaJimK89LLrbtCcJe6U
         q0QOQ1vXNHT2Nbiy7sAJzAb7Bk3ya4gnavjxCTHOOB1pqQkTVrBlWfFrMX+J+3u6XzAO
         Wwvw==
X-Forwarded-Encrypted: i=1; AJvYcCWP1w3fEfATbFVQMnqWIFJur8fBdcAk/kfxtlMR/AhMke50CmBKeYAfjMXmxw39gpUAwQwMlVc3ujYcAHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknKJxXOaWnuJGYbS7IpelxSsTyx4XJ8DW5By/YIMiiQ0RYgPl
	DBtRbWhyIUW4f3JtnIid0cWYiClB/f/5Bx0J8w5srTeorszdqnNqPACC8b1mUmFxTqmQjbxwnB0
	VbO7N7U5E9ZeE2eSJDf7lR14c+hfxzKARE1I8rw==
X-Google-Smtp-Source: AGHT+IE7Fl9EIALn9TNMMttpcoLk+6DrI6/tnerMLnKoCya+sFZ3cL8WdxplP2tFW3MXI3WJLzJVeJrxjnhCy963cl4=
X-Received: by 2002:a05:6a00:3925:b0:71d:f15e:d026 with SMTP id
 d2e1a72fcca58-7241326dd7emr19203123b3a.3.1731368335086; Mon, 11 Nov 2024
 15:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com> <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
 <78eb729c-7594-460f-9d79-97fb683d8b5e@linaro.org> <CAHBxVyFXWpczMmWJbpWoLUjQ4nfNC2_h1yZqSd7kSr6N8Rvm5Q@mail.gmail.com>
 <d9bfd75a-003a-4f65-abba-b8bcaad13682@linaro.org> <CAP-5=fUHjxL5QbsyQQU-3EYiVhiO6wt=F5MfSfDcAffKP7WWAg@mail.gmail.com>
In-Reply-To: <CAP-5=fUHjxL5QbsyQQU-3EYiVhiO6wt=F5MfSfDcAffKP7WWAg@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 11 Nov 2024 15:38:44 -0800
Message-ID: <CAHBxVyFVsKy+PKvyffOfOw6fU7BGa9+cm6d3uYzSG-8GY2jhxA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Ian Rogers <irogers@google.com>
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

On Mon, Nov 11, 2024 at 9:19=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Nov 11, 2024 at 2:45=E2=80=AFAM James Clark <james.clark@linaro.o=
rg> wrote:
> >
> >
> >
> > On 08/11/2024 6:37 pm, Atish Kumar Patra wrote:
> > > On Fri, Nov 8, 2024 at 4:16=E2=80=AFAM James Clark <james.clark@linar=
o.org> wrote:
> > >>
> > >>
> > >>
> > >> On 07/11/2024 18:51, Ian Rogers wrote:
> > >>> On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@google.=
com> wrote:
> > >>>>
> > >>>> At the RISC-V summit the topic of avoiding event data being in the
> > >>>> RISC-V PMU kernel driver came up. There is a preference for sysfs/=
JSON
> > >>>> events being the priority when no PMU is provided so that legacy
> > >>>> events maybe supported via json. Originally Mark Rutland also
> > >>>> expressed at LPC 2023 that doing this would resolve bugs on ARM Ap=
ple
> > >>>> M? processors, but James Clark more recently tested this and belie=
ves
> > >>>> the driver issues there may not have existed or have been resolved=
. In
> > >>>> any case, it is inconsistent that with a PMU event names avoid leg=
acy
> > >>>> encodings, but when wildcarding PMUs (ie without a PMU with the ev=
ent
> > >>>> name) the legacy encodings have priority.
> > >>>>
> > >>>> The patch doing this work was reverted in a v6.10 release candidat=
e
> > >>>> as, even though the patch was posted for weeks and had been on
> > >>>> linux-next for weeks without issue, Linus was in the habit of usin=
g
> > >>>> explicit legacy events with unsupported precision options on his
> > >>>> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycle=
s
> > >>>> where ARM decided to call the events bus_cycles and cycles, the la=
tter
> > >>>> being also a legacy event name. ARM haven't renamed the cycles eve=
nt
> > >>>> to a more consistent cpu_cycles and avoided the problem. With thes=
e
> > >>>> changes the problematic event will now be skipped, a large warning
> > >>>> produced, and perf record will continue for the other PMU events. =
This
> > >>>> solution was proposed by Arnaldo.
> > >>>>
> > >>>> Two minor changes have been added to help with the error message a=
nd
> > >>>> to work around issues occurring with "perf stat metrics (shadow st=
at)
> > >>>> test".
> > >>>>
> > >>>> The patches have only been tested on my x86 non-hybrid laptop.
> > >>>
> > >>> Hi Atish and James,
> > >>>
> > >>> Could I get your tags for this series?
> > >>>
> > >
> > > Hi Ian,
> > > Thanks for your patches. It definitely helps to have a clean slate
> > > implementation
> > > for the perf tool. However, I have some open questions about other us=
e cases
> > > that we discussed during the RVI Summit.
> > >
> > >>> The patches were originally motivated by wanting to make the behavi=
or
> > >>> of events parsed like "cycles" match that of "cpu/cycles/", the PMU=
 is
> > >>> wildcarded to "cpu" in the first case. This was divergent because o=
f
> > >>> ARM we switched from preferring legacy (type =3D PERF_TYPE_HARDWARE=
,
> > >>> config =3D PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=3D<core PM=
U's
> > >>> type>, config=3D<encoding from event>) when a PMU name was given. T=
his
> > >>> aligns with RISC-V wanting to use json encodings to avoid complexit=
y
> > >>> in the PMU driver.
> > >>>
> > >>
> > >> I couldn't find the thread, but I remember fairly recently it was
> > >> mentioned that RISC-V would be supporting the legacy events after al=
l,
> > >> maybe it was a comment from Atish? I'm not sure if that changes the
> > >> requirements for this or not?
> > >>
> > >> I still can't really imagine how tooling would work if every tool ha=
s to
> > >> maintain the mappings of basic events like instructions and branches=
.
> > >> For example all the perf_event_open tests in ltp use the legacy even=
ts.
> > >>
> > >
> > > No it has not changed. While this series helps to avoid clunky vendor
> > > specific encodings
> > > in the driver for perf tool, I am still unsure how we will manage
> > > other applications
> > > (directly passing legacy events through perf_event_open or
> > > perf_evlist__open) will work.
> > >
> > > I have only anecdotal data about folks relying perf legacy events
> > > directly to profile
> > > their application. All of them use mostly cycle/instruction events th=
ough.
> > > Are there any users who use other legacy events directly without perf=
 tool ?
> > >
> > > If not, we may have only cycle/instruction mapping in the driver and
> > > rely on json for everything else.
> > > The other use case is virtualization. I have been playing with these
> > > patches to find a clean solution to
> > > enable all the use cases. If you have any other ideas, please let me =
know.
> > >
> >
> > Yeah I would expect it's mostly cycles and instructions. I searched a
> > bit for PERF_COUNT_HW_BRANCH_MISSES and only found tool/developer type
> > usages, which I suppose we could expect to have to handle the mappings
> > like perf. Although it's not the easiest thing to search for and
> > obviously that only includes open source.
> >
> > Usages do exist though, there are people posting on stack overflow usin=
g
> > it, and other various bug tracker listings. So you would expect those
> > same users to have to use raw event codes and some switch statement to
> > pick the right one for their hardware, or use Perf.
>
> I don't have any magic to solve this. My thoughts:
>
> 1) I thought legacy events were just going to hang around forever,
> although the name hinting they'd kind of been deprecated. At LPC '23
> Atish and Mark Rutland originally asked for the sysfs/json to be the
> preference. I thought Kan was going to push back given the upheaval,
> especially updating every test expectation. It went through but we're
> in this weird state where wildcard events are encoded using legacy and
> PMU specifying events aren't. What this series hopes to solve.
>
> 2) I think it is important that perf tool be a reference
> implementation where others can look (strace, etc.) to base their
> implementation. Moving perf to sysfs/json is 1 step closer to legacy
> event deprecation. Please yell if deprecation isn't what is wanted as
> personally other than cleanliness I don't mind. If we do decide not to
> have sysfs/json be the priority then I think it sensible to revert the
> changes making it the priority for events that specify a PMU. I'd like
> some level of consistency.
>
> 3) I'd like event parsing to be a library that is as easy to link
> against as libbpf (i.e. not a viral license). Event parsing is really
> just mapping an event name to 1 or more perf_event_attr. The PMU
> abstraction is tied into the event parsing, but this has only been
> more true recently. The evsel/evlist is tied into event parsing but
> that feels separable. As most json isn't distributed under a viral
> license this feels achievable, then I suspect most tools can use this
> library rather than have to reinvent a wheel.

That would be the ideal solution IMHO for any other tools.

For virtualization, the guest OS would pass the event attribute as RAW
if the matching json
file is present. The hypervisor would simply program that in mhpmevent CSR.

In absence of the json file, guest OS would pass the legacy event
encoding which must be
mapped to a vendor specific encoding present in the driver. Hopefully,
this can be removed
in the future once legacy events are deprecated.  Thoughts ?

>
> Still looking for tags :-)
>

Done. Sorry for the delay. Just wanted to ensure that this solutions
works properly
for all the above cases I mentioned.

> Thanks,
> Ian

