Return-Path: <linux-kernel+bounces-574555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB0BA6E6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A6A173EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF6E1F3BB3;
	Mon, 24 Mar 2025 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlWP3DU/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CF1F37DA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855713; cv=none; b=SoqOLJUAzp4HZhIehrroU9uNi9653G+3GfxIIkbJOUcfWBek5l2nnJG6VsR/5IvxBKm8DU44bghEkh0HON7VuPFWflojrW1dBthmkqDaGZLMblSemwlzOfZa7y+4prGVusKMFPPF1nVL78D3ZdR7HYycMEhy38yeRIDb66l0DiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855713; c=relaxed/simple;
	bh=Lpq4G5yo+Ga+DGva72uN3LJa5rLWCEW0itHD5ZQBGxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qtWC0L2ov3WX4MUQgITz1c3WVkv2rMC11Dtm1XdnBvsdbvRHZ8A331JX6OpzX8f5HC7FVz7WO53UWQypqJw6MXm76bF7V3UWfpmTFFLRd3OJms9E3917KE2g92gpI57cwrtV6ik5QmYCW3vSTG2YXQuTdMv8fUxYrlZqrBTU1rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlWP3DU/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso13732583a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855711; x=1743460511; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOA/OGGxNBcRColJQpK6PG8JVFiW2q78VM7qIIThxrQ=;
        b=JlWP3DU/4TBTHmgb9h7R5jiTk64DLMA6rMPwa6o22Ku+h6gfP+gvHKgB6druXu62XF
         O+EdiYdEDvvOwOXoFDB+e4U5Cubzxc3AF8NTdEpxZSfvH6JrLs8zHhpoqN02oF0gBmah
         tZ2HV54oevgWYo1fFU+CK4pRfUKZ7hhKe3mUIZgnc0EKSgL1eWaiS6Bxd89tgfORluJm
         CzNVbO81GhFiRxK5qqgIazxvk28KYGr8xKiBOyZZpaEuNJAW9H3l8VVoGGnZUJf5DKNo
         YXUXa/DR19fWFw5vle+i6kA/w5pDLthshC1X22kXmrjwaVdDHmFnlZlynNl2Evy0XHlJ
         ng0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855711; x=1743460511;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOA/OGGxNBcRColJQpK6PG8JVFiW2q78VM7qIIThxrQ=;
        b=Imfk07CtIm3e7wQELs+oAL43qdrWIC5X5eEeRFQ7JvbstYhzgf6t3ddPtPm7ZpBYHc
         IPjNv1SaYX2kjvuZY5eXtLhezMYm8QWkUcLj/i+JYsrOHyGqDIJJeebAX6E+FgsWMh10
         xE0lZHccGTikpwpeQ6kz58xnG1P/VPPdkepmqtxlPTz7K5w4awjlIJ5tEj3O4u5bnYS/
         bZGbEo9q0Qfap017MEtd4tV0IGkWqhrV7V6s5wmdAqQz+MwqiQfD+fAS7yo9hghEmFva
         ZRzXxNEfaxYcWqLM7YT/kPe3WF8uxxh7oTTtqNAcRrSMZq8y+MSsqxrwcTXcy4AiHxEN
         LcEA==
X-Forwarded-Encrypted: i=1; AJvYcCUGYtrAL6hbq7sqW0UIn8/M+iJGudwe1+QTb/vCuzdW+kNOhanOrjptoUWfbYggoesu49DnnQ/EFMZ6gNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoF6wKBkqW3P2zlfwPdYn8EXo7LT4wn8Z7+sXIevlpN5cg8ClF
	aA2h6N3pQvBZwiG0brPw0BUzM55m4sL/HVTuecwsdK4Tw2FRsmFqAE3+C578rDLy4DkZ7RA5BN7
	JSVQlSg==
X-Google-Smtp-Source: AGHT+IGIqJJ2nEjL+FUKqko6r9rKHylvKIdqkCyeFkdN0iwjG9G8AupV+mWrnGgRrnDhqwCmYkw7fzWmhBRZ
X-Received: from pfbcq25.prod.google.com ([2002:a05:6a00:3319:b0:732:51fc:618f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7889:b0:1f5:8153:9407
 with SMTP id adf61e73a8af0-1fe42f996a9mr23579460637.20.1742855710813; Mon, 24
 Mar 2025 15:35:10 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:45 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-8-irogers@google.com>
Subject: [PATCH v1 07/14] perf intel-tpebs: Ensure events are opened, factor
 out finding
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Factor out finding an tpebs_retire_lat from an evsel. Don't blindly
return when ignoring an open request, which happens after the first
open request, ensure the event was started on a fork of perf record.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 61 +++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 3141b7d2e94f..9116cdc6981e 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -44,6 +44,8 @@ struct tpebs_retire_lat {
 	int sum;
 	/* Average of retire_latency, val = sum / count */
 	double val;
+	/* Has the event been sent to perf record? */
+	bool started;
 };
 
 static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
@@ -93,6 +95,9 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
 	tpebs_cmd.out = -1;
 	ret = start_command(&tpebs_cmd);
 	zfree(&tpebs_cmd.argv);
+	list_for_each_entry(t, &tpebs_results, nd)
+		t->started = true;
+
 	return ret;
 }
 
@@ -213,6 +218,19 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 	return result;
 }
 
+static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
+{
+	struct tpebs_retire_lat *t;
+
+	list_for_each_entry(t, &tpebs_results, nd) {
+		if (t->tpebs_name == evsel->name ||
+		    !strcmp(t->tpebs_name, evsel->name) ||
+		    (evsel->metric_id && !strcmp(t->tpebs_name, evsel->metric_id)))
+			return t;
+	}
+	return NULL;
+}
+
 /**
  * evsel__tpebs_prepare - create tpebs data structures ready for opening.
  * @evsel: retire_latency evsel, all evsels on its list will be prepared.
@@ -220,16 +238,11 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 static int evsel__tpebs_prepare(struct evsel *evsel)
 {
 	struct evsel *pos;
-	struct tpebs_retire_lat *tpebs_event;
-
-	list_for_each_entry(tpebs_event, &tpebs_results, nd) {
-		if (!strcmp(tpebs_event->tpebs_name, evsel->name)) {
-			/*
-			 * evsel, or an identically named one, was already
-			 * prepared.
-			 */
-			return 0;
-		}
+	struct tpebs_retire_lat *tpebs_event = tpebs_retire_lat__find(evsel);
+
+	if (tpebs_event) {
+		/* evsel, or an identically named one, was already prepared. */
+		return 0;
 	}
 	tpebs_event = tpebs_retire_lat__new(evsel);
 	if (!tpebs_event)
@@ -261,12 +274,19 @@ int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret;
 
-	/*
-	 * We should only run tpebs_start when tpebs_recording is enabled.
-	 * And we should only run it once with all the required events.
-	 */
-	if (tpebs_cmd.pid != 0 || !tpebs_recording)
+	/* We should only run tpebs_start when tpebs_recording is enabled. */
+	if (!tpebs_recording)
 		return 0;
+	/* Only start the events once. */
+	if (tpebs_cmd.pid != 0) {
+		struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
+
+		if (!t || !t->started) {
+			/* Fail, as the event wasn't started. */
+			return -EBUSY;
+		}
+		return 0;
+	}
 
 	ret = evsel__tpebs_prepare(evsel);
 	if (ret)
@@ -351,7 +371,6 @@ int evsel__tpebs_open(struct evsel *evsel)
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	__u64 val;
-	bool found = false;
 	struct tpebs_retire_lat *t;
 	struct perf_counts_values *count;
 
@@ -366,19 +385,13 @@ int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
 	tpebs_stop();
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
-	list_for_each_entry(t, &tpebs_results, nd) {
-		if (t->tpebs_name == evsel->name ||
-		    (evsel->metric_id && !strcmp(t->tpebs_name, evsel->metric_id))) {
-			found = true;
-			break;
-		}
-	}
+	t = tpebs_retire_lat__find(evsel);
 
 	/* Set ena and run to non-zero */
 	count->ena = count->run = 1;
 	count->lost = 0;
 
-	if (!found) {
+	if (!t) {
 		/*
 		 * Set default value or 0 when retire_latency for this event is
 		 * not found from sampling data (record_tpebs not set or 0
-- 
2.49.0.395.g12beb8f557-goog


