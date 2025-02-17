Return-Path: <linux-kernel+bounces-510065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CABA317BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E393A17F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C6267B0F;
	Tue, 11 Feb 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vh7o4DT6"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595C4267AFB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309462; cv=none; b=dBHwTM5NLfmqSfGwQiDw54V1Da0qauLCiMP56GRm77qvLXGoVyKF/11u0S9TAS2KWO6rnYJUK/QAGmowxLX9hg5fPyazzFG/HOf04e9eb4LznSCX2IZKFULNZ3fX/gaSv23NbBgrWl39koDm+mekOXSITP/9aghwAzkHP8N1dfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309462; c=relaxed/simple;
	bh=wWN22//RSBLmbfzccbt69hGRAK97jH6kIt6lEzL1Ef8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JSiWbpZ33CKkek54S+lVC0KEFAptrzh17l8riUCoVIbIUuy4HvHyBG33JY8A8L0IsZV+qvNHQA8xmowCXmCIYz+5Gh9t1QofmVzYluUDrFZ2z/s/plqVpncMZIwx2Vo5uy12UjJMN7f9IbJP01bNJhuFmWI8jjrHsuSr6n3HXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vh7o4DT6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5b2c00f76bso329187276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 13:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739309458; x=1739914258; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poaOrjqROlOxSLBeynyYX46ZQt3WXrqG/Y2chdx8MCQ=;
        b=vh7o4DT6tUrIiHAOtQD91zoWlq4wv5CVJxYZ9lOXkWQJNWjYpLYJ/KG+j9UQ9nGUhL
         Ct0EZS7t+dzSBxff6mRf/bZ1w88wW3l5vKXypXG6uAA2jjZjOT4CdcKO+/tXuDJb0MMy
         8IQ6vP6GGwiqWoOTTyTN/EX21ka871GwwdkVOcuNZmLPgojeYDCEc1gsP05xIqe6+/mt
         SV8YpS0sk4qaLWrvNn0/Wj6Vb8E5QMDYL6U2ACSV5EXGGxUg0IGofdErEBKnZjZi0fLs
         R84G27fReqGp8VM/1RTbpMLEvcWuLq5l3xFp5j/iTua8Fs1gLHnqIytMyTIgDc2Lur4W
         ii7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739309458; x=1739914258;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=poaOrjqROlOxSLBeynyYX46ZQt3WXrqG/Y2chdx8MCQ=;
        b=DhoJwfVKEhqYPSs6eeMJaA/xf5laUsK0ZWXt47ml18wBRK7FG/UHaztmZXmkIPPp1d
         stgT0PxmWPIdqn/Iy+E40rex+kWYt/zCxf7ufvT78cD75siLcoe8/NoNAZhOHgRO867v
         n7X4KP3ioEVPPcBki05ZMyqmiYxNhLXoFyfDSOki19B/I+GElf3C47JwP2MY9cV/B1hw
         nRSzGW6Fxx6kDK0GFqYYDWiTOyB9qY1SwkF9kSuYYeUUyVaHs+TfWUFZlaHy/oec/jss
         ibhUzgjiIMy24VVS0UK3dxda/PoebxarxLpyl3fuhVpeE0rdBbkMICrtG8635wv3PP97
         cJXA==
X-Forwarded-Encrypted: i=1; AJvYcCXrrcstZQmLgfpVlgTC1/EejqFARcs9nces80qV1YBlBu+g+ULFvjlBdIsh6bvfI0K4bDGxdEcP87lTLAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyBH84JHpe+4WQpocSGaDNcd8Cou3MeeEzlL/4TAAid7FfEFXe
	hA+06fk/rIUyvAG22akbbJaD9ho68Lmlq7VdtR1N05hpgNk/CaEFM9+LsKzyxjteDxYiU1E0RIU
	ANgQoQA==
X-Google-Smtp-Source: AGHT+IFjzOoehPoMQunCKVlHej7U5PGuJgemvZ3w+yiIOAvg+NmEQ6KSsn5hORVU4VO/iemvDG7eKR0cgPxV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a24c:c86a:18a9:d15b])
 (user=irogers job=sendgmr) by 2002:a05:6902:27c2:b0:e5b:3ddb:3e29 with SMTP
 id 3f1490d57ef6-e5d9f7efe47mr5981276.6.1739309458226; Tue, 11 Feb 2025
 13:30:58 -0800 (PST)
Date: Tue, 11 Feb 2025 13:30:15 -0800
In-Reply-To: <20250211213031.114209-1-irogers@google.com>
Message-Id: <20250211213031.114209-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211213031.114209-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v8 08/24] perf vendor events: Add Clearwaterforest events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add events v1.00.

Bring in the events from:
https://github.com/intel/perfmon/tree/main/CWF/events

Co-developed-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Caleb Biggers <caleb.biggers@intel.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/clearwaterforest/cache.json      | 144 ++++++++++++++++++
 .../arch/x86/clearwaterforest/counter.json    |   7 +
 .../arch/x86/clearwaterforest/frontend.json   |  18 +++
 .../arch/x86/clearwaterforest/memory.json     |  22 +++
 .../arch/x86/clearwaterforest/other.json      |  22 +++
 .../arch/x86/clearwaterforest/pipeline.json   | 113 ++++++++++++++
 .../x86/clearwaterforest/virtual-memory.json  |  29 ++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
 8 files changed, 356 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/cache.j=
son
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/counter=
.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/fronten=
d.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/memory.=
json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.j=
son
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/pipelin=
e.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/virtual=
-memory.json

diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json b/t=
ools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
new file mode 100644
index 000000000000..875361b30f1d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
@@ -0,0 +1,144 @@
+[
+    {
+        "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 core has access to an L3 cache, the LLC is the L3 cache, otherwise it is t=
he L2 cache. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
core has access to an L3 cache, the LLC is the L3 cache, otherwise it is th=
e L2 cache. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4f"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81"
+    },
+    {
+        "BriefDescription": "Counts the number of store ops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x80",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x10",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x100",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x20",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x4",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x200",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x40",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x8",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/counter.json b=
/tools/perf/pmu-events/arch/x86/clearwaterforest/counter.json
new file mode 100644
index 000000000000..a0eaf5b6f2bc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/counter.json
@@ -0,0 +1,7 @@
+[
+    {
+        "Unit": "core",
+        "CountersNumFixed": "3",
+        "CountersNumGeneric": "39"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/frontend.json =
b/tools/perf/pmu-events/arch/x86/clearwaterforest/frontend.json
new file mode 100644
index 000000000000..7a9250e5c8f2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/frontend.json
@@ -0,0 +1,18 @@
+[
+    {
+        "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.ACCESSES",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump and the instruction cache registers bytes are not present=
. -",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.MISSES",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json b/=
tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
new file mode 100644
index 000000000000..f5007e56f39b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
@@ -0,0 +1,22 @@
+[
+    {
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x33FBFC00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x33FBFC00002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json b/t=
ools/perf/pmu-events/arch/x86/clearwaterforest/other.json
new file mode 100644
index 000000000000..80454e497f83
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
@@ -0,0 +1,22 @@
+[
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json =
b/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
new file mode 100644
index 000000000000..6a5faa704b85
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
@@ -0,0 +1,113 @@
+[
+    {
+        "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.CORE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es. [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles.",
+        "Counter": "Fixed counter 2",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es. [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired.",
+        "Counter": "Fixed counter 0",
+        "EventName": "INST_RETIRED.ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of issue slo=
ts that were not consumed by the backend because allocation is stalled due =
to a mispredicted jump or a machine clear.",
+        "Counter": "36",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls. [This event is alias to TOPDOWN_BE_BOUND.ALL_P=
]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN_BE_BOUND.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls. [This event is alias to TOPDOWN_BE_BOUND.ALL]"=
,
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN_BE_BOUND.ALL_P",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of retiremen=
t slots not consumed due to front end stalls.",
+        "Counter": "37",
+        "EventName": "TOPDOWN_FE_BOUND.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.",
+        "Counter": "38",
+        "EventName": "TOPDOWN_RETIRING.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/virtual-memory=
.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/virtual-memory.json
new file mode 100644
index 000000000000..78f2b835c1fa
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/virtual-memory.json
@@ -0,0 +1,29 @@
+[
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to any page size.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to any page si=
ze. Includes page walks that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to any page size.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to any page size.  Includes page walks =
that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index a1a3a8c1af02..68c33fa7328a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -7,6 +7,7 @@ GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
 GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.23,cascadelakex,core
+GenuineIntel-6-DD,v1.00,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.09,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
--=20
2.48.1.502.g6dc24dfdaf-goog


