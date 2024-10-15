Return-Path: <linux-kernel+bounces-366689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8892299F8B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D1728295E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BC31FE114;
	Tue, 15 Oct 2024 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JTEB286o"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFBE1FE0E1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026399; cv=none; b=uINiGav3bg4Ens4wjJDIMqwrHRYmFroO6XpG/vH1iIz6a7WWDsKOqNKQMvtsSnyGM4ivbnM5v3PryyGnfhfwrPZY5esktCFk6nAKJVF2kcUAcxJ6lQgHSRN1gPgsbNLthLJsZtT+9qb6BGrkNj7baQjyPNVhybmrcsPcDelWxMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026399; c=relaxed/simple;
	bh=ebE3rElU8qnWqj9yug95dOoylZH4RT6sQlV6UkgfR0o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BkzQACvwN9xW/Ed4QpRihwzsmAvJnkrgBIp0DiO1+mC6UjHJHyAx0sly8xJmvvLa18OsTxbpz/9gvh9vSi31vd7Re9jgWNI/w46lCSY27+yTeoczPBHcDjrzOVJb6jGPIyjVNzfX0mRLHHl0J1wLzRTWVgkH+U1M52Yyy8BUQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JTEB286o; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3d6713619so7193517b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729026396; x=1729631196; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpNEFP1bOsQQDYJ3YsdKfoWX263ozEvdPgx8rw5Iv2s=;
        b=JTEB286oyjPIzQf+69MiUvEtTYdfrf+xG7w4GzdxPfDGeZUZn8QoDXYBa6HRdABsGM
         mDJ2Hckr3VGk7pJsa/qqa+1fUkakINAdTBjI7ThZlV4qULuGRYjuPYnwTCGwcrHJCbW0
         ukPbYZGiCNZBJ/PMIS8Ggvv0SvcNsK3DqFzbQOgILrPdjwSggSJm0eNuyLhLArnl1cTM
         ui0CotYLSrjIOX6MeCjL3j7JCBbRD/Kbvx1kmDHv5cPbYzLKg0cXTJUh5gMSyRCBg3xR
         6so0y/3kCKjND0xl8d6JLpnq/prreDY64ueIPfH0UBdEYUxvPXJIVn5n2kS8r90kc9sf
         0V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026396; x=1729631196;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpNEFP1bOsQQDYJ3YsdKfoWX263ozEvdPgx8rw5Iv2s=;
        b=e1Vq5ybdthFrgy5x8aS8bej+k8pO8nbljqPwZXYXz7UhDo6PGA7G51+BcltpodDRjC
         /b6pIa+PNLbPnvx184h+GIkQcgMNUdfZfIXt+hIcNwIy9P4PX3fUTwW98QuRT4g0iqli
         o9ZZaJgpCUWgArL9PS1YmRTzvTwcJfvS6i8iGkTEv0XbVTW/3dqx31SHUomsS2W/iwzP
         SYldAcyPd5zSK3phPLwle0Okh8vaK1xuBg+may9XoZMQyiIvXrjbba6exgtw4T/VmXCf
         i27J/hknzs//z1wCwi5H2OZo6vRenDEQ7v+kAx6lQYYJxdxNzSXDBnwBOsoHd+RM4vSd
         DYtw==
X-Forwarded-Encrypted: i=1; AJvYcCWJXvd/SKK11vs4wXqhbqN+C5tzErPrZOr8DB8//yLgKpKxrHGYjyI+Qr6aM+YYfDEAdWHGgV40bDMk7iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYe/b4z2qobDXVQJTK6ljTX6ZpUIFOCnXYDzWwuH5A7YavjzgR
	Svr4DS2v/bqJJrf5OHKCmTuPQ/aYUU6WBpvhH+ji8mzAY96ikId/vlZsN8cdds1qIQFDIGU5i6R
	75+wUWQ==
X-Google-Smtp-Source: AGHT+IGTS2e62bom4xk3I/LMdMoiZH1GODgb+AsOGdjQFQGr4M1Onm48wLFSXIL9xOxBaZGoWCsV4gzSCk1r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a05:690c:4b05:b0:648:fc8a:cd23 with SMTP
 id 00721157ae682-6e3d407c2a5mr312137b3.2.1729026396505; Tue, 15 Oct 2024
 14:06:36 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:06:25 -0700
In-Reply-To: <20241015210629.1150428-1-irogers@google.com>
Message-Id: <20241015210629.1150428-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015210629.1150428-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v4 2/5] perf hwmon_pmu: Add a tool PMU exposing events from
 hwmon in sysfs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a tool PMU for hwmon events but don't enable.

The hwmon sysfs ABI is defined in
Documentation/hwmon/sysfs-interface.rst. Create a PMU that reads the
hwmon input and can be used in `perf stat` and metrics much as an
uncore PMU can.

For example, when enabled by a later patch, the following shows
reading the CPU temperature and 2 fan speeds alongside the uncore
frequency:
```
$ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
     1.001153138              52.00 'C   temp_cpu
     1.001153138              2,588 rpm  fan1
     1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
     1.001153138                  8      tool/num_cpus_online/
     1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
     1.001153138      1,012,773,595      duration_time
...
```

The PMUs are named from /sys/class/hwmon/hwmon<num>/name and have an
alias of hwmon<num>.

Hwmon data is presented in multiple <type><number>_<item> files. The
<type><number> is used to identify the event as is the <type> followed
by the contents of the <type>_label file if it exists. The
<type><number>_input file gives the data read by perf.

When enabled by a later patch, in `perf list` the other hwmon <item>
files are used to give a richer description, for example:
```
hwmon:
  temp1
       [Temperature in unit acpitz named temp1. Unit: hwmon_acpitz]
  in0
       [Voltage in unit bat0 named in0. Unit: hwmon_bat0]
  temp_core_0 OR temp2
       [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
        hwmon_coretemp]
  temp_core_1 OR temp3
       [Temperature in unit coretemp named Core 1. crit=100'C,max=100'C crit_alarm=0'C. Unit:
        hwmon_coretemp]
...
  temp_package_id_0 OR temp1
       [Temperature in unit coretemp named Package id 0. crit=100'C,max=100'C crit_alarm=0'C.
        Unit: hwmon_coretemp]
  temp1
       [Temperature in unit iwlwifi_1 named temp1. Unit: hwmon_iwlwifi_1]
  temp_composite OR temp1
       [Temperature in unit nvme named Composite. alarm=0'C,crit=86.85'C,max=75.85'C,
        min=-273.15'C. Unit: hwmon_nvme]
  temp_sensor_1 OR temp2
       [Temperature in unit nvme named Sensor 1. max=65261.8'C,min=-273.15'C. Unit: hwmon_nvme]
  temp_sensor_2 OR temp3
       [Temperature in unit nvme named Sensor 2. max=65261.8'C,min=-273.15'C. Unit: hwmon_nvme]
  fan1
       [Fan in unit thinkpad named fan1. Unit: hwmon_thinkpad]
  fan2
       [Fan in unit thinkpad named fan2. Unit: hwmon_thinkpad]
...
  temp_cpu OR temp1
       [Temperature in unit thinkpad named CPU. Unit: hwmon_thinkpad]
  temp_gpu OR temp2
       [Temperature in unit thinkpad named GPU. Unit: hwmon_thinkpad]
  curr1
       [Current in unit ucsi_source_psy_usbc000_0 named curr1. max=1.5A. Unit:
        hwmon_ucsi_source_psy_usbc000_0]
  in0
       [Voltage in unit ucsi_source_psy_usbc000_0 named in0. max=5V,min=5V. Unit:
        hwmon_ucsi_source_psy_usbc000_0]
```

As there may be multiple hwmon devices a range of PMU types are
reserved for their use and to identify the PMU as belonging to the
hwmon types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build       |   1 +
 tools/perf/util/hwmon_pmu.c | 820 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/hwmon_pmu.h | 154 +++++++
 tools/perf/util/pmu.h       |   2 +
 4 files changed, 977 insertions(+)
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index fa508e113dd0..9eb8b1c3df94 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -83,6 +83,7 @@ perf-util-y += pmu.o
 perf-util-y += pmus.o
 perf-util-y += pmu-flex.o
 perf-util-y += pmu-bison.o
+perf-util-y += hwmon_pmu.o
 perf-util-y += tool_pmu.o
 perf-util-y += svghelper.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
new file mode 100644
index 000000000000..a8bc76721328
--- /dev/null
+++ b/tools/perf/util/hwmon_pmu.c
@@ -0,0 +1,820 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "counts.h"
+#include "debug.h"
+#include "evsel.h"
+#include "hashmap.h"
+#include "hwmon_pmu.h"
+#include "pmu.h"
+#include <internal/xyarray.h>
+#include <internal/threadmap.h>
+#include <perf/threadmap.h>
+#include <sys/types.h>
+#include <ctype.h>
+#include <dirent.h>
+#include <fcntl.h>
+#include <api/fs/fs.h>
+#include <api/io.h>
+#include <linux/zalloc.h>
+
+const char * const hwmon_type_strs[HWMON_TYPE_MAX] = {
+	NULL,
+	"cpu",
+	"curr",
+	"energy",
+	"fan",
+	"humidity",
+	"in",
+	"intrusion",
+	"power",
+	"pwm",
+	"temp",
+};
+#define LONGEST_HWMON_TYPE_STR "intrusion"
+
+static const char *const hwmon_units[HWMON_TYPE_MAX] = {
+	NULL,
+	"V",   /* cpu */
+	"A",   /* curr */
+	"J",   /* energy */
+	"rpm", /* fan */
+	"%",   /* humidity */
+	"V",   /* in */
+	"",    /* intrusion */
+	"W",   /* power */
+	"Hz",  /* pwm */
+	"'C",  /* temp */
+};
+
+const char * const hwmon_item_strs[HWMON_ITEM__MAX] = {
+	NULL,
+	"accuracy",
+	"alarm",
+	"auto_channels_temp",
+	"average",
+	"average_highest",
+	"average_interval",
+	"average_interval_max",
+	"average_interval_min",
+	"average_lowest",
+	"average_max",
+	"average_min",
+	"beep",
+	"cap",
+	"cap_hyst",
+	"cap_max",
+	"cap_min",
+	"crit",
+	"crit_hyst",
+	"div",
+	"emergency",
+	"emergency_hist",
+	"enable",
+	"fault",
+	"freq",
+	"highest",
+	"input",
+	"label",
+	"lcrit",
+	"lcrit_hyst",
+	"lowest",
+	"max",
+	"max_hyst",
+	"min",
+	"min_hyst",
+	"mod",
+	"offset",
+	"pulses",
+	"rated_max",
+	"rated_min",
+	"reset_history",
+	"target",
+	"type",
+	"vid",
+};
+#define LONGEST_HWMON_ITEM_STR "average_interval_max"
+
+struct hwmon_pmu {
+	struct perf_pmu pmu;
+	struct hashmap events;
+	int hwmon_dir_fd;
+};
+
+/**
+ * union hwmon_pmu_event_key: Key for hwmon_pmu->events as such each key
+ * represents an event.
+ *
+ * Related hwmon files start <type><number> that this key represents.
+ */
+union hwmon_pmu_event_key {
+	long type_and_num;
+	struct {
+		int num :16;
+		enum hwmon_type type :8;
+	};
+};
+
+/**
+ * struct hwmon_pmu_event_value: Value in hwmon_pmu->events.
+ *
+ * Hwmon files are of the form <type><number>_<item> and may have a suffix
+ * _alarm.
+ */
+struct hwmon_pmu_event_value {
+	/** @items: which item files are present. */
+	DECLARE_BITMAP(items, HWMON_ITEM__MAX);
+	/** @alarm_items: which item files are present. */
+	DECLARE_BITMAP(alarm_items, HWMON_ITEM__MAX);
+	/** @label: contents of <type><number>_label if present. */
+	char *label;
+	/** @name: name computed from label of the form <type>_<label>. */
+	char *name;
+};
+
+bool perf_pmu__is_hwmon(const struct perf_pmu *pmu)
+{
+	return pmu && pmu->type >= PERF_PMU_TYPE_HWMON_START &&
+		pmu->type <= PERF_PMU_TYPE_HWMON_END;
+}
+
+bool evsel__is_hwmon(const struct evsel *evsel)
+{
+	return perf_pmu__is_hwmon(evsel->pmu);
+}
+
+static size_t hwmon_pmu__event_hashmap_hash(long key, void *ctx __maybe_unused)
+{
+	return ((union hwmon_pmu_event_key)key).type_and_num;
+}
+
+static bool hwmon_pmu__event_hashmap_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return ((union hwmon_pmu_event_key)key1).type_and_num ==
+	       ((union hwmon_pmu_event_key)key2).type_and_num;
+}
+
+static int hwmon_strcmp(const void *a, const void *b)
+{
+	const char *sa = a;
+	const char * const *sb = b;
+
+	return strcmp(sa, *sb);
+}
+
+bool parse_hwmon_filename(const char *filename,
+			  enum hwmon_type *type,
+			  int *number,
+			  enum hwmon_item *item,
+			  bool *alarm)
+{
+	char fn_type[24];
+	const char **elem;
+	const char *fn_item = NULL;
+	size_t fn_item_len;
+
+	assert(strlen(LONGEST_HWMON_TYPE_STR) < sizeof(fn_type));
+	strlcpy(fn_type, filename, sizeof(fn_type));
+	for (size_t i = 0; i < sizeof(fn_type); i++) {
+		if (fn_type[i] >= '0' && fn_type[i] <= '9') {
+			fn_type[i] = '\0';
+			*number = strtoul(&filename[i], (char **)&fn_item, 10);
+			if (*fn_item == '_')
+				fn_item++;
+			break;
+		}
+		if (fn_type[i] == '_') {
+			fn_type[i] = '\0';
+			*number = -1;
+			fn_item = &filename[i + 1];
+			break;
+		}
+	}
+	if (fn_item == NULL || fn_type[0] == '\0' || (item != NULL && fn_item[0] == '\0')) {
+		pr_debug("hwmon_pmu: not a hwmon file '%s'\n", filename);
+		return false;
+	}
+	elem = bsearch(&fn_type, hwmon_type_strs + 1, ARRAY_SIZE(hwmon_type_strs) - 1,
+		       sizeof(hwmon_type_strs[0]), hwmon_strcmp);
+	if (!elem) {
+		pr_debug("hwmon_pmu: not a hwmon type '%s' in file name '%s'\n",
+			 fn_type, filename);
+		return false;
+	}
+
+	*type = elem - &hwmon_type_strs[0];
+	if (!item)
+		return true;
+
+	*alarm = false;
+	fn_item_len = strlen(fn_item);
+	if (fn_item_len > 6 && !strcmp(&fn_item[fn_item_len - 6], "_alarm")) {
+		assert(strlen(LONGEST_HWMON_ITEM_STR) < sizeof(fn_type));
+		strlcpy(fn_type, fn_item, fn_item_len - 6);
+		fn_item = fn_type;
+		*alarm = true;
+	}
+	elem = bsearch(fn_item, hwmon_item_strs + 1, ARRAY_SIZE(hwmon_item_strs) - 1,
+		       sizeof(hwmon_item_strs[0]), hwmon_strcmp);
+	if (!elem) {
+		pr_debug("hwmon_pmu: not a hwmon item '%s' in file name '%s'\n",
+			 fn_item, filename);
+		return false;
+	}
+	*item = elem - &hwmon_item_strs[0];
+	return true;
+}
+
+static void fix_name(char *p)
+{
+	char *s = strchr(p, '\n');
+
+	if (s)
+		*s = '\0';
+
+	while (*p != '\0') {
+		if (strchr(" :,/\n\t", *p))
+			*p = '_';
+		else
+			*p = tolower(*p);
+		p++;
+	}
+}
+
+static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
+{
+	DIR *dir;
+	struct dirent *ent;
+	int dup_fd, err = 0;
+	struct hashmap_entry *cur, *tmp;
+	size_t bkt;
+
+	if (pmu->pmu.sysfs_aliases_loaded)
+		return 0;
+
+	/* Use a dup-ed fd as closedir will close it. */
+	dup_fd = dup(pmu->hwmon_dir_fd);
+	if (dup_fd == -1)
+		return -ENOMEM;
+
+	dir = fdopendir(dup_fd);
+	if (!dir) {
+		close(dup_fd);
+		return -ENOMEM;
+	}
+
+	while ((ent = readdir(dir)) != NULL) {
+		enum hwmon_type type;
+		int number;
+		enum hwmon_item item;
+		bool alarm;
+		union hwmon_pmu_event_key key = {};
+		struct hwmon_pmu_event_value *value;
+
+		if (ent->d_type != DT_REG)
+			continue;
+
+		if (!parse_hwmon_filename(ent->d_name, &type, &number, &item, &alarm)) {
+			pr_debug("Not a hwmon file '%s'\n", ent->d_name);
+			continue;
+		}
+		key.num = number;
+		key.type = type;
+		if (!hashmap__find(&pmu->events, key.type_and_num, &value)) {
+			value = zalloc(sizeof(*value));
+			if (!value) {
+				err = -ENOMEM;
+				goto err_out;
+			}
+			err = hashmap__add(&pmu->events, key.type_and_num, value);
+			if (err) {
+				free(value);
+				err = -ENOMEM;
+				goto err_out;
+			}
+		}
+		__set_bit(item, alarm ? value->alarm_items : value->items);
+		if (item == HWMON_ITEM_LABEL) {
+			char buf[128];
+			int fd = openat(pmu->hwmon_dir_fd, ent->d_name, O_RDONLY);
+			ssize_t read_len;
+
+			if (fd < 0)
+				continue;
+
+			read_len = read(fd, buf, sizeof(buf));
+
+			while (read_len > 0 && buf[read_len - 1] == '\n')
+				read_len--;
+
+			if (read_len > 0)
+				buf[read_len] = '\0';
+
+			if (buf[0] == '\0') {
+				pr_debug("hwmon_pmu: empty label file %s %s\n",
+					 pmu->pmu.name, ent->d_name);
+				close(fd);
+				continue;
+			}
+			value->label = strdup(buf);
+			if (!value->label) {
+				pr_debug("hwmon_pmu: memory allocation failure\n");
+				close(fd);
+				continue;
+			}
+			snprintf(buf, sizeof(buf), "%s_%s", hwmon_type_strs[type], value->label);
+			fix_name(buf);
+			value->name = strdup(buf);
+			if (!value->name)
+				pr_debug("hwmon_pmu: memory allocation failure\n");
+			close(fd);
+		}
+	}
+	hashmap__for_each_entry_safe((&pmu->events), cur, tmp, bkt) {
+		union hwmon_pmu_event_key key = {
+			.type_and_num = cur->key,
+		};
+		struct hwmon_pmu_event_value *value = cur->pvalue;
+
+		if (!test_bit(HWMON_ITEM_INPUT, value->items)) {
+			pr_debug("hwmon_pmu: removing event '%s%d' that has no input file\n",
+				hwmon_type_strs[key.type], key.num);
+			hashmap__delete(&pmu->events, key.type_and_num, &key, &value);
+			zfree(&value->label);
+			zfree(&value->name);
+			free(value);
+		}
+	}
+	pmu->pmu.sysfs_aliases_loaded = true;
+
+err_out:
+	closedir(dir);
+	return err;
+}
+
+struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir, const char *sysfs_name, const char *name)
+{
+	char buf[32];
+	struct hwmon_pmu *hwm;
+
+	hwm = zalloc(sizeof(*hwm));
+	if (!hwm)
+		return NULL;
+
+
+	hwm->hwmon_dir_fd = hwmon_dir;
+	hwm->pmu.type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
+	if (hwm->pmu.type > PERF_PMU_TYPE_HWMON_END) {
+		pr_err("Unable to encode hwmon type from %s in valid PMU type\n", sysfs_name);
+		goto err_out;
+	}
+	snprintf(buf, sizeof(buf), "hwmon_%s", name);
+	fix_name(buf + 6);
+	hwm->pmu.name = strdup(buf);
+	if (!hwm->pmu.name)
+		goto err_out;
+	hwm->pmu.alias_name = strdup(sysfs_name);
+	if (!hwm->pmu.alias_name)
+		goto err_out;
+	hwm->pmu.cpus = perf_cpu_map__new("0");
+	if (!hwm->pmu.cpus)
+		goto err_out;
+	INIT_LIST_HEAD(&hwm->pmu.format);
+	INIT_LIST_HEAD(&hwm->pmu.aliases);
+	INIT_LIST_HEAD(&hwm->pmu.caps);
+	hashmap__init(&hwm->events, hwmon_pmu__event_hashmap_hash,
+		      hwmon_pmu__event_hashmap_equal, /*ctx=*/NULL);
+
+	list_add_tail(&hwm->pmu.list, pmus);
+	return &hwm->pmu;
+err_out:
+	free((char *)hwm->pmu.name);
+	free(hwm->pmu.alias_name);
+	free(hwm);
+	close(hwmon_dir);
+	return NULL;
+}
+
+void hwmon_pmu__exit(struct perf_pmu *pmu)
+{
+	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
+	struct hashmap_entry *cur, *tmp;
+	size_t bkt;
+
+	hashmap__for_each_entry_safe((&hwm->events), cur, tmp, bkt) {
+		struct hwmon_pmu_event_value *value = cur->pvalue;
+
+		zfree(&value->label);
+		zfree(&value->name);
+		free(value);
+	}
+	hashmap__clear(&hwm->events);
+	close (hwm->hwmon_dir_fd);
+}
+
+static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, size_t out_buf_len,
+					union hwmon_pmu_event_key key,
+					const unsigned long *items, bool is_alarm)
+{
+	size_t bit;
+	char buf[64];
+	size_t len = 0;
+
+	for_each_set_bit(bit, items, HWMON_ITEM__MAX) {
+		int fd;
+
+		if (bit == HWMON_ITEM_LABEL || bit == HWMON_ITEM_INPUT)
+			continue;
+
+		snprintf(buf, sizeof(buf), "%s%d_%s%s",
+			hwmon_type_strs[key.type],
+			key.num,
+			hwmon_item_strs[bit],
+			is_alarm ? "_alarm" : "");
+		fd = openat(hwm->hwmon_dir_fd, buf, O_RDONLY);
+		if (fd > 0) {
+			ssize_t read_len = read(fd, buf, sizeof(buf));
+
+			while (read_len > 0 && buf[read_len - 1] == '\n')
+				read_len--;
+
+			if (read_len > 0) {
+				long long val;
+
+				buf[read_len] = '\0';
+				val = strtoll(buf, /*endptr=*/NULL, 10);
+				len += snprintf(out_buf + len, out_buf_len - len, "%s%s%s=%g%s",
+						len == 0 ? " " : ", ",
+						hwmon_item_strs[bit],
+						is_alarm ? "_alarm" : "",
+						(double)val / 1000.0,
+						hwmon_units[key.type]);
+			}
+			close(fd);
+		}
+	}
+	return len;
+}
+
+int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
+{
+	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	if (hwmon_pmu__read_events(hwm))
+		return false;
+
+	hashmap__for_each_entry((&hwm->events), cur, bkt) {
+		static const char *const hwmon_scale_units[HWMON_TYPE_MAX] = {
+			NULL,
+			"0.001V", /* cpu */
+			"0.001A", /* curr */
+			"0.001J", /* energy */
+			"1rpm",   /* fan */
+			"0.001%", /* humidity */
+			"0.001V", /* in */
+			NULL,     /* intrusion */
+			"0.001W", /* power */
+			"1Hz",    /* pwm */
+			"0.001'C", /* temp */
+		};
+		static const char *const hwmon_desc[HWMON_TYPE_MAX] = {
+			NULL,
+			"CPU core reference voltage",   /* cpu */
+			"Current",                      /* curr */
+			"Cumulative energy use",        /* energy */
+			"Fan",                          /* fan */
+			"Humidity",                     /* humidity */
+			"Voltage",                      /* in */
+			"Chassis intrusion detection",  /* intrusion */
+			"Power use",                    /* power */
+			"Pulse width modulation fan control", /* pwm */
+			"Temperature",                  /* temp */
+		};
+		char alias_buf[64];
+		char desc_buf[256];
+		char encoding_buf[128];
+		union hwmon_pmu_event_key key = {
+			.type_and_num = cur->key,
+		};
+		struct hwmon_pmu_event_value *value = cur->pvalue;
+		struct pmu_event_info info = {
+			.pmu = pmu,
+			.name = value->name,
+			.alias = alias_buf,
+			.scale_unit = hwmon_scale_units[key.type],
+			.desc = desc_buf,
+			.long_desc = NULL,
+			.encoding_desc = encoding_buf,
+			.topic = "hwmon",
+			.pmu_name = pmu->name,
+			.event_type_desc = "Hwmon event",
+		};
+		int ret;
+		size_t len;
+
+		len = snprintf(alias_buf, sizeof(alias_buf), "%s%d",
+			       hwmon_type_strs[key.type], key.num);
+		if (!info.name) {
+			info.name = info.alias;
+			info.alias = NULL;
+		}
+
+		len = snprintf(desc_buf, sizeof(desc_buf), "%s in unit %s named %s.",
+			hwmon_desc[key.type],
+			pmu->name + 6,
+			value->label ?: info.name);
+
+		len += hwmon_pmu__describe_items(hwm, desc_buf + len, sizeof(desc_buf) - len,
+						key, value->items, /*is_alarm=*/false);
+
+		len += hwmon_pmu__describe_items(hwm, desc_buf + len, sizeof(desc_buf) - len,
+						key, value->alarm_items, /*is_alarm=*/true);
+
+		snprintf(encoding_buf, sizeof(encoding_buf), "%s/config=0x%lx/",
+			 pmu->name, cur->key);
+
+		ret = cb(state, &info);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+size_t hwmon_pmu__num_events(struct perf_pmu *pmu)
+{
+	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
+
+	hwmon_pmu__read_events(hwm);
+	return hashmap__size(&hwm->events);
+}
+
+bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
+{
+	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
+	enum hwmon_type type;
+	int number;
+	union hwmon_pmu_event_key key = {};
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	if (!parse_hwmon_filename(name, &type, &number, /*item=*/NULL, /*is_alarm=*/NULL))
+		return false;
+
+	if (hwmon_pmu__read_events(hwm))
+		return false;
+
+	key.type = type;
+	key.num = number;
+	if (hashmap_find(&hwm->events, key.type_and_num, /*value=*/NULL))
+		return true;
+	if (key.num != -1)
+		return false;
+	/* Item is of form <type>_ which means we should match <type>_<label>. */
+	hashmap__for_each_entry((&hwm->events), cur, bkt) {
+		struct hwmon_pmu_event_value *value = cur->pvalue;
+
+		key.type_and_num = cur->key;
+		if (key.type == type && value->name && !strcasecmp(name, value->name))
+			return true;
+	}
+	return false;
+}
+
+static int hwmon_pmu__config_term(const struct hwmon_pmu *hwm,
+				  struct perf_event_attr *attr,
+				  struct parse_events_term *term,
+				  struct parse_events_error *err)
+{
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
+		enum hwmon_type type;
+		int number;
+
+		if (parse_hwmon_filename(term->config, &type, &number,
+					 /*item=*/NULL, /*is_alarm=*/NULL)) {
+			if (number == -1) {
+				/*
+				 * Item is of form <type>_ which means we should
+				 * match <type>_<label>.
+				 */
+				struct hashmap_entry *cur;
+				size_t bkt;
+
+				attr->config = 0;
+				hashmap__for_each_entry((&hwm->events), cur, bkt) {
+					union hwmon_pmu_event_key key = {
+						.type_and_num = cur->key,
+					};
+					struct hwmon_pmu_event_value *value = cur->pvalue;
+
+					if (key.type == type && value->name &&
+					    !strcasecmp(term->config, value->name)) {
+						attr->config = key.type_and_num;
+						break;
+					}
+				}
+				if (attr->config == 0)
+					return -EINVAL;
+			} else {
+				union hwmon_pmu_event_key key = {
+					.type = type,
+					.num = number,
+				};
+
+				attr->config = key.type_and_num;
+			}
+			return 0;
+		}
+	}
+	if (err) {
+		char *err_str;
+
+		parse_events_error__handle(err, term->err_val,
+					asprintf(&err_str,
+						"unexpected hwmon event term (%s) %s",
+						parse_events__term_type_str(term->type_term),
+						term->config) < 0
+					? strdup("unexpected hwmon event term")
+					: err_str,
+					NULL);
+	}
+	return -EINVAL;
+}
+
+int hwmon_pmu__config_terms(const struct perf_pmu *pmu,
+			    struct perf_event_attr *attr,
+			    struct parse_events_terms *terms,
+			    struct parse_events_error *err)
+{
+	const struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
+	struct parse_events_term *term;
+
+	assert(pmu->sysfs_aliases_loaded);
+	list_for_each_entry(term, &terms->terms, list) {
+		if (hwmon_pmu__config_term(hwm, attr, term, err))
+			return -EINVAL;
+	}
+
+	return 0;
+
+}
+
+int hwmon_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_info *info,
+			   struct parse_events_error *err)
+{
+	struct parse_events_term *term =
+		list_first_entry(&terms->terms, struct parse_events_term, list);
+
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
+		enum hwmon_type type;
+		int number;
+
+		if (parse_hwmon_filename(term->config, &type, &number,
+					 /*item=*/NULL, /*is_alarm=*/NULL)) {
+			info->unit = hwmon_units[type];
+			if (type == HWMON_TYPE_FAN || type == HWMON_TYPE_PWM ||
+			    type == HWMON_TYPE_INTRUSION)
+				info->scale = 1;
+			else
+				info->scale = 0.001;
+		}
+		return 0;
+	}
+	if (err) {
+		char *err_str;
+
+		parse_events_error__handle(err, term->err_val,
+					asprintf(&err_str,
+						"unexpected hwmon event term (%s) %s",
+						parse_events__term_type_str(term->type_term),
+						term->config) < 0
+					? strdup("unexpected hwmon event term")
+					: err_str,
+					NULL);
+	}
+	return -EINVAL;
+}
+
+int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
+{
+	char *line = NULL;
+	DIR *class_hwmon_dir;
+	struct dirent *class_hwmon_ent;
+	char buf[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+
+	if (!sysfs)
+		return 0;
+
+	scnprintf(buf, sizeof(buf), "%s/class/hwmon/", sysfs);
+	class_hwmon_dir = opendir(buf);
+	if (!class_hwmon_dir)
+		return 0;
+
+	while ((class_hwmon_ent = readdir(class_hwmon_dir)) != NULL) {
+		size_t line_len;
+		int hwmon_dir, name_fd;
+		struct io io;
+
+		if (class_hwmon_ent->d_type != DT_LNK)
+			continue;
+
+		scnprintf(buf, sizeof(buf), "%s/class/hwmon/%s", sysfs, class_hwmon_ent->d_name);
+		hwmon_dir = open(buf, O_DIRECTORY);
+		if (hwmon_dir == -1) {
+			pr_debug("hwmon_pmu: not a directory: '%s/class/hwmon/%s'\n",
+				 sysfs, class_hwmon_ent->d_name);
+			continue;
+		}
+		name_fd = openat(hwmon_dir, "name", O_RDONLY);
+		if (name_fd == -1) {
+			pr_debug("hwmon_pmu: failure to open '%s/class/hwmon/%s/name'\n",
+				  sysfs, class_hwmon_ent->d_name);
+			close(hwmon_dir);
+			continue;
+		}
+		io__init(&io, name_fd, buf, sizeof(buf));
+		io__getline(&io, &line, &line_len);
+		if (line_len > 0 && line[line_len - 1] == '\n')
+			line[line_len - 1] = '\0';
+		hwmon_pmu__new(pmus, hwmon_dir, class_hwmon_ent->d_name, line);
+		close(name_fd);
+	}
+	free(line);
+	closedir(class_hwmon_dir);
+	return 0;
+}
+
+#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
+
+int evsel__hwmon_pmu_open(struct evsel *evsel,
+			  struct perf_thread_map *threads,
+			  int start_cpu_map_idx, int end_cpu_map_idx)
+{
+	struct hwmon_pmu *hwm = container_of(evsel->pmu, struct hwmon_pmu, pmu);
+	union hwmon_pmu_event_key key = {
+		.type_and_num = evsel->core.attr.config,
+	};
+	int idx = 0, thread = 0, nthreads, err = 0;
+
+	nthreads = perf_thread_map__nr(threads);
+	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
+		for (thread = 0; thread < nthreads; thread++) {
+			char buf[64];
+			int fd;
+
+			snprintf(buf, sizeof(buf), "%s%d_input",
+				 hwmon_type_strs[key.type], key.num);
+
+			fd = openat(hwm->hwmon_dir_fd, buf, O_RDONLY);
+			FD(evsel, idx, thread) = fd;
+			if (fd < 0) {
+				err = -errno;
+				goto out_close;
+			}
+		}
+	}
+	return 0;
+out_close:
+	if (err)
+		threads->err_thread = thread;
+
+	do {
+		while (--thread >= 0) {
+			if (FD(evsel, idx, thread) >= 0)
+				close(FD(evsel, idx, thread));
+			FD(evsel, idx, thread) = -1;
+		}
+		thread = nthreads;
+	} while (--idx >= 0);
+	return err;
+}
+
+int evsel__hwmon_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	char buf[32];
+	int fd;
+	ssize_t len;
+	struct perf_counts_values *count, *old_count = NULL;
+
+	if (evsel->prev_raw_counts)
+		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
+
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+	fd = FD(evsel, cpu_map_idx, thread);
+	len = pread(fd, buf, sizeof(buf), 0);
+	if (len <= 0) {
+		count->lost++;
+		return -EINVAL;
+	}
+	buf[len] = '\0';
+	if (old_count) {
+		count->val = old_count->val + strtoll(buf, NULL, 10);
+		count->run = old_count->run + 1;
+		count->ena = old_count->ena + 1;
+	} else {
+		count->val = strtoll(buf, NULL, 10);
+		count->run++;
+		count->ena++;
+	}
+	return 0;
+}
diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
new file mode 100644
index 000000000000..8061301fcd8e
--- /dev/null
+++ b/tools/perf/util/hwmon_pmu.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __HWMON_PMU_H
+#define __HWMON_PMU_H
+
+#include "pmu.h"
+
+struct list_head;
+
+/**
+ * enum hwmon_type:
+ *
+ * As described in Documentation/hwmon/sysfs-interface.rst hwmon events are
+ * defined over multiple files of the form <type><num>_<item>. This enum
+ * captures potential <type> values.
+ *
+ * This enum is exposed for testing.
+ */
+enum hwmon_type {
+	HWMON_TYPE_NONE,
+
+	HWMON_TYPE_CPU,
+	HWMON_TYPE_CURR,
+	HWMON_TYPE_ENERGY,
+	HWMON_TYPE_FAN,
+	HWMON_TYPE_HUMIDITY,
+	HWMON_TYPE_IN,
+	HWMON_TYPE_INTRUSION,
+	HWMON_TYPE_POWER,
+	HWMON_TYPE_PWM,
+	HWMON_TYPE_TEMP,
+
+	HWMON_TYPE_MAX
+};
+
+/**
+ * enum hwmon_item:
+ *
+ * Similar to enum hwmon_type but describes the item part of a a sysfs filename.
+ *
+ * This enum is exposed for testing.
+ */
+enum hwmon_item {
+	HWMON_ITEM_NONE,
+
+	HWMON_ITEM_ACCURACY,
+	HWMON_ITEM_ALARM,
+	HWMON_ITEM_AUTO_CHANNELS_TEMP,
+	HWMON_ITEM_AVERAGE,
+	HWMON_ITEM_AVERAGE_HIGHEST,
+	HWMON_ITEM_AVERAGE_INTERVAL,
+	HWMON_ITEM_AVERAGE_INTERVAL_MAX,
+	HWMON_ITEM_AVERAGE_INTERVAL_MIN,
+	HWMON_ITEM_AVERAGE_LOWEST,
+	HWMON_ITEM_AVERAGE_MAX,
+	HWMON_ITEM_AVERAGE_MIN,
+	HWMON_ITEM_BEEP,
+	HWMON_ITEM_CAP,
+	HWMON_ITEM_CAP_HYST,
+	HWMON_ITEM_CAP_MAX,
+	HWMON_ITEM_CAP_MIN,
+	HWMON_ITEM_CRIT,
+	HWMON_ITEM_CRIT_HYST,
+	HWMON_ITEM_DIV,
+	HWMON_ITEM_EMERGENCY,
+	HWMON_ITEM_EMERGENCY_HIST,
+	HWMON_ITEM_ENABLE,
+	HWMON_ITEM_FAULT,
+	HWMON_ITEM_FREQ,
+	HWMON_ITEM_HIGHEST,
+	HWMON_ITEM_INPUT,
+	HWMON_ITEM_LABEL,
+	HWMON_ITEM_LCRIT,
+	HWMON_ITEM_LCRIT_HYST,
+	HWMON_ITEM_LOWEST,
+	HWMON_ITEM_MAX,
+	HWMON_ITEM_MAX_HYST,
+	HWMON_ITEM_MIN,
+	HWMON_ITEM_MIN_HYST,
+	HWMON_ITEM_MOD,
+	HWMON_ITEM_OFFSET,
+	HWMON_ITEM_PULSES,
+	HWMON_ITEM_RATED_MAX,
+	HWMON_ITEM_RATED_MIN,
+	HWMON_ITEM_RESET_HISTORY,
+	HWMON_ITEM_TARGET,
+	HWMON_ITEM_TYPE,
+	HWMON_ITEM_VID,
+
+	HWMON_ITEM__MAX,
+};
+
+/** Strings that correspond to enum hwmon_type. */
+extern const char * const hwmon_type_strs[HWMON_TYPE_MAX];
+/** Strings that correspond to enum hwmon_item. */
+extern const char * const hwmon_item_strs[HWMON_ITEM__MAX];
+
+bool perf_pmu__is_hwmon(const struct perf_pmu *pmu);
+bool evsel__is_hwmon(const struct evsel *evsel);
+
+/**
+ * parse_hwmon_filename() - Parse filename into constituent parts.
+ *
+ * @filename: To be parsed, of the form <type><number>_<item>.
+ * @type: The type defined from the parsed file name.
+ * @number: The number of the type, for example there may be more than 1 fan.
+ * @item: A hwmon <type><number> may have multiple associated items.
+ * @alarm: Is the filename for an alarm value?
+ *
+ * An example of a hwmon filename is "temp1_input". The type is temp for a
+ * temperature value. The number is 1. The item within the file is an input
+ * value - the temperature itself. This file doesn't contain an alarm value.
+ *
+ * Exposed for testing.
+ */
+bool parse_hwmon_filename(const char *filename,
+			  enum hwmon_type *type,
+			  int *number,
+			  enum hwmon_item *item,
+			  bool *alarm);
+
+/**
+ * hwmon_pmu__new() - Allocate and construct a hwmon PMU.
+ *
+ * @pmus: The list of PMUs to be added to.
+ * @hwmon_dir: An O_DIRECTORY file descriptor for a hwmon directory.
+ * @sysfs_name: Name of the hwmon sysfs directory like hwmon0.
+ * @name: The contents of the "name" file in the hwmon directory.
+ *
+ * Exposed for testing. Regular construction should happen via
+ * perf_pmus__read_hwmon_pmus.
+ */
+struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir,
+				const char *sysfs_name, const char *name);
+void hwmon_pmu__exit(struct perf_pmu *pmu);
+
+int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+size_t hwmon_pmu__num_events(struct perf_pmu *pmu);
+bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name);
+int hwmon_pmu__config_terms(const struct perf_pmu *pmu,
+			    struct perf_event_attr *attr,
+			    struct parse_events_terms *terms,
+			    struct parse_events_error *err);
+int hwmon_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_info *info,
+			   struct parse_events_error *err);
+
+int perf_pmus__read_hwmon_pmus(struct list_head *pmus);
+
+
+int evsel__hwmon_pmu_open(struct evsel *evsel,
+			 struct perf_thread_map *threads,
+			 int start_cpu_map_idx, int end_cpu_map_idx);
+int evsel__hwmon_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
+
+#endif /* __HWMON_PMU_H */
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index e400db9e9eb1..10f23f48479b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -37,6 +37,8 @@ struct perf_pmu_caps {
 };
 
 enum {
+	PERF_PMU_TYPE_HWMON_START = 0xFFFF0000,
+	PERF_PMU_TYPE_HWMON_END   = 0xFFFFFFFD,
 	PERF_PMU_TYPE_TOOL = 0xFFFFFFFE,
 	PERF_PMU_TYPE_FAKE = 0xFFFFFFFF,
 };
-- 
2.47.0.rc1.288.g06298d1525-goog


