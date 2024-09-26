Return-Path: <linux-kernel+bounces-340893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9A9878B8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3F91F27175
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4CE18873E;
	Thu, 26 Sep 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2Z5fSAY"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361318872D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373096; cv=none; b=iwbtet3UegN5SXJvK8C/TTi/Huo0j7GDxl734vfLen9v8pQu/pZLSfEChFvRlWLHlz4LCyZTi1+7I1OR2iFws+LZuXl2lyNsTOTfzFionWqzFjqNBxQG6/0mHBEw6tZCre3FL5n/VGDTVFZ1yV0qSRrbBDcY1bSp15Oc3vD8oG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373096; c=relaxed/simple;
	bh=gERZzLCzc2fWcCvVz8qmuopBQ0MicZBfE0/WEjrEEsQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=C0Ivfk0KPAF7+LQBAPs2/H0sAY//Ak7y/KASOIcOHQbkNDxxcCT3yLWjPc734hkmJdZ1RtUimaCAMQCkzsL63GW7gG2XU3jUpZurx5uePq1TUhvoB5nErTR6v+oVOiRGDoJNF1i/n69gpbAvVVlI2kg0coY9B6Vkzt60hIo7e1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2Z5fSAY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e0082c1dd0so30039127b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373093; x=1727977893; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJ+kNXYQ6ijjlJjPvv7tl9Ibe8Ne8BhermJ+ZjD0JCw=;
        b=e2Z5fSAYENS8f0XEDgpJqXzGNozBI6/wuWGb/vJUu+GyguBHov6fUoVnutlIH1uzsw
         53lqa2OxD9eC+EPqcyd6igiTisLp2tHHRjoWTtqA6ypNt/DOGP/eKQecVGTB1OcCtPXw
         KCs/VIim232LSxMXYQvLkXdAg2PqwEt6VNaLGfquacH/52U+1XePFlzIC2Qk/bhweTTV
         qQBCVV6bKbg2dzNTplz7LVTjja4c00sgP47knASFCzcQfzyEnHaPPsmQ/K8VjrIkPxfH
         AomiD6+trmIZqsF197l9kTsJl4upFx7OItTDtmFSAtEhe/HMAPZ12bomqJl6PVQWUQQ5
         qpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373093; x=1727977893;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ+kNXYQ6ijjlJjPvv7tl9Ibe8Ne8BhermJ+ZjD0JCw=;
        b=gBRNuty5ZjMtHAvJlCvpmOQsWwjUORhJRKzJwik29vfOkfZMJMpV3SodfKGDzjgup5
         vs+QdSR1qoJCZgL8W1dYje5PoOgt+HsZw6fQwmJQx6UFOZ/+Lyb5Dq9TJ8vpifzj3L4m
         JlMgKOzoAPk0D+Sz7pfLPhCjoHEa1aL0kjGT34On+iGJlaogwqgLar0DDvekPii3B1re
         9G7P8J1xJfOkchSKQkRor6vAXFif2G3lzO7ajOQZKGUjvYFsB2e+qvkdLDne2XINHPsR
         HdmzFumVwLdoJSzlQDrwA9fB9rE3VvEK4FL2tR3p4qHJgR+03OuCG3CK/+qD1UzTPoQG
         ZWAA==
X-Forwarded-Encrypted: i=1; AJvYcCVgqwFrdl8MB3InyyQsImfsjscwWt5wHhXcB5ddFdzpdwOfbWysMpdNAWTzt4EFNqJ0cZISOG+atLCVu1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQG/ffYAalymt412AKv/lsPxgIHVxJDJR8JXGpHg5erMjZ6hm
	mZbN3ARDOooVbl/ztDk6dz5Y+mFM/pFZACBVY4wohCVFEeYxsVRGPR6asHhTP2QC0Xi6rwUWPge
	ZgYf6Wg==
X-Google-Smtp-Source: AGHT+IF76900gFgipr9S/AeWEr7e87McD4QtSxG6frbbqn+BrqutYPpn4+Qbx6r73jI9yX+PrPpjA4Fl2z72
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:690c:4810:b0:6e2:ef1:2551 with SMTP id
 00721157ae682-6e2475dd143mr27147b3.8.1727373093569; Thu, 26 Sep 2024 10:51:33
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:34 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 21/22] perf jevents: Add upi_bw metric for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index ec15653e2cb6..8e1c0bc17b8a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -990,6 +990,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+  try:
+    upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+    upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+  except:
+    return None
+
+  upi_total = upi_rds + upi_wrs
+
+  # From "Uncore Performance Monitoring": When measuring the amount of
+  # bandwidth consumed by transmission of the data (i.e. NOT including
+  # the header), it should be .ALL_DATA / 9 * 64B.
+  scale = (64 / 9) / 1_000_000
+  return MetricGroup("upi_bw", [
+      Metric("upi_bw_read", "UPI read bandwidth",
+             d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+      Metric("upi_bw_write", "DDR memory write bandwidth",
+             d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+  ], description = "UPI Bandwidth")
+
+
 def main() -> None:
   global _args
 
@@ -1031,6 +1052,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreUpiBw(),
   ])
 
 
-- 
2.46.1.824.gd892dcdcdd-goog


