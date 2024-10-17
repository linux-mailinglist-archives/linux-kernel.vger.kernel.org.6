Return-Path: <linux-kernel+bounces-368973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923DC9A1728
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DF91C2549B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499281EA85;
	Thu, 17 Oct 2024 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtT/iHxC"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033221E493
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124917; cv=none; b=aay0FZW8kN2dWgz37pafs1Q804e4HB/qfdEZL7GvuPPgLRJnzwM8Jj8bSWMUQptyMJ4eRm4NqEYLtYMT8ficfa0mz2K12l0Csc91OXKTof7R+qMkX0aq/vUZEyq9fD+/J5eGOKwvRk9+KMqu3gJFZIUyO7e2vLYyP/4vrEk+qpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124917; c=relaxed/simple;
	bh=Ij6D5mCxFViYNOZCyVBrXtjAhS5MQbJzMGYbiJbJvRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnAmgqFZMAQjDkMU2dg12HdqxazPsMe+gf/oMSgqKTiTm61m8SU4JMI1Y5kaggzVFbuR+L78ceXPjGEN+FFPT/yF1cPGLGyzHcP8uxJ7Hg6d+f+72Wm0LQPr72wNA+YvISLlgvprvJPwBaGkncL7Wq3HIt0gKCjtsFiBeDWaLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtT/iHxC; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so60185ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124915; x=1729729715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW+swacrnZ0UL3GBvERjuGakj5+j4ErZJOApHuj0ufM=;
        b=YtT/iHxCSN5Joett2rCuzbBssOxSnajyvziUe3kthxHYc6d6Ib9o0keWiBdsyhJnZp
         w+yozxN/lqC0OSBmTUFvYr3aNtEIXyAymoQ0AA6dbOmpUPay9XaYetjaoMm+EoyFLCzZ
         YZNJr3NxLmHegFZr+fLJstHe19AvZgguB9e9NSEEQ+MByKo3IriTbQ38P+TrbAQBC+QX
         Rt4pzuPglQoPUje+u9ZKhMFOta0ypM76ANhxKfYewCkoH5totwB7prJoIdm49bpgWErv
         3WZjmAdtIMm89RpufMi50W+Xa62zZGE7RThzJPMxCMxIya8yaAvMJ8aYfqXdvbaHGewV
         pCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124915; x=1729729715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW+swacrnZ0UL3GBvERjuGakj5+j4ErZJOApHuj0ufM=;
        b=Fsrt36lWu0bK7FrHKyIsJfcgqdpJaX/prjOPmnHv++O0zV76BPFRllAzj/VpFXT/N6
         7W7Bqd+24DMAMXWgJJTuQdxujwesYTsM4+TuURa9mAuwqynKebg4dyuWMQBFG+Wkgmar
         YwASQki10F1KN2EByo/JK+l+5lFrvt6tTKvXo/UWwTsssldp18WugdpDajV0F7ZOpPmK
         e0dqR5/4yWY7qlynSxFlBCXbZTO1zzBcpGPJ5ppm1MsoOho8oiTBlR37b//RnVCWjmlp
         zLRnw+ampbs9Ne7XeH1ShsPcUTpipc9vb737GHcVpe0fABQswG8HWKN4WnQyxlpLHJgb
         sxKg==
X-Forwarded-Encrypted: i=1; AJvYcCXp4IppqBzEONR5HYOiTEZNUI7rCKfjpy/c4/pENrLmGPTGT9VMJ0QqQ+e6tALp34KUdLKZkgt1ek409Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEk5Onq8Do8RBEdKG/VPL+SRA0dwXye3F1Y9j4UgLf9ItxDkb
	EuWlFSQtbPbKtR+QB5CwSA9NkeNSnwFUX15QcBfyoPgQpUL2p54y26bv53u/DNZIfpJeEf4KEO8
	lEsgtOtrxJYgVhoIBaQQyjUScG0xH9zcTn5xM
X-Google-Smtp-Source: AGHT+IFf5pKKv6CnsP7+3IYeOqkHivPqYLICTnWPWzmH7cw51vk0QMKsEZMBZAqmZ5vTbjvIywigueV4F5q7Je6iqKs=
X-Received: by 2002:a05:6e02:1a49:b0:3a2:6d7a:73e0 with SMTP id
 e9e14a558f8ab-3a3e58ef125mr1912025ab.12.1729124914768; Wed, 16 Oct 2024
 17:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com> <ZxBQ6Z2dvxmQ9Vi0@google.com>
In-Reply-To: <ZxBQ6Z2dvxmQ9Vi0@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 17:28:21 -0700
Message-ID: <CAP-5=fUpYZWGU_vDrDekwJu-n-Dw-aymaFsbohnZtqjYG1rDRw@mail.gmail.com>
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

On Wed, Oct 16, 2024 at 4:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Oct 11, 2024 at 03:03:46PM -0700, Ian Rogers wrote:
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
> >
> > v2: Fix inaccurate remaining counts when running specific
> >     tests. Rename "remaining" to "active" to better reflect the
> >     testing behavior. Move the exclusive flag to test cases and not
> >     entire suites. Add more "(exclusive)" flags to test as
> >     suggested-by James Clark. Remove "(exclusive)" flag from test
> >     descriptions to keep the command line output more concise. Add
> >     James Clark's tested-by.
> >
> > Ian Rogers (8):
> >   tools subcmd: Add non-waitpid check_if_command_finished()
> >   perf test: Display number of active running tests
> >   perf test: Reduce scope of parallel variable
> >   perf test: Avoid list test blocking on writing to stdout
> >   perf test: Tag parallel failing shell tests with "(exclusive)"
> >   perf test: Add a signal handler around running a test
> >   perf test: Run parallel tests in two passes
> >   perf test: Make parallel testing the default
>
> Nice work!  It looks much better now.
>
> But I'm seeing more failures in parallel mode.  Maybe we want to
> keep the default serial mode for a little more.

As you say, I think we should be conservative and mark all tests that
need to serial/sequential/exclusive with the exclusive tag. If you
tell me the failing tests I can add them to 'perf test: Tag parallel
failing shell tests with "(exclusive)"' as I did for James Clark with
the ARM tests. I'd prefer we did the tagging rather than not enabling
parallel testing as otherwise I may never learn which tests fail for
people when run in parallel.

Thanks,
Ian

> >
> >  tools/lib/subcmd/run-command.c                |  33 +++
> >  tools/perf/tests/builtin-test.c               | 274 ++++++++++++------
> >  .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
> >  .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
> >  .../coresight/thread_loop_check_tid_10.sh     |   2 +-
> >  .../coresight/thread_loop_check_tid_2.sh      |   2 +-
> >  .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
> >  tools/perf/tests/shell/list.sh                |   5 +-
> >  .../tests/shell/perftool-testsuite_report.sh  |   2 +-
> >  tools/perf/tests/shell/record.sh              |   2 +-
> >  tools/perf/tests/shell/record_lbr.sh          |   2 +-
> >  tools/perf/tests/shell/record_offcpu.sh       |   2 +-
> >  tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
> >  tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
> >  .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
> >  tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
> >  tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
> >  .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
> >  tools/perf/tests/task-exit.c                  |   9 +-
> >  tools/perf/tests/tests-scripts.c              |   7 +-
> >  tools/perf/tests/tests.h                      |   9 +
> >  tools/perf/util/color.h                       |   1 +
> >  22 files changed, 258 insertions(+), 110 deletions(-)
> >
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >

