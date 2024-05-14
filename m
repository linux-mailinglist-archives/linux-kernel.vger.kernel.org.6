Return-Path: <linux-kernel+bounces-178202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9330E8C4A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B17B23B33
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482927FB;
	Tue, 14 May 2024 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGbezZGn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5517C17EF
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715645666; cv=none; b=Y3x9dsnCCz+A++qnWXnO1vOYaPfIYBd2QDh1hxlb7yIspUUbeEvjNTf00Mtcbexa9cWGOkaec4/T0VvXG89lWy+V2QyOqmhrer+sqg7deUGvlm+D/ZHeFAUEaTlG4ruI1YU1JistHnSoMC5QstSpBzeqjdCIfsQgo1etgg777z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715645666; c=relaxed/simple;
	bh=Q9ij4xWg7mDgY3wC/3BcIVhLqg29X2TIwwPIMkcdJE4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RBT8FLAg5kb6DKwRkDaTnEDV1VKcIE6em0s4WTMEqZrlaYk+ktnQh15Yb+aJV+hlv0+HXz67ZTPHGUyV+Mpc8Cid6ADzgP+5085umqmltiiwkI609BUGzXh5+a3cpNNDaNwUv54gA920dX6uCyt1sr7JaXysU1yoQklxMFINmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGbezZGn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-622cd439764so42916717b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715645662; x=1716250462; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xwJdbGGW+Z7XAV8KPdTULv2HcS04UI63fKtEqifeow=;
        b=rGbezZGny6RjkrEgxBQXbtrY6ZcJyVDfgUz2lcyN89v60mWlmFe/jKDU+VQecgEgrp
         pVtgnOsk5+gaam8rsbcimL/U4/5ueBG5mPIYI+iEnrvFX+/g/TwrThtsU6V8oTdTWFoo
         kXypCyxyNShCUXkohG/kCXfGpzqnzt9LDScmZ4wq1N1RODIQJxdU41oT51D8m+44e43w
         7wiaCw7K4Pmi/u6VZtaXetFnwhy5rp4DvRulolKje5Nm1NAewCu9YhgyJ9ZzB9WGmwIZ
         mAQN9UowWsm33cmTcxWUBV4nkmAydLZXyiB8fn9ZdUBpT2Vx8eqvWKsxaNVdUutRRPgc
         GlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715645662; x=1716250462;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xwJdbGGW+Z7XAV8KPdTULv2HcS04UI63fKtEqifeow=;
        b=SDP7Zs1OpCLEoMOGjFX292YL6fXtnLJ2MasjJ9x93u/k/qrguO8CbBtgQR8OB4Oj3A
         HVsROtpIGzjtjE7yF9p6fxI9P7pKRJlfXNIp2bwZ2RVefO3gWQUbO1SU/IctbY4XHfXN
         pm5xr4iHOZqKueuFoRTZ/uuxtYbt2TAd+vKB7z6s3YeJN5Jv29O78NeC9+uedQ7rhAMA
         HhYbrtN90H0m0DAI7jZoPNqn30ZGfHL8LVpsEJ1Fm4TWTnweCtkk/SFIDcOsWlLW7D+F
         7ryrQe/1cj3mAyr/raOZDPs0WWlpCEcO/QtygygatG2Rs2oVn7LzwQxHKAJh46boWiTy
         Ytrw==
X-Forwarded-Encrypted: i=1; AJvYcCUlj2XLVr2g7ipjLixtHW7sd9wc+zZ8s+Se2NXT4ZBR4P6ZTr0yL21HL9FSWahUBF3IKOUH/sUY/r4yy1fHI3PfTNQ2N9ihMmlQd804
X-Gm-Message-State: AOJu0Yx8Cz5n4iNNmDdRbPM2sxgg/3yP9gAEtOX2qxOlK6eI05pTL9X7
	oOJHVY2HRi7sOtiGujiILbB66wLaZKR+ofyGNyQPJSE/6/Ysu/+dfw2DxSub9o04g+Tt8djt0sV
	Zbcy6Bw==
X-Google-Smtp-Source: AGHT+IHNdBQKwX2lqvKQWT0wLRq1Oa+OKSz7aHOjYSHao9LLLzLmASUgkeV+VcqmvERpR3UXbxe0cGqjiS0h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a05:690c:490d:b0:617:d650:11e2 with SMTP
 id 00721157ae682-622affbfd57mr30576877b3.3.1715645662360; Mon, 13 May 2024
 17:14:22 -0700 (PDT)
Date: Mon, 13 May 2024 17:13:58 -0700
In-Reply-To: <20240514001359.2882951-1-irogers@google.com>
Message-Id: <20240514001359.2882951-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240514001359.2882951-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v4 1/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
From: Ian Rogers <irogers@google.com>
To: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
the previous PMU sorting/merging code assumes uncore PMU names start
with uncore_ and have a decimal suffix. Because of the previous
assumption it isn't possible to wildcard the mrvl_ddr_pmu.

Modify pmu_name_len_no_suffix but also remove the suffix number out
argument, this is because we don't know if a suffix number of say 100
is in hexadecimal or decimal. As the only use of the suffix number is
in comparisons, it is safe there to compare the values as hexadecimal.

Only allow hexadecimal suffixes to be greater than length 2 (ie 3 or
more) so that S390's cpum_cf PMU doesn't lose its suffix.

Change the return type of pmu_name_len_no_suffix to size_t to
workaround GCC incorrectly determining the result could be negative.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 17 +++++------
 tools/perf/util/pmus.c | 67 ++++++++++++++++++++++++------------------
 tools/perf/util/pmus.h |  7 ++++-
 3 files changed, 53 insertions(+), 38 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 888ce9912275..f359354070fa 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1788,10 +1788,10 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 			  const struct perf_pmu_alias *alias, bool skip_duplicate_pmus)
 {
 	struct parse_events_term *term;
-	int pmu_name_len = skip_duplicate_pmus
-		? pmu_name_len_no_suffix(pmu->name, /*num=*/NULL)
-		: (int)strlen(pmu->name);
-	int used = snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->name, alias->name);
+	size_t pmu_name_len = skip_duplicate_pmus
+		? pmu_name_len_no_suffix(pmu->name)
+		: strlen(pmu->name);
+	int used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
 
 	list_for_each_entry(term, &alias->terms.terms, list) {
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
@@ -1828,13 +1828,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
-		size_t buf_used;
-		int pmu_name_len;
+		size_t buf_used, pmu_name_len;
 
 		info.pmu_name = event->pmu_name ?: pmu->name;
 		pmu_name_len = skip_duplicate_pmus
-			? pmu_name_len_no_suffix(info.pmu_name, /*num=*/NULL)
-			: (int)strlen(info.pmu_name);
+			? pmu_name_len_no_suffix(info.pmu_name)
+			: strlen(info.pmu_name);
 		info.alias = NULL;
 		if (event->desc) {
 			info.name = event->name;
@@ -1859,7 +1858,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		info.encoding_desc = buf + buf_used;
 		parse_events_terms__to_strbuf(&event->terms, &sb);
 		buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-				"%.*s/%s/", pmu_name_len, info.pmu_name, sb.buf) + 1;
+				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, sb.buf) + 1;
 		info.topic = event->topic;
 		info.str = sb.buf;
 		info.deprecated = event->deprecated;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b9b4c5eb5002..63b9cf9ccfa7 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -40,31 +40,52 @@ static bool read_sysfs_all_pmus;
 
 static void pmu_read_sysfs(bool core_only);
 
-int pmu_name_len_no_suffix(const char *str, unsigned long *num)
+size_t pmu_name_len_no_suffix(const char *str)
 {
 	int orig_len, len;
+	bool has_hex_digits = false;
 
 	orig_len = len = strlen(str);
 
-	/* Non-uncore PMUs have their full length, for example, i915. */
-	if (!strstarts(str, "uncore_"))
-		return len;
-
-	/*
-	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
-	 * the full length.
-	 */
-	while (len > 0 && isdigit(str[len - 1]))
+	/* Count trailing digits. */
+	while (len > 0 && isxdigit(str[len - 1])) {
+		if (!isdigit(str[len - 1]))
+			has_hex_digits = true;
 		len--;
+	}
 
 	if (len > 0 && len != orig_len && str[len - 1] == '_') {
-		if (num)
-			*num = strtoul(&str[len], NULL, 10);
-		return len - 1;
+		/*
+		 * There is a '_{num}' suffix. For decimal suffixes any length
+		 * will do, for hexadecimal ensure more than 2 hex digits so
+		 * that S390's cpum_cf PMU doesn't match.
+		 */
+		if (!has_hex_digits || (orig_len - len) > 2)
+			return len - 1;
 	}
+	/* Use the full length. */
 	return orig_len;
 }
 
+int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
+{
+	unsigned long lhs_num = 0, rhs_num = 0;
+	size_t lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name);
+	size_t rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name);
+	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
+			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
+
+	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
+		return ret;
+
+	if (lhs_pmu_name_len + 1 < strlen(lhs_pmu_name))
+		lhs_num = strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
+	if (rhs_pmu_name_len + 1 < strlen(rhs_pmu_name))
+		rhs_num = strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
+
+	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+}
+
 void perf_pmus__destroy(void)
 {
 	struct perf_pmu *pmu, *tmp;
@@ -167,20 +188,10 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 static int pmus_cmp(void *priv __maybe_unused,
 		    const struct list_head *lhs, const struct list_head *rhs)
 {
-	unsigned long lhs_num = 0, rhs_num = 0;
 	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
 	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
-	const char *lhs_pmu_name = lhs_pmu->name ?: "";
-	const char *rhs_pmu_name = rhs_pmu->name ?: "";
-	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
-	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);
-	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
-			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
-
-	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
-		return ret;
 
-	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+	return pmu_name_cmp(lhs_pmu->name ?: "", rhs_pmu->name ?: "");
 }
 
 /* Add all pmus in sysfs to pmu list: */
@@ -300,11 +311,11 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 		pmu_read_sysfs(/*core_only=*/false);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	} else
-		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", NULL);
+		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 	if (use_core_pmus) {
 		list_for_each_entry_continue(pmu, &core_pmus, list) {
-			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 			if (last_pmu_name_len == pmu_name_len &&
 			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
@@ -316,7 +327,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 		pmu = list_prepare_entry(pmu, &other_pmus, list);
 	}
 	list_for_each_entry_continue(pmu, &other_pmus, list) {
-		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 		if (last_pmu_name_len == pmu_name_len &&
 		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
@@ -566,7 +577,7 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 			.long_string = STRBUF_INIT,
 			.num_formats = 0,
 		};
-		int len = pmu_name_len_no_suffix(pmu->name, /*num=*/NULL);
+		int len = pmu_name_len_no_suffix(pmu->name);
 		const char *desc = "(see 'man perf-list' or 'man perf-record' on how to encode it)";
 
 		if (!pmu->is_core)
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 9d4ded80b8e9..fa6df53b52ab 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -2,10 +2,15 @@
 #ifndef __PMUS_H
 #define __PMUS_H
 
+#include <stdbool.h>
+#include <linux/list.h>
+
 struct perf_pmu;
 struct print_callbacks;
 
-int pmu_name_len_no_suffix(const char *str, unsigned long *num);
+size_t pmu_name_len_no_suffix(const char *str);
+/* Exposed for testing only. */
+int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
 
 void perf_pmus__destroy(void);
 
-- 
2.45.0.118.g7fe29c98d7-goog


