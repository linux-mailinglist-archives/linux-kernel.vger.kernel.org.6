Return-Path: <linux-kernel+bounces-314230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C47596B048
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC0B1F25D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5143184A2B;
	Wed,  4 Sep 2024 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZceUgQZH"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD6839E3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426374; cv=none; b=WKf5D2dU4npMPXj45/GoWXQoEfLgFXJMKnXFlz4Y3gTwDGt6q/EldmWOIaYYhVh8uvaQ5sAUL/uyZjmHpvTDlVd8Kkg0VNn1GVu9W+TNS7elXSU0ru0GlVwOiucgjX/l2rgKsM5tgmoJl87MbRNMRInHRJkFCYPiVzlkTGVK3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426374; c=relaxed/simple;
	bh=e7twF7D4RZxswFbYZbFUFk/hv4Xp6qmoMYXmywlWvMQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JbpLZbr00+HL1y040rd1G5oHSxzYPlOSaKyKMX3e5TmrAmCizwICgv70vKccA0PzXWbdqhi64LaKikFzxIw+/CwqNZsdcZRaWiRcPcQsVEMeCXmsisO0ItKt7X3ZFJ5efAdrNUYuS7A2X6IURo5aDuDdnpd8MjNAg38XqiPmu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZceUgQZH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a74f824f9so9987694276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725426372; x=1726031172; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JYnw2dXbPbmg3NZBXlioPl/0JNNRzqtalz3T5B9FgQ=;
        b=ZceUgQZH2jf7AGhKdIzR+Q+Z61c2JGiOvPQjKwA+tmA+wy5dgm+q45ZpxeNsL22Cow
         8wJKFolDTjHgDfh61USh44RknXT36oKuyJkRhQPo1XOT7jNaIqKmyhZp9Gd/+zlW6N3+
         tnEcRj2tQz1R0/tUNqWrcuVtVBHOO/xuPd7mZr4sMr9twYCEjExBSkGIzuOJECxI/ccs
         xhCFD4oM8tYcWz4cmFVpbIjf+LRtT5UIDkwMteYKqNPuNHf8iPEU0VLOjINJ5/hXzpDx
         jZ7HIctqD7QEJ4C0Klhf9/rkt+pRgtOI9ip7d0uytWfelso+zaZ7wJdoGyX4qoczaSd+
         qqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426372; x=1726031172;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JYnw2dXbPbmg3NZBXlioPl/0JNNRzqtalz3T5B9FgQ=;
        b=mbvULvKsvOUUEZ3CynVXiE61gYpiIjG+j5artowoyCqQ1d0/9VpYhHDnwbL86yphEp
         DTx73Nl+faGwWnxt8v/CS4oGthIIT2dsZ18tKDlByNQkBs5luGK6lam1el8AlJtaimHM
         iHW6TQgQkAMCEA7RXLvpmxZy1LqEqBo3nPJkFBRhQ158IrzLTE0GnxxTxNOC5uNL5F6r
         YFIDoM4P1akKnjQMo5T98zPDRnygFHkU3Wp7QnJOwrQPPl49RYFBcOPCVVPKZzwmOG8x
         x8GNFKdCgvdJAC+fachML5RPqzgs4MxX9qbX4Zv1IAoGMCzN1K5Dv8qA1fTyrgQXGlIX
         qRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLi0cF3ZUp9dTaHuOLscJzdw2a9HUt9LNWbf7qqsMYfU8s6C9Zr3HwjOpbUNIf95LGGBus836gkO41Z2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAilThrAdbKTkNZND9dxRBoI8C2f7/qhF3vk16EXXoCHCM5nq
	tDzThgwOwomjj5JEf1uXfiewwiI7ORqxH4Bz28MXUWsYoGw5NXAODBx2Ep8jxR+0/X0WNY3sIQn
	3+ELx0A==
X-Google-Smtp-Source: AGHT+IEMgGK3kKUPug6YrK1FymJVV4ObYq+yK+ANVEHj+WY9mLBrHgfy5pgCRUdgiN9TS5s545K0o+YICLeT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c48b:5e3:a63c:2d09])
 (user=irogers job=sendgmr) by 2002:a25:f302:0:b0:e02:c06f:1db8 with SMTP id
 3f1490d57ef6-e1a79fd4228mr27889276.4.1725426372213; Tue, 03 Sep 2024 22:06:12
 -0700 (PDT)
Date: Tue,  3 Sep 2024 22:06:01 -0700
In-Reply-To: <20240904050606.752788-1-irogers@google.com>
Message-Id: <20240904050606.752788-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904050606.752788-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v2 1/6] perf pmus: Fix name comparisons on 32-bit systems
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hex PMU suffix maybe 64-bit but the comparisons were "unsigned
long" or 32-bit on 32-bit systems. This was causing the "PMU name
comparison" test to fail in a 32-bit build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3fcabfd8fca1..769b920d9250 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -69,7 +69,7 @@ size_t pmu_name_len_no_suffix(const char *str)
 
 int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
 {
-	unsigned long lhs_num = 0, rhs_num = 0;
+	unsigned long long lhs_num = 0, rhs_num = 0;
 	size_t lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name);
 	size_t rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name);
 	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
@@ -79,9 +79,9 @@ int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
 		return ret;
 
 	if (lhs_pmu_name_len + 1 < strlen(lhs_pmu_name))
-		lhs_num = strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
+		lhs_num = strtoull(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
 	if (rhs_pmu_name_len + 1 < strlen(rhs_pmu_name))
-		rhs_num = strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
+		rhs_num = strtoull(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
 
 	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
 }
-- 
2.46.0.469.g59c65b2a67-goog


