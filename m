Return-Path: <linux-kernel+bounces-178212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6A68C4A78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DAE1F21FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAA5EDC;
	Tue, 14 May 2024 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZaD1fIn"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D4AD55
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715646520; cv=none; b=IJ7IXiF5FyuR5KQ1kXZCu4A9eZCDoTcFbdy4fr5JoUcSRqe6vgS7l0ZlH4xGv+G4xPFH8cv0XRjH+Pi6Kl+zZQUJ+q6/G+i0TeKSk2i8pctk8nP6RTYv4GycwXcraJGeN9ntrVxutIyZ9tZd9vwTMdO7WvcEd2jh7yoaZDVQ0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715646520; c=relaxed/simple;
	bh=SUmGhn7U8Bhn0LJUMjbbdvaJXGbSc6Bswuda7N7OrT4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=prms88GOtsbjhek4Mvqpcoy2Al5JfMG61gH2y240QeTHMgvMdzxTrbz3AGfaa2RJmW2cTYt3GClJJxZ9SxEI/zr6rAybDo5NFcdrU5gre7K830O5lIvIpc2wfjn5X7CFcqDHxIOJQJURhJYIgi7XG8m+/OuvGuV0n8Myfayphf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZaD1fIn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be26af113so84622787b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715646517; x=1716251317; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbt3+oOgWiYhvdlIPoeQ0dzOgUp0iTplIsC7hc2pJ+U=;
        b=eZaD1fIn099M6hxuUfgtSJwVC6VxgSxZTtwwLzNTZduGemc0z3i8+408YG2o2LHDsg
         8lnlxu47xHP6ClN5Cwe8ur2yIEr4fE8TWrxUyfyXiq1bVhzlCGe4PI6Usozsod/R+Qga
         YS5rpwPWk8MG/8E3yIUan35EG0BvaTG/quwXAm338lDtG8D9Wl2lnlxdIHXmDeS18zuj
         7yTk9vxJLTWiQuI/F9958bNhdkrXvjuo8iBFZ2qbEr0l3bvNYywK6TpJDz7CZL/jQgDI
         mQujagWOjWxSxtWLTqmsS/xr7+DyOHQ7CEmXtQ/+ApDfDqV0Ed7Ztd9rkdqafI+N4fHs
         MWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715646517; x=1716251317;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbt3+oOgWiYhvdlIPoeQ0dzOgUp0iTplIsC7hc2pJ+U=;
        b=koYFjGHS0togYr+XjtMPUnzM9wlk17mp/NOCMZQB++JYNz6WG0dKveO1BmjrgLnYvf
         kDy3lnDfL3rCGj+IRLWLmWJOIl+sb3N3/jnAnAzEHhk9O+wZ2v4JLBp3FT0LPTiOQYvB
         Rf8Z9QNXW2TGsot/7lscvwHP8JoPmOe+ugJOjCicjYSYIYmFR9GBcBYeIuekUk+2uLAk
         SjDcLE0JXwgA4m7yZ/qABKfmRxmveOCZ/vGCmJybltSGckIGXvXxRBuO7coGrwpbOD1n
         hA7Qw2QEEfB7zsD1LMau1YES/NQB1dVVkzRbguxS8dq+8e93Q4wNeHTKmavBHpwTR7uY
         M+Og==
X-Forwarded-Encrypted: i=1; AJvYcCXJtJC0z9mAo/CBhPNK/kyyPTslm2klzBg1WhtL0Y7F8BWRWgGPtu3tNeq2ybnaKdtOo8eeR6uRFd+SG6Wi26Ky3tlMrZKnWtMtwxCD
X-Gm-Message-State: AOJu0YzMBNWtn0j1ZaReAGS8d48RIfYhxOZogvZJ9HYwoXPiaAPLuu86
	VuyrQyW/z4YIDUwoU7u7FXpHcD15JBzRFN2VvRb5nPqPQKjPksfaEiRSatMFj2Cs6GsZyBc3Sie
	Arbq4bw==
X-Google-Smtp-Source: AGHT+IHQD7xGxCLt2zUsv4OEAubQ6r/mlZ90Y2ApAoSQfOKnps9AqMkExIdjvLWy3Q7dTjWEOhS3jupGto/a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a05:6902:1081:b0:dee:80d7:e72d with SMTP
 id 3f1490d57ef6-dee80d7e8e3mr433174276.7.1715646516967; Mon, 13 May 2024
 17:28:36 -0700 (PDT)
Date: Mon, 13 May 2024 17:28:17 -0700
In-Reply-To: <20240514002817.2896240-1-irogers@google.com>
Message-Id: <20240514002817.2896240-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240514002817.2896240-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 2/2] perf tests: Add some pmu core functionality tests
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

Test behavior of PMU names and comparisons wrt suffixes using Intel
uncore_cha, marvell mrvl_ddr_pmu and S390's cpum_cf as examples.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 06cc0e46cb28..cc88b5920c3e 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -3,6 +3,7 @@
 #include "evsel.h"
 #include "parse-events.h"
 #include "pmu.h"
+#include "pmus.h"
 #include "tests.h"
 #include "debug.h"
 #include "fncache.h"
@@ -340,10 +341,108 @@ static int test__pmu_event_names(struct test_suite *test __maybe_unused,
 	return ret;
 }
 
+static const char * const uncore_chas[] = {
+	"uncore_cha_0",
+	"uncore_cha_1",
+	"uncore_cha_2",
+	"uncore_cha_3",
+	"uncore_cha_4",
+	"uncore_cha_5",
+	"uncore_cha_6",
+	"uncore_cha_7",
+	"uncore_cha_8",
+	"uncore_cha_9",
+	"uncore_cha_10",
+	"uncore_cha_11",
+	"uncore_cha_12",
+	"uncore_cha_13",
+	"uncore_cha_14",
+	"uncore_cha_15",
+	"uncore_cha_16",
+	"uncore_cha_17",
+	"uncore_cha_18",
+	"uncore_cha_19",
+	"uncore_cha_20",
+	"uncore_cha_21",
+	"uncore_cha_22",
+	"uncore_cha_23",
+	"uncore_cha_24",
+	"uncore_cha_25",
+	"uncore_cha_26",
+	"uncore_cha_27",
+	"uncore_cha_28",
+	"uncore_cha_29",
+	"uncore_cha_30",
+	"uncore_cha_31",
+};
+
+static const char * const mrvl_ddrs[] = {
+	"mrvl_ddr_pmu_87e1b0000000",
+	"mrvl_ddr_pmu_87e1b1000000",
+	"mrvl_ddr_pmu_87e1b2000000",
+	"mrvl_ddr_pmu_87e1b3000000",
+	"mrvl_ddr_pmu_87e1b4000000",
+	"mrvl_ddr_pmu_87e1b5000000",
+	"mrvl_ddr_pmu_87e1b6000000",
+	"mrvl_ddr_pmu_87e1b7000000",
+	"mrvl_ddr_pmu_87e1b8000000",
+	"mrvl_ddr_pmu_87e1b9000000",
+	"mrvl_ddr_pmu_87e1ba000000",
+	"mrvl_ddr_pmu_87e1bb000000",
+	"mrvl_ddr_pmu_87e1bc000000",
+	"mrvl_ddr_pmu_87e1bd000000",
+	"mrvl_ddr_pmu_87e1be000000",
+	"mrvl_ddr_pmu_87e1bf000000",
+};
+
+static int test__name_len(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_VAL("cpu", pmu_name_len_no_suffix("cpu") == strlen("cpu"));
+	TEST_ASSERT_VAL("i915", pmu_name_len_no_suffix("i915") == strlen("i915"));
+	TEST_ASSERT_VAL("cpum_cf", pmu_name_len_no_suffix("cpum_cf") == strlen("cpum_cf"));
+	for (size_t i = 0; i < ARRAY_SIZE(uncore_chas); i++) {
+		TEST_ASSERT_VAL("Strips uncore_cha suffix",
+				pmu_name_len_no_suffix(uncore_chas[i]) ==
+				strlen("uncore_cha"));
+	}
+	for (size_t i = 0; i < ARRAY_SIZE(mrvl_ddrs); i++) {
+		TEST_ASSERT_VAL("Strips mrvl_ddr_pmu suffix",
+				pmu_name_len_no_suffix(mrvl_ddrs[i]) ==
+				strlen("mrvl_ddr_pmu"));
+	}
+	return TEST_OK;
+}
+
+static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_EQUAL("cpu", pmu_name_cmp("cpu", "cpu"), 0);
+	TEST_ASSERT_EQUAL("i915", pmu_name_cmp("i915", "i915"), 0);
+	TEST_ASSERT_EQUAL("cpum_cf", pmu_name_cmp("cpum_cf", "cpum_cf"), 0);
+	TEST_ASSERT_VAL("i915", pmu_name_cmp("cpu", "i915") < 0);
+	TEST_ASSERT_VAL("i915", pmu_name_cmp("i915", "cpu") > 0);
+	TEST_ASSERT_VAL("cpum_cf", pmu_name_cmp("cpum_cf", "cpum_ce") > 0);
+	TEST_ASSERT_VAL("cpum_cf", pmu_name_cmp("cpum_cf", "cpum_d0") < 0);
+	for (size_t i = 1; i < ARRAY_SIZE(uncore_chas); i++) {
+		TEST_ASSERT_VAL("uncore_cha suffixes ordered lt",
+				pmu_name_cmp(uncore_chas[i-1], uncore_chas[i]) < 0);
+		TEST_ASSERT_VAL("uncore_cha suffixes ordered gt",
+				pmu_name_cmp(uncore_chas[i], uncore_chas[i-1]) > 0);
+	}
+	for (size_t i = 1; i < ARRAY_SIZE(mrvl_ddrs); i++) {
+		TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered lt",
+				pmu_name_cmp(mrvl_ddrs[i-1], mrvl_ddrs[i]) < 0);
+		TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered gt",
+				pmu_name_cmp(mrvl_ddrs[i], mrvl_ddrs[i-1]) > 0);
+	}
+	return TEST_OK;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
 	TEST_CASE("Parsing with PMU event", pmu_events),
 	TEST_CASE("PMU event names", pmu_event_names),
+	TEST_CASE("PMU name combining", name_len),
+	TEST_CASE("PMU name comparison", name_cmp),
 	{	.name = NULL, }
 };
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


