Return-Path: <linux-kernel+bounces-255805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF285934565
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAAD1C2168B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8D615C9;
	Thu, 18 Jul 2024 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlSsjkxc"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD61B86F6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262652; cv=none; b=kpj7APSu1L9QjR+cnJhLIkTDJumCR6mF81HtCjEfydrTmt2VdYq4xeHUfEmsM71iapj12pL4gffr8ahWj9aGplx/MJfu6j9MzBGcZdn1dac6gYMansQG/fLO7eVkkXdHPylco1gm6iJkHbFzsf3zbirW/dFlKCknJx0E624Bgmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262652; c=relaxed/simple;
	bh=xO1LeDUwAlVEwZnVaFmHHPJ2GZce6TEJ/S7/OdCC7Zg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=u2+RivIao6Trg6m2hgD4O8lZUEHPe26WSEtFSTZt6GAn8rE16rLE6BrX0iw0FjfA1sanGmNBiCi1I6xH7Gu0qs0ArbOyrk9GOnMY4yeON40J7j6VOPshWHMLyJj78e0+nQiJ1nwqT4wRxZ2b6npPUIjAuusViQVZ4Bh6XohKXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RlSsjkxc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6506bfeaf64so4569597b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721262650; x=1721867450; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpNlJN2SGII3MYeevUlf4p1OQiPVTTvbXe1jkW5mOAw=;
        b=RlSsjkxcC/IRWN0WwacEwBho1lsHj484vVq20I8wgxjlpySQ7KdgFFm9QetjsWq4TT
         DcnnRzOrrfuoA7vrUtvT1DWxmOfVDBefQBvrFAWDe/QHWbmnIZkP1R/4qa8Q9EqhnioR
         j4f/sAOE74MPaFb1fPF2EGLmdaj8TpGUU8aHebIbt/5+kuLKgRwImR+N3+GuN1fDbFA3
         7eIyQxpYoFyK80Q3B3Y0xBD0Mc8kjUCeY/KmJ4EzbnhBrTtG6soLkCu8/tkNnMIDfTeH
         QpaIvz/LUSBvOIx1yE2fkk25QZr4qQRXGyDv9KRwoZCOVSYN8774EdGu4GVD8Gru8/rh
         wwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262650; x=1721867450;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpNlJN2SGII3MYeevUlf4p1OQiPVTTvbXe1jkW5mOAw=;
        b=U7+b4zaf90megdZj0wadeldQjVsCJINXJ/dbWtqIgY5anPCCNNDGkephfu8/tcdH44
         l6kPSj8zNP9B1R9k2bQAP5wnvOHeGV17zjAVGxQ0lUketLTS3bl8w1LJG+PuOgFc4le0
         BCe+mkssqjr1kvggiutqhUygYYIIr3oSOAheGssaH7RlZscvcK4/hul2pLIvtU2bAitd
         e+0mC+uScCC8/KWCJ2TJHDRIeMwEEhdnL1e7W3wN5eH9FEYQugJnVpR3c6IUoIlJ7ZgL
         nmYpSs5bULs+N3S4uX68/bd2cI3e/OAZLmpov/V/H5imHk/YAFzFquM0TfJd0ZSPe1RI
         3rZA==
X-Forwarded-Encrypted: i=1; AJvYcCX9oifC/cr64krSzfnOvEg0PTcgIZloxtOUYKFaK2N5TJldjMzsAEwbc5etNbBrl2Olz9B1jyBUTF0XCGugwM7wJWfVao7FwXIu2xdu
X-Gm-Message-State: AOJu0YzHi8QEdMJRT0NUniQmq1i89bRHm0+qa3nUa/ncnDkwqyqUE+Au
	Adwkp/98bgxHqsmTNIcbnqcwG/RE11SssQTGjqgOHqBJwafrFxAblNkTQcB3TLK9mmzgBt8Sawb
	DhVrd0w==
X-Google-Smtp-Source: AGHT+IGG7VWzTnmycXmTdJphblM+hhP0c4L9vMl9r5mE9Xw5+miKnxk+TogRA/6By5AIKP4LV8790tNifGhm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:289:b0:62c:ff73:83f with SMTP id
 00721157ae682-666040ccaedmr396737b3.8.1721262649825; Wed, 17 Jul 2024
 17:30:49 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:23 -0700
In-Reply-To: <20240718003025.1486232-1-irogers@google.com>
Message-Id: <20240718003025.1486232-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v2 4/6] libperf cpumap: Add ability to create CPU from a
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


