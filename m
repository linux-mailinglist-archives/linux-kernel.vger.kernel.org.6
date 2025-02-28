Return-Path: <linux-kernel+bounces-539557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC90A4A5D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393D7189C194
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753A1DE883;
	Fri, 28 Feb 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ZpqNINu"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D61DF277
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781441; cv=none; b=r55ToqN6ToLcPOlpJuIn1Zicb9fBkbKKKfP+TVauZt+xN6bebrYjUpSjJRmUEB08Llegz+8ndRTdiH5JO48PJAF7wl/rKqrgjIb4S/CbmIF3usH77qgfxAUj6+Ui2aQxNdjYaVjyCfXsyVNkR/+Bttajn650w2aVT8rYh0FMIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781441; c=relaxed/simple;
	bh=1QIgufyKX//dArN5ELC42cSlOnJMqn/N6xXRUEwesp8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=CNV9LuOTM6Hh76TjE5jSF+sTMDYljedEnPC7CLlu6e9BHQTUpx4UOjo81aBJn79N0vcSs8ontyvIwlVSiw4MMXpFhGVEbgoxQ7KY+6C8CoomY6C9tOUPHv72O4dunNiL45QNqYzcXHNclc0Wccu8lWynAk7q1zosQS9Z6XXLXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ZpqNINu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fd010df0f4so41552237b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781438; x=1741386238; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NsPMBkH69637TTeUcT12GL6mDYxITCSmP/v5bZ3zoSc=;
        b=3ZpqNINuMmRm+VsPbvi8OGKHitqQN41gkBY1nEg8eRsD1t7CRThVgfL5hXe36UVmB+
         T7X7oFEc63iFCzhrw31UOk+qTVyd5pGeOhcm/7juHGUikaUnw2+7DIRSp+gap5+rFYJL
         Pc80K6EKPt6jCMDHOtE5unJTScgHKAHJeEVduwMYos8GMTcCYCCK77dFqPYV0cqjrcdQ
         IueALOZdHH/B9kaC8PK8n5fTUbWC0VHQQ2BJ+kxkNqjDuH7a4SWvceN9jSGjmg2zJOcu
         J52Rcs/UdOYj3wLaJTi8Jq2K8nOoAkNUzn+OAMIJ0q/sIJ0mAueYk/Mglr+2gc87s308
         wgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781438; x=1741386238;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsPMBkH69637TTeUcT12GL6mDYxITCSmP/v5bZ3zoSc=;
        b=CzVASbjm92odGoXxKxYXMTFDEdmHpyzBeBPci0gUteMM+OdyBNgose8zUcuBRF9Si2
         K1QldxW5twFZ55FdUjNCeb2eCadeDAaSMAWtcDbY5mEzJ6EtLqEyKCS5uFkRPWuQ3nPF
         g5Rd6PGYUdfxtU5pwUS9jVRGgLw6FZYKl53MHLLVGb/XvDCzCyKCyWGxuQTMAd+jk+iC
         gL+TpwOUfwmSYhLduqEtGm0v+M7vNeTAk8G3X0lrhc+NxFvksLPOYJH2KmiKOmAUQgXq
         muJTI08NT5UH3DYTCRoalyeun3pVhPAfNfO9vkzrNiiEyFnq++dK10lUyRyjR8+qjgK0
         HTQg==
X-Forwarded-Encrypted: i=1; AJvYcCXD/BaK/8c1ik/LvO5PEa2AnELDGgAk1+U2f/hCz0/OTFOVxMcYfFGnvG9kXN8TfpxA0lxwSvkX45vPLso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsrm41vQlVNRLucZjfaQDYshQBfJh661o9D1RBuJdjsDqG2xpM
	+DkHkzTtdgPNMbGmpZtH+7OqkjgsLCIaX2E93SPnKHmmyf7lzuDjPZuahX2YUyKQcp1VFlOnxu/
	NLX+1Mg==
X-Google-Smtp-Source: AGHT+IGZdRCkerahb9c4wxk645+PM+BR2jUS+KgFNjUrlkGATtsekS5Ap18M/puYq5Y6YdfL36FIgTPIx/hT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:8e06:b0:6ef:7372:10f8 with SMTP
 id 00721157ae682-6fd4a0f729fmr6305367b3.5.1740781437790; Fri, 28 Feb 2025
 14:23:57 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:00 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 03/11] perf evsel: tp_format accessing improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure evsel__clone copies the tp_sys and tp_name variables.
In evsel__tp_format, if tp_sys isn't set, use the config value to find
the tp_format. This succeeds in python code where pyrf__tracepoint has
already found the format.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a0ef095db92..1974395492d7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -521,6 +521,16 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 	}
 	evsel->cgrp = cgroup__get(orig->cgrp);
 #ifdef HAVE_LIBTRACEEVENT
+	if (orig->tp_sys) {
+		evsel->tp_sys = strdup(orig->tp_sys);
+		if (evsel->tp_sys == NULL)
+			goto out_err;
+	}
+	if (orig->tp_name) {
+		evsel->tp_name = strdup(orig->tp_name);
+		if (evsel->tp_name == NULL)
+			goto out_err;
+	}
 	evsel->tp_format = orig->tp_format;
 #endif
 	evsel->handler = orig->handler;
@@ -644,7 +654,11 @@ struct tep_event *evsel__tp_format(struct evsel *evsel)
 	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 		return NULL;
 
-	tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
+	if (!evsel->tp_sys)
+		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
+	else
+		tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
+
 	if (IS_ERR(tp_format)) {
 		int err = -PTR_ERR(evsel->tp_format);
 
-- 
2.48.1.711.g2feabab25a-goog


