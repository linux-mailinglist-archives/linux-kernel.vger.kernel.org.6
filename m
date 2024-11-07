Return-Path: <linux-kernel+bounces-399441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE4E9BFEEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607ECB22B66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFF91DE4F8;
	Thu,  7 Nov 2024 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmQwcCmr"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDAD1DE4EA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963769; cv=none; b=PW/TNNE+jzvvaNxdA4iRjqLgqqXJdUzqMCoIkKtWj6QOxC/4lLGuxyzN9MXLenut+2fTbuCgs5wKGrJV54Q3+sSx+UAhNTyh55LSPLVUjP0vvsfkTc0/XxKSvZaWClLg9IJQcbVvu5ZCoVlmVGP4/leyw3VgmC12bBLFxHYso+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963769; c=relaxed/simple;
	bh=owS3gFAXW6+G60tXNdObjtbFPJBTnB5LTfABtjIlfns=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H5Q7wvbKXZmcD4PXdQ8Hazmu4neK/4bJMrktBfVOigC10+LYn/f9P6iDfvXXoX3NxNX6v1g3aRLvT0egsnHtB2ptWcNn7bqVkN5Z6nXBA8tTYMahx/OMaUFIlZJux8IQZlanZu6lCGq8/onIVR2NY0bXC6WJW86t+vbzWqTzZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmQwcCmr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea86f1df79so12647077b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 23:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730963766; x=1731568566; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5CBVRj+oeokqCZ8tX2zkzcVhcgEep+JK2ByfRR+yWc=;
        b=PmQwcCmrKT0g+lU0C8GqAqIjX3LwTFkw0pboQCie3g5JbxlK6xmz1Cr/3+i94HtuAL
         Ra5CWXJsU5sMe2eKOJQrLGxVP/UJdur/0zDZaZu4DALQ7+fKQp78tP89SK+DIIBhrvI+
         Vi96CmaScOAsZ3EgPwKe/yc7cSBWQsvrxKEMq0kdpJHfKk1Q3UbQb8LicSpvQEzjAiRN
         L+P770lmr9AH+rx62yL+aSDi0DqBEHkMhcaEV+EyhqktTFtMlGBjwuWwM9KpBYXH9tHA
         OS0epA/SCc79SKn5PArGCVn+mInt5bKdgnEC0vGEfw592qdisuVehSvPMkZpui1GpG42
         0KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963766; x=1731568566;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5CBVRj+oeokqCZ8tX2zkzcVhcgEep+JK2ByfRR+yWc=;
        b=Q/g9JcQvnGbDdvBPVJmVbywlkAsZpSt8DH+78dV2+C2jSK22Mm49mTemg293mlINq1
         p7GfQb6BDkRPajpgZfoe5hn68vhBGkKFH2iHdNyDNMw6HNP//DWIkCmrpERS1o8SOipN
         udBA3yMbAyLwTq6g6WJqcE9xX7NzQAWuhqCYgs0kg4NkU6v8KNt1HZJZF3MM7BeJ8jjJ
         2TFQhrzpnD8yM6+l+ATBrGY2ls2MHYxAb42GXxv+A6n4jXA+ZfhASqPQUa3GFPS6RrIW
         29vnucTpcNC9YYt1XdEuoJLl5xzm59yTNCmSwi18LFG6oPhP314lhC4Ny8Etz4rDG9y8
         nLgg==
X-Forwarded-Encrypted: i=1; AJvYcCWf10nO7UyrGbrtqLN7Qtm8K9rjWJTB3KDSs4oLZ69gLO4BoTXLKbxxwR1j0fGhYoL6Xedpn3mtyaYcijs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx88sGXxh1MpHZw3k82zbSBRdnnN+ZvRIWC5jLe3h861CnBdwI+
	6lznlS8DNHdwd4C98sZhH1bgruVWE/WUG1SH8S5c5wgAldRPSAi8j35UqCkL25l9sOWzM9PmLpV
	qlmtVPQ==
X-Google-Smtp-Source: AGHT+IEd0XW+XP13/lIdiLfA1JS+O6Mq9dYjD7PUyhpWzqvtXDfGa/+OwNkNynbL8Jl1y47mBuEBrXARi0WE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a25:a305:0:b0:e11:639b:6428 with SMTP id
 3f1490d57ef6-e3087722c24mr85002276.0.1730963765469; Wed, 06 Nov 2024 23:16:05
 -0800 (PST)
Date: Wed,  6 Nov 2024 23:15:54 -0800
In-Reply-To: <20241107071600.9082-1-irogers@google.com>
Message-Id: <20241107071600.9082-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107071600.9082-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 1/7] perf header: Move is_cpu_online to numa bench
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

The helper function is only used in the NUMA benchmark as typically
online CPUs are determined through
perf_cpu_map__new_online_cpus(). Reduce the scope of the function for
now.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/numa.c  | 51 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.c | 51 ----------------------------------------
 tools/perf/util/header.h |  1 -
 3 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 1fbd7c947abc..611451dbc234 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -533,6 +533,57 @@ static int parse_cpu_list(const char *arg)
 	return 0;
 }
 
+/*
+ * Check whether a CPU is online
+ *
+ * Returns:
+ *     1 -> if CPU is online
+ *     0 -> if CPU is offline
+ *    -1 -> error case
+ */
+static int is_cpu_online(unsigned int cpu)
+{
+	char *str;
+	size_t strlen;
+	char buf[256];
+	int status = -1;
+	struct stat statbuf;
+
+	snprintf(buf, sizeof(buf),
+		"/sys/devices/system/cpu/cpu%d", cpu);
+	if (stat(buf, &statbuf) != 0)
+		return 0;
+
+	/*
+	 * Check if /sys/devices/system/cpu/cpux/online file
+	 * exists. Some cases cpu0 won't have online file since
+	 * it is not expected to be turned off generally.
+	 * In kernels without CONFIG_HOTPLUG_CPU, this
+	 * file won't exist
+	 */
+	snprintf(buf, sizeof(buf),
+		"/sys/devices/system/cpu/cpu%d/online", cpu);
+	if (stat(buf, &statbuf) != 0)
+		return 1;
+
+	/*
+	 * Read online file using sysfs__read_str.
+	 * If read or open fails, return -1.
+	 * If read succeeds, return value from file
+	 * which gets stored in "str"
+	 */
+	snprintf(buf, sizeof(buf),
+		"devices/system/cpu/cpu%d/online", cpu);
+
+	if (sysfs__read_str(buf, &str, &strlen) < 0)
+		return status;
+
+	status = atoi(str);
+
+	free(str);
+	return status;
+}
+
 static int parse_setup_cpu_list(void)
 {
 	struct thread_data *td;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a6386d12afd7..55c28e4377ec 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -987,57 +987,6 @@ static int write_dir_format(struct feat_fd *ff,
 	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
 }
 
-/*
- * Check whether a CPU is online
- *
- * Returns:
- *     1 -> if CPU is online
- *     0 -> if CPU is offline
- *    -1 -> error case
- */
-int is_cpu_online(unsigned int cpu)
-{
-	char *str;
-	size_t strlen;
-	char buf[256];
-	int status = -1;
-	struct stat statbuf;
-
-	snprintf(buf, sizeof(buf),
-		"/sys/devices/system/cpu/cpu%d", cpu);
-	if (stat(buf, &statbuf) != 0)
-		return 0;
-
-	/*
-	 * Check if /sys/devices/system/cpu/cpux/online file
-	 * exists. Some cases cpu0 won't have online file since
-	 * it is not expected to be turned off generally.
-	 * In kernels without CONFIG_HOTPLUG_CPU, this
-	 * file won't exist
-	 */
-	snprintf(buf, sizeof(buf),
-		"/sys/devices/system/cpu/cpu%d/online", cpu);
-	if (stat(buf, &statbuf) != 0)
-		return 1;
-
-	/*
-	 * Read online file using sysfs__read_str.
-	 * If read or open fails, return -1.
-	 * If read succeeds, return value from file
-	 * which gets stored in "str"
-	 */
-	snprintf(buf, sizeof(buf),
-		"devices/system/cpu/cpu%d/online", cpu);
-
-	if (sysfs__read_str(buf, &str, &strlen) < 0)
-		return status;
-
-	status = atoi(str);
-
-	free(str);
-	return status;
-}
-
 #ifdef HAVE_LIBBPF_SUPPORT
 static int write_bpf_prog_info(struct feat_fd *ff,
 			       struct evlist *evlist __maybe_unused)
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index a63a361f20f4..e91e89d22537 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -196,7 +196,6 @@ int write_padded(struct feat_fd *fd, const void *bf,
 
 #define MAX_CACHE_LVL 4
 
-int is_cpu_online(unsigned int cpu);
 int build_caches_for_cpu(u32 cpu, struct cpu_cache_level caches[], u32 *cntp);
 
 /*
-- 
2.47.0.199.ga7371fff76-goog


