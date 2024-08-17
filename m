Return-Path: <linux-kernel+bounces-290566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA55A9555D2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED61B226FF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9385613DBA2;
	Sat, 17 Aug 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+V14js1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB8F507
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877113; cv=none; b=O7W1UMRQUa8Ywx8UwkJ4JW+mWc87u/VGkDtPm0RxXfzaPidUxHKxHTjJ/ZVlVkdUkO9JjbB9BaPLHmtVST9VR7CUvn1w9tNE9KvyhinKbrNuI+E806jBBi3oQc2WxqXhVMc6hEzwuIixA435sFtAtUpAZ2ULkkaKhl49ebBYYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877113; c=relaxed/simple;
	bh=vaGNKEiJXAzzF4hjfF7Oz41w5agr1IFSb6If7kSm75Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hq0mYDaQ0IuRNjD9YpUwQLlQ+IbsLlnQ1DEyXbHTkp1KokG24tnHIXzAIyQxvNlcbmv+MEieOr/1EwD6NAq09UH0B4TR2r7DzHgzy3Qe8olnzYMpXFcj8P7vDRIWhiiCQwuWb8FwQc3IVyXBUAXsejNG0x9yTBtmaABCY2HoE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+V14js1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b44f75f886so12277017b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877111; x=1724481911; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5r7bnvRFUBWrS5kWDeEcwFQiANlYqgPSEcymYDkpBqs=;
        b=i+V14js1oSvZxMz89m0m/dMRtXO5O7f0ffJKXO/Fqv4rHKu7Eojj9Uctc21x0fL7zA
         8mAYWLkw/HW1VAkMrhC0khpzzyneyDgjDfLKYxQyZ0kSoAxCg3YAeF1tdO1Y5uZACzLV
         kQrvpEcE1qU4400OOsONvpc/zND3lUkmhmz8wFYtLMHG7BkkJnrtx+PCEzM055QV8Gdv
         L8t0RpcfysrQrMqo9Pjqb0NW/2hnJez6qEGnQRRQp079Q91eaIQS9hEowK6diC/1b4Ve
         uNVmJWr0NKtKdnQP6qK5UgPYra6rkRmZbWmd0bQS2vSwnKuAwXkkNCjpMu7iyvK5cW9b
         zlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877111; x=1724481911;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5r7bnvRFUBWrS5kWDeEcwFQiANlYqgPSEcymYDkpBqs=;
        b=QSspIfD339RjuTLHRNhxpwk1zrkb5pNqD+kG1WLbWQPpFHeSf2MZzKfTMkcpC0mN/k
         5TkqdHdOdtAj5fr5HpUoxOmTV/BdxbtTeBhC6ztxGrZrHIK9fhqEBLVViO8Uxu8bD8O4
         MxKs4T7n2lvCd7w51sIfZjCrUFiKaxhcH5YDAIR1S8hj2/AFJkhO4vnNFWoEv3k8AG6X
         mBd6R9HhDQq7TLJuJBYP9FT9XmSYgM9AsZSscQ2kUtyb6ocXnfs6jqMpFFBJVGCLCKcr
         iBqyNcNEjaMbmKeXV1v+N28dQcTBvyI8X3C3Jj6IoFpRfO863ZbOc1y+QBdyKocmuEPg
         74KA==
X-Forwarded-Encrypted: i=1; AJvYcCU2q30n1Pq1pmk6o/VP2UFykYht14Zd93MFVrKKL8N8wqF5LIQGQzpiXNIgBim8dUo7yuYSkiLRgHXUVQMaKTKGFL5tJ/r6nZa2HtnX
X-Gm-Message-State: AOJu0YzvkLaDxliVEBwSCVYOmj/tdYxK0OEPfk/iWLIgBCJfO55Pd2+H
	XiIJ/DmGomrgVMacLCKedCEeiXJsDYcsxLKUUASDDUgXjiBRVuor+MJxZaKVvPKPm5bzdpOXSew
	pcUBnlA==
X-Google-Smtp-Source: AGHT+IGlcPF2a10mg0azJ+yMp/FA6xLrTtvwRfHpENN3NxES0vbVTMocPo1rsrKU6ZIuhjb7odPV92DivNS3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b13:b0:673:b39a:92f2 with SMTP
 id 00721157ae682-6b1baeae4ccmr292407b3.7.1723877110786; Fri, 16 Aug 2024
 23:45:10 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:33 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 04/13] perf dso: Constify dso_id
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

The passed dso_id is copied and so is never an out argument. Remove
its mutability.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c |  2 +-
 tools/perf/util/dso.c       |  4 ++--
 tools/perf/util/dso.h       |  4 ++--
 tools/perf/util/dsos.c      | 12 ++++++------
 tools/perf/util/dsos.h      |  2 +-
 tools/perf/util/machine.c   |  3 ++-
 tools/perf/util/machine.h   |  3 ++-
 7 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a35bde3f3c09..8440ddfbf4fe 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -411,7 +411,7 @@ static int perf_event__jit_repipe_mmap(const struct perf_tool *tool,
 #endif
 
 static struct dso *findnew_dso(int pid, int tid, const char *filename,
-			       struct dso_id *id, struct machine *machine)
+			       const struct dso_id *id, struct machine *machine)
 {
 	struct thread *thread;
 	struct nsinfo *nsi = NULL;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 67414944f245..5c6e85fdae0d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1327,7 +1327,7 @@ bool dso_id__empty(const struct dso_id *id)
 	return !id->maj && !id->min && !id->ino && !id->ino_generation;
 }
 
-void __dso__inject_id(struct dso *dso, struct dso_id *id)
+void __dso__inject_id(struct dso *dso, const struct dso_id *id)
 {
 	struct dsos *dsos = dso__dsos(dso);
 	struct dso_id *dso_id = dso__id(dso);
@@ -1417,7 +1417,7 @@ void dso__set_sorted_by_name(struct dso *dso)
 	RC_CHK_ACCESS(dso)->sorted_by_name = true;
 }
 
-struct dso *dso__new_id(const char *name, struct dso_id *id)
+struct dso *dso__new_id(const char *name, const struct dso_id *id)
 {
 	RC_STRUCT(dso) *dso = zalloc(sizeof(*dso) + strlen(name) + 1);
 	struct dso *res;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ed0068251c65..bb8e8f444054 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -640,14 +640,14 @@ static inline void dso__set_text_offset(struct dso *dso, u64 val)
 int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
 bool dso_id__empty(const struct dso_id *id);
 
-struct dso *dso__new_id(const char *name, struct dso_id *id);
+struct dso *dso__new_id(const char *name, const struct dso_id *id);
 struct dso *dso__new(const char *name);
 void dso__delete(struct dso *dso);
 
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
-void __dso__inject_id(struct dso *dso, struct dso_id *id);
+void __dso__inject_id(struct dso *dso, const struct dso_id *id);
 
 int dso__name_len(const struct dso *dso);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index d4acdb37f046..e0998e2a7c4e 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -155,7 +155,7 @@ static int dsos__cmp_key_long_name_id(const void *vkey, const void *vdso)
  */
 static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 					       const char *name,
-					       struct dso_id *id,
+					       const struct dso_id *id,
 					       bool write_locked)
 {
 	struct dsos__key key = {
@@ -244,7 +244,7 @@ int dsos__add(struct dsos *dsos, struct dso *dso)
 
 struct dsos__find_id_cb_args {
 	const char *name;
-	struct dso_id *id;
+	const struct dso_id *id;
 	struct dso *res;
 };
 
@@ -260,7 +260,7 @@ static int dsos__find_id_cb(struct dso *dso, void *data)
 
 }
 
-static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct dso_id *id,
+static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, const struct dso_id *id,
 				   bool cmp_short, bool write_locked)
 {
 	struct dso *res;
@@ -321,7 +321,7 @@ static void dso__set_basename(struct dso *dso)
 	dso__set_short_name(dso, base, true);
 }
 
-static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
+static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
 {
 	struct dso *dso = dso__new_id(name, id);
 
@@ -337,7 +337,7 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	return dso;
 }
 
-static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
+static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
 
@@ -347,7 +347,7 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struc
 	return dso ? dso : __dsos__addnew_id(dsos, name, id);
 }
 
-struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
+struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
 {
 	struct dso *dso;
 	down_write(&dsos->lock);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 6c13b65648bc..a26774950866 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -32,7 +32,7 @@ int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
-struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
+struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id);
  
 bool dsos__read_build_ids(struct dsos *dsos, bool with_hits);
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c08774d06d14..cd79a830abae 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3128,7 +3128,8 @@ u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr)
 	return addr_cpumode;
 }
 
-struct dso *machine__findnew_dso_id(struct machine *machine, const char *filename, struct dso_id *id)
+struct dso *machine__findnew_dso_id(struct machine *machine, const char *filename,
+				    const struct dso_id *id)
 {
 	return dsos__findnew_id(&machine->dsos, filename, id);
 }
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 82a47bac8023..a687876e3453 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -207,7 +207,8 @@ int machine__nr_cpus_avail(struct machine *machine);
 
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 
-struct dso *machine__findnew_dso_id(struct machine *machine, const char *filename, struct dso_id *id);
+struct dso *machine__findnew_dso_id(struct machine *machine, const char *filename,
+				    const struct dso_id *id);
 struct dso *machine__findnew_dso(struct machine *machine, const char *filename);
 
 size_t machine__fprintf(struct machine *machine, FILE *fp);
-- 
2.46.0.184.g6999bdac58-goog


