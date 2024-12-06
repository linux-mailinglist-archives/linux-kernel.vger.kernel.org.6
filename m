Return-Path: <linux-kernel+bounces-434408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A39E666B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26678162472
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CE6198850;
	Fri,  6 Dec 2024 04:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITPvaYeR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267D193426
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460044; cv=none; b=K3sOLKKgRtzd9bRCll5VShCY6KkYhs/qEMjjjNyqxjAcNp+mtq6qccnjZm4DiKpiPdiO8vLEUV+uqbBa1U5fdXIBINV01oV6021evmF2EX/C8lZUyJOHwOl3pJr53xOthbSqCXO13dC5DmLolGfIVUO0KuvrFv2r694EK69h58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460044; c=relaxed/simple;
	bh=NvHv1JvgCIj4wxEXi2qnifVrg5VM8kZfYBZjSzBa3dg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IOAuy4HNt/VDOc5TeNB8/Nm5gngErU+tfO0hUoEQF5FQDCxgjFwVIGtUaXDOn5G/dcOsZNKdH/rW/hKntjc1g0DTzQSqCQfljqaj5b1r+t/cjR5YsDfc3rT7VVYhj1SAhffZVzCEjgCGbESRQt9xNHL8/H7i9tFFNMVWcFMYVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITPvaYeR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3a109984a5so309546276.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460041; x=1734064841; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HooQRn/pxrZs6KSP4MCRwKNyrc2n5wJOPs3/bci4Uk=;
        b=ITPvaYeRcgVc38hqEm+Bpq2IJRYcrWPrEtidw63fxdkb4xkrQrGPRGkr3eMrUd65PP
         NT+brCB7suidmG6yIuhtu25HYz+RJTo9UpLHMim2ALkqkbOZ7+FTHuZfWgMBZODnkA72
         Vzk/r3l+m7zQsGT1QeMy3+yXQDi7tcZ1ksDjQfDd8yXzNRWVVE3gSHBbwf6cYB/LNS5W
         TEfGX15BR4/8Ko7oUm5VWveuA1LUq6VsIog0l99rEDb1sO0NOzTpdhZyIXmNtq/YmSx5
         atpmoPDWX+vlonPr8KrmyP6g+B+ewbdBeQOoPMvrV9i+JYh9exa+rTVsmIILhKxZpU3l
         khAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460041; x=1734064841;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HooQRn/pxrZs6KSP4MCRwKNyrc2n5wJOPs3/bci4Uk=;
        b=CXcH2gaKNEmOlKxf3JKE4Nzc8ULxBjeH1M3CWVvCfSSdHY7kqwsDKLAW9Hargk/gZz
         VxNpx4oo7hhKG9zsn+cTicd0c98D8N8WXE3vbF39nL/hszB98t13MeSolRWrHUz13SEK
         204McSZptuNhrc7+WELT+gFCDetcyEpTsJjFTjFjwiN17v1KUmGEROhoD5BN9aShrmQ/
         y8ekS65HlRmfmeAQ2OWT3wFu9zdtZdeoWxE2thmUtQaZbBCTeVpudoBzN7hHzg3b88BB
         UluUqW72bWOQYvVEe3KEsk3Yi8QsTWVhMJjk9wzt9RO7yrQvnyaSqOHOmopIQQRKdjEh
         WGpw==
X-Forwarded-Encrypted: i=1; AJvYcCWmuZVh0ArFRUBcK/22/hAiLeiny6g+sumeG2jdUEpo8jN+p8lBHc9PDhUup3CPlfaZuC5iiZcOFHY0dJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfqsUciM8YkQp8y2v/7LQV+i1KibmJ7FwBqwvmx6RThFFrZ1ft
	P41q5l5gDqDEI3YrTTHWYwFNmfOkdPYw5o/CNCQ/6bN53GJlB5zDZMlRddSnq0P/yzJAWGjXz1U
	oIscalQ==
X-Google-Smtp-Source: AGHT+IHIgCIgWFyGcAWDY7516J4vjQr1pq+XRf6N+uB0/z07nFo7rInpoiDluy+8thojGoFnFz9roVvtzpil
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a25:7c06:0:b0:e38:d1e:af86 with SMTP id
 3f1490d57ef6-e3a0b07413dmr731276.2.1733460040757; Thu, 05 Dec 2024 20:40:40
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:28 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 1/8] perf: Increase MAX_NR_CPUS to 4096
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kyle Meyer <kyle.meyer@hpe.com>

Systems have surpassed 2048 CPUs. Increase MAX_NR_CPUS to 4096.

Bitmaps declared with MAX_NR_CPUS bits will increase from 256B to 512B,
cpus_runtime will increase from 81960B to 163880B, and max_entries will
increase from 8192B to 16384B.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/cpumap.h | 2 +-
 tools/perf/perf.h                        | 2 +-
 tools/perf/util/bpf_skel/kwork_top.bpf.c | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 49649eb51ce4..3cf28522004e 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -22,7 +22,7 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
 };
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS	2048
+#define MAX_NR_CPUS	4096
 #endif
 
 struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index c004dd4e65a3..3cb40965549f 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -3,7 +3,7 @@
 #define _PERF_PERF_H
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS			2048
+#define MAX_NR_CPUS			4096
 #endif
 
 enum perf_affinity {
diff --git a/tools/perf/util/bpf_skel/kwork_top.bpf.c b/tools/perf/util/bpf_skel/kwork_top.bpf.c
index 594da91965a2..73e32e063030 100644
--- a/tools/perf/util/bpf_skel/kwork_top.bpf.c
+++ b/tools/perf/util/bpf_skel/kwork_top.bpf.c
@@ -18,7 +18,9 @@ enum kwork_class_type {
 };
 
 #define MAX_ENTRIES     102400
-#define MAX_NR_CPUS     2048
+#ifndef MAX_NR_CPUS
+#define MAX_NR_CPUS     4096
+#endif
 #define PF_KTHREAD      0x00200000
 #define MAX_COMMAND_LEN 16
 
-- 
2.47.0.338.g60cca15819-goog


