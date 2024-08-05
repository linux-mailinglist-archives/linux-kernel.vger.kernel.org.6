Return-Path: <linux-kernel+bounces-275264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E967948287
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040E528349F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8289416D9CB;
	Mon,  5 Aug 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDZIL9Th"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61D16D338
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887081; cv=none; b=ldvo7SrAPwDnelYj8Fs0fMuqyhAc+zcqqmHGBed7vFXThRoBOxfs6QTZVVaicUC4ywxSnQksWV8E22FR6uCnOWFtKHCWRqr3QaYUCq5O4uDZJFr4lYK1Uxjf76mIKM5Sgn/TJWM6RQ0FbPIBkOaZ0YI5/j9J6CJXN+DVT+zdiDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887081; c=relaxed/simple;
	bh=OkprP2+30CGqXbCJlToyp/lfbM9hlW0HK2ABpa1Qa+8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oOydXmytWSYUpI15JqMrg/LhtXrREgP4hpca30wrUem5IN2Rqo0Q+9ZEk5v98bP+0UIR37Sit6+3uXHEYmGK1pLdTH5HW3iJ6BNbezfN8u04wWTt3OzCjTriv0BgAXZXW2DGPH62/BLqIJXag2rqw9LbFr3sHI19qH+YdUbEjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDZIL9Th; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0ba463c970so12184809276.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887079; x=1723491879; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lfe4gxEvYKxDxRwW2qESsqEIUodbK6p7qv/mhdEEZFQ=;
        b=mDZIL9ThEPLP1K13LNI+vvWAkXI/9Ru9T9Zqs837qXFvHOSkW/aT8GHBZ45B9JDrvv
         WwK2ovuATFuI0fWDoOr5QbSD8lxs1OG7fHuSxoDcmsTnoeiPMmOKomd+rgyPdVGURBgd
         Dgs4luyX89aXiyHoa1hTsBTlMadPunpCqosXyVBmV4GW01hBnX489Um+gJ5Gcn2IUXq9
         EnY+euCrOZyPM419mhN5j2IKQECaQ6tfdHS7DBR8IuCZ/2fjDWG/3frBsfcW8pzSfAda
         a6FWWAOSMPtbto2aoKQ5Fb4sxvDKSXfcke0pFuLBHC9BwycnFcLTp8vhrqvFqPIXe0Rk
         S8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887079; x=1723491879;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lfe4gxEvYKxDxRwW2qESsqEIUodbK6p7qv/mhdEEZFQ=;
        b=JuOEUtyd1jRWA5Q/b4GQlGQzFgZYKWNeEowCciaCWKiHli9ZLofs7ueu6CnpPscG6L
         j5SjxYnkzusnzY9Fqd0/AqCdZOJYrFB0zqAkMReejSmK8netgsvI35f9elKwWZoz/kEl
         tHiReKb4eCcC/wI8E2ZmNZ/x1/K9Y03Zy3wdzwpgIdyVGWAQ+us7ZE7ntiTD21uiK/zy
         q+sItOMmty5TntTow4tPa+dvCdoPEADVKWP1POlR5NmtzFz4LGr1JdL5QcgwN0xVBEA4
         mJ4VPYeikAdnUAtofF/ZY8G8OcHsKq12HhCHU/OLEykbXSXKEVEpVmny3oJ4+O473FhV
         Rxvw==
X-Forwarded-Encrypted: i=1; AJvYcCX6UCuf2Q11Ms6gGp4WMHm/sxgligEWwP93mi+zQYY5+2iU/GuM5iGI0cWnqnd7f2NWCIkdw5XBMc7GGcK9Yba2nAoB3XDz3yUohFr3
X-Gm-Message-State: AOJu0YxZ0heIS5noY2xYzudCgvyXmr9jthEuVA4V8B8jk8oR9x3D0Mze
	hGT+mMDciwImrgUFkbbQ/6MbLKsKJVwbjh8GbBZQvvrNZOvBDYzhTZ7t1xR/4sdjfmb+tvL/H1B
	TMOQeaA==
X-Google-Smtp-Source: AGHT+IGrmti4jOH/kazGkyLVxy/soVqkMo0+E8STQu6tXr+6jrpf9QaL4kxNGpeU3MiUA4lgzpOT4h7CHrFx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1f65:8dc8:61d0:4b08])
 (user=irogers job=sendgmr) by 2002:a05:6902:2311:b0:e0b:6bb1:fac with SMTP id
 3f1490d57ef6-e0bde421a34mr35840276.9.1722887079301; Mon, 05 Aug 2024 12:44:39
 -0700 (PDT)
Date: Mon,  5 Aug 2024 12:44:23 -0700
In-Reply-To: <20240805194424.597244-1-irogers@google.com>
Message-Id: <20240805194424.597244-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	Charles Ci-Jyun Wu <dminus@andestech.com>, Locus Wei-Han Chen <locus84@andestech.com>, 
	Atish Patra <atishp@rivosinc.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	vincent.chen@sifive.com, greentime.hu@sifive.com, 
	Eric Lin <eric.lin@sifive.com>
Content-Type: text/plain; charset="UTF-8"

FW_SFENCE_VMA_RECEIVED is repeated twice in the file which will break
invariants in perf list as discussed in this thread:
https://lore.kernel.org/linux-perf-users/20240719081651.24853-1-eric.lin@sifive.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json      | 3 ---
 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json      | 3 ---
 .../perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json | 3 ---
 .../perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json | 3 ---
 4 files changed, 12 deletions(-)

diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
index 9b4a032186a7..5a996fa4b837 100644
--- a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
@@ -35,9 +35,6 @@
   {
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
-  {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
-  },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
   },
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
index 9b4a032186a7..5a996fa4b837 100644
--- a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
@@ -35,9 +35,6 @@
   {
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
-  {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
-  },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
   },
diff --git a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
index 9b4a032186a7..5a996fa4b837 100644
--- a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
@@ -35,9 +35,6 @@
   {
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
-  {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
-  },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
   },
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
index 9b4a032186a7..5a996fa4b837 100644
--- a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
@@ -35,9 +35,6 @@
   {
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
-  {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
-  },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
   },
-- 
2.46.0.rc2.264.g509ed76dc8-goog


