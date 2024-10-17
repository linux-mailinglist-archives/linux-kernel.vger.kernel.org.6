Return-Path: <linux-kernel+bounces-370158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E802F9A28C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5A91C211C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4091DF73D;
	Thu, 17 Oct 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxURDOBP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C51DF96A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182429; cv=none; b=s/vDAe4gnA6a6b1ARvYCusS8vE3sP9kmoI7WROo8e5u9pts47JC2A3RTPQDb85tOzBAFW7iWza91oEEYZlD/lyzUCfTMSELZHn1Vq78cl7yTwkGyWfrFOwGK5xgFThEABjsw/BzkAKDUZgzf3MYt27wSDAYPbAToC04fVMvIlFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182429; c=relaxed/simple;
	bh=7RObRM0z6nR9DWrq0r5Bujm7WrPO0gXOnXZjPf3UXpk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=WPvHpNux+CLczKS4tqkAgqhxJ/kicBop/+l52dqjkobItwh/geJ7AWMdcwS+WkJkPqxqvbDl6FGPZYh0Y9XJSs/Ld6FSaogORA8L9X/7/JhJ1c0xXGz/adokJ+9TGCADEPvM98lR1X0DcTZ7T75Ojxs4Gr0nxefvUddIUJi9/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxURDOBP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35bdb6a31so23047477b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729182423; x=1729787223; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B4IAnzQZVBr6W615fwR+39NWeMnDjMPSHLvl/Wce2vU=;
        b=JxURDOBPAoKBzbtxxi2UmR4w4JQQoayUSWgJOcyypZEyTDcgHdsIunsg7sTTKv1qff
         Bh5mDaCkCYdmuoV4KoWEO9YLi3MF+Zll/eLKnLzb5rPeQrkiqohizE0AclI1OaXhkxcF
         5aCDm+M/iGVbet3gKv+hdHiTQJPcRTSLt7ScYDSeOonS/JeqAyKhP/R8bardIwgjCFuR
         aBiaZccROsTA5VtNDLCSRL3ulNCZS52+vUn36/Vlx4/StnrX+y0FugU8O6erKdrvdLIL
         WGWIDIANYvL7eS653V/tbQZ2MNAEIwcrNloJNVS7xVTjg2Zr0OCUEITJWkTDZLoVZyl2
         Ax4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182423; x=1729787223;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4IAnzQZVBr6W615fwR+39NWeMnDjMPSHLvl/Wce2vU=;
        b=Ex6w6sylGWqZGtqDpS795IUcuWK8jdxBVOPWptXMyJrNwNqUYdGVmn84VoRx4/o9GZ
         FsTeboY8n8MU0HdIo1Hh4cBgUCNXxQEpODITrngM/ztqNNwIs6UAlMGfa31QOzYoaz4G
         4mbdml/3Ea+kpDS3lqIp35GWhLAyQVJOWMibaEtH4bRjpJpkHMx+4zxoU0JLDt+0YSaS
         FO2/1ip+MSkTJYE8a1ytkdAnXFg4Yq6pepfMEYsFsYzKBvdBPKjZb1TzScGuO+XwTnPk
         VHzYvYzElDH2T/SAlk5W5X5CGOQ+GysaBsl+lJwDT/EkCzGOC61MSrfY70h2ptphAeXL
         Lv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDdIfrzf7ATbIl77K6j9NnZjatZctTgbQcXcDpo0oLjSpSWbXM13um9oZ+rFwK0ItiJnkXHSwEklUi6Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeM0g0A2B1DWhUh8PNj6ZBQr23c3M0zd3W1pNeJrb4At/Y0b1W
	+X6WaP/vmLRqM98bq6tV7Gq3O84IO/V6+4KglCr6jIy1IOHCXIl0Y1TWHMMRozkpvNPx6hRtbdT
	lO1yamg==
X-Google-Smtp-Source: AGHT+IFG7sCOdONyNi5sV1QifTeVlHob7eJx347MgZjZvcxyocfpiupcKBob93e0kzghzcj2bHUGdDdpRE70
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:6902:1824:b0:e28:fba4:8b6e with SMTP
 id 3f1490d57ef6-e2979482a97mr4636276.7.1729182422876; Thu, 17 Oct 2024
 09:27:02 -0700 (PDT)
Date: Thu, 17 Oct 2024 09:26:49 -0700
Message-Id: <20241017162649.724851-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v1] perf check: Add sanitizer feature and use to avoid test failure
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sanitizer builds can break expectations for test disassembly,
particularly in the annotate test. Add features for the different
sanitizer options seen in the source tree. Use the added sanitizer
feature to skip the annotate test when sanitizers are in use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-check.c         | 37 ++++++++++++++++++++++++++++++
 tools/perf/tests/shell/annotate.sh |  6 +++++
 2 files changed, 43 insertions(+)

diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 0b76b6e42b78..5779df5e35ec 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -9,6 +9,37 @@
 #include <string.h>
 #include <subcmd/parse-options.h>
 
+#if defined(__has_feature)
+#define HAS_COMPILER_FEATURE(feature) __has_feature(feature)
+#else
+#define HAS_COMPILER_FEATURE(feature) 0
+#endif
+
+#if defined(__SANITIZE_ADDRESS__) || defined(ADDRESS_SANITIZER) || \
+	HAS_COMPILER_FEATURE(address_sanitizer)
+#define HAVE_SANITIZER_ADDRESS 1
+#define HAVE_SANITIZER_LEAK 1
+#elif defined(LEAK_SANITIZER) || HAS_COMPILER_FEATURE(leak_sanitizer)
+#define HAVE_SANITIZER_LEAK 1
+#endif
+
+#if defined(MEMORY_SANITIZER) || HAS_COMPILER_FEATURE(memory_sanitizer)
+#define HAVE_SANITIZER_MEMORY 1
+#endif
+
+#if defined(THREAD_SANITIZER) || HAS_COMPILER_FEATURE(thread_sanitizer)
+#define HAVE_SANITIZER_THREAD 1
+#endif
+
+#if defined(UNDEFINED_SANITIZER) || HAS_COMPILER_FEATURE(undefined_sanitizer)
+#define HAVE_SANITIZER_UNDEFINED 1
+#endif
+
+#if HAVE_SANITIZER_ADDRESS || HAVE_SANITIZER_LEAK || HAVE_SANITIZER_MEMORY || \
+	HAVE_SANITIZER_THREAD || HAVE_SANITIZER_UNDEFINED
+#define HAVE_SANITIZER 1
+#endif
+
 static const char * const check_subcommands[] = { "feature", NULL };
 static struct option check_options[] = {
 	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
@@ -47,6 +78,12 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
 	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
 	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
+	FEATURE_STATUS("sanitizer", HAVE_SANITIZER),
+	FEATURE_STATUS("sanitizer_address", HAVE_SANITIZER_ADDRESS),
+	FEATURE_STATUS("sanitizer_leak", HAVE_SANITIZER_LEAK),
+	FEATURE_STATUS("sanitizer_memory", HAVE_SANITIZER_MEMORY),
+	FEATURE_STATUS("sanitizer_thread", HAVE_SANITIZER_THREAD),
+	FEATURE_STATUS("sanitizer_undefined", HAVE_SANITIZER_UNDEFINED),
 	FEATURE_STATUS("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
 	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
 	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 1590a37363de..199f547e656d 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -4,6 +4,12 @@
 
 set -e
 
+if perf check feature -q sanitizer
+then
+  echo "Skip test with sanitizers due to differing assembly code"
+  exit 2
+fi
+
 shelldir=$(dirname "$0")
 
 # shellcheck source=lib/perf_has_symbol.sh
-- 
2.47.0.105.g07ac214952-goog


