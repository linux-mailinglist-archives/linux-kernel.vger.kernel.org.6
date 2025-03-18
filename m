Return-Path: <linux-kernel+bounces-565443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F360AA66825
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B313BA200
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FFE1D14FF;
	Tue, 18 Mar 2025 04:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eV5dO8Sv"
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9461C8615
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271300; cv=none; b=T2Y74d8XrXI9WlbAeGeX20RflNhrLmZRaQFuIpVApAqqduKB12weLw2otY9E64nHu1iNyhf0I1/ReW+LLY67Il6iZtrL0/qSi2nANpPoQ63qU/rg9NLgOiJZyepOHPPkIlXOU24tJFGcLyFzVBpyWyNu1QE8XsSOtuzFeq0uVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271300; c=relaxed/simple;
	bh=nM7VLv/vcPJb8IP1hkBb7xTP6rJT9gjNNb4KuBio9Y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=C7Z1aSO2D2zN5cSBsu+i7Ynxt1KjMyfedDgDoONw9rxR/jhg84KXp6bARzzXifsw5ikHIRYALWV0SQw1wpYl7mDDIs5fGuuGkbBlkrrVvBb1fknBq/UcUWB1+MnKlqzPV1iDtwKCLOBmumQcJlZbtzwV+kU6o/Jz+sidWA9MZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eV5dO8Sv; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-601e0f09262so1032792eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742271298; x=1742876098; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IcTDVc7sWc+BX5SOaqTWz06HZw+0rggI949f/hqkkSw=;
        b=eV5dO8Svo2y5cx6scAbegntfkkIeovgL7zY+a8uboV0Ftt5ma7eC0YFUS8R/6EsS9N
         LdTj8VRvqIkz0VLFNwe4F8+7eCFeovD3enCkGwLkYHT4ZI6q4gDxcZmJY/Otz+91WqMh
         O/wtBSoXAhqFbnhCEathU/RfRNk6OWFIBIYMAZ9rSnVC0DGX8XPndu/oCZdSYWfbRdmf
         DoO442o5m0IaL0I81MM+QbqV3m25HBrXq4o3+JD+57ZMQyddj3h3OoeGuoV8GBYAOPEO
         hjJ7q0DxobxGPWSgU4kIwYwQzUFR2ZyhtOnMMTkaBnoxTyt4/ZC8B7/asIQNH2gS1Xuu
         Vqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742271298; x=1742876098;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcTDVc7sWc+BX5SOaqTWz06HZw+0rggI949f/hqkkSw=;
        b=qnsvIsZVjcAV5Do+N9OWOVh4NvjXvGP3llVhMmgBgBvKzpWMDYkPk434NWLGL8UYA7
         ildCKGbqo6QMeEHjhYgB3lm8nor6sRGJ1IxIm6lj8iUyoBN4uiPZje9WzJTm2usN4YIH
         7Ek0JLgG1i7QIdT81Woe3OHDIVRHsLF7xB2NV22KlIVzTwmYt4y1jOHPNwFl0vsWrDJI
         moeEdEH3Pq1eEfzdHh49hn8vd+kTeLnDIqvdei/+GYlwdO5/aG7Ym67nzKh0f1nEWN1z
         dqpgucZIrGLSD96ZCX42IO8j1cqhfI8o121OZ3iXxsNUunJ+8lnbs/2uTYZNB7zU7Tlu
         4hlg==
X-Forwarded-Encrypted: i=1; AJvYcCUH5UQlpUJL8tA+ajKRldifpbNgo3kP2Pi2alXNa3ULSoo2qcO25hc79LDOkVQKKQubayGrFJVLuDISSIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+eHTWzhlVTtv7vNcCMjNCVBKJfSF2no6GodovfWy+DwaM+a6
	bwCVOa9dcIlvtp4jzlgETdRyll6BjXp1x52c3Z4fqsUEI0fy7nPNf6KYaKYbbjfSzVE6aXZsqaF
	fz4+xgw==
X-Google-Smtp-Source: AGHT+IHbiPc7HGDa8UDDNXiyyyNYm3dPD9ip4rcffjkWbCIt+vvE/ogOPNPgJ48eQYU33l1n9NXH5ew2ke34
X-Received: from oabhq15.prod.google.com ([2002:a05:6870:9b0f:b0:2c2:67a4:62b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:d614:b0:2c2:d2b8:e1ab
 with SMTP id 586e51a60fabf-2c690feb31dmr7568764fac.18.1742271298202; Mon, 17
 Mar 2025 21:14:58 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:14:42 -0700
In-Reply-To: <20250318041442.321230-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318041442.321230-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318041442.321230-6-irogers@google.com>
Subject: [PATCH v1 5/5] perf parse-events: Add debug dump of evlist if reordered
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add debug verbose output to show how evsels were reordered by
parse_events__sort_events_and_fix_groups. For example:
```
$ perf record -v -e '{instructions,cycles}' true
Using CPUID GenuineIntel-6-B7-1
WARNING: events were regrouped to match PMUs
evlist after sorting/fixing: '{cpu_atom/instructions/,cpu_atom/cycles/},{cpu_core/instructions/,cpu_core/cycles/}'
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..cb76796bc5c7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -28,6 +28,7 @@
 #include "util/evsel_config.h"
 #include "util/event.h"
 #include "util/bpf-filter.h"
+#include "util/stat.h"
 #include "util/util.h"
 #include "tracepoint.h"
 
@@ -2196,14 +2197,23 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	if (ret2 < 0)
 		return ret;
 
-	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus)
-		pr_warning("WARNING: events were regrouped to match PMUs\n");
-
 	/*
 	 * Add list to the evlist even with errors to allow callers to clean up.
 	 */
 	evlist__splice_list_tail(evlist, &parse_state.list);
 
+	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus) {
+		pr_warning("WARNING: events were regrouped to match PMUs\n");
+
+		if (verbose > 0) {
+			struct strbuf sb = STRBUF_INIT;
+
+			evlist__uniquify_name(evlist);
+			evlist__format_evsels(evlist, &sb);
+			pr_debug("evlist after sorting/fixing: '%s'\n", sb.buf);
+			strbuf_release(&sb);
+		}
+	}
 	if (!ret) {
 		struct evsel *last;
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


