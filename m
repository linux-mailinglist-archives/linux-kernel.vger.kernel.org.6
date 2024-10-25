Return-Path: <linux-kernel+bounces-382485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CB19B0EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F022865CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B0C216E1C;
	Fri, 25 Oct 2024 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpjDkPiE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA404216DF7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884084; cv=none; b=dMcqmMxqrqlxfuyeIhLyL+yX3JmYD4SSmj7E7zfM4viZFqgmhJCcjV00PLEYlO21jGOLFr5oPbxwjo0Z44sPTtE8ZS2HjSkdawGNVcGUIAMeNoielsXK5rydPXKiTQn0XO8P+nrkD6dDtkktU1oNP9J7KRhxNiqgAgrWvRKKpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884084; c=relaxed/simple;
	bh=bl0TwbExu4G349NNkk4dquZriD14f6vKBPjGiiViYyk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=L/D4OTL91l6J76qVVZb7O+9j9qxtBLLas0wtN6e+jQa1cHbqIzrL2ETok5KDDQJ9cvhTfueb8v43TdGBt+rnR+G/i+Ohmx+kKJotNw2oaz+XYR+rTjUCPXHbagdFP0CpPYMsgN4d6Wyz9l7zr90wY9cHeyw/gsZOTF/KMYbXtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpjDkPiE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38fabff35so50217537b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884081; x=1730488881; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yVnPqZ8RpP/8r+vCUjKwDzk1QDMtk4+iGqU5/U/LQI=;
        b=bpjDkPiEVbqldAK7qFtuGUmE/yqWjEGWL06+Z6X94otan2KK31U/gjgQ1987Mo2bHX
         MQ/WWUKm1MPk5BAWyBo7T4Py5lbcbKnF7FSHiSl+dyidozDaWKKjR7rXvPDjqR66qj73
         3ORiXnSrTQ+OLAuy6IFF2ob5TNZWi34wjqcAwKDkDhHEX7lhM3Rc1Mxypw0peR+jZZRy
         6o73/inlcaoIwSIl986YbE/qqLVFHagYhE6z0shTUH9xap9e1Tw5g9WjmEPKpsoNRzwW
         rZjJL+gvQRvb+oOBoIqLvyKDeA8cwYFnm4pmcXTqdDuO/q4dilSxW4rAVnUNw8s3gCUx
         OjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884081; x=1730488881;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yVnPqZ8RpP/8r+vCUjKwDzk1QDMtk4+iGqU5/U/LQI=;
        b=nr5wEAhLdVnnArhuNTK1oIqVLukNz0S4qIjkcKcDkYGpcFg9AmjaP7NbXheI/V6Uc4
         2d3ltbMbyQGZB8Vg/bsOj6ocu9C2HCUeFem66+LrN65UgMQxvlNGYL/wXKuTeYlnrYAK
         PqNfmWwLTxBxwljozctVOGWwWWT+6wbA3IdKn6ghgE7ChyT9GznGmjm0stpF6Y/girCb
         XLZBRw6vLrZywOgEIsRLujxqfTrN8DMOFOwgVZ3dK2hkRZaBWLdb3g62I5XS0CM8OcVa
         Xr1Z7IkKBPxl/NxXncvs9fdb06U+f2C490Sp9EYfJG9Duj1ADD6A224CO9rih7Glpy3z
         GrTg==
X-Forwarded-Encrypted: i=1; AJvYcCUCSRd0qAwQlt2JllozMQp+Xu1D7tUQDK2nnw/TC1mAwMKuW/07Zm5RbMPpWmEAjRt27ovC7Yx88BlnXus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOB6hk6olavW0E+Y0BiaLWnXA9nJL76lpB49bvm6fvTKD7Xks
	KQ/aUiXsnW95KmMFlNX076mTD5cpty2QcxC36bdbO67Dx5FDCZ0NARkwBefVYoNtfZtaYbfoP7u
	iHuHYMw==
X-Google-Smtp-Source: AGHT+IGD95Dz7s4SY58TIPO1jaSqaYOrqZkpzNst4Ej+pMqlACgZPWYG4A3kUs+EkUUpEclRsAV7/bDATl4y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a81:be05:0:b0:6d4:30f0:3a74 with SMTP id
 00721157ae682-6e9d8b5ed4emr165137b3.6.1729884080901; Fri, 25 Oct 2024
 12:21:20 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:02 -0700
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Message-Id: <20241025192109.132482-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025192109.132482-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 03/10] perf test: Reduce scope of parallel variable
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

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 57d2e9e03fbc..0e8f877f4b1f 100644
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
 
@@ -578,6 +575,12 @@ int cmd_test(int argc, const char **argv)
 	const char *skip = NULL;
 	const char *workload = NULL;
 	bool list_workloads = false;
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
2.47.0.163.g1226f6d8fa-goog


