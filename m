Return-Path: <linux-kernel+bounces-255824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD2934584
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF9B2834FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E89439FD4;
	Thu, 18 Jul 2024 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4gi2Byc/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22CB2BAF3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264455; cv=none; b=R7ys25P0DXmHKD2pbIMjHsPVX2FI8qKl2D11b/m+quSNb7YAYct9Sc/7OhnKp3cnJJEV7o3Bs9l9Pqd3ZKAg/OCtjSESr8vZshkr/v/JTKvPLBQ35q1DGEiDgAYbeXyXe9vYWDz6OTzRjzNMnAZ/wQPuegRO/mVFrBz8KxNvL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264455; c=relaxed/simple;
	bh=knmil6GMFDmF9fxKO25Al7zr+dbtmO1yh62jXywG2KM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AoAhAZ/PcWVd5bXsLy8mSEjJd3ycBcE44d5ESqpoeSbok50/rUxlvWQuFAe3vSkcfqNK3cxk/bv9JkB5S6mVD8t5KPbCKAnhsuIoQKv828sO7S2tgUFyFHTlYRhTjWuLyCvDHTbuImDkCVuC6JOc3H9PC8exd+Ne4UE8rxuSBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4gi2Byc/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-654d96c2bb5so6395617b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264453; x=1721869253; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82lJtR2QiowtdojpRIK0xRJphQA1CgRwB82Bes7qNdo=;
        b=4gi2Byc/QSLgEE6CKpb+y6+NyW1re7ExwAZi6/IL4AIY5MJ5XRiOHjCbvFkVEvaWRb
         jX9NN6L+t79TVUDr8+qFqwmAUcXvVC7d6L+w1toFGn0xP2+hg+U7sgOrEasPujroLhjd
         tDQdMc7vhdUVldSY67QvID5ouW4q45FLH8Yv7SNGFyeUVpwve1OdBJURmpToAVFpKzy0
         tvdsJgFdYVPePxOq0THYKagJcllLyQqnUfdJydNoYCGjK+18qS1QnEeYEEU+6Tu0ESpm
         C9WS4gzkviYZakJK5Ns9+1vi5Rey0yegajE/R2oXtPT9ZoehTrwDHSO3tPrv6XwfJFDq
         d5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264453; x=1721869253;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82lJtR2QiowtdojpRIK0xRJphQA1CgRwB82Bes7qNdo=;
        b=FX5/tCXqsVN0kZW253uFqcEd7VIabMT+h+CR+K+VygcbgPIHTjWdKYBxhKxdXl9vsD
         DD7FhnpntoZH9wrAsK3r1MPxbuJvKriA3YNjYTxtfbnrYFY0N3IGya7aI+4xZw3pG4NJ
         eUmMfSmLOPpCaaKzkBptJ6xNhwvBSHEoNk2xBhbhmaR9ZZH3FUoUIdId/hStE5/zCN/v
         EU/3SRoDjFSUu0fGvuY7HX6FwH9Mi1w30wrIYcumVNbCUQYKtLrg02uCwtHy3HOiL0Y6
         iGcTAyscOnfaQA2af6jQr9B+uekNHicvcuOQEW2M/+hIck0m0+mq5Dm15AhObb6bQ1kp
         Y8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXre7Qo1hDNrh3oAfGVVQ7ptvg3scjgpN7AySOYPSHRGGz+vCEo28h8/grEZJF3wXZMx8+dL5dZ693zkKV6fKnTU6tQTCq4koN9VzgG
X-Gm-Message-State: AOJu0YxYC3kFewXSM/OYHdbzM1L7qN3RsEHFNSnXwA+krJQPwvbP981q
	q7HShG7oxMo4KsWvwFzAQM6YRXFecbcW9xxM+EEWN/ZqUn0YJptwcXYyCbEWHbqvpXR+R96WHjY
	yo/um1Q==
X-Google-Smtp-Source: AGHT+IEyKD1zw/SRriBJYp/5PAftCKkg1vVG8YgDL9BHxzbdv3Dg4Oi+rhd7WFZsx5MgVc5quGMumQEfcIPT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:ec8:b0:665:a4a4:57c1 with SMTP id
 00721157ae682-666015f3170mr275457b3.2.1721264452941; Wed, 17 Jul 2024
 18:00:52 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:03 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 07/27] perf buildid-list: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Reduce scope of build_id__mark_dso_hit_ops to the scope of function
perf_session__list_build_ids, its only use, and use perf_tool__init
for the default values. Move perf_event__exit_del_thread to event.[ch]
so it can be used in builtin-buildid-list.c.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-buildid-list.c | 10 ++++++++++
 tools/perf/util/build-id.c        | 32 -------------------------------
 tools/perf/util/build-id.h        |  4 +---
 tools/perf/util/event.c           | 20 +++++++++++++++++++
 tools/perf/util/event.h           |  4 ++++
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 383d5de36ce4..52dfacaff8e3 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -89,6 +89,7 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
+	struct perf_tool build_id__mark_dso_hit_ops;
 
 	symbol__elf_init();
 	/*
@@ -97,6 +98,15 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 	if (filename__fprintf_build_id(input_name, stdout) > 0)
 		goto out;
 
+	perf_tool__init(&build_id__mark_dso_hit_ops, /*ordered_events=*/true);
+	build_id__mark_dso_hit_ops.sample	= build_id__mark_dso_hit;
+	build_id__mark_dso_hit_ops.mmap		= perf_event__process_mmap;
+	build_id__mark_dso_hit_ops.mmap2	= perf_event__process_mmap2;
+	build_id__mark_dso_hit_ops.fork		= perf_event__process_fork;
+	build_id__mark_dso_hit_ops.exit		= perf_event__exit_del_thread;
+	build_id__mark_dso_hit_ops.attr		= perf_event__process_attr;
+	build_id__mark_dso_hit_ops.build_id	= perf_event__process_build_id;
+
 	session = perf_session__new(&data, &build_id__mark_dso_hit_ops);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 098fcc625d91..451d145fa4ed 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -67,38 +67,6 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int perf_event__exit_del_thread(const struct perf_tool *tool __maybe_unused,
-				       union perf_event *event,
-				       struct perf_sample *sample
-				       __maybe_unused,
-				       struct machine *machine)
-{
-	struct thread *thread = machine__findnew_thread(machine,
-							event->fork.pid,
-							event->fork.tid);
-
-	dump_printf("(%d:%d):(%d:%d)\n", event->fork.pid, event->fork.tid,
-		    event->fork.ppid, event->fork.ptid);
-
-	if (thread) {
-		machine__remove_thread(machine, thread);
-		thread__put(thread);
-	}
-
-	return 0;
-}
-
-struct perf_tool build_id__mark_dso_hit_ops = {
-	.sample	= build_id__mark_dso_hit,
-	.mmap	= perf_event__process_mmap,
-	.mmap2	= perf_event__process_mmap2,
-	.fork	= perf_event__process_fork,
-	.exit	= perf_event__exit_del_thread,
-	.attr		 = perf_event__process_attr,
-	.build_id	 = perf_event__process_build_id,
-	.ordered_events	 = true,
-};
-
 int build_id__sprintf(const struct build_id *build_id, char *bf)
 {
 	char *bid = bf;
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index ae87c4c58d5b..a212497bfdb0 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -16,11 +16,9 @@ struct build_id {
 	size_t	size;
 };
 
-struct nsinfo;
-
-extern struct perf_tool build_id__mark_dso_hit_ops;
 struct dso;
 struct feat_fd;
+struct nsinfo;
 
 void build_id__init(struct build_id *bid, const u8 *data, size_t size);
 int build_id__sprintf(const struct build_id *build_id, char *bf);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c2f0e7f40ad5..aac96d5d1917 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -426,6 +426,26 @@ int perf_event__process_exit(const struct perf_tool *tool __maybe_unused,
 	return machine__process_exit_event(machine, event, sample);
 }
 
+int perf_event__exit_del_thread(const struct perf_tool *tool __maybe_unused,
+				union perf_event *event,
+				struct perf_sample *sample __maybe_unused,
+				struct machine *machine)
+{
+	struct thread *thread = machine__findnew_thread(machine,
+							event->fork.pid,
+							event->fork.tid);
+
+	dump_printf("(%d:%d):(%d:%d)\n", event->fork.pid, event->fork.tid,
+		    event->fork.ppid, event->fork.ptid);
+
+	if (thread) {
+		machine__remove_thread(machine, thread);
+		thread__put(thread);
+	}
+
+	return 0;
+}
+
 size_t perf_event__fprintf_aux(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " offset: %#"PRI_lx64" size: %#"PRI_lx64" flags: %#"PRI_lx64" [%s%s%s]\n",
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4b24f1c580fd..f8742e6230a5 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -319,6 +319,10 @@ int perf_event__process_exit(const struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
 			     struct machine *machine);
+int perf_event__exit_del_thread(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine);
 int perf_event__process_ksymbol(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-- 
2.45.2.1089.g2a221341d9-goog


