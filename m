Return-Path: <linux-kernel+bounces-340844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA13987871
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B473C282B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B6817E919;
	Thu, 26 Sep 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ai0xq0xj"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9615ECDF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372188; cv=none; b=s0HyjqAtxw52WaddeimBUqc7pRyZbbWqqICjVyHxAg1kgr9QzUNADAVx91Vzscm0HIEtfPtntpN08Opk3XId97+Nx/ZhnoK0WMsPWpVy6SwPj5yYYlI25zYwph/ozF9OKCHKZKfxtfl3pztIdry4gqj6zqcripBtv81gf6SC5Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372188; c=relaxed/simple;
	bh=LfTLgfo3KHjH2LunPKqfm7zFwrL+OIEXixJxNNTXPLE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FbeUbNyUIfhrppK+jy7jFs9vnET1qlZjbsSM2TYWOEh0wCkl8zQO7QbsbDHY+xDVQht6boJSoMSlR3j4BrnwKyBGhMLTElHMFA2JxSuEQokup+n54CWJ8lHqWyMVyfR3NgUb58xeEWxDAjWHhfwr5fnI/3oLne61y01nXjPNr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ai0xq0xj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2146737ccso25825147b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372186; x=1727976986; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjawVu6SYilvwlXMo1d1xJkVjPzpefbyO0+sOzkc8XI=;
        b=ai0xq0xjLFJ5I4QdASfQSXYnU4rujcuAHUOBlW9EC25Y8dgY6d1ISbyzNi7JijRUdJ
         YFHhl3eMyj2wbPBcdpIYLwNUH3nuUhk3xnL7vP8DmC7KtS0VGPOdJqUyPC4Boj4rygcy
         zCTBvEHe7jytzJY3huWgaflDEfWTE75PbZvzpF7x8bftSFv3yCFVheUfWZjVmM5e0BYC
         +Xa/De15hqmpwxENGvI29oO98VWv5rWNgBXCNTcSwqckp3ypuIOPDAjYxvK4iwttOwT/
         Q1Fv/Oi/LkEYD3Yd3jagiml7kYlRXuNXn+SH0VmVsj0+TF7BCm5VLVCYPcfgxiupsOr0
         BBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372186; x=1727976986;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjawVu6SYilvwlXMo1d1xJkVjPzpefbyO0+sOzkc8XI=;
        b=msBTrREvJAkpaDScjyL3bKNiUDYjgqPy36q5JbgSgyUe5zt7+DQyOXzdZJZi2pW9AR
         rdQK7GadBf1biRRmyVdHi7674q35ZZknZvzCQdC8sv+qaGs0tT/xcC/r4x+FLzWWSU0f
         +6/SJp/gazXiClQGMraSrgzZlFTywVQ8aU+DEBfJ8usw8ioPd6BR2+4zaCis224dfBFz
         7beQWYkmDU4SuMlItOhfG1WxZxZj0vLBpiSPyia2PMAngYQWTYYs3gWgaHeETNOWF9UL
         okBsDMiJENuKJzwJr0c7ul23R9TREBnmn22+xKkcxeJgDa66AW4VlWERQKSPhj+ZgI0U
         YdKA==
X-Forwarded-Encrypted: i=1; AJvYcCVHqBfuJKNj41sgO7juIZ2iXMrSqSk09cZ9kEP5pAjS+ERAYC0tmk6IfcAUe/gh+zhLeTSiDBr93iA4Oe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdUtIJqAG6iaENhfk/QkztCn1VJJz4G6KP0doXUJOrhDcY0oX
	tkNGvE8aP9STZylaTlQopyKc2PESHFLDi5YsP6GgD1YnFYfnBn2ccvpuT8j+I4Uk8y1DVlV1729
	SVKZl1g==
X-Google-Smtp-Source: AGHT+IGcJqvC20L0V+paymemjxK4+5rieH/QOLFJ1PlUVqwDGglKVZ4qbYjF0OvDMX7Q9s6A+nqH8IYFGlZG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:690c:2a8c:b0:6db:d257:b98 with SMTP id
 00721157ae682-6e2475a592bmr14757b3.3.1727372185710; Thu, 26 Sep 2024 10:36:25
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:50 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 08/12] perf jevents: Move json encoding to its own functions
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

Have dedicate encode functions rather than having them embedded in
MetricGroup. This is to provide some uniformity in the Metric ToXXX
routines.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index e81fed2e29b5..b39189182608 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -484,15 +484,6 @@ class Metric:
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     return {}
 
-class _MetricJsonEncoder(json.JSONEncoder):
-  """Special handling for Metric objects."""
-
-  def default(self, o):
-    if isinstance(o, Metric):
-      return o.ToPerfJson()
-    return json.JSONEncoder.default(self, o)
-
-
 class MetricGroup:
   """A group of metrics.
 
@@ -523,8 +514,11 @@ class MetricGroup:
 
     return result
 
-  def ToPerfJson(self) -> str:
-    return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
+  def ToPerfJson(self) -> List[Dict[str, str]]:
+    result = []
+    for x in sorted(self.Flatten()):
+      result.append(x.ToPerfJson())
+    return result
 
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     result = {self.name: self.description} if self.description else {}
@@ -533,7 +527,23 @@ class MetricGroup:
     return result
 
   def __str__(self) -> str:
-    return self.ToPerfJson()
+    return str(self.ToPerfJson())
+
+
+def JsonEncodeMetric(x: MetricGroup):
+  class MetricJsonEncoder(json.JSONEncoder):
+    """Special handling for Metric objects."""
+
+    def default(self, o):
+      if isinstance(o, Metric) or isinstance(o, MetricGroup):
+        return o.ToPerfJson()
+      return json.JSONEncoder.default(self, o)
+
+  return json.dumps(x, indent=2, cls=MetricJsonEncoder)
+
+
+def JsonEncodeMetricGroupDescriptions(x: MetricGroup):
+  return json.dumps(x.ToMetricGroupDescriptions(), indent=2)
 
 
 class _RewriteIfExpToSelect(ast.NodeTransformer):
-- 
2.46.1.824.gd892dcdcdd-goog


