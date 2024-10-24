Return-Path: <linux-kernel+bounces-379367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA229ADDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C839D1F22739
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF81ABEB8;
	Thu, 24 Oct 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdDMa56r"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648981A0B1A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755211; cv=none; b=EfZdpXfEnY0Iu025CRQkmDl2mm96VCQf7VnImPVhvnX5cVBCpyOupsDAWUhHSAo7k3ssy2ej6mEV3KeFioZ8Ppa6UICZzJbu9rW6qNuqzqjqZDW+bkOeCerBpWRvStM9xlunuddqYbWKqNoqbVhclJlzZ0r9ND8mDlx7I/Cmwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755211; c=relaxed/simple;
	bh=OQkhUlmEEqbXpB+pBzdQUwbOmBl0iJzWCygIQYaTCg8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=aIaa6XdmuqOc25j8MT7xaWggfufGkMYuN9ouQQrv7kN5K/tL30zsv1gG75H3JgCW+teCPZZ8tETcFiFltQ12Fopn5KlIdrD82CqBbmL/MsnuyJLiBrycemM0/W3KdXoPT1uluTtj7ng/S4Y9+4wNz9ED7nzjI8ifYt7Ap+Fu4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FdDMa56r; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2e3f8dc62cso1717780276.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755208; x=1730360008; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M77V5JZaZYSeYCOYRB0a7mZE3uzLmx3YYpmuM6s/PP8=;
        b=FdDMa56riLvMPtuOZPsB8qh8J/pyyPbaLTuhf16mejP8FkrdNa5erNeXm821kIbmwP
         cFKtBMTE1esxJcOyOQwi+yBqSg6pDJ71a+CYWTRfr7xsMAWEgKpC6OIRbSr5LqvaiLuB
         E4Dwi/LUbpHFVKVMH6PVWi36VoFyPxF2A1p8y3x1YZuCRBgDmwgyW1eeRThMTd9Tw5Bi
         /xpFbxKnFf7i1AfOnZ8xfuOqgoCH92gksiClqSrUMDZnEFzk+weloJFTagy7IWSZkldy
         576UMzscSHrh8sWAHfv7oI5b5URH5A2UQ6FBBt4t4hSzFMjHxUVvj/VtKeLT6Lc7gxyR
         MT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755208; x=1730360008;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M77V5JZaZYSeYCOYRB0a7mZE3uzLmx3YYpmuM6s/PP8=;
        b=GrOI+DuRTT5Ui5TC7Rb8J8FxMDwrJsG2rJ5w3PPmXdtSqJsrS9zaWhDLLI0R1WZZtt
         Lns4SAFNosnWW4xYfhn1shTEBSUnFP/zKNZSsaW7wc7fW5bobrhtP3zvd1wqm9MJoNqq
         PwsJjtymcLBHVAl3fIMthhOWaPace4RnP9QTju7rWlXNccFIXr4C7akvQTDqPLJiW8y/
         +8Gu1WM3Fg4QLRZkHJUzCEXrUMXdCPZLlrJDJ6z9jRQgV+JVL+gogC4sqIJ0jrDDWA9I
         YpobLgqYywtGbk6A7kWWFSKublqiS6IQJd9a40oYiFNRTJbTRJaTd0GpS4l0qx1q6VQf
         9lVw==
X-Forwarded-Encrypted: i=1; AJvYcCXmm0JXq/ccOFh07+gEpAvjBxa/X5xph8i6AlzWKgW0wRaZW4ABuvSr/EhUbVv5D3IuTmwAQQSGXDr4gB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQOAIlK94+nIf1FwS+3TL6b4DCApeGjH74vSUgGGjH2Bd5tLh
	u78BJUT+kjKa5JmVbQIgBItgjRtrlmUMm2V1OOnEKr4/U/TeB+B6Z+mcDeSUriQVPu1Hb+MoADn
	o273O4w==
X-Google-Smtp-Source: AGHT+IFX2iXZND5ZNv6DTaf/WGNs9vqFP3Y9OJNvW5URba/OF+Oua1CDf+FnSnTQOsXtRULyO26E0vGPEL9z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a05:6902:52b:b0:e2e:2c2e:277b with SMTP id
 3f1490d57ef6-e2eb86afea8mr11407276.3.1729755208334; Thu, 24 Oct 2024 00:33:28
 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:14 -0700
Message-Id: <20241024073324.1513433-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 00/10] Run tests in parallel showing number of tests running
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
 tools/perf/tests/builtin-test.c               | 405 ++++++++++++------
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
 27 files changed, 365 insertions(+), 144 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


