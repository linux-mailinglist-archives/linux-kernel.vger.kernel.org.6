Return-Path: <linux-kernel+bounces-332309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 618D097B808
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C5EB27B49
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1216C687;
	Wed, 18 Sep 2024 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D675cMAS"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB2165F17
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726641518; cv=none; b=llah/QonJhEbKkdqFoyXYvuMTFC6kd3yeu0M3V0tUXbid54TQlsLW132FObS5UTxPPrrAu8CsuZ5o4YWla8TBgvotP1oiXaJdJki3rCke1ArLNKLKx/JTI2grRmLEu3PK4bCVfIc06eV7VEscQF6JbWriUPkUmamRGbpxcJHihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726641518; c=relaxed/simple;
	bh=YaDJ4xfoBXINHqTsarVwnm+r8lB7RjaDZjS+N/z7e7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiZRWK2rGY3Pvd73jJAEpsNzS4QleN4Q3vig6ftSTbyFwJfkEfRjeL4kxjTGY+hzkiWgregwgq8TKXKCzx4W4nBxrU6uhhM0N9dR7YzfIKich17MkybjsQlf14viAxEN5nyT2hYGZeotgyKYGYl0RkvOUbYmoBjeuPqwPahpYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D675cMAS; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so198895ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 23:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726641515; x=1727246315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJiTd4/FU5F7zmVIghyo4lA++ZZc6Lm3yzIVWFkh7Js=;
        b=D675cMASNgAKz26GRUSKHniDUgAyjUORN/N0G5RYJPQcnV24QIfy1l6zxY8FkIPfxp
         RvhzjS91x+EW1kBg1DEqArlImuNxvh+xEI9WmSlHkb7daoFaOk9Q16ygCNCHTUAaCwbL
         /HqlmtSOMeJmXlz/ITwq1/jw0e+zy4VHn9z76teaDWaOrpZR8A5Hd2COu1wbjFNxFZ9N
         36/yUAfYE3f7l054bmxKC0IdSI62H/ThbFCkyrHWgSIbZjeEAkhXfxtnAKRNPa+P/7Yp
         91sGEYpH7Pg7C1A4IIStiP3kchaewcMf3tRWEdPELs/1NICBtXOAnOiK52iFrdRlQGpi
         g0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726641515; x=1727246315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJiTd4/FU5F7zmVIghyo4lA++ZZc6Lm3yzIVWFkh7Js=;
        b=Q4N8KMafqbRvOcNImLPdxs0rKiuDpak1t2yPDPPcp4KlmoGYzFuPMXQwAGqyVP8HMF
         ZLV/J3s9uNiTXWmU0lA1Mecf1LqjnBdOR5hrrlVWFi6Ohcq7o4zM80b/MJT2qGFWSarB
         UCNZEHwPa5X/EC0nYabDFm90SesMbVfAXHpoz62Uv4c0K18K/P8JlZfxil8TZjWEpU3u
         1cpFj2VJu+xav8JMeimIpt3IADuB+QWegDQNWIUh21WtK7GtfzmQ7BnFqmDq70eWk+B/
         7//5cupCqlxxAoK7eiPUlEQU3LUyrWbxp9xXl3wZMKETtNWsYUNItu8RRZSkmAB5DtHo
         djsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/BaUCcFxq3a8DEHQtQEpo0AMv/+jl3AWMywB/m0RsNC8YdgGfqA7x4/t/I3ADXIaf6X+URUh7XNva7Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVhUyU75gSnoOKjDUsgQMX/ShuW1uhWnyvfsQ2rNxmTta4x8AP
	a/ecWdNsGI7tWLzognUNNfT1LWWfRV9g7BSVUdvIHUIS4ayGm0NsbzzdzMVoPxCXvNFiGZWRqt4
	9r9pHyywRQXsb2ZtJpBdC8vCvFjC2wXSyYAzx
X-Google-Smtp-Source: AGHT+IGoj+5PzB4icph7RhG3UMOr6ql1rZQwZT2T/ETh0X8uz/CU+7GUgtm1sEFw4YBQdLWnNO4Giv41j7x4BrHMvr8=
X-Received: by 2002:a05:6e02:1786:b0:3a0:9ffd:2b7a with SMTP id
 e9e14a558f8ab-3a0b9874e5bmr1646435ab.9.1726641515383; Tue, 17 Sep 2024
 23:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917222820.197594-1-namhyung@kernel.org>
In-Reply-To: <20240917222820.197594-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Sep 2024 08:38:22 +0200
Message-ID: <CAP-5=fVV9wzp7L71VJxaqzuURFtr1LAg0Qmk5uqmzs3By1Exow@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf tools: Support deferred user callchains (v2)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Indu Bhagat <indu.bhagat@oracle.com>, 
	linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 12:28=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> This is a counterpart for Josh's kernel change v2 [1] to support deferred
> user callchains.  The change is transparent and users should not notice
> anything with the deferred callchains.
>
>   $ perf record -g sleep 1
>
> I added --[no-]merge-callchains option to control output of perf script.
> You can verify it has the deferred callchains like this:
>
>   $ perf script --no-merge-callchains
>   perf     801 [000]    18.031793:          1 cycles:P:
>           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.ka=
llsyms])
>           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
>           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
>           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
>           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
>           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsym=
s])
>           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
>           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsy=
ms])
>           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
>           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
>           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
>           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
>           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
>
>   perf     801 [000]    18.031814: DEFERRED CALLCHAIN
>                   7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-g=
nu/libc.so.6)
>
>   ...
>
> When the callchain is merged (it's the default) it'd look like below:
>
>   $ perf script
>   perf     801 [000]    18.031793:          1 cycles:P:
>           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.ka=
llsyms])
>           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
>           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
>           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
>           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
>           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsym=
s])
>           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
>           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsy=
ms])
>           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
>           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
>           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
>           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
>           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
>                   7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-g=
nu/libc.so.6)
>
>   ...
>
> Notice that the last line and it has the __GI___ioctl in the same
> callchain.  It should work with other tools like perf report.

Hi Namhyung, I think this is interesting work!

The issue feels similar to leader sampling and some of the unpicking
of that we've been dealing with. With leader sampling it was added and
then the dispatch of events modified so that tools wouldn't see leader
samples, instead new events would be synthesized based on the leader
sample data. However, the leader sample event wasn't changed and so
now we have multiple repeated events and perf inject wouldn't just
pass through a perf data file.

What I'm expecting based on this description is that a deferred call
chain will be merged with a regular one, however, perf inject isn't
updated to drop the deferred callchain so now we have the deferred
callchain event twice.

My feeling is that making the dispatch of events to tools "smart" is a
false economy. Tools can add handlers for these events easily enough.
What's harder is undoing the smartness when it does things that lead
to duplicated events and the like. I'm not a fan of how leader
sampling was implemented and I still think it odd that with perf
script we see invented events when trying to just dump the contents of
a perf.data file.

Thanks,
Ian

> The code is available at 'perf/defer-callchain-v2' branch in
> https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
> [1] https://lore.kernel.org/lkml/cover.1726268190.git.jpoimboe@kernel.org
>
>
> Namhyung Kim (5):
>   perf tools: Sync UAPI perf_event.h header
>   perf tools: Minimal DEFERRED_CALLCHAIN support
>   perf record: Enable defer_callchain for user callchains
>   perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
>   perf tools: Merge deferred user callchains
>
>  tools/include/uapi/linux/perf_event.h     | 21 +++++-
>  tools/lib/perf/include/perf/event.h       |  7 ++
>  tools/perf/Documentation/perf-script.txt  |  5 ++
>  tools/perf/builtin-script.c               | 92 +++++++++++++++++++++++
>  tools/perf/util/callchain.c               | 24 ++++++
>  tools/perf/util/callchain.h               |  3 +
>  tools/perf/util/event.c                   |  1 +
>  tools/perf/util/evlist.c                  |  1 +
>  tools/perf/util/evlist.h                  |  1 +
>  tools/perf/util/evsel.c                   | 32 +++++++-
>  tools/perf/util/evsel.h                   |  1 +
>  tools/perf/util/machine.c                 |  1 +
>  tools/perf/util/perf_event_attr_fprintf.c |  1 +
>  tools/perf/util/sample.h                  |  3 +-
>  tools/perf/util/session.c                 | 78 +++++++++++++++++++
>  tools/perf/util/tool.c                    |  2 +
>  tools/perf/util/tool.h                    |  4 +-
>  17 files changed, 273 insertions(+), 4 deletions(-)
>
> --
> 2.46.0.792.g87dc391469-goog
>

