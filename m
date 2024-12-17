Return-Path: <linux-kernel+bounces-449139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC3F9F4A61
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DF416DB35
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CC01F03E9;
	Tue, 17 Dec 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6QTUKrY"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9F1F2395
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436593; cv=none; b=t4Ebxj0cuAdI9utWtjWXFApEgKU3hTZBpigbYZhITajyfWwLRn7CTQHuZrPg+6wDERMW6Yu4DKa+sy2f2f/2yoA58r8+WOQ8IjpPDTDqYi3yBzdzbI2GQ7swKAFT1XBstBv+/Ckzsz7S8ZJo5sUakxkBfxcytAWtVQIqcwrAa6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436593; c=relaxed/simple;
	bh=tpnlelcMbJ7A8lxnHi41TMdRMlFf/pMqWGQuvroX664=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVvwtbuG+LJ2mW3uhWvAfNZ9BTonea5EENOsuLYu9wJJdVjEqbwfczYb6t3IYciZMemMYj1Rc44EyVEvZKVRDKpA2sVgazGs4Qrn3zaXSTmyHu/ns2LYPQytcSWQUHoRPOeZwjxzjtsmrx1y5mYHm7/xAFRwEkogQm1wef52af8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6QTUKrY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862f32a33eso2525050f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436589; x=1735041389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Swt8An6cH0UytiEm5BcU77Mv2Ddjr7IJCM9GFGK4Ig=;
        b=a6QTUKrYjFhtafekqJdaynKjbNhAAMY7O2v41wmwEQydeLW4sXdiVSBGWCMUBtHuy/
         pUaBE/NaN14J46TANmNMFzB/lJhG3vpWQbNCZZESmmPhSYdEKWXWzKPZU9E2tVQa8di5
         sla3CkmbrPdK+TDRlKbgVD8sFPgxZ7ObBY7OHwuKQ+5gYMO1DHNjRhZnYtSzZS2Au8rY
         0lCDgxnuafM/RnbSIRS7VCXW6la4MuhoRhU7ncrzATeQuur/ZfEX1mfH9fmEWk2FdJgI
         +i7hkkIPWLbeoTKV7Y3iEPcVzsrjh1OX+ZxgVf/O51K3fITcPRrtImrqGyWaBPy4aRoO
         kRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436589; x=1735041389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Swt8An6cH0UytiEm5BcU77Mv2Ddjr7IJCM9GFGK4Ig=;
        b=AXALssPZnDoLhaAuUG9mc/Sqcr5o/EQUMYB4uKQbqephFFL5IdNyhhNxYUcNICfsXx
         4wXRLKltx3xDW9jstEIJ5EwHQQtglPJeKvnun14SKrCTCxd4A+U8xKe+UD9rX9W6Zvf2
         f06ByqFwJCV8Axez/44suO6i837yEXRQzvU0yIUZEjwpAcNecvDvrECSfcBbVkqaszRz
         HrmpS8kaWXYb2GLO9UIZ7brcT5l2Dh0C1femL4bt4wBu5fBZmyNUqVMtQbRNRanmOwCg
         1Oswu+CCxeD111isNN5D79upj1/2anPZ6saA1uswlUXq49LcMa7skP/qVMXzVwtn2g1z
         FDuA==
X-Forwarded-Encrypted: i=1; AJvYcCVxhdDratftO/dX0dzce3pt5Lf+1R+jiMwnZ2+4JBGHJzJlkXtmSM27ZK7cH8L++bCQwJKJNp/CsNPmI34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwqY6j9IU1vl2YThPmCFFFKJXFEtzDvMqLuztRhtSxDv97gzS
	vLmirZ60tbBwPbalBisKEb/FMq+ICa+R8YErgyf1gvFP8mAqPO+YEVMBxb2+v/k=
X-Gm-Gg: ASbGnculk1pTfrkPt28ZKNL66sldHwRe+KaniI/26GAAD3uYYrwt050Tsj2SZ13WCYG
	N+kPJowcJ07ZlLj01EzF3QrmmapbRz/c/2aNHZ6/5dxhNgC40Gf7txLeLHNVQMSoxhda3feketa
	0uNTBRaUds+kakEsTsTCdhh0gCDqImgzqK5I9aqBg0zG03neMYD3VqpHgnzmTvBNioDBtj5EL2q
	kxP6rcdLf4TetWQe483jP63C5bzitpYDgWkpLv5YLg3pskA06yvKd2h
X-Google-Smtp-Source: AGHT+IHYPBPQkQDRXyVGehPAmC7A1dmxHnikbhEhvzazvTv4q/sZtDwu0z2Pco+deD3aSmH2xXPBEw==
X-Received: by 2002:a05:6000:1f82:b0:385:ed16:cac with SMTP id ffacd0b85a97d-3889ad33ff4mr10801795f8f.56.1734436589050;
        Tue, 17 Dec 2024 03:56:29 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:28 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/5] perf tool: arm-spe: Pull out functions for aux buffer and tracking setup
Date: Tue, 17 Dec 2024 11:56:05 +0000
Message-Id: <20241217115610.371755-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217115610.371755-1-james.clark@linaro.org>
References: <20241217115610.371755-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These won't be used in the next commit in discard mode, so put them in
their own functions. No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 83 +++++++++++++++++-----------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 22b19dcc6beb..1b543855f206 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -274,33 +274,9 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 		evsel__set_sample_bit(evsel, PHYS_ADDR);
 }
 
-static int arm_spe_recording_options(struct auxtrace_record *itr,
-				     struct evlist *evlist,
-				     struct record_opts *opts)
+static int arm_spe_setup_aux_buffer(struct record_opts *opts)
 {
-	struct arm_spe_recording *sper =
-			container_of(itr, struct arm_spe_recording, itr);
-	struct evsel *evsel, *tmp;
-	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool privileged = perf_event_paranoid_check(-1);
-	struct evsel *tracking_evsel;
-	int err;
-
-	sper->evlist = evlist;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__is_aux_event(evsel)) {
-			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
-				pr_err("Found unexpected auxtrace event: %s\n",
-				       evsel->pmu->name);
-				return -EINVAL;
-			}
-			opts->full_auxtrace = true;
-		}
-	}
-
-	if (!opts->full_auxtrace)
-		return 0;
 
 	/*
 	 * we are in snapshot mode.
@@ -330,6 +306,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			pr_err("Failed to calculate default snapshot size and/or AUX area tracing mmap pages\n");
 			return -EINVAL;
 		}
+
+		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
+			  opts->auxtrace_snapshot_size);
 	}
 
 	/* We are in full trace mode but '-m,xyz' wasn't specified */
@@ -355,14 +334,15 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
-	if (opts->auxtrace_snapshot_mode)
-		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
-			  opts->auxtrace_snapshot_size);
+	return 0;
+}
 
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel__is_aux_event(evsel))
-			arm_spe_setup_evsel(evsel, cpus);
-	}
+static int arm_spe_setup_tracking_event(struct evlist *evlist,
+					struct record_opts *opts)
+{
+	int err;
+	struct evsel *tracking_evsel;
+	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");
@@ -388,6 +368,45 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int arm_spe_recording_options(struct auxtrace_record *itr,
+				     struct evlist *evlist,
+				     struct record_opts *opts)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct evsel *evsel, *tmp;
+	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
+
+	int err;
+
+	sper->evlist = evlist;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_aux_event(evsel)) {
+			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
+				pr_err("Found unexpected auxtrace event: %s\n",
+				       evsel->pmu->name);
+				return -EINVAL;
+			}
+			opts->full_auxtrace = true;
+		}
+	}
+
+	if (!opts->full_auxtrace)
+		return 0;
+
+	evlist__for_each_entry_safe(evlist, tmp, evsel) {
+		if (evsel__is_aux_event(evsel))
+			arm_spe_setup_evsel(evsel, cpus);
+	}
+
+	err = arm_spe_setup_aux_buffer(opts);
+	if (err)
+		return err;
+
+	return arm_spe_setup_tracking_event(evlist, opts);
+}
+
 static int arm_spe_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
 					 struct record_opts *opts,
 					 const char *str)
-- 
2.34.1


