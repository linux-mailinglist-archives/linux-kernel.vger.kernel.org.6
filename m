Return-Path: <linux-kernel+bounces-337935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BDB98512C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296781F2263E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9341C132124;
	Wed, 25 Sep 2024 03:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cerTAM+Q"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4A322A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233473; cv=none; b=C7+Thz8yZcUGW7cDK9jtgAjt0l1MgYAL4NvV8CmuGdUoRbyqNDd3sByNf5YM6uIDL5NF/qIueWSKtweEplsKp3MZ7eoqEvX6XpzxjK/LccVzY1tPXpgNtnANcoI5/J1agNGcgE06fmMKXRQc6YDzErPCYEpm+JOgEhYtFnXrTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233473; c=relaxed/simple;
	bh=d9fjwCqZhOrVOY7JwIobl/3xoYisnCv4ybKxHOAGAzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ct12xzxSnYdqbNm1rHGS4qb/bAS/EqxYPu/cGwIP2PKjw2ix56MGc2CCCTCHX/4p7sE39lLht2IeZwh2fPvkINAzy4/mgJ1vCvKSaXIoaym9R+3By79WwTBGwQwvkWXj5uRCEe8REpDfQxGIB18uDqMozk9kUoBCsufmMxvwaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cerTAM+Q; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4581cec6079so141531cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727233471; x=1727838271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuiPm0Dt4Y3JNQRfEKYN1QbKtyTN0war4ihX6UvCc8c=;
        b=cerTAM+QVSpG6YGyi81VtxCwBdMko/i3+qJKXmecI+vhAAxb/0sl0VymCRM1g4Ze6S
         MaD1UssLfOVnChLbs3Lpus9J6dxF1U7hoQPMrqf0Sc5j5nMn4rGLALKWO2/fn5H8zzcu
         hmHGRaOKJDNySCYkdkmiiO8WGV9SBBunHdgIDuGDayIQBmo0mzyJIll8N4+gjSRARdMV
         G1wvK3DNIK0DSOjk5OiqKx3IPMb/APWu+6GaBMpS6kOOKzCGHL+xtoTI3Gq79qMdx2gz
         sVoghXH1mMMdnBwtme3g9Qi03cjybLN44nsFBOjfQmteYgEdRXwfbEtynikra0G39Sdw
         zUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727233471; x=1727838271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuiPm0Dt4Y3JNQRfEKYN1QbKtyTN0war4ihX6UvCc8c=;
        b=u3d6vgjP89uD28vY7NJalX76nlUF3TevJqe/FQJzMmKuFmrP8NkmpW79pKvj+x/mpg
         bym5c5/+0V2jbORnHBJCsm3n02oOfBxERAEaUkDAhlVadz2xxi9X9K8AXGdshBC6rJ+3
         byjithtNvloKlHBtjgkhjumQp3KQeeH4zuGP6WmJovhJjRLY+RW6SlfCvgkP7WaB+00l
         +OMciMLK/9z4wYA6dsZHPHc5mBJtBOAzThR4ykV5c2tGOb8oHnMH6tI1HR/oTU9wSbnq
         JclRySaK7hoC7difBsUqQXoSAhiPiLMgEifnmLw5bDEiQpLBFhWnftnKfYXP7sKNRZhT
         phIw==
X-Forwarded-Encrypted: i=1; AJvYcCX9dv03HYlc6bzgYYX0s+uu/khR1pbQvTLO/r2jSBNufGAQLsH49x/0NMjoUJuqdsdXaOFrkaSuoGESR2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2lMT3p7QSi2Dao3JzmJYwO0W2dAZYqX62FfjmSPJAnDpMGkJe
	F9x99tDwRmenSQTbDTsmdsHaB/0aD/YARUqBNwAhGXa6xIr7K363XE4MS0WDnOSke3//+QOfn2d
	lQ9S18VGfy4zs8KgrCfiiq+ycUiTYnSZnjua8
X-Google-Smtp-Source: AGHT+IEAqJVsj13voNzYZp3vvG3S8gQM1xlB/GFTp50/4EQjQuzhfxD5Njf8MPLz4LNvHS2GlB4Ds1H4RFBjit8ZFxU=
X-Received: by 2002:ac8:5781:0:b0:453:62ee:3fe with SMTP id
 d75a77b69052e-45b5f8324d3mr1002231cf.17.1727233470851; Tue, 24 Sep 2024
 20:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153843.3231451-1-howardchu95@gmail.com>
In-Reply-To: <20240807153843.3231451-1-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Sep 2024 20:04:19 -0700
Message-ID: <CAP-5=fVy4HijSq=M6QvFtHpyjw=R7XB8CsbMmFMqzJrmG9t6vg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] perf record --off-cpu: Dump off-cpu samples directly
To: Howard Chu <howardchu95@gmail.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:38=E2=80=AFAM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Changes in v4:
>  - Minimize the size of data output by perf_event_output()
>  - Keep only one off-cpu event
>  - Change off-cpu threshold's unit to microseconds
>  - Set a default off-cpu threshold
>  - Print the correct error message for the field 'embed' in perf data hea=
der

Hi Howard,

I think this all looks good. There is an outstanding comment for patch
2/9 where a definition in a later patch needs moving to patch 2/9.
There is also a comment in 3/9 where you say you will turn a "=3D" back
to an "&=3D". These seem like small things to fix, could you rebase and
post the series? Are there other outstanding issues I'm missing? I'd
quite like to see this land.

Thanks,
Ian

> Changes in v3:
>  - Add off-cpu-thresh argument
>  - Process direct off-cpu samples in post
>
> Changes in v2:
>  - Remove unnecessary comments.
>  - Rename function off_cpu_change_type to off_cpu_prepare_parse
>
> v1:
>
> As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D207323
>
> Currently, off-cpu samples are dumped when perf record is exiting. This
> results in off-cpu samples being after the regular samples. This patch
> series makes possible dumping off-cpu samples on-the-fly, directly into
> perf ring buffer. And it dispatches those samples to the correct format
> for perf.data consumers.
>
> Before:
> ```
>      migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  fff=
fffff90d2e8aa record_times+0xa ([kernel.kallsyms])
>             perf  770116 [001] 27981.041375:          1    cycles:P:  fff=
fffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
>             perf  770116 [001] 27981.041377:          1    cycles:P:  fff=
fffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
>             perf  770116 [001] 27981.041379:      51611    cycles:P:  fff=
fffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
>      migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  fff=
fffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
>      migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  fff=
fffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])
>
> sshd  708098 [000] 18446744069.414584:     286392 offcpu-time:
>             79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
>             585690935cca [unknown] (/usr/bin/sshd)
> ```
>
> After:
> ```
>             perf  774767 [003] 28178.033444:        497           cycles:=
P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
>             perf  774767 [003] 28178.033445:     399440           cycles:=
P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
>          swapper       0 [001] 28178.036639:  376650973           cycles:=
P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>          swapper       0 [003] 28178.182921:  348779378           cycles:=
P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>     blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time:
>             7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
>             7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
>             7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-=
2.0.so.0.8000.2)
>             7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.=
0.8000.2)
>             7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
>             7fff24e862d8 [unknown] ([unknown])
>
>
>     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time:
>             7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
>             7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
>             7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-=
2.0.so.0.8000.2)
>             7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.=
0.8000.2)
>             7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
>             7fff24e862d8 [unknown] ([unknown])
>
>
>          swapper       0 [000] 28178.463253:  195945410           cycles:=
P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>      dbus-broker     412 [002] 28178.464855:  376737008           cycles:=
P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
> ```
>
>
> Howard Chu (9):
>   perf evsel: Set BPF output to system-wide
>   perf record --off-cpu: Add --off-cpu-thresh
>   perf record --off-cpu: Parse offcpu-time event
>   perf record off-cpu: Dump direct off-cpu samples in BPF
>   perf record --off-cpu: Dump total off-cpu time at the end.
>   perf evsel: Delete unnecessary =3D 0
>   perf record --off-cpu: Parse BPF output embedded data
>   perf header: Add field 'embed'
>   perf test: Add direct off-cpu dumping test
>
>  tools/perf/builtin-record.c             |  26 ++++
>  tools/perf/builtin-script.c             |   5 +-
>  tools/perf/tests/builtin-test.c         |   1 +
>  tools/perf/tests/shell/record_offcpu.sh |  27 ++++
>  tools/perf/tests/tests.h                |   1 +
>  tools/perf/tests/workloads/Build        |   1 +
>  tools/perf/tests/workloads/offcpu.c     |  16 +++
>  tools/perf/util/bpf_off_cpu.c           | 176 +++++++++++++++---------
>  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 135 ++++++++++++++++++
>  tools/perf/util/evsel.c                 |  49 ++++---
>  tools/perf/util/evsel.h                 |  13 ++
>  tools/perf/util/header.c                |  12 ++
>  tools/perf/util/off_cpu.h               |  10 +-
>  tools/perf/util/record.h                |   1 +
>  tools/perf/util/session.c               |  16 ++-
>  15 files changed, 401 insertions(+), 88 deletions(-)
>  create mode 100644 tools/perf/tests/workloads/offcpu.c
>
> --
> 2.45.2
>

