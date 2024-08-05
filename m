Return-Path: <linux-kernel+bounces-274226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759B794755E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27D4281D74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A185C1487EA;
	Mon,  5 Aug 2024 06:39:33 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C011E4B2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839973; cv=none; b=Te1ySB825zlUY+lhmUFNSPwS4bl2kLajBulBcbJyAdWRGu8ewBTej/OqLHiJ9ZIF6TaluSt03qO7vMjdmPVjPnu+uZvBAaGkXSqn3WpKjVkOnuPoGbG9wEnkaQrhLL6jIte5nNBb9KVrKkiODJmz5OUFItbz2/bG2kbEuODqUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839973; c=relaxed/simple;
	bh=cdRrs5yc6c21ZMzQZvPXTWcgHdLmJGZoCYuH45cpuzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCQC7YbaGgOk1RUycnJrFtb8OAeH7kdhjy9O7LGlMnNBELL+etQhL4tZ4pi2x9X6ryV8BHEBbHq+vJyXmHZp9vc3z/Wawf6D49WSihq2gpEhjtYKmljzSjlDSio05y3s9WuprulSlD6wvRPZuF+mcu8ZtssxIV113OJrVbXO0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc4fccdd78so73592875ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 23:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722839970; x=1723444770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrYD9KOq2yyLTMqqJLUDEunSl1H8gAaGV5fWpykY4WQ=;
        b=GM4cgTSeIaLyP+++9+zWOEOZYT7bAnGuAXFoUKgz5nignIkdLZozO7DVY5NKVtH0VP
         u6GFtmbwUFyP4c/KbTeQ8zDMyScw6h+Fm3bSCnAoacVCQEI5Snf5ylm5E8d6RKGpm3Z+
         0IPfGS1R0xYr0riCWMYSCFjlVL5rvfoIoUlpr7OOUeyyrhRYJ79QcNapnBZRnOHZonjB
         ZPO1HkxHfLlBF8qduIwN7hYOZcDzOpJq3WGuOvEHvp2WdPfqkcbgCIy9ER2ZMLlAtgOD
         XtGTFY5Qbc9AsadFIa5QZNE1GBjtTSz/ONN3zqNhJy3TWZfrvdK6k/EXwyqXxdxF1yf7
         N5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp9tMFMtyJGa6y/a+FC+fsgUmEa1WlNqP1R7x+vLuwNXEijeDTvOjsCeMWOuR7Lt9rd35HYXS36X8qoD1S7nd8uu8ta9fNTHtcgtKe
X-Gm-Message-State: AOJu0YxtMYcPIAgT/geb57F2AYd91kU5PzUVw3tybSrGyhp7LckZ8GKL
	clg1D76N8kzOzDGcxIL/Jqu6r/UkV+yhXNBEEAOpE+PRRIrm3s7ONdVkBfBZbZq9QPrRxOicEE7
	JOZTLAnIk9ftxuOknVHswuyyhQ4o=
X-Google-Smtp-Source: AGHT+IHuvJZg0wjRnAas8Ah4s7BJ8UsYOsUN3IUdVwortPva5wfGHhwg/1kAD2uLPWAicHUyMrQwsi5m6lpFarPXF2w=
X-Received: by 2002:a17:90b:164d:b0:2c9:6f53:1f44 with SMTP id
 98e67ed59e1d1-2cff93db52amr9484719a91.3.1722839970181; Sun, 04 Aug 2024
 23:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731000607.543783-1-namhyung@kernel.org> <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240802183841.GG37996@noisy.programming.kicks-ass.net> <20240802184350.GA12673@noisy.programming.kicks-ass.net>
 <20240802185023.GB12673@noisy.programming.kicks-ass.net> <20240802191123.GC12673@noisy.programming.kicks-ass.net>
 <20240803103202.GD12673@noisy.programming.kicks-ass.net> <CAM9d7cgNZQrJk7-TnMgqvCMpkYkcpBT78Ts_5oTsAzNB9gp+_w@mail.gmail.com>
In-Reply-To: <CAM9d7cgNZQrJk7-TnMgqvCMpkYkcpBT78Ts_5oTsAzNB9gp+_w@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 4 Aug 2024 23:39:18 -0700
Message-ID: <CAM9d7ch=-cp-wxLUXf1=EizAeHMG_zneSqp0owdbKp__K0ZeCw@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 10:08=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sat, Aug 3, 2024 at 3:32=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Fri, Aug 02, 2024 at 09:11:23PM +0200, Peter Zijlstra wrote:
> >
> > > But I'll have to continue staring at this later.
> >
> > OK, I have the below, which boots and seems able to do:
> >
> >   perf stat -ae power/energy-pkg/ -- sleep 1
> >
> > and
> >
> >   perf top
> >
> > also still works, so it must be perfect, right, right?
>
> I really hope so. :)  I'll test it over the weekend.

I found a failing test about the context time - it complained about
difference in enabled vs running time of a software event.

Thanks,
Namhyung


$ perf test -v times
 46: Event times:
--- start ---
test child forked, pid 325425
Using CPUID GenuineIntel-6-55-7
...
attaching to current thread as disabled
Opening: cpu-clock:u
------------------------------------------------------------
perf_event_attr:
  type                             1 (software)
  size                             136
  config                           0 (PERF_COUNT_SW_CPU_CLOCK)
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  exclude_kernel                   1
  exclude_hv                       1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 325425  cpu -1  group_fd -1  flags 0x8 =3D 3
  FAILED: ena 1026, run 881

attaching to CPU 0 as enabled
Opening: cpu-clock:u
------------------------------------------------------------
perf_event_attr:
  type                             1 (software)
  size                             136
  config                           0 (PERF_COUNT_SW_CPU_CLOCK)
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  exclude_kernel                   1
  exclude_hv                       1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 3
  FAILED: ena 6554, run 6079
...

