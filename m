Return-Path: <linux-kernel+bounces-361888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4C599AE74
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4871F213F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7448A1D1E81;
	Fri, 11 Oct 2024 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9gq/BxR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBDA1E47DF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684259; cv=none; b=MtbviyMgv1CaF4mZB2e3U7Q4EY2wrV6s6bIuZRnE9bstaNL7eDoOX8XE8J6KHB0CaUhfJ56HwnFo8ZNirap+59/xnFgWIfkG7YkUQIAhK+AAgvPbx8/UEMejDqS2VNfrABz2+XaydOFztlQgPabsudDg2Vzy8IynKPS8iPVQsPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684259; c=relaxed/simple;
	bh=7GwxBquywU+IxTcpxM3Ko+Upc2nLVpDtM+WJFJ40q0Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jbmgc9oDjAYMkGqbrbhiNLi+Bzj06358amqq4PNIFklRne5ggiI9ceN8lPZzxhV8S7iKjsLuT2zEyhfzJrZwBeh+naVZeQ60LZ1EHI2Q94hQKkhcQINsz2XqgRrHTK5NNyW6qKyK97/yvLRRT4hW+pp40PHgxyB/38OAfB3BLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9gq/BxR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e0082c1dd0so48951997b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728684257; x=1729289057; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAeyMobsK3znaJpVmaZIUJ4+zYiQ3C3XAxpS99a1TIk=;
        b=t9gq/BxR1EOptrdQQFdKHhWj6Dxl6XNTARAL755RXzrJ5NYeo0a0DwsB+JWSo9ZGeq
         Uz4L+K5j76LzHPjpmnJ1RtSDuip+GKO75T74R7cpHrNgPTGvCANnFw7zuRp294jKgTGl
         p+AyoANPr1UCfJ/q/+NPV5C0G7V+Cf9W0RcS9CmUjl2a0BU4Z+oYtITf4U0BBATYVgT4
         USpOKAYE3Fd2ZUeCcbCbzyvTnhbmNVQDlh4fidhi817gFshURnk9LIn1w2L0YWW+oeDW
         NoZ5NCq9jPrxFrVz3MFX9F4RZCSIAwPq6AoDwXrKLXSi0Nt8FfwTN3o3b3uB2dVoUjmm
         5X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684257; x=1729289057;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAeyMobsK3znaJpVmaZIUJ4+zYiQ3C3XAxpS99a1TIk=;
        b=oZHfkEqOKqc4lsyHQx478580hy5Jc6Z3KiBKfAWpe4tsqAuaw2w4zifWCK1IyWgzw1
         C61m+NVhAVibpTRvaOVhnf/5hH6Hrp2VhmWkQ3JVI5mZLv1/mk8pOb6uDBh9RvjJXslq
         u+R34KQh7KUq611xZAT2X3ukoUGsMEoBDMAH20opqaR53Vlz8MnZ/eUfCon3wCwrC++g
         t+fgI7NiCAKcxSYR6HhI5IboWUrM2yRRNtwMnI5L7fnI5MFFxDFawKBgyNPnvvSDvjbf
         HzcioCOHjH8vVlYk54q/tw83diyup+RokKIH0SMQvVUXDPYdtP8IJWjjo7geVq2xLEYB
         orkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBQt7QVgd09Ij+TqlRojy24wg8DAIKuH1sCQXelGybVbgoB1tKIIZe2BASKlyiEOPaJgRN0pA8upCcmYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnpbup9OJCYvQCAcNpnJyeRgaeObQqWq9Nxl0A0zHHR6QB2Oi
	B7vaM8GkzysAStqYpybwHSSZ6uITnMt56K9ZclHzOkgfRl8CTfdikSLGSCB6/fG7YSUiGi3vZqM
	19AALEw==
X-Google-Smtp-Source: AGHT+IEy4jaHEPHR3h1zcaYnMrqHXdROnQ6I3DL6+yTRDe+apB0CnaL9fg9TdbjBBA0NNdROjg8t50+X9jOl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:6085:b0:6db:54ae:fd0f with SMTP
 id 00721157ae682-6e347c6b7edmr1468017b3.7.1728684256349; Fri, 11 Oct 2024
 15:04:16 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:03:51 -0700
In-Reply-To: <20241011220354.756798-1-irogers@google.com>
Message-Id: <20241011220354.756798-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 5/8] perf test: Tag parallel failing shell tests with "(exclusive)"
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some shell tests compete for resources and so can't run with other
tests, tag such tests.  The "(exclusive)" stems from shared/exclusive
to describe how the tests run as if holding a lock.

For ARM/coresight tests:
Suggested-by: James Clark <james.clark@linaro.org>

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/coresight/asm_pure_loop.sh            | 2 +-
 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh     | 2 +-
 tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh | 2 +-
 tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh  | 2 +-
 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh    | 2 +-
 tools/perf/tests/shell/perftool-testsuite_report.sh          | 2 +-
 tools/perf/tests/shell/record.sh                             | 2 +-
 tools/perf/tests/shell/record_lbr.sh                         | 2 +-
 tools/perf/tests/shell/record_offcpu.sh                      | 2 +-
 tools/perf/tests/shell/stat_all_pmu.sh                       | 2 +-
 tools/perf/tests/shell/test_arm_coresight.sh                 | 2 +-
 tools/perf/tests/shell/test_arm_coresight_disasm.sh          | 2 +-
 tools/perf/tests/shell/test_arm_spe.sh                       | 2 +-
 tools/perf/tests/shell/test_intel_pt.sh                      | 2 +-
 tools/perf/tests/shell/test_stat_intel_tpebs.sh              | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop.sh b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
index 2d65defb7e0f..c63bc8c73e26 100755
--- a/tools/perf/tests/shell/coresight/asm_pure_loop.sh
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
@@ -1,5 +1,5 @@
 #!/bin/sh -e
-# CoreSight / ASM Pure Loop
+# CoreSight / ASM Pure Loop (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
diff --git a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
index ddcc9bb850f5..8e29630957c8 100755
--- a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
+++ b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
@@ -1,5 +1,5 @@
 #!/bin/sh -e
-# CoreSight / Memcpy 16k 10 Threads
+# CoreSight / Memcpy 16k 10 Threads (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
index 2ce5e139b2fd..0c4c82a1c8e1 100755
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
+++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
@@ -1,5 +1,5 @@
 #!/bin/sh -e
-# CoreSight / Thread Loop 10 Threads - Check TID
+# CoreSight / Thread Loop 10 Threads - Check TID (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
index 3ad9498753d7..d3aea9fc6ced 100755
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
+++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
@@ -1,5 +1,5 @@
 #!/bin/sh -e
-# CoreSight / Thread Loop 2 Threads - Check TID
+# CoreSight / Thread Loop 2 Threads - Check TID (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
index 4fbb4a29aad3..7429d3a2ae43 100755
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
@@ -1,5 +1,5 @@
 #!/bin/sh -e
-# CoreSight / Unroll Loop Thread 10
+# CoreSight / Unroll Loop Thread 10 (exclusive)
 
 # SPDX-License-Identifier: GPL-2.0
 # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/perf/tests/shell/perftool-testsuite_report.sh
index 973012ce92a7..a8cf75b4e77e 100755
--- a/tools/perf/tests/shell/perftool-testsuite_report.sh
+++ b/tools/perf/tests/shell/perftool-testsuite_report.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perftool-testsuite_report
+# perftool-testsuite_report (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 test -d "$(dirname "$0")/base_report" || exit 2
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 8d6366d96883..f7d8c5b243a4 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf record tests
+# perf record tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 32314641217e..8d750ee631f8 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf record LBR tests
+# perf record LBR tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 67c925f3a15a..678947fe69ee 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# perf record offcpu profiling tests
+# perf record offcpu profiling tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index 42456d89c5da..8b148b300be1 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf all PMU test
+# perf all PMU test (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 3302ea0b9672..534145778d7b 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Check Arm CoreSight trace data recording and synthesized samples
+# Check Arm CoreSight trace data recording and synthesized samples (exclusive)
 
 # Uses the 'perf record' to record trace data with Arm CoreSight sinks;
 # then verify if there have any branch samples and instruction samples
diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
index af63e3757cb0..353d0a24f976 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Check Arm CoreSight disassembly script completes without errors
+# Check Arm CoreSight disassembly script completes without errors (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 # The disassembly script reconstructs ranges of instructions and gives these to objdump to
diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index 03d5c7d12ee5..be0fcdadeea8 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Check Arm SPE trace data recording and synthesized samples
+# Check Arm SPE trace data recording and synthesized samples (exclusive)
 
 # Uses the 'perf record' to record trace data of Arm SPE events;
 # then verify if any SPE event samples are generated by SPE with
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 723ec501f99a..660991d17607 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Miscellaneous Intel PT testing
+# Miscellaneous Intel PT testing (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
index 9a11f42d153c..f95fc64bf0a7 100755
--- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# test Intel TPEBS counting mode
+# test Intel TPEBS counting mode (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-- 
2.47.0.rc1.288.g06298d1525-goog


