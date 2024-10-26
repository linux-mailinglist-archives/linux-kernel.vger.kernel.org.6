Return-Path: <linux-kernel+bounces-382940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BCF9B1542
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B167B1F229BB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 05:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615C516EBE6;
	Sat, 26 Oct 2024 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2caRAmEF"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1E143744
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729922361; cv=none; b=dbd0q7f+aEPRqMcxnhSTvmGy/M+WJxhXvB35Z55DMeQzND45cxNf7bIDf1bpXxES5b6Y7AO2gosR6UGgtCaVgtHezkr5yekZi2pAcWQxTGRESbBAQRTlVrIrYBYeBQxhlERLr9Vju7BquYOK4adTmVOAmqcFUoGELzbB3Kc77MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729922361; c=relaxed/simple;
	bh=DVgHonOP+qfVOVSsnuUg3JoDMBINKVJR1WySMZ0Eg/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHbvZ9jJOptjDYO7Y42JI+AV/dANjmdb5cQ816ZHzSXuce0uEG8PMxg8bKp17UOqwwsVL6n8qgDr+pqWTKZ0aiWblh+qOOOKxDE+ftle8kGnKRMK0+mMKO3Hs/3n1H1ocE2kl++FRaHdMjpSnkx2K9Kflqk1aeX3b9lJnjjE6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2caRAmEF; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460969c49f2so92671cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729922358; x=1730527158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=farf8J6dOdw5+yAhG38R11UamjSyENjAYgToeiwkxvQ=;
        b=2caRAmEFIBX+Q52PG6M57faDN7YQAY1xVi0vzqYjkmpyB4z4M6Da/rY57wgoS2N672
         Sko09wYwDUpi8LPgAagYat5C8BCvlenpmf23oAnZ4eTb0fjfMKs1va9YK8ggjZfnjXeh
         ZyTYXt6dZexzXYMr0GU296eXu2BCqCduboMhv+xhyKc3vUyuntlZvYqU+CUhzYqbM8rL
         6m2DSh8Vf+R+YilANupnCiTOgxHlFgSDrxtl2QHg2pvCU1sks5LQssqD9+ks1Sb+H1Zs
         KiTip//ZDlUZAcZTaOVgn3CJOoNPCZTMrTS/PgKQkU1nWWM2lL4yEAoTzwFhL8Gz214d
         ECFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729922358; x=1730527158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=farf8J6dOdw5+yAhG38R11UamjSyENjAYgToeiwkxvQ=;
        b=A5JF+bsggzbu1qNTCOsuAfmzAPcmFSnbqGWR4ruCCSvHYyxEhENbJCxLusQhZq6E9Z
         P6+rjZb3hMXS8rGfo8XSEKbxfKSz/p9drf0Mw52zyEYYmDcvHqnOqd3aQQMYai5kytOF
         c/GpuCohc0iHw1GG8PeZjo9GJvGEm9AqnD5ogmXnp321aHxR4w40hngPYvHJVNEhJWRS
         Am3axvI3PeNODv6CIcW8szgrj9A5lylxu3CcRLtT99nBtmn5RrPZmRMQhpw5BTKwsRty
         DT2OOtuw1c8U5s6QTHRCr2pw+1h2RKs/bI66JOZYyQwqt8UUr1DDKXxWCNXNCgfs80K/
         sfKA==
X-Forwarded-Encrypted: i=1; AJvYcCV1YLcW6Pbnl/ITd7Wt47q2OVe/lj59uwcCZTqrDdnm3OziRGizulle2CPE7wAhHUcYGAU7T5Ugx8N2GFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIG+zC+f22xqrJ7h+AmdN+GSTEcB9DglmwN8XfjsB4ywvdPPj/
	SF7wYhH/mzgdgIiHGRbauhRmRorrysLfBVfiJZhhSiQA9JdiPQXEcesH7yMVKm4usGhd5oKpn3E
	HANujisXXXXG7QpoYhiZO1tXacSnN0nJbPP7U
X-Google-Smtp-Source: AGHT+IHU/w68610o/SGd+7ZazQjCpJAKA0Fd8jKwmHTKx/FrPEndGGpCFK9/8gEa763Sty5t5/Ac/AGBgfX3XJlHiRM=
X-Received: by 2002:ac8:470f:0:b0:461:4150:b833 with SMTP id
 d75a77b69052e-4614150b8f8mr296651cf.22.1729922357789; Fri, 25 Oct 2024
 22:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806220614.831914-1-irogers@google.com> <cc7d6bdf-1aeb-4179-9029-4baf50b59342@intel.com>
 <CAP-5=fVXvus+7PMO=WU+V3CnVNSboGgwS5EcPgXhJKb5MtRAWw@mail.gmail.com> <5b7b2b5e-8ed9-4180-907f-81c11e76d268@intel.com>
In-Reply-To: <5b7b2b5e-8ed9-4180-907f-81c11e76d268@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Oct 2024 22:59:06 -0700
Message-ID: <CAP-5=fXDD5ZQ0tcnyJyFzGnYxWtJmop7qu2m3ZwROYjcPSv=zg@mail.gmail.com>
Subject: Re: [PATCH v3] perf cap: Tidy up and improve capability testing
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Leo Yan <leo.yan@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:10=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 22/10/24 19:34, Ian Rogers wrote:
> > On Tue, Oct 22, 2024 at 6:56=E2=80=AFAM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 7/08/24 01:06, Ian Rogers wrote:
> >>> Remove dependence on libcap. libcap is only used to query whether a
> >>> capability is supported, which is just 1 capget system call.
> >>>
> >>> If the capget system call fails, fall back on root permission
> >>> checking. Previously if libcap fails then the permission is assumed
> >>> not present which may be pessimistic/wrong.
> >>>
> >>> Add a used_root out argument to perf_cap__capable to say whether the
> >>> fall back root check was used. This allows the correct error message,
> >>> "root" vs "users with the CAP_PERFMON or CAP_SYS_ADMIN capability", t=
o
> >>> be selected.
> >>>
> >>> Tidy uses of perf_cap__capable so that tests aren't repeated if capge=
t
> >>> isn't supported.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>
> >> I find I need to revert this.  E.g.
> >>
> >> $ install-perf.sh
> >> $ perf record -e intel_pt//k uname
> >> WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted=
,
> >> check /proc/sys/kernel/kptr_restrict and
> >> /proc/sys/kernel/perf_event_paranoid.
> >>
> >> Samples in kernel functions may not be resolved if a suitable vmlinux
> >> file is not found in the buildid cache or in the vmlinux path.
> >>
> >> Samples in kernel modules won't be resolved at all.
> >>
> >> If some relocation was applied (e.g. kexec) symbols may be misresolved
> >> even with a suitable vmlinux or kallsyms file.
> >>
> >> Couldn't record kernel reference relocation symbol
> >> Symbol resolution may be skewed if relocation was used (e.g. kexec).
> >> Check /proc/kallsyms permission or run as root.
> >> Linux
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.061 MB perf.data ]
> >> $ git revert e25ebda78e230283bf707ae3e9655270ff40a7f9
> >> Auto-merging tools/perf/Makefile.config
> >> Auto-merging tools/perf/builtin-ftrace.c
> >> Auto-merging tools/perf/util/Build
> >> Auto-merging tools/perf/util/symbol.c
> >> [master 752707588a700] Revert "perf cap: Tidy up and improve capabilit=
y
> >> testing"
> >>  7 files changed, 70 insertions(+), 73 deletions(-)
> >> $ install-perf.sh
> >> $ perf record -e intel_pt//k uname
> >> Linux
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.065 MB perf.data ]
> >
> > Sorry for this. I couldn't immediately see a code path that should
> > impact `perf record` and the reproducer works for me without the
> > revert.
>
> Sorry, I forgot to highlight that capabilities are being used
> as described here:
>
>         https://www.kernel.org/doc/html/latest/admin-guide/perf-security.=
html
>
> i.e.    # setcap "cap_perfmon,cap_sys_ptrace,cap_syslog=3Dep" perf
>         # setcap -v "cap_perfmon,cap_sys_ptrace,cap_syslog=3Dep" perf
>         perf: OK
>         # getcap perf
>         perf =3D cap_sys_ptrace,cap_syslog,cap_perfmon+ep
>
> instead of changing perf_paranoid, kptr_restrict etc

Thanks Adrian. I was able to reproduce something like the problem.
Anyway, the issue appears to be include path related, I came up with:
https://lore.kernel.org/lkml/20241026055448.312247-1-irogers@google.com/
Could you take a look and test for me. Again, sorry for the inconvenience.

Ian

> > revert. Running your command under gdb looking for calls to
> > perf_cap__capable:
> >
> > 1)
> > ```
> > #0  0x00005555557f7abe in symbol__read_kptr_restrict () at util/symbol.=
c:2429
> > #1  0x00005555557f759f in symbol__init (env=3D0x0) at util/symbol.c:252=
3
> > #2  0x00005555555e7ca3 in cmd_record (argc=3D1, argv=3D0x7fffffffe390) =
at
> > builtin-record.c:4114
> > #3  0x000055555569775f in run_builtin (p=3D0x5555560bda50
> > <commands+288>, argc=3D4,
> >    argv=3D0x7fffffffe390) at perf.c:351
> > #4  0x0000555555696e13 in handle_internal_command (argc=3D4,
> > argv=3D0x7fffffffe390) at perf.c:404
> > #5  0x000055555569762f in run_argv (argcp=3D0x7fffffffe1dc,
> > argv=3D0x7fffffffe1d0) at perf.c:448
> > #6  0x0000555555696a74 in main (argc=3D4, argv=3D0x7fffffffe390) at per=
f.c:562
> > ```
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-record.c?h=3Dperf-tools-next#n4108
> > ```
> > /*
> > * Allow aliases to facilitate the lookup of symbols for address
> > * filters. Refer to auxtrace_parse_filters().
> > */
> > symbol_conf.allow_aliases =3D true;
> >
> > symbol__init(NULL);
> > ```
> > I don't think this is the cause but it seems unfortunate we're
> > enabling symbols in perf record unconditionally.
> >
> > 2)
> > ```
> > #0  perf_cap__capable (cap=3D21, used_root=3D0x7fffffffbd87) at util/ca=
p.c:22
> > #1  0x0000555555878236 in perf_event_paranoid_check (max_level=3D-1) at
> > util/util.c:330
> > #2  0x00005555559574ba in intel_pt_recording_options
> > (itr=3D0x55555610ada0, evlist=3D0x5555560f36f0,
> >    opts=3D0x5555560b4818 <record+320>) at arch/x86/util/intel-pt.c:619
> > #3  0x00005555558a46ad in auxtrace_record__options
> > (itr=3D0x55555610ada0, evlist=3D0x5555560f36f0,
> >    opts=3D0x5555560b4818 <record+320>) at util/auxtrace.c:619
> > #4  0x00005555555e8139 in cmd_record (argc=3D1, argv=3D0x7fffffffe390) =
at
> > builtin-record.c:4206
> > #5  0x000055555569775f in run_builtin (p=3D0x5555560bda50
> > <commands+288>, argc=3D4,
> >    argv=3D0x7fffffffe390) at perf.c:351
> > #6  0x0000555555696e13 in handle_internal_command (argc=3D4,
> > argv=3D0x7fffffffe390) at perf.c:404
> > #7  0x000055555569762f in run_argv (argcp=3D0x7fffffffe1dc,
> > argv=3D0x7fffffffe1d0) at perf.c:448
> > #8  0x0000555555696a74 in main (argc=3D4, argv=3D0x7fffffffe390) at per=
f.c:562
> > ```
> > So this looks like the cause.
> >
> > Would it be possible for you to trace (strace/gdb/perf trace) what's
> > happening in perf_cap__capable? I suspect the system call capget and
> > its interpretation are the source of the problem, but I can't eyeball
> > an issue in:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/cap.c?h=3Dperf-tools-next#n53
> >
> > I'd prefer a fix to a revert but I'll leave that to others to decide.
> >
> > Thanks,
> > Ian
>

