Return-Path: <linux-kernel+bounces-576316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFACA70DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CEE3A75E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C3B322A;
	Wed, 26 Mar 2025 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIBybslv"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8D2C9D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947541; cv=none; b=Cu0/q37XJlge4+lVqEXyYC8d41cKtU26pV+hnWm6oUjxpXzmINy5xtQhbgMvf/sD7ffoGgc6RpYVQRmfRp6kPyYExXsxQhxPcN9pydIL4EYfrONtM6KIUc/MBZJlRJWKvavq/lXCF+UwvZlCOaqtwslV348kqX6KCMPZMdCbY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947541; c=relaxed/simple;
	bh=gzOhUwuk6PRtqJT004lFT8JmHmf233ItpyrfAz7UByY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gNCs/7noFcfTK87rD/59F8VnAVfOKFyb71VghyEZOpomdD8Zo28SCm/tojGdmb5y9+0Zar1VZ2nASMBhidA3+wCPiHoft4QLoU6VwQ54jxpjzXnjeolUuJWkl90bv61QkK/4ppFtdvi/VDvDGaTUKtiQfPb+GlMep23uzWaLMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIBybslv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso10558741a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947539; x=1743552339; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=QIBybslvucyY+IHEtWVssnwuCH/gYZmf91/146mcCNUdz0iJUwcjvqkmtMVhZikhec
         FcLUfmDOlvJQ9+hxW6CBueR5Fdm5AvwGFdL1iCF9puZGaNYqefibBND8AXPUC40FlXmH
         jECc44vXq34iNWcrm/+eUGish9eV6ksFFfcH9bblPdWSME14RL/lhqy0HvPK455VhKZd
         hUlNtOL8C8HbRhSJ5n6T0b8lDiGl3WWVOt2TOzVRWyByWsIU6WNPxgVerSPvD26BS4RD
         fYNg3BTR7x9TPJ7tY93/Nt2LjXGBglvBq6XLAfs7QH25NJLT8gCAUq5mfHu0ZeaF5znr
         uUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947539; x=1743552339;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=TcfaSO+Pxb3TAbAHVN19GiOmOdsw1V4Gb+tfIuL7n0tLI+S+ad7+IycSmMbrgPd0Ks
         iPy4kNMmkWCBWCg8WF8qzkyeZZyVLZd0cyLuIAnvTvH0mnQTvi8ZM6ACm3tIlT01YtRK
         J1+yA7gxw1ggpJZ+NKFnM9/vsMhqZS89an1fQ74O9/JS4QhpPZ3pzg6zJCq/lHowzLyz
         LouIm3AQ8clF4/JKXtERrLzwW4sImSU1KKiuWAkRK11xPW+qso2MkCVqX6U/dElmUW0z
         DAEz0yJJkaPuJ+SgYjdHUGx6DPjKrIaVlvG1+0/z+wCbtwuGejYufbvcEADzqT98XSdl
         G7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWYQLGvV1d9s58K2Ez1lm07yKlC2A8hEsAjxAk0jaiDoBQDFBE7v4xFKZRODm3k/BmwZRu7sKrMqziWIek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOl7RRdfGkkIz/PWrMAJsgRdoTDh9m1nFH+8kaWogtFGgPLAzP
	rqC+nRO7x7tpqwm95u9T29PitbQMcI77bhgyhRs0uv2vBQNRXwxSWnd99oajqF2MZVqVdKUhQmG
	Pm/zCfw==
X-Google-Smtp-Source: AGHT+IE4oWDbWFvtLNFUwOWfpQXhRUeiwXDJOaV/ZyS/d/4GQ1851TdG55OmtLkNTLtGGaToqQ3bXUo2qjqi
X-Received: from pgbdo14.prod.google.com ([2002:a05:6a02:e8e:b0:af2:48c3:360f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:688:b0:1f5:7353:c303
 with SMTP id adf61e73a8af0-1fe42f2cbf3mr30460960637.11.1742947539131; Tue, 25
 Mar 2025 17:05:39 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:02 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-5-irogers@google.com>
Subject: [PATCH v3 04/35] perf vendor events: Update bonnell events
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

Move DISPATCH_BLOCKED.ANY to the pipeline topic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/bonnell/other.json    | 8 --------
 tools/perf/pmu-events/arch/x86/bonnell/pipeline.json | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/bonnell/other.json b/tools/perf/pmu-events/arch/x86/bonnell/other.json
index 3a55c101fbf7..6e6f64b96834 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/other.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/other.json
@@ -323,14 +323,6 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x2"
     },
-    {
-        "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason",
-        "Counter": "0,1",
-        "EventCode": "0x9",
-        "EventName": "DISPATCH_BLOCKED.ANY",
-        "SampleAfterValue": "200000",
-        "UMask": "0x20"
-    },
     {
         "BriefDescription": "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
         "Counter": "0,1",
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
index 9ff032ab11e2..48d3d053a369 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
@@ -211,6 +211,14 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason",
+        "Counter": "0,1",
+        "EventCode": "0x9",
+        "EventName": "DISPATCH_BLOCKED.ANY",
+        "SampleAfterValue": "200000",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Divide operations retired",
         "Counter": "0,1",
-- 
2.49.0.395.g12beb8f557-goog


