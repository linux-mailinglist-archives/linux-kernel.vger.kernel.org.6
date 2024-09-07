Return-Path: <linux-kernel+bounces-319650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0D7970022
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D51F23AC3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828F715B12A;
	Sat,  7 Sep 2024 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3t9Mpt4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7A159583
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685752; cv=none; b=kgGdD+b7InHC/nMZwkTCyDHDurJ08uVNJHdHauE/dUTe96CwiK77vVtgXsBT0BSPkVoAojL8ydC3zBO3jD8Gih4AUficGSLjoR20AoFURuKhh2rv0zsvSM9W52xeGuHzYMgiPJIECltLBO68epz4mYn0k39XSE+O6KCpeBal9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685752; c=relaxed/simple;
	bh=zgNzTknoxQWGaTxAWg+yg5AbW9anNUVCe+80Iw5kmk8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=q8XfJqL0FvmDjg14clolCIDPSfyNt+z76hgg5G4gtK1nfNCP5tPVsVAXvpj3mn9nUhnJdr7Q8Z+YjuUWzUv+69r6P9A1T7K91BivkqGWxarFTyA6f37eCvdwh9S3WWwSaNRt1FpaciKsFIPvwKaacAZQ+IIGE+POUyjLlfVizXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3t9Mpt4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b41e02c255so98520267b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685750; x=1726290550; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/Ar3dUi50U5MkQ1SlyAwk/I3yarddmL36DdZBmDzV4=;
        b=P3t9Mpt43rtdvWFM305G1ygVnyo77Gt52k5Dxtt1SDcQ86/fVPmkpUHsoehLtnz+53
         HuC0N54Ze9clr+AlJoBk1nZf0F5e1c7Xqn04tu7rkBqg6Tx4iA0XAayoZgrrUapopVW3
         t+ypcMYHYKiLq9IJ/9+XaC+Dk7TlhUMnrut45JHrDF9ht+a2P82GQ+57ciHJVzD8gyv+
         qNlBk9a0z4pQQlJosR0wsVmmbpvObabFPbTXwQNNwB8oPoivAE898OKXKZSYOyJXzkhb
         uqeJE6507hRJa0y8LkAIiWkUtuSX8CpgmiUu9+CvA/LSFePCAn/1me38ELygofDkf8VI
         X84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685750; x=1726290550;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/Ar3dUi50U5MkQ1SlyAwk/I3yarddmL36DdZBmDzV4=;
        b=WdZ+Wg7Z3SnYKi4xeK3wI3teu5JmIvPWBnxg681FvTIY6ytNPZG7sduhRyN9BkwgEq
         rETt9ED7tkg/t+TPIi2s62Zg6pAsHIH1HnfFa2ktG0aQOmFLg6/dG5ayPLRzjY0oHBMX
         T/pJk9hQRVZHE8jwUyzGZRLpoMp53I7rtiT1uwX2ZlYUr7nIc87dSh05gi9xabl1cRW8
         eozxqunUqy3fOtvANygGcOeD9bIAPsmGE3RZY8hnkh0V6PjQubUGcL2TALipIQuo0WsT
         Cxsysb8NNulzrFFCek0qUZ7OkhMP9QUTYO3NjXrNe4JwaSJEmsyLekK5IcRMsXcnlz2d
         KQAw==
X-Forwarded-Encrypted: i=1; AJvYcCUz4RcGK08qM7wrBMYYscq5qQpORsephtBYcaUy7mfBr+KHKrOp/MMncxp4PghPDchWWZzS0FaL1T/iYvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsiRt3I4o91Sq+72Cr3KpnUEbsSql0bdQMhlTAs+xWJSOWIGfq
	3VthbQIeYn3jl27IPkIs1RpRqCDtBf3yzDlH6T30lrWtm50bYOCW3JeAQEPkn7QYSlSqILjsizR
	qOQ8uEg==
X-Google-Smtp-Source: AGHT+IE8fHd4LfbapRE/tIEDY9qTS5Fj2ijGjPzlTc2FTO6xmYM62oDetj4uPSv3jpaKIE4fx+/hRNzhtD5i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a5b:c0c:0:b0:e11:5f87:1e3c with SMTP id
 3f1490d57ef6-e1d34a7f845mr40886276.11.1725685749881; Fri, 06 Sep 2024
 22:09:09 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:28 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 13/15] perf tests: Add tool PMU test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure parsing with and without PMU creates events with the expected
config values. This ensures the tool.json doesn't get out of sync with
tool_pmu_event enum.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/tests.h        |   1 +
 tools/perf/tests/tool_pmu.c     | 111 ++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)
 create mode 100644 tools/perf/tests/tool_pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5671ee530019..a771e4928247 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -67,6 +67,7 @@ perf-test-y += sigtrap.o
 perf-test-y += event_groups.o
 perf-test-y += symbols.o
 perf-test-y += util.o
+perf-test-y += tool_pmu.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 470a9709427d..3b30f258c395 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -73,6 +73,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__PERF_RECORD,
 	&suite__pmu,
 	&suite__pmu_events,
+	&suite__tool_pmu,
 	&suite__dso_data,
 	&suite__perf_evsel__roundtrip_name_test,
 #ifdef HAVE_LIBTRACEEVENT
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 6ea2be86b7bf..1ed76d4156b6 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -83,6 +83,7 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
 DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
+DECLARE_SUITE(tool_pmu);
 DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
 DECLARE_SUITE(dso_data_cache);
diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
new file mode 100644
index 000000000000..94d0dd8fd3cb
--- /dev/null
+++ b/tools/perf/tests/tool_pmu.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "tests.h"
+#include "tool_pmu.h"
+
+static int do_test(enum tool_pmu_event ev, bool with_pmu)
+{
+	struct evlist *evlist = evlist__new();
+	struct evsel *evsel;
+	struct parse_events_error err;
+	int ret;
+	char str[128];
+	bool found = false;
+
+	if (!evlist) {
+		pr_err("evlist allocation failed\n");
+		return TEST_FAIL;
+	}
+
+	if (with_pmu)
+		snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to_str(ev));
+	else
+		strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
+
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, str, &err);
+	if (ret) {
+		evlist__delete(evlist);
+		if (tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
+			ret = TEST_OK;
+			goto out;
+		}
+
+		pr_debug("FAILED %s:%d failed to parse event '%s', err %d\n",
+			 __FILE__, __LINE__, str, ret);
+		parse_events_error__print(&err, str);
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	ret = TEST_OK;
+	if (with_pmu ? (evlist->core.nr_entries != 1) : (evlist->core.nr_entries < 1)) {
+		pr_debug("FAILED %s:%d Unexpected number of events for '%s' of %d\n",
+			 __FILE__, __LINE__, str, evlist->core.nr_entries);
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (perf_pmu__is_tool(evsel->pmu)) {
+			if (evsel->core.attr.config != ev) {
+				pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %d\n",
+					__FILE__, __LINE__, str, evsel->core.attr.config, ev);
+				ret = TEST_FAIL;
+				goto out;
+			}
+			found = true;
+		}
+	}
+
+	if (!found && !tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
+		pr_debug("FAILED %s:%d Didn't find tool event '%s' in parsed evsels\n",
+			 __FILE__, __LINE__, str);
+		ret = TEST_FAIL;
+	}
+
+out:
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int test__tool_pmu_without_pmu(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	int i;
+
+	tool_pmu__for_each_event(i) {
+		int ret = do_test(i, /*with_pmu=*/false);
+
+		if (ret != TEST_OK)
+			return ret;
+	}
+	return TEST_OK;
+}
+
+static int test__tool_pmu_with_pmu(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	int i;
+
+	tool_pmu__for_each_event(i) {
+		int ret = do_test(i, /*with_pmu=*/true);
+
+		if (ret != TEST_OK)
+			return ret;
+	}
+	return TEST_OK;
+}
+
+static struct test_case tests__tool_pmu[] = {
+	TEST_CASE("Parsing without PMU name", tool_pmu_without_pmu),
+	TEST_CASE("Parsing with PMU name", tool_pmu_with_pmu),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__tool_pmu = {
+	.desc = "Tool PMU",
+	.test_cases = tests__tool_pmu,
+};
-- 
2.46.0.469.g59c65b2a67-goog


