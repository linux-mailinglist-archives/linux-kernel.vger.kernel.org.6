Return-Path: <linux-kernel+bounces-369792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD39A22BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869681F211DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BAA1DD556;
	Thu, 17 Oct 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="suUfmsIF"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FD1D8E01
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169371; cv=none; b=Iwo0mfYvYUi0NBZMtYQ0w+1AVPbuCCaDz6a0A//FD8fLwqcaByNVWcfb1C2p2nYP7djuT+f44DUN649WRKWLji2QJ0MiNxyWnOwU0pjw/sjM4ljmh8Py/c7TFf3moigNKEdj44q2qzQeQuSRFKsTxIwx9nlxYrFNl7x/1r96vpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169371; c=relaxed/simple;
	bh=lBbLP61tEiwbiAPkUbAo47H3r5vkptjMntdpv3sHhoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXqFGdRw/PmmtLMn0kfc5yuAwAdFjoMRw2uG4w2Fkxz/g4BQ9dyT0+S93uMyNTK/EkwQYYax4POlW85JYVzZZE1z9x+5b0tilxs/V61YWV0n8L4oh0b5fy4zYhjJVxfZMdqzrhxZHtAsCvlV2VuL/vmQXal6VS/5SxTav+CLLHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=suUfmsIF; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so221715ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729169366; x=1729774166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mynrk8rYLBQ5bwomhuNxZLGHdaIWzHBxjXSxu3oJxe4=;
        b=suUfmsIFKZ+NYispZQ3mp7NuvcCID8F1PpR8YnHHs360crb/XvGQ/JNEOtBRNCpJPU
         w4meDP05v/8Yj55XUTK6WiqEd76MVP3bKEksosyXoZmy3ffoXIHqgIQS/JimSIfy58Uw
         YKDgE4v1SELzNaJx9PJxE5Q9lqWiph7BNkqy/nb5HU/tfK4Vb6nBVcHUMxE0loL1u22J
         uxiM28kK5MQADhy9ODzyNfA31BeoRxiRt1RFShJaHDJSUAXLOGLIV9OsH+3+Z4LtBqIv
         W5sWPx0/zba7cmY7j88G4PrrP8WYx5S7A/oXVcpnz+12LLH3asVThTZJzwtgzQFwUrXC
         9r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729169366; x=1729774166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mynrk8rYLBQ5bwomhuNxZLGHdaIWzHBxjXSxu3oJxe4=;
        b=RUN+LiyOshsK5PCpKNAkbuGEcdeNHnwLR6sdWqgvFrLBxp8An8YUWmfXBS6RZ3HryI
         yaAEmDO8I4iHBDkq3K12zece5cVgS+JPS4PXpXj4esTBUaGYrynqEoXy9SySxgmonudS
         EACkWKhU12IJN9dxGCYUi47uy3s49App9Y0qEaOnjijWQIP5vKc+Z+TAi0w++aYi3yol
         wk1nWV0YWl6y9tNA+Y7+uaPzAD1O2i/TL1BRcr6UrcBzBZtJ83m8gezhmo24vMgVJZR3
         06MgDPuGbIrXeJEGOImTYlTiAl2ltrZnMysVqv/nF/WX0yLiaVR75w3HoNShgfWFCjWG
         fKYA==
X-Forwarded-Encrypted: i=1; AJvYcCUAqtZVq18gASGRLi0mWiq153svRtBX3VFJvre5SFyFuHrcn54JSzvFQSuM7R8jkyUXVTd5E+BcCs5iND4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRP17BM+JOGwSE66GC2tdzMZuzpK3keFnpX8EcoziUYX70DyLI
	QeF//HyBzcVPcDA9AWexVw8EPf192bavMcs3ezOQbZEMS1ezF7VMzkJ2jAUPfMyRRpqN7qOVOIN
	XpW7FRr5jvdX3f1NpyPGc65XfI+BqKmFsoBqf
X-Google-Smtp-Source: AGHT+IEwBr1vqysdl6mH5AEcslKafAZ4hsLkxyMoeW9qFJJmOQPnPYKVL9Eyt1lsc8wmydyDESpvt4BEBzzDni04qAs=
X-Received: by 2002:a05:6e02:144f:b0:3a0:9e83:21ea with SMTP id
 e9e14a558f8ab-3a3ea0249a6mr3564815ab.17.1729169366398; Thu, 17 Oct 2024
 05:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com> <ZxBQ6Z2dvxmQ9Vi0@google.com>
 <CAP-5=fUpYZWGU_vDrDekwJu-n-Dw-aymaFsbohnZtqjYG1rDRw@mail.gmail.com>
In-Reply-To: <CAP-5=fUpYZWGU_vDrDekwJu-n-Dw-aymaFsbohnZtqjYG1rDRw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Oct 2024 05:49:12 -0700
Message-ID: <CAP-5=fXaiZS3sUctP9K=h5cgaL1dFsuWbhhJFfM4=Avg+xduPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Run tests in parallel showing number of tests running
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

On Wed, Oct 16, 2024 at 5:28=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Oct 16, 2024 at 4:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Fri, Oct 11, 2024 at 03:03:46PM -0700, Ian Rogers wrote:
> > > Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
> > > to read them for display. When running on a color terminal, display
> > > the number of running tests (1 if sequential). To avoid previous
> > > flicker, only delete and refresh the display line when it changes. An
> > > earlier version of this code is here:
> > > https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.c=
om/
> > >
> > > Add a signal handler for perf tests so that unexpected signals are
> > > displayed and test clean up is possible.
> > >
> > > In perf test add an "exclusive" flag that causes a test to be run wit=
h
> > > no other test. Set this flag manually for C tests and via a
> > > "(exclusive)" in the test description for shell tests. Add the flag t=
o
> > > shell tests that may fail when run with other tests.
> > >
> > > Change the perf test loop to run in two passes. For parallel
> > > execution, the first pass runs all tests that can be run in parallel
> > > then the 2nd runs remaining tests sequentially. This causes the
> > > "exclusive" tests to be run last and with test numbers moderately out
> > > of alignment.
> > >
> > > Change the default to be to run tests in parallel. Running tests in
> > > parallel brings the execution time down to less than half.
> > >
> > > v2: Fix inaccurate remaining counts when running specific
> > >     tests. Rename "remaining" to "active" to better reflect the
> > >     testing behavior. Move the exclusive flag to test cases and not
> > >     entire suites. Add more "(exclusive)" flags to test as
> > >     suggested-by James Clark. Remove "(exclusive)" flag from test
> > >     descriptions to keep the command line output more concise. Add
> > >     James Clark's tested-by.
> > >
> > > Ian Rogers (8):
> > >   tools subcmd: Add non-waitpid check_if_command_finished()
> > >   perf test: Display number of active running tests
> > >   perf test: Reduce scope of parallel variable
> > >   perf test: Avoid list test blocking on writing to stdout
> > >   perf test: Tag parallel failing shell tests with "(exclusive)"
> > >   perf test: Add a signal handler around running a test
> > >   perf test: Run parallel tests in two passes
> > >   perf test: Make parallel testing the default
> >
> > Nice work!  It looks much better now.
> >
> > But I'm seeing more failures in parallel mode.  Maybe we want to
> > keep the default serial mode for a little more.
>
> As you say, I think we should be conservative and mark all tests that
> need to serial/sequential/exclusive with the exclusive tag. If you
> tell me the failing tests I can add them to 'perf test: Tag parallel
> failing shell tests with "(exclusive)"' as I did for James Clark with
> the ARM tests. I'd prefer we did the tagging rather than not enabling
> parallel testing as otherwise I may never learn which tests fail for
> people when run in parallel.

With repeat testing, most often for me it was fine, I was able to get
a flake on the probe plus vfs_getname tests like:
```
$ sudo /tmp/perf/perf test vfs -v
91: Add vfs_getname probe to get syscall args filenames             : Ok
--- start ---
test child forked, pid 466904
Failed to write event: File exists
 Error: Failed to add events.
---- end(-1) ----
93: Use vfs_getname probe to get syscall args filenames             : FAILE=
D!
--- start ---
test child forked, pid 466906
Error: event "vfs_getname" already exists.
Hint: Remove existing event by 'perf probe -d'
      or force duplicates by 'perf probe -f'
      or set 'force=3Dyes' in BPF source.
 Error: Failed to add events.
---- end(-1) ----
127: Check open filename arg using perf trace + vfs_getname          : FAIL=
ED!
```
So I'll make those exclusive in v2 too. If you could let me know of others.

Thanks,
Ian

> > >
> > >  tools/lib/subcmd/run-command.c                |  33 +++
> > >  tools/perf/tests/builtin-test.c               | 274 ++++++++++++----=
--
> > >  .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
> > >  .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
> > >  .../coresight/thread_loop_check_tid_10.sh     |   2 +-
> > >  .../coresight/thread_loop_check_tid_2.sh      |   2 +-
> > >  .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
> > >  tools/perf/tests/shell/list.sh                |   5 +-
> > >  .../tests/shell/perftool-testsuite_report.sh  |   2 +-
> > >  tools/perf/tests/shell/record.sh              |   2 +-
> > >  tools/perf/tests/shell/record_lbr.sh          |   2 +-
> > >  tools/perf/tests/shell/record_offcpu.sh       |   2 +-
> > >  tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
> > >  tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
> > >  .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
> > >  tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
> > >  tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
> > >  .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
> > >  tools/perf/tests/task-exit.c                  |   9 +-
> > >  tools/perf/tests/tests-scripts.c              |   7 +-
> > >  tools/perf/tests/tests.h                      |   9 +
> > >  tools/perf/util/color.h                       |   1 +
> > >  22 files changed, 258 insertions(+), 110 deletions(-)
> > >
> > > --
> > > 2.47.0.rc1.288.g06298d1525-goog
> > >

