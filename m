Return-Path: <linux-kernel+bounces-513970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE8A350DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0661890F15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A81626E14C;
	Thu, 13 Feb 2025 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IWNdUMrh"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5802698B2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484233; cv=none; b=ciXWAz78eHn6qi3yR8vT4n7GLtBuADhTOviBLOv1+TfY9jOw7nHr4LQNRbbedG+UgSE64qk7+jsSbvF9Q5YcfXMFeg5ToFKjfEyhgWYlCPdKayI41paLLQYEFJ7A5cvtvjOM33nsDxe7/36fuvZfKDobBGrrvPIHP4bhLeBz69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484233; c=relaxed/simple;
	bh=bUCkjPsIRjGp3Sm7BYtOAbfz5ZKlANVWbKSMN2fuR5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR2VsGPWh48qW4JfnfuyJKQRn6nSjbEnYj/13Za1SzvvVLS7GK3rFWi77rHE/h1Zp6VoxGBFxfqeXlU807tMrExa75BdKVkv1r/CDVKYodaBIOLu/qp7U4GOkkZ0gBfh4i10P6aD12dsaQ2IofK3mvkRGrQCn3n7OFvOVjtWkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IWNdUMrh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f61b01630so40787425ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739484231; x=1740089031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpwIO49GNbtoyWqWXl7vLneMjnaxCqv/Wwmz/9PWqJA=;
        b=IWNdUMrh4hlhrd5hDjPWRSC7d9jLX9ntK+r5KtzS+LlH/mIs+aiY1G8m5ZYuePAH+V
         yd/7EQ29YPJ30bBApyp5nAd0jQ19qklNiqkOcxHc9dDegvv9gqWiXLJp4RfeFPLWfgHb
         C72gnhE7KxI0j13CxwLqGI9IgG+IhRRkgz71lw3kvzea/AR03AEotBMZlH7XoLsnqFPH
         orq2H3Xx+bwLQBrenfYK4dv5pBMtFaTVZb5qL9sRTDq7bHqxQhGA1kCu7qJxm4Rw0iYU
         AdT1dNmGN1MTT+cRGLqM5s0N4/FN8vf4aPrLjXsZ1q23hGdJiEO1HB1GXUX7lfbMmAVc
         nRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484231; x=1740089031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpwIO49GNbtoyWqWXl7vLneMjnaxCqv/Wwmz/9PWqJA=;
        b=qbHMvbrkzPjXRD4vmGo4dE2swxL83NvxyWMMtaNzrFF4/kWXc1ePC1Dh4UduOJfi6n
         q47eCzZHOfFe19hLGl+S/WBOCqNShcxZHFpCvG6T6GrwUpoNseNb75lCoAV3JaB4Sofz
         c2e8vdc/AR/haxfSWJPoTfd6J/2HCjaQt03Av361Pljug3hGEfwWA0M2ILQbmdelcjPF
         eHwiwjlBTpf/MU6fuPPVsUq8gI3kSz52a+kGcbaY7fNoQAaXDGUQEbENgpDCiyOwDWPw
         4+XE4Ttx9CxJ2u9C40QQ6aNk+rzeUgUDFFrMGawhkG5pTyc5RGVF8nUJpUqXbl49rjtq
         ZRYA==
X-Forwarded-Encrypted: i=1; AJvYcCVycIlVIbn09pSEsXWYFeWSj1ytzFY/ofjF47u3nDvjDlQQTuijY+imXO9561CnOUeBVuXooDfZz233hQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFu9f5HxS0ijiskuIl8gTzXIqv6u+YIJZzzBbBz+kkhm3cm1ka
	0WXr8n9BZ6S29PwS4egfOP88ysHawBIF1XylN0R7pmT9IZ0yWKxya5zM7gt3rEw=
X-Gm-Gg: ASbGncsdqgLga5HG9aBhWX1dS/xMt14iGhBvHVJ7hdDMtDti7uK7nbm7kijpyFTkFO7
	G3H6+POddcTeYqpu5vLaJQ23MJgLcLfTJmsCRQIfiPfol2A/QHJ8+K8KUD/gUT3P0Hcq8LgONqW
	9up1QnOfdexBG5Yq2BLRdw7VyAOO/XOGqioNeaUTAaIfAIq2wKvBv5ssXvX+7BuvcUcslGYxFGp
	X2+Kcib1+QyAIUMDm6GNk7lMsK7SIferdrxBIJTbXAN7O/S09JVzKE9pqRIDvsXdZs3OZweINxZ
	BaIYAsUw/EUP7OFnNv9KFHTpz/+MxZmK9qNGMw==
X-Google-Smtp-Source: AGHT+IHyp5GPdiF4nIYOwtKcjQEfdkn2i33PogWXmBC+DOooDH454z3E0beNUeVSYbV2PZWSHNiXZw==
X-Received: by 2002:a05:6a00:2d82:b0:725:4915:c10 with SMTP id d2e1a72fcca58-7323c76e38fmr8546927b3a.10.1739484230699;
        Thu, 13 Feb 2025 14:03:50 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e438sm1847491b3a.94.2025.02.13.14.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:03:50 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Eric Lin <eric.lin@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RESEND PATCH 5/7] perf vendor events riscv: Add SiFive Bullet version 0x0d events
Date: Wed, 12 Feb 2025 17:21:38 -0800
Message-ID: <20250213220341.3215660-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250213220341.3215660-1-samuel.holland@sifive.com>
References: <20250213220341.3215660-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Lin <eric.lin@sifive.com>

SiFive Bullet microarchitecture cores with mimpid values starting with
0x0d or greater add new PMU events to count TLB miss stall cycles.

All other PMU events are unchanged from earlier Bullet cores.

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../cycle-and-instruction-count.json          |  1 +
 .../arch/riscv/sifive/bullet-0d/firmware.json |  1 +
 .../riscv/sifive/bullet-0d/instruction.json   |  1 +
 .../arch/riscv/sifive/bullet-0d/memory.json   |  1 +
 .../riscv/sifive/bullet-0d/microarch.json     | 72 +++++++++++++++++++
 .../riscv/sifive/bullet-0d/watchpoint.json    |  1 +
 7 files changed, 78 insertions(+)
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 8706d289215e..9e9bd7ac0ebe 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -16,6 +16,7 @@
 #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/bullet,core
 0x489-0x8000000000000[1-9a-e]07-0x[78ac][[:xdigit:]]+,v1,sifive/bullet-07,core
+0x489-0x8000000000000[1-9a-e]07-0xd[[:xdigit:]]+,v1,sifive/bullet-0d,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
new file mode 120000
index 000000000000..ccd29278f61b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
@@ -0,0 +1 @@
+../bullet-07/cycle-and-instruction-count.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
new file mode 120000
index 000000000000..34e5c2870eee
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
@@ -0,0 +1 @@
+../bullet/firmware.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
new file mode 120000
index 000000000000..62eacc2d7497
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
@@ -0,0 +1 @@
+../bullet/instruction.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
new file mode 120000
index 000000000000..df50fc47a5fe
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
@@ -0,0 +1 @@
+../bullet/memory.json
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
new file mode 100644
index 000000000000..6573b24788eb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
@@ -0,0 +1,72 @@
+[
+  {
+    "EventName": "ADDRESSGEN_INTERLOCK",
+    "EventCode": "0x101",
+    "BriefDescription": "Counts cycles with an address-generation interlock"
+  },
+  {
+    "EventName": "LONGLATENCY_INTERLOCK",
+    "EventCode": "0x201",
+    "BriefDescription": "Counts cycles with a long-latency interlock"
+  },
+  {
+    "EventName": "CSR_INTERLOCK",
+    "EventCode": "0x401",
+    "BriefDescription": "Counts cycles with a CSR interlock"
+  },
+  {
+    "EventName": "ICACHE_BLOCKED",
+    "EventCode": "0x801",
+    "BriefDescription": "Counts cycles in which the instruction cache was not able to provide an instruction"
+  },
+  {
+    "EventName": "DCACHE_BLOCKED",
+    "EventCode": "0x1001",
+    "BriefDescription": "Counts cycles in which the data cache blocked an instruction"
+  },
+  {
+    "EventName": "BRANCH_DIRECTION_MISPREDICTION",
+    "EventCode": "0x2001",
+    "BriefDescription": "Counts mispredictions of conditional branch direction (taken/not taken)"
+  },
+  {
+    "EventName": "BRANCH_TARGET_MISPREDICTION",
+    "EventCode": "0x4001",
+    "BriefDescription": "Counts mispredictions of the target PC of control-flow instructions"
+  },
+  {
+    "EventName": "PIPELINE_FLUSH",
+    "EventCode": "0x8001",
+    "BriefDescription": "Counts flushes of the core pipeline. Common causes include fence.i and CSR accesses"
+  },
+  {
+    "EventName": "REPLAY",
+    "EventCode": "0x10001",
+    "BriefDescription": "Counts instruction replays"
+  },
+  {
+    "EventName": "INTEGER_MUL_DIV_INTERLOCK",
+    "EventCode": "0x20001",
+    "BriefDescription": "Counts cycles with a multiply or divide interlock"
+  },
+  {
+    "EventName": "FP_INTERLOCK",
+    "EventCode": "0x40001",
+    "BriefDescription": "Counts cycles with a floating-point interlock"
+  },
+  {
+    "EventName": "TRACE_STALL",
+    "EventCode": "0x80001",
+    "BriefDescription": "Counts cycles in which the core pipeline is stalled due to backpressure from the Trace Encoder"
+  },
+  {
+    "EventName": "ITLB_MISS_STALL",
+    "EventCode": "0x100001",
+    "BriefDescription": "Counts cycles in which the core pipeline is stalled due to ITLB Miss"
+  },
+  {
+    "EventName": "DTLB_MISS_STALL",
+    "EventCode": "0x200001",
+    "BriefDescription": "Counts cycles in which the core pipeline is stalled due to DTLB Miss"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json
new file mode 120000
index 000000000000..e88b98bfc5c8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json
@@ -0,0 +1 @@
+../bullet-07/watchpoint.json
\ No newline at end of file
-- 
2.47.0


