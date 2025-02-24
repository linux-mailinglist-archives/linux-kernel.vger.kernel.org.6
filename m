Return-Path: <linux-kernel+bounces-529426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B64ADA4260F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B611897F63
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FC0189905;
	Mon, 24 Feb 2025 15:14:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4270E13D52B;
	Mon, 24 Feb 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410086; cv=none; b=AYVIgN32q4oKqI31Sbn3D64A9/hB1m2lkC6WlStAnofan2hbxtKUAR5wmY4lQMPqq6d5e9aFbuVx3o5ZhqW+bI+uw6b7kwPN7ZPEYykpe/ZTSnnFLruyHloBTvoy51LfoAIYBR7qRvRCZWYDmYt+iSBsXHOqcc0vr4at8969gq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410086; c=relaxed/simple;
	bh=39IaXFwTZhQ6mNM8ADNcM9b5VILnAM/6sCCIci5UAkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U+20FLnMBHdaJ7bj9/qzIxcaHs/1PJIBQZMDwIRjis1qSoLqI8vFt2OQFJY0jhmg6KvFfAWjc/DeJ/HMmr4moLF5m/jgYOFdNV06nbOaCKw97B/st+Gw7EVtF2sj6ZaXYmZlcaguSPR3f3nYGZQ0teL7D2+/TCfyRSi5IhjQMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1906152B;
	Mon, 24 Feb 2025 07:14:59 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 857503F6A8;
	Mon, 24 Feb 2025 07:14:41 -0800 (PST)
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
Subject: [PATCH v1 0/8] Arm CoreSight: Support AUX pause and resume
Date: Mon, 24 Feb 2025 15:14:15 +0000
Message-Id: <20250224151423.1630639-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is to enable AUX pause and resume on Arm CoreSight.

The first patch extracts the trace unit controlling operations to two
functions.  These two functions will be used by AUX pause and resume.

Patches 02 and 03 change the ETMv4 driver to prepare callback functions
for AUX pause and resume.

Patch 04 changes the ETM perf layer to support AUX pause and resume in a
perf session.  The patches 05 and 06 offers an extra feature for
updating buffer on AUX pause occasion, which can mitigate the trace data
lose issue.

Patch 07 documents the AUX pause usages with Arm CoreSight.  The last
patch syncs headers between user space and the kernel.

This patch set has been verified on the Hikey960 board and TC platform.
The previous one uses ETR and the later uses TRBE as sink.

It is suggested to disable CPUIdle (add `nohlt` option in Linux command
line) when verifying this series.  ETM and funnel drivers are found
issues during CPU suspend and resume which will be addressed separately.


Leo Yan (8):
  coresight: etm4x: Extract the trace unit controlling
  coresight: Introduce pause and resume APIs for source
  coresight: etm4x: Hook pause and resume callbacks
  coresight: perf: Support AUX trace pause and resume
  coresight: etm: Add an attribute for updating buffer
  coresight: perf: Update buffer on AUX pause
  Documentation: coresight: Document AUX pause and resume
  perf cs-etm: Sync kernel coresight-pmu.h header

 .../trace/coresight/coresight-perf.rst        |  50 ++++++
 drivers/hwtracing/coresight/coresight-core.c  |  12 ++
 .../hwtracing/coresight/coresight-etm-perf.c  |  94 +++++++++-
 .../hwtracing/coresight/coresight-etm-perf.h  |   2 +
 .../coresight/coresight-etm4x-core.c          | 166 ++++++++++++------
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +
 drivers/hwtracing/coresight/coresight-priv.h  |   2 +
 include/linux/coresight-pmu.h                 |   1 +
 include/linux/coresight.h                     |   4 +
 tools/include/linux/coresight-pmu.h           |   1 +
 10 files changed, 281 insertions(+), 53 deletions(-)

-- 
2.34.1


