Return-Path: <linux-kernel+bounces-539565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AB5A4A5D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41001899F82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E729A1E25F2;
	Fri, 28 Feb 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yqglsY3B"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EAB1E25EA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781459; cv=none; b=YSmyPc6UQxg/836qJZYwfUSzMG+kE+cuf5W+zID0HETM6yaqtMnDFNMuO9Z7g6w28mDmr7PdtGypxxdW4q8uDQ+lICdjV6OX27yAKAF0M8//K96ekiXoCvLMJrRxqNYf30ftD2fomL5V86xbQYKKAYHDX6MPSjh0oNkxzBfeZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781459; c=relaxed/simple;
	bh=rex2as/EnuXYCks18MkDmVUBXz3F9t2JAEg7XMf2fWQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=UgKhbRWSbbIHpNVE7wiBQW3qzUKYqeu7Jt2V4mauJ4XShF/0Ixtjqd+J3e86Ba2ffAgH9JI9pAxa/vK/Utz8HgA00iZw259rnnB3yctpqV6PDiJtXAZceHmVYrML7koVs0+1A4aftx7w0U+GWtAGXMKohnNiCQqCQ5R8bIt7oPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqglsY3B; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fb518ad1e4so29037457b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781457; x=1741386257; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RU/+DqotUTg+8ru2ruiECPIkRiWWFRT5gNEZToh78w=;
        b=yqglsY3B/iEIDP9/RKZL7Wl1NcqXkKwqrvw3FG5XC/UfK5ENGCeY+AFKra79AH841b
         VDJ6Y275ypvLF/teWBKePbnjnndUygloAQ17Jvk3zvHQD+FUfKWyeQTtRCjJEzQjXKKo
         YPrIbI6c6vNsD6z9adDGb1Jg1KtBdbza54MpNncbkZ4kgdumoAquTx/BXcZwAcDfQBFT
         Qf6vWmRUBVX1iL6OEXWQ3y9VTxYZXf0ZPL+y6o9OpQh5BhLHIsxnGntukkYPqBQf6IWi
         KrMHVgjavq2RTC+32vDaDO4aLW659kwz9OqputgxLAEwcVGIU/4iSOscI3kWHKnw3STt
         /0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781457; x=1741386257;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RU/+DqotUTg+8ru2ruiECPIkRiWWFRT5gNEZToh78w=;
        b=N9Rhf2lLjEr/piW4wpZ68vzriIo3Z2JBjUR14WPKhFb+pQcEXS2MQIc/dA6xeJrq26
         OhpoD6ziu4P7ccPU8KrGzNxJL7pBZPZnX5jHA85wdtcNnNFa/PCOG/BWtqIUICIydgW3
         UOFBZ+4u6mYj6p5zsQ548xWsQsfdHRN+UP7j2rm8lNsfIAnULi+kRdYmXNy7SzyfswBr
         PZsOpaIScskFFS5NeiZVEeWVUcyN5PFupjEkREDsR9ha3JSMRDla+jaOp8ZoxtLTP75f
         6/aoNxkpQUUWvoikWa3hWjy1kfihspyKtVdeqBXk6osbUrKAwUndeUtfXAJQUexI2gP4
         OcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4g5f9CDODoOdyVCmkuDBOQYqkih3WUyishW3EnjZDH8z1wg5Vh5Otp1TWnOTmKsHOVKev+tIAlU6z96w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+Uk6RV5dYun7VWJ0GNnFJWRsMkiGT6Jd5aaFvCqYeZxGerL9
	hW7j5NF+dnbZqgvagMZAFKpBNVWezcePughj7qJ1v804roXMvJx3cLdPtLuAGyPJRIcdy5+zS1/
	XJumBnA==
X-Google-Smtp-Source: AGHT+IHRV+YnNTUs6kh7Q7NpG8hvARodfZBeKR3CohIJAv7l0VaH42fhATH5xGQ/HIF4iWzdguHHMKEDTZpl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:6303:b0:6fb:afe0:f186 with SMTP
 id 00721157ae682-6fd49fa7cefmr4574187b3.2.1740781456425; Fri, 28 Feb 2025
 14:24:16 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:08 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 11/11] perf python tracepoint: Switch to using parse_events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rather than manually configuring an evsel, switch to using
parse_events for greater commonality with the rest of the perf code.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/tracepoint.py | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index bba68a6d4515..38b2b6d11f64 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -5,24 +5,23 @@
 
 import perf
 
-class tracepoint(perf.evsel):
-    def __init__(self, sys, name):
-        config = perf.tracepoint(sys, name)
-        perf.evsel.__init__(self,
-                            type   = perf.TYPE_TRACEPOINT,
-                            config = config,
-                            freq = 0, sample_period = 1, wakeup_events = 1,
-                            sample_type = perf.SAMPLE_PERIOD | perf.SAMPLE_TID | perf.SAMPLE_CPU | perf.SAMPLE_RAW | perf.SAMPLE_TIME)
-
 def main():
-    tp      = tracepoint("sched", "sched_switch")
     cpus    = perf.cpu_map()
     threads = perf.thread_map(-1)
+    evlist = perf.parse_events("sched:sched_switch", cpus, threads)
+    # Disable tracking of mmaps and similar that are unnecessary.
+    for ev in evlist:
+        ev.tracking = False
+    # Configure evsels with default record options.
+    evlist.config()
+    # Simplify the sample_type and read_format of evsels
+    for ev in evlist:
+        ev.sample_type = ev.sample_type & ~perf.SAMPLE_IP
+        ev.read_format = 0
 
-    evlist = perf.evlist(cpus, threads)
-    evlist.add(tp)
     evlist.open()
     evlist.mmap()
+    evlist.enable();
 
     while True:
         evlist.poll(timeout = -1)
-- 
2.48.1.711.g2feabab25a-goog


