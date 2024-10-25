Return-Path: <linux-kernel+bounces-382271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7D59B0BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B46D285EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7981A20EA29;
	Fri, 25 Oct 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNCouuqQ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F120EA27
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877323; cv=none; b=u2TIeksJoy+hD6hKuIIrlWDDHmvXvblSoJ4kUwctu+/bNVMiTF7UXp96ILhhqfM9Gvxn6lfIus1LZ0RfE3Ssgq/Hi2b+50dPF5jz473cHUzfjsQ4JvpnRjScuo93xQDpmva4ZYmXMR1RqA0UqPkRtcCYQ4b20HcL5dUdf7aSuxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877323; c=relaxed/simple;
	bh=EadSvH1nCXNnbUFXESWMZhX4lkiwkNOvhx8zRKJnB6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eje+1lO2zzM/zU+DSIyv6IS9pzjwUUeh6K+6j8RQoMQhHt8BKVhI/b0/CJQND3JUdn7nsAkWvft9jjC5Min9eAy7Lqrm36YHQ62Uj8rl59aKyx0ef0IU/9XiRxZ7yw+485PxNqUCYgq9fWgyxeDjNHBhjDcMJc+234wrPZ+waKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNCouuqQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca4877690so8745ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729877320; x=1730482120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NERe5BmqqG7td09PWa0YFbRH/pOHK/E81Gszzf1NSQY=;
        b=hNCouuqQ1PJXnoG0gIaCWoXTCo9EF9mM4JaEq6mNYBVIbLkOHvLLAgQ0bLT2I8kVgb
         r/R17d0TgShMWBxPNz43SPahReRbPUWZiJfMb0/fdD6cDZ4T5ZvIERYtTf0FiXNjgF5N
         E6hk6NTZLEyyX9ZM2Xp63+y699bfs9jxSxNRUKy8O+n1g9o3FalncrNB5KXDjL4Vsn8e
         aqPecwydd0UyFHXUJA5DGvcZHgfdSt9IjfBRKLW2fegANV+wzhjOQ5U+2ipXmPmwqy2G
         fZZ+Ha/nLgdJVnwk2YgoUEDGY3lwP9QSItV/yn7VrGJ+hnT29YnbitbqRRWFpFIwuDMI
         RD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729877320; x=1730482120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NERe5BmqqG7td09PWa0YFbRH/pOHK/E81Gszzf1NSQY=;
        b=i/EypqdeQjv7xwNDj4DYOl6saGVXzoouYsVVi386to8LHrbtPIJaY1v0c+tuvcJIJY
         bWpJ49Groz4mRxuoKBpnKtsvYRbwFBx09ZRSHsqslBqWPQVQyA6+vOeNFvhWiMDU0Yft
         MhdZAZrNNxc2Ug8jDp8R6n0qvPuRpigvdqEiArc+QZbi5Po9j0aO2WF6XZD3B+h8a1nZ
         o4/DzXtlrGJ/1Mg+Zm7C2jPPf+tSd/WlRJ7p5MHlotJhw/k6+aTAa+tDxVslwG1FpK57
         0Dfx6lC+QhPijgtt+y6JBVBiJvlFiDEw3wcqaHMxNkDDL640idT08om30i9mSdagODlo
         RiCw==
X-Forwarded-Encrypted: i=1; AJvYcCUz0NspZz8NL6dtEaJJgSh26llKb6F5i1T6c6R4CSrDGIBLWTUWTNuupaUCnOfIKbo/JVfY5RvYJvNHbow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVrT0h8FDggWKWvprWQ4EkhY5zHUApTjmvQPtBJtl8odBPyMbm
	vZOAw3mwcZe2Gz8rozT3AYjvc6u9WIrb358hDPiE/LIG7K+9mDO9isoRLBSlKDXm10WalNa7+F5
	6HJ9tI9ifOrNuLK2fbDg3cMHBXhh02BwXzqyx
X-Google-Smtp-Source: AGHT+IGlD/+0J6Xli2Vr61sE6IQaLWKzjV9LwIKjci0mblIVO4/qT00wWXFWVtb8GoDPACyeDllhujorEPXAPYYZejY=
X-Received: by 2002:a17:903:2281:b0:20b:13a8:9f86 with SMTP id
 d9443c01a7336-20fc221aa04mr3066645ad.28.1729877319825; Fri, 25 Oct 2024
 10:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com> <ZxvLW-DMFcM9_K71@google.com>
In-Reply-To: <ZxvLW-DMFcM9_K71@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Oct 2024 10:28:25 -0700
Message-ID: <CAP-5=fU1t_88L5-+JXnvn7DuFU4maXz06sz5ncnmh-71P7PMsg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Run tests in parallel showing number of tests running
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:46=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Thu, Oct 24, 2024 at 12:33:14AM -0700, Ian Rogers wrote:
> > Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
> > to read them for display. When running on a color terminal, display
> > the number of running tests (1 if sequential). To avoid previous
> > flicker, only delete and refresh the display line when it changes. An
> > earlier version of this code is here:
> > https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com=
/
> >
> > Add a signal handler for perf tests so that unexpected signals are
> > displayed and test clean up is possible.
> >
> > In perf test add an "exclusive" flag that causes a test to be run with
> > no other test. Set this flag manually for C tests and via a
> > "(exclusive)" in the test description for shell tests. Add the flag to
> > shell tests that may fail when run with other tests.
> >
> > Change the perf test loop to run in two passes. For parallel
> > execution, the first pass runs all tests that can be run in parallel
> > then the 2nd runs remaining tests sequentially. This causes the
> > "exclusive" tests to be run last and with test numbers moderately out
> > of alignment.
> >
> > Change the default to be to run tests in parallel. Running tests in
> > parallel brings the execution time down to less than half.
>
> Thanks for the update, but I got a build error for this version.
>
>   tests/builtin-test.c: In function '__cmd_test':
>   tests/builtin-test.c:479:6: error: variable 'width' might be clobbered =
by 'longjmp' or 'vfork' [-Werror=3Dclobbered]
>     int width =3D 0;
>         ^~~~~

The error is legit but I can't reproduce it with gcc or clang. Making
the variable static should resolve the issue so I'll post v5 with
this. I can't confirm the error is gone.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > v4: Add patch to sort exclusive tests last, this allows for increasing
> >     test numbers as requested by Namhyung.
> >
> > v3: Mark additional shell tests as "(exclusive)" to avoid issues with
> >     shared resources suggested by Namhyung. Add dependent signal
> >     handler change so that kill/ctrl-C don't leave lots of processes,
> >     previously sent here:
> >     https://lore.kernel.org/lkml/20241017052137.225514-1-irogers@google=
.com/
> >
> > v2: Fix inaccurate remaining counts when running specific
> >     tests. Rename "remaining" to "active" to better reflect the
> >     testing behavior. Move the exclusive flag to test cases and not
> >     entire suites. Add more "(exclusive)" flags to test as
> >     suggested-by James Clark. Remove "(exclusive)" flag from test
> >     descriptions to keep the command line output more concise. Add
> >     James Clark's tested-by.
> >
> > Ian Rogers (10):
> >   tools subcmd: Add non-waitpid check_if_command_finished()
> >   perf test: Display number of active running tests
> >   perf test: Reduce scope of parallel variable
> >   perf test: Avoid list test blocking on writing to stdout
> >   perf test: Tag parallel failing shell tests with "(exclusive)"
> >   perf test: Add a signal handler around running a test
> >   perf test: Run parallel tests in two passes
> >   perf test: Make parallel testing the default
> >   perf test: Add a signal handler to kill forked child processes
> >   perf test: Sort tests placing exclusive tests last
> >
> >  tools/lib/subcmd/run-command.c                |  33 ++
> >  tools/perf/tests/builtin-test.c               | 405 ++++++++++++------
> >  .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
> >  .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
> >  .../coresight/thread_loop_check_tid_10.sh     |   2 +-
> >  .../coresight/thread_loop_check_tid_2.sh      |   2 +-
> >  .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
> >  tools/perf/tests/shell/list.sh                |   5 +-
> >  .../tests/shell/perftool-testsuite_report.sh  |   2 +-
> >  tools/perf/tests/shell/probe_vfs_getname.sh   |   2 +-
> >  .../shell/record+script_probe_vfs_getname.sh  |   2 +-
> >  tools/perf/tests/shell/record.sh              |   2 +-
> >  tools/perf/tests/shell/record_lbr.sh          |   2 +-
> >  tools/perf/tests/shell/record_offcpu.sh       |   2 +-
> >  tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
> >  tools/perf/tests/shell/stat_bpf_counters.sh   |   2 +-
> >  tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
> >  .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
> >  tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
> >  tools/perf/tests/shell/test_data_symbol.sh    |   2 +-
> >  tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
> >  .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
> >  .../tests/shell/trace+probe_vfs_getname.sh    |   2 +-
> >  tools/perf/tests/task-exit.c                  |   9 +-
> >  tools/perf/tests/tests-scripts.c              |   7 +-
> >  tools/perf/tests/tests.h                      |   9 +
> >  tools/perf/util/color.h                       |   1 +
> >  27 files changed, 365 insertions(+), 144 deletions(-)
> >
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >

