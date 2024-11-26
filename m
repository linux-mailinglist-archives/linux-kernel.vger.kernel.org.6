Return-Path: <linux-kernel+bounces-421954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF39D928C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5C0281AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9398F192B77;
	Tue, 26 Nov 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+tGC2P3"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C51885B8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606611; cv=none; b=Ukz6Gd1ZgCs9F3IkQIjknrCnNSRwLZPcQkbPEADVceJ8cVivYwpVe3TdxEKB+Csqnsw9HmsUWjH+8zuGo3rO+J7jClV48HtmVFWcruVYoWkpNt6sm8oLiV5Go/895PelfNqXm/i0a6AgpmoTVpIlW+8dg6DY+nkhNTq8HcHfEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606611; c=relaxed/simple;
	bh=VDJY3yiBoVngPTWiGSiuBTfSgRR67SydmNcxaC74v+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kO/DYISZm0uMAqfi1W9J+oLsWPt1b59jHu/PZ7jGePukfNR3zhRR8WMmGxEk7kLHKAk2no2wL/pSH/fpyZYx0a++ENqsGyGRPQgQR/wFBCt3ka2INjtOyzP9yCdpLSprXSMdM7NRjhKf/jdlmon5gF6+oKn8Gnr4CPjGJ9RCF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+tGC2P3; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a762686909so77175ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 23:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732606608; x=1733211408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVFC9uTMb/mXBjKdhuqq0vzcdAkU2NQseQTYcXTHSYM=;
        b=A+tGC2P3XX2zJLSNZheGQJbYI6csporIG7PHPO/RyZDRdJ3L0W2cE859V2NHD2eJ3b
         VAu1+luGVCgWwEAfXUD6NEC/7XWhqi+PN6wiSYUoKxBQfk9QMgCVV/WdZ4SyftarZhK0
         Oi2DHbM53YORfZA5flq7/w6SYZBrRhNY6455VYf44VqLtGkb+2i92MCKjShh8fU600yR
         9HuD33o0JBkTmWgaKCbWfnQiFFkTfhOVAzxVJkT1GdB7dKX9S35RY3TJZr8j7UAmcumT
         WBzNL5PuLGyfwgGSiFvrqbmos1XCerONF2haS06kcpPb6k/Gf0pZyRthsTn/+zk0/Ozr
         XXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732606608; x=1733211408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVFC9uTMb/mXBjKdhuqq0vzcdAkU2NQseQTYcXTHSYM=;
        b=hds3PH7MuxD+8SO/d26RvplDVeiSc7llVDSAm+9UUIZqDqEvZQGETXfeQi8lMH4k6H
         fSwg+paiv0UmIoxREcH1p913/tgd8HKQozzzeXDTzyLgXM5byKlVgERvGHDAeq2LdZob
         5mQQ9nw6n8231BFe/gQLFM8znFwi/hDAmatHzb0a7WyDaDjUv40MWVi3yUrVYK9VjzVe
         FX4Ib22w2eyFdYRzKqOFJmfovsKeY2l1jjBQjCfl23qv2r69S7VTrbQoyMAOng/D7ifT
         t6TckkYbRssvWpl3HOXkHJK1IKHnGRN9S5eb+dQ7GxO8pmJT8xugWRrKKdm+QZtY36Yc
         2VBA==
X-Forwarded-Encrypted: i=1; AJvYcCUbGEx5X0Vo1y9Qu6AqOr9T+qV1EM/+xM1/mJ5wVHMz8gxr8rZKkjBE3Eq49MKb5AXOht4gAqq+JeAPRJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6b1N9/LbJQ2CAjjbtJ2R5DCEZjBBUky59vKhZHh05BxgR2WI
	5G/ASMF7+JrXT3HLvg+F1nrqmp0eeGDVbJFlTJ9G+oLnMPp5UWqsa3yiN9ZK7NUbpXJRde+bdHq
	WnJrHRtc3FLkYxbW7mPfbEbb+DchBT0wvQ2eB
X-Gm-Gg: ASbGncvQvD1qDtoCWrr0raHcvzIImw0Yoj6voZ99ZfML70OYF/NWsY0zvBeLfL4dUTc
	y4W/y+6qr4eOVx1T2CZOnC8DVdegGuQ/r
X-Google-Smtp-Source: AGHT+IETG6EvOsQk4OsyusLSXZglVPtp2o04gIj+f6Xoc2Bd630fTt4oLaGmuyPBgxp2eti6gO1zZDqu6WbHjJaLUoc=
X-Received: by 2002:a05:6e02:3047:b0:3a7:a929:9e62 with SMTP id
 e9e14a558f8ab-3a7bd86649emr1862305ab.21.1732606608408; Mon, 25 Nov 2024
 23:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125071653.1350621-1-namhyung@kernel.org> <Z0TK9aqrQO1PremH@sashalap>
 <Z0U4Dk_W30x4JSXG@google.com>
In-Reply-To: <Z0U4Dk_W30x4JSXG@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Nov 2024 23:36:37 -0800
Message-ID: <CAP-5=fVE4VTtB23CHF2rSwm=0RM4Y=iVEJJYiYD9OLJLQQfaVg@mail.gmail.com>
Subject: Re: [GIT PULL] perf-tools changes for v6.13
To: Namhyung Kim <namhyung@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 6:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Mon, Nov 25, 2024 at 02:07:33PM -0500, Sasha Levin wrote:
> > On Sun, Nov 24, 2024 at 11:16:53PM -0800, Namhyung Kim wrote:
> > > Hi Linus,
> > >
> > > Please consider pulling the following changes in perf tools for v6.13=
.
> > >
> > > Thanks,
> > > Namhyung
> > >
> > >
> > > The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae4=
5bf230:
> > >
> > >  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)
> > >
> > > are available in the Git repository at:
> > >
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git ta=
gs/perf-tools-for-v6.13-2024-11-24
> >
> > Hey Namhyung,
> >
> > After merging this PR into linus-next, the "Simple expression parser"
> > test has started failing:
> >
> > --- start ---
> > test child forked, pid 292
> > Using CPUID GenuineIntel-6-1A-3
> > division by zero
> > syntax error
> > Failed to find TSC frequency in /proc/cpuinfo
> > FAILED tests/expr.c:250 #system_tsc_freq > 0
> > ---- end(-1) ----
> >   7: Simple expression parser                         : FAILED!
> >
> > Here's a full log of the run: https://qa-reports.linaro.org/lkft/sashal=
-linus-next/build/v6.11-24716-gab16e9af2ff9/testrun/26045681/suite/perf/tes=
t/_7_Simple_expression_parser/log
>
> Thanks for the report, I'll take a look.

I suspect this is a side effect of the tool PMU refactoring where the
expr double values were changed to u64 counter like values:
https://lore.kernel.org/lkml/20241002032016.333748-8-irogers@google.com/

The CPU model matches nehalemep:
```
$ python tools/perf/pmu-events/models.py x86  GenuineIntel-6-1A-3
tools/perf/pmu-events/arch/
nehalemep
```
so the tsc frequency should be determined via /proc/cpuinfo looking
for  "model name ... @ %lfGHz":
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/util/tsc.c?h=3Dperf-tools-next#n44

The logs make the machine look like an emulator (reference to bochs)
so I wonder if the cpuinfo is incorrect. Why the switch from double to
u64 would show this problem I'm not sure, perhaps a latent bug was
exposed in the test as previously NaN would be returned which does
interesting things with comparisons. The test is expecting on an Intel
x86 it should be able to compute the TSC frequency and assuming the
cpuinfo is lacking the "@ ...GHz" then the test could be working as
intended.

Thanks,
Ian

