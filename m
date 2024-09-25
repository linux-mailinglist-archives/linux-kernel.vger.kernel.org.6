Return-Path: <linux-kernel+bounces-339577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A54986731
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BCE1F22794
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF871487DC;
	Wed, 25 Sep 2024 19:53:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1836C146593;
	Wed, 25 Sep 2024 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294035; cv=none; b=iwSizU2L+kmIsIVN0T88mo2iZmtFt1tSumx/xlRRDHldtSOsnp2rtn574lr+ckUGkXwdGuKBbrHfRFTnL4UBuThYi5uULeP4uIazgzzuiizI9GnWqYs5u2CYDVGCCPSKoI/ytuiD8Ud77ttdkL62rg9LNELJNz/qSlYG0jm2N1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294035; c=relaxed/simple;
	bh=S1L6bzuR4Aqpc1XmXN74M833CH5WL50qd1rAM5VQPlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADjlplNVJPYBYV4VWa2sTmt4g2OV2Pvi2mzX44fP0UC/Atvt/rZkv43Noo5j5skLAasl7MBdOehz58EOQasoTcPYxgwLUCJxlsar2p+0+ThK7tssG8aWm480Xyk0olOrcb7XoPWZyjmxHK8LIOVrHUOXXNxH3twXinyPiaSo0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91B92150C;
	Wed, 25 Sep 2024 12:54:21 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 554D63F64C;
	Wed, 25 Sep 2024 12:53:50 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 0/5] perf cpumap: Correct for perf_cpu_map__merge()
Date: Wed, 25 Sep 2024 20:53:20 +0100
Message-Id: <20240925195325.426533-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_cpu_map__merge() has two arguments, 'orig' and 'other', as
described in its original comment:

"orig either gets freed and replaced with a new map, or reused
with no reference count change (similar to "realloc")
other has its reference count increased."

This causes confusion due to the different reference counting on the CPU
map objects, which complicates its usage and makes maintenance
difficult. We also discussed this in the email [1].

This patch series makes that a new CPU map is allocated for the
merging result, or the reference count is increased if an existing CPU
map is reused. This means that once perf_cpu_map__merge() is invoked,
the caller gains ownership of the resulting map and must release it
with perf_cpu_map__put().

The perf test has been updated accordingly. Tested result is:

  # ./perf test 41
   41: CPU map                            :
   41.1: Synthesize cpu map               : Ok
   41.2: Print cpu map                    : Ok
   41.3: Merge cpu map                    : Ok
   41.4: Intersect cpu map                : Ok
   41.5: Equal cpu map                    : Ok

[1] https://lore.kernel.org/linux-perf-users/3f03541e-6dab-472f-bad9-4cdc0c0dc061@intel.com/


Leo Yan (5):
  libperf cpumap: Correct reference count for perf_cpu_map__merge()
  perf: Release old CPU maps after merging
  perf cpumap: Update CPU map merging test
  perf cpumap: Add more tests for CPU map merging
  perf cpumap: Add checking for reference counter

 tools/lib/perf/cpumap.c      | 11 ++------
 tools/lib/perf/evlist.c      |  4 +++
 tools/perf/tests/cpumap.c    | 55 ++++++++++++++++++++++++++++++++----
 tools/perf/util/mem-events.c |  4 ++-
 4 files changed, 60 insertions(+), 14 deletions(-)

-- 
2.34.1


