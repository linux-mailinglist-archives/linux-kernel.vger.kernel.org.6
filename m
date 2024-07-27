Return-Path: <linux-kernel+bounces-266159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1193FBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B59D1F21B91
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFD818A951;
	Mon, 29 Jul 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mJyZycx+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34F189F32
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271581; cv=none; b=sL431RN3rI6M384Kejh/o6LKuCq2Na4J2Pia8/bIC1n+PFzsMK8JGS+ALyMRlMHyOldp5JhPfR9rmannNcx7DrAsdzbSewDLK8uD9juSHF30GEc1own47A84jqeAD/XwRD4dV4WqLR1RJY9NYxPe6/ncL+1UlrkoA/JrEGDtiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271581; c=relaxed/simple;
	bh=DcCALxIHVCUK+9WrmJFTXpoeJxfw9pHG1sO9q8SD+00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5kPdVgx1gj3gMNujzJovfMrU76KVX2OiF8OtXAp9OtpmE2hvSA1QYeKYRNZy7/7dzAIcwV+LjSXEz2XYFl8aaCOuCVbigNgC7UPZiiZS6CmM4PH7zE6rHHNOxX3fiVwbJ4nDk4v/TFRJU3xSSWgjYRiF9km909fHCnCG3EO8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mJyZycx+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd9e6189d5so23481165ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271578; x=1722876378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esv+2bQw0aEMT9KM4UokUyH6FGgrDkyBUaVhFoJhC+U=;
        b=mJyZycx+hMEodAzZe9rbUdYqULnRVrcPJN0Y0oBMluGhX7EROrWyv/Rj7aqLnRorml
         tRmoyulT9QlLciumW9EVqeQYxBg3Um/woe6WrkyZ4iEUL54YvinHk0wN+WwCriZGELGI
         y2x4Xvi4Dee0ICkK6yDO6GB9/RTItdpsLn6jVhn410NJEhfkw7HpFLFqYckGaMBN7uLl
         7ILn1M5v0bgPftZD3RkuEV4G9R5Hck6JLLnSDcq22USvZ5Gg4adW40pVXpTFi/3L/xuW
         XtNzQNrqHI1EU3YrocfJLmOkGjjvi0vOY09xEAkzjh/bIJf9lZL9w8U7EhHVBH0WpaG+
         8iBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271578; x=1722876378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esv+2bQw0aEMT9KM4UokUyH6FGgrDkyBUaVhFoJhC+U=;
        b=Kmo+wm1ChZqEJbRcTTzxzbZwlm6iQ4T7IxJ0KOrwbJB2Ut407M5VWdHlU28umV9m+e
         I4DVI89esVw/wszFuVCp5fNqV8Q8dWyoWZ+f1Ttb5hOBpRofHngubRrhDLFHI/jUzrfM
         EQ1cpyuprryUU84aj8bmRZFKCr7edSrqmO9Vx0429EVrKI2FmRZSOrFlRr9ibKRPj8XW
         AED+mJYXZS6q6b9BFoqrrmhYJ4c25pZl7Ve+UPfbYGuStEppw5sLimv7YrhMrDRjtufT
         kNe1Jfn2Av6BZl0MXNn9uBI414oOLu4PhJyIHMSrtKLHed+bYTovfv01hbiQ2nWJX5dh
         jyYw==
X-Forwarded-Encrypted: i=1; AJvYcCX/L4wvwMrFLV2rugzsDN3ffYmwKjH9usz09TOxkVHjdSxhRb+qfKP7DTzZsT4WER2RBX2hPhqgDpPdeoGABBcOw+FDp0k2etNEWiAZ
X-Gm-Message-State: AOJu0YzWgF11WJccMMzurDXhUY5g45lPjbCNVkyuwBXeN+8MHG/F+8Tk
	1anS4CIoo9dZdN6LKLCkiEMYsUJM198CoJ9eAqpniLOB/i4TOZ0g0sw9vlbF2Wl83+yN+Uaq6f9
	a
X-Google-Smtp-Source: AGHT+IFSQceV8kL40vzasoKkWICuL+b5k2ukcYwrsTHg9WGugoQ3cfB1FuG9VUzxm2y6klGdQ4UbgQ==
X-Received: by 2002:a17:902:ecd1:b0:1fd:a412:5ded with SMTP id d9443c01a7336-1ff0482c4b4mr61845635ad.26.1722271578209;
        Mon, 29 Jul 2024 09:46:18 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:17 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Jul 2024 22:29:37 -0700
Subject: [PATCH v2 7/8] libperf test: Add test_stat_overflow()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-overflow_check_libperf-v2-7-7d154dcf6bea@rivosinc.com>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
In-Reply-To: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=6608;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=A//Q40WQ+t6MAB7Qrx+4soh8s9dOFzIWFwFxUkcU1xQ=;
 b=+cUdR4bb9FAKj9f/4IUP2R/tUuPZM+LqB0IMO5aNFMPM4mX7d13LQVKXc6rmVNnaFYgiGulWk
 PlzGGTIQ9umDJIit7xHV/tS7FtHPUUN0OsO1VqzI/T/ntOXJ8jerbFS
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Added overflow test using refresh and period.

Confirmation
 - That the overflow occurs the number of times specified by
   perf_evse__refresh()
 - That the period can be updated by perf_evsel__period()

Committer testing:

  $ sudo make tests -C ./tools/lib/perf V=1
  make: Entering directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=. obj=libperf
  make -C /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/api/ O= libapi.a
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./fd obj=libapi
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./fs obj=libapi
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=. obj=tests
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./tests obj=tests
  running static:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...

  <SNIP>

  OK
  - running tests/test-evsel.c...

  <SNIP>

          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...

  <SNIP>

  OK
  - running tests/test-evsel.c...

  <SNIP>

          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
  OK
  make: Leaving directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/tests/test-evsel.c | 107 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 545ec3150546..b27dd65f2ec9 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -1,7 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <fcntl.h>
 #include <linux/perf_event.h>
 #include <linux/kernel.h>
 #include <perf/cpumap.h>
@@ -11,6 +15,15 @@
 #include <internal/tests.h>
 #include "tests.h"
 
+#define WAIT_COUNT 10000000UL
+static struct signal_counts {
+	int in;
+	int hup;
+	int others;
+	int overflow;
+} sig_count;
+static struct perf_evsel *s_evsel;
+
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
@@ -349,6 +362,98 @@ static int test_stat_read_format(void)
 	return 0;
 }
 
+static void sig_handler(int signo, siginfo_t *info, void *uc)
+{
+	switch (info->si_code) {
+	case POLL_IN:
+		sig_count.in++;
+		break;
+	case POLL_HUP:
+		sig_count.hup++;
+		break;
+	default:
+		sig_count.others++;
+	}
+
+	sig_count.overflow++;
+}
+
+static int test_stat_overflow(int owner)
+{
+	static struct sigaction sig;
+	u64 period = 1000000;
+	int overflow_limit = 3;
+
+	struct perf_thread_map *threads;
+	struct perf_event_attr attr = {
+		.type           = PERF_TYPE_SOFTWARE,
+		.config         = PERF_COUNT_SW_TASK_CLOCK,
+		.sample_type    = PERF_SAMPLE_PERIOD,
+		.sample_period  = period,
+		.disabled       = 1,
+	};
+	struct perf_event_attr *tmp_attr;
+	int err = 0, i;
+
+	LIBPERF_OPTS(perf_evsel_open_opts, opts,
+		     .open_flags = PERF_FLAG_FD_CLOEXEC,
+		     .flags	 = (O_RDWR | O_NONBLOCK | O_ASYNC),
+		     .signal	 = SIGRTMIN + 1,
+		     .owner_type = owner,
+		     .sig	 = &sig);
+
+	/* setup signal handler */
+	memset(&sig, 0, sizeof(struct sigaction));
+	sig.sa_sigaction = (void *)sig_handler;
+	sig.sa_flags = SA_SIGINFO;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	s_evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", s_evsel);
+
+	err = perf_evsel__open_opts(s_evsel, NULL, threads, &opts);
+	__T("failed to open evsel", err == 0);
+
+	for (i = 0; i < 2; i++) {
+		volatile unsigned int wait_count = WAIT_COUNT;
+
+		sig_count.in = 0;
+		sig_count.hup = 0;
+		sig_count.others = 0;
+		sig_count.overflow = 0;
+
+		period = period << i;
+		err = perf_evsel__period(s_evsel, period);
+		__T("failed to period evsel", err == 0);
+
+		tmp_attr = perf_evsel__attr(s_evsel);
+		__T_VERBOSE("\tperiod = %llu\n", tmp_attr->sample_period);
+
+		err = perf_evsel__refresh(s_evsel, overflow_limit);
+		__T("failed to refresh evsel", err == 0);
+
+		while (wait_count--)
+			;
+
+		__T_VERBOSE("\toverflow limit = %d, overflow count = %d, ",
+			    overflow_limit, sig_count.overflow);
+		__T_VERBOSE("POLL_IN = %d, POLL_HUP = %d, other signal event = %d\n",
+			    sig_count.in, sig_count.hup, sig_count.others);
+
+		__T("failed to overflow count", overflow_limit == sig_count.overflow);
+	}
+
+	perf_evsel__close(s_evsel);
+	perf_evsel__delete(s_evsel);
+	perf_thread_map__put(threads);
+
+	return 0;
+}
+
 int test_evsel(int argc, char **argv)
 {
 	__T_START;
@@ -361,6 +466,8 @@ int test_evsel(int argc, char **argv)
 	test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
 	test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
 	test_stat_read_format();
+	test_stat_overflow(F_OWNER_PID);
+	test_stat_overflow(F_OWNER_TID);
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;

-- 
2.44.0


