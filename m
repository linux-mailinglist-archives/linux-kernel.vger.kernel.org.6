Return-Path: <linux-kernel+bounces-406802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE819C6435
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFF52822C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8591E21A6FF;
	Tue, 12 Nov 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQcviIGh"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890221A4DC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450268; cv=none; b=msv1FS4y0vsUhKmMGnCrtPdDqAvOcO3CnnNt0iVULKaVOLmlYvmLNQ6jFkYqkU+Uy/sZtdcVHjbvsnj0/Ev1Ya7st968ORgGgNMEWT1m7vJfCc22SYSyDXrSMqBWcDL/wSOQjdeO//Cpxy0FjaxS+YEUk+tfY47lhyNpiSvqGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450268; c=relaxed/simple;
	bh=/wlansXT8ic1VdGrktjv6oyEADi9JxkCX7zQgwP+2Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSCEoLMPINqZBZIFbHPhTRGtY63RQny+eKVnw5EUpfJx8J3EOyRb6jajQGdJbMJtr3lZihYmQ9hG3WWTWxwv9nfmv4MGHVftC/04g/7rW7NmJi2Jh8l3RSST4BDfeD/oBocQbx2MZJewWX3tsYaAgpUVkdTpyIHXKZ5i9DD1XV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQcviIGh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca4877690so20025ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731450266; x=1732055066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrbUWlz/10HI8HCWywPHxZR9oOzLRJKPdLGJRk3v8wY=;
        b=wQcviIGhyMH7BttYPzkOspFSDnDLhfdZR6TXRGgyTRUTuxp6ILrQir0hzaFrGR1i+3
         Hf6RiUqIRV72eZNDya/IDhaySuCC28epWyYD0nr5FBi4FdJVb4IPigYRaNH45SkJa3Av
         zGvJrkemAzmZHy6VWbeEl6xxGvNB0sEmp9spo2HI6G8llbv5aJVy/2d0piHM5bsEg8lG
         7wyPl9KxffDqx6PxQZQ8Nimli7IB7DTnpSuQd0R/fQjtbg8BPEeYjBrGq4XXNVUPJPUp
         UIUOH6ZAdaXQknS8Ar7XVmw4/n+EM//qhYULysXjDGOxWCfEXsiq/MNfFXamqo4cdRSB
         Va5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731450266; x=1732055066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrbUWlz/10HI8HCWywPHxZR9oOzLRJKPdLGJRk3v8wY=;
        b=ocl/z8gRPHhLE+aBgV11uZWlTJ2jlKZMAiU6GJjhulx9TcXe6Oikas3Wz1t3h1oatD
         texrwhIl2UeJsDHtDzzHtvCd7qoWtIqLUUg+jBur59NXann+mKKuLCWNwI+USUWgaCe7
         v1C6Y28Ycdg2Lu+l3TIVah1DpRnqqeSk/R2GlmaRiiY9a/rZEuvua2yLbRT+lGXxnvkY
         mAR/c/nIpzljNrLS4XGW2T8kFhUuWeS8goCKPyiVe4ZLUgyTbaICm6euqFouNgg5YaZs
         laO9393mTjVyXDqLeISgAMiWudH5s/H/3cMaSBtNBWA+HVMTpfxROrCQImM12ULwbE0o
         sW9g==
X-Forwarded-Encrypted: i=1; AJvYcCXYIV3s4pYR0ZSJYRTBJ/uyORO3ei1nXwXxD83YtYWM0OAAy3T3rxO0a33WsmqqMQaNJ5QNqHL/Gt05JIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgJo1zsJxM91/bNz9gdB0Uz6OXNd7gf38h9fa9qHZszmT7lE1
	yTucm0nnwCNUU9TaUrJTwb3Mucttr11684y+h4Wy5ydi9jRN8m8p5hzllYlZ92WMigeRSqv1ae1
	/cxl9v7DKg9gEziuM40u5ZHwgiLXl7dcOl6LT
X-Gm-Gg: ASbGncue0pKfYJDNhTleu8q+8Q3WRLq6JyjhDdpHYoqwxaVj/lJUAmT1x5kG/SUB6sj
	8Rs1BOrp1Mid4XjCi99a0mSoJnPYE9h4UWOTcQGN55iIy9PZa8RjI+OOwLf8HyNc=
X-Google-Smtp-Source: AGHT+IHVjOXDPek3bTfzpcjqhyl6dO+VgXJqAYZyQMTiOm5YzMnjDVAcfOTw1GP054zeGixwaVYPsd6ThcCJdKkbUoY=
X-Received: by 2002:a17:903:2449:b0:20b:81bb:4a81 with SMTP id
 d9443c01a7336-211b70725d1mr132885ad.7.1731450266232; Tue, 12 Nov 2024
 14:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com> <20241026121758.143259-4-irogers@google.com>
 <20241112195343.GA404636@e132581.arm.com>
In-Reply-To: <20241112195343.GA404636@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Nov 2024 14:24:15 -0800
Message-ID: <CAP-5=fXuyZbn3Jiq=RQaLTqybgji50Ko8jrpsinFqo+OOPBeRw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] perf record: Skip don't fail for events that don't open
To: Leo Yan <leo.yan@arm.com>
Cc: Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 11:53=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Sat, Oct 26, 2024 at 05:17:57AM -0700, Ian Rogers wrote:
> >
> > Whilst for many tools it is an expected behavior that failure to open
> > a perf event is a failure, ARM decided to name PMU events the same as
> > legacy events and then failed to rename such events on a server uncore
> > SLC PMU. As perf's default behavior when no PMU is specified is to
> > open the event on all PMUs that advertise/"have" the event, this
> > yielded failures when trying to make the priority of legacy and
> > sysfs/json events uniform - something requested by RISC-V and ARM. A
> > legacy event user on ARM hardware may find their event opened on an
> > uncore PMU which for perf record will fail. Arnaldo suggested skipping
> > such events which this patch implements. Rather than have the skipping
> > conditional on running on ARM, the skipping is done on all
> > architectures as such a fundamental behavioral difference could lead
> > to problems with tools built/depending on perf.
> >
> > An example of perf record failing to open events on x86 is:
> > ```
> > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > Error:
> > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' wh=
ich will be removed.
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) f=
or event (data_read).
> > "dmesg | grep -i perf" may provide additional information.
> >
> > Error:
> > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' wh=
ich will be removed.
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) f=
or event (data_read).
> > "dmesg | grep -i perf" may provide additional information.
> >
> > Error:
> > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be re=
moved.
> > The LLC-prefetch-read event is not supported.
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> >
> > $ perf report --stats
> > Aggregated stats:
> >                TOTAL events:      17255
> >                 MMAP events:        284  ( 1.6%)
> >                 COMM events:       1961  (11.4%)
> >                 EXIT events:          1  ( 0.0%)
> >                 FORK events:       1960  (11.4%)
> >               SAMPLE events:         87  ( 0.5%)
> >                MMAP2 events:      12836  (74.4%)
> >              KSYMBOL events:         83  ( 0.5%)
> >            BPF_EVENT events:         36  ( 0.2%)
> >       FINISHED_ROUND events:          2  ( 0.0%)
> >             ID_INDEX events:          1  ( 0.0%)
> >           THREAD_MAP events:          1  ( 0.0%)
> >              CPU_MAP events:          1  ( 0.0%)
> >            TIME_CONV events:          1  ( 0.0%)
> >        FINISHED_INIT events:          1  ( 0.0%)
> > cycles stats:
> >               SAMPLE events:         87
> > ```
>
> Thanks for James reminding me.  Tested on AVA platform:
>
> # tree /sys/bus/event_source/devices/arm_dsu_*/events
>   ...
>   /sys/bus/event_source/devices/arm_dsu_9/events
>   =E2=94=9C=E2=94=80=E2=94=80 bus_access
>   =E2=94=9C=E2=94=80=E2=94=80 bus_cycles
>   =E2=94=9C=E2=94=80=E2=94=80 cycles
>   =E2=94=9C=E2=94=80=E2=94=80 l3d_cache
>   =E2=94=9C=E2=94=80=E2=94=80 l3d_cache_allocate
>   =E2=94=9C=E2=94=80=E2=94=80 l3d_cache_refill
>   =E2=94=9C=E2=94=80=E2=94=80 l3d_cache_wb
>   =E2=94=94=E2=94=80=E2=94=80 memory_error
>
> # ./perf record -- sleep 0.1
>  Error:
>  Failure to open event 'cycles:PH' on PMU 'arm_dsu_0' which will be
>  removed.
>  cycles:PH: PMU Hardware doesn't support sampling/overflow-interrupts.
>  Try 'perf stat'
>  Error:
>  Failure to open event 'cycles:PH' on PMU 'arm_dsu_1' which will be
>  removed.
>  cycles:PH: PMU Hardware doesn't support sampling/overflow-interrupts.
>  Try 'perf stat'
>  ...
>  Error:
>  Failure to open event 'cycles:PH' on PMU 'arm_dsu_15' which will be
>  removed.
>  cycles:PH: PMU Hardware doesn't support sampling/overflow-interrupts.
>  Try 'perf stat'
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.008 MB perf.data (8 samples) ]
>
> # ./perf report --stats
>
>  Aggregated stats:
>                 TOTAL events:         67
>                  MMAP events:         40  (59.7%)
>                  COMM events:          1  ( 1.5%)
>                SAMPLE events:          8  (11.9%)
>               KSYMBOL events:          6  ( 9.0%)
>             BPF_EVENT events:          6  ( 9.0%)
>        FINISHED_ROUND events:          1  ( 1.5%)
>              ID_INDEX events:          1  ( 1.5%)
>            THREAD_MAP events:          1  ( 1.5%)
>               CPU_MAP events:          1  ( 1.5%)
>             TIME_CONV events:          1  ( 1.5%)
>         FINISHED_INIT events:          1  ( 1.5%)
>  cycles:P stats:
>                SAMPLE events:          8
>
> # ./perf stat -- sleep 0.1
>
>  Performance counter stats for 'sleep 0.1':
>
>               0.87 msec task-clock                       #    0.009 CPUs =
utilized
>                  1      context-switches                 #    1.148 K/sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 52      page-faults                      #   59.685 K/sec
>            877,835      instructions                     #    1.14  insn =
per cycle
>                                                   #    0.25  stalled cycl=
es per insn
>            772,102      cycles                           #  886.210 M/sec
>            191,914      stalled-cycles-frontend          #   24.86% front=
end cycles idle
>            219,183      stalled-cycles-backend           #   28.39% backe=
nd cycles idle
>            184,099      branches                         #  211.307 M/sec
>              8,548      branch-misses                    #    4.64% of al=
l branches
>
>        0.101623529 seconds time elapsed
>
>        0.001645000 seconds user
>        0.000000000 seconds sys
>
> Tested-by: Leo Yan <leo.yan@arm.com>

Thanks Leo! As the Tested-by makes sense only if you've applied all 4
patches, which your testing and James' testing shows you've both done,
I'll add the tags to all 4 patches. I'll do likewise with Atish,
rebase and resend the patches.

Thanks,
Ian

