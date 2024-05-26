Return-Path: <linux-kernel+bounces-189596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A73F8CF2A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 08:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B0C1F212AE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 06:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D09E3D62;
	Sun, 26 May 2024 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INqJNrjN"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F917D2
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716704542; cv=none; b=EvT+pK0+wJxc3o7ofS5GZBq740dJzp5tTE9ZIV2Lt31o9JPg3O5Kce+XV/oWn7d1JvJRptCTMliPNhmWcZNp5OsjZO225nbR5KHPc/xYh7B7iUJp2NyGLxnVes/R8Ix8dTvXyqvdcoSInPId9TwV/oN8aaPy+K22+Q8Sf7WlZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716704542; c=relaxed/simple;
	bh=EE8BTXmet0WFB7GKsVR0ZWDaP2FTwcYXZes7aSfRQjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4NW5pR3sRvMw1SLwyEZoi7ffEx8Vjbz3Mhw1aqH42SidzFUAcMBzfS6n5419HHO+Yy33haKv1KQNA6hEVoE6cG65c6e3z/nGxProPMnJXSaV6vgodtLUJZyVos3+oKS+ERnSkmixaxz1vNe8gG7j7QUZy/lOaTN9eOJ5bXzCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INqJNrjN; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36c6056f7bdso196795ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 23:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716704540; x=1717309340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPuTC1vAAk7gbV8KtBdVCBb6XPyiuQya/wCN3kuuIQQ=;
        b=INqJNrjNUcvmi/KCYq5ea9+TY0xFfFsJrHcRgHLqQA+1UQQI6rDpeGoWpy39awPFXL
         OEcHRAm9lBD4wE1T4zE11caDVOXsj64odflXt/61hVkWShHHmTf7JjBq8xgRR4IFHo5H
         SPa8NeFhwBrhqiv8pwcrzDO6ykt9OCAOMnp7tYjdwVF/ss5/L/EK85+tEb2lUpbBdhlE
         nkTtyKPdKMTj8jM46IpbWMpGKu15hzZdI2zhpqrhlQSu1XEpdF3sXhMBLUIYYs5I73oj
         Xcas1Fi1qRQ4G53yaYdZEYckuMcrR+8O+RhF/M7brAummcqawYCf4njS0cwMu1yt4+xF
         Pd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716704540; x=1717309340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPuTC1vAAk7gbV8KtBdVCBb6XPyiuQya/wCN3kuuIQQ=;
        b=M6b73cAJQGg4jDiL28rVdp4+MoXpARWFhrY212o4MHErVDPlkqxaGg8Rg1tni6fF7y
         NLdIvA14gfb1KdXDVwwin8dc+EQXSCxcy2v3LxtcJ4Wqbn1aSqmOYdpXdGnuatmcETKl
         2aDTwPBLA3ZMKnUtUGjGiQ8e4wKZf0N16qs2pB/6I/p7+nk1X4BDTGvuwlFfWFDHD/g4
         NZ4DYTn8+Yssn3CSE9E0LOWsHtZkR4xSQYe6DRqWJYzkHBfo5t030IA8IhdjWAV5n3BK
         3+9xP8roHo0uo2OvzJFO66njt+Z51F0ZIxNmxJPN8InWJtdlKLOq2ySovtG25fALG5mv
         zd7A==
X-Forwarded-Encrypted: i=1; AJvYcCVwgoFFZPA1EVQ1typ5NGp8CR4riwVanFSn1tvRc3Tb+YGHfJQ7LJc8h4dXAJRK101P/7dypRwy0jxwiKertzPjx3g0ZdVZ+WV34QAI
X-Gm-Message-State: AOJu0Yz2cqU5hCEBxTol3y+tl256Q8kQwJGqG7MWzHtiMMxQgj2rI5dx
	ajfuE/vdGwapkJeeJWJAHozNm7eKcnD0dLGb7h1bvvE2iH/wLovCbOpRxwclsdFnSIcaWH1OEAO
	QVAdEq+zodPaokAz3VYYXTeuZddGU+p9YOJ+p
X-Google-Smtp-Source: AGHT+IHOA+3MC5BCfYSWcQg2wRbFihyeqfHBSu7YvoHy4Tl4WaL1ZBauL1kAIowyYSCno5WQwGNXBMvJTlwcx9+mjo0=
X-Received: by 2002:a92:3611:0:b0:373:7fc0:e392 with SMTP id
 e9e14a558f8ab-3738b349abbmr2093135ab.19.1716704540022; Sat, 25 May 2024
 23:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
 <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
 <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
 <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com> <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
In-Reply-To: <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 25 May 2024 23:22:08 -0700
Message-ID: <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 10:22=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 25 May 2024 at 16:34, Ian Rogers <irogers@google.com> wrote:
> >
> > So I think we still need to figure out what:
> >
> > $ perf <command> -e <event> ...
> >
> > where <event> doesn't specify a PMU means. I'll try to enumerate the op=
tions:
>
> [ snip snip ]
>
> How about make the rule be that if the event doesn't have a specified
> PMU, then that just means "legacy rules first".
>
> IOW, if you have a fully qualified event name (maybe define that as
> "event name contains a slash), then you use the sysfs lookup.
>
> But a simple event name that doesn't contain a slash shall mean "use
> legacy lookup rules".

What to do with events with no PMU like data_read? On my Intel tigerlake la=
ptop:
```
$ ls /sys/devices/*/events/data_read
/sys/devices/uncore_imc_free_running_0/events/data_read
/sys/devices/uncore_imc_free_running_1/events/data_read
$ perf --version
perf version 6.6.15
$ sudo perf stat --no-merge -e data_read -a sleep 0.1

 Performance counter stats for 'system wide':

            122.84 MiB  data_read [uncore_imc_free_running_0]
            123.00 MiB  data_read [uncore_imc_free_running_1]

       0.101826301 seconds time elapsed
```
The rule for looking up an event with no PMU specified is to try it on
every PMU - the rule is about as old as perf itself. For heterogeneous
systems (BIG.little, hybrid) legacy events (cycles, instructions..)
will be opened on every "core" PMU before the change. The behavior now
is to just be consistent and say when no PMU is specified we always
search all PMUs. This is motivated by ARM, RISC-V, .. wanting legacy
events to be a last resort if sysfs or json encodings can't be found.

> Maybe in practice that ends up being the same as your option #4 ("if
> the PMU isn't specified with <event> then we only search core PMUs")?
> I don't know the perf code well enough to be able to say.
>
> But basically, the #1 rule in the kernel is that we do not break user
> workflows. I happen to think that that is a really important rule, and
> I'm disgusted at how many other open source projects ignore that rule
> and think that "in the name of improvement, we will break the world".

So the problem was that the world was broken. It still is. Find a
BIG.little ARM and try "perf stat -a sleep 1", the counts reported
will be for either the BIG or the little cores. BIG.little is a decade
old now.

The switch to prioritize sysfs/JSON events over legacy events was
specifically so that we wouldn't break Apple M1 and newer CPUs when
making ARM properly support BIG.little when an event is specified. I
think perf was broken over 2 kernel releases on Apple devices because
of that. I had to fix issues with Apple M1 and later while not having
access to such a machine. Frankly life would have been easier if ARM
had just fixed the driver.

> And as long as "perf" is maintained in the kernel sources, that kernel
> rule will guide perf too. Because the rule is not so much "kernels are
> special" as a "Linus wants people to be able to feel confident in
> updating".

Sure, me too. This wouldn't have been an issue if Ampere had chosen a
different event name than cycles. Often the driver writers don't test
or consider perf. For example, perf will treat PMUs with a number at
the end as being something to merge together in counts. On my laptop,
uncore_imc_free_running_0 and uncore_imc_free_running_1 were merged in
the data_read example above. ARM decided to start a new convention of
putting hex addresses as suffixes many Linux releases ago, I've sent
patches to make these encodings work like the numeric case and we may
get it landed in v6.11 (a big problem being S390 already had PMUs like
cpum_cf and cf is a valid hex suffix):
https://lore.kernel.org/lkml/20240515060114.3268149-1-irogers@google.com/

In doing that work the code was tested by IBM for S390 and by Intel,
but it was fixing an ARM created problem. ARM were the first to have
BIG.little systems but contributed nothing to the perf tool to handle
it, even though each core type has a different PMU. ARM BIG.little
remains broken with the perf tool and when I fix it for them they
don't review or test the code. ARM changed and left unworking uncore
PMU naming conventions. ARM don't fix tests for their platform. ARM
don't help make perf's tests cover their different way of naming PMUs.
No one is trying to break ARM machines, but when ARM fails to do
anything other than review their own changes in the perf tree it is
something of an inevitability.

Fwiw, I am working on making perf record, perf top, etc. skip events
on non-core PMUs when they fail to open. It is a rather large and ugly
change. It is also a holiday weekend and I'm spending a lot of my time
in it addressing latent ARM problems.

Thanks,
Ian

>            Linus
>

