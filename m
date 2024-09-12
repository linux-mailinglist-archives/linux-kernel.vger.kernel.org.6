Return-Path: <linux-kernel+bounces-327108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50554977106
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C785C1F21881
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC21C1731;
	Thu, 12 Sep 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TuOw07y8"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F81C2435
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167855; cv=none; b=smBckkPF8sSYGQW03h+NJETDVCgPQopXZKM2yer4ptvTcJOOaWUiuhX//XET8gimzZE5ruEbT0PVjxyOXLVOrgxLxR+MaRqnOX1VeYE6GUb9kNM6Y5WDau6Uc9UzAYoV2nCC6bMpaudpxQZHW3P+NiegdHn62OKqMdJsFNe73hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167855; c=relaxed/simple;
	bh=15Nc/OwWurUUacjqwVltwlzbPJZfDu3Guj0Nm4r/qc4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MfVqTa+6zZHZqu16UDuKHQdHSRche+90GcadvrHF2/aMT5RH7NUKTWNrowmqw7CQX473o0uOBSJn7/52ZHEx/qdALjGXRtLtX4Ku7IZ7XNLs5NPJzv1lwLlaLrcJk3sxWQMXmm4nX4fhmMciEOPMOMiwp8C0jfUCb9THqubDQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TuOw07y8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1d46cee0b0so2317403276.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167853; x=1726772653; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FX+r6SVFIqGib21jmzvlNHWAGVIuITyDyogStZXuwgU=;
        b=TuOw07y8oKvj2Z8kOPnIw886EEKnJDiu5/WAD7gr24PUuXJI4XPab3yY5J67CoV4+w
         GZZumz9Rc2bQXu0i+gxj/ucpBsF/tNUZ2K1M3DWi/k5Al/4//PTq3KVjTKeqQxH22/ZA
         5z3X+FofC0Xbv2ttk2BUDGYvFuAw0DaYzH/qS4L1XaoTp374v63oO+MPZ0kMX4LuyjPP
         hXsdxGeHgGnZgPZ0FMxVd/ghPjTmf7Jsk1b2ZDSJqxgHOGjXga57xqVt0ti5YTIVgP6M
         IPnmLGNIJYe+pW8khrV9mK4gNPn/09DvNHH8eun3jRw+Yb9MbnzuckCa8IgyHT8B+Pvu
         uH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167853; x=1726772653;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FX+r6SVFIqGib21jmzvlNHWAGVIuITyDyogStZXuwgU=;
        b=p/Pg4HISUVjBEks4FLU93xCrmX7RmJv5O+hKTWXPcQCfwVR5tC3Gh8vXyEuVBu1a1o
         QFtF87Y1CDQBnFBmZY7hi89hoi2RQIr0j2SWKBiwy8p+dwSCBolC04AQgu2J/AcDYcHg
         /m9h0+lBVfjcZcK9hPI/YnJebj20PY17JdKpdUlMB2Yg1uATKNfrbRhA0xaJAB6Vn2R5
         o8DGD5m5KhzW2RQv+anVT7KaEbiZSZDNV2eHGojs0+pySVOsjDJgvpsHU21quGowQpwd
         EQEXiUQAThlKy4qW+h46v4GnLsp+mvvUFm6tgSClaniGsuoxFsKpl9S9ddckj3D99/s0
         K6pg==
X-Forwarded-Encrypted: i=1; AJvYcCXhXfhCtvGa21GIY6AzIascEQ6IdEg86mYp3NA0woKLfF7mi6QlnbPU/kto4Cfvx3ZFkg4CKoQ1T+1BO0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy197pO5mdNfc90945stzCbVnXXsuhaI5JqJXtkBc9aaYxIfk7B
	EsxjL0OsqQ108nsYDhGxt2fz3LTUgfkU0DSlnhwtoBQcKB5UR0ZKcD6cmZAhIFwNJ+bKJvNT8K6
	5RAzWMQ==
X-Google-Smtp-Source: AGHT+IGvofSNWStqV0FQzod3PiS0/dd5eh6QGon7LzpPoW9cWLn4mOIWytpk9Z8xbGbtLTwR8S/zRT7oQlDW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a25:e812:0:b0:e16:51f9:59da with SMTP id
 3f1490d57ef6-e1d9dc1b42emr12659276.6.1726167852675; Thu, 12 Sep 2024 12:04:12
 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:37 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 10/13] perf tests: Add tool PMU test
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
2.46.0.662.g92d0881bb0-goog


