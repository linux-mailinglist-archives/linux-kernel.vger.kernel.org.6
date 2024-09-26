Return-Path: <linux-kernel+bounces-340841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68998786E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B99DB20DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2C615DBB6;
	Thu, 26 Sep 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyKTtAIW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33014170A12
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372180; cv=none; b=OCtDFvNRkUnuePPtjixrdEb69eMikKnXmISCwZGB6Inu2flrDenWB0hnnoJhUhyVbNFOOs2GtvN5On74fmmM0q+Kc2GsWv+Arc+INtcw/xpijq6ckYq4UGeK91y3fPaCUMLwXNUtKNCWTrde3OW+XzTwlnIpNPDnya7HRn/PUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372180; c=relaxed/simple;
	bh=Ic2gzA/bbOWr8+GudHHWFur7h6xRAQmb3Pn9q49UzKw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CGISZJPmOpZL3wghQcqjghGSssNRwq6fsowoJscAYGDNV9mjKQ1h+tosOfZ9N4hjP/mhpH9ctnvldLjtGM5VHdFeSHcNr48fVjXudxVlUHY6BEShHgbP5Vz4gW/12YtZeRSVfyIEXPk+KaVO0pRDjlcxiQG8arfMYa0sYyvj1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyKTtAIW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e230808464so23652427b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372178; x=1727976978; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0HaGZwNUfFDFp9ShWHIUFE2GLz8humaPEHhJilF6vs=;
        b=cyKTtAIWUK3sP7j6wiQm7PdWlRoMKwwi+qqP88Lb/cM/jv1ISOj5+umuecZEyoyXG2
         eRof0wEbFTjsh4c8W0lDLIfMyLWHNDguN1q5OPoSyI85s5ZGD3T92fB7J44fQJwy6574
         f+bARq9Ai/lnbbO9JkNfqCoH7AJ+/YJrEM9jH1zS//nFGe6m3wgLYMmMNWTJwo55jGdg
         HDkDEqtPhN2R/+myW5GuNc89haU45rU7lsrdyLIZLAVQ3jQsKRs4t92CZyzJZoxCrsZS
         WdlxyTyGfq6ZJV/SZcC2BiRW1rLnzs8UbYnDI7i/2PeSR2knLzTDrYp3exXkDAeIhMlC
         MHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372178; x=1727976978;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0HaGZwNUfFDFp9ShWHIUFE2GLz8humaPEHhJilF6vs=;
        b=lAzfyjbjAMNw0W+9W1QdfsR54kqb9CnE646/QNj7tyQDCazabv4E8l1m6wvq9BZ7TA
         93PTawZdY4Nz0kMDpsyttRpQC7rA6gsEjgtOEBo+0pteYcjrf9yqS8yLs37egEAWu8rz
         vZP7lcTyTit5zI8YlNa2h0wXgJZ5ERxTHAm4YW3qRi6HAIeLgh6U0kkwvvUvSw3teJjr
         1Vx9x4Z5HmlX9ggflaQ+MY3f82L0n5xzLWZG9FXZfd5WkQabnXSfsZRu4KQ70BSYYp14
         EXweeIwuRYHYmk+QNhybo1vn1RGscwOKAj2JKh6OaSecEdtINQ7WpKTkrO3CVH6i+uty
         xDIw==
X-Forwarded-Encrypted: i=1; AJvYcCW8e56mGeCXj3ETGqST9ZwDI5DuGKOAiRHaCvNrJ/Jl0ZVcrwwltA0CwS50jkACFxg98DatKdmyaeGQsfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGu9eV0KNekc0Hdw6oJy3ML117AzEmgwkhftvbrkGQZUw27QA
	/BLnuUWy3MnJQmNFzr6FKE/ibDJOnrQJRpeGzziTm57ElJeUpLbWnMZ5o1vtU5vkzeMnviV3mVQ
	ozyB/fQ==
X-Google-Smtp-Source: AGHT+IExVWVCVrF+zkRsj+feFu2ow2iY7yX8CH096Gn48W9MKPFI96XHvR0wTsbPJJisdUdY5Mudg03gPhPA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:690c:dd4:b0:6db:e228:2e40 with SMTP id
 00721157ae682-6e247604e7emr5997b3.8.1727372178311; Thu, 26 Sep 2024 10:36:18
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:47 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 05/12] perf jevents: Support parsing negative exponents
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support negative exponents when parsing from a json metric string by
making the numbers after the 'e' optional in the 'Event' insertion fix
up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py      | 2 +-
 tools/perf/pmu-events/metric_test.py | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 847b614d40d5..31eea2f45152 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -573,7 +573,7 @@ def ParsePerfJson(orig: str) -> Expression:
   # a double by the Bison parser
   py = re.sub(r'0Event\(r"[xX]([0-9a-fA-F]*)"\)', r'Event("0x\1")', py)
   # Convert accidentally converted scientific notation constants back
-  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
+  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]*)"\)', r'\1\2', py)
   # Convert all the known keywords back from events to just the keyword
   keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event', 'strcmp_cpuid_str']
   for kw in keywords:
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index ee22ff43ddd7..8acfe4652b55 100755
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -61,6 +61,10 @@ class TestMetricExpressions(unittest.TestCase):
     after = before
     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
 
+    before = r'a + 3e-12 + b'
+    after = before
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
   def test_IfElseTests(self):
     # if-else needs rewriting to Select and back.
     before = r'Event1 if #smt_on else Event2'
-- 
2.46.1.824.gd892dcdcdd-goog


