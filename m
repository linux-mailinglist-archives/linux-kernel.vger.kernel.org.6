Return-Path: <linux-kernel+bounces-337598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CE984C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5106E284F07
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C41411DE;
	Tue, 24 Sep 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+HyZIkd"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDB126C0D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209770; cv=none; b=syCq7ihjykI2h3DroAixCvOj4Mgi346rkHO7cSYSbW6cHwhqF7fhvlVKzDDViq+sC3BtDzbdnqI7ctUrfsjWHraxb3e+C9GhS+sEeAQ9hKT8Bwnbc8NBLKyKpIOkyTKqOex3a7oG3HTlc259bxX9F7Y/k3DUv2Ucm7DW8wbj+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209770; c=relaxed/simple;
	bh=mqhOmmb5D7zCSOmLJGmsN3Tq39WjvR27nLQ5ZPsh9gQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=K7WMXAgjExbd547A0GtEGFX3d8zR1v6jRDhRJjG5CUB2kOxhSnrrR+errF0VAIFFoViVSH3zHQsZNrAQrW27ZLfvQD6EjeDywgJU12kggarpTCT74AKBE3z9xvgDgU0W6kKH8xWi6V0JXAskMR0vunUxemexmSXUPEEqHXpucs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+HyZIkd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4f52a4069so105350547b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727209768; x=1727814568; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDzgbRV3saEMgHqtXlPW4lWYEn2RBDB7kO3Czm+EZaQ=;
        b=u+HyZIkdo4fPuMlX+2qd8sTU1nIA50hwdeB9dgkqdYR3butbRwr99SqfV+VCpN2pj4
         fq3pCLsCfmPa9Gx2CLWly9e9WFkXxHfte1mHUytNTt47O1h34pUUHfN5tjpD2c7FpzN6
         7F9ewdMZap+hEC6n2jDUOBmk/fCbysjMh2fpFE/lwzc9wtLEesk9KmQL9GSXJHgPoPhx
         R4M1Bsr1ywCyb4ZfGUPgqs6mi2r2sZKdAdrlC1Rjhz+Lzr9LNITPTyDbL6UsCqq2HjNi
         vhCM0m9P92dFnbvF6Xg0BUIXrLZU5Ptt0qxe6nZNTSONs0PHePIfTKatGgiL24DEajUQ
         yPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727209768; x=1727814568;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDzgbRV3saEMgHqtXlPW4lWYEn2RBDB7kO3Czm+EZaQ=;
        b=vNjtSDQmqsKdNgt36uHIZZliDucrDq5T8Duoi0e3LmMvCWGrCFJEKSTOw58Z8btDqv
         rjTcdD4kFQ9QYLmdInheTJ7sLxTjPSdcOXxNAAF/vIJH2LibS3Lhiup/SjAjVZcZN1zX
         OK3Tn1jGzVAes5sgdlU6PlCsn9DyfZrx4JIvOeYGmlyVJ5Ri2IprUHJM/gWf6bLLuKqG
         T24BTl/adcHthzZwuL8Ap5H3hVxvI/I6m4qSQm4giK1eSmM9XMJlAqNt6Oz2NI3Z8PBx
         wUe1lNOy7kteapHYIM7/6bj542ogoU55XV5bZOWc+Gq2msdjRb1np3tRIXEd8m4ac6xb
         udHw==
X-Forwarded-Encrypted: i=1; AJvYcCUPXJEJzr5RMsVVmts7/0D76nOMhGv0C8EADBGf4dMd3uJfcKUnUfvawe/dbem9DrDUexKUaQ+yNW6b97Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+U4EMGaj1Hg/BxMbDIgMBOLVPAe/E1h8S+R60ZGOsQW6bc4hm
	nLbNZnPKoQOHZiavUmJcFgVwq1fuiYMZxCtah+tNIIM0oWnv03SaWnQJ/l+ZpbqOJ7WLFgGlAwt
	BowBXIQ==
X-Google-Smtp-Source: AGHT+IGznbeG/EIeM/kx+fLQtWIOIBujQilCujxnmYu1O8iIttqTrQ+JngIBgAmfebo5C2ezozKBwiF2Gpj4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:965e:4297:88a9:5902])
 (user=irogers job=sendgmr) by 2002:a05:690c:d85:b0:6db:e107:75a2 with SMTP id
 00721157ae682-6e21da5c761mr113237b3.4.1727209767952; Tue, 24 Sep 2024
 13:29:27 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:29:15 -0700
In-Reply-To: <20240924202916.1560687-1-irogers@google.com>
Message-Id: <20240924202916.1560687-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924202916.1560687-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 3/4] perf test: Skip not fail tp fields test when
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
2.46.0.792.g87dc391469-goog


