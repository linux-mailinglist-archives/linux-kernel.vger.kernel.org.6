Return-Path: <linux-kernel+bounces-574553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42774A6E6A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA013B333D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D839A1F30C0;
	Mon, 24 Mar 2025 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goyuoU6/"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308F1F1931
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855709; cv=none; b=Mwmjcl/9bDAZ+rCBdkAlaU/QuByjLoZqMygPEceZD/GknpEfxA5NtMs0498KdasWH5n1FSICzWvRhORMsauwYu5ZwuClnxSgtWH9aOQ0WLq5dlKFBTZHrQzvN3/ng4a2QhbxGGzXfld+B9IYXpryEZVdS8WeFeiNs4yok4jzIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855709; c=relaxed/simple;
	bh=ie26b2RyksuReoq3CaWAWU5urfeVKfBweu+iRLyCrp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Wn8gdLTWuEfP0urHkIbucpOcSl4Ynp3pXH+cOIKhyFFCaTStkapbUKeLqxs/BQnci9uvQEbJ3J/Orl4Cg72rem6SSlKStN7M+1cU0Fe+XRjrkhLw2NfFI6pu+FWa3jio+91JtLHLJz+UtsDVQJqH4JGqifgyDkSgt8M+MvRq08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=goyuoU6/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-300fefb8e05so6277382a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855707; x=1743460507; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UQH7oGCzJ0WNTA83Vjhjs3RZyEx+gk9Fkp49zJCF0U=;
        b=goyuoU6/LuDHXoHYtsRTTajw4+JsrWyok+bL8EOgV166PakhdydURwGgyZ+6qUDs77
         GTY5Otdl2ep24wmcq1bKofEEo5WSalAu6uCEyirqUAYKdFep/vYH0ThGWBAHCl1WGl3W
         /9Z6f8pN5CrJJrK74zsiFfZmkzdX3GuPOMoUkQdOXtxXxIo7N64TOFml5Q25eNJn97zv
         G69t/Tocix7Tw4g6IUAs1YebeEzaFHvENKpfyQ0PJob07JjJz9CY/XVdulsCFU9friV5
         1+Qe+uxP8HHqUqG/RPnX0/18lwPFofxuXyHmRulhrc3mEbCwbOTWDTVPgOE1jQ0bWlVi
         ZIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855707; x=1743460507;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UQH7oGCzJ0WNTA83Vjhjs3RZyEx+gk9Fkp49zJCF0U=;
        b=msnvgiC2XVos0puESb4v2hi4fr68M4HRc6y+HTWFpeTi4qyZATQSIHw1Ww+iBeZOcA
         IcAn2+hF1gKOsjlVA44EtTujCLwAG+kOVDKk2toYuwLtzfyJHmsqbkThes+IKX3b/KEZ
         NvnThUh+5E4oDzXFW+4bmgC4lPzM4tzFpMpqVjMmNxil0ahEk4IA6HSjsSYQae0L4u9W
         MTYsiUL+e8M+EtitVeUyM/pRsdikkz6D+zDwaR6bOw59OhC6o/25xuo+yu0RjQfIZgn0
         /gFP04jaGMWxWG1HpU6JMTUoXqc2yclRRZiUrmyXr7QiF7udZqZbvnh5gpB4+WcEuZzG
         9nHg==
X-Forwarded-Encrypted: i=1; AJvYcCWme5Bh6sEKwCaDHHS+aWzrVdfYG/K+ClTg+gSD2Jz4OFa0QvCnyHaeqpClLxYkcjKSTjslaqwWhQJ0Kes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3v4Nnb7oFw8pEU9SVaR/jouZB9kn1RaUC5vl5/uNx7uSCThs
	PstFaQeq+nqAerOjnoVohSnQIsEeY60w0LhgxVKp0BWvxy8y04rU42DvWcGPhOnAByQIjTwyP31
	RNGkM0A==
X-Google-Smtp-Source: AGHT+IGFLKGJaI5bECm8GfE6E/ktNhg/Uw8ybtyoGREwW3ADT2dnJDRNCo4vlwbZHy3oU/U1f9nA6LgLIxMV
X-Received: from pgjh4.prod.google.com ([2002:a63:df44:0:b0:af5:91a1:e217])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7116:b0:1f5:9961:c40
 with SMTP id adf61e73a8af0-1fe42f26554mr25357292637.8.1742855706986; Mon, 24
 Mar 2025 15:35:06 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:43 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-6-irogers@google.com>
Subject: [PATCH v1 05/14] perf intel-tpebs: Reduce scope of tpebs_events_size
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

Moved to record argument computation rather than being global.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 13d70c6bd44b..e5ca58599b5f 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -28,7 +28,6 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
-static size_t tpebs_event_size;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
@@ -85,15 +84,20 @@ static int get_perf_record_args(const char **record_argv, char buf[],
 static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
 	const char **record_argv;
+	size_t tpebs_event_size = 0;
 	int ret;
 	char buf[32];
 	char cpumap_buf[50];
+	struct tpebs_retire_lat *t;
 
 	cpu_map__snprint(evsel->evlist->core.user_requested_cpus, cpumap_buf,
 			 sizeof(cpumap_buf));
 
 	scnprintf(buf, sizeof(buf), "--control=fd:%d,%d", control_fd[0], ack_fd[1]);
 
+	list_for_each_entry(t, &tpebs_results, nd)
+		tpebs_event_size++;
+
 	record_argv = calloc(12 + 2 * tpebs_event_size, sizeof(char *));
 	if (!record_argv)
 		return -ENOMEM;
@@ -225,7 +229,6 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 		return NULL;
 	}
 	list_add_tail(&result->nd, &tpebs_results);
-	tpebs_event_size++;
 	return result;
 }
 
@@ -288,7 +291,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 	if (ret)
 		return ret;
 
-	if (tpebs_event_size > 0) {
+	if (!list_empty(&tpebs_results)) {
 		struct pollfd pollfd = { .events = POLLIN, };
 		int control_fd[2], ack_fd[2], len;
 		char ack_buf[8];
-- 
2.49.0.395.g12beb8f557-goog


