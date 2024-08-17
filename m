Return-Path: <linux-kernel+bounces-290564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD79555D0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1091F22ED3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47513D532;
	Sat, 17 Aug 2024 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XOJqmw/W"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7513E41D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877108; cv=none; b=tvHMY7mgTGaYg8ToPA0i0x2BUg6pEOypbGMk7xRB4MZfRMdxC3a6s+/zqcYvWs04NiN5hYly9GHsVN+ph1wb20k2lb52U7j/jujilZaNf8su38WZwxfdPv+6cXeoyecaJzb/F8hCcVEjlJRp4OVLiQe9R/4M8dPVt0nlSxSjLaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877108; c=relaxed/simple;
	bh=gTRDFpYLNlrakknneQA/FAQIcyaR80SGVOx61iwej84=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HtDyM+gDLwi3vl4TLySatrbtTh5VjZB9aF9XaYQcKNyblJdsXy0Y+iwgd1CD2nBUGztGumAwElpxGGtA0QPs0lG7f8Eq8Pul4mv5FvjtlCgMSDa6aRpAM5Rbbyqac6qkDipIipNhdbaJmWx4z4zpU/3DXd4bit4jODAQLVj+0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XOJqmw/W; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0be1808a36so4307895276.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877106; x=1724481906; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rN2bQVk5OkgIwB1Fv0zphF3BxkmyT/Y2fj34BjcoCDI=;
        b=XOJqmw/WC79ReUdYoYhLVn+xzW4zqiC+GCzR8AhU99ZLirUGQH7stoNbxvzx9K4TUV
         jrDkxethYcWqBAlKUGeAefJ2NDdG3JkYVGvxzvU8GGLkmPDax5nUfxhoBcSzUwVeSajX
         16gpAtToU6yW4f7o3DRJsr6by2JrF0BVEgWkQ7p2G/Zx2haI/MNgn4I21h7yuJeelZR4
         SRfeRgZovJc5+9bAR8/BADVjxYLLb5sjEUI+y7plJkZM4KnbZ8zHGxDHukZI4IyHAY9q
         kOfhe0YyEwAYKzuJbEaFMTB9w0AR8glglY9Tm7iJuLafxEROaHkkMfw+tYhn7WmPH5eF
         TPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877106; x=1724481906;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rN2bQVk5OkgIwB1Fv0zphF3BxkmyT/Y2fj34BjcoCDI=;
        b=tA/gyMMlwk1Pqx2TArdAfiB1ng3xjC1H3pE5wLfhuifmIVLTlhhOoeygMapYLd+u/U
         +kxbVovrMfOk5FWuRMVq3VGdiHf78DQrdJz+ZdtYCsL7OpJacu3MBDCar3jrc3kNkwg1
         /tmx8t1hfx9nv0RFRQXrGBLg0v9Np+lQ6F6OWipFkcnVsmFB9sBTaeO7YBvNdyl6e+2A
         gfVZ9h2WjLIWFb5TC3eyuJl0mp97q1xbcTk32oNTQpgcWnn5ezKcQkFERyXlWjaEA2mz
         3s9B4sSKBF5Bs/L5jvJ73LCseYflQwG7n/hSWzGkHVnLfOy5B9pA6b92WZKFTX83cAJ+
         709Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGawt09NCOtZ6Vi/bUA5KGOxFquTBcukY7SY/hNQ4xVOwtDAf1ZiydvwRoyyjLaZXTxxqBMUfGdEc84r9lDD7r5I6Wrfsg4t9oUP3D
X-Gm-Message-State: AOJu0Yz2HnMDbzfh8OfOzxc8tmr7FF1ogX95us4jxUnyLgEm0uwK0H9k
	UN7oMkrVG6yivcJgYdI9ubVDb8sPWeJ8tj7tHUR/0/pii/dKvTageHRMIdPhauUo6rCcdTxY3gd
	DWbKHrg==
X-Google-Smtp-Source: AGHT+IFz/d7kKhLXM3B8opmAt9DpVCoXyHPmqqZ9siDIPulFjBaWeU2wl7wRQzaoGMjKbtKBLqj4blJlvBJ1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:6902:11:b0:e0b:fe07:1e22 with SMTP id
 3f1490d57ef6-e1180e61040mr21103276.1.1723877106044; Fri, 16 Aug 2024 23:45:06
 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:31 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 02/13] perf map: API clean up
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

map__init is only used internally so make it static. Assume memory is
zero initialized, which will better support adding fields to struct
map in the future and was already the case for map__new2. To reduce
complexity, change set_priv and set_erange_warned to not take a value
to assign as they always assign true.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c            |  2 +-
 tools/perf/tests/vmlinux-kallsyms.c |  4 ++--
 tools/perf/util/map.c               | 24 ++++++++++++------------
 tools/perf/util/map.h               | 11 ++++-------
 4 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 881b861c35ee..724a79386321 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -191,7 +191,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 	if (use_browser <= 0)
 		sleep(5);
 
-	map__set_erange_warned(map, true);
+	map__set_erange_warned(map);
 }
 
 static void perf_top__record_precise_ip(struct perf_top *top,
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index cd3b480d20bd..74cdbd2ce9d0 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -131,7 +131,7 @@ static int test__vmlinux_matches_kallsyms_cb1(struct map *map, void *data)
 					(dso__kernel(dso) ? dso__short_name(dso) : dso__name(dso)));
 
 	if (pair) {
-		map__set_priv(pair, 1);
+		map__set_priv(pair);
 		map__put(pair);
 	} else {
 		if (!args->header_printed) {
@@ -166,7 +166,7 @@ static int test__vmlinux_matches_kallsyms_cb2(struct map *map, void *data)
 			pr_info(":\nWARN: *%" PRIx64 "-%" PRIx64 " %" PRIx64,
 				map__start(pair), map__end(pair), map__pgoff(pair));
 		pr_info(" %s\n", dso__name(dso));
-		map__set_priv(pair, 1);
+		map__set_priv(pair);
 	}
 	map__put(pair);
 	return 0;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e1d14936a60d..e781c8d56a9a 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -102,16 +102,20 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 	return false;
 }
 
-void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
+static void map__init(struct map *map, u64 start, u64 end, u64 pgoff,
+		      struct dso *dso, u32 prot, u32 flags)
 {
 	map__set_start(map, start);
 	map__set_end(map, end);
 	map__set_pgoff(map, pgoff);
-	map__set_reloc(map, 0);
+	assert(map__reloc(map) == 0);
 	map__set_dso(map, dso__get(dso));
-	map__set_mapping_type(map, MAPPING_TYPE__DSO);
-	map__set_erange_warned(map, false);
 	refcount_set(map__refcnt(map), 1);
+	RC_CHK_ACCESS(map)->prot = prot;
+	RC_CHK_ACCESS(map)->flags = flags;
+	map__set_mapping_type(map, MAPPING_TYPE__DSO);
+	assert(map__erange_warned(map) == false);
+	assert(map__priv(map) == false);
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
@@ -124,7 +128,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 	struct nsinfo *nsi = NULL;
 	struct nsinfo *nnsi;
 
-	map = malloc(sizeof(*map));
+	map = zalloc(sizeof(*map));
 	if (ADD_RC_CHK(result, map)) {
 		char newfilename[PATH_MAX];
 		struct dso *dso, *header_bid_dso;
@@ -134,8 +138,6 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		anon = is_anon_memory(filename) || flags & MAP_HUGETLB;
 		vdso = is_vdso_map(filename);
 		no_dso = is_no_dso_memory(filename);
-		map->prot = prot;
-		map->flags = flags;
 		nsi = nsinfo__get(thread__nsinfo(thread));
 
 		if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
@@ -169,7 +171,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			goto out_delete;
 
 		assert(!dso__kernel(dso));
-		map__init(result, start, start + len, pgoff, dso);
+		map__init(result, start, start + len, pgoff, dso, prot, flags);
 
 		if (anon || no_dso) {
 			map->mapping_type = MAPPING_TYPE__IDENTITY;
@@ -223,10 +225,8 @@ struct map *map__new2(u64 start, struct dso *dso)
 
 	map = calloc(1, sizeof(*map) + (dso__kernel(dso) ? sizeof(struct kmap) : 0));
 	if (ADD_RC_CHK(result, map)) {
-		/*
-		 * ->end will be filled after we load all the symbols
-		 */
-		map__init(result, start, 0, 0, dso);
+		/* ->end will be filled after we load all the symbols. */
+		map__init(result, start, /*end=*/0, /*pgoff=*/0, dso, /*prot=*/0, /*flags=*/0);
 	}
 
 	return result;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 65e2609fa1b1..6c43f31a9fe0 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -166,9 +166,6 @@ struct thread;
 #define map__for_each_symbol_by_name(map, sym_name, pos, idx)	\
 	__map__for_each_symbol_by_name(map, sym_name, (pos), idx)
 
-void map__init(struct map *map,
-	       u64 start, u64 end, u64 pgoff, struct dso *dso);
-
 struct dso_id;
 struct build_id;
 
@@ -285,14 +282,14 @@ static inline void map__set_reloc(struct map *map, u64 reloc)
 	RC_CHK_ACCESS(map)->reloc = reloc;
 }
 
-static inline void map__set_priv(struct map *map, int priv)
+static inline void map__set_priv(struct map *map)
 {
-	RC_CHK_ACCESS(map)->priv = priv;
+	RC_CHK_ACCESS(map)->priv = true;
 }
 
-static inline void map__set_erange_warned(struct map *map, bool erange_warned)
+static inline void map__set_erange_warned(struct map *map)
 {
-	RC_CHK_ACCESS(map)->erange_warned = erange_warned;
+	RC_CHK_ACCESS(map)->erange_warned = true;
 }
 
 static inline void map__set_dso(struct map *map, struct dso *dso)
-- 
2.46.0.184.g6999bdac58-goog


