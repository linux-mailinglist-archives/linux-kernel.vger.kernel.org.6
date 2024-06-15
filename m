Return-Path: <linux-kernel+bounces-215558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BE2909473
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89321C21597
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB72F18FC6B;
	Fri, 14 Jun 2024 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3aogBJvQ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8C1487D1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406214; cv=none; b=YHBVdP2LwsWOEXt5dUlTzm+05gt2yrn7DKdqt6PeDWV6PUkpQvvlTEd9o0Z0pMYia4YVyAMc5HDXGNibBrK/jnW4dZP23wEKwUWaFYRowxu+38wg8sJlX/b7PMCIicWbz28IUQfx6NtN/ij3BytFA118ApKccMfufW0we66Gmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406214; c=relaxed/simple;
	bh=ieB17I1MT2rgUrcudExa0rhgLac2+ZrCC4GBJDqdYm4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=A+x7aP5yoa2m2M8U19S6dUCO+7DnukGQjgsOVvscLy8hUTwOKOCBV5y4aPiuXf04NBxPngLl7nljFDbmRv5EwiPFcSFhvk2Rt65arrVb31FAo8idokL0Sqio0xYnlEwTuIuqpJMoBuqnetOm9cJcr17IrXKU2lUBmmpZunfrWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3aogBJvQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-631d53af5e1so32001477b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718406199; x=1719010999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4gNY5UyGShmTBmm0ScMrES30qo2Da9Za/Hbei9E4N0=;
        b=3aogBJvQ/QWjRYLz/TzFSXdGJPzgk3ArV0vzVd3qbV86JjQ0j70XjEPRztIjpVh8b/
         ETBNXg7TRJEqJlKYj49une2ywcwIeBoXzq2fHFBvHyHwc0YBSS0fd9F6rgOcYUuLBDaZ
         vTjOJWuFRubks97kYStviehSn2oH7XYTXVsrlNVERmnd20MqfHjgsCYgQ1JH2rovKd1T
         X5mKPN1msGu9VvwVOAFu0Mm42QppBH53NeItDNB/0Q0Dkk8TpnNZiLtBZUfuJeUF1mB8
         Le1+inoP+w0aF0HEwfMhXkN3xdg6Yeq/rikmmWIOcvATOU+B+j3hqacRp15lNS6Rq21N
         tOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406199; x=1719010999;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4gNY5UyGShmTBmm0ScMrES30qo2Da9Za/Hbei9E4N0=;
        b=FV8PW9pBdRCMoE9Zh8UhjYr5LAVXThj/bZDkk9mZCTy1N4IUslLz9heEuCl32b/i4q
         BSLTjkhklOH7bz/6zH4v3YwLqPWQMmDBjMvo7fG6fW7pcZ9k7ywquEitfwYga+7XeetG
         p0283HZzwEYH8BTGiWFQmdVatTdCGw4uKA5/9c/upuKSmk73Wk6Njf+gm+M85OVHlGs8
         tsptY9XZ05NAKe6W+o9dCsKLY14fKQtm+L9Upe9Vg9Fq9Yw9lhbkvCX+DV9pcdduxZiu
         4xRsW/cIe4PDuxgFr7QRPrxB+mgxDlqr3ordjWp4H0js+D059yF7drM256jfxfLjpxKN
         EaOA==
X-Forwarded-Encrypted: i=1; AJvYcCUrbAh9bT8q6Wdm1FpQOtdtbKXLF7cnECQ/lPkiKhBc0f/Cc60gFoYEmphkqgQSzwzbHr241NHxRnaowAMLw9tU8gmw2zIoe138OcWH
X-Gm-Message-State: AOJu0YwOFvomhnEnrFdbZxFidpx6P6WtG32GiZeR39H0OKGn1NYB89UG
	d2TiPC5oq76cQLYRiIX/JEtKpCDFF/HDJn0JEMz5l+VraPbTaqbtC9xWsQd6Se/MZlcYR9B4vUX
	5cIyOfg==
X-Google-Smtp-Source: AGHT+IEhEmNU9Z1WaNQJRf7IxikBDHN26QLTtu7zvhCcrs8uLHc3OpxmIHBKKp6qIRTfnfq7jF6r4Q9JfQlF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:714a:5e65:12a1:603])
 (user=irogers job=sendgmr) by 2002:a05:690c:fc7:b0:62d:cef:67dd with SMTP id
 00721157ae682-632220709b0mr11661607b3.1.1718406199128; Fri, 14 Jun 2024
 16:03:19 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:01:22 -0700
In-Reply-To: <20240614230146.3783221-1-irogers@google.com>
Message-Id: <20240614230146.3783221-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614230146.3783221-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v1 14/37] perf vendor events: Add haswell counter information
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Weilin Wang <weilin.wang@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add counter information necessary for optimizing event grouping the
perf tool.

The most recent RFC patch set using this information:
https://lore.kernel.org/lkml/20240412210756.309828-1-weilin.wang@intel.com/

The information was added in:
https://github.com/intel/perfmon/commit/475892a9690cb048949e593fe39cee65cd4=
765e1
and later patches.

Co-authored-by: Weilin Wang <weilin.wang@intel.com>
Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/haswell/cache.json    |  94 +++++++++++++
 .../pmu-events/arch/x86/haswell/counter.json  |  22 +++
 .../arch/x86/haswell/floating-point.json      |  10 ++
 .../pmu-events/arch/x86/haswell/frontend.json |  29 ++++
 .../arch/x86/haswell/hsw-metrics.json         |  66 +++++----
 .../pmu-events/arch/x86/haswell/memory.json   |  60 ++++++++
 .../arch/x86/haswell/metricgroups.json        |  11 ++
 .../pmu-events/arch/x86/haswell/other.json    |   4 +
 .../pmu-events/arch/x86/haswell/pipeline.json | 130 ++++++++++++++++++
 .../arch/x86/haswell/uncore-cache.json        |  33 +++++
 .../arch/x86/haswell/uncore-interconnect.json |   6 +
 .../arch/x86/haswell/uncore-other.json        |   1 +
 .../arch/x86/haswell/virtual-memory.json      |  49 +++++++
 13 files changed, 485 insertions(+), 30 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/counter.json

diff --git a/tools/perf/pmu-events/arch/x86/haswell/cache.json b/tools/perf=
/pmu-events/arch/x86/haswell/cache.json
index 0831f14b3cc6..29b408d036c2 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "L1D data line replacements",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
         "PublicDescription": "This event counts when new data lines are br=
ought into the L1 Data cache, which cause other lines to be evicted from th=
e cache.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers unavailability.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "L1D miss outstanding duration in cycles",
+        "Counter": "2",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "PublicDescription": "Increments the number of outstanding L1D mis=
ses every cycle. Set Cmask =3D 1 and Edge =3D1 to count occurrences.",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Cycles with L1D load Misses outstanding.",
+        "Counter": "2",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
@@ -34,6 +38,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles with L1D load Misses outstanding from =
any thread on physical core.",
+        "Counter": "2",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES_ANY",
@@ -42,6 +47,7 @@
     },
     {
         "BriefDescription": "Number of times a request needed a FB entry b=
ut there was no entry available for it. That is the FB unavailability was d=
ominant reason for blocking the request. A request includes cacheable/uncac=
heable demands that is load, store or SW prefetch. HWP are e.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.REQUEST_FB_FULL",
         "SampleAfterValue": "2000003",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Not rejected writebacks that hit L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_DEMAND_RQSTS.WB_HIT",
         "PublicDescription": "Not rejected writebacks that hit L2 cache.",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "L2 cache lines filling L2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ALL",
         "PublicDescription": "This event counts the number of L2 cache lin=
es brought into the L2 cache.  Lines are filled into the L2 cache when ther=
e was an L2 miss.",
@@ -65,6 +73,7 @@
     },
     {
         "BriefDescription": "L2 cache lines in E state filling L2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.E",
         "PublicDescription": "L2 cache lines in E state filling L2.",
@@ -73,6 +82,7 @@
     },
     {
         "BriefDescription": "L2 cache lines in I state filling L2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.I",
         "PublicDescription": "L2 cache lines in I state filling L2.",
@@ -81,6 +91,7 @@
     },
     {
         "BriefDescription": "L2 cache lines in S state filling L2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.S",
         "PublicDescription": "L2 cache lines in S state filling L2.",
@@ -89,6 +100,7 @@
     },
     {
         "BriefDescription": "Clean L2 cache lines evicted by demand",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_CLEAN",
         "PublicDescription": "Clean L2 cache lines evicted by demand.",
@@ -97,6 +109,7 @@
     },
     {
         "BriefDescription": "Dirty L2 cache lines evicted by demand",
+        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_DIRTY",
         "PublicDescription": "Dirty L2 cache lines evicted by demand.",
@@ -105,6 +118,7 @@
     },
     {
         "BriefDescription": "L2 code requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "PublicDescription": "Counts all L2 code requests.",
@@ -113,6 +127,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests",
+        "Counter": "0,1,2,3",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
@@ -122,6 +137,7 @@
     },
     {
         "BriefDescription": "Demand requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
@@ -131,6 +147,7 @@
     },
     {
         "BriefDescription": "Demand requests to L2 cache",
+        "Counter": "0,1,2,3",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
@@ -140,6 +157,7 @@
     },
     {
         "BriefDescription": "Requests from L2 hardware prefetchers",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_PF",
         "PublicDescription": "Counts all L2 HW prefetcher requests.",
@@ -148,6 +166,7 @@
     },
     {
         "BriefDescription": "RFO requests to L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
         "PublicDescription": "Counts all L2 store RFO requests.",
@@ -156,6 +175,7 @@
     },
     {
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "PublicDescription": "Number of instruction fetches that hit the L=
2 cache.",
@@ -164,6 +184,7 @@
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
         "PublicDescription": "Number of instruction fetches that missed th=
e L2 cache.",
@@ -172,6 +193,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
+        "Counter": "0,1,2,3",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
@@ -181,6 +203,7 @@
     },
     {
         "BriefDescription": "Demand Data Read miss L2, no rejects",
+        "Counter": "0,1,2,3",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
@@ -190,6 +213,7 @@
     },
     {
         "BriefDescription": "L2 prefetch requests that hit L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.L2_PF_HIT",
         "PublicDescription": "Counts all L2 HW prefetcher requests that hi=
t L2.",
@@ -198,6 +222,7 @@
     },
     {
         "BriefDescription": "L2 prefetch requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.L2_PF_MISS",
         "PublicDescription": "Counts all L2 HW prefetcher requests that mi=
ssed L2.",
@@ -206,6 +231,7 @@
     },
     {
         "BriefDescription": "All requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
@@ -215,6 +241,7 @@
     },
     {
         "BriefDescription": "All L2 requests",
+        "Counter": "0,1,2,3",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
@@ -224,6 +251,7 @@
     },
     {
         "BriefDescription": "RFO requests that hit L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "PublicDescription": "Counts the number of store RFO requests that=
 hit the L2 cache.",
@@ -232,6 +260,7 @@
     },
     {
         "BriefDescription": "RFO requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "PublicDescription": "Counts the number of store RFO requests that=
 miss the L2 cache.",
@@ -240,6 +269,7 @@
     },
     {
         "BriefDescription": "L2 or L3 HW prefetches that access L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.ALL_PF",
         "PublicDescription": "Any MLC or L3 HW prefetch accessing L2, incl=
uding rejects.",
@@ -248,6 +278,7 @@
     },
     {
         "BriefDescription": "Transactions accessing L2 pipe",
+        "Counter": "0,1,2,3",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.ALL_REQUESTS",
         "PublicDescription": "Transactions accessing L2 pipe.",
@@ -256,6 +287,7 @@
     },
     {
         "BriefDescription": "L2 cache accesses when fetching instructions"=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.CODE_RD",
         "PublicDescription": "L2 cache accesses when fetching instructions=
.",
@@ -264,6 +296,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that access L2 cach=
e",
+        "Counter": "0,1,2,3",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.DEMAND_DATA_RD",
         "PublicDescription": "Demand data read requests that access L2 cac=
he.",
@@ -272,6 +305,7 @@
     },
     {
         "BriefDescription": "L1D writebacks that access L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.L1D_WB",
         "PublicDescription": "L1D writebacks that access L2 cache.",
@@ -280,6 +314,7 @@
     },
     {
         "BriefDescription": "L2 fill requests that access L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.L2_FILL",
         "PublicDescription": "L2 fill requests that access L2 cache.",
@@ -288,6 +323,7 @@
     },
     {
         "BriefDescription": "L2 writebacks that access L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.L2_WB",
         "PublicDescription": "L2 writebacks that access L2 cache.",
@@ -296,6 +332,7 @@
     },
     {
         "BriefDescription": "RFO requests that access L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.RFO",
         "PublicDescription": "RFO requests that access L2 cache.",
@@ -304,6 +341,7 @@
     },
     {
         "BriefDescription": "Cycles when L1D is locked",
+        "Counter": "0,1,2,3",
         "EventCode": "0x63",
         "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
         "PublicDescription": "Cycles in which the L1D is locked.",
@@ -312,6 +350,7 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests mis=
sed L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "This event counts each cache miss condition =
for references to the last level cache.",
@@ -320,6 +359,7 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests tha=
t refer to L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "This event counts requests originating from =
the core that reference a cache line in the last level cache.",
@@ -328,6 +368,7 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were L3 =
and cross-core snoop hits in on-pkg core cache.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD2",
@@ -338,6 +379,7 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were Hit=
M responses from shared L3.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD2",
@@ -348,6 +390,7 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were L3 =
hit and cross-core snoop missed in on-pkg core cache.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD2",
@@ -358,6 +401,7 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were hit=
s in L3 without snoops required.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD74, HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD2",
@@ -368,6 +412,7 @@
     },
     {
         "BriefDescription": "Data from local DRAM either Snoop not needed =
or Snoop Miss (RspI)",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD74, HSD29, HSD25, HSM30",
         "EventCode": "0xD3",
@@ -379,6 +424,7 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were loa=
d uops missed L1 but hit FB due to preceding miss to the same cache line wi=
th data not ready.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSM30",
         "EventCode": "0xD1",
@@ -389,6 +435,7 @@
     },
     {
         "BriefDescription": "Retired load uops with L1 cache hits as data =
sources.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD1",
@@ -399,6 +446,7 @@
     },
     {
         "BriefDescription": "Retired load uops misses in L1 cache as data =
sources.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSM30",
         "EventCode": "0xD1",
@@ -410,6 +458,7 @@
     },
     {
         "BriefDescription": "Retired load uops with L2 cache hits as data =
sources.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD29, HSM30",
         "EventCode": "0xD1",
@@ -420,6 +469,7 @@
     },
     {
         "BriefDescription": "Miss in mid-level (L2) cache. Excludes Unknow=
n data-source.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD1",
@@ -431,6 +481,7 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were dat=
a hits in L3 without snoops required.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD74, HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD1",
@@ -442,6 +493,7 @@
     },
     {
         "BriefDescription": "Miss in last-level (L3) cache. Excludes Unkno=
wn data-source.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD74, HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD1",
@@ -453,6 +505,7 @@
     },
     {
         "BriefDescription": "Retired load uops.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
@@ -464,6 +517,7 @@
     },
     {
         "BriefDescription": "Retired store uops.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
@@ -475,6 +529,7 @@
     },
     {
         "BriefDescription": "Retired load uops with locked access.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD29, HSM30",
         "EventCode": "0xD0",
@@ -485,6 +540,7 @@
     },
     {
         "BriefDescription": "Retired load uops that split across a cacheli=
ne boundary.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
@@ -495,6 +551,7 @@
     },
     {
         "BriefDescription": "Retired store uops that split across a cachel=
ine boundary.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
@@ -505,6 +562,7 @@
     },
     {
         "BriefDescription": "Retired load uops that miss the STLB.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
@@ -515,6 +573,7 @@
     },
     {
         "BriefDescription": "Retired store uops that miss the STLB.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
@@ -525,6 +584,7 @@
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
         "PublicDescription": "Data read requests sent to uncore (demand an=
d prefetch).",
@@ -533,6 +593,7 @@
     },
     {
         "BriefDescription": "Cacheable and noncacheable code read requests=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
         "PublicDescription": "Demand code read requests sent to uncore.",
@@ -541,6 +602,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
+        "Counter": "0,1,2,3",
         "Errata": "HSD78, HSM80",
         "EventCode": "0xb0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
@@ -550,6 +612,7 @@
     },
     {
         "BriefDescription": "Demand RFO requests including regular RFOs, l=
ocks, ItoM",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
         "PublicDescription": "Demand RFO read requests sent to uncore, inc=
luding regular RFOs, locks, ItoM.",
@@ -558,6 +621,7 @@
     },
     {
         "BriefDescription": "Offcore requests buffer cannot take more entr=
ies for this thread core.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xb2",
         "EventName": "OFFCORE_REQUESTS_BUFFER.SQ_FULL",
         "SampleAfterValue": "2000003",
@@ -565,6 +629,7 @@
     },
     {
         "BriefDescription": "Offcore outstanding cacheable Core Data Read =
transactions in SuperQueue (SQ), queue to uncore",
+        "Counter": "0,1,2,3",
         "Errata": "HSD62, HSD61, HSM63",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
@@ -574,6 +639,7 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD62, HSD61, HSM63",
         "EventCode": "0x60",
@@ -583,6 +649,7 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding Demand Data R=
ead transactions are present in SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD78, HSD62, HSD61, HSM63, HSM80",
         "EventCode": "0x60",
@@ -592,6 +659,7 @@
     },
     {
         "BriefDescription": "Offcore outstanding demand rfo reads transact=
ions in SuperQueue (SQ), queue to uncore, every cycle.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD62, HSD61, HSM63",
         "EventCode": "0x60",
@@ -601,6 +669,7 @@
     },
     {
         "BriefDescription": "Offcore outstanding code reads transactions i=
n SuperQueue (SQ), queue to uncore, every cycle",
+        "Counter": "0,1,2,3",
         "Errata": "HSD62, HSD61, HSM63",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
@@ -610,6 +679,7 @@
     },
     {
         "BriefDescription": "Offcore outstanding Demand Data Read transact=
ions in uncore queue.",
+        "Counter": "0,1,2,3",
         "Errata": "HSD78, HSD62, HSD61, HSM63, HSM80",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
@@ -619,6 +689,7 @@
     },
     {
         "BriefDescription": "Cycles with at least 6 offcore outstanding De=
mand Data Read transactions in uncore queue.",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "Errata": "HSD78, HSD62, HSD61, HSM63, HSM80",
         "EventCode": "0x60",
@@ -628,6 +699,7 @@
     },
     {
         "BriefDescription": "Offcore outstanding RFO store transactions in=
 SuperQueue (SQ), queue to uncore",
+        "Counter": "0,1,2,3",
         "Errata": "HSD62, HSD61, HSM63",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
@@ -637,6 +709,7 @@
     },
     {
         "BriefDescription": "Offcore response can be programmed only with =
a specific pair of event select and counter MSR, and with specific event co=
des and predefine mask bit value in a dedicated MSR to specify attributes o=
f the offcore transaction.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE",
         "SampleAfterValue": "100003",
@@ -644,6 +717,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch code reads hit i=
n the L3 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_HIT.HIT_OTHER_CORE_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -653,6 +727,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads hit i=
n the L3 and the snoop to one of the sibling cores hits the line in M state=
 and the line is forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.HITM_OTHER_CORE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -662,6 +737,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads hit i=
n the L3 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -671,6 +747,7 @@
     },
     {
         "BriefDescription": "hit in the L3 and the snoop to one of the sib=
ling cores hits the line in M state and the line is forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -680,6 +757,7 @@
     },
     {
         "BriefDescription": "hit in the L3 and the snoops to sibling cores=
 hit in either E/S state and the line is not forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_HIT.HIT_OTHER_CORE_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -689,6 +767,7 @@
     },
     {
         "BriefDescription": "Counts all requests hit in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_REQUESTS.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -698,6 +777,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs hit in the =
L3 and the snoop to one of the sibling cores hits the line in M state and t=
he line is forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -707,6 +787,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs hit in the =
L3 and the snoops to sibling cores hit in either E/S state and the line is =
not forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.HIT_OTHER_CORE_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
@@ -716,6 +797,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads hit in the L3 an=
d the snoop to one of the sibling cores hits the line in M state and the li=
ne is forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -725,6 +807,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads hit in the L3 an=
d the snoops to sibling cores hit in either E/S state and the line is not f=
orwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -734,6 +817,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads hit in the L3 and th=
e snoop to one of the sibling cores hits the line in M state and the line i=
s forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -743,6 +827,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads hit in the L3 and th=
e snoops to sibling cores hit in either E/S state and the line is not forwa=
rded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -752,6 +837,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs) hit in t=
he L3 and the snoop to one of the sibling cores hits the line in M state an=
d the line is forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -761,6 +847,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs) hit in t=
he L3 and the snoops to sibling cores hit in either E/S state and the line =
is not forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HIT_OTHER_CORE_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -770,6 +857,7 @@
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads hit in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -779,6 +867,7 @@
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads hit in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -788,6 +877,7 @@
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs hit in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -797,6 +887,7 @@
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads hit in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -806,6 +897,7 @@
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads hit in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -815,6 +907,7 @@
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs hit in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -824,6 +917,7 @@
     },
     {
         "BriefDescription": "Split locks in SQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0xf4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
         "SampleAfterValue": "100003",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/counter.json b/tools/pe=
rf/pmu-events/arch/x86/haswell/counter.json
new file mode 100644
index 000000000000..1be6522e2bbc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/haswell/counter.json
@@ -0,0 +1,22 @@
+[
+    {
+        "Unit": "core",
+        "CountersNumFixed": "3",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "CBOX",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "2"
+    },
+    {
+        "Unit": "ARB",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "2"
+    },
+    {
+        "Unit": "cbox_0",
+        "CountersNumFixed": 1,
+        "CountersNumGeneric": "0"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/haswell/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/haswell/floating-point.json
index 8fcc10f74ad9..a0b917306887 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Approximate counts of AVX & AVX2 256-bit inst=
ructions, including non-arithmetic instructions, loads, and stores.  May co=
unt non-AVX instructions that employ 256-bit operations, including (but not=
 necessarily limited to) rep string instructions that use 256-bit loads and=
 stores for optimized performance, XSAVE* and XRSTOR*, and operations that =
transition the x87 FPU data registers between x87 and MMX.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC6",
         "EventName": "AVX_INSTS.ALL",
         "PublicDescription": "Note that a whole rep string only counts AVX=
_INST.ALL once.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Cycles with any input/output SSE or FP assist=
",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.ANY",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Number of SIMD FP assists due to input values=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.SIMD_INPUT",
         "PublicDescription": "Number of SIMD FP assists due to input value=
s.",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Number of SIMD FP assists due to Output value=
s",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.SIMD_OUTPUT",
         "PublicDescription": "Number of SIMD FP assists due to output valu=
es.",
@@ -34,6 +38,7 @@
     },
     {
         "BriefDescription": "Number of X87 assists due to input value.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.X87_INPUT",
         "PublicDescription": "Number of X87 FP assists due to input values=
.",
@@ -42,6 +47,7 @@
     },
     {
         "BriefDescription": "Number of X87 assists due to output value.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.X87_OUTPUT",
         "PublicDescription": "Number of X87 FP assists due to output value=
s.",
@@ -50,6 +56,7 @@
     },
     {
         "BriefDescription": "Number of SIMD Move Elimination candidate uop=
s that were eliminated.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.SIMD_ELIMINATED",
         "PublicDescription": "Number of SIMD move elimination candidate uo=
ps that were eliminated.",
@@ -58,6 +65,7 @@
     },
     {
         "BriefDescription": "Number of SIMD Move Elimination candidate uop=
s that were not eliminated.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.SIMD_NOT_ELIMINATED",
         "PublicDescription": "Number of SIMD move elimination candidate uo=
ps that were not eliminated.",
@@ -66,6 +74,7 @@
     },
     {
         "BriefDescription": "Number of transitions from AVX-256 to legacy =
SSE when penalty applicable.",
+        "Counter": "0,1,2,3",
         "Errata": "HSD56, HSM57",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.AVX_TO_SSE",
@@ -74,6 +83,7 @@
     },
     {
         "BriefDescription": "Number of transitions from SSE to AVX-256 whe=
n penalty applicable.",
+        "Counter": "0,1,2,3",
         "Errata": "HSD56, HSM57",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.SSE_TO_AVX",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/frontend.json b/tools/p=
erf/pmu-events/arch/x86/haswell/frontend.json
index 73d6d681dfa7..a9f81fd17925 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/frontend.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the total number when the front end is=
 resteered, mainly when the BPU cannot provide a correct prediction and thi=
s is corrected by other branch handling mechanisms at the front end.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.ANY",
         "PublicDescription": "Number of front end re-steers due to BPU mis=
prediction.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switch tru=
e penalty cycles.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "SampleAfterValue": "2000003",
@@ -16,6 +18,7 @@
     },
     {
         "BriefDescription": "Number of Instruction Cache, Streaming Buffer=
 and Victim Cache Reads. both cacheable and noncacheable, including UC fetc=
hes.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "SampleAfterValue": "2000003",
@@ -23,6 +26,7 @@
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction-cache miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.IFDATA_STALL",
         "SampleAfterValue": "2000003",
@@ -30,6 +34,7 @@
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction-cache miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.IFETCH_STALL",
         "SampleAfterValue": "2000003",
@@ -37,6 +42,7 @@
     },
     {
         "BriefDescription": "Number of Instruction Cache, Streaming Buffer=
 and Victim Cache Misses. Includes Uncacheable accesses.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PublicDescription": "This event counts Instruction Cache (ICACHE)=
 misses.",
@@ -45,6 +51,7 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
@@ -54,6 +61,7 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_ANY_UOPS",
@@ -63,6 +71,7 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering 4 Uops",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_4_UOPS",
@@ -72,6 +81,7 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_ANY_UOPS",
@@ -81,6 +91,7 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES",
@@ -89,6 +100,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
         "PublicDescription": "Increment each cycle. # of uops delivered to=
 IDQ from DSB path. Set Cmask =3D 1 to count cycles.",
@@ -97,6 +109,7 @@
     },
     {
         "BriefDescription": "Instruction Decode Queue (IDQ) empty cycles",
+        "Counter": "0,1,2,3",
         "Errata": "HSD135",
         "EventCode": "0x79",
         "EventName": "IDQ.EMPTY",
@@ -106,6 +119,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_ALL_UOPS",
         "PublicDescription": "Number of uops delivered to IDQ from any pat=
h.",
@@ -114,6 +128,7 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from MITE path.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES",
@@ -122,6 +137,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
         "PublicDescription": "Increment each cycle # of uops delivered to =
IDQ from MITE path. Set Cmask =3D 1 to count cycles.",
@@ -130,6 +146,7 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
@@ -139,6 +156,7 @@
     },
     {
         "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequencer (MS) is busy.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
@@ -147,6 +165,7 @@
     },
     {
         "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is b=
usy.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -156,6 +175,7 @@
     },
     {
         "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequencer (MS) is busy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_UOPS",
         "PublicDescription": "Increment each cycle # of uops delivered to =
IDQ when MS_busy by DSB. Set Cmask =3D 1 to count cycles. Add Edge=3D1 to c=
ount # of delivery.",
@@ -164,6 +184,7 @@
     },
     {
         "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_MITE_UOPS",
         "PublicDescription": "Increment each cycle # of uops delivered to =
IDQ when MS_busy by MITE. Set Cmask =3D 1 to count cycles.",
@@ -172,6 +193,7 @@
     },
     {
         "BriefDescription": "Number of switches from DSB (Decode Stream Bu=
ffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -181,6 +203,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequencer (MS) is busy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "PublicDescription": "This event counts uops delivered by the Fron=
t-end with the assistance of the microcode sequencer.  Microcode assists ar=
e used for complex instructions or scenarios that can't be handled by the s=
tandard decoder.  Using other instructions, if possible, will usually impro=
ve performance.",
@@ -189,6 +212,7 @@
     },
     {
         "BriefDescription": "Uops not delivered to Resource Allocation Tab=
le (RAT) per thread when backend of the machine is not stalled",
+        "Counter": "0,1,2,3",
         "Errata": "HSD135",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
@@ -198,6 +222,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when 4 or more uops are not=
 delivered to Resource Allocation Table (RAT) when backend of the machine i=
s not stalled",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "Errata": "HSD135",
         "EventCode": "0x9C",
@@ -208,6 +233,7 @@
     },
     {
         "BriefDescription": "Counts cycles FE delivered 4 uops or Resource=
 Allocation Table (RAT) was stalling FE.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD135",
         "EventCode": "0x9C",
@@ -218,6 +244,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when 3 or more uops are not=
 delivered to Resource Allocation Table (RAT) when backend of the machine i=
s not stalled.",
+        "Counter": "0,1,2,3",
         "CounterMask": "3",
         "Errata": "HSD135",
         "EventCode": "0x9C",
@@ -227,6 +254,7 @@
     },
     {
         "BriefDescription": "Cycles with less than 2 uops delivered by the=
 front end.",
+        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "Errata": "HSD135",
         "EventCode": "0x9C",
@@ -236,6 +264,7 @@
     },
     {
         "BriefDescription": "Cycles with less than 3 uops delivered by the=
 front end.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD135",
         "EventCode": "0x9C",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tool=
s/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index 5631018ed388..b693c0b0cafe 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
@@ -90,7 +90,7 @@
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
         "MetricExpr": "66 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_thread_=
slots",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
+        "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
         "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: OTHER_ASSISTS.AN=
Y",
@@ -100,7 +100,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "BvOB;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1",
@@ -121,7 +121,7 @@
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * tma_bad_speculation",
-        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueBM",
+        "MetricGroup": "BadSpec;BrMispredicts;BvMP;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
@@ -151,7 +151,7 @@
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM * (1 =
+ MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS=
_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LO=
AD_UOPS_RETIRED.L3_MISS))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + ME=
M_LOAD_UOPS_RETIRED.L3_MISS)))) / tma_info_thread_clks",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
+        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. Re=
lated metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma=
_remote_cache",
@@ -172,7 +172,7 @@
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + =
MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UO=
PS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L=
3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD=
_UOPS_RETIRED.L3_MISS))) / tma_info_thread_clks",
-        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
+        "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
@@ -181,7 +181,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
         "MetricExpr": "10 * ARITH.DIVIDER_UOPS / tma_info_core_core_clks",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_UOPS",
@@ -218,7 +218,7 @@
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
         "MetricExpr": "(8 * DTLB_LOAD_MISSES.STLB_HIT + DTLB_LOAD_MISSES.W=
ALK_DURATION) / tma_info_thread_clks",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
+        "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
         "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_UOPS_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store",
@@ -227,7 +227,7 @@
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
         "MetricExpr": "(8 * DTLB_STORE_MISSES.STLB_HIT + DTLB_STORE_MISSES=
.WALK_DURATION) / tma_info_thread_clks",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
+        "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
         "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_UOPS_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load",
@@ -236,7 +236,7 @@
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
         "MetricExpr": "60 * OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HITM_OTHER_=
CORE / tma_info_thread_clks",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
+        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM. Related=
 metrics: tma_contested_accesses, tma_data_sharing, tma_machine_clears, tma=
_remote_cache",
@@ -246,7 +246,7 @@
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.REQUEST_FB_FULL\\,cmask\\=3D1@ / tma_info_thread_clks",
-        "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;tma_is=
sueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricGroup": "BvMS;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
         "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_ba=
ndwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
@@ -275,7 +275,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_thread_slots=
",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "BvFB;BvIO;PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
@@ -295,7 +295,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
         "MetricExpr": "ICACHE.IFDATA_STALL / tma_info_thread_clks",
-        "MetricGroup": "BigFootprint;FetchLat;IcMiss;TopdownL3;tma_L3_grou=
p;tma_fetch_latency_group",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
         "ScaleUnit": "100%"
@@ -388,12 +388,12 @@
         "MetricThreshold": "tma_info_inst_mix_ipstore < 8"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
+        "BriefDescription": "Instructions per taken branch",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
         "MetricThreshold": "tma_info_inst_mix_iptb < 9",
-        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, t=
ma_lcp"
+        "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, =
tma_lcp"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
@@ -414,7 +414,7 @@
         "MetricName": "tma_info_memory_core_l3_cache_fill_bw_2t"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw"
@@ -426,7 +426,7 @@
         "MetricName": "tma_info_memory_l1mpki"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l2_cache_fill_bw"
@@ -438,7 +438,13 @@
         "MetricName": "tma_info_memory_l2mpki"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Offcore requests (L2 cache miss) per kilo ins=
truction for demand RFOs",
+        "MetricExpr": "1e3 * OFFCORE_REQUESTS.DEMAND_RFO / INST_RETIRED.AN=
Y",
+        "MetricGroup": "CacheMisses;Offcore",
+        "MetricName": "tma_info_memory_l2mpki_rfo"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
         "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l3_cache_fill_bw"
@@ -503,13 +509,13 @@
     },
     {
         "BriefDescription": "Average CPU Utilization (percentage)",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "tma_info_system_cpus_utilized / #num_cpus_online",
         "MetricGroup": "HPC;Summary",
         "MetricName": "tma_info_system_cpu_utilization"
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "#num_cpus_online * tma_info_system_cpu_utilization"=
,
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
@@ -590,7 +596,7 @@
         "MetricThreshold": "tma_info_thread_uoppi > 1.05"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
+        "BriefDescription": "Uops per taken branch",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TA=
KEN",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
@@ -599,7 +605,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "(14 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
ION) / tma_info_thread_clks",
-        "MetricGroup": "BigFootprint;FetchLat;MemoryTLB;TopdownL3;tma_L3_g=
roup;tma_fetch_latency_group",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: ITLB_M=
ISSES.WALK_COMPLETED",
@@ -617,7 +623,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_PENDING - CYCLE_ACTIVITY=
.STALLS_L2_PENDING) / tma_info_thread_clks",
-        "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
+        "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_UOPS_RETIRED.L2_HIT_PS",
@@ -637,7 +643,7 @@
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + MEM_LOAD_=
UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIRE=
D.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RET=
IRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOPS_RET=
IRED.L3_MISS))) / tma_info_thread_clks",
-        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
+        "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related metric=
s: tma_mem_latency",
@@ -686,7 +692,7 @@
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_bad_speculation - tma_branch_mispredicts",
-        "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
+        "MetricGroup": "BadSpec;BvMS;MachineClears;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
@@ -696,7 +702,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_thread_clks",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group;tma_issueBW",
+        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_fb_full, tma_info_system_dram_bw_u=
se, tma_sq_full",
@@ -705,7 +711,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory - DRA=
M ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group;tma_issueLat",
+        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_l3_hit_latency",
@@ -861,7 +867,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
         "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / tma_info_core_core_clks",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
         "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
@@ -869,7 +875,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "BvUW;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "MetricgroupNoGroup": "TopdownL1",
@@ -898,7 +904,7 @@
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
         "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_core_clks",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueB=
W;tma_l3_bound_group",
+        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_system_dram_bw_use, tma_mem_bandwidth",
@@ -926,7 +932,7 @@
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
+        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/per=
f/pmu-events/arch/x86/haswell/memory.json
index 6ba0ea6e3fa6..edb1b5b9f553 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to any reasons (multiple categories may count as one).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED",
         "PEBS": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to various memory events (e.g., read/write capacity and conflicts).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC1",
         "SampleAfterValue": "2000003",
@@ -16,6 +18,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to uncommon conditions.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC2",
         "SampleAfterValue": "2000003",
@@ -23,6 +26,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to HLE-unfriendly instructions.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC3",
         "SampleAfterValue": "2000003",
@@ -30,6 +34,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to incompatible memory type.",
+        "Counter": "0,1,2,3",
         "Errata": "HSD65",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC4",
@@ -38,6 +43,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to none of the previous 4 categories (e.g. interrupts)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC5",
         "PublicDescription": "Number of times an HLE execution aborted due=
 to none of the previous 4 categories (e.g. interrupts).",
@@ -46,6 +52,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution successfully=
 committed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.COMMIT",
         "SampleAfterValue": "2000003",
@@ -53,6 +60,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution started.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "HLE_RETIRED.START",
         "SampleAfterValue": "2000003",
@@ -60,6 +68,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data inflight in the pipeline.  Machine clears can have a significant perfo=
rmance impact if they are happening frequently.",
@@ -68,6 +77,7 @@
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 128.",
+        "Counter": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -80,6 +90,7 @@
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 16.",
+        "Counter": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -92,6 +103,7 @@
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 256.",
+        "Counter": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -104,6 +116,7 @@
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 32.",
+        "Counter": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -116,6 +129,7 @@
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 4.",
+        "Counter": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -128,6 +142,7 @@
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 512.",
+        "Counter": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -140,6 +155,7 @@
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 64.",
+        "Counter": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -152,6 +168,7 @@
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 8.",
+        "Counter": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -164,6 +181,7 @@
     },
     {
         "BriefDescription": "Speculative cache line split load uops dispat=
ched to L1 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "MISALIGN_MEM_REF.LOADS",
         "PublicDescription": "Speculative cache-line split load uops dispa=
tched to L1D.",
@@ -172,6 +190,7 @@
     },
     {
         "BriefDescription": "Speculative cache line split STA uops dispatc=
hed to L1 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "MISALIGN_MEM_REF.STORES",
         "PublicDescription": "Speculative cache-line split store-address u=
ops dispatched to L1D.",
@@ -180,6 +199,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch code reads miss =
in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -189,6 +209,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch code reads miss =
the L3 and the data is returned from local dram",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -198,6 +219,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads miss =
in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -207,6 +229,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads miss =
the L3 and the data is returned from local dram",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -216,6 +239,7 @@
     },
     {
         "BriefDescription": "miss in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -225,6 +249,7 @@
     },
     {
         "BriefDescription": "miss the L3 and the data is returned from loc=
al dram",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -234,6 +259,7 @@
     },
     {
         "BriefDescription": "Counts all requests miss in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_REQUESTS.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -243,6 +269,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs miss in the=
 L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -252,6 +279,7 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs miss the L3=
 and the data is returned from local dram",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -261,6 +289,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads miss in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -270,6 +299,7 @@
     },
     {
         "BriefDescription": "Counts all demand code reads miss the L3 and =
the data is returned from local dram",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -279,6 +309,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads miss in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
@@ -288,6 +319,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads miss the L3 and the =
data is returned from local dram",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -297,6 +329,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs) miss in =
the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -306,6 +339,7 @@
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs) miss the=
 L3 and the data is returned from local dram",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -315,6 +349,7 @@
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads miss in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -324,6 +359,7 @@
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads miss in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -333,6 +369,7 @@
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs miss in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -342,6 +379,7 @@
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads miss in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -351,6 +389,7 @@
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads miss in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
@@ -360,6 +399,7 @@
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs miss in the L3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -369,6 +409,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to any reasons (multiple categories may count as one).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
         "PEBS": "2",
@@ -377,6 +418,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g. read/write capacity and conflicts)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC1",
         "PublicDescription": "Number of times an RTM execution aborted due=
 to various memory events (e.g. read/write capacity and conflicts).",
@@ -385,6 +427,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g., read/write capacity and conflicts).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC2",
         "SampleAfterValue": "2000003",
@@ -392,6 +435,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to HLE-unfriendly instructions.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC3",
         "SampleAfterValue": "2000003",
@@ -399,6 +443,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to incompatible memory type.",
+        "Counter": "0,1,2,3",
         "Errata": "HSD65",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC4",
@@ -407,6 +452,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 4 categories (e.g. interrupt)",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC5",
         "PublicDescription": "Number of times an RTM execution aborted due=
 to none of the previous 4 categories (e.g. interrupt).",
@@ -415,6 +461,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution successfully=
 committed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.COMMIT",
         "SampleAfterValue": "2000003",
@@ -422,6 +469,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution started.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.START",
         "SampleAfterValue": "2000003",
@@ -429,6 +477,7 @@
     },
     {
         "BriefDescription": "Counts the number of times a class of instruc=
tions that may cause a transactional abort was executed. Since this is the =
count of execution, it may not always cause a transactional abort.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC1",
         "SampleAfterValue": "2000003",
@@ -436,6 +485,7 @@
     },
     {
         "BriefDescription": "Counts the number of times a class of instruc=
tions (e.g., vzeroupper) that may cause a transactional abort was executed =
inside a transactional region.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC2",
         "SampleAfterValue": "2000003",
@@ -443,6 +493,7 @@
     },
     {
         "BriefDescription": "Counts the number of times an instruction exe=
cution caused the transactional nest count supported to be exceeded.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC3",
         "SampleAfterValue": "2000003",
@@ -450,6 +501,7 @@
     },
     {
         "BriefDescription": "Counts the number of times a XBEGIN instructi=
on was executed inside an HLE transactional region.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC4",
         "SampleAfterValue": "2000003",
@@ -457,6 +509,7 @@
     },
     {
         "BriefDescription": "Counts the number of times an HLE XACQUIRE in=
struction was executed inside an RTM transactional region.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC5",
         "SampleAfterValue": "2000003",
@@ -464,6 +517,7 @@
     },
     {
         "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data capacity limitation for transactional writes.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
         "SampleAfterValue": "2000003",
@@ -471,6 +525,7 @@
     },
     {
         "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data conflict on a transactionally accessed address.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CONFLICT",
         "SampleAfterValue": "2000003",
@@ -478,6 +533,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to XRELEASE lock not satisfying the address and value require=
ments in the elision buffer.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_MISMATCH",
         "SampleAfterValue": "2000003",
@@ -485,6 +541,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to NoAllocatedElisionBuffer being non-zero.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_NOT_EMPTY",
         "SampleAfterValue": "2000003",
@@ -492,6 +549,7 @@
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to an unsupported read alignment from the elision buffer.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_UNSUPPORTED_ALIGNMEN=
T",
         "SampleAfterValue": "2000003",
@@ -499,6 +557,7 @@
     },
     {
         "BriefDescription": "Number of times a HLE transactional region ab=
orted due to a non XRELEASE prefixed instruction writing to an elided lock =
in the elision buffer.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_STORE_TO_ELIDED_LOCK",
         "SampleAfterValue": "2000003",
@@ -506,6 +565,7 @@
     },
     {
         "BriefDescription": "Number of times HLE lock could not be elided =
due to ElisionBufferAvailable being zero.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.HLE_ELISION_BUFFER_FULL",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/metricgroups.json b/too=
ls/perf/pmu-events/arch/x86/haswell/metricgroups.json
index 8c808347f6da..4193c90c3459 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/metricgroups.json
@@ -5,7 +5,18 @@
     "BigFootprint": "Grouping from Top-down Microarchitecture Analysis Met=
rics spreadsheet",
     "BrMispredicts": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Branches": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "BvBC": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvCB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvFB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvIO": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvML": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMP": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMS": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMT": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvOB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvUW": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "CacheHits": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
+    "CacheMisses": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
     "Compute": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "Cor": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "DSB": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/other.json b/tools/perf=
/pmu-events/arch/x86/haswell/other.json
index 2395ebf112db..7d8769ef6d04 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/other.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Unhalted core cycles when the thread is in ri=
ng 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "CPL_CYCLES.RING0",
         "PublicDescription": "Unhalted core cycles when the thread is in r=
ing 0.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Number of intervals between processor halts w=
hile thread is in ring 0.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x5C",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Unhalted core cycles when thread is in rings =
1, 2, or 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "CPL_CYCLES.RING123",
         "PublicDescription": "Unhalted core cycles when the thread is not =
in ring 0.",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Cycles when L1 and L2 are locked due to UC or=
 split lock",
+        "Counter": "0,1,2,3",
         "EventCode": "0x63",
         "EventName": "LOCK_CYCLES.SPLIT_LOCK_UC_LOCK_DURATION",
         "PublicDescription": "Cycles in which the L1D and L2 are locked, d=
ue to a UC lock or split lock.",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/haswell/pipeline.json
index 540f4372623c..c00301fdb3d7 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Any uop executed by the Divider. (This includ=
es all divide uops, sqrt, ...)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "ARITH.DIVIDER_UOPS",
         "SampleAfterValue": "2000003",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Speculative and retired  branches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_BRANCHES",
         "PublicDescription": "Counts all near executed branches (not neces=
sarily retired).",
@@ -16,6 +18,7 @@
     },
     {
         "BriefDescription": "Speculative and retired macro-conditional bra=
nches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -23,6 +26,7 @@
     },
     {
         "BriefDescription": "Speculative and retired macro-unconditional b=
ranches excluding calls and indirects.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_DIRECT_JMP",
         "SampleAfterValue": "200003",
@@ -30,6 +34,7 @@
     },
     {
         "BriefDescription": "Speculative and retired direct near calls.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_DIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -37,6 +42,7 @@
     },
     {
         "BriefDescription": "Speculative and retired indirect branches exc=
luding calls and returns.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -44,6 +50,7 @@
     },
     {
         "BriefDescription": "Speculative and retired indirect return branc=
hes.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_INDIRECT_NEAR_RETURN",
         "SampleAfterValue": "200003",
@@ -51,6 +58,7 @@
     },
     {
         "BriefDescription": "Not taken macro-conditional branches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.NONTAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -58,6 +66,7 @@
     },
     {
         "BriefDescription": "Taken speculative and retired macro-condition=
al branches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -65,6 +74,7 @@
     },
     {
         "BriefDescription": "Taken speculative and retired macro-condition=
al branch instructions excluding calls and indirects.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_DIRECT_JUMP",
         "SampleAfterValue": "200003",
@@ -72,6 +82,7 @@
     },
     {
         "BriefDescription": "Taken speculative and retired direct near cal=
ls.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_DIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -79,6 +90,7 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect branch=
es excluding calls and returns.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -86,6 +98,7 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect calls.=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -93,6 +106,7 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect branch=
es with return mnemonic.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_RETURN",
         "SampleAfterValue": "200003",
@@ -100,6 +114,7 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PublicDescription": "Branch instructions at retirement.",
@@ -107,6 +122,7 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES_PEBS",
         "PEBS": "2",
@@ -115,6 +131,7 @@
     },
     {
         "BriefDescription": "Conditional branch instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -124,6 +141,7 @@
     },
     {
         "BriefDescription": "Far branch instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PublicDescription": "Number of far branches retired.",
@@ -132,6 +150,7 @@
     },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -140,6 +159,7 @@
     },
     {
         "BriefDescription": "Direct and indirect macro near call instructi=
ons retired (captured in ring 3).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL_R3",
         "PEBS": "1",
@@ -148,6 +168,7 @@
     },
     {
         "BriefDescription": "Return instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
@@ -157,6 +178,7 @@
     },
     {
         "BriefDescription": "Taken branch instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -166,6 +188,7 @@
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NOT_TAKEN",
         "PublicDescription": "Counts the number of not taken branch instru=
ctions retired.",
@@ -174,6 +197,7 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted macro co=
nditional branches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_BRANCHES",
         "PublicDescription": "Counts all near executed branches (not neces=
sarily retired).",
@@ -182,6 +206,7 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted macro co=
nditional branches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -189,6 +214,7 @@
     },
     {
         "BriefDescription": "Mispredicted indirect branches excluding call=
s and returns.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -196,6 +222,7 @@
     },
     {
         "BriefDescription": "Speculative mispredicted indirect branches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.INDIRECT",
         "PublicDescription": "Counts speculatively miss-predicted indirect=
 branches at execution time. Counts for indirect near CALL or JMP instructi=
ons (RET excluded).",
@@ -204,6 +231,7 @@
     },
     {
         "BriefDescription": "Not taken speculative and retired mispredicte=
d macro conditional branches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.NONTAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -211,6 +239,7 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted ma=
cro conditional branches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -218,6 +247,7 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct branches excluding calls and returns.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -225,6 +255,7 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct calls.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -232,6 +263,7 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct branches with return mnemonic.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_RETURN_NEAR",
         "SampleAfterValue": "200003",
@@ -239,6 +271,7 @@
     },
     {
         "BriefDescription": "All mispredicted macro branch instructions re=
tired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PublicDescription": "Mispredicted branch instructions at retireme=
nt.",
@@ -246,6 +279,7 @@
     },
     {
         "BriefDescription": "Mispredicted macro branch instructions retire=
d.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_PEBS",
         "PEBS": "2",
@@ -255,6 +289,7 @@
     },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -263,6 +298,7 @@
     },
     {
         "BriefDescription": "number of near branch instructions retired th=
at were mispredicted and taken.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -272,6 +308,7 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "100003",
@@ -279,6 +316,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the thread is unhalted =
(counts at 100 MHz rate)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK",
         "PublicDescription": "Increments at the frequency of XCLK (100 MHz=
) when not halted.",
@@ -288,6 +326,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted (counts at 100 MHz rate)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
         "PublicDescription": "Reference cycles when the at least one threa=
d on the physical core is unhalted (counts at 100 MHz rate).",
@@ -296,6 +335,7 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "100003",
@@ -303,6 +343,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cy=
cles when the core is not in a halt state. The core enters the halt state w=
hen it is running the HLT instruction or the MWAIT instruction. This event =
is not affected by core frequency changes (for example, P states, TM2 trans=
itions) but has the same incrementing frequency as the time stamp counter. =
This event can approximate elapsed time while the core was not in a halt st=
ate.",
         "SampleAfterValue": "2000003",
@@ -310,6 +351,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the thread is unhalted =
(counts at 100 MHz rate)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
         "PublicDescription": "Reference cycles when the thread is unhalted=
. (counts at 100 MHz rate)",
@@ -319,6 +361,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted (counts at 100 MHz rate)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
         "PublicDescription": "Reference cycles when the at least one threa=
d on the physical core is unhalted (counts at 100 MHz rate).",
@@ -327,6 +370,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate.",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of thread cycle=
s while the thread is not in a halt state. The thread enters the halt state=
 when it is running the HLT instruction. The core frequency may change from=
 time to time due to power or thermal throttling.",
         "SampleAfterValue": "2000003",
@@ -335,12 +379,14 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state.",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PublicDescription": "Counts the number of thread cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. The core frequency may change from time to ti=
me due to power or thermal throttling.",
@@ -349,12 +395,14 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P_ANY",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Cycles with pending L1 cache miss loads.",
+        "Counter": "2",
         "CounterMask": "8",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_PENDING",
@@ -364,6 +412,7 @@
     },
     {
         "BriefDescription": "Cycles with pending L2 cache miss loads.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD78, HSM63, HSM80",
         "EventCode": "0xa3",
@@ -374,6 +423,7 @@
     },
     {
         "BriefDescription": "Cycles with pending memory loads.",
+        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_LDM_PENDING",
@@ -383,6 +433,7 @@
     },
     {
         "BriefDescription": "This event increments by 1 for every cycle wh=
ere there was no execute for this thread.",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_NO_EXECUTE",
@@ -392,6 +443,7 @@
     },
     {
         "BriefDescription": "Execution stalls due to L1 data cache misses"=
,
+        "Counter": "2",
         "CounterMask": "12",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_PENDING",
@@ -401,6 +453,7 @@
     },
     {
         "BriefDescription": "Execution stalls due to L2 cache misses.",
+        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "Errata": "HSM63, HSM80",
         "EventCode": "0xa3",
@@ -411,6 +464,7 @@
     },
     {
         "BriefDescription": "Execution stalls due to memory subsystem.",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_LDM_PENDING",
@@ -420,6 +474,7 @@
     },
     {
         "BriefDescription": "Stall cycles because IQ is full",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.IQ_FULL",
         "PublicDescription": "Stall cycles due to IQ is full.",
@@ -428,6 +483,7 @@
     },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
         "PublicDescription": "This event counts cycles where the decoder i=
s stalled on an instruction with a length changing prefix (LCP).",
@@ -436,6 +492,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "Counter": "Fixed counter 0",
         "Errata": "HSD140, HSD143",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions=
 retired from execution. For instructions that consist of multiple micro-op=
s, this event counts the retirement of the last micro-op of the instruction=
. Counting continues during hardware interrupts, traps, and inside interrup=
t handlers. INST_RETIRED.ANY is counted by a designated fixed counter, leav=
ing the programmable counters available for other events. Faulting executio=
ns of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.=
",
@@ -444,6 +501,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er   - architectural event",
+        "Counter": "0,1,2,3",
         "Errata": "HSD11, HSD140",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
@@ -452,6 +510,7 @@
     },
     {
         "BriefDescription": "Precise instruction retired event with HW to =
reduce effect of PEBS shadow in IP distribution",
+        "Counter": "1",
         "Errata": "HSD140",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.PREC_DIST",
@@ -462,6 +521,7 @@
     },
     {
         "BriefDescription": "FP operations retired. X87 FP operations that=
 have no exceptions: Counts also flows that have several X87 or flows that =
use X87 uops in the exception handling.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.X87",
         "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts FP operations retired. For X87 FP o=
perations that have no exceptions counting also includes flows that have se=
veral X87, or flows that use X87 uops in the exception handling.",
@@ -470,6 +530,7 @@
     },
     {
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread (e.g. misprediction or me=
mory nuke)",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
@@ -480,6 +541,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for any thread running on the physical co=
re (e.g. misprediction or memory nuke)",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES_ANY",
@@ -489,6 +551,7 @@
     },
     {
         "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
         "PublicDescription": "The number of times that split load operatio=
ns are temporarily blocked because all resources for handling the split acc=
esses are in use.",
@@ -497,6 +560,7 @@
     },
     {
         "BriefDescription": "loads blocked by overlapping with store buffe=
r that cannot be forwarded",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a precedi=
ng smaller uncompleted store. The penalty for blocked store forwarding is t=
hat the load must wait for the store to write its value to the cache before=
 it can be issued.",
@@ -505,6 +569,7 @@
     },
     {
         "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x07",
         "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
         "PublicDescription": "Aliasing occurs when a load is issued after =
a store and their memory addresses are offset by 4K.  This event counts the=
 number of loads that aliased with a preceding store, resulting in an exten=
ded address check in the pipeline which can have a performance impact.",
@@ -513,6 +578,7 @@
     },
     {
         "BriefDescription": "Not software-prefetch load dispatches that hi=
t FB allocated for hardware prefetch",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PRE.HW_PF",
         "PublicDescription": "Non-SW-prefetch load dispatches that hit fil=
l buffer allocated for H/W prefetch.",
@@ -521,6 +587,7 @@
     },
     {
         "BriefDescription": "Not software-prefetch load dispatches that hi=
t FB allocated for software prefetch",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PRE.SW_PF",
         "PublicDescription": "Non-SW-prefetch load dispatches that hit fil=
l buffer allocated for S/W prefetch.",
@@ -529,6 +596,7 @@
     },
     {
         "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn'=
t come from the decoder.",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_4_UOPS",
@@ -537,6 +605,7 @@
     },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_ACTIVE",
@@ -545,6 +614,7 @@
     },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
         "PublicDescription": "Number of uops delivered by the LSD.",
@@ -553,6 +623,7 @@
     },
     {
         "BriefDescription": "Number of machine clears (nukes) of any type.=
",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xC3",
@@ -562,6 +633,7 @@
     },
     {
         "BriefDescription": "Cycles there was a Nuke. Account for both thr=
ead-specific and All Thread Nukes.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.CYCLES",
         "SampleAfterValue": "2000003",
@@ -569,6 +641,7 @@
     },
     {
         "BriefDescription": "This event counts the number of executed Inte=
l AVX masked load operations that refer to an illegal address range with th=
e mask bits set to 0.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MASKMOV",
         "SampleAfterValue": "100003",
@@ -576,6 +649,7 @@
     },
     {
         "BriefDescription": "Self-modifying code (SMC) detected.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "This event is incremented when self-modifyin=
g code (SMC) is detected, which causes a machine clear.  Machine clears can=
 have a significant performance impact if they are happening frequently.",
@@ -584,6 +658,7 @@
     },
     {
         "BriefDescription": "Number of integer Move Elimination candidate =
uops that were eliminated.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.INT_ELIMINATED",
         "PublicDescription": "Number of integer move elimination candidate=
 uops that were eliminated.",
@@ -592,6 +667,7 @@
     },
     {
         "BriefDescription": "Number of integer Move Elimination candidate =
uops that were not eliminated.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.INT_NOT_ELIMINATED",
         "PublicDescription": "Number of integer move elimination candidate=
 uops that were not eliminated.",
@@ -600,6 +676,7 @@
     },
     {
         "BriefDescription": "Number of times any microcode assist is invok=
ed by HW upon uop writeback.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.ANY_WB_ASSIST",
         "PublicDescription": "Number of microcode assists invoked by HW up=
on uop writeback.",
@@ -608,6 +685,7 @@
     },
     {
         "BriefDescription": "Resource-related stall cycles",
+        "Counter": "0,1,2,3",
         "Errata": "HSD135",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ANY",
@@ -617,6 +695,7 @@
     },
     {
         "BriefDescription": "Cycles stalled due to re-order buffer full.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ROB",
         "SampleAfterValue": "2000003",
@@ -624,6 +703,7 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no eligible RS entry av=
ailable.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.RS",
         "SampleAfterValue": "2000003",
@@ -631,6 +711,7 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.SB",
         "PublicDescription": "This event counts cycles during which no ins=
tructions were allocated because no Store Buffers (SB) were available.",
@@ -639,6 +720,7 @@
     },
     {
         "BriefDescription": "Count cases of saving new LBR",
+        "Counter": "0,1,2,3",
         "EventCode": "0xCC",
         "EventName": "ROB_MISC_EVENTS.LBR_INSERTS",
         "PublicDescription": "Count cases of saving new LBR records by har=
dware.",
@@ -647,6 +729,7 @@
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5E",
         "EventName": "RS_EVENTS.EMPTY_CYCLES",
         "PublicDescription": "This event counts cycles when the Reservatio=
n Station ( RS ) is empty for the thread. The RS is a structure that buffer=
s allocated micro-ops from the Front-end. If there are many cycles when the=
 RS is empty, it may represent an underflow of instructions delivered from =
the Front-end.",
@@ -655,6 +738,7 @@
     },
     {
         "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty. Could be useful to precisely locate Frontend Latency=
 Bound issues.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x5E",
@@ -665,6 +749,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 0.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_0",
         "SampleAfterValue": "2000003",
@@ -672,6 +757,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 1.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_1",
         "SampleAfterValue": "2000003",
@@ -679,6 +765,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 2.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_2",
         "SampleAfterValue": "2000003",
@@ -686,6 +773,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 3.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_3",
         "SampleAfterValue": "2000003",
@@ -693,6 +781,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 4.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_4",
         "SampleAfterValue": "2000003",
@@ -700,6 +789,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 5.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_5",
         "SampleAfterValue": "2000003",
@@ -707,6 +797,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 6.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_6",
         "SampleAfterValue": "2000003",
@@ -714,6 +805,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 7.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_7",
         "SampleAfterValue": "2000003",
@@ -721,6 +813,7 @@
     },
     {
         "BriefDescription": "Number of uops executed on the core.",
+        "Counter": "0,1,2,3",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE",
@@ -730,6 +823,7 @@
     },
     {
         "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xb1",
@@ -739,6 +833,7 @@
     },
     {
         "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xb1",
@@ -748,6 +843,7 @@
     },
     {
         "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3",
         "CounterMask": "3",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xb1",
@@ -757,6 +853,7 @@
     },
     {
         "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xb1",
@@ -766,6 +863,7 @@
     },
     {
         "BriefDescription": "Cycles with no micro-ops executed from any th=
read on physical core.",
+        "Counter": "0,1,2,3",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_NONE",
@@ -775,6 +873,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD144, HSD30, HSM31",
         "EventCode": "0xB1",
@@ -785,6 +884,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "Errata": "HSD144, HSD30, HSM31",
         "EventCode": "0xB1",
@@ -795,6 +895,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3",
         "CounterMask": "3",
         "Errata": "HSD144, HSD30, HSM31",
         "EventCode": "0xB1",
@@ -805,6 +906,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread.",
+        "Counter": "0,1,2,3",
         "CounterMask": "4",
         "Errata": "HSD144, HSD30, HSM31",
         "EventCode": "0xB1",
@@ -814,6 +916,7 @@
     },
     {
         "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD144, HSD30, HSM31",
         "EventCode": "0xB1",
@@ -824,6 +927,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0",
         "PublicDescription": "Cycles which a uop is dispatched on port 0 i=
n this thread.",
@@ -833,6 +937,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are executed in por=
t 0.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
         "SampleAfterValue": "2000003",
@@ -840,6 +945,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1",
         "PublicDescription": "Cycles which a uop is dispatched on port 1 i=
n this thread.",
@@ -849,6 +955,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are executed in por=
t 1.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
         "SampleAfterValue": "2000003",
@@ -856,6 +963,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_2",
         "PublicDescription": "Cycles which a uop is dispatched on port 2 i=
n this thread.",
@@ -865,6 +973,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 2.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_2_CORE",
         "SampleAfterValue": "2000003",
@@ -872,6 +981,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_3",
         "PublicDescription": "Cycles which a uop is dispatched on port 3 i=
n this thread.",
@@ -881,6 +991,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 3.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_3_CORE",
         "SampleAfterValue": "2000003",
@@ -888,6 +999,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4",
         "PublicDescription": "Cycles which a uop is dispatched on port 4 i=
n this thread.",
@@ -897,6 +1009,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are executed in por=
t 4.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
         "SampleAfterValue": "2000003",
@@ -904,6 +1017,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5",
         "PublicDescription": "Cycles which a uop is dispatched on port 5 i=
n this thread.",
@@ -913,6 +1027,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are executed in por=
t 5.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
         "SampleAfterValue": "2000003",
@@ -920,6 +1035,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6",
         "PublicDescription": "Cycles which a uop is dispatched on port 6 i=
n this thread.",
@@ -929,6 +1045,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are executed in por=
t 6.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
         "SampleAfterValue": "2000003",
@@ -936,6 +1053,7 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_7",
         "PublicDescription": "Cycles which a uop is dispatched on port 7 i=
n this thread.",
@@ -945,6 +1063,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 7.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_7_CORE",
         "SampleAfterValue": "2000003",
@@ -952,6 +1071,7 @@
     },
     {
         "BriefDescription": "Uops that Resource Allocation Table (RAT) iss=
ues to Reservation Station (RS)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "This event counts the number of uops issued =
by the Front-end of the pipeline to the Back-end. This event is counted at =
the allocation stage and will count both retired and non-retired uops.",
@@ -961,6 +1081,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) d=
oes not issue Uops to Reservation Station (RS) for all threads.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.CORE_STALL_CYCLES",
@@ -970,6 +1091,7 @@
     },
     {
         "BriefDescription": "Number of flags-merge uops being allocated. S=
uch uops considered perf sensitive; added by GSR u-arch.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.FLAGS_MERGE",
         "PublicDescription": "Number of flags-merge uops allocated. Such u=
ops add delay.",
@@ -978,6 +1100,7 @@
     },
     {
         "BriefDescription": "Number of Multiply packed/scalar single preci=
sion uops allocated",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.SINGLE_MUL",
         "PublicDescription": "Number of multiply packed/scalar single prec=
ision uops allocated.",
@@ -986,6 +1109,7 @@
     },
     {
         "BriefDescription": "Number of slow LEA uops being allocated. A uo=
p is generally considered SlowLea if it has 3 sources (e.g. 2 sources + imm=
ediate) regardless if as a result of LEA instruction or not.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.SLOW_LEA",
         "PublicDescription": "Number of slow LEA or similar uops allocated=
. Such uop has 3 sources (for example, 2 sources + immediate) regardless of=
 whether it is a result of LEA instruction or not.",
@@ -994,6 +1118,7 @@
     },
     {
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) d=
oes not issue Uops to Reservation Station (RS) for the thread.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.STALL_CYCLES",
@@ -1003,6 +1128,7 @@
     },
     {
         "BriefDescription": "Actually retired uops.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
         "PEBS": "1",
@@ -1013,6 +1139,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles without actually retired uops.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.CORE_STALL_CYCLES",
@@ -1022,6 +1149,7 @@
     },
     {
         "BriefDescription": "Retirement slots used.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "PEBS": "1",
@@ -1031,6 +1159,7 @@
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
@@ -1040,6 +1169,7 @@
     },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
+        "Counter": "0,1,2,3",
         "CounterMask": "16",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/haswell/uncore-cache.json
index be9a3ed1a940..fb116637e83e 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in E or S-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_ES",
         "PerPkg": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in I-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_I",
         "PerPkg": "1",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in M-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_M",
         "PerPkg": "1",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in MESI-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_MESI",
         "PerPkg": "1",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access =
cache and found line in E or S-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_ES",
         "PerPkg": "1",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access =
cache and found line in I-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_I",
         "PerPkg": "1",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access =
cache and found line in M-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_M",
         "PerPkg": "1",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access =
cache and found line in MESI-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_MESI",
         "PerPkg": "1",
@@ -65,6 +73,7 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in E or S-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_ES",
         "PerPkg": "1",
@@ -73,6 +82,7 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in I-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_I",
         "PerPkg": "1",
@@ -81,6 +91,7 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in M-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_M",
         "PerPkg": "1",
@@ -89,6 +100,7 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in any MESI-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_MESI",
         "PerPkg": "1",
@@ -97,6 +109,7 @@
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in E or S-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_ES",
         "PerPkg": "1",
@@ -105,6 +118,7 @@
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in I-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_I",
         "PerPkg": "1",
@@ -113,6 +127,7 @@
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in M-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_M",
         "PerPkg": "1",
@@ -121,6 +136,7 @@
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in MESI-state.",
+        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_MESI",
         "PerPkg": "1",
@@ -129,6 +145,7 @@
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction =
which hits a modified line in some processor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_EVICTION",
         "PerPkg": "1",
@@ -137,6 +154,7 @@
     },
     {
         "BriefDescription": "An external snoop hits a modified line in som=
e processor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_EXTERNAL",
         "PerPkg": "1",
@@ -145,6 +163,7 @@
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a modified line in some proces=
sor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_XCORE",
         "PerPkg": "1",
@@ -153,6 +172,7 @@
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction =
which hits a non-modified line in some processor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_EVICTION",
         "PerPkg": "1",
@@ -161,6 +181,7 @@
     },
     {
         "BriefDescription": "An external snoop hits a non-modified line in=
 some processor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_EXTERNAL",
         "PerPkg": "1",
@@ -169,6 +190,7 @@
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a non-modified line in some pr=
ocessor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_XCORE",
         "PerPkg": "1",
@@ -177,6 +199,7 @@
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction =
which misses in some processor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
         "PerPkg": "1",
@@ -185,6 +208,7 @@
     },
     {
         "BriefDescription": "An external snoop misses in some processor co=
re.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EXTERNAL",
         "PerPkg": "1",
@@ -193,10 +217,19 @@
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which misses in some processor core.",
+        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE",
         "PerPkg": "1",
         "UMask": "0x41",
         "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
+        "Counter": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "Unit": "cbox_0"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/haswell/uncore-interconnect.json
index 8da28239ebf9..557b278e631d 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/uncore-interconnect.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Each cycle count number of valid entries in C=
oherency Tracker queue from allocation till deallocation. Aperture requests=
 (snoops) appear as NC decoded internally and become coherent (snoop L3, ac=
cess memory)",
+        "Counter": "0",
         "EventCode": "0x83",
         "EventName": "UNC_ARB_COH_TRK_OCCUPANCY.All",
         "PerPkg": "1",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop, Core aperture, etc.",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
         "PerPkg": "1",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Each cycle counts number of all Core outgoing=
 valid entries. Such entry is defined as valid from its allocation till fir=
st of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-cohe=
rent traffic.",
+        "Counter": "0",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
         "PerPkg": "1",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Cycles with at least one request outstanding =
is waiting for data return from memory controller. Account for coherent and=
 non-coherent requests initiated by IA Cores, Processor Graphics Unit, or L=
LC.",
+        "Counter": "0",
         "CounterMask": "1",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
@@ -35,6 +39,7 @@
     },
     {
         "BriefDescription": "Total number of Core outgoing entries allocat=
ed. Accounts for Coherent and non-coherent traffic.",
+        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
         "PerPkg": "1",
@@ -43,6 +48,7 @@
     },
     {
         "BriefDescription": "Number of Writes allocated - any write transa=
ctions: full/partials writes and evictions.",
+        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/haswell/uncore-other.json
index 2af92e43b28a..1ac5b5ef8094 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
+        "Counter": "FIXED",
         "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json b/t=
ools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
index 87a4ec1ee7d7..7cf00ae0e993 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Load misses in all DTLB levels that cause pag=
e walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Misses in all TLB levels that cause a page w=
alk of any page size.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "DTLB demand load misses with low part of line=
ar-to-physical address translation missed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.PDE_CACHE_MISS",
         "PublicDescription": "DTLB demand load misses with low part of lin=
ear-to-physical address translation missed.",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Load operations that miss the first DTLB leve=
l but hit the second and do not cause page walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "PublicDescription": "Number of cache load STLB hits. No page walk=
.",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Load misses that miss the  DTLB and hit the S=
TLB (2M)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT_2M",
         "PublicDescription": "This event counts load operations from a 2M =
page that miss the first DTLB level but hit the second and do not cause pag=
e walks.",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Load misses that miss the  DTLB and hit the S=
TLB (4K)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT_4K",
         "PublicDescription": "This event counts load operations from a 4K =
page that miss the first DTLB level but hit the second and do not cause pag=
e walks.",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes of any page size.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PublicDescription": "Completed page walks in any TLB of any page =
size due to demand load misses.",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (1G)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
         "SampleAfterValue": "2000003",
@@ -56,6 +63,7 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes (2M/4M).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Completed page walks due to demand load miss=
es that caused 2M/4M page walks in any TLB levels.",
@@ -64,6 +72,7 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes (4K).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Completed page walks due to demand load miss=
es that caused 4K page walks in any TLB levels.",
@@ -72,6 +81,7 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_DURATION",
         "PublicDescription": "This event counts cycles when the  page miss=
 handler (PMH) is servicing page walks caused by DTLB load misses.",
@@ -80,6 +90,7 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause pa=
ge walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Miss in all TLB levels causes a page walk of=
 any page size (4K/2M/4M/1G).",
@@ -88,6 +99,7 @@
     },
     {
         "BriefDescription": "DTLB store misses with low part of linear-to-=
physical address translation missed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.PDE_CACHE_MISS",
         "PublicDescription": "DTLB store misses with low part of linear-to=
-physical address translation missed.",
@@ -96,6 +108,7 @@
     },
     {
         "BriefDescription": "Store operations that miss the first TLB leve=
l but hit the second and do not cause page walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "PublicDescription": "Store operations that miss the first TLB lev=
el but hit the second and do not cause page walks.",
@@ -104,6 +117,7 @@
     },
     {
         "BriefDescription": "Store misses that miss the  DTLB and hit the =
STLB (2M)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT_2M",
         "PublicDescription": "This event counts store operations from a 2M=
 page that miss the first DTLB level but hit the second and do not cause pa=
ge walks.",
@@ -112,6 +126,7 @@
     },
     {
         "BriefDescription": "Store misses that miss the  DTLB and hit the =
STLB (4K)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT_4K",
         "PublicDescription": "This event counts store operations from a 4K=
 page that miss the first DTLB level but hit the second and do not cause pa=
ge walks.",
@@ -120,6 +135,7 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PublicDescription": "Completed page walks due to store miss in an=
y TLB levels of any page size (4K/2M/4M/1G).",
@@ -128,6 +144,7 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks. (1G)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
         "SampleAfterValue": "100003",
@@ -135,6 +152,7 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks (2M/4M)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Completed page walks due to store misses in =
one or more TLB levels of 2M/4M page structure.",
@@ -143,6 +161,7 @@
     },
     {
         "BriefDescription": "Store miss in all TLB levels causes a page wa=
lk that completes. (4K)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Completed page walks due to store misses in =
one or more TLB levels of 4K page structure.",
@@ -151,6 +170,7 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_DURATION",
         "PublicDescription": "This event counts cycles when the  page miss=
 handler (PMH) is servicing page walks caused by DTLB store misses.",
@@ -159,6 +179,7 @@
     },
     {
         "BriefDescription": "Cycle count for an Extended Page table walk."=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.WALK_CYCLES",
         "SampleAfterValue": "2000003",
@@ -166,6 +187,7 @@
     },
     {
         "BriefDescription": "Flushing of the Instruction TLB (ITLB) pages,=
 includes 4k/2M/4M pages.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xae",
         "EventName": "ITLB.ITLB_FLUSH",
         "PublicDescription": "Counts the number of ITLB flushes, includes =
4k/2M/4M pages.",
@@ -174,6 +196,7 @@
     },
     {
         "BriefDescription": "Misses at all ITLB levels that cause page wal=
ks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Misses in ITLB that causes a page walk of an=
y page size.",
@@ -182,6 +205,7 @@
     },
     {
         "BriefDescription": "Operations that miss the first ITLB level but=
 hit the second and do not cause any page walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT",
         "PublicDescription": "ITLB misses that hit STLB. No page walk.",
@@ -190,6 +214,7 @@
     },
     {
         "BriefDescription": "Code misses that miss the  DTLB and hit the S=
TLB (2M)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT_2M",
         "PublicDescription": "ITLB misses that hit STLB (2M).",
@@ -198,6 +223,7 @@
     },
     {
         "BriefDescription": "Core misses that miss the  DTLB and hit the S=
TLB (4K)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT_4K",
         "PublicDescription": "ITLB misses that hit STLB (4K).",
@@ -206,6 +232,7 @@
     },
     {
         "BriefDescription": "Misses in all ITLB levels that cause complete=
d page walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Completed page walks in ITLB of any page siz=
e.",
@@ -214,6 +241,7 @@
     },
     {
         "BriefDescription": "Store miss in all TLB levels causes a page wa=
lk that completes. (1G)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_1G",
         "SampleAfterValue": "100003",
@@ -221,6 +249,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Completed page walks due to misses in ITLB 2=
M/4M page entries.",
@@ -229,6 +258,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Completed page walks due to misses in ITLB 4=
K page entries.",
@@ -237,6 +267,7 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_DURATION",
         "PublicDescription": "This event counts cycles when the  page miss=
 handler (PMH) is servicing page walks caused by ITLB misses.",
@@ -245,6 +276,7 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in the L1+FB"=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_L1",
         "PublicDescription": "Number of DTLB page walker loads that hit in=
 the L1+FB.",
@@ -253,6 +285,7 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in the L2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_L2",
         "PublicDescription": "Number of DTLB page walker loads that hit in=
 the L2.",
@@ -261,6 +294,7 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in the L3 + X=
SNP",
+        "Counter": "0,1,2,3",
         "Errata": "HSD25",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_L3",
@@ -270,6 +304,7 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in Memory",
+        "Counter": "0,1,2,3",
         "Errata": "HSD25",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_MEMORY",
@@ -279,6 +314,7 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the DTLB that hit in the L1 and FB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_DTLB_L1",
         "SampleAfterValue": "2000003",
@@ -286,6 +322,7 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the DTLB that hit in the L2.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_DTLB_L2",
         "SampleAfterValue": "2000003",
@@ -293,6 +330,7 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the DTLB that hit in the L3.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_DTLB_L3",
         "SampleAfterValue": "2000003",
@@ -300,6 +338,7 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the DTLB that hit in memory.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_DTLB_MEMORY",
         "SampleAfterValue": "2000003",
@@ -307,6 +346,7 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the ITLB that hit in the L1 and FB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_ITLB_L1",
         "SampleAfterValue": "2000003",
@@ -314,6 +354,7 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the ITLB that hit in the L2.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_ITLB_L2",
         "SampleAfterValue": "2000003",
@@ -321,6 +362,7 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the ITLB that hit in the L2.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_ITLB_L3",
         "SampleAfterValue": "2000003",
@@ -328,6 +370,7 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the ITLB that hit in memory.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_ITLB_MEMORY",
         "SampleAfterValue": "2000003",
@@ -335,6 +378,7 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in the L1+FB"=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_L1",
         "PublicDescription": "Number of ITLB page walker loads that hit in=
 the L1+FB.",
@@ -343,6 +387,7 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in the L2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_L2",
         "PublicDescription": "Number of ITLB page walker loads that hit in=
 the L2.",
@@ -351,6 +396,7 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in the L3 + X=
SNP",
+        "Counter": "0,1,2,3",
         "Errata": "HSD25",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_L3",
@@ -360,6 +406,7 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in Memory",
+        "Counter": "0,1,2,3",
         "Errata": "HSD25",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_MEMORY",
@@ -369,6 +416,7 @@
     },
     {
         "BriefDescription": "DTLB flush attempts of the thread-specific en=
tries",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.DTLB_THREAD",
         "PublicDescription": "DTLB flush attempts of the thread-specific e=
ntries.",
@@ -377,6 +425,7 @@
     },
     {
         "BriefDescription": "STLB flush attempts",
+        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.STLB_ANY",
         "PublicDescription": "Count number of STLB flush attempts.",
--=20
2.45.2.627.g7a2c4fd464-goog


