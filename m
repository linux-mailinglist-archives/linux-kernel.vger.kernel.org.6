Return-Path: <linux-kernel+bounces-322087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C49723CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A988283F47
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6140618A947;
	Mon,  9 Sep 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5CjpmER"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24018B477
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914272; cv=none; b=OEbx2kgUFvVwlMfQlBR2dYxUemEhdqPvYJrGG4IPHo9O+u3wTsSyiolmVwyVSzZ46PGbDt3OUrnBHGgs6TIvVsTlcSaCogrtfDL5+H4+4QBa8aMn5+qKQJ4mX3EEylf25y9unhnZ9vGjRbnUlB8wluQMwDxDl1O/hkokVweoyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914272; c=relaxed/simple;
	bh=eHJGHN9ZgfSRD5mYwKtP3gfcwoonvdu8rY9fnz8dm6I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=G+IFCDP/LMFYEsBuzGprMNWzU/ZBjQ2LbRKWTPjclK6fZ1ps5i3gcbiEmeJ9U7QGbLaMIVJ4T7F9o2CZqASH9FtDRbH0SqDGp0X+W6EVLFZFAXM7dKQha8oWOtxuG5om/N2XQ9ivAl/wJqX40sEA/2h4L4vMMk9UBKw4towtdlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5CjpmER; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1d46cee0b0so4536733276.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725914269; x=1726519069; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riE2Y5T5o1PrdK09V4CHcR+iYujERLclBkWQoR+wdM8=;
        b=o5CjpmERJauWo5qdhqf+OMHDqK82YMgMwVCtwbs1JOWSuEvHsahREbnenc0z/o+lej
         tgZDSjDgDQG7zj9P284t/WK24xew1SGYACC2WDkWk2rIU1S6BNatbWs7WjUj3BgWRg6U
         /+6/i+MkI5WTSMfm1mFKSzUIoMvzp1IfGGh274DCSrK3SKoTdY4Fzchb6H9SOnOVRHyj
         WhyBrmhRc7GDim6vSdqZMyztO8d7FAA12h/9w/IQbEBp27gn8CRalKdnLJiBTzoEwZrR
         7xYEV4EeYz4pPhZqiYbrT3sdkANktYAipqOlRH3ncbF8FZIDFE8iP7imYMXTLxuPMBML
         niVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725914269; x=1726519069;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riE2Y5T5o1PrdK09V4CHcR+iYujERLclBkWQoR+wdM8=;
        b=FpM0D78K6IVomapObm5AckVuQwn01salR3H8Hjjx6psy2DR4UHkahQJm+ScWGf9XhG
         WdjlINnvME0hJoSspx0O58CJem8fPvPfhCC5il3x2QzWpXeTSA9e/L1c0boZlIxH7MGz
         UcwaJE17Uf3DfjQsiVTzZBV1OH4JnRbkGMFpkoag3fR366CR5mpQ8FefDyrRiQu/JBuj
         unhDglazoXw5XXIlTMqw11CORC942ST282zBjZPwKzRBRE/mfAi+4Q4jUxId6EXqqbuF
         BGQ82Dhkk2ngLGcktyzgrF7eZ2oqJ1v6IxCR965KbY53Wlarj9zWW5wgWFEwhKAKo2lz
         TJgw==
X-Forwarded-Encrypted: i=1; AJvYcCWNc5P4pNkLjnA1IYudnTLOdQal4a5h4aSAycTsUeOMwoHaxrLkjTDFylRcCTkDwTymYozQggXXFCJQ5jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3JfiYs5d/xeUtobv4vW+8GZYoycoyBqiNExcN9+Pz85I3y6D
	YxBwnbOSFbgUiaLmVS/cjtVx9/fV66fFSDpR5W1e1NXeK/bbop8Zw3RJiRF/n/yj2NWbfduiE3k
	8ynaDYA==
X-Google-Smtp-Source: AGHT+IFw0v/ERsDoQPrmRfi2lZR9SLEXkvKbz5hWc62/lKRxJULkEExCOOiC1kLbivngwG7zCyAiIKtjDHLk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b7b9:f9a0:1197:ff33])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d43:b0:dfa:8ed1:8f1b with SMTP
 id 3f1490d57ef6-e1d34864d44mr21429276.1.1725914269332; Mon, 09 Sep 2024
 13:37:49 -0700 (PDT)
Date: Mon,  9 Sep 2024 13:37:37 -0700
In-Reply-To: <20240909203740.143492-1-irogers@google.com>
Message-Id: <20240909203740.143492-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240909203740.143492-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Subject: [PATCH v2 1/4] perf inject: Fix build ID injection
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Casey Chen <cachen@purestorage.com>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Build ID injection wasn't inserting a sample ID and aligning events to
64 bytes rather than 8. No sample ID means events are unordered and
two different build_id events for the same path, as happens when a
file is replaced, can't be differentiated.

Add in sample ID insertion for the build_id events alongside some
refactoring. The refactoring better aligns the function arguments for
different use cases, such as synthesizing build_id events without
needing to have a dso. The misc bits are explicitly passed as with
callchains the maps/dsos may span user and kernel land, so using
sample->cpumode isn't good enough.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        | 170 ++++++++++++++++++++++-------
 tools/perf/util/build-id.c         |   6 +-
 tools/perf/util/synthetic-events.c |  44 ++++++--
 tools/perf/util/synthetic-events.h |  10 +-
 4 files changed, 175 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 0ccf80fe8399..24470c57527d 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -130,6 +130,7 @@ struct perf_inject {
 	struct perf_file_section secs[HEADER_FEAT_BITS];
 	struct guest_session	guest_session;
 	struct strlist		*known_build_ids;
+	const struct evsel	*mmap_evsel;
 };
 
 struct event_entry {
@@ -138,8 +139,13 @@ struct event_entry {
 	union perf_event event[];
 };
 
-static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
-				struct machine *machine, u8 cpumode, u32 flags);
+static int tool__inject_build_id(const struct perf_tool *tool,
+				 struct perf_sample *sample,
+				 struct machine *machine,
+				 const struct evsel *evsel,
+				 __u16 misc,
+				 const char *filename,
+				 struct dso *dso, u32 flags);
 
 static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
 {
@@ -422,6 +428,28 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 	return dso;
 }
 
+/*
+ * The evsel used for the sample ID for mmap events. Typically stashed when
+ * processing mmap events. If not stashed, search the evlist for the first mmap
+ * gathering event.
+ */
+static const struct evsel *inject__mmap_evsel(struct perf_inject *inject)
+{
+	struct evsel *pos;
+
+	if (inject->mmap_evsel)
+		return inject->mmap_evsel;
+
+	evlist__for_each_entry(inject->session->evlist, pos) {
+		if (pos->core.attr.mmap) {
+			inject->mmap_evsel = pos;
+			return pos;
+		}
+	}
+	pr_err("No mmap events found\n");
+	return NULL;
+}
+
 static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 					  union perf_event *event,
 					  struct perf_sample *sample,
@@ -469,12 +497,28 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 		}
 
 		if (dso && !dso__hit(dso)) {
-			dso__set_hit(dso);
-			dso__inject_build_id(dso, tool, machine, sample->cpumode, flags);
+			struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
+
+			if (evsel) {
+				dso__set_hit(dso);
+				tool__inject_build_id(tool, sample, machine, evsel,
+						      /*misc=*/sample->cpumode,
+						      filename, dso, flags);
+			}
 		}
 	} else {
+		int err;
+
+		/*
+		 * Remember the evsel for lazy build id generation. It is used
+		 * for the sample id header type.
+		 */
+		if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY &&
+		    !inject->mmap_evsel)
+			inject->mmap_evsel = evlist__event2evsel(inject->session->evlist, event);
+
 		/* Create the thread, map, etc. Not done for the unordered inject all case. */
-		int err = perf_event_process(tool, event, sample, machine);
+		err = perf_event_process(tool, event, sample, machine);
 
 		if (err) {
 			dso__put(dso);
@@ -667,16 +711,20 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 	return false;
 }
 
-static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
-				struct machine *machine, u8 cpumode, u32 flags)
+static int tool__inject_build_id(const struct perf_tool *tool,
+				 struct perf_sample *sample,
+				 struct machine *machine,
+				 const struct evsel *evsel,
+				 __u16 misc,
+				 const char *filename,
+				 struct dso *dso, u32 flags)
 {
-	struct perf_inject *inject = container_of(tool, struct perf_inject,
-						  tool);
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	int err;
 
-	if (is_anon_memory(dso__long_name(dso)) || flags & MAP_HUGETLB)
+	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
 		return 0;
-	if (is_no_dso_memory(dso__long_name(dso)))
+	if (is_no_dso_memory(filename))
 		return 0;
 
 	if (inject->known_build_ids != NULL &&
@@ -684,24 +732,65 @@ static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
 		return 1;
 
 	if (dso__read_build_id(dso) < 0) {
-		pr_debug("no build_id found for %s\n", dso__long_name(dso));
+		pr_debug("no build_id found for %s\n", filename);
 		return -1;
 	}
 
-	err = perf_event__synthesize_build_id(tool, dso, cpumode,
-					      perf_event__repipe, machine);
+	err = perf_event__synthesize_build_id(tool, sample, machine,
+					      perf_event__repipe,
+					      evsel, misc, dso__bid(dso),
+					      filename);
 	if (err) {
-		pr_err("Can't synthesize build_id event for %s\n", dso__long_name(dso));
+		pr_err("Can't synthesize build_id event for %s\n", filename);
 		return -1;
 	}
 
 	return 0;
 }
 
+static int mark_dso_hit(const struct perf_tool *tool,
+			struct perf_sample *sample,
+			struct machine *machine,
+			const struct evsel *mmap_evsel,
+			struct map *map, bool sample_in_dso)
+{
+	struct dso *dso;
+	u16 misc = sample->cpumode;
+
+	if (!map)
+		return 0;
+
+	if (!sample_in_dso) {
+		u16 guest_mask = PERF_RECORD_MISC_GUEST_KERNEL |
+			PERF_RECORD_MISC_GUEST_USER;
+
+		if ((misc & guest_mask) != 0) {
+			misc &= PERF_RECORD_MISC_HYPERVISOR;
+			misc |= __map__is_kernel(map)
+				? PERF_RECORD_MISC_GUEST_KERNEL
+				: PERF_RECORD_MISC_GUEST_USER;
+		} else {
+			misc &= PERF_RECORD_MISC_HYPERVISOR;
+			misc |= __map__is_kernel(map)
+				? PERF_RECORD_MISC_KERNEL
+				: PERF_RECORD_MISC_USER;
+		}
+	}
+	dso = map__dso(map);
+	if (dso && !dso__hit(dso)) {
+		dso__set_hit(dso);
+		tool__inject_build_id(tool, sample, machine,
+				      mmap_evsel, misc, dso__long_name(dso), dso,
+				      map__flags(map));
+	}
+	return 0;
+}
+
 struct mark_dso_hit_args {
 	const struct perf_tool *tool;
+	struct perf_sample *sample;
 	struct machine *machine;
-	u8 cpumode;
+	const struct evsel *mmap_evsel;
 };
 
 static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
@@ -709,16 +798,8 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
 	struct mark_dso_hit_args *args = data;
 	struct map *map = node->ms.map;
 
-	if (map) {
-		struct dso *dso = map__dso(map);
-
-		if (dso && !dso__hit(dso)) {
-			dso__set_hit(dso);
-			dso__inject_build_id(dso, args->tool, args->machine,
-					     args->cpumode, map__flags(map));
-		}
-	}
-	return 0;
+	return mark_dso_hit(args->tool, args->sample, args->machine,
+			    args->mmap_evsel, map, /*sample_in_dso=*/false);
 }
 
 int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
@@ -728,10 +809,16 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 {
 	struct addr_location al;
 	struct thread *thread;
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	struct mark_dso_hit_args args = {
 		.tool = tool,
+		/*
+		 * Use the parsed sample data of the sample event, which will
+		 * have a later timestamp than the mmap event.
+		 */
+		.sample = sample,
 		.machine = machine,
-		.cpumode = sample->cpumode,
+		.mmap_evsel = inject__mmap_evsel(inject),
 	};
 
 	addr_location__init(&al);
@@ -743,13 +830,8 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 	}
 
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
-		struct dso *dso = map__dso(al.map);
-
-		if (!dso__hit(dso)) {
-			dso__set_hit(dso);
-			dso__inject_build_id(dso, tool, machine,
-					     sample->cpumode, map__flags(al.map));
-		}
+		mark_dso_hit(tool, sample, machine, args.mmap_evsel, al.map,
+			     /*sample_in_dso=*/true);
 	}
 
 	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
@@ -1159,17 +1241,27 @@ static int process_build_id(const struct perf_tool *tool,
 static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_t machine_pid)
 {
 	struct machine *machine = perf_session__findnew_machine(inject->session, machine_pid);
-	u8 cpumode = dso__is_in_kernel_space(dso) ?
-			PERF_RECORD_MISC_GUEST_KERNEL :
-			PERF_RECORD_MISC_GUEST_USER;
+	struct perf_sample synth_sample = {
+		.pid	   = -1,
+		.tid	   = -1,
+		.time	   = -1,
+		.stream_id = -1,
+		.cpu	   = -1,
+		.period	   = 1,
+		.cpumode   = dso__is_in_kernel_space(dso)
+		? PERF_RECORD_MISC_GUEST_KERNEL
+		: PERF_RECORD_MISC_GUEST_USER,
+	};
 
 	if (!machine)
 		return -ENOMEM;
 
 	dso__set_hit(dso);
 
-	return perf_event__synthesize_build_id(&inject->tool, dso, cpumode,
-					       process_build_id, machine);
+	return perf_event__synthesize_build_id(&inject->tool, &synth_sample, machine,
+					       process_build_id, inject__mmap_evsel(inject),
+					       /*misc=*/synth_sample.cpumode,
+					       dso__bid(dso), dso__long_name(dso));
 }
 
 static int guest_session__add_build_ids_cb(struct dso *dso, void *data)
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 451d145fa4ed..8982f68e7230 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -277,8 +277,8 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	struct perf_record_header_build_id b;
 	size_t len;
 
-	len = name_len + 1;
-	len = PERF_ALIGN(len, NAME_ALIGN);
+	len = sizeof(b) + name_len + 1;
+	len = PERF_ALIGN(len, sizeof(u64));
 
 	memset(&b, 0, sizeof(b));
 	memcpy(&b.data, bid->data, bid->size);
@@ -286,7 +286,7 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	misc |= PERF_RECORD_MISC_BUILD_ID_SIZE;
 	b.pid = pid;
 	b.header.misc = misc;
-	b.header.size = sizeof(b) + len;
+	b.header.size = len;
 
 	err = do_write(fd, &b, sizeof(b));
 	if (err < 0)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0a7f93ae76fb..6bb62e4e2d5d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2225,28 +2225,48 @@ int perf_event__synthesize_tracing_data(const struct perf_tool *tool, int fd, st
 }
 #endif
 
-int perf_event__synthesize_build_id(const struct perf_tool *tool, struct dso *pos, u16 misc,
-				    perf_event__handler_t process, struct machine *machine)
+int perf_event__synthesize_build_id(const struct perf_tool *tool,
+				    struct perf_sample *sample,
+				    struct machine *machine,
+				    perf_event__handler_t process,
+				    const struct evsel *evsel,
+				    __u16 misc,
+				    const struct build_id *bid,
+				    const char *filename)
 {
 	union perf_event ev;
 	size_t len;
 
-	if (!dso__hit(pos))
-		return 0;
+	len = sizeof(ev.build_id) + strlen(filename) + 1;
+	len = PERF_ALIGN(len, sizeof(u64));
 
-	memset(&ev, 0, sizeof(ev));
+	memset(&ev, 0, len);
 
-	len = dso__long_name_len(pos) + 1;
-	len = PERF_ALIGN(len, NAME_ALIGN);
-	ev.build_id.size = min(dso__bid(pos)->size, sizeof(dso__bid(pos)->data));
-	memcpy(&ev.build_id.build_id, dso__bid(pos)->data, ev.build_id.size);
+	ev.build_id.size = min(bid->size, sizeof(ev.build_id.build_id));
+	memcpy(ev.build_id.build_id, bid->data, ev.build_id.size);
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
 	ev.build_id.pid = machine->pid;
-	ev.build_id.header.size = sizeof(ev.build_id) + len;
-	memcpy(&ev.build_id.filename, dso__long_name(pos), dso__long_name_len(pos));
+	ev.build_id.header.size = len;
+	strcpy(ev.build_id.filename, filename);
+
+	if (evsel) {
+		void *array = &ev;
+		int ret;
 
-	return process(tool, &ev, NULL, machine);
+		array += ev.header.size;
+		ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+		if (ret < 0)
+			return ret;
+
+		if (ret & 7) {
+			pr_err("Bad id sample size %d\n", ret);
+			return -EINVAL;
+		}
+
+		ev.header.size += ret;
+	}
+	return process(tool, &ev, sample, machine);
 }
 
 int perf_event__synthesize_stat_events(struct perf_stat_config *config, const struct perf_tool *tool,
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index 31df7653677f..795bf3e18396 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -9,6 +9,7 @@
 #include <perf/cpumap.h>
 
 struct auxtrace_record;
+struct build_id;
 struct dso;
 struct evlist;
 struct evsel;
@@ -45,7 +46,14 @@ typedef int (*perf_event__handler_t)(const struct perf_tool *tool, union perf_ev
 
 int perf_event__synthesize_attrs(const struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process);
 int perf_event__synthesize_attr(const struct perf_tool *tool, struct perf_event_attr *attr, u32 ids, u64 *id, perf_event__handler_t process);
-int perf_event__synthesize_build_id(const struct perf_tool *tool, struct dso *pos, u16 misc, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_build_id(const struct perf_tool *tool,
+				    struct perf_sample *sample,
+				    struct machine *machine,
+				    perf_event__handler_t process,
+				    const struct evsel *evsel,
+				    __u16 misc,
+				    const struct build_id *bid,
+				    const char *filename);
 int perf_event__synthesize_cpu_map(const struct perf_tool *tool, const struct perf_cpu_map *cpus, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_event_update_cpus(const struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
 int perf_event__synthesize_event_update_name(const struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
-- 
2.46.0.598.g6f2099f65c-goog


