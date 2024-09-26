Return-Path: <linux-kernel+bounces-340855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BD98787E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C9E1C20400
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AF1667DA;
	Thu, 26 Sep 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yVGVMSmY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CCB165EF5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372478; cv=none; b=OBqQPJKGavWojJD2lSGel19HiXyHsReYwc1gL8nNFz8k3y1y/JSQRQvJl0qemgqQt6tnXKl0mvSep5te9YSCTdfbPUHw92LoNm+p8HwfjvOKw/wZPKYw542dxJUlUR8I7mHrR08GfIiE20yEPMLRsiHkF2CFKZ4Xu1HU/g4LTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372478; c=relaxed/simple;
	bh=i0f6cs3zgN4BvTOxSGiPurv5Mttm1AXTfByvdHtI7eo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bPXHuzygdgGG4vmQUdn2OqP7RMfoQK/G42+a+pRsl+W++POY83sDcAUHDAvDFh/UGLyHy9OccTJJqQReJkyG+mO4I4+kUXFpwKH0/b3ftniLWzUVQR5HJQRSP/1Pznv8o9dDWRoAHKULz4LDCevc1do0mscmVZDz2cgwSRXd0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yVGVMSmY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso1724642276.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372475; x=1727977275; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8L64M9/E3Nef4j9HyHAM40/T9q1l6tgS57dtuqDDd0Q=;
        b=yVGVMSmY42Wm7YVT4qWDJZI8KbeJNFvh9NxH8Z1WECJILqvEsrr0+JyCy3RllgRVlh
         U8ekmJMfgJUBQ6nyNJXTXP6fRc/R985tKndHJnvbz9h138XihC4n3hUXSqHmgQwpRXAW
         D2gj7EdZ1mSa0E4TVDqdzlE/0Y3qkobry2dpJH36UnfiTkaXCmD3whzESORjo1js8zq1
         wZ6e70OcRzi/boIVC0B8IFXfWsK9YOCTHjDArpkGi3mqaUEGXLBvuaoJjXT9mCQ4pGNe
         32FZUcQ5Dd8n0/+B1SJw/cea3QJ4iBg6hY8PV4MaEBSPeskXVQ3eo+YtTGBsEjL1Mfmz
         BR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372475; x=1727977275;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8L64M9/E3Nef4j9HyHAM40/T9q1l6tgS57dtuqDDd0Q=;
        b=wfkNqGAy2xDAYytshFHCb+EPZSkeH/mrkLvJrjn3wFnLeek5YsB32IE49xDLdVqvc6
         r0/s3FCF3bnGYUhS5h6MNDoc7T4ziESVSYfhZVJa5M+Wl3MFP9RCiRe3GuYYceEGIS3s
         YbdBBbxZlr41zmb5mlz6U3o2XwYsSUP12IWLn3eo6YBYilxm2w/0HB4RFTenk+VDTo4Z
         h2ArSDg+zupZk/M1oS1/aLqhq9QwLhxr6qVo9HfKPZi1rcZ9dJDUg9akYkEbY75vGPEX
         nDWkWsoMDKYtOAWHK+WyR0FuG3yg9GfokHZqkWKPVX/Y6QwgptQOWjejAqT1V7OHycbQ
         dVJA==
X-Forwarded-Encrypted: i=1; AJvYcCWq/X2P+RZ6d9wWZ1cQwbo6RaUi/21NGmdACZRv5McHVZ6bRSvuTLIuQQK+MdUKtftwo4kSNii7bT82sLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLS9luJGVjXXWUg7BJfdtJuMs8Jy+FWIgBa6MP7aNLFcJmFTdC
	tmEqdjhFVEV3GnZ+SNBNI2ez+ag/RzcOx8gS8QHxhMjY9fY5tqOBW58JKo88ImX4ETMNr/am6B/
	QGWgn3Q==
X-Google-Smtp-Source: AGHT+IFRF1RA+NvIosqX2fqp9SFu+U+Fskiv+3MILB0wDEjoJX6ZH2hO0Ll4ypw8pOfUI5zfi1xwrrntMmFw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:b19b:0:b0:e16:67c4:5cd4 with SMTP id
 3f1490d57ef6-e2604b2b0f1mr131276.4.1727372475531; Thu, 26 Sep 2024 10:41:15
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:52 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 03/12] perf jevents: Add upc metric for uops per cycle for AMD
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

The metric adjusts for whether or not SMT is on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index e069b95d6470..c64470d4822e 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,8 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, Select)
 import argparse
 import json
 import math
@@ -10,8 +10,17 @@ import os
 
 # Global command line arguments.
 _args = None
-
+_zen_model: int = 1
 interval_sec = Event("duration_time")
+cycles = Event("cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
+
+def AmdUpc() -> Metric:
+  ops = Event("ex_ret_ops", "ex_ret_cops")
+  upc = d_ratio(ops, smt_cycles)
+  return Metric("upc", "Micro-ops retired per core cycle (higher is better)",
+                upc, "uops/cycle")
 
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
@@ -45,6 +54,7 @@ def Rapl() -> MetricGroup:
 
 def main() -> None:
   global _args
+  global _zen_model
 
   def dir_path(path: str) -> str:
     """Validate path is a directory for argparse."""
@@ -65,7 +75,10 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
+  _zen_model = int(_args.model[6:])
+
   all_metrics = MetricGroup("", [
+      AmdUpc(),
       Idle(),
       Rapl(),
   ])
-- 
2.46.1.824.gd892dcdcdd-goog


