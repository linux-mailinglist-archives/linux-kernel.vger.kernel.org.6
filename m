Return-Path: <linux-kernel+bounces-387785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B33499B55FF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52DE1C21114
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE98F20F5A7;
	Tue, 29 Oct 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBaggpb1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B920ADE0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241915; cv=none; b=pymMPqbRPasdGgertgw2i6/F2x1XhcT0t6LAZPuxDXpM0NG56tYvDhMVah85mY9ZuqsjvybsD7CSgfJIH/Bmu/Ltm2IGtLzIA1dG9iPsadyWhj1vCY1iz6QlErqBYc3QcAQ3pBs/ztxhlifY3xDFh2WRqtPD3XB7zJ4N9oMTzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241915; c=relaxed/simple;
	bh=iNS6gSj7D1lsvc1g5KMcNyPf5WgHbLQ5ta+6ZtnweO0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RhsiR//t8Oi2bBYYLr+gkFTYbn8q4HmKfpj1O/jchePSRPFXgEkSVI1o8qQvIHBnzFsShDKSm81hUotWXUh07IoIWTtDs7M9jF4SN2en+YBkJa7YfIzB4rdBUSpyMAfRNnfgWHLLdr0L4QL0ssqrDBiS4ZbnjfalFZ8NCYOtjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBaggpb1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e59dc7df64so5025137b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241912; x=1730846712; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1shwZLFPVJttCYQn91hD7eEDXA/86MDDB/52gfDhUo=;
        b=PBaggpb1CbQkG95scbZ7LNvGfd4HtiUSGm6Ssqi+74tRSniFcQvTmYk7zKo+aT89JR
         6VTd9qY2Gll85k2lyrv0Yb2BYABCX7Lb6VuDsHVmHYCGz4bRekpntE7HJt5738lugyED
         LadxmgI6+qhm26FYV7RFQpvED8fYGC9jZtEbQLJIkedB4ZNmrPmDz7YS3avo4LyWDju8
         DYs8/rcNAW5eRtNLN96YMmWkpg7PECHdn/lno8KGFWkt8vadgHsaD3eXQYmRYQc7lAnt
         UVgkpbjtD4zkuHDcpiYq016idostTRE/uGug0Ca40wf2AcBXmfbDjzBba7C++QCmdFDJ
         pBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241912; x=1730846712;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1shwZLFPVJttCYQn91hD7eEDXA/86MDDB/52gfDhUo=;
        b=m2Wlgqf89B40zq8HrHIt8EcO7r7D0da5fbmX2eN2hhb6FS19uFtRHgxkvgIXa1AwA6
         gAHh+12Xee0g9KyNCTxn75S8FBHuySHBbHkZJjRazrPySYDRJEUB2O44tVyXf8W0u8o0
         f29SgofjHp7CkuRvt3NkDEp0pYc6uFPRI3qgIXrXK8DKeHLDt7mMNkflMtUmrMLtS9k2
         VPV/OuuNIhOqQZo5CcNqdOMzfbXqRnis5dYbdp0HMOEtJ+nm9OJCzelFc6ByvEGAyU5u
         A0dbywNia7qX74S1dcPs78aqvibiJvdR44obqNavtL3cP6S+uGeHdEk33ph61RriCoxM
         Aeow==
X-Forwarded-Encrypted: i=1; AJvYcCWbjJ+Hd/DrSLGgpQ5cGbEE1UegPL6gudWlreZ4fswcp+7UrnkksLnGr6W0jHkw5lkL+/TkH3a5D5JK4aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2K6V3ttQt0byPkESDqBTGaSjIrI897nicp+IMYVIUZGhhUqL/
	VSduyfQzuHhdHTh4V3zOg0e79/+fKjHjsEW4WE0PRx1J4yx+z8K5hteye+tLfXO/jB2NXqB89dF
	5STzVvw==
X-Google-Smtp-Source: AGHT+IEwTaJlXSQRR4sx+ZQnzVzk15DS6veFG4A3cQyhb+cmNvvvPfy1YzJ3tWyEoBvgx2hnMXYELCvii+HH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:690c:3582:b0:6d9:d865:46c7 with SMTP
 id 00721157ae682-6ea3e721cdemr176997b3.2.1730241912105; Tue, 29 Oct 2024
 15:45:12 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:27 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 15/19] perf build: Remove test library from python shared object
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

With the attr.c code moved to a shell test, there is no need to link
the test code into the python dso to avoid a missing reference to
test_attr__open. Drop the test code from the python library.

With the bench and test code removed from the python library on my x86
debian derived laptop the python library is reduced in size by 508,712
bytes or nearly 5%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ef1b39b5042d..2059f1c4b78d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -487,7 +487,7 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
-PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS))
 LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 export INSTALL SHELL_PATH
-- 
2.47.0.163.g1226f6d8fa-goog


