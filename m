Return-Path: <linux-kernel+bounces-400295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46BD9C0B82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654EC283073
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D302C218D7E;
	Thu,  7 Nov 2024 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDKcSvbv"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B521894A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996449; cv=none; b=jSI90vN4zNyCmC4cWkpCbXkYT3+G0Nf+/4mmJNxmXUXuvrtQ0Eg7mrqRK0vCrYUw1lI3lT/SugLwN76sQ0+R0Df4moEbZUQiXxFHUWT6PB8Zo6Ngjadcup6AhfJGyD9ORqFgt8uO7na9l473OrLC/C+H+gPK0X/edWRxK8aJZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996449; c=relaxed/simple;
	bh=UGgs7qpyQsaOAD/+38PffSoTksURxSZGP6Fxx9r4zHE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=h0FXcGItQypk9Q7ftuIpeq0/fVGElyof5boR6LxcMZwyaZvXi6TqtJbsIvUeinIfpkUN7X6U+zEPbghETDfKbF/z8+yuHdTf2Dsdi4p4Yb6ldgwOKDKzbs23N+9YVnWK3tPg8IvLw6KLRxUjQCUEKyaYfXiUKR/qwytg/A/327Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDKcSvbv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2954ada861so2000332276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 08:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996447; x=1731601247; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeV5H6hULi4PmNWhXYnKicIpV1Vf/5KV4yP0bFilR2g=;
        b=rDKcSvbvM083GVA9yBW6NxSP+6ueGE08VbwHqnkxkWtv0EOIE/SwlAg4pbqVCbYO73
         NEpB/TZ2/nDamaKLgdFf96h5kmt9Us4PhNZhlGDwbJQLZJuXacQ87eYh8PYpaWNh0dzQ
         /SbB0tiUYHfGll/odbtn4IWY4kGhvvazJuEV9t7Dgs/3NjzraDnp76bOHyY6bX2Lyd4S
         z0hQ6UFe5SIczg94515OxBsVV7F4Oc2zDQwbMNkaCFoQ2SLKoF2XkPgb4BnltBtXA6JX
         l5L6sqBSEXyMcdQXcYweWuLUYShNq6q90xy2ZR5zaRDkNUHVCdVODW6rv4G4U7UoyH1H
         x5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996447; x=1731601247;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeV5H6hULi4PmNWhXYnKicIpV1Vf/5KV4yP0bFilR2g=;
        b=QNRs4WmoduPVCNXAaYntTupgUGr8nxcIHtRxRGmRB/0oe9+d+P35Qrm+4u4AyXstex
         Obql8NNeO2ZhSREd6TLgbSk4SqqbHrXCS8Xo/2HSx2E9/oppIeb4YiMeMnmCFBaoLDAx
         8f8A+EiVg5QT0rhJsIpf/4By/caqpH62k1lcUAAlpi+ezITew28BlIUqZS6cVL5y8xxM
         QIbddqYkceuMGcr6SafEcjtA3206U2/gLX83FQUZobME5W23QXeArk7lp+KEIgjCU0Xi
         qVwWJ3QbcZZECgxBMgAhm7f5Z8c2hJgweqXR+Yz6onb8bpznu/uRd1riUILl+F+7OTWq
         59/w==
X-Forwarded-Encrypted: i=1; AJvYcCVCIf7fowLAJ76U2oqpNs+cl90LRURGbAzCLqvgemzaCC70au29QOLO1SQazoBJMEoIxeGi4IeDZ/Y40rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgF6APIgupNN/trcoCygRI6ebLX9snw7vrKr2sOonFtpn5993
	nmcWtTfNGLlEhYBqR6ChBMxC6eZ7C/IYLOswUVT3PdGsJjU30noHpki66N3M1RPrVPL9PBi19FN
	+EjfrXA==
X-Google-Smtp-Source: AGHT+IGjhnQlyx60uwo4p9IkAZDT92KIybjWbIW3SuIDxmWBljHRgORYz+qbzqRTmwlk3UFalbtBGeNtiEp3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a25:8382:0:b0:e2b:ce2f:787a with SMTP id
 3f1490d57ef6-e3087a603e2mr94177276.3.1730996447029; Thu, 07 Nov 2024 08:20:47
 -0800 (PST)
Date: Thu,  7 Nov 2024 08:20:30 -0800
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
Message-Id: <20241107162035.52206-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 3/8] perf header: Refactor get_cpuid to take a CPU for ARM
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

ARM BIG.little has no notion of a constant CPUID for both core
types. To reflect this reality, change the get_cpuid function to also
pass in a possibly unused logical cpu. If the dummy value (-1) is
passed in then ARM can, as currently happens, select the first logical
CPU's "CPUID". The changes to ARM getcpuid happen in a follow up
change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/header.c     | 2 +-
 tools/perf/arch/loongarch/util/header.c | 2 +-
 tools/perf/arch/powerpc/util/header.c   | 2 +-
 tools/perf/arch/riscv/util/header.c     | 2 +-
 tools/perf/arch/s390/util/header.c      | 2 +-
 tools/perf/arch/x86/util/auxtrace.c     | 3 ++-
 tools/perf/arch/x86/util/header.c       | 2 +-
 tools/perf/builtin-kvm.c                | 4 +++-
 tools/perf/util/env.c                   | 3 ++-
 tools/perf/util/header.c                | 9 +++++----
 tools/perf/util/header.h                | 2 +-
 11 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 741df3614a09..760c21784713 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -50,7 +50,7 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 	return ret;
 }
 
-int get_cpuid(char *buf, size_t sz)
+int get_cpuid(char *buf, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	struct perf_cpu_map *cpus = perf_cpu_map__new_online_cpus();
 	int ret;
diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arch/loongarch/util/header.c
index d962dff55512..f1f0b116962d 100644
--- a/tools/perf/arch/loongarch/util/header.c
+++ b/tools/perf/arch/loongarch/util/header.c
@@ -70,7 +70,7 @@ static char *_get_cpuid(void)
 	return cpuid;
 }
 
-int get_cpuid(char *buffer, size_t sz)
+int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	int ret = 0;
 	char *cpuid = _get_cpuid();
diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 251cdbf58a4d..6d1a63a2922f 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -24,7 +24,7 @@ static bool is_compat_mode(void)
 }
 
 int
-get_cpuid(char *buffer, size_t sz)
+get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	unsigned long pvr;
 	int nb;
diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/util/header.c
index 1b29030021ee..ebac294c877f 100644
--- a/tools/perf/arch/riscv/util/header.c
+++ b/tools/perf/arch/riscv/util/header.c
@@ -81,7 +81,7 @@ static char *_get_cpuid(void)
 	return cpuid;
 }
 
-int get_cpuid(char *buffer, size_t sz)
+int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	char *cpuid = _get_cpuid();
 	int ret = 0;
diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 7933f6871c81..2add1a561242 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -27,7 +27,7 @@
 #define SYSINFO		"/proc/sysinfo"
 #define SRVLVL		"/proc/service_levels"
 
-int get_cpuid(char *buffer, size_t sz)
+int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	char *cp, *line = NULL, *line2;
 	char type[8], model[33], version[8], manufacturer[32], authorization[8];
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 354780ff1605..ecbf61a7eb3a 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -55,11 +55,12 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 					      int *err)
 {
 	char buffer[64];
+	struct perf_cpu cpu = perf_cpu_map__min(evlist->core.all_cpus);
 	int ret;
 
 	*err = 0;
 
-	ret = get_cpuid(buffer, sizeof(buffer));
+	ret = get_cpuid(buffer, sizeof(buffer), cpu);
 	if (ret) {
 		*err = ret;
 		return NULL;
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index a51444a77a5f..690f86cbbb1c 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -58,7 +58,7 @@ __get_cpuid(char *buffer, size_t sz, const char *fmt)
 }
 
 int
-get_cpuid(char *buffer, size_t sz)
+get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 {
 	return __get_cpuid(buffer, sz, "%s,%u,%u,%u$");
 }
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 099ce3ebf67c..274568d712d1 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1226,7 +1226,9 @@ static int cpu_isa_config(struct perf_kvm_stat *kvm)
 	int err;
 
 	if (kvm->live) {
-		err = get_cpuid(buf, sizeof(buf));
+		struct perf_cpu cpu = {-1};
+
+		err = get_cpuid(buf, sizeof(buf), cpu);
 		if (err != 0) {
 			pr_err("Failed to look up CPU type: %s\n",
 			       str_error_r(err, buf, sizeof(buf)));
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index ccb464026642..93cabdd7ff43 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -373,7 +373,8 @@ int perf_env__read_pmu_mappings(struct perf_env *env)
 int perf_env__read_cpuid(struct perf_env *env)
 {
 	char cpuid[128];
-	int err = get_cpuid(cpuid, sizeof(cpuid));
+	struct perf_cpu cpu = {-1};
+	int err = get_cpuid(cpuid, sizeof(cpuid), cpu);
 
 	if (err)
 		return err;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 55c28e4377ec..60b42ddc3dac 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -856,18 +856,19 @@ int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
  * default get_cpuid(): nothing gets recorded
  * actual implementation must be in arch/$(SRCARCH)/util/header.c
  */
-int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
+int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused,
+		     struct perf_cpu cpu __maybe_unused)
 {
 	return ENOSYS; /* Not implemented */
 }
 
-static int write_cpuid(struct feat_fd *ff,
-		       struct evlist *evlist __maybe_unused)
+static int write_cpuid(struct feat_fd *ff, struct evlist *evlist)
 {
+	struct perf_cpu cpu = perf_cpu_map__min(evlist->core.all_cpus);
 	char buffer[64];
 	int ret;
 
-	ret = get_cpuid(buffer, sizeof(buffer));
+	ret = get_cpuid(buffer, sizeof(buffer), cpu);
 	if (ret)
 		return -1;
 
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index e91e89d22537..b77f89de12dd 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -201,7 +201,7 @@ int build_caches_for_cpu(u32 cpu, struct cpu_cache_level caches[], u32 *cntp);
 /*
  * arch specific callback
  */
-int get_cpuid(char *buffer, size_t sz);
+int get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu);
 
 char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);
 int strcmp_cpuid_str(const char *s1, const char *s2);
-- 
2.47.0.199.ga7371fff76-goog


