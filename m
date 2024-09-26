Return-Path: <linux-kernel+bounces-340839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD498786C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D4FB27AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4351667DA;
	Thu, 26 Sep 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qE+qxTAf"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EA165EFB
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372177; cv=none; b=X5oSRZJh6QReFmRaSgUN1ju46KEbfvxp98n4kITMw0IqEcpYpt8bEPsf84uVChR/jixE6B0co+cCr0HGHY+9P71ehjjmMxqEaREEXTFbn1jl+jBDHK7O1cbLiR0UgmY4D/60RxD1bvNNoCCV1IB6pa7GzLyQk8O8U70uTXDYM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372177; c=relaxed/simple;
	bh=eHwzA5MH9IBoaTTv+LG1bQW6beIMXCSj2nnjaeYUe+M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EJqwXXqnQ7qhyYB3bOMmasTWqy4b6wfeJu3+jxjK1yQNlsJ8aOeLuWgw34+2Pi9LTUPw4mMbgvg+lSdBiDKahU6RbrGgBzvKchVqEmr5I9FjNafKNMMOTojacxKz1v71xVEMVMFNcknj2HtTf/Sp4/VhAFp/KqqNXYZKB0maUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qE+qxTAf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4bd76f5a8so24370787b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372173; x=1727976973; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWFP43NYs/kH9GrC3hN9+SHb163yh6Hop52j6JI/aqA=;
        b=qE+qxTAfv13cVsc3H9C3oQyTvp0KxzBzDl2dDOZRCpnFG4WB9F+HmgHlP/oPgD3SPj
         zdIbJNG9KjKSHEyARxBCPAUmHsqDrqMu9QSYiNNQcGBZo5Y5pt+zwgT/2pevvh+kDyxg
         UXEj/pc0JQSP6hrtBAN+Q3+XXj+lzE+CnPPpob3l9xujDl5V95+8vPGYuGXdEtPXIzEs
         a95084MOf4icnbk0ckjG/QfVwmIretUrKWH8QjSQDGqk9Q4792mcYVQn8VztDbDX14HO
         pau6fCR25YImUNcxzKO4n9MF1yYBSkzhCABRu/j2/hMMN4on82z76PKLEe6oYxoA1+kL
         Jzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372173; x=1727976973;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWFP43NYs/kH9GrC3hN9+SHb163yh6Hop52j6JI/aqA=;
        b=UZ27eJfaT+dAvprUYO6at9FJ4w4nX29KUfgmBEbwjG2Vv9yQZx/k5znA/n7t5jTqmQ
         qFZd8RuIRB7jGW1daB6xHJ1cRp9P8wDezsZ7XYtBnnd0R/umpSySMjNZe65u4r5fUCHu
         9JLNXrCYtXDCudG6y/H4ZVDysJ8G+qz1TNkDFa4hw2dTaS4V+Gztt3yiyL9MGwXVb8ZA
         egbEhLV5kjiAu1uj3VV7P4u21QfE+X+YKI/+XiD6tURzFk6opWQCnot6x20Lp5jcCm28
         vEJiju/t4ueoWxZXC4NVNj10UAwapLUm499iLwm9zmIFQ/e9S+Jbs9JVUJPMv1mWmBUP
         FmMg==
X-Forwarded-Encrypted: i=1; AJvYcCWinDqfrOLjWhLNNS2ytpoH4MTQaBOWuKZA1l2eV8wxtZiV10XomWyYpd9CpF3lcq3GXkHz1DeOfy3niBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRkSt+Yvb1Ol8hKd0xfy2DKc2y2aza8jGxo4Oy/xkfe6mVkIK
	jBHQngF6QOxCcU8K9HA7gO5rADdVOcUY2e3HJCwuRKL63XPM5+H1qr/oePNcJEvhV2C07TiAizX
	MzMttdw==
X-Google-Smtp-Source: AGHT+IGaWYXnORF5dJR+cgf78DHcNovDJSUuCpedznZbnze2G9M/UGqAPYyC12mYh2UOcwlpHVa0iwNORqVz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:690c:2011:b0:6e2:3e17:1838 with SMTP
 id 00721157ae682-6e247518b3emr9337b3.1.1727372173427; Thu, 26 Sep 2024
 10:36:13 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:45 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 03/12] perf jevents: Add descriptions to metricgroup abstraction
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

Add a function to recursively generate metric group descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 8a718dd4b1fe..1de4fb72c75e 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -475,6 +475,8 @@ class Metric:
 
     return result
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    return {}
 
 class _MetricJsonEncoder(json.JSONEncoder):
   """Special handling for Metric objects."""
@@ -493,10 +495,12 @@ class MetricGroup:
   which can facilitate arrangements similar to trees.
   """
 
-  def __init__(self, name: str, metric_list: List[Union[Metric,
-                                                        'MetricGroup']]):
+  def __init__(self, name: str,
+               metric_list: List[Union[Metric, 'MetricGroup']],
+               description: Optional[str] = None):
     self.name = name
     self.metric_list = metric_list
+    self.description = description
     for metric in metric_list:
       metric.AddToMetricGroup(self)
 
@@ -516,6 +520,12 @@ class MetricGroup:
   def ToPerfJson(self) -> str:
     return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    result = {self.name: self.description} if self.description else {}
+    for x in self.metric_list:
+      result.update(x.ToMetricGroupDescriptions(False))
+    return result
+
   def __str__(self) -> str:
     return self.ToPerfJson()
 
-- 
2.46.1.824.gd892dcdcdd-goog


