Return-Path: <linux-kernel+bounces-360684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37A999E09
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5DE2892B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD65D20B1F2;
	Fri, 11 Oct 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZaSEn0YN"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C820ADF4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632183; cv=none; b=Z1kJOgfSLfP3+c8CSPyf6O3gxzay5NuYL9TENx3FjJeG6sbuDGOSUkSKrqogSYeggHmsXkMJks0DHYLlcHp+MJ6zEig/13bQplH6tlkyfmIxxTLN3t6JspLhDjzGkbA25Xhm/mNkX5xKRD7Wd0h3C65hsJxrNS08iXclnm5QSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632183; c=relaxed/simple;
	bh=j9xoZhKUCxCRzKJME1b4ctoFywjIrcKy9BRs5A8oUiA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fc46PASJuEwXlZjmVxy347dNAfbNSHM/HKmrFQoYzZupf0+9CRw+MsVSy4m/3R78eFx0ilP3KZuC/thnEyyo0a+qxsDNZQ95A+IH+JtTcfjN0MxzpiiGKs7eE8KdfN+4Ta05eNOSPcvwZhKPaV75gFW+bBlT/T02AzaB9awtEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZaSEn0YN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e31e5d1739so33092257b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632181; x=1729236981; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgB00BYIV9qluKgj4RC8eehGF10YxeeBjZZWHyrv1y0=;
        b=ZaSEn0YNjf8R2J/E8cqDERh+uEpFZoKt3bRWQ5+AX3hROyWWy9+i7pUCfYFLs8ERRo
         fG+ziIi6sLGMG02R0kFp7XOXXrvM9J7vPrsH+4lPvfwlcg9IAKHwpHocdJoIVbS5qLiN
         OBCzsacQchKEK+WXKt1pD/Ke8aq+xFUsJQKua45lqKW0wpiVsCDCZWJWuOyyhi2FSUS5
         JSsj1LTyTuz3NTmfhjUjK37xIsbUrhZofuMHJYuJuU6AOYvPFYAcckgjINxpZq2rStFf
         DeijZKy7qRQnc1uomJKVaDGxpNxH3ff1nwBYMOHnGbe99ClS3MNgl9vpCBp/YUAr5+/L
         5iHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632181; x=1729236981;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgB00BYIV9qluKgj4RC8eehGF10YxeeBjZZWHyrv1y0=;
        b=gQjGYvwBxJMLIiNvI0bZKI4fGKQFY/4OhDg3pMn+5kugfDkRx05w5LL4HtjJoWeZkl
         WuOxx4xaElfc2sb/9OYo2eKMNGXFVNJUbP+YFGXg7kE4PQIaRJ0ncS8OxnxczhjjM+R0
         3Ztpf8iXwRwG960856bAHoa7iWsDB9OOmY9ks+LyoELjEpscTFy/mIT/bdrX5saseZMo
         4vGivLJd5uJZmCVWKqQYQZ6yZoIMbYdpT1wYkNeV+9+l7vob0hMgEWj0m4rvD3diKp/a
         uwj1E7nfq2OZoDecUWSQHTX1AdSnldJIktukM84kXh0Oc7d2XOMP43mKEC0YzWlBZTj+
         a5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuERK3BUINHc8B+FC/C9CBZZWqI0S5h7dz4G348tBqNlVwfQuEJLp+ZF2EbyzGHQV8XM64SBu2YQuxlmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhhqmzdvspebsW7MDfKlvup2CKiYe2awX/MIOvzqB9p7A1jzLZ
	XFG6TAMzBQyEfaSycp7RipS8CRr6FYYILeHS0pyY+X31B6XtkQyoNgdhhAGrA/2D8XdrVs8PazF
	hZj1Hhw==
X-Google-Smtp-Source: AGHT+IFAgo37u8rfjVAYg4qiXtWEdAHj0LY5XoBITiq7BqupjjYH0ReOmowk3vBX1hWxCN/0yj8Fi53KsVtF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:4449:b0:6e2:2c72:3abb with SMTP
 id 00721157ae682-6e347c85db8mr432917b3.7.1728632180691; Fri, 11 Oct 2024
 00:36:20 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:54 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 3/8] perf test: Reduce scope of parallel variable
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The variable duplicates sequential but is only used for command line
argument processing. Reduce scope to make the behavior clearer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index df0466d3def6..6b8ef198d975 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -41,9 +41,6 @@
 static bool dont_fork;
 /* Don't fork the tests in parallel and wait for their completion. */
 static bool sequential = true;
-/* Do it in parallel, lacks infrastructure to avoid running tests that clash for resources,
- * So leave it as the developers choice to enable while working on the needed infra */
-static bool parallel;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -566,6 +563,12 @@ int cmd_test(int argc, const char **argv)
 	};
 	const char *skip = NULL;
 	const char *workload = NULL;
+	/*
+	 * Run tests in parallel, lacks infrastructure to avoid running tests
+	 * that clash for resources, So leave it as the developers choice to
+	 * enable while working on the needed infra.
+	 */
+	bool parallel = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
-- 
2.47.0.rc1.288.g06298d1525-goog


