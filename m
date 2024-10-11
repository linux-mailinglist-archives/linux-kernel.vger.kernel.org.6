Return-Path: <linux-kernel+bounces-360686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9515999E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3841F23DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E6D20C475;
	Fri, 11 Oct 2024 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/1WHHhc"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F920B216
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632187; cv=none; b=ZrmoN7DRkyo97dXwq+GU3IydSqnTiQ0ReVsnNlBIGQosNhtQuZTz49eg+Ir5nwaTahzepHOVUaPyUwly5UZRHaTdSQxJduR1XD/+em4470nebu0Yv1D36DvLwuvMsjAT0FkJzNl1xTanIfjBMhnTydV4D3ORtsjSTc/YzfnCHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632187; c=relaxed/simple;
	bh=qRJ7uobiuXa4lx58ydid8NsiY9eSUc6Dd5fam5Iq7JM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k8LQ3/7O/6aQ4t/oZHqW2nb+Gmy9jpkaMNEZ73ZkNIMA1PyH3Bw5QNUwOkE51skdSgZxjznoAV91wQ1LAdVfhcKYK3X3fakJgNc2/HkjDRqwPHr1GLsyPcjwKgoPC/rzg65upr8EJ0NwDuUu0BIvNfiQ1dglv8y+3KWbdJ8w6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/1WHHhc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31d9c8efcso35447607b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632185; x=1729236985; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGy2stET4dPYcbIauhcjx1YKA3rAeDl4bGF/9JCbzDA=;
        b=x/1WHHhcX5uhIxoTpgJ6UZwPYJRUF+JSEIHaOdJWNzLDZJe6aHEZe/3u+iSYX8MOlB
         Nrk+Bfyq+S/t+w5ZOTXMXYCpMbHvoUN3BoqSGR4KR3wcO6KLTSt86R+Rc/nzuSnFJG78
         ARnI42Sxg/65Q77Vb0iQOzCbiYXAzJ7odOkuvDh0sJa9boNgE3YU6rRWaIplJAHO8niU
         nQ7W2z67TzFq5jNUm8Ntgdk+WAmCeEyauyjtia2NXK4bhEsYV4xPU9yADNrGtj/uuxSu
         t7swkd2owG05q61MaFjqCy8YL2niNI8XDJOfnCUZ3lriD7U0jMXKQq90yo6nMFjwKEn4
         ++3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632185; x=1729236985;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGy2stET4dPYcbIauhcjx1YKA3rAeDl4bGF/9JCbzDA=;
        b=HCe2Z7LB8ZN5CSYKUzVukaXFHJt2p09Wa/DyUZSGRo93kDKkWZT590iYo6NBUTz0RU
         llkCxXYuwxXwdQttobnRYOcGwVb0QTrXkndrWTXfRfAqP5aKB9zhBm/dwdGdKiQljoeO
         11aFvItyUUN875FN/47mrLlgJ0fJ22HK0XlFRNFBSejYZdDxqiNA3HQAqFZP/ucUD7P6
         21gHzcAe3r2nQttcE3Ey9txF6wV7ZTh5m2naHGF2wQ7pVnxgyy07Vi/WvLOx2bt2MYuW
         pWmbWJLBxMoaWvwYSswaKxWOtl9HtJR/ttgrZCtKMcEL5YybLuJI8LaM3vq55IOvFaIG
         pznA==
X-Forwarded-Encrypted: i=1; AJvYcCWgcmoDKLKVLm2pcnW+/+xMRgAAYXqSskyatrBdvhzu6CWQINLcMZD8kF8bWc7CqV51zkC2kzWIPJkbUmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zn2RbTQmyih8cBgkBlJIEdYJI8tQ86Gofet4NvG7VOIRUXcj
	mN1a2X6fL+7d4PI0uU778wHSMaEQMXmJRFXCWMsY9gZCsLJeaifL0yhZJqRohFokZcQ/IGxASxs
	WCbof4A==
X-Google-Smtp-Source: AGHT+IFCnDFL9xKF8OEn5GZiOdl2eowmU59Qvp9zHwHa5EKbZlB7BPAnM/Hp0z+j/P9xYahKR4m00uHjtQKt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a25:c593:0:b0:e28:ede2:d060 with SMTP id
 3f1490d57ef6-e2919dd2c51mr1323276.4.1728632185018; Fri, 11 Oct 2024 00:36:25
 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:56 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 5/8] perf test: Tag parallel failing shell tests with "(exclusive)"
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/perftool-testsuite_report.sh | 2 +-
 tools/perf/tests/shell/record.sh                    | 2 +-
 tools/perf/tests/shell/record_lbr.sh                | 2 +-
 tools/perf/tests/shell/record_offcpu.sh             | 2 +-
 tools/perf/tests/shell/stat_all_pmu.sh              | 2 +-
 tools/perf/tests/shell/test_intel_pt.sh             | 2 +-
 tools/perf/tests/shell/test_stat_intel_tpebs.sh     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

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


