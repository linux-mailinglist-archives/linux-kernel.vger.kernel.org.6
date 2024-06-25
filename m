Return-Path: <linux-kernel+bounces-229484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04094917011
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2009282448
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A653317920C;
	Tue, 25 Jun 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZFqtsyv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD36177991
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339744; cv=none; b=LNloypdGWQ5nGCESGiX411sAZRKN/ghbCNOvhH5zxr63dLDXUCvj4Sik0pONSI3qbSfFAyyhn3qlUmD3NjtMiO/nxjn4vwA3QTHS3+SfFj7qPnFZt/XVxGdKczR6odK5GxblFXlgSH/TMD42YdT8F/RPpPrXOZk7edTV/9/DbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339744; c=relaxed/simple;
	bh=NDsKJjM1+/sb4dcr6+emp79NbvKrO+USMDDr9jVi1XY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B+rJu9Dg+tn98ReSIDAlhI9JuJMP5caK+5g9oav2DQAiMXTYVvMula4nEjG6DfhbjgYPb/XxZbQAy6lBhuJRZ4PYumuOG//tQagZxHalBMS8mxp0UeJ3O9vR7DptJXnVKtFID1oDmUqNPqgdu18nnnLmD2EPfrv0vt0eFjRieKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZFqtsyv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719339743; x=1750875743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NDsKJjM1+/sb4dcr6+emp79NbvKrO+USMDDr9jVi1XY=;
  b=XZFqtsyv7Hh9dMagfRUV/cdn7vCbz5N++RXR/Z6SdLN3pSQukAXz1nUd
   hmlZ0o7F82Eqivro/raKmZeU9wjHtqIW1a0m07cNU7Kr304cEOPmGQigA
   bhlZ3UdAYk0c8H9qNLgc4nXfWntEZBTRacIOgBSjFZ2XyhrGsTmm9ptES
   pHjgNabsLbRyZDx2Wsj0cMAjLDv4LHCtObtMJl1vYaKh7oBDlAVC9bKNR
   VDrgvvCM1N4YpDckqNXzhQolYzB2j23AyJOmCijWEy5II3qVjIHYrckeZ
   BIV3mKxKlq9LozOcVqwEjbhaK9rAkoCvc58rDP7v+K/zZ+I0DLP3xwMSO
   Q==;
X-CSE-ConnectionGUID: w3TMLU0PSFuFJGCuMw4Pmg==
X-CSE-MsgGUID: gAHQ6Dj4Q6yyaS78nt0UyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16203981"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16203981"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:22:21 -0700
X-CSE-ConnectionGUID: YF3Emd0ETeuFVmsvOpreeQ==
X-CSE-MsgGUID: /7aVxB55St22KdnfsKBJ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48913338"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa004.jf.intel.com with ESMTP; 25 Jun 2024 11:22:06 -0700
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
Subject: [PATCH V2 00/13] Support Lunar Lake and Arrow Lake core PMU
Date: Tue, 25 Jun 2024 11:22:43 -0700
Message-Id: <20240625182256.291914-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

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

Patch 3-4 supports all the legacy features on LNL and ARL.

Patch 5-7 supports the new Architectural performance monitoring V6.

Patch 8-11 supports the new PEBS format V6.

Patch 12 supports the new RDPMC metrics clear mode.

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
2.35.1


