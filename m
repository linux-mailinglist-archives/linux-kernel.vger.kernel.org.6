Return-Path: <linux-kernel+bounces-558470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E49A5E65A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91ABB7A9DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29821EFF85;
	Wed, 12 Mar 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byw/udgO"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C31EFFB6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814193; cv=none; b=LAJnWMjHrtYhBST5Q5fTF8EF01/eE7m7hEtKyv2iIorZN0Y4xTnK0URDz3dVBsjxWHv71KI22ZjXWC3Pb/x3BxfvFaz+duPjDHcOEj3YvAbXtlxrOJRpolF+v3NJT3p8uVRuiOxp8tYhStSF54EWV7B+BCCVfEvEgnxcWKF+hGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814193; c=relaxed/simple;
	bh=PdPgmcBYIWEeNLSGXkHHbQNrOkp0XMuWoBrNvNBx1oE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kIdgZ8sIRZ7b2NSeNTwnRw5RU6EzTGU+YE30X+MAYtjh2krgWDVRznGwJSVPjalAytfpVZ9kCB2n2ycio8DpHhMtBcZJoeKzZDsay1OJnhhaQ1JVsePVJgi7VX9E6YdJATF0l7YWZ/CGXRCgJM0bmgWkPNolGvZh8G1EZtocEb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byw/udgO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2217a4bfcc7so4255815ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741814190; x=1742418990; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mtw5A6pnErP63NBf+2oMOxljRBPUk1W+HOiO6no4Q+Y=;
        b=byw/udgOa9rMmdP+amxslFO5uYU3WTM+07joqht8MaUQskONiGw+f1BaKU3N2hi3lo
         atny66NCZw5pUHtR75lKuKnj0BmJyxwKmMObMYeUkBtiMNfF2+9Z41p/0WbNrNuQAdO9
         1iVVv8aksjQlbvMayDp1QnDkcUMiAnKpwLBtK7cz8Hq6V6UrOpTdsE4j57jmTOzYCuTY
         EQP187qDg7mQg1m+0NDlRGVD3u8VaZhfCEDRqLZmO6GlP25YdWhdVOkKPOgVWGT208d5
         1iYpEpsPqC2jufc4vxtA8jaWkOkh2sLpv2pGz+ky4jdxX01F6jUm6Aj+oP0+802QevKu
         2rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814190; x=1742418990;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtw5A6pnErP63NBf+2oMOxljRBPUk1W+HOiO6no4Q+Y=;
        b=BdHilcQyS8fguojFZP1DhOC5+5NjThhEqe3lQt/4CYSu2N3MEJIrcTol5/pCauQC+i
         VXZrJMMkniYJycq02Olat+wPjySRQFpo5iuOq2I5We5hX1NZaUCjeshVGLWY8afBsxCr
         l2ShDLp/JFDteF/I7mNN0Ib8oTaPoyuP41Uv3GBl9IyNICuuYQNlFfKwFmpkZLB47poF
         B1p9T0U6Jvq3S7eOrczwFTShIo1uSWSpJj+bbodFlNfbdFRL69OaNgqxrMi9LIhQQwXx
         pc7CIf1q7LyHLZQkIZBmFZGUriXCIELz8YI70tCraxVMvxXQCYhj8ATV4KiYNDp7AoCS
         J8nw==
X-Forwarded-Encrypted: i=1; AJvYcCUest+s1urVwk8lY2dPI9F4mR6JZtbKIgjIS1gvGwt31qkvCE/5S8325tnzpSTVe7PRLmMO8sysmhNR3Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJ5hbFJLYqDejlYzICJHLaNB5emv/YsT08jKBg83POsqHkCEk
	VmkvDtxnhDD5hFzTiNcBnJQ2vMFkelNF2sJPoTZXGzIiQfRGnMHbrZaqjEfdRCAdIcf5RDTBOFD
	z7Bktvw==
X-Google-Smtp-Source: AGHT+IE3fBCKu7LH5dWy4Mhc2DNcNCtpsN2q683UIyw1GVM1fMDJFk9jQ0EhTpT9uiJfq/9n5G9W16mHQqdN
X-Received: from plty2.prod.google.com ([2002:a17:902:8642:b0:220:c8cf:970c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da90:b0:223:5ada:891e
 with SMTP id d9443c01a7336-22592e201e3mr110847595ad.7.1741814190032; Wed, 12
 Mar 2025 14:16:30 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:16:22 -0700
In-Reply-To: <20250312211623.2495798-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312211623.2495798-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312211623.2495798-2-irogers@google.com>
Subject: [PATCH v2 1/2] perf parse-events: Make legacy events always have
 priority over sysfs/json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

This reverts the behavior of commit a24d9d9dc096 ("perf parse-events:
Make legacy events lower priority than sysfs/JSON"). That commit
states:

  As part of that report Mark Rutland <mark.rutland@arm.com> requested
  that legacy events not be higher in priority when a PMU is specified
  reversing what has until this change been perf's default behavior.

with an Acked-by: Mark Rutland <mark.rutland@arm.com> tag. Mark
expresses this preference here:
https://lore.kernel.org/lkml/ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com/
On an Alderlake this commit caused `cpu_core/instructions/` to be
encoded as:

  ------------------------------------------------------------
  perf_event_attr:
    type                             4 (cpu_core)
    size                             136
    config                           0xc0 (instructions)
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------

While `instructions` would be encoded as:

  ------------------------------------------------------------
  perf_event_attr:
    type                             0 (PERF_TYPE_HARDWARE)
    size                             136
    config                           0x400000001
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------

As the event parsing for legacy events uses parse_events_add_numeric,
rather than the more generic PMU handling case, we end up with the
same event name being encoded two ways. However, as instructions is
also a cpu_atom event on Alderlake, or any hybrid system, the PMU
prefixes are added in the stat output meaning instructions is reported
as cpu_core/instructions/ and cpu_atom/instructions/ even though those
events are encoded differently and potentially have different
behaviors. We shouldn't be having the same event with two different
encodings and I followed up the commit with changing the
prioritization of legacy events also when no PMU is specified in
commit 617824a7f0f7 ("perf parse-events: Prefer sysfs/JSON hardware
events over legacy").

RISC-V have been asking that legacy events also be a lower priority
than sysfs/json to avoid driver complexity. They've since had to work
around this issue meaning it isn't a necessity:

  If the overriding legacy with JSON is available, each future vendor
  may just provide the json file instead of modifying the driver.
  However, it will be a matter of convenience and clutter free future
  rather than a necessity at this point.

https://lists.riscv.org/g/sig-perf-analysis/topic/110906276#msg458

Landing the commit making encoding consistent and having sysfs/json a
priority has been pushed back against by Namhyung Kim, Arnaldo
Carvalho de Melo and James Clark. James assert the ARM drivers are now
fixed and don't need the prioritization. RISC-V's interests have been
ignored. The fact that legacy events are antiquated, imprecise in
meaning, brittle, misleading and don't give us a way to fix kernel
issues in software, have also been ignored:
https://lore.kernel.org/lkml/Z8sMcta0zTWeOso4@x1/

Given the push back against sysfs/json being a priority, contrary to
Mark Rutland's insistence this was the sensible way to do things,
contrary to RISC-V's wishes, and contrary to my own preference that
legacy events do become legacy, this patch changes the priority back
to legacy events being the priority consistently - that is
instructions and cpu_core/instructions/ are both encoded using legacy
events. It isn't a straight revert as clean-ups/refactorings are kept
in place.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 13 +++----------
 tools/perf/util/parse-events.c  | 26 +++++++++-----------------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5ec2e5607987..78e8ae825bf8 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -162,16 +162,9 @@ static int test__checkevent_numeric(struct evlist *evlist)
 
 static int assert_hw(struct perf_evsel *evsel, enum perf_hw_id id, const char *name)
 {
-	struct perf_pmu *pmu;
-
-	if (evsel->attr.type == PERF_TYPE_HARDWARE) {
-		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, id));
-		return 0;
-	}
-	pmu = perf_pmus__find_by_type(evsel->attr.type);
-
-	TEST_ASSERT_VAL("unexpected PMU type", pmu);
-	TEST_ASSERT_VAL("PMU missing event", perf_pmu__have_event(pmu, name));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
+	TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, id));
+	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__hw_names[id], name));
 	return 0;
 }
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 35e48fe56dfa..04bb70ba4292 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1023,12 +1023,10 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			return -EINVAL;
 		}
 		/*
-		 * Rewrite the PMU event to a legacy cache one unless the PMU
-		 * doesn't support legacy cache events or the event is present
-		 * within the PMU.
+		 * Rewrite the PMU event to a legacy cache one as legacy events
+		 * take priority over sysfs/json.
 		 */
-		if (perf_pmu__supports_legacy_cache(pmu) &&
-		    !perf_pmu__have_event(pmu, term->config)) {
+		if (perf_pmu__supports_legacy_cache(pmu)) {
 			attr->type = PERF_TYPE_HW_CACHE;
 			return parse_events__decode_legacy_cache(term->config, pmu->type,
 								 &attr->config);
@@ -1049,19 +1047,13 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			return -EINVAL;
 		}
 		/*
-		 * If the PMU has a sysfs or json event prefer it over
-		 * legacy. ARM requires this.
+		 * Rewrite the PMU event to a legacy cache one as legacy events
+		 * take priority over sysfs/json.
 		 */
-		if (perf_pmu__have_event(pmu, term->config)) {
-			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
-			term->no_value = true;
-			term->alternate_hw_config = true;
-		} else {
-			attr->type = PERF_TYPE_HARDWARE;
-			attr->config = term->val.num;
-			if (perf_pmus__supports_extended_type())
-				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
-		}
+		attr->type = PERF_TYPE_HARDWARE;
+		attr->config = term->val.num;
+		if (perf_pmus__supports_extended_type())
+			attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
 		return 0;
 	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


