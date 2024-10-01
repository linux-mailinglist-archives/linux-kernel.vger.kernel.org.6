Return-Path: <linux-kernel+bounces-345246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B998B396
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8DB281697
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FEB1BC07E;
	Tue,  1 Oct 2024 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NyXNjkRF"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45E1BC084
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760222; cv=none; b=RVEf+/U2eyTjU9ANJ1fuecRbZVUnUjZIYKzkd+hHH2xhz1nQo0BlJKK7N/tDSZhKzgW3Rxjffqej1QG5ILlKLyHVvFUPpo1dnd5JyuiC2VKUP/elbsLg09QcFvRN1Np0ZQYFoog1+qcq4sQF7XW3+tDc+9mTnZ5Kkee/s3L7OqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760222; c=relaxed/simple;
	bh=Ok+FhDXN/bUiz9+kds8fM6XMayPQjAdr+t4YJVsFhlo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Gzkc+Aq3m/nIjdfuvpgQcEuMwlW4K4sXiv7l24eqM6uiCGW4q2Nt/kxQeQHSoj8NbNAYNiM9oMCYeGRRriuweavdoHw630saV77EOfu2SlriABJpGqH3VAMK73pbDi9UVKFbhJN+LZHB1PS9S71scSOIp5HZ49ywfePIkNdDBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NyXNjkRF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e294f38bddso5508197b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727760220; x=1728365020; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ta5YpSmga+h02rO1c/RFOYlnk/Em15j2RCfsC0qW0X4=;
        b=NyXNjkRFn40amU8m5lpohCQynDaXqE3wAP96/xxMPiYwHptLu6i+8P/rIKHhMjD74B
         oPlqs9j3uZFo8/Eb8M6pu22zmPpOjiHZbo8uItV0YSmwC71zoYvt5ayuAJQJm4BaEIgy
         C20laGkYM827qqiidGv+yi7m/kWa/5w3QZiiarkSBY1rW8QtDlu5WzGDPshO6AplKsf+
         1dYEKnqDcz77dw+5LjgKQFk2w46QxwZ8/TkPpQW66HTeKON+kYhSLBjXIDBVDGegZ24E
         mOCxtDlCPYXph/rEfRbNa3wp6Le0wV2rY/YfFXf5EPYnU+pj8Ylyxtxmw7ZR56CaI0Dc
         D3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760220; x=1728365020;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ta5YpSmga+h02rO1c/RFOYlnk/Em15j2RCfsC0qW0X4=;
        b=mn5bm3ns4Lr//JhThjKCl+9eoOCC3bBHvrpGegRgTWR0CWjQh12JNOAZprV1eXTseN
         lmSqHqdgWrz5D6uct0DZ81LkxP3/IxV45mlK7hkcQq6gAMg1usk2yTIDn9dSvYDF0s92
         F4eoJHT9an6/13k84kPgQIs16/k6XeScZQS6k2F6ZY46mGWuVxsb+YlI10+q8oc0eRBX
         +UAr6DC3DXrQpOBGy3YyVZ7jzTgMD9MPVeLoVpnNOsflxfw3ni1xJuUigcXeb3cbJpNY
         Gh11RPyv6gZXi7Qi2OYXk+eonzKyBWd/Cx129OjTunp26GqWsytrN7Bv9X8l0GoqbskW
         TpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwZq4owwqtkr+hQNjfBN4C/uncC0PMCtitnZ1B35resSPGJOM3bDNpbD3hC93txqxPhqYcsSX8EYaKXB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbt/UtTd+mWsnYceT8NwzPTfcUMJcE3XL9NLiwin/HVKegqq5D
	+C5x2DIfeeL3ju6tFb7dnxmFQN7SVK0g5xIPFzHUTil9GHffQ6YGvohCOG9aYMkIpTRNvNJtf1F
	5DChQrw==
X-Google-Smtp-Source: AGHT+IE9nO+iqokkfm82bAK4mbVT5Uil7PWvBrDlRgIQGKqFunhB43WFpJO35+IDQx+/3jg5ffcPAKWvZ3vt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a05:690c:2c11:b0:6dd:dcf5:28ad with SMTP
 id 00721157ae682-6e247399192mr840327b3.0.1727760219780; Mon, 30 Sep 2024
 22:23:39 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:23:26 -0700
In-Reply-To: <20241001052327.7052-1-irogers@google.com>
Message-Id: <20241001052327.7052-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001052327.7052-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2 3/4] perf test: Skip not fail tp fields test when
 insufficient permissions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up return value to be TEST_* rather than unspecific integer. Add
test case skip reason. Skip test if EACCES comes back from
evsel__newtp.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/evsel-tp-sched.c | 40 +++++++++++++++++++------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index cf4da3d748c2..3da6a76eac38 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -36,33 +36,33 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 					   int subtest __maybe_unused)
 {
 	struct evsel *evsel = evsel__newtp("sched", "sched_switch");
-	int ret = 0;
+	int ret = TEST_OK;
 
 	if (IS_ERR(evsel)) {
 		pr_debug("evsel__newtp failed with %ld\n", PTR_ERR(evsel));
-		return -1;
+		return PTR_ERR(evsel) == -EACCES ? TEST_SKIP : TEST_FAIL;
 	}
 
 	if (evsel__test_field(evsel, "prev_comm", 16, false))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prev_pid", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prev_prio", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "next_comm", 16, false))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "next_pid", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "next_prio", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	evsel__delete(evsel);
 
@@ -70,23 +70,33 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 
 	if (IS_ERR(evsel)) {
 		pr_debug("evsel__newtp failed with %ld\n", PTR_ERR(evsel));
-		return -1;
+		return TEST_FAIL;
 	}
 
 	if (evsel__test_field(evsel, "comm", 16, false))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "pid", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prio", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "target_cpu", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	evsel__delete(evsel);
 	return ret;
 }
 
-DEFINE_SUITE("Parse sched tracepoints fields", perf_evsel__tp_sched_test);
+static struct test_case tests__perf_evsel__tp_sched_test[] = {
+	TEST_CASE_REASON("Parse sched tracepoints fields",
+			 perf_evsel__tp_sched_test,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__perf_evsel__tp_sched_test = {
+	.desc = "Parse sched tracepoints fields",
+	.test_cases = tests__perf_evsel__tp_sched_test,
+};
-- 
2.46.1.824.gd892dcdcdd-goog


