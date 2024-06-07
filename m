Return-Path: <linux-kernel+bounces-206736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 750ED900D27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38A2B22E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A9154BE4;
	Fri,  7 Jun 2024 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/M/sFvv"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC3D2EE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793267; cv=none; b=aKwOFubKrBzk7V8PXexJJ70CHlP+GuM2ls/XWwxC7dThmf0jzsf3B/QL3WHn+Dc6wehVganfvwkPy5eYpFBrFq+ZWsyFCwG/XkYPHtx+o3KjrT21QiyoJhxLhqdaIRlZUtRu9CcyfoOIwOrEqu2b9e36Q+EgYupbRK7IEQ8s4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793267; c=relaxed/simple;
	bh=rll9k0tB7NHEIjBp2+3dI4iswXfAKzJ6/WWKFna/ZK4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=KK5pk4eFulWyPIQOaZEwoGrzM+TR2fN3bRShEuvPAnnSmH+WDxpgVFvPxokm0Nb3iSTqqqV61SzIqll6up6Z+jiQOsQr4CIQljDqfADGxuQT/KQ+XBtFA95AFyYkEamDq+gkJaxfizM9dk1p/fK05tSd1zwktVe413OxqIyyw8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/M/sFvv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df773f9471fso4751483276.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717793264; x=1718398064; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9fYtvobquZVKvp1QHiSBNzMAcMNlZnXn1wwJ7y/l2IU=;
        b=C/M/sFvvKcYH8aMSzHE2adwBFRrZDtQNzV+tVLi5Tv6lttm7LtV6nGtgzqywFh1k4q
         q8NHUtov3NS7UWH5sW0XdvdvVWfIgCDuCUgrUXnSsND50QwYG7hsVMndX9DqM8xuoELA
         dWD9aZliYT+TKoDhTvSDOooZ3it3YUawkr0s34j6EGJ+XFeBuRRoNYQYMzFb35R+1D3S
         nCdSrI0k/ghAcbaxBGd63AEF1DRYC0hM5UqszWVrdomGGSszb0HgTEUBo0vO3Yga+lcY
         GbnLiXjwhLR9yesbQEy5AQnc/kcyhyhxwwG8tJimmYZuGAC5I84hqii0FGrODQGI4wPa
         TN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793264; x=1718398064;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fYtvobquZVKvp1QHiSBNzMAcMNlZnXn1wwJ7y/l2IU=;
        b=pBk551YYOrmdWvjNYfYKnb5as3Ej5rjQPlUA6hJl4iF0ofnAdl/BPWPg8py5cqv84w
         7UZ9XxF93h1w2KRgvtN0HdDo9uu8t1inj0G/uPPXmZdRD+414wbudNK3zyoGT68FOwy+
         YJZStibKZU59KE2/Vuffl9jnnMJpRc4midWOk/qZyeHEx2d40ApkMWMxDR0U3N+IcDIx
         qO/hgnLaWy8ZMLshNClr3p1LrCx5kzfB1ovzFcws7X9zExjuYgtui26uhET8bjbUBlx3
         og2eWFRNCmdfiYSg0tDURm1jHS7NoaRohx8yIkZO4WpzGRDufVvQGzprGUZLveQjo/gl
         7tJA==
X-Forwarded-Encrypted: i=1; AJvYcCWa3VaffR6Gp195Is9oTmCAC+sEG5L1H8baxGA4/rFMNK3/TrCXWfWFUu9dDbH8T03v59UB3n07e8gZ+feS+mL//eMtJZDx3av+ONzx
X-Gm-Message-State: AOJu0Yxhs4zemw4vvc80IOmwTXPRLdv5Dh6yFDUzwbh6cqqOqgDA+677
	b+xsYMLoDIiPZjItJyNp2EqyWqNIOdsbqS0jqMPlbmLEEvj1NhvQrJ339crrWL6zo3WRd3yKQoo
	XzrhgWQ==
X-Google-Smtp-Source: AGHT+IHZSdHOzA3rR55KrquWkQlvr81kHdqwOwsqdbbLZkkcSIQXNLLe15qynRNB5SsDXtDh+pVt2HHTEgv+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5f56:330e:c132:da6b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1145:b0:df4:e7aa:590b with SMTP
 id 3f1490d57ef6-dfaf66c8998mr966135276.13.1717793264537; Fri, 07 Jun 2024
 13:47:44 -0700 (PDT)
Date: Fri,  7 Jun 2024 13:47:27 -0700
Message-Id: <20240607204727.849174-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v1] perf record: Ensure space for lost samples
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Milian Wolff <milian.wolff@kdab.com>
Content-Type: text/plain; charset="UTF-8"

Previous allocation didn't account for sample ID written after the
lost samples event. Switch from malloc/free to a stack allocation.

Reported-by: Milian Wolff <milian.wolff@kdab.com>
Closes: https://lore.kernel.org/linux-perf-users/23879991.0LEYPuXRzz@milian-workstation/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/event.h |  3 +++
 tools/perf/builtin-record.c         | 37 ++++++++++-------------------
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index ae64090184d3..8f3cefef9069 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -77,6 +77,9 @@ struct perf_record_lost_samples {
 	__u64			 lost;
 };
 
+#define MAX_ID_HDR_ENTRIES  6
+#define PERF_RECORD_MAX_LOST_SAMPLE_AND_ID_SIZE \
+	(sizeof(struct perf_record_lost_samples) + MAX_ID_HDR_ENTRIES * sizeof(__u64))
 /*
  * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID | PERF_FORMAT_LOST
  */
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 66a3de8ac661..1615a1723fb9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1926,7 +1926,10 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
 static void record__read_lost_samples(struct record *rec)
 {
 	struct perf_session *session = rec->session;
-	struct perf_record_lost_samples *lost = NULL;
+	union {
+		struct perf_record_lost_samples lost;
+		char lost_and_sample_id[PERF_RECORD_MAX_LOST_SAMPLE_AND_ID_SIZE];
+	} lost;
 	struct evsel *evsel;
 
 	/* there was an error during record__open */
@@ -1951,20 +1954,13 @@ static void record__read_lost_samples(struct record *rec)
 
 				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
 					pr_debug("read LOST count failed\n");
-					goto out;
+					return;
 				}
 
 				if (count.lost) {
-					if (!lost) {
-						lost = zalloc(sizeof(*lost) +
-							      session->machines.host.id_hdr_size);
-						if (!lost) {
-							pr_debug("Memory allocation failed\n");
-							return;
-						}
-						lost->header.type = PERF_RECORD_LOST_SAMPLES;
-					}
-					__record__save_lost_samples(rec, evsel, lost,
+					memset(&lost, 0, sizeof(lost));
+					lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
+					__record__save_lost_samples(rec, evsel, &lost.lost,
 								    x, y, count.lost, 0);
 				}
 			}
@@ -1972,21 +1968,12 @@ static void record__read_lost_samples(struct record *rec)
 
 		lost_count = perf_bpf_filter__lost_count(evsel);
 		if (lost_count) {
-			if (!lost) {
-				lost = zalloc(sizeof(*lost) +
-					      session->machines.host.id_hdr_size);
-				if (!lost) {
-					pr_debug("Memory allocation failed\n");
-					return;
-				}
-				lost->header.type = PERF_RECORD_LOST_SAMPLES;
-			}
-			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
+			memset(&lost, 0, sizeof(lost));
+			lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
+			__record__save_lost_samples(rec, evsel, &lost.lost, 0, 0, lost_count,
 						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
 		}
 	}
-out:
-	free(lost);
 }
 
 static volatile sig_atomic_t workload_exec_errno;
@@ -3198,7 +3185,7 @@ static int switch_output_setup(struct record *rec)
 	unsigned long val;
 
 	/*
-	 * If we're using --switch-output-events, then we imply its 
+	 * If we're using --switch-output-events, then we imply its
 	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
 	 *  thread to its parent.
 	 */
-- 
2.45.2.505.gda0bf45e8d-goog


