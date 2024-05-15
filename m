Return-Path: <linux-kernel+bounces-179500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5DE8C608D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04183B23C88
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE6A43156;
	Wed, 15 May 2024 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHYXIAKo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC543ABE
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752884; cv=none; b=K3AQ+1qFVwnn3FAtXQ3e75bNj/qHzeFK8bNmp5jEO0NXyfseurL1By+0KCpxhZ1nv8NIFnXvTA0hZgmFIkkGejovEYvSwyTTNAWarM8uEZPwfIfPzBKwAqVQ0Y9lbvBr/Sz92X+yK8Ls7X/UR+EEZ6KNEs+cJbQFgV4N6dAceTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752884; c=relaxed/simple;
	bh=SUmGhn7U8Bhn0LJUMjbbdvaJXGbSc6Bswuda7N7OrT4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Po7FulMkvq6RVPBesX2lLsebrwYaS+QQ8AQXdTkeBJU42VXykBBPPR0NMhhtpq3fNEj9zJmW/uVAXp/VkiQphCWenKI/qIdIANA4RqZsRXZxk3oD1NtWLA3lstmC1HtlHrcjZr681AJ4MmcZYRT8u4OFGW088RiLdkjct7XwuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHYXIAKo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bed763956so120103767b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 23:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715752882; x=1716357682; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbt3+oOgWiYhvdlIPoeQ0dzOgUp0iTplIsC7hc2pJ+U=;
        b=lHYXIAKofUYWwYfcakeEYAxQphwSmk20PXmItI3ckRjKSnHFBmTuf5AjefUEpXkgYL
         qmn3yw0+kX8kB6Abr1rPx98KsMNmskAf+xLlhLYlthqD6UavTQsmIcPs0XY3j0wnlRp3
         lbodQzaj3ImeY1PCmCNBEazuYuef1CmisiCmjrlpwm6LcfvZaehxhtSemTVqk2XgWfVe
         MeG2zQH8nnfKwagk/BLqaTDxszAtP774M6htaI8BXO64bJNgEfutnefJ3gvXss6/LbKG
         KEGOV1AnE+qBgsDPkmBLSPenms3hbqLuM9irVIraX+/l2C2aMbTcHOOwY9BuOcr6IAHD
         wcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715752882; x=1716357682;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbt3+oOgWiYhvdlIPoeQ0dzOgUp0iTplIsC7hc2pJ+U=;
        b=UbjISbEFKqzXSKwBFxwbvh8bIAy/tP2xxdUtndk1cTRjZDjR9WO2EyN4Z89/1tyLDM
         3N3depdGN1A0roQq7+bWCyM2nhb+2MO+/yEDNTMNMsUTZHgWdnpgWH4aza0pycZgxWtm
         kUGRJA7qbuymiUmkZZ80f7mItocOVnEV8ragSz05PbIcYCnfYefgjPwsHP/h349ClXmx
         FbCAYWmRftTIamvuPdA2ueO01EIBDU+L7OQNvVRj6vFllb51ldWSN4E5SvrKWPRelkXu
         5CfjM+TDoKvlfKgcGxtJitXFo+t3FmLholPY9o4DrAMR7xjYs/nnRGybs4blB2PfmIrF
         Z4eA==
X-Forwarded-Encrypted: i=1; AJvYcCWxirttK6M7/XFG8T2fs4hpH8yD0kWWnUM7tUFP9B/Avgy3/EOcxn0alKxVw3plWPNAqI7k6uZRXQkTPwlAwmo+fYZVrmb0knKaG7y/
X-Gm-Message-State: AOJu0YwgMh5H8L6XUZ2oYSjWo4g9u7Q45FiAJ3nh2s6+KxwMEsPeXl6X
	TrfV/ufnFJ8Sr08Zj31MORRrSKtgQA5DSHEy8jamiw2QqnNTcaLyletRSTgN21/3fcOCIOP1NJW
	M/i1JmA==
X-Google-Smtp-Source: AGHT+IEYbruynMzwQTf+H5YajmkeOApfArgyEh3Z0hkcdqCiUJOLMAgirPQdXuz0xbnoJkwoe34enSuu9/dP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a05:6902:149:b0:de5:5225:c3a4 with SMTP id
 3f1490d57ef6-dee4f304cb7mr3523816276.7.1715752882040; Tue, 14 May 2024
 23:01:22 -0700 (PDT)
Date: Tue, 14 May 2024 23:01:14 -0700
In-Reply-To: <20240515060114.3268149-1-irogers@google.com>
Message-Id: <20240515060114.3268149-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515060114.3268149-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 2/2] perf tests: Add some pmu core functionality tests
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


