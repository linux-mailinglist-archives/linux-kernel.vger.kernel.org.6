Return-Path: <linux-kernel+bounces-231484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2D919934
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198CAB2332F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A206F1946D2;
	Wed, 26 Jun 2024 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRJwz9xJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA21946A4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434217; cv=none; b=A7AJXZON8XOE/EcfYmlWJrFO79xI893kQXHDzTXboF1HcY1dTJvofwzaKZmI2Ex1SAjCP5DQEE/2OXcbFWpD57cweureckZLsJ2K6KxmznYSZ8C+OOj5FfXZRsBCvd2FJRFPvBYKZET0UlclLySLOYoJKqhW0eH74bZkGJQy/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434217; c=relaxed/simple;
	bh=qFwb7pD5p1ottsupqVtJ+t1WOnePId5UkLvj0dZnRLg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NYLwt0bZ+MYk740/bbvmzBIVXkZiSt1+XGRe8UK2akOvVKS6nWUHMUF1yO+fRvykfskaMvIBZwb9O2DQDy4KLwe4q06rMCpipKEvS4hLLzU4Zgy+WYPcBWFQJKAFiwX3vBI3LK3UGVuevvdVbxBw79GBP0SJrC4OkB6AMiYfqMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRJwz9xJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64507372362so92714737b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434215; x=1720039015; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBBi2BhFlB8lzPr0QxAvcmIjepeVZAePgHWd4re5Qfg=;
        b=KRJwz9xJv6tiYWOuLDEmFDxlD1wpEaop/w8kPk1Q5hwtNDguHUYGsEHT4BpzF5BZoo
         mz+WyFE0cy7uXuJ/OJmzvk4JQ3STSX8BjW1USp8Y12vX1lxgAw+Xpe6h1rEFCn2KB0i5
         D85UuHsvX0/tTbE8IR6yRuNCsF2GUCAGWx1jRmnUfkvVY+w/vZ/7pmfYwR6paKOkx1G7
         HdZh6Ztn1p9z6Y/pyQ2c+kCZDMGlCEH7vkdaohDiY4IATZ2vbX3QZmDRyYP5VDUl2wWj
         e3x55peHZx8mG7qDHlrjCPkxFSvQAy584BbCQsUmOuD/9UdTbINp4CXOudEt0wTvgJA4
         AA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434215; x=1720039015;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBBi2BhFlB8lzPr0QxAvcmIjepeVZAePgHWd4re5Qfg=;
        b=DYz/+idZ3Y47ZZqvHF4iD+AFCKf3odyqBQ73lEGWc3aGjxDm/megWJGEfQbWvEAdq0
         9RoV1gM1Fu9fErVa45thFuc0dBcDW6OpAzsRlEqA8njQU19GlQ/kmZ04yakh4SYynvO3
         A3pD3ohC31rxdbVewgVe2EvFTrsvxMtsOY7DtAbtlXakuokSkd6BbDRjib+sS+a2Y4ZZ
         H/CjFXhViIxGUj3j00AD+EuByOPPb+43Xn/XArCVHNdxSIxQorU9lF1zjf8vKVGJfarn
         JHOV6KzXXxIjsE63LliTVsNxNMozNT4lsGzQr8cc+vay5sUjtupYJnJSm2r8iiiQPe2J
         xlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhcELSmiCm7WsvfNOSgzVKv9VlbKQgcn9bVXzNHUq6qVoVMnPNGoARTX6ny84EDv05axNwRPiSqkH4sgXUIIeQP/E11LuA03R1p5He
X-Gm-Message-State: AOJu0YwbLJrpwJXtkLHV+cd9EY/oV/WUux6xQn8r1PFwqAKFm5dCngns
	BWswBq7eiUYK8vuHYKGlF8jdEnyR7FFA5K34IUvtzXVr9exFOZwUmbjacwlAHuKtIataoVgwfk7
	yP6rObw==
X-Google-Smtp-Source: AGHT+IGT+gvtwDggFBDqG46JcZNI+OF6C4ySEcnFu5BTJCBB89+ztHE/sDy0qagvNq8yW7dfnywqTmFE/0AO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:c16:b0:631:9b3b:525d with SMTP id
 00721157ae682-642997c4d57mr410297b3.4.1719434214542; Wed, 26 Jun 2024
 13:36:54 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:09 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 07/27] perf buildid-list: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Reduce scope of build_id__mark_dso_hit_ops to the scope of function
perf_session__list_build_ids, its only use, and use perf_tool__init
for the default values. Move perf_event__exit_del_thread to event.[ch]
so it can be used in builtin-buildid-list.c.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.45.2.741.gdbec12cfda-goog


