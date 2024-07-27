Return-Path: <linux-kernel+bounces-266153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E2A93FBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC751F23A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE117C7C1;
	Mon, 29 Jul 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ekjWg2T5"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315016F265
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271570; cv=none; b=J7l/2CFMOt9DHdwQiZpHVkjvmLjsi7nXQIwx7eeRtzWkjxrP/VfjFR4XtP5O0vXS93bFTuGwSu/DblCWM03SDkaO/yp9LvU7wINi39hHqD0j5LDc7Kk+829NISL4oUDTP8t8uPT0qNj6K/pYeLjjAgtjBLRkjdihSA3yKoO/1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271570; c=relaxed/simple;
	bh=tPwVwQ9afMUi2qsyAkI7jXUjgcctJpljCtDAaGNiM3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZqK92Q7Vfpp/DodJwIxDMIwA6yp7xcBle2zfmAsyNH9DEvkOi5/9Oul22jMdHvNfrdTZD/SGA811TTHy8YYJBstQ5fNdsB5K0aawVKtK/QJLR69ghYujuiXIWBowg4wO6o13QdRegA5PXrUfiIh98lmDJ4dRCUmKRmkJdagQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ekjWg2T5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc47abc040so19094185ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271568; x=1722876368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aScmstzHvx/v7UKZvzRNSOVMJdMn5iWDOIaOoUqNRU=;
        b=ekjWg2T5jNm1Mi5eKw2PnG2c7qdoRkeDWRyyl4sFWGls+/dFD8mna88jsJ1alFjekc
         SCPOmJl2Qc74r9VfQ2uHjni9pFzcs3g7WfGkdIED/W+W4X5aDH5sSfqWBBeznml+Um7Y
         PLm3boLWSwTL2yljrjT63jfiy8tCH9/BVhmSb97Xcq+mCQAJewAu6uP4XmAX1U4BxwXy
         KIlblP/xOMEfxoEUdZiISS1skreEV2ctDKIww0f9pCNp61yUR82UZkRQUY9Te7DVQ4PI
         ALYa4ALKPgXqvr2hxYQVwyDCkW9kJ+rk16235xsIYeADXamM0Jb36OJrhmFI4BqbGsFg
         XgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271568; x=1722876368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aScmstzHvx/v7UKZvzRNSOVMJdMn5iWDOIaOoUqNRU=;
        b=MNd8yypFQynKzxDyCfR+2eJ73eUUhc/YlHECxDAv+0BA+pPMfRGrpHjWdNzNB/DFeq
         a1zDpQOHEcZWNOEGuHBnv58YW846CCrbGVlIXIXVEzfrqdv5Gr+/acm2RYs/fFNAKz8k
         hjhsCSIJ6DAjGAtK/WDwHa3+7x4IuDRawREa7reOKT8Hep5A7OA8r8BkW59EFyEbdigr
         6tVrLqL1mH4qCRuX7IsIRvEzaHr/z+ow7Yll61T30b3vByw59i94dAq6VmGs1GFT7pdE
         3Fr7o8Q32aMJuVa0SoWwuBeEnhH4kWYE4TTm5FsnSCVMTeFetiCti/wgQnfyANeK5uIm
         dnag==
X-Forwarded-Encrypted: i=1; AJvYcCVsTtSNUJ4sxfZkSrQoftdpSinhLMxBImVJK2IsSCCgFrCBuCbcf8xyNHdOX1n9n0MTc+Vup5l6Po07evbRLKPUUUbIxtqfcUv93MlN
X-Gm-Message-State: AOJu0YwllAd9OexoVI2AJeC9LHrwYQQGGXDZmNmCdIf/ycKkL5YzDNVn
	tmRWTZTSBV5mToiuzSppNcmD3uvO5oX6JgaLh/SfFZ3AeOHWvQBqFq75vtEF3Uk=
X-Google-Smtp-Source: AGHT+IFw4yvYw/i8q9qY3Z4fCLdCFqDAF12yaV9mKyL9wxg0B2527KSAol4D6gP2nOhvSnXfhixfFQ==
X-Received: by 2002:a17:902:f551:b0:1fb:fc96:757e with SMTP id d9443c01a7336-1ff047df750mr62572485ad.37.1722271567833;
        Mon, 29 Jul 2024 09:46:07 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:07 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Jul 2024 22:29:31 -0700
Subject: [PATCH v2 1/8] libperf: Move 'open_flags' from tools/perf to
 evsel::open_flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-overflow_check_libperf-v2-1-7d154dcf6bea@rivosinc.com>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
In-Reply-To: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=3858;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=EYj46EMmFuWQIBLme5IpvIZq5GbJ6nvJPdb/Sh/Sx+Q=;
 b=vLdlwLK8xuEDGs508wuLB7axsc0kxOK4nqPJyBnq14QfksSIFCuMQLC7FZKwlgaCswfBL1cHF
 L5JsaoW/jOSB90gGhDupKAl23sFBBAfqB6IwClC3TT0xddOQE+FNgn2
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Move evsel::open_flags to perf_evsel::open_flags, so we can move
the open_flags interface to libperf.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/include/internal/evsel.h |  2 ++
 tools/perf/util/evsel.c                 | 16 +++++++++-------
 tools/perf/util/evsel.h                 |  1 -
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 5cd220a61962..1d0d0406793a 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -75,6 +75,8 @@ struct perf_evsel {
 	/** Is the PMU for the event a core one? Effects the handling of own_cpus. */
 	bool			 is_pmu_core;
 	int			 idx;
+
+	unsigned long		 open_flags;
 };
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4f818ab6b662..65f0f83ada6d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1829,9 +1829,9 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
 		return -ENOMEM;
 
-	evsel->open_flags = PERF_FLAG_FD_CLOEXEC;
+	evsel->core.open_flags = PERF_FLAG_FD_CLOEXEC;
 	if (evsel->cgrp)
-		evsel->open_flags |= PERF_FLAG_PID_CGROUP;
+		evsel->core.open_flags |= PERF_FLAG_PID_CGROUP;
 
 	return 0;
 }
@@ -1853,7 +1853,7 @@ static void evsel__disable_missing_features(struct evsel *evsel)
 		evsel->core.attr.clockid = 0;
 	}
 	if (perf_missing_features.cloexec)
-		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
+		evsel->core.open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
 	if (perf_missing_features.mmap2)
 		evsel->core.attr.mmap2 = 0;
 	if (evsel->pmu && evsel->pmu->missing_features.exclude_guest)
@@ -1951,7 +1951,8 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 		perf_missing_features.clockid = true;
 		pr_debug2_peo("switching off use_clockid\n");
 		return true;
-	} else if (!perf_missing_features.cloexec && (evsel->open_flags & PERF_FLAG_FD_CLOEXEC)) {
+	} else if (!perf_missing_features.cloexec &&
+		   (evsel->core.open_flags & PERF_FLAG_FD_CLOEXEC)) {
 		perf_missing_features.cloexec = true;
 		pr_debug2_peo("switching off cloexec flag\n");
 		return true;
@@ -2055,11 +2056,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
+				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd,
+				evsel->core.open_flags);
 
 			fd = sys_perf_event_open(&evsel->core.attr, pid,
 						perf_cpu_map__cpu(cpus, idx).cpu,
-						group_fd, evsel->open_flags);
+						group_fd, evsel->core.open_flags);
 
 			FD(evsel, idx, thread) = fd;
 
@@ -2076,7 +2078,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			if (unlikely(test_attr__enabled)) {
 				test_attr__open(&evsel->core.attr, pid,
 						perf_cpu_map__cpu(cpus, idx),
-						fd, group_fd, evsel->open_flags);
+						fd, group_fd, evsel->core.open_flags);
 			}
 
 			/* Debug message used by test scripts */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 375a38e15cd9..2efda7ad8f96 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -165,7 +165,6 @@ struct evsel {
 		struct bperf_follower_bpf *follower_skel;
 		void *bpf_skel;
 	};
-	unsigned long		open_flags;
 	int			precise_ip_original;
 
 	/* for missing_features */

-- 
2.44.0


