Return-Path: <linux-kernel+bounces-382482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650649B0EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28ADD281BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B828620EA25;
	Fri, 25 Oct 2024 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4kAFwroR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E42161EF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884078; cv=none; b=aF0hn4qTbiA1QeFQ89ozbW+Jtwms9hvJQ2UXKC4K/51Mm0Um09YqJq905KQ+JLQpExIXHJwTLYvwWjSuoNPqrXf6hjFGykLCQQ2NmNNWfnAFgAo7lJoaNQAfcr2nF+Ocrfdw/9c4DSiMLITMPXLwe6/FrJzUGwsCrmA5IWIlStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884078; c=relaxed/simple;
	bh=a/TWGbFbTJx44iMbNWHvC+ORfVhj4jJLy3uVR1nphIU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=omxxhLvNEuuehn0EmyNy0JumycxCKjdDbbECiOJ5DV386pDAVFv7gaqHptqMqHbGj6P+XpPa8gVE6naZkJtiskfBJgDcrvamUPq5MwWAPV4SA+dFr3uAfFRoxl0KJnti4//F3TB4u/FXAVInTEH33MD8ZjcWkTfWlGgfMKVcWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4kAFwroR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d6713619so35595357b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884074; x=1730488874; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jxmJGIq4H32hm0DkPvECpN1AE+jYT8LlOkAl+AswmRY=;
        b=4kAFwroRJvwaGLCH75dkgDZlqhjZHhZAo9b+5EuEJlx1PgTDmka3iTv6vsCuXYZi3a
         JGV5egxe//g/nPZQW6XDXG+ePr8EZUu+ItyeS7PK/DLBfPCKgxaHKv8d7Ar8DGF59vva
         YBppNB/GN927dic9KyMy+Tq6Ov+63cnbq1Zue6I9XqqX+CIvwpen5rrU5ISfOWD9DhAT
         rxTtuveXCJ1x4qi0KRV94UQzZ7jhFQxvMCW5tSzSIxqE7e2FEmxOPt45wbax0bxZ1Ky9
         s4kaklXPQF7BUw+r4o+hBDPivVzAcrKDbe2JSiR2pyLuuD2D1fM1+ufR5KUudu8CByZk
         E6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884074; x=1730488874;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxmJGIq4H32hm0DkPvECpN1AE+jYT8LlOkAl+AswmRY=;
        b=D9UinB+GvyZIcXIvFvXz4DOhP7YRYUrYpWnjHMG7eRsx/OdooqqLmRJeUb4hOQJmql
         2+HlhJWZ1H5BSHJkjHWV2b6VrULzNdhIbDd5F13p1Nw6vmSaRpIV7cSXhlY5icztE+VG
         +nj3FP8jMeRv61luceEf8kCMLnAlhCAksgdFlCoxOkRiaMNJZAgFpu83oR7AzfoxyufY
         k0fNxmq1+0qCDFt8JJxmcGTnoPz4H5vBWTWG8DISG+kmpPiPUPUcLfyNYLTd2ixfqvOI
         Gf8HyMCgWR4RHq8gwMw3iot9lLE1CToDMR/bX00k6SqJJQWzxC68DEpffrmipIDyrZs+
         vWjw==
X-Forwarded-Encrypted: i=1; AJvYcCX40wuUilHCOfZrw+iE5eZGPcLQONVrFhF8tn4+GqtNDjp5oaaJBk7AAXb5SD9RwasupNtNxnRa5APA5ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEGckN6MmtBevKsGUDPdgzIVYXu9shoJXVhZtv1mBbtEM660H
	Isfk+iPMxnfOt7fCT0bMY+TrrtJYk4cm08iwU9skPSq50V4bXT4RB/XMnf/Lq5IS3bVL2cuopIx
	o8Ql8Bw==
X-Google-Smtp-Source: AGHT+IG60UugzYBREg+paR2N6L0qRUzYk2crmXXQBA6PUb8cKEHp+lzwKsr+m64d+LqM4aPKsO9r3xdCH+jJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:6ac6:b0:6e3:2f0b:b595 with SMTP
 id 00721157ae682-6e9d8b171afmr167647b3.5.1729884074430; Fri, 25 Oct 2024
 12:21:14 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:20:59 -0700
Message-Id: <20241025192109.132482-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 00/10] Run tests in parallel showing number of tests running
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
to read them for display. When running on a color terminal, display
the number of running tests (1 if sequential). To avoid previous
flicker, only delete and refresh the display line when it changes. An
earlier version of this code is here:
https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com/

Add a signal handler for perf tests so that unexpected signals are
displayed and test clean up is possible.

In perf test add an "exclusive" flag that causes a test to be run with
no other test. Set this flag manually for C tests and via a
"(exclusive)" in the test description for shell tests. Add the flag to
shell tests that may fail when run with other tests.

Change the perf test loop to run in two passes. For parallel
execution, the first pass runs all tests that can be run in parallel
then the 2nd runs remaining tests sequentially. This causes the
"exclusive" tests to be run last and with test numbers moderately out
of alignment.

Change the default to be to run tests in parallel. Running tests in
parallel brings the execution time down to less than half.

v5: Make width robust to signal delivery (Namhyung). Minor signal
    print message tweaks and test kill value.

v4: Add patch to sort exclusive tests last, this allows for increasing
    test numbers as requested by Namhyung.

v3: Mark additional shell tests as "(exclusive)" to avoid issues with
    shared resources suggested by Namhyung. Add dependent signal
    handler change so that kill/ctrl-C don't leave lots of processes,
    previously sent here:
    https://lore.kernel.org/lkml/20241017052137.225514-1-irogers@google.com/

v2: Fix inaccurate remaining counts when running specific
    tests. Rename "remaining" to "active" to better reflect the
    testing behavior. Move the exclusive flag to test cases and not
    entire suites. Add more "(exclusive)" flags to test as
    suggested-by James Clark. Remove "(exclusive)" flag from test
    descriptions to keep the command line output more concise. Add
    James Clark's tested-by.

Ian Rogers (10):
  tools subcmd: Add non-waitpid check_if_command_finished()
  perf test: Display number of active running tests
  perf test: Reduce scope of parallel variable
  perf test: Avoid list test blocking on writing to stdout
  perf test: Tag parallel failing shell tests with "(exclusive)"
  perf test: Add a signal handler around running a test
  perf test: Run parallel tests in two passes
  perf test: Make parallel testing the default
  perf test: Add a signal handler to kill forked child processes
  perf test: Sort tests placing exclusive tests last

 tools/lib/subcmd/run-command.c                |  33 ++
 tools/perf/tests/builtin-test.c               | 408 ++++++++++++------
 .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
 .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
 .../coresight/thread_loop_check_tid_10.sh     |   2 +-
 .../coresight/thread_loop_check_tid_2.sh      |   2 +-
 .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
 tools/perf/tests/shell/list.sh                |   5 +-
 .../tests/shell/perftool-testsuite_report.sh  |   2 +-
 tools/perf/tests/shell/probe_vfs_getname.sh   |   2 +-
 .../shell/record+script_probe_vfs_getname.sh  |   2 +-
 tools/perf/tests/shell/record.sh              |   2 +-
 tools/perf/tests/shell/record_lbr.sh          |   2 +-
 tools/perf/tests/shell/record_offcpu.sh       |   2 +-
 tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
 tools/perf/tests/shell/stat_bpf_counters.sh   |   2 +-
 tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
 .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
 tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
 tools/perf/tests/shell/test_data_symbol.sh    |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
 .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
 .../tests/shell/trace+probe_vfs_getname.sh    |   2 +-
 tools/perf/tests/task-exit.c                  |   9 +-
 tools/perf/tests/tests-scripts.c              |   7 +-
 tools/perf/tests/tests.h                      |   9 +
 tools/perf/util/color.h                       |   1 +
 27 files changed, 367 insertions(+), 145 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


