Return-Path: <linux-kernel+bounces-255772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11169344E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E815283C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220A2757EB;
	Wed, 17 Jul 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lz9XADGm"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3D673459
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256467; cv=none; b=WH4ytQN5rSDcM0peCCPieRKV6229WcSHgTgywaYapx4RfFgsPLN/tz8U4i/ZxBnFCop6+9ldSK9fVgRU21LO6rRApRDV20H347kxzYcuctSDDJLvieAQ3PWc4dBQUP1Dif7g4XF8Ub5cBVi/rj6VU7guKJlCiDcUMyQFYDlzFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256467; c=relaxed/simple;
	bh=xO1LeDUwAlVEwZnVaFmHHPJ2GZce6TEJ/S7/OdCC7Zg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TuDBAbqj7T29zZjwuEMJU/JNfiIw3M+PX7a6hR1mVzWsB74LIrZWV6uz7pBn0Lv6nkEeYE0BB+1cBk76Px3dLlsnZRU8KPPDAkumcLcCh9xIAIknvuH6T7WXuCmHLXujfTMIK0zJ3nkpu/Z4yaqLD64ryVNnEsVjw5EArKn+zkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lz9XADGm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05ec8921fdso445307276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721256465; x=1721861265; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpNlJN2SGII3MYeevUlf4p1OQiPVTTvbXe1jkW5mOAw=;
        b=Lz9XADGmqG5ApnzFw3PLMkAyHTwZV61OOTcQnV2szMHn7fxqQ+vm8JIlZE/f30PPyx
         FNpAQS8AwF0V1dX64OkayFWNoUznP98FBdT2btdYrhB0Sc3tPnCc9UZ1G5nSzTZUUBjF
         soBvwqTUiH4e+Zv3CYRre8mtRObHtG+s121IsBmhXNWyVONDV7bG0Fl3lVMmzzqaPhGU
         dVOPwldynZ2YFEfQH1jOimEgvVvzSlvPGHAdGpkqqPcV69liiuT1GL+4AngVJBzJHnv9
         KI0FdQ/v46TksSSZIqYsyCZxLWdoUw7ZV5yt8jNXaTrghaIc7zBiwjp2lEOrXo2uOe64
         O/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256465; x=1721861265;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpNlJN2SGII3MYeevUlf4p1OQiPVTTvbXe1jkW5mOAw=;
        b=YLrY8/V538UKPSN/zHjGBbxwqP/eZUkZeFgjYasEsKx0OIpaxir765acqgcSFopUgD
         b3VQfgCjX/WAu03bp0dnO52gsPff6PcftVsj5qiTUlcOJLb7hqxFDxlNIAFNGESK5gtC
         k6AuIEKMcyZmO0YTRd43PX//UQhy4wvIsDYp9GeckuD/LBNNqiWXxY6/ochGdCwTBvf2
         72kIONjmHyv8zrZucBj1yYMXcDWMpOtELF7qlt0wk16kaFip9JsDRVQg1lx7rh0BhcgG
         zUcpH3Cclpi/hlOcBNHXC+Sz+PiYMeyDx3HLbmcGfM8LGhwCZFYcEuXTBzoqq2luXSaa
         2OVA==
X-Forwarded-Encrypted: i=1; AJvYcCVanhIlwL3cYs+TpsGt9QPAaA2hd9vM16QKSgo73Lb85BaHZOLJs+9NIIBczelegClXsbqY1GVyjWdl0XbA4EfDEpIWtAjh+OZFuWhd
X-Gm-Message-State: AOJu0Yyr764dKIL1ZOySuAKcQlVsmDMOisc5uJbD3bO7d4XouunwRwF4
	vBThYh4ugiNAcOVv9hqGk2ZHfIbxTrSp/3qEYuYZQqDsQgeo7LVNvDiB8CWrQGrvU6MNqKKFhVq
	40Mr3NA==
X-Google-Smtp-Source: AGHT+IHD579pgm3HArxrQGR94j4J3NgPiAcdglBtctueU/H6FmZ0a/dayddNY5G65oQ1POwqO65dBGQXMvHE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:1144:b0:e05:fd7c:9cfb with SMTP
 id 3f1490d57ef6-e05feb3769amr2480276.1.1721256464923; Wed, 17 Jul 2024
 15:47:44 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:47:30 -0700
In-Reply-To: <20240717224732.1465438-1-irogers@google.com>
Message-Id: <20240717224732.1465438-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717224732.1465438-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 4/6] libperf cpumap: Add ability to create CPU from a
 single CPU number
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"

Add perf_cpu_map__new_int so that a CPU map can be created from a
single integer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 10 ++++++++++
 tools/lib/perf/include/perf/cpumap.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index cae799ad44e1..2c8e36d0efaa 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -293,6 +293,16 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 	return cpus;
 }
 
+struct perf_cpu_map *perf_cpu_map__new_int(int cpu)
+{
+	struct perf_cpu_map *cpus = perf_cpu_map__alloc(1);
+
+	if (cpus)
+		RC_CHK_ACCESS(cpus)->map[0].cpu = cpu;
+
+	return cpus;
+}
+
 static int __perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 {
 	return RC_CHK_ACCESS(cpus)->nr;
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 90457d17fb2f..79ed3449d288 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -37,6 +37,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
  *                     perf_cpu_map__new_online_cpus is returned.
  */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
+/** perf_cpu_map__new_int - create a map with the one given cpu. */
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_int(int cpu);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
-- 
2.45.2.1089.g2a221341d9-goog


