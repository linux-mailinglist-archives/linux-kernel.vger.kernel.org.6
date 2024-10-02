Return-Path: <linux-kernel+bounces-346971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB06898CB7F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB0E1C20EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A391863F;
	Wed,  2 Oct 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fK9BHVYy"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F882866
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839254; cv=none; b=EGcc9MLz/9lu/5wLqnYerqr5MP266xZQuP8emK5ZciU5whBtOsrFM957mtG15xpXE3YQnVspnzQWxjmrCbuheWXpuIayTt7PJ8SmTsI8cdbETEaYIkjl7RLnr4HozDdlHtYpkRy0kfIlUA7WbsX73e72M5Z2WTqz/SrjzFgD/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839254; c=relaxed/simple;
	bh=zJLSWphoK/5thBSEuRGRo1DV6mfXxIV9tOUoeGeERlc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oFw/+G9LMRq+OXafLWuhqxA0ZX3SmymJfmLKnOZ8I8DQ/1yXAOXtoDEvLCIoWN4SjJheRlDY0FsuVX0LPtN5Hg+vCDRRtvGasL0uTdVm94dAezvH+l1SWHZJ4fCB8qUsJHi5wLxul57M8JOXL/QoVHzt1HyLabK6duwXBUPkTqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fK9BHVYy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e25a6fddb0so54548097b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 20:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839252; x=1728444052; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjH+e42xHNJsyHnAiPAOj3YUvO9P1GLiExZWpzpC88Q=;
        b=fK9BHVYyDenk2JVR8U6jlroGKiQskcaKUqHPTB9LpqUmj9qbGVeyGejnSLaCh/PfE+
         sm4ZyzSv0xjajdPSh3nBndIBcSkHmYgL+LfT9golJixmWD+Emf5HG1Nfs3ZS6nXlGQIF
         AlzqJH0bHuBA++i5anMtHf8MddbtyTkkfsc6AtZasBD2SUI295V+hi2E3STMwaj65S8u
         2KoGBR5DZa97hgHUleDjJGbOm3QCKgk0+yHmGKSGR0BAgV2MeHZdOFi8QE/4gEacz3g4
         l01xJUcM5gj2iPLHoOkYF9yzUosfM608Je5s3BBed7roBC75btogaI/ISsw4UVa5ESFn
         rKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839252; x=1728444052;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjH+e42xHNJsyHnAiPAOj3YUvO9P1GLiExZWpzpC88Q=;
        b=aNg+D+Y6DZttEO9+OhYKpCjesqlNN978LHjRFnzOJzHRtcnw//6Ma3ng2keLWQvJ15
         1gm0rsfxS1eAMzlGvrewO3m7yLY58+1CeahFR/mpHORjBJJUcTSDNhaooTKSsA2bOrY/
         Pb1tDNU+LDChrTfwmrIgU77zmluWOhJdkRwKs3sFU/46/k3gbSR7Bjb0U9SZWFjjg6W8
         xUjr9AJdEsWKAlw/DzjCYV2Bbby4e/i3ZhBb/bXlVl/mWgmBsc0OgbXVfuNT8I8f+sGe
         +wTE38AQ3/vSchk3asPCLGRPH1xUO3i0GFXbkx/l3ielJV9poyDFfjNQcuIsYmcBoTDc
         eEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcNkbCUbnQWRRA34u9HlJnhF6T/Z7fPWsBbAU1o4FfM90lO/fATx5SwJn2ehshXmncwudTrSvbO7YmMS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5T7D/wXcYj15beeH3Ui0wuKvgDI81YKwapgbv1E+E3opTqpc
	Nd8JZ8yd9IJfoxRg8nCnKsFUN6u2+ukaenfl7V9sxWi5261tnsIDyO6hwwAr6i79Jl3yujJOQWE
	YcboiZQ==
X-Google-Smtp-Source: AGHT+IFCH/kc5OhOQqJFG2ZyK2/mLbtdCMfB4e7/kfit0uzEJ2uChVnic7Aar08+Qf4T9xHYUBtu9e4/2pnO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a05:6902:1783:b0:e20:2bba:739d with SMTP
 id 3f1490d57ef6-e263837e68fmr3872276.2.1727839251497; Tue, 01 Oct 2024
 20:20:51 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:15 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 12/13] perf test: Add hwmon "PMU" test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Based on a mix of the sysfs PMU test (for creating the reference
files) and the tool PMU test, test that parsing given hwmon events
with there aliases creates the expected config values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/hwmon_pmu.c    | 243 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/pmus.c          |   7 +
 tools/perf/util/pmus.h          |   3 +
 6 files changed, 256 insertions(+)
 create mode 100644 tools/perf/tests/hwmon_pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index a771e4928247..078d2580d46c 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -67,6 +67,7 @@ perf-test-y += sigtrap.o
 perf-test-y += event_groups.o
 perf-test-y += symbols.o
 perf-test-y += util.o
+perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3b30f258c395..81c0f12b8820 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -73,6 +73,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__PERF_RECORD,
 	&suite__pmu,
 	&suite__pmu_events,
+	&suite__hwmon_pmu,
 	&suite__tool_pmu,
 	&suite__dso_data,
 	&suite__perf_evsel__roundtrip_name_test,
diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
new file mode 100644
index 000000000000..712d6ecbd8f9
--- /dev/null
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "tests.h"
+#include "hwmon_pmu.h"
+#include <fcntl.h>
+#include <sys/stat.h>
+
+static const struct test_event {
+	const char *name;
+	const char *alias;
+	long config;
+} test_events[] = {
+	{
+		"temp_test_hwmon_event1",
+		"temp1",
+		0xA0001,
+	},
+	{
+		"temp_test_hwmon_event2",
+		"temp2",
+		0xA0002,
+	},
+};
+
+/* Cleanup test PMU directory. */
+static int test_pmu_put(const char *dir, struct perf_pmu *hwm)
+{
+	char buf[PATH_MAX + 20];
+	int ret;
+
+	if (scnprintf(buf, sizeof(buf), "rm -fr %s", dir) < 0) {
+		pr_err("Failure to set up buffer for \"%s\"\n", dir);
+		return -EINVAL;
+	}
+	ret = system(buf);
+	if (ret)
+		pr_err("Failure to \"%s\"\n", buf);
+
+	perf_pmu__delete(hwm);
+	return ret;
+}
+
+/*
+ * Prepare test PMU directory data, normally exported by kernel at
+ * /sys/class/hwmon/hwmon<number>/. Give as input a buffer to hold the file
+ * path, the result is PMU loaded using that directory.
+ */
+static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
+{
+	const char *test_hwmon_name_nl = "A test hwmon PMU\n";
+	const char *test_hwmon_name = "A test hwmon PMU";
+	/* Simulated hwmon items. */
+	const struct test_item {
+		const char *name;
+		const char *value;
+	} test_items[] = {
+		{ "temp1_label", "test hwmon event1\n", },
+		{ "temp1_input", "40000\n", },
+		{ "temp2_label", "test hwmon event2\n", },
+		{ "temp2_input", "50000\n", },
+	};
+	int dirfd, file;
+	struct perf_pmu *hwm = NULL;
+	ssize_t len;
+
+	/* Create equivalent of sysfs mount point. */
+	scnprintf(dir, sz, "/tmp/perf-hwmon-pmu-test-XXXXXX");
+	if (!mkdtemp(dir)) {
+		pr_err("mkdtemp failed\n");
+		dir[0] = '\0';
+		return NULL;
+	}
+	dirfd = open(dir, O_DIRECTORY);
+	if (dirfd < 0) {
+		pr_err("Failed to open test directory \"%s\"\n", dir);
+		goto err_out;
+	}
+
+	/* Create the test hwmon directory and give it a name. */
+	if (mkdirat(dirfd, "hwmon1234", 0755) < 0) {
+		pr_err("Failed to mkdir hwmon directory\n");
+		goto err_out;
+	}
+	file = openat(dirfd, "hwmon1234/name", O_WRONLY | O_CREAT, 0600);
+	if (!file) {
+		pr_err("Failed to open for writing file \"name\"\n");
+		goto err_out;
+	}
+	len = strlen(test_hwmon_name_nl);
+	if (write(file, test_hwmon_name_nl, len) < len) {
+		close(file);
+		pr_err("Failed to write to 'name' file\n");
+		goto err_out;
+	}
+	close(file);
+
+	/* Create test hwmon files. */
+	for (size_t i = 0; i < ARRAY_SIZE(test_items); i++) {
+		const struct test_item *item = &test_items[i];
+
+		file = openat(dirfd, item->name, O_WRONLY | O_CREAT, 0600);
+		if (!file) {
+			pr_err("Failed to open for writing file \"%s\"\n", item->name);
+			goto err_out;
+		}
+
+		if (write(file, item->value, strlen(item->value)) < 0) {
+			pr_err("Failed to write to file \"%s\"\n", item->name);
+			close(file);
+			goto err_out;
+		}
+		close(file);
+	}
+
+	/* Make the PMU reading the files created above. */
+	hwm = perf_pmus__add_test_hwmon_pmu(dirfd, "hwmon1234", test_hwmon_name);
+	if (!hwm)
+		pr_err("Test hwmon creation failed\n");
+
+err_out:
+	if (!hwm) {
+		test_pmu_put(dir, hwm);
+		if (dirfd >= 0)
+			close(dirfd);
+	}
+	return hwm;
+}
+
+static int do_test(size_t i, bool with_pmu, bool with_alias)
+{
+	const char *test_event = with_alias ? test_events[i].alias : test_events[i].name;
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
+		snprintf(str, sizeof(str), "/%s/", test_event);
+	else
+		strncpy(str, test_event, sizeof(str));
+
+	pr_debug("Testing '%s'\n", str);
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, str, &err);
+	if (ret) {
+		evlist__delete(evlist);
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
+		if (!perf_pmu__is_hwmon(evsel->pmu))
+			continue;
+
+		if (evsel->core.attr.config != (u64)test_events[i].config) {
+			pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %ld\n",
+				__FILE__, __LINE__, str,
+				evsel->core.attr.config,
+				test_events[i].config);
+			ret = TEST_FAIL;
+			goto out;
+		}
+		found = true;
+	}
+
+	if (!found) {
+		pr_debug("FAILED %s:%d Didn't find hwmon event '%s' in parsed evsels\n",
+			 __FILE__, __LINE__, str);
+		ret = TEST_FAIL;
+	}
+
+out:
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int test__hwmon_pmu(bool with_pmu)
+{
+	char dir[PATH_MAX];
+	struct perf_pmu *pmu = test_pmu_get(dir, sizeof(dir));
+	int ret = TEST_OK;
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(test_events); i++) {
+		ret = do_test(i, with_pmu, /*with_alias=*/false);
+
+		if (ret != TEST_OK)
+			break;
+
+		ret = do_test(i, with_pmu, /*with_alias=*/true);
+
+		if (ret != TEST_OK)
+			break;
+	}
+	test_pmu_put(dir, pmu);
+	return ret;
+}
+
+static int test__hwmon_pmu_without_pmu(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	return test__hwmon_pmu(/*with_pmu=*/false);
+}
+
+static int test__hwmon_pmu_with_pmu(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	return test__hwmon_pmu(/*with_pmu=*/false);
+}
+
+static struct test_case tests__hwmon_pmu[] = {
+	TEST_CASE("Parsing without PMU name", hwmon_pmu_without_pmu),
+	TEST_CASE("Parsing with PMU name", hwmon_pmu_with_pmu),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__hwmon_pmu = {
+	.desc = "Hwmon PMU",
+	.test_cases = tests__hwmon_pmu,
+};
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 1ed76d4156b6..260daa77eb06 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -83,6 +83,7 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
 DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
+DECLARE_SUITE(hwmon_pmu);
 DECLARE_SUITE(tool_pmu);
 DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 5c3e88adb9e6..451c6e00ad70 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -733,6 +733,13 @@ struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name)
 	return perf_pmu__lookup(&other_pmus, test_sysfs_dirfd, name, /*eager_load=*/true);
 }
 
+struct perf_pmu *perf_pmus__add_test_hwmon_pmu(int hwmon_dir,
+					       const char *sysfs_name,
+					       const char *name)
+{
+	return hwmon_pmu__new(&other_pmus, hwmon_dir, sysfs_name, name);
+}
+
 struct perf_pmu *perf_pmus__fake_pmu(void)
 {
 	static struct perf_pmu fake = {
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index e1742b56eec7..a0cb0eb2ff97 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -30,6 +30,9 @@ bool perf_pmus__supports_extended_type(void);
 char *perf_pmus__default_pmu_name(void);
 
 struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name);
+struct perf_pmu *perf_pmus__add_test_hwmon_pmu(int hwmon_dir,
+					       const char *sysfs_name,
+					       const char *name);
 struct perf_pmu *perf_pmus__fake_pmu(void);
 
 #endif /* __PMUS_H */
-- 
2.46.1.824.gd892dcdcdd-goog


