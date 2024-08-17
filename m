Return-Path: <linux-kernel+bounces-290574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5D19555DA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C57F28203B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA2B148856;
	Sat, 17 Aug 2024 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3dS96kLB"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6913FD86
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877131; cv=none; b=m6ixvM7bwkdonjAShQi1owMPLzx1WKLbd/mQIgq5gJpnbMER9OehAu1oBEqq/SQTedI/ecNBX+csR2S/KmJxPYGWYrVBXWlPy+OoTiR9J3oc2Hue8YVJxgwLgwCOHUg0PaX4joXZoomoJbq8qHW64itUsTCDz6pcbbK0WavQtXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877131; c=relaxed/simple;
	bh=VnhhslHkaD4cCwbYqZhzz2/fkKI4DNPiJVg+COtL2pQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hldunjPiwy9q7nKz4Pqg//uv9ekfuHvOdjK/0kl/8U+pcl6RGOAoM/E3UurES9Q6cWWCWNCLCzL6JN2Aj8+oN4iPBJwyGwluydDqeNMnPmipPktY8RCG5hK6zRJNPEcMmiiMSg9PgOYyUfTocjSTAlpc2Pti13iG8+FZNUpjVYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3dS96kLB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6506bfeaf64so40592187b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877129; x=1724481929; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=His0pYvOMvESQ2So15V1L43VruSGtFsE9vF3maA0zqQ=;
        b=3dS96kLB2UNjl+ObvXcfCfFsDYuMLjazieXszB+eIzvsy43Fxi821lhntfkEZvsxS2
         1fg0JFHIe4iSSe2McwOEVDgnLeHfsSLQr9Tlidby1/LymSutrJVJ2p9DXMMI5/WjvpQS
         Vv8D9V+4r3VzpKJmON+HoCEPHcSiCvtn04tEcwn48yvx88BAVjolf3hUIY6haU2/nFwi
         akWmVGcCXK/1d20VsxyscImslgXk6AlmI/gXgllPAzYHEqUjOnxJBv7sB+aNNYEGd3BR
         mNpXeXiltY8aNPf+MqLfelIhLlAbHwutA4h1N2s5QEgiksMw+00Wvjz/MI1crryut5kH
         Qrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877129; x=1724481929;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=His0pYvOMvESQ2So15V1L43VruSGtFsE9vF3maA0zqQ=;
        b=HEzzpRRTC+WMpjC/9ZWPRDRHJA2VQ4GxxJvc3QjQlKmajrK3F4Dor7EFB/mUvUejLt
         KJmQRaDePI+puELeVJZfzQoWiAa8EehNVU42xAusBjWKPZ0wi1taA23VmsL8xGXaDGBC
         hDKYp49YlcIfn8hG7Y+qZOCkXFeUa+vUQwUb03CwzhGzY1NGASTP3t3ZZp+wjomIzo+W
         slf/KrkmouXUqnsT1e9kAqzyTE36xKpJ3kNsQqc5Lgq35DevZylZ1sbnUtOXmCl625HV
         yb+uVn1kNzIUJd4t4t8V/QVv2LhjX7fb61DzDyMIpSax0vPMYS/AeSlNZm4rB6jDtW8X
         MDVw==
X-Forwarded-Encrypted: i=1; AJvYcCX7EK6/7jtPgc9G2hUq4WD24W9l6yRr+5TeGSSXfsGxkNw7DM8v7inW2+XiCisfZ9QoCSDi+kPG2sx9P4fLrk5ZomSQd/Gn0Qh0KmKR
X-Gm-Message-State: AOJu0YzGWBg0+lZZ+5e0lcw60u0ivvlqn1wRZEmBPPrI0Y+c90Gk0q16
	MBlUPFy7eVebvNKbBsbFfJENwZssHLTcXt7MV+LUorqRD8/0EKS0jAYMm51plFDw9AxL0jsDZYy
	E+eMcCQ==
X-Google-Smtp-Source: AGHT+IFQKhgp0W3SvzFWr5GF42xG1sD5n1dv9Y/pMZdZM6IiAqUpv0hBnIIr0MQsm0E4/fBlO+PuC9Um3l2z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:4084:b0:667:8a45:d0f9 with SMTP
 id 00721157ae682-6b1b1e5d0dcmr1703327b3.0.1723877129211; Fri, 16 Aug 2024
 23:45:29 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:41 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 12/13] perf inject: Lazy build-id mmap2 event insertion
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add -B option that lazily inserts mmap2 events thereby dropping all
mmap events without samples. This is similar to the behavior of -b
where only build_id events are inserted when a dso is accessed in a
sample.

File size savings can be significant in system-wide mode, consider:
```
$ perf record -g -a -o perf.data sleep 1
$ perf inject -B -i perf.data -o perf.new.data
$ ls -al perf.data perf.new.data
         5147049 perf.data
         2248493 perf.new.data
```

Give test coverage of the new option in pipe test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c         | 62 +++++++++++++++++++++++------
 tools/perf/tests/shell/pipe_test.sh |  1 +
 tools/perf/util/map.c               |  1 +
 tools/perf/util/map.h               | 11 +++++
 4 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 86425cade30e..2ff246f56a44 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -108,6 +108,7 @@ enum build_id_rewrite_style {
 	BID_RWS__INJECT_HEADER_LAZY,
 	BID_RWS__INJECT_HEADER_ALL,
 	BID_RWS__MMAP2_BUILDID_ALL,
+	BID_RWS__MMAP2_BUILDID_LAZY,
 };
 
 struct perf_inject {
@@ -527,7 +528,8 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 		 * Remember the evsel for lazy build id generation. It is used
 		 * for the sample id header type.
 		 */
-		if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY &&
+		if ((inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
+		     inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) &&
 		    !inject->mmap_evsel)
 			inject->mmap_evsel = evlist__event2evsel(inject->session->evlist, event);
 
@@ -560,6 +562,9 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 		}
 	}
 	dso__put(dso);
+	if (inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY)
+		return 0;
+
 	return perf_event__repipe(tool, event, sample, machine);
 }
 
@@ -825,7 +830,8 @@ static int dso__inject_mmap2_build_id(const struct perf_tool *tool,
 	return 0;
 }
 
-static int mark_dso_hit(const struct perf_tool *tool,
+static int mark_dso_hit(const struct perf_inject *inject,
+			const struct perf_tool *tool,
 			struct perf_sample *sample,
 			struct machine *machine,
 			const struct evsel *mmap_evsel,
@@ -854,16 +860,39 @@ static int mark_dso_hit(const struct perf_tool *tool,
 		}
 	}
 	dso = map__dso(map);
-	if (dso && !dso__hit(dso)) {
-		dso__set_hit(dso);
-		dso__inject_build_id(tool, sample, machine,
-				mmap_evsel, misc, dso__long_name(dso), dso,
-				map__flags(map));
+	if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
+		if (dso && !dso__hit(dso)) {
+			dso__set_hit(dso);
+			dso__inject_build_id(tool, sample, machine,
+					     mmap_evsel, misc, dso__long_name(dso), dso,
+					     map__flags(map));
+		}
+	} else if (inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
+		if (!map__hit(map)) {
+			const struct build_id null_bid = { .size = 0 };
+			const struct build_id *bid = dso ? dso__bid(dso) : &null_bid;
+			const char *filename = dso ? dso__long_name(dso) : "";
+
+			map__set_hit(map);
+			perf_event__synthesize_mmap2_build_id(tool, sample, machine,
+								perf_event__repipe,
+								mmap_evsel,
+								misc,
+								sample->pid, sample->tid,
+								map__start(map),
+								map__end(map) - map__start(map),
+								map__pgoff(map),
+								bid,
+								map__prot(map),
+								map__flags(map),
+								filename);
+		}
 	}
 	return 0;
 }
 
 struct mark_dso_hit_args {
+	const struct perf_inject *inject;
 	const struct perf_tool *tool;
 	struct perf_sample *sample;
 	struct machine *machine;
@@ -875,7 +904,7 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
 	struct mark_dso_hit_args *args = data;
 	struct map *map = node->ms.map;
 
-	return mark_dso_hit(args->tool, args->sample, args->machine,
+	return mark_dso_hit(args->inject, args->tool, args->sample, args->machine,
 			    args->mmap_evsel, map, /*sample_in_dso=*/false);
 }
 
@@ -888,6 +917,7 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 	struct thread *thread;
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	struct mark_dso_hit_args args = {
+		.inject = inject,
 		.tool = tool,
 		/*
 		 * Use the parsed sample data of the sample event, which will
@@ -907,7 +937,7 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 	}
 
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
-		mark_dso_hit(tool, sample, machine, args.mmap_evsel, al.map,
+		mark_dso_hit(inject, tool, sample, machine, args.mmap_evsel, al.map,
 			     /*sample_in_dso=*/true);
 	}
 
@@ -2151,7 +2181,8 @@ static int __cmd_inject(struct perf_inject *inject)
 
 	output_data_offset = perf_session__data_offset(session->evlist);
 
-	if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
+	if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
+	    inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
 		inject->tool.sample = perf_event__inject_buildid;
 	} else if (inject->sched_stat) {
 		struct evsel *evsel;
@@ -2334,6 +2365,7 @@ int cmd_inject(int argc, const char **argv)
 	const char *known_build_ids = NULL;
 	bool build_ids;
 	bool build_id_all;
+	bool mmap2_build_ids;
 	bool mmap2_build_id_all;
 
 	struct option options[] = {
@@ -2341,6 +2373,8 @@ int cmd_inject(int argc, const char **argv)
 			    "Inject build-ids into the output stream"),
 		OPT_BOOLEAN(0, "buildid-all", &build_id_all,
 			    "Inject build-ids of all DSOs into the output stream"),
+		OPT_BOOLEAN('B', "mmap2-buildids", &mmap2_build_ids,
+			    "Drop unused mmap events, make others mmap2 with build IDs"),
 		OPT_BOOLEAN(0, "mmap2-buildid-all", &mmap2_build_id_all,
 			    "Rewrite all mmap events as mmap2 events with build IDs"),
 		OPT_STRING(0, "known-build-ids", &known_build_ids,
@@ -2439,6 +2473,8 @@ int cmd_inject(int argc, const char **argv)
 			return -1;
 		}
 	}
+	if (mmap2_build_ids)
+		inject.build_id_style = BID_RWS__MMAP2_BUILDID_LAZY;
 	if (mmap2_build_id_all)
 		inject.build_id_style = BID_RWS__MMAP2_BUILDID_ALL;
 	if (build_ids)
@@ -2458,7 +2494,8 @@ int cmd_inject(int argc, const char **argv)
 			repipe = false;
 	}
 	ordered_events = inject.jit_mode || inject.sched_stat ||
-		(inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY);
+		inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
+		inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY;
 	perf_tool__init(&inject.tool, ordered_events);
 	inject.tool.sample		= perf_event__repipe_sample;
 	inject.tool.read		= perf_event__repipe_sample;
@@ -2530,7 +2567,8 @@ int cmd_inject(int argc, const char **argv)
 			goto out_delete;
 	}
 
-	if (inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
+	if (inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
+	    inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
 		/*
 		 * to make sure the mmap records are ordered correctly
 		 * and so that the correct especially due to jitted code
diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index 1cacd6f15bcb..9b1fcbfeb837 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -90,6 +90,7 @@ test_inject_bids() {
 }
 
 test_record_report
+test_inject_bids -B
 test_inject_bids -b
 test_inject_bids --buildid-all
 test_inject_bids --mmap2-buildid-all
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e781c8d56a9a..d729438b7d65 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -116,6 +116,7 @@ static void map__init(struct map *map, u64 start, u64 end, u64 pgoff,
 	map__set_mapping_type(map, MAPPING_TYPE__DSO);
 	assert(map__erange_warned(map) == false);
 	assert(map__priv(map) == false);
+	assert(map__hit(map) == false);
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 6c43f31a9fe0..4262f5a143be 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -35,6 +35,7 @@ DECLARE_RC_STRUCT(map) {
 	enum mapping_type	mapping_type:8;
 	bool			erange_warned;
 	bool			priv;
+	bool			hit;
 };
 
 struct kmap;
@@ -83,6 +84,11 @@ static inline bool map__priv(const struct map *map)
 	return RC_CHK_ACCESS(map)->priv;
 }
 
+static inline bool map__hit(const struct map *map)
+{
+	return RC_CHK_ACCESS(map)->hit;
+}
+
 static inline refcount_t *map__refcnt(struct map *map)
 {
 	return &RC_CHK_ACCESS(map)->refcnt;
@@ -287,6 +293,11 @@ static inline void map__set_priv(struct map *map)
 	RC_CHK_ACCESS(map)->priv = true;
 }
 
+static inline void map__set_hit(struct map *map)
+{
+	RC_CHK_ACCESS(map)->hit = true;
+}
+
 static inline void map__set_erange_warned(struct map *map)
 {
 	RC_CHK_ACCESS(map)->erange_warned = true;
-- 
2.46.0.184.g6999bdac58-goog


