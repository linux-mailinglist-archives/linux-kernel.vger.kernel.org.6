Return-Path: <linux-kernel+bounces-361883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCFC99AE6D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347741C21D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D511D1745;
	Fri, 11 Oct 2024 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hgot9SLq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7A196DB1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684247; cv=none; b=t44dNyIj/PVFN2rTQlTLlS8W/Yhzxql7UWug3svAi68Wi/FJxZDtEGIuvsvLsKtGi3nZBQ60ma+T0DvYp9p7lPE+fs8wkJ0DcAtBJPNs6509UIq+OqvaPHw6JdNnFwPYfsJCEDd+YlouiES2XVzTwfVUWfva5CHPsvpARiXC0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684247; c=relaxed/simple;
	bh=pj+tIFhO/r6lPX3jXVKvD6dGzB1WeKlzT565/6lQCtE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=fsRiRcecIBouxz5dMiQQKX3Kep16GHbNuFuyzOlOf5uGMQ5HsvvGkOw8EWIRZ4y84zHG20DCOjdNNNvnbhF0UL/rZrlULrAiLoaJ+6p1NFSUw8q4BiAs57P+nsQxBPrsr94Amqca9sBR3wOiiMmeyVDW6Ww1H42pchZU81rx5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hgot9SLq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35a643200so16843307b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728684244; x=1729289044; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/MZivQ7r1tdwpDnFtMBphLBJG9TSs0ALU4e/RPdpNw=;
        b=Hgot9SLqswZzBcz0MrE0iR6Wr33ksiHgfxUKGeee2W3oO77qyHc6W1pNBSSL/esGau
         KPdOXdR0cIU+x3ZSgMiHgVGX1mZdJRlV9/mb3hOIQGYEBMVFSfp2naytcr6xYny7TPA5
         zTE1FmEpMnLwvoHo68ta/G3Oxktw+SRJ80ecjv8kVFXMgpw0wD7qIJhA9ZkIqtLkCYUY
         JSr1gW0iCrKKGXgActuSpTPb6xkiHnbQ44yXTs4o6mLVJ3fgtdeX7ev7Bj8a3UB6F43+
         2DSVhvW6tEoD4CRj7V/9xMM9LfBV73VdjG47/0zW6J52IApmr4nbNJm/Y9FU7VOVmiFW
         h5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684244; x=1729289044;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/MZivQ7r1tdwpDnFtMBphLBJG9TSs0ALU4e/RPdpNw=;
        b=C7sp/BNz3Kkx/gJwt98cupcIhZVjV288DXn6Iisvdve7RQkRl/7lWXrk/txXoGJJzW
         lhDTjIinrvvybNS5skiqCT91t6vO62A5zKTxEF6S8PtNkKjDiaZ4DcUpj6MHu5iGp6jd
         TOqIWRm5+n8mAAomNdML6z4LH964cOBk34NG6RSde6LPfQ3gR+xxF8CYVF+JzGzbujCL
         V39rqAtgCj33SNdMDNhk+dt5DakCLx6pxt+P565JusrSCfXZduD1Krp4zWQmUrK4SFUc
         FhAll3s6Jma9OIJdUS2seGY3G4HCLfN3VFc6u738MC5ufiogV0iddpXgNr+cp5eG1Ae9
         cLhw==
X-Forwarded-Encrypted: i=1; AJvYcCVwaylrao0kHfaqJEQJ0JtCsAKDISF8B50qLX0vQaJhwBo35NEklGjXoHtPM7pTR3WvnnOlCydathp3LJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1FNBpvjQ89vjeJg4L8OdBT0gyapJZa/se+uBuCypq2T5s3MgK
	DqE9QxyJEBNTC2KzJ0L4RIjjfQHc8CpeAMvikghWBIl4gA14NrEotuhSXmGs56uYd9BMTqLFmMG
	hq/nU1A==
X-Google-Smtp-Source: AGHT+IEjdPs6yTN0q32XZWt3awRHs1FP3Tong+0smaqfivJgs8yGKw7PxPi31X3WsIaJP3Ru7bXGU8Mf4WS6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a25:5f44:0:b0:e28:8f62:e735 with SMTP id
 3f1490d57ef6-e2919d71b86mr2999276.1.1728684243824; Fri, 11 Oct 2024 15:04:03
 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:03:46 -0700
Message-Id: <20241011220354.756798-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 0/8] Run tests in parallel showing number of tests running
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

v2: Fix inaccurate remaining counts when running specific
    tests. Rename "remaining" to "active" to better reflect the
    testing behavior. Move the exclusive flag to test cases and not
    entire suites. Add more "(exclusive)" flags to test as
    suggested-by James Clark. Remove "(exclusive)" flag from test
    descriptions to keep the command line output more concise. Add
    James Clark's tested-by.

Ian Rogers (8):
  tools subcmd: Add non-waitpid check_if_command_finished()
  perf test: Display number of active running tests
  perf test: Reduce scope of parallel variable
  perf test: Avoid list test blocking on writing to stdout
  perf test: Tag parallel failing shell tests with "(exclusive)"
  perf test: Add a signal handler around running a test
  perf test: Run parallel tests in two passes
  perf test: Make parallel testing the default

 tools/lib/subcmd/run-command.c                |  33 +++
 tools/perf/tests/builtin-test.c               | 274 ++++++++++++------
 .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
 .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
 .../coresight/thread_loop_check_tid_10.sh     |   2 +-
 .../coresight/thread_loop_check_tid_2.sh      |   2 +-
 .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
 tools/perf/tests/shell/list.sh                |   5 +-
 .../tests/shell/perftool-testsuite_report.sh  |   2 +-
 tools/perf/tests/shell/record.sh              |   2 +-
 tools/perf/tests/shell/record_lbr.sh          |   2 +-
 tools/perf/tests/shell/record_offcpu.sh       |   2 +-
 tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
 tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
 .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
 tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
 .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
 tools/perf/tests/task-exit.c                  |   9 +-
 tools/perf/tests/tests-scripts.c              |   7 +-
 tools/perf/tests/tests.h                      |   9 +
 tools/perf/util/color.h                       |   1 +
 22 files changed, 258 insertions(+), 110 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


