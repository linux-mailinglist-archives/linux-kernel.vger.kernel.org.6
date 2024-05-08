Return-Path: <linux-kernel+bounces-172668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABED8BF514
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77EE4B23C17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1217BA5;
	Wed,  8 May 2024 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EV57yJwD"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930A17756
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140399; cv=none; b=fpf0EJrARcvg3VTbr50uXs7Az5Z3ia2LSZX+9udaIjDv6IMq5TJs12pJ8hUam4G0BdwTrxuSwCLGoTmbpLitDte3tpm2T7imOWaK2dIKOV6CxdSoRCAlTYpvcostXRZx2nrkvheyxGgX+B9pVfQuvUvG9I2V9xyq5sE3HE9+QlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140399; c=relaxed/simple;
	bh=1gjiKx8CEp6GLpjJeA3XOWVnAQEoANQb0FbmONXrbR0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sJOzPQxBawHNJqWMRzPuxlZ4DINnx20dOSw9f/HRVjCcLGkmWjkJbHdNEfeBPBy4o+UJ6LlxwLzkdg0G3oTmKrT8iC6srRL9Tn5e0p8XU4cGQTOnHxvjthUsz88GfvjomFrvlVNPrPktgQO40vt88oF/r2uIFxiI1DNP8F7bRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EV57yJwD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bed763956so80589987b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715140398; x=1715745198; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evqEKyKRq93CW7bOGoBWyVHoXocBvIcKIjPummzTEM4=;
        b=EV57yJwDSoR3biBtmfXMvv3nRCD6OLGkeKIYBrsECK7VOqUarkS8pdRGyfBa4H36x8
         5+XABmOQh7dwRaISHOXyPIstAUcwh6xnScsObUsNGglUel+l3IJRMUN+bkO1ykHO7O20
         HzgzFi0IKefZ26F0gy2PAIpARoiSrD2eEJb5w8DvfplWYQNVr80c6IwBhO5fG4eQfZjs
         g3pnEIUoOPk3V6Mzji8XvM+QQmEwM183xSUBIrbi7vh13qLxQX0KBF1Juk5nyJAUMzQP
         2hsaRLyDrati/MvtiM6VxEhMEKwnKoze7Wsr+5poCHXPFw99L5xdsrNE6BByDLAMEWpV
         Kkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715140398; x=1715745198;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evqEKyKRq93CW7bOGoBWyVHoXocBvIcKIjPummzTEM4=;
        b=ixCX/imFjOJLbr9t7VVVL4WGhzg+QDcGi+bZyo3jhYIs93gFZl3eF359z5MbhQgTG3
         znxk32wOPkhyuvQsHSM2OoXiDtABTTWRNdgCwLorzsr/vWA8sT5CVRsrgrPT2bU1CRGn
         TTBMmN7r6tq97Gzd/ivvnHHd1P2WBdyUIKttxkMYsDeQplYgoQ1jucXdSTdvvLMnfGxR
         uvOUdtguMrM7H95W5d9lhKVNuyeJX5p0Bt1FZKUSu9rBGkuL+r80irTIjaRwse868GfY
         dRFrMdBG/HtvIhc3zb6J1wOyKo3Y6WMXCPmvvXZDZV6QuL/OlhlqvoPfsRQZ2sQPccdA
         m9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0YA6AFQvJ1hfCtj/rjAUGDMxFjwkQgIRHfICRlDdyY2ZYIf50Tj263noVFnnWjL9AQZwKTmLKnatLd7w+7E94Q6JTtin3OO3qVGqQ
X-Gm-Message-State: AOJu0YznMiuEcjE8+2XQShRW/sgW4ghsLCJokClPeWzkOJa8yxaQIMBW
	vVjX5Hl2seFoFBJ2gI2bBfxQSGnHbRWUfxtyXsAAIv92BGDp780Rz6vfRd26UuuUjh6jpQUjEKU
	s5s+xBA==
X-Google-Smtp-Source: AGHT+IFFi6TPEZBiQZat0J8wPmQsKgf7WRxfdVdZ6yCN7mIOFkHcTAwrw61sUraFs85lMk8PIkUKfpdUg5AT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:56f9:40dc:113f:ba3])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:de5:5225:c3a4 with SMTP
 id 3f1490d57ef6-debb9d3d713mr439844276.7.1715140397650; Tue, 07 May 2024
 20:53:17 -0700 (PDT)
Date: Tue,  7 May 2024 20:53:00 -0700
In-Reply-To: <20240508035301.1554434-1-irogers@google.com>
Message-Id: <20240508035301.1554434-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240508035301.1554434-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 3/4] perf report: Avoid segv in report__setup_sample_type
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In some cases evsel->name is lazily initialized in evsel__name. If not
initialized passing NULL to strstr leads to a segv.

Fixes: ccb17caecfbd ("perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE event")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0892b6e3e5e7..69618fb0110b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -429,7 +429,7 @@ static int report__setup_sample_type(struct report *rep)
 		 * compatibility, set the bit if it's an old perf data file.
 		 */
 		evlist__for_each_entry(session->evlist, evsel) {
-			if (strstr(evsel->name, "arm_spe") &&
+			if (strstr(evsel__name(evsel), "arm_spe") &&
 				!(sample_type & PERF_SAMPLE_DATA_SRC)) {
 				evsel->core.attr.sample_type |= PERF_SAMPLE_DATA_SRC;
 				sample_type |= PERF_SAMPLE_DATA_SRC;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


