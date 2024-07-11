Return-Path: <linux-kernel+bounces-249647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674DB92EE32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BF91C21E76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0BF16F265;
	Thu, 11 Jul 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMkRCVVg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDFC16DC08
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720831; cv=none; b=BtQ0k9o54q+cjAlx2p37WKHeOLEdmH/0LoXAggo5V7bhjWUEU2ZwT+x0O60Grs3OemTgnUnFFFJDRPlRrQSO1OB/e26cL9mNzaS6P+6GhwNX3biIGR0W7+DL6Rf6Nm5tYlHTQkqX/ORlGxJrhLA4NiG94eWurcKvxA2F4OT6Chw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720831; c=relaxed/simple;
	bh=z5wXs6v0oTEwyKPVEdDTOwtt2S/GFG3uzWXLUE9bRVQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=flPHdZTiykNhy6Rdm8pK+9FMFAVx+Tqa762f0qjdoXQ71e1r9pOM1zJq8SZ3dVK6RE+a9x8UI+A1MTqRiftSnC0qJ/WdLRU7j+h2JhZBppGDMIqJIFPPq12XYnk8jp4f3FY2W6PxaeJbw8ugSnui6tVyR/T3+rBMgNlXp20+0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMkRCVVg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e037c3d20a6so2005016276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720829; x=1721325629; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTWyT8gKTKays8rE64DnYrzhErijM5o6wos0PD63SLQ=;
        b=uMkRCVVg4+8d8UHW2YpYBHCtJBFje+SEQ/PtYN4xKeintSCODVi8bzFQjGf+JyWLvq
         C9O91iCbxN0puvu6UiQrUZqlTHm8HISz1+HDFiejJj3uQyY1zHZ2Qq+B9T3xvR+jNoyi
         bL9HCCnMX59sGNYHBAvX5NzA19VgROlVZWwDg816cNtlLSGyREjdcGYvyT+8Iq5E18yE
         ORHKkdmBH/CWY445jQucXaZEXC7hlBToVCoifn7R1aONTYuNMw33DTo36DjXKg5+y+rr
         027GfqegzGBOU7dm0IUiXKAd30dTthN1ZqyiipL9py83iI/CZGTHL7JVFHzYqD2PKou1
         HONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720829; x=1721325629;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTWyT8gKTKays8rE64DnYrzhErijM5o6wos0PD63SLQ=;
        b=hXdOlFC9NlJK+BJbLFhXpdMxS+7lCrHsFUSv/EsY/qxUWqJeSZXofKJ4/fqyHCFoQm
         S4p3NKWVY208Guh57qz87EMjMsGF7jZ2lh7qZWOxylMesIKinVb9oJyHEOks4VY4IsKs
         wxDJl1tWVGOWiHiC9o09R8yjM6zt3MiQ5YvZWe/xaMC/LPO+Myzbo0JyNOwyLCSwMxfm
         grNnBd4pHo6nUSV3WmcEu9wWGBnK7htuckz9UmEGAkLkZtohju6hevLBePKHCBnFORZQ
         uQSNlRGJr84VslXRIzf5VT80pMhVCek9COwD5m1904gX5ByQHneyg51tVarAPsQFkiV0
         b+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+qXacLelo9CWs9R6gFyKs5igI6n2+anPi94ne9vAAiIO3sZ3Z5TW4BB3xmYsvxyUfJ9nkcRjnC4/g1VYD+UKA9T+fgFjHVf7BhDDY
X-Gm-Message-State: AOJu0Yy3YfiKFSOXML4aUMlpfyyNHll5f1xTPCNeD+WiszgZ5V7t2A4F
	MZvhY6JC+fJnSct+B18J3kADYwdtdD0i4ThvB4LGL8ySzOA/LaamFJkjtpHAfzd3pYSe/QdMs/V
	UK47hPg==
X-Google-Smtp-Source: AGHT+IHHvO9Dhy0kBlcS6+TF6u533W13vm3/nzwkXeSVQqKTUfz4Z3LP7tKCWbiDOEGivVzU7ZTCq/u5C+Mt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b0d:b0:e03:3cfa:1aa9 with SMTP
 id 3f1490d57ef6-e041b1134afmr21767276.8.1720720828932; Thu, 11 Jul 2024
 11:00:28 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:47 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 07/28] perf kmem: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Reduce the scope of the tool from global/static to just that of the
cmd_kmem function where the session is scoped. Use the perf_tool__init
to initialize default values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 859ff018eace..b3cbac40b8c7 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -986,15 +986,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return err;
 }
 
-static struct perf_tool perf_kmem = {
-	.sample		 = process_sample_event,
-	.comm		 = perf_event__process_comm,
-	.mmap		 = perf_event__process_mmap,
-	.mmap2		 = perf_event__process_mmap2,
-	.namespaces	 = perf_event__process_namespaces,
-	.ordered_events	 = true,
-};
-
 static double fragmentation(unsigned long n_req, unsigned long n_alloc)
 {
 	if (n_alloc == 0)
@@ -1971,6 +1962,7 @@ int cmd_kmem(int argc, const char **argv)
 		NULL
 	};
 	struct perf_session *session;
+	struct perf_tool perf_kmem;
 	static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
 	int ret = perf_config(kmem_config, NULL);
 
@@ -1998,6 +1990,13 @@ int cmd_kmem(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&perf_kmem, /*ordered_events=*/true);
+	perf_kmem.sample	= process_sample_event;
+	perf_kmem.comm		= perf_event__process_comm;
+	perf_kmem.mmap		= perf_event__process_mmap;
+	perf_kmem.mmap2		= perf_event__process_mmap2;
+	perf_kmem.namespaces	= perf_event__process_namespaces;
+
 	kmem_session = session = perf_session__new(&data, &perf_kmem);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.993.g49e7a77208-goog


