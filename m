Return-Path: <linux-kernel+bounces-171990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294B48BEB8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84821F25E44
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797216D9C1;
	Tue,  7 May 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="24inxVWY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83D16EC16
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106983; cv=none; b=TCVcyHlQfeiIQduc+bDJ6vJeA90BJld88NwdZZiDtuuYfC6n5pqOrZ3fSuo3+ouxxPTn9ERrV0l2pnRvDjJ8P93Oz4pkt/s87uW5P93SJqmIJ4GGby236L8e5mlZWMJ+//djiSWTHrmlgo97Lp8PJdEkYsfdXS3lKUTNazWp2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106983; c=relaxed/simple;
	bh=31qEjfVLn/ROf3wIzcCsPP40NMhHeBUTuFO+eWfkcbI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Tr+iV6l3FPQjVcv/xB9/mI7NxIy+hKzbarUuiWwAK3/H8ayZXPpqezYCkEY78TTGrlWz3Fj5MKsGMMOxhkypnSxCMaCtnN7O9Ps9RxdUl0aVYHSmmICZBVp/scoT/k8eyDnCgwZ0O7wXhG3JpjIVbUEGsQSrEHKJC8U3xsvEwPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=24inxVWY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de468af2b73so7154039276.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106980; x=1715711780; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkcy47SUAl8Qk/1NuLP9UuoXgRoyNCsO/J4K5RjvMZc=;
        b=24inxVWYzm6c74SJXjE3tu1WTN47MPzpEY3Z8viuBlJd1bFsfPtEaW6sNFEK0+ijp1
         WGWS15pEEX9hOLPzi6OBz2wJal6bH8AicT5u3rI3yf6bwoYNeUkgrBjD9q5KclB78O+d
         GFaqJqBOdGYeJ5dRp9qHeWcpUTy3iACWRPQku4x/okzfu6Kj8blSq12AL/fG8pVgkDBq
         sdPIv/vIWeaQ7urk/VQzJJ9yYCOby+5SWqVSdEVD6JRNAc6kvdwPHUBt3JMGNGyLS/vm
         ZBA+SfYrnlyql8OFFo6WfJXB6+W6wxPqZJZAWQxncfeFokpz6Ndwp1hDvre3lIvv/vRq
         X2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106980; x=1715711780;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkcy47SUAl8Qk/1NuLP9UuoXgRoyNCsO/J4K5RjvMZc=;
        b=w8JcyDe3XzkCLm6Nfq/vPACeSDhY68gWvMFE1hhR0LKLbhqwvUAiN85BVFbtl5zFBM
         R5gzJPHhrGOrbZhn+9tNnM7sm+VhOgydFu2kdW5MBthQya6Nw2ukeScpEvEWjg1NU5B6
         CJj3O0u8xeCkUShgXAxshqUWIx127YsYzyWXV52MciCLxStaLEniN+eBz/UApWPFIZ2T
         cdX3eWFpHGpCQ/Nc6zqP5K4FQxjQXFmFaFqgWQyA3eXw4NMJUiF9rGaXPngpJDv+58hO
         07xP/PvfDh+y242uoZJt4S1pMlXoUBR/uRHYZkQyCfeskFq/69bu5sKn4QHrzsOgjhJf
         XzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnulOY4v6tmuBkzpRUhEmkvffSOXs8qheICicag/E/XH3/UG5OboYfqmj95k2u/o9td5hEy8/67K5w/pGJF2/Id+4dXEWzBMi5/aK1
X-Gm-Message-State: AOJu0YzxHfDiOfB9hXp/2BCjlFcgtxhvHXCJ/ZHkzPZgbZWIqWqaWCQw
	00JTM0r+WuMgvecfF5k/qamlBh+VyHqCXI1la4Wxe2WD2SRMYzUNwMmYmc+DyysY6pu0TkpXCg4
	IwAQcQQ==
X-Google-Smtp-Source: AGHT+IGlMhZFA/hbu/l2BZqCLqXOoUAaHGH/wkUQZGCjT+6OtQcAz9YFlKU5BLtDRkbw/8FvMXBlreuwEKfs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a25:9e11:0:b0:de5:1b63:9ee5 with SMTP id
 3f1490d57ef6-debb9da66d2mr118984276.7.1715106980236; Tue, 07 May 2024
 11:36:20 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:44 -0700
In-Reply-To: <20240507183545.1236093-1-irogers@google.com>
Message-Id: <20240507183545.1236093-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 7/8] perf mem-info: Add reference count checking
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add reference count checking and switch struct mem_info usage to use
accessor functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c                      | 12 ++--
 tools/perf/builtin-report.c                   |  2 +-
 tools/perf/builtin-script.c                   | 11 ++-
 tools/perf/tests/mem.c                        | 10 +--
 tools/perf/util/hist.c                        | 26 +++----
 tools/perf/util/machine.c                     |  6 +-
 tools/perf/util/mem-events.c                  | 20 +++---
 tools/perf/util/mem-info.c                    | 29 +++++---
 tools/perf/util/mem-info.h                    | 28 +++++++-
 .../scripting-engines/trace-event-python.c    | 11 ++-
 tools/perf/util/sort.c                        | 68 +++++++++----------
 11 files changed, 135 insertions(+), 88 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c624414b2285..c157bd31f2e5 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -530,7 +530,7 @@ static int dcacheline_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	char buf[20];
 
 	if (he->mem_info)
-		addr = cl_address(he->mem_info->daddr.addr, chk_double_cl);
+		addr = cl_address(mem_info__daddr(he->mem_info)->addr, chk_double_cl);
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
 }
@@ -568,7 +568,7 @@ static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	char buf[20];
 
 	if (he->mem_info)
-		addr = cl_offset(he->mem_info->daddr.al_addr, chk_double_cl);
+		addr = cl_offset(mem_info__daddr(he->mem_info)->al_addr, chk_double_cl);
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
 }
@@ -580,10 +580,10 @@ offset_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	uint64_t l = 0, r = 0;
 
 	if (left->mem_info)
-		l = cl_offset(left->mem_info->daddr.addr, chk_double_cl);
+		l = cl_offset(mem_info__daddr(left->mem_info)->addr, chk_double_cl);
 
 	if (right->mem_info)
-		r = cl_offset(right->mem_info->daddr.addr, chk_double_cl);
+		r = cl_offset(mem_info__daddr(right->mem_info)->addr, chk_double_cl);
 
 	return (int64_t)(r - l);
 }
@@ -597,7 +597,7 @@ iaddr_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	char buf[20];
 
 	if (he->mem_info)
-		addr = he->mem_info->iaddr.addr;
+		addr = mem_info__iaddr(he->mem_info)->addr;
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
 }
@@ -2593,7 +2593,7 @@ perf_c2c_cacheline_browser__title(struct hist_browser *browser,
 	he = cl_browser->he;
 
 	if (he->mem_info)
-		addr = cl_address(he->mem_info->daddr.addr, chk_double_cl);
+		addr = cl_address(mem_info__daddr(he->mem_info)->addr, chk_double_cl);
 
 	scnprintf(bf, size, "Cacheline 0x%lx", addr);
 	return 0;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 6eb1d90b589f..0892b6e3e5e7 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -186,7 +186,7 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 
 	} else if (rep->mem_mode) {
 		mi = he->mem_info;
-		err = addr_map_symbol__inc_samples(&mi->daddr, sample, evsel);
+		err = addr_map_symbol__inc_samples(mem_info__daddr(mi), sample, evsel);
 		if (err)
 			goto out;
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 58af4f3aa592..c16224b1fef3 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2051,13 +2051,18 @@ static int evlist__max_name_len(struct evlist *evlist)
 
 static int data_src__fprintf(u64 data_src, FILE *fp)
 {
-	struct mem_info mi = { .data_src.val = data_src };
+	struct mem_info *mi = mem_info__new();
 	char decode[100];
 	char out[100];
 	static int maxlen;
 	int len;
 
-	perf_script__meminfo_scnprintf(decode, 100, &mi);
+	if (!mi)
+		return -ENOMEM;
+
+	mem_info__data_src(mi)->val = data_src;
+	perf_script__meminfo_scnprintf(decode, 100, mi);
+	mem_info__put(mi);
 
 	len = scnprintf(out, 100, "%16" PRIx64 " %s", data_src, decode);
 	if (maxlen < len)
@@ -2498,7 +2503,7 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	evsel = evlist__last(*pevlist);
 
 	if (!evsel->priv) {
-		if (scr->per_event_dump) { 
+		if (scr->per_event_dump) {
 			evsel->priv = evsel_script__new(evsel, scr->session->data);
 			if (!evsel->priv)
 				return -ENOMEM;
diff --git a/tools/perf/tests/mem.c b/tools/perf/tests/mem.c
index f694a60d8a73..cb3d749e157b 100644
--- a/tools/perf/tests/mem.c
+++ b/tools/perf/tests/mem.c
@@ -13,12 +13,14 @@ static int check(union perf_mem_data_src data_src,
 {
 	char out[100];
 	char failure[100];
-	struct mem_info mi = { .data_src = data_src };
-
+	struct mem_info *mi = mem_info__new();
 	int n;
 
-	n = perf_mem__snp_scnprintf(out, sizeof out, &mi);
-	n += perf_mem__lvl_scnprintf(out + n, sizeof out - n, &mi);
+	TEST_ASSERT_VAL("Memory allocation failed", mi);
+	*mem_info__data_src(mi) = data_src;
+	n = perf_mem__snp_scnprintf(out, sizeof out, mi);
+	n += perf_mem__lvl_scnprintf(out + n, sizeof out - n, mi);
+	mem_info__put(mi);
 	scnprintf(failure, sizeof failure, "unexpected %s", out);
 	TEST_ASSERT_VAL(failure, !strcmp(string, out));
 	return 0;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 56453a02cdf4..00814d42d5f1 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -154,8 +154,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	}
 
 	if (h->mem_info) {
-		if (h->mem_info->daddr.ms.sym) {
-			symlen = (int)h->mem_info->daddr.ms.sym->namelen + 4
+		if (mem_info__daddr(h->mem_info)->ms.sym) {
+			symlen = (int)mem_info__daddr(h->mem_info)->ms.sym->namelen + 4
 			       + unresolved_col_width + 2;
 			hists__new_col_len(hists, HISTC_MEM_DADDR_SYMBOL,
 					   symlen);
@@ -169,8 +169,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 					   symlen);
 		}
 
-		if (h->mem_info->iaddr.ms.sym) {
-			symlen = (int)h->mem_info->iaddr.ms.sym->namelen + 4
+		if (mem_info__iaddr(h->mem_info)->ms.sym) {
+			symlen = (int)mem_info__iaddr(h->mem_info)->ms.sym->namelen + 4
 			       + unresolved_col_width + 2;
 			hists__new_col_len(hists, HISTC_MEM_IADDR_SYMBOL,
 					   symlen);
@@ -180,8 +180,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 					   symlen);
 		}
 
-		if (h->mem_info->daddr.ms.map) {
-			symlen = dso__name_len(map__dso(h->mem_info->daddr.ms.map));
+		if (mem_info__daddr(h->mem_info)->ms.map) {
+			symlen = dso__name_len(map__dso(mem_info__daddr(h->mem_info)->ms.map));
 			hists__new_col_len(hists, HISTC_MEM_DADDR_DSO,
 					   symlen);
 		} else {
@@ -477,8 +477,10 @@ static int hist_entry__init(struct hist_entry *he,
 	}
 
 	if (he->mem_info) {
-		he->mem_info->iaddr.ms.map = map__get(he->mem_info->iaddr.ms.map);
-		he->mem_info->daddr.ms.map = map__get(he->mem_info->daddr.ms.map);
+		mem_info__iaddr(he->mem_info)->ms.map =
+			map__get(mem_info__iaddr(he->mem_info)->ms.map);
+		mem_info__daddr(he->mem_info)->ms.map =
+			map__get(mem_info__daddr(he->mem_info)->ms.map);
 	}
 
 	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
@@ -526,8 +528,8 @@ static int hist_entry__init(struct hist_entry *he,
 		zfree(&he->branch_info);
 	}
 	if (he->mem_info) {
-		map_symbol__exit(&he->mem_info->iaddr.ms);
-		map_symbol__exit(&he->mem_info->daddr.ms);
+		map_symbol__exit(&mem_info__iaddr(he->mem_info)->ms);
+		map_symbol__exit(&mem_info__daddr(he->mem_info)->ms);
 	}
 err:
 	map_symbol__exit(&he->ms);
@@ -1336,8 +1338,8 @@ void hist_entry__delete(struct hist_entry *he)
 	}
 
 	if (he->mem_info) {
-		map_symbol__exit(&he->mem_info->iaddr.ms);
-		map_symbol__exit(&he->mem_info->daddr.ms);
+		map_symbol__exit(&mem_info__iaddr(he->mem_info)->ms);
+		map_symbol__exit(&mem_info__daddr(he->mem_info)->ms);
 		mem_info__zput(he->mem_info);
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d5a01ef92668..8477edefc299 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2013,11 +2013,11 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 	if (!mi)
 		return NULL;
 
-	ip__resolve_ams(al->thread, &mi->iaddr, sample->ip);
-	ip__resolve_data(al->thread, al->cpumode, &mi->daddr,
+	ip__resolve_ams(al->thread, mem_info__iaddr(mi), sample->ip);
+	ip__resolve_data(al->thread, al->cpumode, mem_info__daddr(mi),
 			 sample->addr, sample->phys_addr,
 			 sample->data_page_size);
-	mi->data_src.val = sample->data_src;
+	mem_info__data_src(mi)->val = sample->data_src;
 
 	return mi;
 }
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index f618a5ccc7af..6dda47bb774f 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -293,7 +293,7 @@ int perf_mem__tlb_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	out[0] = '\0';
 
 	if (mem_info)
-		m = mem_info->data_src.mem_dtlb;
+		m = mem_info__const_data_src(mem_info)->mem_dtlb;
 
 	hit = m & PERF_MEM_TLB_HIT;
 	miss = m & PERF_MEM_TLB_MISS;
@@ -367,7 +367,7 @@ static int perf_mem__op_scnprintf(char *out, size_t sz, const struct mem_info *m
 	int l;
 
 	if (mem_info)
-		op = mem_info->data_src.mem_op;
+		op = mem_info__const_data_src(mem_info)->mem_op;
 
 	if (op & PERF_MEM_OP_NA)
 		l = scnprintf(out, sz, "N/A");
@@ -400,7 +400,7 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	if (!mem_info)
 		goto na;
 
-	data_src = mem_info->data_src;
+	data_src = *mem_info__const_data_src(mem_info);
 
 	if (data_src.mem_lvl & PERF_MEM_LVL_HIT)
 		memcpy(hit_miss, "hit", 3);
@@ -476,7 +476,7 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	out[0] = '\0';
 
 	if (mem_info)
-		m = mem_info->data_src.mem_snoop;
+		m = mem_info__const_data_src(mem_info)->mem_snoop;
 
 	for (i = 0; m && i < ARRAY_SIZE(snoop_access); i++, m >>= 1) {
 		if (!(m & 0x1))
@@ -490,7 +490,7 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 
 	m = 0;
 	if (mem_info)
-		m = mem_info->data_src.mem_snoopx;
+		m = mem_info__const_data_src(mem_info)->mem_snoopx;
 
 	for (i = 0; m && i < ARRAY_SIZE(snoopx_access); i++, m >>= 1) {
 		if (!(m & 0x1))
@@ -515,7 +515,7 @@ int perf_mem__lck_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	int l;
 
 	if (mem_info)
-		mask = mem_info->data_src.mem_lock;
+		mask = mem_info__const_data_src(mem_info)->mem_lock;
 
 	if (mask & PERF_MEM_LOCK_NA)
 		l = scnprintf(out, sz, "N/A");
@@ -536,7 +536,7 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	out[0] = '\0';
 
 	if (mem_info)
-		mask = mem_info->data_src.mem_blk;
+		mask = mem_info__const_data_src(mem_info)->mem_blk;
 
 	if (!mask || (mask & PERF_MEM_BLK_NA)) {
 		l += scnprintf(out + l, sz - l, " N/A");
@@ -572,8 +572,8 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
 
 int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
 {
-	union perf_mem_data_src *data_src = &mi->data_src;
-	u64 daddr  = mi->daddr.addr;
+	union perf_mem_data_src *data_src = mem_info__data_src(mi);
+	u64 daddr  = mem_info__daddr(mi)->addr;
 	u64 op     = data_src->mem_op;
 	u64 lvl    = data_src->mem_lvl;
 	u64 snoop  = data_src->mem_snoop;
@@ -700,7 +700,7 @@ do {				\
 		return -1;
 	}
 
-	if (!mi->daddr.ms.map || !mi->iaddr.ms.map) {
+	if (!mem_info__daddr(mi)->ms.map || !mem_info__iaddr(mi)->ms.map) {
 		stats->nomap++;
 		return -1;
 	}
diff --git a/tools/perf/util/mem-info.c b/tools/perf/util/mem-info.c
index ff0dfdb5369a..27d67721a695 100644
--- a/tools/perf/util/mem-info.c
+++ b/tools/perf/util/mem-info.c
@@ -4,25 +4,32 @@
 
 struct mem_info *mem_info__get(struct mem_info *mi)
 {
-	if (mi)
-		refcount_inc(&mi->refcnt);
-	return mi;
+	struct mem_info *result;
+
+	if (RC_CHK_GET(result, mi))
+		refcount_inc(mem_info__refcnt(mi));
+
+	return result;
 }
 
 void mem_info__put(struct mem_info *mi)
 {
-	if (mi && refcount_dec_and_test(&mi->refcnt)) {
-		addr_map_symbol__exit(&mi->iaddr);
-		addr_map_symbol__exit(&mi->daddr);
-		free(mi);
+	if (mi && refcount_dec_and_test(mem_info__refcnt(mi))) {
+		addr_map_symbol__exit(mem_info__iaddr(mi));
+		addr_map_symbol__exit(mem_info__daddr(mi));
+		RC_CHK_FREE(mi);
+	} else {
+		RC_CHK_PUT(mi);
 	}
 }
 
 struct mem_info *mem_info__new(void)
 {
-	struct mem_info *mi = zalloc(sizeof(*mi));
+	struct mem_info *result = NULL;
+	RC_STRUCT(mem_info) *mi = zalloc(sizeof(*mi));
+
+	if (ADD_RC_CHK(result, mi))
+		refcount_set(mem_info__refcnt(result), 1);
 
-	if (mi)
-		refcount_set(&mi->refcnt, 1);
-	return mi;
+	return result;
 }
diff --git a/tools/perf/util/mem-info.h b/tools/perf/util/mem-info.h
index bb7d8375d73c..0f68e29f311b 100644
--- a/tools/perf/util/mem-info.h
+++ b/tools/perf/util/mem-info.h
@@ -4,9 +4,10 @@
 
 #include <linux/refcount.h>
 #include <linux/perf_event.h>
+#include <internal/rc_check.h>
 #include "map_symbol.h"
 
-struct mem_info {
+DECLARE_RC_STRUCT(mem_info) {
 	struct addr_map_symbol	iaddr;
 	struct addr_map_symbol	daddr;
 	union perf_mem_data_src	data_src;
@@ -25,4 +26,29 @@ static inline void __mem_info__zput(struct mem_info **mi)
 
 #define mem_info__zput(mi) __mem_info__zput(&mi)
 
+static inline struct addr_map_symbol *mem_info__iaddr(struct mem_info *mi)
+{
+	return &RC_CHK_ACCESS(mi)->iaddr;
+}
+
+static inline struct addr_map_symbol *mem_info__daddr(struct mem_info *mi)
+{
+	return &RC_CHK_ACCESS(mi)->daddr;
+}
+
+static inline union perf_mem_data_src *mem_info__data_src(struct mem_info *mi)
+{
+	return &RC_CHK_ACCESS(mi)->data_src;
+}
+
+static inline const union perf_mem_data_src *mem_info__const_data_src(const struct mem_info *mi)
+{
+	return &RC_CHK_ACCESS(mi)->data_src;
+}
+
+static inline refcount_t *mem_info__refcnt(struct mem_info *mi)
+{
+	return &RC_CHK_ACCESS(mi)->refcnt;
+}
+
 #endif /* __PERF_MEM_INFO_H */
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c77fe08a0545..fb00f3ad6815 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -721,15 +721,20 @@ static void set_sample_read_in_dict(PyObject *dict_sample,
 }
 
 static void set_sample_datasrc_in_dict(PyObject *dict,
-				       struct perf_sample *sample)
+				      struct perf_sample *sample)
 {
-	struct mem_info mi = { .data_src.val = sample->data_src };
+	struct mem_info *mi = mem_info__new();
 	char decode[100];
 
+	if (!mi)
+		Py_FatalError("couldn't create mem-info");
+
 	pydict_set_item_string_decref(dict, "datasrc",
 			PyLong_FromUnsignedLongLong(sample->data_src));
 
-	perf_script__meminfo_scnprintf(decode, 100, &mi);
+	mem_info__data_src(mi)->val = sample->data_src;
+	perf_script__meminfo_scnprintf(decode, 100, mi);
+	mem_info__put(mi);
 
 	pydict_set_item_string_decref(dict, "datasrc_decode",
 			_PyUnicode_FromString(decode));
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 711ef69306f3..cd39ea972193 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1365,9 +1365,9 @@ sort__daddr_cmp(struct hist_entry *left, struct hist_entry *right)
 	uint64_t l = 0, r = 0;
 
 	if (left->mem_info)
-		l = left->mem_info->daddr.addr;
+		l = mem_info__daddr(left->mem_info)->addr;
 	if (right->mem_info)
-		r = right->mem_info->daddr.addr;
+		r = mem_info__daddr(right->mem_info)->addr;
 
 	return (int64_t)(r - l);
 }
@@ -1379,8 +1379,8 @@ static int hist_entry__daddr_snprintf(struct hist_entry *he, char *bf,
 	struct map_symbol *ms = NULL;
 
 	if (he->mem_info) {
-		addr = he->mem_info->daddr.addr;
-		ms = &he->mem_info->daddr.ms;
+		addr = mem_info__daddr(he->mem_info)->addr;
+		ms = &mem_info__daddr(he->mem_info)->ms;
 	}
 	return _hist_entry__sym_snprintf(ms, addr, he->level, bf, size, width);
 }
@@ -1391,9 +1391,9 @@ sort__iaddr_cmp(struct hist_entry *left, struct hist_entry *right)
 	uint64_t l = 0, r = 0;
 
 	if (left->mem_info)
-		l = left->mem_info->iaddr.addr;
+		l = mem_info__iaddr(left->mem_info)->addr;
 	if (right->mem_info)
-		r = right->mem_info->iaddr.addr;
+		r = mem_info__iaddr(right->mem_info)->addr;
 
 	return (int64_t)(r - l);
 }
@@ -1405,8 +1405,8 @@ static int hist_entry__iaddr_snprintf(struct hist_entry *he, char *bf,
 	struct map_symbol *ms = NULL;
 
 	if (he->mem_info) {
-		addr = he->mem_info->iaddr.addr;
-		ms   = &he->mem_info->iaddr.ms;
+		addr = mem_info__iaddr(he->mem_info)->addr;
+		ms   = &mem_info__iaddr(he->mem_info)->ms;
 	}
 	return _hist_entry__sym_snprintf(ms, addr, he->level, bf, size, width);
 }
@@ -1418,9 +1418,9 @@ sort__dso_daddr_cmp(struct hist_entry *left, struct hist_entry *right)
 	struct map *map_r = NULL;
 
 	if (left->mem_info)
-		map_l = left->mem_info->daddr.ms.map;
+		map_l = mem_info__daddr(left->mem_info)->ms.map;
 	if (right->mem_info)
-		map_r = right->mem_info->daddr.ms.map;
+		map_r = mem_info__daddr(right->mem_info)->ms.map;
 
 	return _sort__dso_cmp(map_l, map_r);
 }
@@ -1431,7 +1431,7 @@ static int hist_entry__dso_daddr_snprintf(struct hist_entry *he, char *bf,
 	struct map *map = NULL;
 
 	if (he->mem_info)
-		map = he->mem_info->daddr.ms.map;
+		map = mem_info__daddr(he->mem_info)->ms.map;
 
 	return _hist_entry__dso_snprintf(map, bf, size, width);
 }
@@ -1443,12 +1443,12 @@ sort__locked_cmp(struct hist_entry *left, struct hist_entry *right)
 	union perf_mem_data_src data_src_r;
 
 	if (left->mem_info)
-		data_src_l = left->mem_info->data_src;
+		data_src_l = *mem_info__data_src(left->mem_info);
 	else
 		data_src_l.mem_lock = PERF_MEM_LOCK_NA;
 
 	if (right->mem_info)
-		data_src_r = right->mem_info->data_src;
+		data_src_r = *mem_info__data_src(right->mem_info);
 	else
 		data_src_r.mem_lock = PERF_MEM_LOCK_NA;
 
@@ -1471,12 +1471,12 @@ sort__tlb_cmp(struct hist_entry *left, struct hist_entry *right)
 	union perf_mem_data_src data_src_r;
 
 	if (left->mem_info)
-		data_src_l = left->mem_info->data_src;
+		data_src_l = *mem_info__data_src(left->mem_info);
 	else
 		data_src_l.mem_dtlb = PERF_MEM_TLB_NA;
 
 	if (right->mem_info)
-		data_src_r = right->mem_info->data_src;
+		data_src_r = *mem_info__data_src(right->mem_info);
 	else
 		data_src_r.mem_dtlb = PERF_MEM_TLB_NA;
 
@@ -1499,12 +1499,12 @@ sort__lvl_cmp(struct hist_entry *left, struct hist_entry *right)
 	union perf_mem_data_src data_src_r;
 
 	if (left->mem_info)
-		data_src_l = left->mem_info->data_src;
+		data_src_l = *mem_info__data_src(left->mem_info);
 	else
 		data_src_l.mem_lvl = PERF_MEM_LVL_NA;
 
 	if (right->mem_info)
-		data_src_r = right->mem_info->data_src;
+		data_src_r = *mem_info__data_src(right->mem_info);
 	else
 		data_src_r.mem_lvl = PERF_MEM_LVL_NA;
 
@@ -1527,12 +1527,12 @@ sort__snoop_cmp(struct hist_entry *left, struct hist_entry *right)
 	union perf_mem_data_src data_src_r;
 
 	if (left->mem_info)
-		data_src_l = left->mem_info->data_src;
+		data_src_l = *mem_info__data_src(left->mem_info);
 	else
 		data_src_l.mem_snoop = PERF_MEM_SNOOP_NA;
 
 	if (right->mem_info)
-		data_src_r = right->mem_info->data_src;
+		data_src_r = *mem_info__data_src(right->mem_info);
 	else
 		data_src_r.mem_snoop = PERF_MEM_SNOOP_NA;
 
@@ -1563,8 +1563,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (left->cpumode > right->cpumode) return -1;
 	if (left->cpumode < right->cpumode) return 1;
 
-	l_map = left->mem_info->daddr.ms.map;
-	r_map = right->mem_info->daddr.ms.map;
+	l_map = mem_info__daddr(left->mem_info)->ms.map;
+	r_map = mem_info__daddr(right->mem_info)->ms.map;
 
 	/* if both are NULL, jump to sort on al_addr instead */
 	if (!l_map && !r_map)
@@ -1599,8 +1599,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 
 addr:
 	/* al_addr does all the right addr - start + offset calculations */
-	l = cl_address(left->mem_info->daddr.al_addr, chk_double_cl);
-	r = cl_address(right->mem_info->daddr.al_addr, chk_double_cl);
+	l = cl_address(mem_info__daddr(left->mem_info)->al_addr, chk_double_cl);
+	r = cl_address(mem_info__daddr(right->mem_info)->al_addr, chk_double_cl);
 
 	if (l > r) return -1;
 	if (l < r) return 1;
@@ -1617,11 +1617,11 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 	char level = he->level;
 
 	if (he->mem_info) {
-		struct map *map = he->mem_info->daddr.ms.map;
+		struct map *map = mem_info__daddr(he->mem_info)->ms.map;
 		struct dso *dso = map ? map__dso(map) : NULL;
 
-		addr = cl_address(he->mem_info->daddr.al_addr, chk_double_cl);
-		ms = &he->mem_info->daddr.ms;
+		addr = cl_address(mem_info__daddr(he->mem_info)->al_addr, chk_double_cl);
+		ms = &mem_info__daddr(he->mem_info)->ms;
 
 		/* print [s] for shared data mmaps */
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
@@ -1806,12 +1806,12 @@ sort__blocked_cmp(struct hist_entry *left, struct hist_entry *right)
 	union perf_mem_data_src data_src_r;
 
 	if (left->mem_info)
-		data_src_l = left->mem_info->data_src;
+		data_src_l = *mem_info__data_src(left->mem_info);
 	else
 		data_src_l.mem_blk = PERF_MEM_BLK_NA;
 
 	if (right->mem_info)
-		data_src_r = right->mem_info->data_src;
+		data_src_r = *mem_info__data_src(right->mem_info);
 	else
 		data_src_r.mem_blk = PERF_MEM_BLK_NA;
 
@@ -1840,9 +1840,9 @@ sort__phys_daddr_cmp(struct hist_entry *left, struct hist_entry *right)
 	uint64_t l = 0, r = 0;
 
 	if (left->mem_info)
-		l = left->mem_info->daddr.phys_addr;
+		l = mem_info__daddr(left->mem_info)->phys_addr;
 	if (right->mem_info)
-		r = right->mem_info->daddr.phys_addr;
+		r = mem_info__daddr(right->mem_info)->phys_addr;
 
 	return (int64_t)(r - l);
 }
@@ -1854,7 +1854,7 @@ static int hist_entry__phys_daddr_snprintf(struct hist_entry *he, char *bf,
 	size_t ret = 0;
 	size_t len = BITS_PER_LONG / 4;
 
-	addr = he->mem_info->daddr.phys_addr;
+	addr = mem_info__daddr(he->mem_info)->phys_addr;
 
 	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", he->level);
 
@@ -1881,9 +1881,9 @@ sort__data_page_size_cmp(struct hist_entry *left, struct hist_entry *right)
 	uint64_t l = 0, r = 0;
 
 	if (left->mem_info)
-		l = left->mem_info->daddr.data_page_size;
+		l = mem_info__daddr(left->mem_info)->data_page_size;
 	if (right->mem_info)
-		r = right->mem_info->daddr.data_page_size;
+		r = mem_info__daddr(right->mem_info)->data_page_size;
 
 	return (int64_t)(r - l);
 }
@@ -1894,7 +1894,7 @@ static int hist_entry__data_page_size_snprintf(struct hist_entry *he, char *bf,
 	char str[PAGE_SIZE_NAME_LEN];
 
 	return repsep_snprintf(bf, size, "%-*s", width,
-			       get_page_size_name(he->mem_info->daddr.data_page_size, str));
+			get_page_size_name(mem_info__daddr(he->mem_info)->data_page_size, str));
 }
 
 struct sort_entry sort_mem_data_page_size = {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


