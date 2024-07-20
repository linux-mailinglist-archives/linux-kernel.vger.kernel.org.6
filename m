Return-Path: <linux-kernel+bounces-257853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED7E937FC5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B13B21034
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E07026ADE;
	Sat, 20 Jul 2024 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2ApYbbV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D31C68E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461610; cv=none; b=XUYP4HZWdfVysiAebXz1mRmDkW8iWsfOjs1UCysvceluCoOXjUH9BKwDdpBFz3o39i00y74szOcG1QbAgF9jJ4bOAEXWjCOty9lA4Qf/8WmOlthQUCOspicwA4MqGfEV4EjMKRd4QRHPrqGOiL3yIGm/A47QODPoEr8AoHWwYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461610; c=relaxed/simple;
	bh=TCkraRgkZ/cWDF55w+lJe2JNLcX3iOyf3fjmZqlM1v8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=qhRUVLg/KYAiDD2hEbdwZAD0MoizQcYGRwetRUyIsqoW2O/HZ5WGugJb5vPMTPYAsPOpDV1Uz4uAzSnofNKAqJQLgzJRBlD5e1FG7foXfSpgSXsr1tQJQ4rT+azY9wXmAsJx9K3E49r2tXUDtLDulLmv43usZFGNh/U4SJu8mRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2ApYbbV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa7a8147c3so5836996276.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721461607; x=1722066407; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yp3G2O/AMKzgruzp+hIrvoG3w9Lyd6HB8ME50phSljQ=;
        b=C2ApYbbVT/yk02iOOy8itcbHYnQcN8P/xSBlhnFzfXXsfMhFkUj5R1cF3xgkGFMAhS
         wdVy0cfBlAIOzWOlGvhjrkjkhs20XjQ8FMDHQnxAJvMFISuBnN2TLF/rjUMycliRFPt9
         V3MrPVBEP7e6O61boLd2chZ/UAxBwnHBrhkBiu2KFtkQqZNAWFuS1mEw9rg4ZRQtS/mQ
         QZGXlu2XdEpmO2bleTNPdMB4pTV8tqkRL2gYybYHwkIc1QBTdDYb6vQ3ofX5IzgByb/a
         K2qk18Y6trzvqIJthuT1Ihxfo81qCKkDwGjTRE5Gyz41thty1aNR4ivVvRy4hkOOVEnF
         klYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721461607; x=1722066407;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yp3G2O/AMKzgruzp+hIrvoG3w9Lyd6HB8ME50phSljQ=;
        b=U+AhHq+kNqbKAoCZvRCakb5JljM+0bETyo1/Jk4ma07Dfbv7OlXFKhzgbe/eJinjP5
         +FIH8YAZ9ZVqOCDm8/6nfYcLRWqrX92lbdDIDM3LIN09vnI9T44MuuomkkAOdXgN0Ij0
         MWgTzyhuVtlOan6SJlxNerIwwxI8BYZxyvPFjbihyUdgnjeNuv8F+WnyELp6D1/HOmoU
         ZTmQnngTJKr4/WYvCecPkSYKndgaDCelI5pOqKB8jMXUr/PACT1OA1fkr48mr7FU3G9S
         Ip9VvIht/Ny3B4X3tn2ncf9Oi51u1s3fJOCQU29fVTFz5AzaOpgJvoGv6iOAJP+fEr11
         Lg+g==
X-Forwarded-Encrypted: i=1; AJvYcCXavSZ+WqCbnp9Fg+To7mVGcTO5ov1B4NxdqvEwsz7psDTFL3CKgcTKGS9rO9yQ+8K7FqT+mazUHM8sFleD9r0Db0dVSB6rj2isFumL
X-Gm-Message-State: AOJu0YwmFRIRwSEcrA4EbVu/d2fsNU598nR4KtJwt2P5VW8ZagxxHWOZ
	qEtmaaKjJ5et0qbdF5rcmXqeuycVm+e2YVZUSlqq7ka8VeIJc2qOmos7hQ4pQLi5BIU/B8Qq1/d
	rwLDg6Q==
X-Google-Smtp-Source: AGHT+IECSiL47Avn+rFt/Lw8pbMrOMAl/W6rko3QnvPj+nApn4mgO2aALZpE+QoJUBwZ98UOHRhfGoOoLw1o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5df:6f0f:a93c:ac73])
 (user=irogers job=sendgmr) by 2002:a25:902:0:b0:e05:a1b5:adc0 with SMTP id
 3f1490d57ef6-e08704570c3mr7212276.10.1721461606800; Sat, 20 Jul 2024 00:46:46
 -0700 (PDT)
Date: Sat, 20 Jul 2024 00:45:51 -0700
Message-Id: <20240720074552.1915993-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 1/2] libperf threadmap: Add ability to find index from pid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

It is useful to be able to determine the index of thread in a thread
map as the index is used in other situations like finding the perf
count values. Unlike with perf_cpu_map__idx a binary search can't be
performed as the array isn't ordered. Also -1 in the array matches any
pid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/threadmap.h | 1 +
 tools/lib/perf/threadmap.c                  | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/lib/perf/include/internal/threadmap.h b/tools/lib/perf/include/internal/threadmap.h
index df748baf9eda..92889d81b6b1 100644
--- a/tools/lib/perf/include/internal/threadmap.h
+++ b/tools/lib/perf/include/internal/threadmap.h
@@ -19,5 +19,6 @@ struct perf_thread_map {
 };
 
 struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr);
+int perf_thread_map__idx(const struct perf_thread_map *threads, pid_t pid);
 
 #endif /* __LIBPERF_INTERNAL_THREADMAP_H */
diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index 07968f3ea093..728683199a85 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -99,3 +99,12 @@ pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx)
 {
 	return map->map[idx].pid;
 }
+
+int perf_thread_map__idx(const struct perf_thread_map *threads, pid_t pid)
+{
+	for (int i = 0; i < threads->nr; i++) {
+		if (pid == threads->map[i].pid || threads->map[i].pid == -1)
+			return i;
+	}
+	return -1;
+}
-- 
2.45.2.1089.g2a221341d9-goog


