Return-Path: <linux-kernel+bounces-556561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4BA5CBB7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAEB189ED26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217C4264FB1;
	Tue, 11 Mar 2025 17:05:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EF0264A97;
	Tue, 11 Mar 2025 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712743; cv=none; b=uir6WYRSf8Lp1TBCrZbyh1KH8avrvuxUS4Ptlnzxy5TXFPiTovZXXwDLKq1VeAh21LHfQWOkdR19s1ZmWS5wdNDQRff64CxoUC7JHtDm/7IMkQwanT/3P5NV5aZg1gT7G6UH+WzwXp3blB5SpQ3H+mIxHVOd7FIyIFw2Rrm9B6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712743; c=relaxed/simple;
	bh=UXWV4cibA3DBNOwARNqtXEB87A1SUJIL/bVUttg1dts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGadFAtWXB1sQSwuKSnrv6v05oiiFO0JEMbrbTCEdClDl4eAu/kjDz9w2itBI27DBjSSa5B6LKMl6+qfWWyKMAqLGqRfCeyBZ+hYlQ9sZmWK6KCUNXARp3o9BxvtI4NyixJYqnesPYgIYQleGvjsJAdYttCaJM3qOYgLqDRuXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAC29152B;
	Tue, 11 Mar 2025 10:05:52 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 584593F673;
	Tue, 11 Mar 2025 10:05:40 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 6/6] Documentation: coresight: Document AUX pause and resume
Date: Tue, 11 Mar 2025 17:04:51 +0000
Message-Id: <20250311170451.611389-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311170451.611389-1-leo.yan@arm.com>
References: <20250311170451.611389-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds description for AUX pause and resume.  It gives introduction
for what's AUX pause and resume and records usage examples.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../trace/coresight/coresight-perf.rst        | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
index d087aae7d492..30be89320621 100644
--- a/Documentation/trace/coresight/coresight-perf.rst
+++ b/Documentation/trace/coresight/coresight-perf.rst
@@ -78,6 +78,37 @@ enabled like::
 
 Please refer to the kernel configuration help for more information.
 
+Fine-grained tracing with AUX pause and resume
+----------------------------------------------
+
+Arm CoreSight may generate a large amount of hardware trace data, which
+will lead to overhead in recording and distract users when reviewing
+profiling result. To mitigate the issue of excessive trace data, Perf
+provides AUX pause and resume functionality for fine-grained tracing.
+
+The AUX pause and resume can be triggered by associated events. These
+events can be ftrace tracepoints (including static and dynamic
+tracepoints) or PMU events (e.g. CPU PMU cycle event). To create a perf
+session with AUX pause / resume, three configuration terms are
+introduced:
+
+- "aux-action=start-paused": it is specified for the cs_etm PMU event to
+  launch in a paused state.
+- "aux-action=pause": an associated event is specified with this term
+  to pause AUX trace.
+- "aux-action=resume": an associated event is specified with this term
+  to resume AUX trace.
+
+Example for triggering AUX pause and resume with ftrace tracepoints::
+
+  perf record -e cs_etm/aux-action=start-paused/k,syscalls:sys_enter_openat/aux-action=resume/,syscalls:sys_exit_openat/aux-action=pause/ ls
+
+Example for triggering AUX pause and resume with PMU event::
+
+  perf record -a -e cs_etm/aux-action=start-paused/k \
+        -e cycles/aux-action=pause,period=10000000/ \
+        -e cycles/aux-action=resume,period=1050000/ -- sleep 1
+
 Perf test - Verify kernel and userspace perf CoreSight work
 -----------------------------------------------------------
 
-- 
2.34.1


