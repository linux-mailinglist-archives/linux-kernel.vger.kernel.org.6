Return-Path: <linux-kernel+bounces-314233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829DD96B04B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B8A1F25DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D980D86AE3;
	Wed,  4 Sep 2024 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rj1/F93t"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC08615A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426381; cv=none; b=X2goGJ3tPpdDnLW6efeDQMU4iw8iTtvr4I7OJNKTvphwnrbInfxO+gOJ3mPga3KC2rvuBBPG3k1Dehi8IadhQvCqK5t4xVRImsRhnHEj9QPhPpyWKJGtzOLq/UDShEJihiDGHSBKvECVJsmT1lIKeH8+G8QuiSotgWpBKGfe2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426381; c=relaxed/simple;
	bh=VbNrSurkC5nzUGb7NXBdVnuXvhVETW9clCJbcW7SRmA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M8MGSmbiU7yGi42nehkUq7uLGngFoEmLPcPXWKhRNSiCJ8FkN7bCX3ZHVjiX/OK1wSyf0B8DWOvyJejOO4wgj6iAgVg7zfpAvRBVJjrgius0iSqgXic+boS1QnfsfaTIv085APPeZ1lzylW8OOHx60SQ1vhUiw7MRl0qgKjKNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rj1/F93t; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4f52a4069so92429867b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 22:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725426378; x=1726031178; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3L6GY/PfMSCC3gu8eXS/W2rnDG3a0GQsrPiN06mruw=;
        b=Rj1/F93tD5jz+ZNcBGIHT3eYambvpDQAbyPWIK1VjAJEBtx5WKQOLHJZinbDnfemES
         9INHP1skPkvGBZ9RY1SzJXT+X3GyZC6XkxOZLQnBNVUehiZ0JTSaH/MKfjZ5qi5ZI6zW
         xKJQQ2Tvt1qmFApYA83LqAuOnGxAhT8prbYsrv4Qzq2OM5cT6EtwNV+TAOBxyfqISEf7
         6FDu/UueOAXUZolXuTIo67BAs5X5HzdbHyEZRSABBoK7yppUa7kkHtr1wgTKam4c1nhq
         j8rdagfaKPWOGe9QCNo1qrgFFZfzIr3ORwayOM7UOUrOO1cVXDObssoYc2WdFfarAxCJ
         eBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426378; x=1726031178;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3L6GY/PfMSCC3gu8eXS/W2rnDG3a0GQsrPiN06mruw=;
        b=Qsuj7k/xt4hlae6BTlPDZdmra9gLZ5ft5xzBgKl6VMLkQkVbP38ohvOtkLB3MDxOUS
         QGRt7qzrtoT3Mi6kPLYdqwC3i4E97FPWnJ44sJy2+zOOqKmMRXwbWtWz4LSByPD/2Ztb
         LL3bTh1JDW2w5J5Y4AAbK0xIsKQCKQNseGYtocbvF5dGLkT82YxgDxg2NaAWKnJLBxQV
         jCNYQ6xfoG8xSJ9kRjrvT95mqzMsaVlrwbhwgyJxVST2MiJWwOGhwS6l3TYSBEnt/tS0
         j6hXm35b61eqCaBA0LLAx+Fnjtm/BqsN+/ixh5kNDWTDsaB3H/crtHQmfc0q1/fOZoYs
         BS/w==
X-Forwarded-Encrypted: i=1; AJvYcCXJt188n/epGrnkQCOd5x60Wg08LJpZxgEjzCC0HCukKOmPcdCl5Uy51qm8pyv0XiB9hAArapAasfeXnuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzWOo/6ybfuJBVkNvDaCLKqsiizDSvmJamsJR7aK/aEHyTiNYs
	uct4MzT+bwxTKpggOIoGKgEEUsDklcXqYeJdpU+lzhT/HhNjRETLPWsSgRZtFnKXfZRzI3yHPvp
	tN1jZuw==
X-Google-Smtp-Source: AGHT+IE1mkmO0Uy4xte6nu6JFO/gz07tnmiUACW3Tsyw3ZNvbTNs+fQfqdlYpyc+9bvXRlhbPM7zFwiJfSeS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c48b:5e3:a63c:2d09])
 (user=irogers job=sendgmr) by 2002:a25:b28a:0:b0:e1d:2e2:f6fe with SMTP id
 3f1490d57ef6-e1d02e2f8dfmr11379276.11.1725426378583; Tue, 03 Sep 2024
 22:06:18 -0700 (PDT)
Date: Tue,  3 Sep 2024 22:06:04 -0700
In-Reply-To: <20240904050606.752788-1-irogers@google.com>
Message-Id: <20240904050606.752788-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904050606.752788-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v2 4/6] perf parse-events: Add default_breakpoint_len helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The default breakpoint length is "sizeof(long)" however this is
incorrect on platforms like Aarch64 where sizeof(long) is 8 but the
breakpoint length is 4. Add a helper function that can be used to
determine the correct breakpoint length, in this change it just
returns the existing default sizeof(long) value.

Use the helper in the bp_account test so that, when modifying the
event from a watchpoint to a breakpoint, the breakpoint length is
appropriate for the architecture and not just sizeof(long).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/bp_account.c         | 4 +++-
 tools/perf/tests/bp_signal.c          | 3 ++-
 tools/perf/tests/bp_signal_overflow.c | 3 ++-
 tools/perf/tests/parse-events.c       | 3 ++-
 tools/perf/util/parse-events.c        | 7 ++++++-
 tools/perf/util/parse-events.h        | 2 ++
 6 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 6f921db33cf9..4cb7d486b5c1 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -16,6 +16,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "event.h"
+#include "parse-events.h"
 #include "../perf-sys.h"
 #include "cloexec.h"
 
@@ -50,7 +51,7 @@ static int __event(bool is_x, void *addr, struct perf_event_attr *attr)
 	attr->config = 0;
 	attr->bp_type = is_x ? HW_BREAKPOINT_X : HW_BREAKPOINT_W;
 	attr->bp_addr = (unsigned long) addr;
-	attr->bp_len = sizeof(long);
+	attr->bp_len = is_x ? default_breakpoint_len() : sizeof(long);
 
 	attr->sample_period = 1;
 	attr->sample_type = PERF_SAMPLE_IP;
@@ -92,6 +93,7 @@ static int bp_accounting(int wp_cnt, int share)
 	attr_mod = attr;
 	attr_mod.bp_type = HW_BREAKPOINT_X;
 	attr_mod.bp_addr = (unsigned long) test_function;
+	attr_mod.bp_len = default_breakpoint_len();
 
 	ret = ioctl(fd[0], PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &attr_mod);
 	TEST_ASSERT_VAL("failed to modify wp\n", ret == 0);
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 1f2908f02389..3faeb5b6fe0b 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -26,6 +26,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "event.h"
+#include "parse-events.h"
 #include "perf-sys.h"
 #include "cloexec.h"
 
@@ -111,7 +112,7 @@ static int __event(bool is_x, void *addr, int sig)
 	pe.config = 0;
 	pe.bp_type = is_x ? HW_BREAKPOINT_X : HW_BREAKPOINT_W;
 	pe.bp_addr = (unsigned long) addr;
-	pe.bp_len = sizeof(long);
+	pe.bp_len = is_x ? default_breakpoint_len() : sizeof(long);
 
 	pe.sample_period = 1;
 	pe.sample_type = PERF_SAMPLE_IP;
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index 4e897c2cf26b..ee560e156be6 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -25,6 +25,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "event.h"
+#include "parse-events.h"
 #include "../perf-sys.h"
 #include "cloexec.h"
 
@@ -88,7 +89,7 @@ static int test__bp_signal_overflow(struct test_suite *test __maybe_unused, int
 	pe.config = 0;
 	pe.bp_type = HW_BREAKPOINT_X;
 	pe.bp_addr = (unsigned long) test_function;
-	pe.bp_len = sizeof(long);
+	pe.bp_len = default_breakpoint_len();
 
 	pe.sample_period = THRESHOLD;
 	pe.sample_type = PERF_SAMPLE_IP;
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index edc2adcf1bae..639e65a9bf61 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -5,6 +5,7 @@
 #include <api/fs/fs.h>
 #include "tests.h"
 #include "debug.h"
+#include "parse-events.h"
 #include "pmu.h"
 #include "pmus.h"
 #include <dirent.h>
@@ -262,7 +263,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_X == evsel->core.attr.bp_type);
-	TEST_ASSERT_VAL("wrong bp_len", sizeof(long) == evsel->core.attr.bp_len);
+	TEST_ASSERT_VAL("wrong bp_len", default_breakpoint_len() == evsel->core.attr.bp_len);
 	return TEST_OK;
 }
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fab01ba54e34..792e5ed94870 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -670,6 +670,11 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 }
 #endif /* HAVE_LIBTRACEEVENT */
 
+size_t default_breakpoint_len(void)
+{
+	return sizeof(long);
+}
+
 static int
 parse_breakpoint_type(const char *type, struct perf_event_attr *attr)
 {
@@ -728,7 +733,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 	/* Provide some defaults if len is not specified */
 	if (!len) {
 		if (attr.bp_type == HW_BREAKPOINT_X)
-			len = sizeof(long);
+			len = default_breakpoint_len();
 		else
 			len = HW_BREAKPOINT_LEN_4;
 	}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b735cd9e0acf..68bfea9ffa70 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -286,4 +286,6 @@ static inline bool is_sdt_event(char *str __maybe_unused)
 }
 #endif /* HAVE_LIBELF_SUPPORT */
 
+size_t default_breakpoint_len(void);
+
 #endif /* __PERF_PARSE_EVENTS_H */
-- 
2.46.0.469.g59c65b2a67-goog


