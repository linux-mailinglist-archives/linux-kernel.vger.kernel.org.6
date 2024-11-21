Return-Path: <linux-kernel+bounces-416442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D69D44D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5456B21B92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C802E4409;
	Thu, 21 Nov 2024 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ajyfkrv6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907021FB3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147805; cv=none; b=tROzyWLYuUUFqBOtDhGg2FrCynbISkg2WBa+BrdWS6WTr26KNMnuH23q7NLIoPfJfL/fdfrGKHfspIGpauxLYMGgKTTb8erMZ6vPU/HMbHSmPgSMyHNs3eBiTdzn7nD9bdCTu2YXN2+gyZFTf4c2FoU+PPNH1ZU4VYR2tHBHP9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147805; c=relaxed/simple;
	bh=O/yMNZrirBScAgKI94cBzqEnvOowo0MA6z0q16DxO1A=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=etjb8HspxzNix1M7AFFVsFWHFxnutasbgkBQEAnVNEq0+gE/xN5S0mvtHJbpc/XYRV54T9HWkAuM2iOsXc5HFWHEi2M8mwlqlIJbv+bcV0KSR4e2VKH8sm0LsoL0w4HXM7aMbI22auTldfhCdymBBX2rsNqVDVaCUDNHaVn+8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ajyfkrv6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eecc0fe396so3548927b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732147802; x=1732752602; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uGFxFptMJQAFIjN9wGwiYhVq63M4S9vZgunlbNZee5s=;
        b=Ajyfkrv615pYU0OoW9g9GyvbMhPAgKObeGPTv7N7eMRiGutkFURpyT8PeyLQtPkFC9
         dgcjNmpTWFN8R9hRYHaiySTZKdE1fyg6l2Cvus6MpptFNR4XXotrLTGvZ9jiqT7pXoEI
         pxTCztFVVGYC79tZHe6AD9nfZDKEbOcoYzx6XrHDjK4ZzUP5uAPFsIgOKnvkjYZk+gtW
         YHOtYEyJyODEbVTePBE9C3tQFnUhRs+IPLtYlPjuSBGNczSwE2hn3Kcq1ueXBwVR7YDA
         0yi0NGBohgXgbv8nYqdpvLfUmBD1EKqD4CRVAFMiyQUguKbqOQpjwihwU22vyBQEYo3L
         P8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732147802; x=1732752602;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGFxFptMJQAFIjN9wGwiYhVq63M4S9vZgunlbNZee5s=;
        b=L8WvATxpDb5Un8XNRTxKiWTdkewAqz9EbYO5oZpnlB22DBmf5kyYpcpuRqmNBG7dV/
         YdgJ1PR5NXmIkm6ICLx3zoKssKrXkAZnVXFMc4KkK2C4QC0ASZFZ63biLJwbK5haDHhd
         rUCcstvDh+XOtCJJJPeZqFM26wpr4fuhWqWmKJ6W2UBuOpZdxdKL+g5Yan0yY2a97Aju
         paF9NCJ1spBubh3/a8Gf7tgbWKF1FHVQMuxOlBkvxTxU3OK5N/wE8EJ7lsDmLQIOx8GV
         ZDcxtieoY+d2AGQCPTTk9UpKCdZlYn1BTxMo16T298Ril2etSW0zJJb/bKy9XfiJoqNV
         M4cg==
X-Forwarded-Encrypted: i=1; AJvYcCViRKIF5WmfawAfuJRujmAXozXaXdyANJXE6KzKftEzlBZYNIu/kbpmqRJzli52t8fana/sqsD22R2EcVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77xvGHlY9AAHOX7sXvAnyrXFRbycNbHuVSFx4GNXmDLYGWF61
	NxUOoPz3qbIcPlYWOJOldW4l5rT3QhWzrXigfhlbWW1YC0Zokf4CHR1zPvVz4ztO7bwZUc1PXeO
	CABibqQ==
X-Google-Smtp-Source: AGHT+IHVbGrkkREFtXXgtVDR4qO5j4+SwvySXmNQ3eAKZklqlUbszdYFgWrGlTLJBuH3HqU2LOVdOjgdHiAi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f0ab:b1c6:6df2:ed2a])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b10:b0:6e3:f32:5fc8 with SMTP id
 00721157ae682-6eebd141ff1mr52667b3.1.1732147802352; Wed, 20 Nov 2024 16:10:02
 -0800 (PST)
Date: Wed, 20 Nov 2024 16:09:55 -0800
Message-Id: <20241121000955.536930-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Subject: [PATCH v1] perf tests: Fix hwmon parsing with PMU name test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Incorrectly the hwmon with PMU name test didn't pass "true". Fix and
address issue with hwmon_pmu__config_terms needing to load events - a
load bearing assert fired. Also fix missing list deletion when putting
the hwmon test PMU and lower some debug warnings to make the hwmon PMU
less spammy in verbose mode.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c |  5 +++--
 tools/perf/util/hwmon_pmu.c  | 16 ++++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index d8bc71b51599..b4656529146e 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -41,6 +41,7 @@ static int test_pmu_put(const char *dir, struct perf_pmu *hwm)
 	if (ret)
 		pr_err("Failure to \"%s\"\n", buf);
 
+	list_del(&hwm->list);
 	perf_pmu__delete(hwm);
 	return ret;
 }
@@ -147,7 +148,7 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
 	}
 
 	if (with_pmu)
-		snprintf(str, sizeof(str), "/%s/", test_event);
+		snprintf(str, sizeof(str), "hwmon_a_test_hwmon_pmu/%s/", test_event);
 	else
 		strlcpy(str, test_event, sizeof(str));
 
@@ -230,7 +231,7 @@ static int test__hwmon_pmu_without_pmu(struct test_suite *test __maybe_unused,
 static int test__hwmon_pmu_with_pmu(struct test_suite *test __maybe_unused,
 				   int subtest __maybe_unused)
 {
-	return test__hwmon_pmu(/*with_pmu=*/false);
+	return test__hwmon_pmu(/*with_pmu=*/true);
 }
 
 static int test__parse_hwmon_filename(struct test_suite *test __maybe_unused,
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 4d9d6f405434..e61429b38ba7 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -197,13 +197,13 @@ bool parse_hwmon_filename(const char *filename,
 		}
 	}
 	if (fn_item == NULL || fn_type[0] == '\0' || (item != NULL && fn_item[0] == '\0')) {
-		pr_debug("hwmon_pmu: not a hwmon file '%s'\n", filename);
+		pr_debug3("hwmon_pmu: not a hwmon file '%s'\n", filename);
 		return false;
 	}
 	elem = bsearch(&fn_type, hwmon_type_strs + 1, ARRAY_SIZE(hwmon_type_strs) - 1,
 		       sizeof(hwmon_type_strs[0]), hwmon_strcmp);
 	if (!elem) {
-		pr_debug("hwmon_pmu: not a hwmon type '%s' in file name '%s'\n",
+		pr_debug3("hwmon_pmu: not a hwmon type '%s' in file name '%s'\n",
 			 fn_type, filename);
 		return false;
 	}
@@ -223,7 +223,7 @@ bool parse_hwmon_filename(const char *filename,
 	elem = bsearch(fn_item, hwmon_item_strs + 1, ARRAY_SIZE(hwmon_item_strs) - 1,
 		       sizeof(hwmon_item_strs[0]), hwmon_strcmp);
 	if (!elem) {
-		pr_debug("hwmon_pmu: not a hwmon item '%s' in file name '%s'\n",
+		pr_debug3("hwmon_pmu: not a hwmon item '%s' in file name '%s'\n",
 			 fn_item, filename);
 		return false;
 	}
@@ -281,7 +281,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 			continue;
 
 		if (!parse_hwmon_filename(ent->d_name, &type, &number, &item, &alarm)) {
-			pr_debug("Not a hwmon file '%s'\n", ent->d_name);
+			pr_debug3("Not a hwmon file '%s'\n", ent->d_name);
 			continue;
 		}
 		key.num = number;
@@ -653,10 +653,14 @@ int hwmon_pmu__config_terms(const struct perf_pmu *pmu,
 			    struct parse_events_terms *terms,
 			    struct parse_events_error *err)
 {
-	const struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
+	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
 	struct parse_events_term *term;
+	int ret;
+
+	ret = hwmon_pmu__read_events(hwm);
+	if (ret)
+		return ret;
 
-	assert(pmu->sysfs_aliases_loaded);
 	list_for_each_entry(term, &terms->terms, list) {
 		if (hwmon_pmu__config_term(hwm, attr, term, err))
 			return -EINVAL;
-- 
2.47.0.371.ga323438b13-goog


