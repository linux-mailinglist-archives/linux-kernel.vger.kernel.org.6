Return-Path: <linux-kernel+bounces-230967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C646918478
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2A328571C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0BA186E2A;
	Wed, 26 Jun 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zc+mkK1u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B6C136
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412505; cv=none; b=SEbqBnaJD5+pkW8blCgdtWgZOanSaHTZSpwo8sI0lY5buv890VxCAG6xygsFzzwp03+sOLlvbNMotEjYWYArdtoRUcAy7Tk0jCjc78kIMMsGRakc1gJuwtnCUKJaw3P85nXf4PIQPA6UxCZ+GVlj23bVUrCd5r7P2eiaEs56u1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412505; c=relaxed/simple;
	bh=9acWqS97YmBq5pSjJQXxHybgwrwtJ6z6pPo+bkIcMOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LzDHvjI0UR4lHWGGD8P7tIG/bHav9Q7VRT440r2sdWEH6GmmqWs6OAu5ogwQlXaoYE7QuCENH+UPpOviwhmrqFWlkA9IXX/5wZJnX59kzwa5brfAitczU4HFazWndqojyqTbS7wG6a35sFretwkzZ9TFLF+QQavhrAxmPXJzl2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zc+mkK1u; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719412504; x=1750948504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9acWqS97YmBq5pSjJQXxHybgwrwtJ6z6pPo+bkIcMOY=;
  b=Zc+mkK1uXcQzwl8/cnqkShSfc77cDXC1LWRXv474qXeOkjFbCCykA8Vx
   rJDw3uf3KviQEGEnnhUfCk7jWStpMwFEI7Nr+DrALN8RoZFKX7ZnVqvER
   Mku4kY7/YFiJAUB8gxhs23pLPtk1CDwXqRi4T1LVlDJEmj7cXZEyvxAn3
   WtlFPQCYlmbpT/TmbFNDbDuyQz52Ig6Rs3rRx9XkG3iO5cn6eBJViy+/D
   JFyQHI0z60qC2COTRMBrFXnuJK09GITii3j/tvLSxy6E9o/6zwJDPyYQA
   /2vptuNqZq5Fe/CWYr9tCVFrV2zYu9u7akHhPOap7M9BcVRwABGHbbFIZ
   w==;
X-CSE-ConnectionGUID: AQbUmgmIQ5WK8GdnyrLn+A==
X-CSE-MsgGUID: kodlvFQyTwi9tZs+H28sNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="19375515"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="19375515"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:34:45 -0700
X-CSE-ConnectionGUID: Fx/F/QQrRU6KxwQQbWR1aA==
X-CSE-MsgGUID: oHXQOnitSMadjZsy+T2zZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43911946"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 26 Jun 2024 07:34:44 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 00/13] Support Lunar Lake and Arrow Lake core PMU
Date: Wed, 26 Jun 2024 07:35:32 -0700
Message-Id: <20240626143545.480761-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V2:
- Rebase on top of the tip.git. Specifically on top of the below two
  patches.
  commit cd84351c8c1b ("perf/x86/amd: Use try_cmpxchg() in events/amd/{un,}core.c")
  commit d142df13f357 ("perf/x86/intel: Switch to new Intel CPU model defines")
- Add Reviewed-by tag from Ian

Changes since V1:
- Add x86/intel_pmu_max_num_pebs/counters/counters_fixed()
- Rename model-specific pebs_latency_data functions
- Rename V6 counter MSRs

From the core PMU' perspective, the Lunar Lake and Arrow Lake are the
same, which are similar to the previous generation Meteor Lake. Both are
hybrid platforms, with e-core and p-core.

The key differences include:
- The e-core supports 3 new fixed counters
- The p-core supports an updated PEBS Data Source format
- More GP counters (Updated event constraint table)
- New Architectural performance monitoring V6
  (New Perfmon MSRs aliasing, umask2, eq).
- New PEBS format V6 (Counters Snapshotting group)
- New RDPMC metrics clear mode

The details for the above new features can be found in the Intel
Architecture Instruction Set Extensions and Future Features (052).
https://cdrdv2.intel.com/v1/dl/getContent/671368

The counters may not be continuous anymore. Patch 1-2 converts the max
number of counters to a mask of counters. The change is a generic change
which impacts all X86 platforms.

Patch 3-5 supports all the legacy features on LNL and ARL.

Patch 6-8 supports the new Architectural performance monitoring V6.

Patch 9-12 supports the new PEBS format V6.

Patch 13 supports the new RDPMC metrics clear mode.

Only the two features (Architectural performance monitoring V6
and the RDPMC metrics clear mode) add new formats, which impacts the ABI.
The "Sysfs PMU tests" case has covered the non-contiguous format
definition caused by the new umask. The current perf test should be good
enough to cover the ABI changes.

Kan Liang (13):
  perf/x86/intel: Support the PEBS event mask
  perf/x86: Support counter mask
  perf/x86: Add Lunar Lake and Arrow Lake support
  perf/x86/intel: Rename model-specific pebs_latency_data functions
  perf/x86/intel: Support new data source for Lunar Lake
  perf/x86: Add config_mask to represent EVENTSEL bitmask
  perf/x86/intel: Support PERFEVTSEL extension
  perf/x86/intel: Support Perfmon MSRs aliasing
  perf/x86: Extend event update interface
  perf: Extend perf_output_read
  perf/x86/intel: Move PEBS event update after the sample output
  perf/x86/intel: Support PEBS counters snapshotting
  perf/x86/intel: Support RDPMC metrics clear mode

 arch/x86/events/amd/core.c           |  26 +-
 arch/x86/events/core.c               | 123 +++----
 arch/x86/events/intel/core.c         | 471 ++++++++++++++++++++-------
 arch/x86/events/intel/ds.c           | 288 +++++++++++++---
 arch/x86/events/intel/knc.c          |   2 +-
 arch/x86/events/intel/p4.c           |  12 +-
 arch/x86/events/intel/p6.c           |   2 +-
 arch/x86/events/perf_event.h         | 105 +++++-
 arch/x86/events/perf_event_flags.h   |   2 +-
 arch/x86/events/zhaoxin/core.c       |  14 +-
 arch/x86/include/asm/intel_ds.h      |   1 +
 arch/x86/include/asm/msr-index.h     |   6 +
 arch/x86/include/asm/perf_event.h    |  27 ++
 include/uapi/linux/perf_event.h      |   6 +-
 kernel/events/core.c                 |  15 +-
 tools/perf/Documentation/topdown.txt |   9 +-
 16 files changed, 839 insertions(+), 270 deletions(-)

-- 
2.38.1


