Return-Path: <linux-kernel+bounces-395349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E7E9BBCB4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2ED282330
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D82D1CB53A;
	Mon,  4 Nov 2024 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ysq6NZAj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23E1CACEE;
	Mon,  4 Nov 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743219; cv=none; b=gKVFVsVV/rdKJSjvry3RTKrUBOfo40pvxDvEoMeq+MhICWkhvfhsmy7RYPEFEMkq42Szrg9lM3ab4mscbbT+OX6bz0Ja3M8eAa3gMR04aWFR9ytWdFiQHJZB3QNGnpyKpy2YMYIxf4KJAUte7FY6jtkeD/rT3zHeR7P5g17wC/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743219; c=relaxed/simple;
	bh=F1s6u0X+Iv0mHmZbN7On6qu/JK/gHnv7NSXJRTaaqC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbGiC11SMj34ir+yyNBRyqOS3eKyetOSYAn2W1iZIolb3OltjHY6OcijHbseT7NKR70jLs+kSumvrOmhlvDfkXj77JJGbLKCL8WSF5bbtOeEg10P9ptiaCrjh+Ina23VvR1GIQNFn9HZFHSRpNUVi9e7o96+xVlKYsopDVjH6Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ysq6NZAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43283C4CECE;
	Mon,  4 Nov 2024 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730743219;
	bh=F1s6u0X+Iv0mHmZbN7On6qu/JK/gHnv7NSXJRTaaqC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ysq6NZAjesTKBIGwYPKfAtTnAi2hDUcC/VRgZlN4MFs0CtKyEa+4OTuo63HLGWmsk
	 KXd5TVBOe0nGJESkNFu1/DCIMdoICLGRfggeT8SrHll841iPdo+HNtJxGtHCQx70Eh
	 8kWISpFnMbWqGkjGgeDlsEUaY9+7A/DLlFGK5zMUm6HdxwdWaBZYWhpxt+BygiFJIW
	 O9piVZOs4NR0Nid0EEudka4B4i5pmXE2fWF/5uGyDF00lIfzSa/9G8AaOcrdxh4jB7
	 0cqefoB0y7sH2pzaqLo5BGeXcszK+B0cqqF6U+DxT435udNx/Rb03o4SwuceK/C4DL
	 GPrZUvqr0HJRw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: [PATCH 2/2] perf test: Don't build the python binding builtin test case with NO_LIBPYTHON=1
Date: Mon,  4 Nov 2024 14:59:53 -0300
Message-ID: <20241104175953.535202-3-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104175953.535202-1-acme@kernel.org>
References: <20241104175953.535202-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The python_use test suite was being built even when the python binding
that it is designed to test is not being built, fix it.

Testing this patch:

When building with NO_LIBPYTHON=1, i.e. explicitely disabling linking
against libpython and thus not building the python binding:

  $ perf check feature libpython
             libpython: [ OFF ]  # HAVE_LIBPYTHON_SUPPORT
  $ perf test "import perf"
  $

Not disabling linking with libpython, the default, that results in the
python binding being built:

  $ perf check feature libpython
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
  $ perf test "import perf"
   17: 'import perf' in python                                         : Ok
  $ perf test -vv "import perf"
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
   17: 'import perf' in python:
  --- start ---
  test child forked, pid 533419
  python usage test: "'/usr/bin/python3' -c "import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf" "
  ---- end(0) ----
   17: 'import perf' in python                                         : Ok
  $ strace -s1024 -f -e execve perf test 17
  execve("/home/acme/bin/perf", ["perf", "test", "17"], 0x7ffe04832040 /* 38 vars */) = 0
  strace: Process 533458 attached
   17: 'import perf' in python                                         : Running (1 active)
  strace: Process 533459 attached
  [pid 533459] execve("/bin/sh", ["sh", "-c", "--", "'/usr/bin/python3' -c \"import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf\" 2> /dev/null"], 0x133179a0 /* 40 vars */) = 0
  strace: Process 533460 attached
  [pid 533460] execve("/usr/bin/python3", ["/usr/bin/python3", "-c", "import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf"], 0x5566715c7280 /* 40 vars */) = 0
  [pid 533460] +++ exited with 0 +++
  [pid 533459] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=533460, si_uid=1000, si_status=0, si_utime=4 /* 0.04 s */, si_stime=2 /* 0.02 s */} ---
  [pid 533459] +++ exited with 0 +++
  [pid 533458] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=533459, si_uid=1000, si_status=0, si_utime=0, si_stime=0} ---
  [pid 533458] +++ exited with 0 +++
   17: 'import perf' in python                                         : Ok
  +++ exited with 0 +++
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          | 2 +-
 tools/perf/tests/builtin-test.c | 2 ++
 tools/perf/tests/tests.h        | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 01ed9335db4dba4e..8596616907adf244 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -20,7 +20,7 @@ perf-test-y += hists_link.o
 perf-test-y += hists_filter.o
 perf-test-y += hists_output.o
 perf-test-y += hists_cumulate.o
-perf-test-y += python-use.o
+perf-test-$(CONFIG_LIBPYTHON) += python-use.o
 perf-test-y += bp_signal.o
 perf-test-y += bp_signal_overflow.o
 perf-test-y += bp_account.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2cabaa8ad922d68..13f7b24694d1d0b0 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -79,7 +79,9 @@ static struct test_suite *generic_tests[] = {
 	&suite__syscall_openat_tp_fields,
 #endif
 	&suite__hists_link,
+#ifdef HAVE_LIBPYTHON_SUPPORT
 	&suite__python_use,
+#endif
 	&suite__bp_signal,
 	&suite__bp_signal_overflow,
 	&suite__bp_accounting,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index af284dd47e5c7855..3144c7916532825c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -99,7 +99,9 @@ DECLARE_SUITE(dso_data_cache);
 DECLARE_SUITE(dso_data_reopen);
 DECLARE_SUITE(parse_events);
 DECLARE_SUITE(hists_link);
+#ifdef HAVE_LIBPYTHON_SUPPORT
 DECLARE_SUITE(python_use);
+#endif
 DECLARE_SUITE(bp_signal);
 DECLARE_SUITE(bp_signal_overflow);
 DECLARE_SUITE(bp_accounting);
-- 
2.47.0


