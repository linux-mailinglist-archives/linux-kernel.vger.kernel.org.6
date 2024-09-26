Return-Path: <linux-kernel+bounces-340838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9078F98786B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E3EB27851
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0CA161311;
	Thu, 26 Sep 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5L1ubrQ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7E156665
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372173; cv=none; b=Bkjv3ggByDoKFJzIHaenUjbClIw75Ba/zomCVjSLkg+kmcg8qQslTUQHFcGVIA5Uj5QkspsYAEr0BSnteVDHGObjQzvRDT/wzThtSDuRURDe8evpAUsAyLqWEU0JcmbaLysLRHtbwekvvSv0rrrAg1gMvUgUiPfjf5tHxJZlwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372173; c=relaxed/simple;
	bh=Ix3OFhfdr4sDNf1twgqYwbUt/vWWkfx//TF5rxOehQw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OZ9gGTavqfLOdVIJrGct0EmPmXAzk5Kasva66ySkA0Bap+S+CvSGdoihw3r8yqU/20TZOj78aQxG5ADFpXI9sTNGDcEhICzIRuqIyxOR4KjZNHq3xzUGFOYxtkUQ7Flt+hHdah1ub+mOdm1V2eSDTu5WtP00ZWwvCEIUG0oYAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h5L1ubrQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035949cc4eso1915779276.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372171; x=1727976971; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXw26LoZtjF4490TVkyxEfHo6L+w0tQShMM1GlIzvwo=;
        b=h5L1ubrQzWaBHNuNkLEnAMpkRbeWgCeLVeaIUpoFo++K4sf+0iVmrnIh6OunVkTV9o
         u7sz4rsg3naToCKxvdSyfUZxjW4vKnDMGh/RLaSIDLKRpUvNqb62gnLWa/difItAzCIL
         sIPxbh5fPPGcxjjUCx3szdTgofOMHQ99GN4o6sMhmwAFU/1nRLeo00bsDdHUc0mtmn38
         MBaLViNvc8zeZTczCfWN5YVkkfwc3hQSOCu2TKKWuaH63mRntCksTtF3RCPf63w1xYgU
         0ktFGox472giYLkl3yNvKWtGW0CSSn4mIa2rTj1MpC5aFh8bxnlRMgI1DHHrcQ4xUDVE
         nMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372171; x=1727976971;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXw26LoZtjF4490TVkyxEfHo6L+w0tQShMM1GlIzvwo=;
        b=EeuKQHz9Fc745wjkkrPy5rmTM2PTux+e3QF1LsJ5MyuCZQs7Zay6MLSxnO0llP2eFt
         7nbASdQpCKW0OJBW9Wgx6zONgI22nl5T9WZnjP9Rt3hsAu6Q+zci2QrR/woxUHQc9EQO
         vaPXp4xuwYljE0HRXvFYp4Md+hzArwyV4PELLR1VfP2Hn+iTovJTHPvZq2egrMcy2UBU
         pCEiSMoKHWt/AU8FMjN0ioyx9/IyvIYa4+daAiWjmfbHJ5xJparpzxT17pa8DYoPez6r
         Ocgfpq+UZwoqRXdtBm1a7zshE62d3dwXGOBu9pSpHrefDphEIHEQ6bfaIbZVJ9+u60Nh
         Ymww==
X-Forwarded-Encrypted: i=1; AJvYcCVP4nykwdvjm+K9h7HPkcTwXdQblHb/WuebeBdO6zwXg2Cie4JurNmbMrljyIsk+rPcw6miLL7++JQGiHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUrOUnt6P9bpYI9neAoxf1EpSOXl8Cb50cAdz9J8zZJtJLkaO
	24V3Gf6ZAz7fmHGaCq2QCRwZXGKH2M88qKAXxsfOcpBs6QPIMCkf7wSplGLF6xg8yhLlDKz7dHq
	L5DuFzw==
X-Google-Smtp-Source: AGHT+IHB8Y0pFHinkxYRhJPZyfPi+ipY1+wne0gkGK2mqD4nHa0eKNeL6IF+NYjzlB9rzqUqXVIq1djWU2cw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:d6c1:0:b0:e16:51f9:59da with SMTP id
 3f1490d57ef6-e2604b79520mr172276.6.1727372170691; Thu, 26 Sep 2024 10:36:10
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:44 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 02/12] perf jevents: Update metric constraint support
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

Previous metric constraints were binary, either none or don't group
when the NMI watchdog is present. Update to match the definitions in
'enum metric_event_groups' in pmu-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 92acd89ed97a..8a718dd4b1fe 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -4,8 +4,14 @@ import ast
 import decimal
 import json
 import re
+from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+class MetricConstraint(Enum):
+  GROUPED_EVENTS = 0
+  NO_GROUP_EVENTS = 1
+  NO_GROUP_EVENTS_NMI = 2
+  NO_GROUP_EVENTS_SMT = 3
 
 class Expression:
   """Abstract base class of elements in a metric expression."""
@@ -423,14 +429,14 @@ class Metric:
   groups: Set[str]
   expr: Expression
   scale_unit: str
-  constraint: bool
+  constraint: MetricConstraint
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: bool = False):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -464,8 +470,8 @@ class Metric:
         'MetricExpr': self.expr.ToPerfJson(),
         'ScaleUnit': self.scale_unit
     }
-    if self.constraint:
-      result['MetricConstraint'] = 'NO_NMI_WATCHDOG'
+    if self.constraint != MetricConstraint.GROUPED_EVENTS:
+      result['MetricConstraint'] = self.constraint.name
 
     return result
 
-- 
2.46.1.824.gd892dcdcdd-goog


