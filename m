Return-Path: <linux-kernel+bounces-340842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252798786F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6AD2825C1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8B17BED3;
	Thu, 26 Sep 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0LTPjhA"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C43176FD3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372183; cv=none; b=Ij1IT7j+ttxfrIxp6UJHBkxCkuw8U6IKU2ekLUFUcqCd00hQ2qzmO/IK2CkYMQptcziu74O1GUmiYin5H9KIX0peuZJaBhQWajOvzshX9AJA6jCq7ThOAbPKfZVzvYOfCqKWH85LZvMdYxx6hb60NADBuiVmp69smSi3wdjVCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372183; c=relaxed/simple;
	bh=6wYQLnce4vlSDrSCmK7EkBM7P0b6NutgsCaHsuj/wc0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MsWZf30zGcN4ihWxbMWsjtvZkNQXQ7HZU3vEntNDBCraq9slRCuxIZnTeg4MJfQGUglH75kGWNo4TTyq5WcLRm5OqFFeQDYsXVS0eyRMiEIBf0q13wUGIKLrVWTG56y2XO0Ayk9pVG2fTDGhdLqRgP0m5QhM56QtfKkjqnUeRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0LTPjhA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso1717574276.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372181; x=1727976981; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9lmVPIwGAJgbZqGwUepqlVg7PwPudVkm3v4N6Eoo8Q=;
        b=g0LTPjhAO1VKAmyQLxvFDOOPcelFwVzDBwPbN3lHf3AEeQecf3u8mI0toSU4XGDF5B
         r+Y8/sUCvSPSht6a8/9FsmMJknQo5UTkrYeXqcj1Gh6bFX/NxnkfJbFtXKsBjg5Uh5tV
         3h8LF0bpQF97+BmwPgtB+dV6gjBB6ypAdJFALJDCNS7slzgemQmA4Cpcy70C4uxJRMiO
         b1bSkGBAR3VG46G8F3aO+R8+e7DNoA2+Fnx2yUc0T4BNA5kuPCv+rarnZlu3CoHVLHum
         +0A8k++j8XU3U6DA0tZDxrmILIe4EpBcdfBiKHECxUNCT3Ih+JzGarmiJQmQttPEbMJ5
         QDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372181; x=1727976981;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9lmVPIwGAJgbZqGwUepqlVg7PwPudVkm3v4N6Eoo8Q=;
        b=wlP1KWCbZzEy9/X0WRe1H2HTnq5xSB3yrniqK/X73Mi7puAa6UH+evNhdoU3IkOJob
         F5qxK4XDb/AX+Mym/LBHXZWFUtWuuSTmTpm5xv3I57daDbc0s3pdN3hKIIUG5FYg1tPA
         HWTE9M5fi3AwuS2AvhcHHlXEmnsTQL5vbqtyYowZpaqdA0SKwI3XGI9mRIWuxoGxBJpn
         RbEh8jggzB35pyi7QHKv/QSDMAsFABJU7Zo0FQ0zySSeuYoVkk0571MO6UjWxRXfOddD
         YC2NPcMQPxf2VRbmOzOujbWqIbunRj3LVWxzKmGpatKLAMOiiq3rH/J4IqurPUpmJOeJ
         +FFw==
X-Forwarded-Encrypted: i=1; AJvYcCXWEyK/nly0SzbEaTBO0/2MXHWzIi3/CT//z9TA/p7bETHTKlH/C7BvYvxz1cBRT81lw7hcklXw85c0fso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM4wcU1tZpKLO5auVfTUOBd+prvrj350MG06PSH8wKXlZYlUDi
	1XOXZ7l8YRp4rYYPqNpBsX1yBfbzw0TE6cBTgpKy9jmFMMYMb6kVo5ybU9YpqJ6s3Zf6cO6xOvc
	H7xUaVQ==
X-Google-Smtp-Source: AGHT+IE9EeWE6+0RW1hIqycPqZaqeDYi4shJTqvgSeMl0wmZe2+VVEUC52Ho0fKT4gPggEdM9QYHPYHQfjRX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:6902:1343:b0:e25:17cb:352e with SMTP
 id 3f1490d57ef6-e2604b7f6b9mr121276.9.1727372180804; Thu, 26 Sep 2024
 10:36:20 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:48 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 06/12] perf jevents: Term list fix in event parsing
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

Fix events seemingly broken apart at a comma.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 31eea2f45152..0f4e67e5cfea 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -568,6 +568,12 @@ def ParsePerfJson(orig: str) -> Expression:
               r'Event(r"\1")', py)
   # If it started with a # it should have been a literal, rather than an event name
   py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
+  # Fix events wrongly broken at a ','
+  while True:
+    prev_py = py
+    py = re.sub(r'Event\(r"([^"]*)"\),Event\(r"([^"]*)"\)', r'Event(r"\1,\2")', py)
+    if py == prev_py:
+      break
   # Convert accidentally converted hex constants ("0Event(r"xDEADBEEF)"") back to a constant,
   # but keep it wrapped in Event(), otherwise Python drops the 0x prefix and it gets interpreted as
   # a double by the Bison parser
@@ -586,7 +592,6 @@ def ParsePerfJson(orig: str) -> Expression:
   parsed = ast.fix_missing_locations(parsed)
   return _Constify(eval(compile(parsed, orig, 'eval')))
 
-
 def RewriteMetricsInTermsOfOthers(metrics: List[Tuple[str, str, Expression]]
                                   )-> Dict[Tuple[str, str], Expression]:
   """Shorten metrics by rewriting in terms of others.
-- 
2.46.1.824.gd892dcdcdd-goog


