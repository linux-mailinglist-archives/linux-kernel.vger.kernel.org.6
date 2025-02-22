Return-Path: <linux-kernel+bounces-526971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F4A405C8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6914244E8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204F72045A1;
	Sat, 22 Feb 2025 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0UgK3m8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5916203709
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204637; cv=none; b=iSPaxETD4UxCyXVSAYMK/PShFAqBlU1y9XAhZEXjbAjRosb1EMiHFffpvnqyySAAumPwWoPZ3BP2drJaT3vD3lEHYZ1LG+spy627D/DPSfbre6MwVZSX5pBUuz5He+lq0f+dhr2b5p+pgPv7lsj84hEj8lI4bjMZZ3KDjRS3rWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204637; c=relaxed/simple;
	bh=LRozhCJXL5k6IKqHIrkVd30rMKT/7gwCcsKW8bf38xo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=MVPFUpWDcMsFegnQmDNd4XdeckfPsSuzzHsU0pJQpdFk3tQhtp+lkU+GlFq2nMYGJq+gXanfRSKXzZEJ6xZVYTNlNm8h5zwTXyIViU9BRV6XmSB5j1kMuSlH8lURxjcdfD154D9p7dDNdRlv9fAJzYJElXdqL32DvBT9LOyIzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0UgK3m8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f27dd44f86so39759317b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740204635; x=1740809435; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNqTKXDdLcTTDXYG7o7DuC+JW2tM4rFG1DmHs5toIAA=;
        b=f0UgK3m8z1M6AuzVluTZbL5POerRmG5AXxyU0W+tQvVpiVimxNFenFtkkFomxgs+RK
         ZvrlDi0bgAavJDkyab5YibwJjgJ3oPs7jsc0s02HTjNB3n6ZgBnOo8F7lTQNP3k8k1ha
         TN61x5hSWV2FYbLlPkgp2zEa0tlBTs+/noQ0ShwzoPpC2NKnI2x4BVUWnO1k2AD7Rc9a
         P95cz2RbkWYInk4CyHeQSq6me2KuaOV94QUezruAQciMpsDsrg6DufKrs+zaBJ3tfzKe
         qQSVCOE8zEYF2ro5PDD9lqSyy9mMTo1GfpxOo+L5RL2AXIzk3hLOd27JN8lbn7Qt/kY/
         KP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740204635; x=1740809435;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNqTKXDdLcTTDXYG7o7DuC+JW2tM4rFG1DmHs5toIAA=;
        b=bvg5e/2zwu+TRiDSMaeu8rFSxEQ96kZ3sJxgbADkWJ/nYWl4748vlqEV6vbZBLwu97
         +t/C+w+58GbeOgcEdBWsLhWUsNOCjVWI0WwAwD+l56oPz9c7tokTOT2s8BtKcZCc3LCT
         QY1vSPfoIr0whxNaxwQpGdAtXQZ4VmT+/Rj6xK0bFoRCmVnqqm7Imdp6aT/NuykoWC/a
         omdWiWvFVw3Y1NePd66/Diukv9hn5gVCAp/5thvMSYR8qX5VjGqbi0QvTk/9XVWIQS7u
         NPMDBPXgqdmTRtlbuRyEDOh6NzdsnIlwgr5veIy9UBMWUknjbkLt6A5SwF0zsr54eodY
         Qw8g==
X-Forwarded-Encrypted: i=1; AJvYcCVQPKHE2TWVZP8r0WuJ9JREU7ks6AP+a7DadyGfHtwqcVCXhe9vJOi0OFqehw3uaZIIOZ6f+5YMSd+NNCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBgpeK7i9xdOQZctxvyEWQ9qynIurjlp3IdGrKxVtMnRljeGV
	wdyNTJJ1uRbDY/Wqw7mNwylmmNTUAjgY7gFAEp3Z0NT5ntN6n6X++m6KQR8rfPa3Ymmykju53aW
	iDvTsLw==
X-Google-Smtp-Source: AGHT+IEHISW9UexRhcuM6WLs8YyW+s2ZKyLI5YvTgb5iTjI0yLM9WEcZKp6clAbMyUZaJSQjrqAKYihmNOWq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5003:3a14:d4e7:121])
 (user=irogers job=sendgmr) by 2002:a05:690c:6e0f:b0:6fb:b96f:b3e7 with SMTP
 id 00721157ae682-6fbcc39fd50mr7540767b3.6.1740204634743; Fri, 21 Feb 2025
 22:10:34 -0800 (PST)
Date: Fri, 21 Feb 2025 22:10:10 -0800
In-Reply-To: <20250222061015.303622-1-irogers@google.com>
Message-Id: <20250222061015.303622-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Subject: [PATCH v3 5/8] perf events: Remove scandir in thread synthesis
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This avoids scanddir reading the directory into memory that's
allocated and instead allocates on the stack.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2dfc4260d36d..2fc4d0537840 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -38,6 +38,7 @@
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
 #include <api/fs/fs.h>
 #include <api/io.h>
+#include <api/io_dir.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -767,10 +768,10 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 				      bool needs_mmap, bool mmap_data)
 {
 	char filename[PATH_MAX];
-	struct dirent **dirent;
+	struct io_dir iod;
+	struct io_dirent64 *dent;
 	pid_t tgid, ppid;
 	int rc = 0;
-	int i, n;
 
 	/* special case: only send one comm event using passed in pid */
 	if (!full) {
@@ -802,16 +803,19 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	snprintf(filename, sizeof(filename), "%s/proc/%d/task",
 		 machine->root_dir, pid);
 
-	n = scandir(filename, &dirent, filter_task, NULL);
-	if (n < 0)
-		return n;
+	io_dir__init(&iod, open(filename, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (iod.dirfd < 0)
+		return -1;
 
-	for (i = 0; i < n; i++) {
+	while ((dent = io_dir__readdir(&iod)) != NULL) {
 		char *end;
 		pid_t _pid;
 		bool kernel_thread = false;
 
-		_pid = strtol(dirent[i]->d_name, &end, 10);
+		if (!isdigit(dent->d_name[0]))
+			continue;
+
+		_pid = strtol(dent->d_name, &end, 10);
 		if (*end)
 			continue;
 
@@ -845,9 +849,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		}
 	}
 
-	for (i = 0; i < n; i++)
-		zfree(&dirent[i]);
-	free(dirent);
+	close(iod.dirfd);
 
 	return rc;
 }
-- 
2.48.1.658.g4767266eb4-goog


