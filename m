Return-Path: <linux-kernel+bounces-576320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AEDA70DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE63AB49B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD40628E3F;
	Wed, 26 Mar 2025 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ubqg7UTq"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA1286A9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947585; cv=none; b=F5iS2sokTpVRu2hFAdsHOhVnBgve1vOgiQZbmqYmMlNzUUJCjkkKFJ1rsq6RNSMYj3aywfWRQgERtpMLQrbVBNZxNhPGIYTX2bZMUA/hncxV1ufe6UqBh37XIVcpG3FndD/WUSNDgtzkU4ZtMBn4D19iYPj3UJvuUuU+XCtajL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947585; c=relaxed/simple;
	bh=jj7cgVY1dHCdbl7CToIOpx+DtAOgzXi+ZwBseYtASCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kgCsOTe+j3zox4HdtKUaHXVbbgPtDdLr4VP5Bk4/plsis54vA6x81hFA7FS0JZqU/Ugd+1ONJBprZQoSqPQOVO2Oiixdp3OqcPlPUrOL5aARXP29PCmWCEZEcqTyglIugZGIo18pKO1tACBiJSS86ZJ9TmoEBy9XwqtilJFe04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ubqg7UTq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso10770173a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947583; x=1743552383; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tXKzMdne0PcZ1yEwuy/OWzqt9sFMlDxjtYmEokV0uc=;
        b=Ubqg7UTq9r/Hdkk87250xpWbi7HOpyje7lAqkhYCWr3aUfGxIKht2Zio1DI+NNfWoO
         A49DBDRO/UVeJyxzoltRyhnRahUC7zava/5v/30JMUWMLmgDQgAcCz+cImgURcha1QY5
         1BDpGaMKFR9U3SJ3Q4bErQffH8GTvDhstr8D2FwAidT3aJUAHGk542EVu/YJhEIccfVN
         jiivm4s2VkEV0f6cf/ZOWFRD8+6821NAv0mOKNdXkOLIwmbHDD3nx4Bi61uXo2k5TP01
         uNsHwHoIXpcr+cujXcvTl5GfXSTgVQ19JFzm2n95iaCDygm9coRYz1PWrfsP6JD+JUrB
         2yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947583; x=1743552383;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tXKzMdne0PcZ1yEwuy/OWzqt9sFMlDxjtYmEokV0uc=;
        b=UQK2gnS6sSXK3KkTDqz7OnwFvDoBkuSbBrBASpmhN8GHgiMf8Bi3GPw2E4FyLz3qwG
         lzlORRU1cateywIFR+EhCNNbPnKM5JzkqK/rdEJgwQvnIZbvhZKKhkHkpnoaESoVqvcu
         sX+jkZ69KQONMVxOCVqeVRtk7gOwC88SCiupyHWAmXUQb1aRKXgqdFiopA7sDSeKVJik
         oGucwziE/eZql05dZUBQu+yRQKtueMxJauKwysHbiXj6F2wsNXUumXACFzAeRx9D/6/V
         pBZUZWAYs4p13o4grqh0QJIBv3QBdimwPuaapizMbOKJVzsGAB8X6SIjUeFu3aa02Ge6
         VCLA==
X-Forwarded-Encrypted: i=1; AJvYcCVLyZkmkglgAFl2pFb68ySJDYwZRnl97C6j58gtakvlGkLT60oNIV4I/++ROzYDx7Ycxr09vdySPYcUyTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/wP5/dpfc0BAzoM9pNLMmjiShjIhnqL6B/UWOx/hFZPHyn9H
	YHXIu054O9vrLby5FsvxpH3NIbViN+XTUF8dFodTgC588btphKoTBdaLMXUx6omoB+b+Q6S6ITi
	SC8+FJQ==
X-Google-Smtp-Source: AGHT+IEwizCIlZ2mc7buHdqoiSSOfJ7BZ84a8AqmrE27Kj7Vd7q1ky5apXKAZA8h3DcPgWfNdVvfYIQ7kII8
X-Received: from pgbdo14.prod.google.com ([2002:a05:6a02:e8e:b0:af2:48c3:360f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a92:b0:1f5:6a1a:329b
 with SMTP id adf61e73a8af0-1fe4300f787mr38309635637.32.1742947582873; Tue, 25
 Mar 2025 17:06:22 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:07 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-10-irogers@google.com>
Subject: [PATCH v3 09/35] perf vendor events: Update clearwaterforest events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update event topic of OCR.DEMAND_DATA_RD.ANY_RESPONSE and
OCR.DEMAND_RFO.ANY_RESPONSE to be cache.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/clearwaterforest/cache.json      | 20 +++++++++++++++++
 .../arch/x86/clearwaterforest/other.json      | 22 -------------------
 2 files changed, 20 insertions(+), 22 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json

diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
index 875361b30f1d..17f8bfba56bc 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
@@ -140,5 +140,25 @@
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
deleted file mode 100644
index 80454e497f83..000000000000
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
+++ /dev/null
@@ -1,22 +0,0 @@
-[
-    {
-        "BriefDescription": "Counts demand data reads that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    }
-]
-- 
2.49.0.395.g12beb8f557-goog


