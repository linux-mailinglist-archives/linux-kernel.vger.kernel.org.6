Return-Path: <linux-kernel+bounces-340864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE10987887
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680541F23BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C596186287;
	Thu, 26 Sep 2024 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYxp/KWt"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCA185B63
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372499; cv=none; b=XXoRKvpEUjxRYXB/o6vYUZ8SL25n1Yz7KgzmtM2c+78yKh8Xq/OdRF85kK4aGZwJG2w5YzDMlYwuUXPem68Nmgr1ZRB6BSwjARDlXCoXpCl1jZaIt5TKxmBlogF2LEGbf8EBbU7ZOYA/76pt2lajAg2+O72wM4NS9m/l4EKnQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372499; c=relaxed/simple;
	bh=HbYzvLuYsseA2874qSaA2XOQKpO6t49BfofOqxj0Fp8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Pt2VoVZSXObQtiPbFR966XneMzXPTkfVZ9ObrUFNMZt212eUPXJSChX0nk6f6K7tJmio7EgkqHHdhb8a2xMTQr/LD0414F75kMLqH2gGewkpojipKrW78N4c6SKqlCIBAV/FZYBnw3mqYUtRJWsuVPMJo3dpHsVQJlF9frM6IMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYxp/KWt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb161fso1891351276.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372497; x=1727977297; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vztDkA1b6fMQPPkmuqvV2cGZZRqOfqcurU8xn4X9/5Y=;
        b=pYxp/KWtgUh6K+tDqwQZUSCo+fTzqQ68w6Y8B/LI0fpYr+rYd6EhmsW1g/TpQlSOBk
         uQzIhFcjeOMGwYQVHWLAo5EJth8k44pw3Wxnb7YIAF3AW4t8TRkFQSQ577BKvNOHfg18
         JBwaLvnZPBox36//+ssDX2CdRMnCVVgjh6No6sByxCCGM3cJF+g+t/BOuTS39PHEMu22
         Fd66wZolMMfUIoiDnMj1xTzwPldCRLQhdBh8iNNDnRUYvmUJ6QjhXSejy+lUzUaYORWt
         8Tz8Wg+XbNu9EEA5pzU32sEL3DC0G8PsXn9IUiNsX0XXDMo33HOsrAa8MEqkx1u7FcIm
         JBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372497; x=1727977297;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vztDkA1b6fMQPPkmuqvV2cGZZRqOfqcurU8xn4X9/5Y=;
        b=s/JfeZkoVvErr9Ti60QohNq4eGht7HItwC/n998ZNjkwr7MaQC1Q3KW42qB4QQox5J
         ZkHpQDd4yGO+GOVwtswqnyE8Ikql0EL8WoF93G2cqrjCdBXO56bCRaIvixqt27vCajlo
         6WCyLr04eyXQCqGiOakZKPa7sWALnKlc/CxuXzqdtVWPxZFhTwnZI8wbDEZBUKr+/kg7
         QV4Uc0t/uHYmmGDNxCDKkjrcSpjAkMC+IKUzvzDRFhLaueFVhK2f8orc6+MUOzJ/4jeq
         57Um3u1TphYBrC0yl9uDWrun8wF9XFXstQP5ntz80IIuQRxiz34caaanu2sjB2e50QDS
         LXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9sPDkoYCSe4YT9EtYKAkJtFN8oaQke+tOAGEAmPlBfHvU0UKjICzlVJd+PDwozNQ2FH144qUvZ8kNKxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFnK9n1t47WzPzQWLfgEIxpjp02f11I0XdSVliLpLxHmZfMgKm
	UC3j2DNAvESDlyYroX98+sU96V+UPnlU2j0mX+TYcvNPuQzuDkcmGMOcyS1Kq/GfdLOclNtQUxn
	HtjdtMQ==
X-Google-Smtp-Source: AGHT+IG2l5Wiyl4xs/zHJlkJNliUa2mF2TeajB656ncgLowFzdt762/OAPpl5ayyTneYKB+7oqzPysmvaGDH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a5b:b4f:0:b0:e22:5fcb:5e22 with SMTP id
 3f1490d57ef6-e2604b28574mr172276.3.1727372497446; Thu, 26 Sep 2024 10:41:37
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:41:01 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 12/12] perf jevents: Add context switch metrics for AMD
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 157fa4fa3d62..422b119553ff 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,37 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
+  cs = Event("context\-switches")
+  metrics = [
+      Metric("cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  ev = Event("ls_dispatch.ld_dispatch")
+  metrics.append(Metric("cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+
+  ev = Event("ls_dispatch.store_dispatch")
+  metrics.append(Metric("cs_stores", "Stores per context switch",
+                        d_ratio(ev, cs), "stores/cs"))
+
+  ev = Event("ex_ret_brn_tkn")
+  metrics.append(Metric("cs_br_taken", "Branches taken per context switch",
+                        d_ratio(ev, cs), "br_taken/cs"))
+
+  return MetricGroup("cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def AmdIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -613,6 +644,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdCtxSw(),
       AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
-- 
2.46.1.824.gd892dcdcdd-goog


