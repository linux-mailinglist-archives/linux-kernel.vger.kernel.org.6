Return-Path: <linux-kernel+bounces-402545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27139C28EB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A51F23051
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A343FB9C;
	Sat,  9 Nov 2024 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMp71Gqw"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DD1E505
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112691; cv=none; b=nPRungQheGtLd8GJBgMFaYISqFsJUxXUC76UFaXQZ7SNVVNsv7zyEsPB8oJpLbPIZnxydRkNZCviH3aHbYSqgPNTukvLIWZfUq1+J6HlXJ97kg1sxJaNlHb85Cdv7yVH883gixQe66cUK4C9KDh5Fm5L99GqQSn5ssc4DU7K/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112691; c=relaxed/simple;
	bh=EPHABW4Dal5OoWmB5VB9qYe0tkW5pDWGRMOxZWg45/8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DP/Px553wCk62acETzBsVZL9GCUy5Orf6jDcXgmeSJcC+WyeyoP/QDDp+aErY/R8IY28twKCfq/tYszeFpoNUxMmlZGRf1Mqbw5vlpKbjpbtevsEXmcf/BAPgCyG5ibhz17MkSWvOXGk+58QIGPDjli58B8aSpBaIXMB4dx1yYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMp71Gqw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea86f1df79so52116407b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112688; x=1731717488; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTiUHf6g81o8sTIu2Q+yefZ91ahAjUlTz9BdmD6fp2A=;
        b=vMp71GqwHoSgPpYbGo0okBqH1jkJtEmB4GlVq3fF59EcKSmamAbQvaTzim9mQrGWXT
         ypB8ooE1Tc2st4HB4WkQJuB+Jo4EnkpuTdmabSxIdmh+gNYPRwa9lVNbZjNzJjE6Pj3C
         tHzNaW8xrAVYb45UTFvR6q0c6e+C2v+Q02DTsrgdNV8ErTtBTMyzAsYYf/YHgJFxC1jR
         nysiXyuLytTQnmLof0YRRujTCCYaPdhHL6WtWKRYZKRibe/zGwo07aE3AQ15qU5SDazC
         rL4bwAjXL5xL84dwVGKf2qoz6ysfGDMrOX6UWsTv/fKURM7yG5Ep8pr4eRztOc6ksQWA
         vMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112688; x=1731717488;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTiUHf6g81o8sTIu2Q+yefZ91ahAjUlTz9BdmD6fp2A=;
        b=MQOGdn+10R1r6OIXnlGrCd9yjs1fn9BXaA6kTe+oxWm2Qh3GiBkISrSNInzDS7dsvv
         /t4gDHefoVVZUO4m3+lg9iQpb9P7rmbMwXFoBV0UuJ+aH5xRldu2ewWhwkxy2n+HBUrB
         sp2xwSsQPD2Bv9cbExqao9pEDABWaE8niLrrZLIRYlx/jOaKVYQZiNc7arLbcz1Gj1Wd
         vLNMvNGe3HXHhdSFTukQW8Slzx0BiHhjA6FoKPqcAm4S4yygv7HT5k7oV7YD1Uk+wZQm
         BhhclefZ8OnvH3BrsKyXUvFBNdue8xcj4v8CEpqtp0vA9/rHzp/YhpJsfnq4zhu9kvAs
         CePA==
X-Forwarded-Encrypted: i=1; AJvYcCXMO4IX7t6KOiwrGaWNqEF4nUqFyktosvkl50QhbZ6JF6RDCqtLNT01wFdM8Los7dx/wL6dR/s96IwiR8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxivtmUQBJhyrjICrVMnDq+gFMMDIapCCOp6aJh9qeLXBi+erk
	Jx6l02sp+7qiaYVTtxKb9RkPJHY57tGeBo4xyZsdiLHK9IHStCmVtNeZZT3xk6wHNswvzgkP08B
	Wq67NpQ==
X-Google-Smtp-Source: AGHT+IF6gQvvK5Lil5+ng0LPpg9X8rdu8LgEF9SDR8ig2x/8mDlSkvbT3HqLAYHEhF+R6ExZ4n87L1KB3LEL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a05:690c:200f:b0:6ea:34c3:742b with SMTP
 id 00721157ae682-6eaddfad76amr477787b3.6.1731112688654; Fri, 08 Nov 2024
 16:38:08 -0800 (PST)
Date: Fri,  8 Nov 2024 16:37:54 -0800
In-Reply-To: <20241109003759.473460-1-irogers@google.com>
Message-Id: <20241109003759.473460-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003759.473460-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v9 2/7] perf hwmon_pmu: Add hwmon filename parser
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
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hwmon filenames have a specific encoding that will be used to give a
config value. The encoding is described in:
Documentation/hwmon/sysfs-interface.rst
Add a function to parse the filename into consituent enums/ints that
will then be amenable to config encoding.

Note, things are done this way to allow mapping names to config and
back without the use of hash/dynamic lookup tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build       |   1 +
 tools/perf/util/hwmon_pmu.c | 144 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/hwmon_pmu.h | 111 +++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1eedead5f2f2..78b990c04f71 100644
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
index 000000000000..8791e55097dc
--- /dev/null
+++ b/tools/perf/util/hwmon_pmu.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "debug.h"
+#include "hwmon_pmu.h"
+#include <assert.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/kernel.h>
+
+/** Strings that correspond to enum hwmon_type. */
+static const char * const hwmon_type_strs[HWMON_TYPE_MAX] = {
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
+/** Strings that correspond to enum hwmon_item. */
+static const char * const hwmon_item_strs[HWMON_ITEM__MAX] = {
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
+	for (size_t i = 0; fn_type[i] != '\0'; i++) {
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
+		strlcpy(fn_type, fn_item, fn_item_len - 5);
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
diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
new file mode 100644
index 000000000000..df0ab5ff7534
--- /dev/null
+++ b/tools/perf/util/hwmon_pmu.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __HWMON_PMU_H
+#define __HWMON_PMU_H
+
+#include <stdbool.h>
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
+#endif /* __HWMON_PMU_H */
-- 
2.47.0.277.g8800431eea-goog


