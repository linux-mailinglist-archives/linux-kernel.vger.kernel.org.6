Return-Path: <linux-kernel+bounces-529433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC8EA42622
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC9A16E228
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EBB254844;
	Mon, 24 Feb 2025 15:15:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D56A24EF95;
	Mon, 24 Feb 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410099; cv=none; b=jhYCBx09VUA93Kf/tjphdeI0s0eMwwcK8CHoXWDICx2fJf53i1AEqvKzxqKFX04xYi2FyIStcZqkNkMXYLcT8YYKJFRfLGfSTakZHPIxT2xrd8oSf8Eucf8wJVLGNXLpzWw7Lv7ajddg43gde2NpwuhCdgUdKNDpX6yVr8ez2Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410099; c=relaxed/simple;
	bh=42aKcXhK8IV5fPBPTGh2nGPlIREx2MphMV8CwqHXvYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpMXUU/pvW0YoYAkkYRbt+bhOzbEcURLlkfhOELKCpJaD8hnyD+DWfhXiDaknmw5RnbOUTog4aPQW9bQnIQOAjy3SsFe9TsSN707oDXWZTvCwPmyts9m+XcJU083KWqNzmUYqVHVPQorR7G7S5w9D0iGaaQ2Ko7us2w14bXMXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22BAF26B9;
	Mon, 24 Feb 2025 07:15:14 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2FAA3F6A8;
	Mon, 24 Feb 2025 07:14:55 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 7/8] Documentation: coresight: Document AUX pause and resume
Date: Mon, 24 Feb 2025 15:14:22 +0000
Message-Id: <20250224151423.1630639-8-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224151423.1630639-1-leo.yan@arm.com>
References: <20250224151423.1630639-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds description for AUX pause and resume.  It gives introduction
for what's AUX pause and resume and how to use the configuration terms.
As last, it records several usage examples.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../trace/coresight/coresight-perf.rst        | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
index d087aae7d492..c49aa05c51eb 100644
--- a/Documentation/trace/coresight/coresight-perf.rst
+++ b/Documentation/trace/coresight/coresight-perf.rst
@@ -78,6 +78,56 @@ enabled like::
 
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
+Some Arm CoreSight sinks (e.g., ETR, ETB) do not support interrupt
+mechanism. As a result, trace data might be lost if it cannot be copied
+to the user space tool in a timely manner. To mitigate trace data lose,
+a configuration term "update_buf_on_pause" can be used for the cs_etm
+PMU event. As its name suggests, it directs the driver to update the
+buffer when the AUX trace is paused. By default, this feature is
+disabled until users explicitly specify "update_buf_on_pause=1".
+
+TRBE has interrupt handling.  To avoid the race condition between the
+AUX pause or resume invoked in NMI and TRBE interrupt handler, the
+driver reports a failure if users try to use "update_buf_on_pause=1" on
+TRBE.
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
+Example for updating buffer on AUX pause::
+
+  perf record -a -e cs_etm/aux-action=start-paused,update_buf_on_pause=1/ \
+        -e cycles/aux-action=pause,period=10000000/ \
+        -e cycles/aux-action=resume,period=1050000/ -- sleep 1
+
 Perf test - Verify kernel and userspace perf CoreSight work
 -----------------------------------------------------------
 
-- 
2.34.1


