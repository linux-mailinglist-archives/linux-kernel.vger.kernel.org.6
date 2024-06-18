Return-Path: <linux-kernel+bounces-219710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9D590D6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237A428497A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9057B13D53F;
	Tue, 18 Jun 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDLh2KyT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485521D69E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723536; cv=none; b=XIYV4XYaOoES/GLfDhiev5ZroBLDORsv+Dcpppr/AAWzdYGGaUG6a6ftjYWGtMRH2gUvjHIFnPGfBMwEqtbv10Qynp53ks701U5B3y0z89q+GdyIQPM5NtSytdp31iAJ9NFDVKArq8rPJTXbrRMOESJEFQio3Iew/lBLw2LxWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723536; c=relaxed/simple;
	bh=kiewTNom2O47OTfFgOcrJGUfRo6DrcAKHxtaAdWUzTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GdhZInH7VUmwqces6Zt4hm8ZrsEXIsZg6RIGNu/eQX1cwjvAXfFxEkj20kYRZaeFn1W8KpKv5VgPX1/cKBz6LHffpgPI09K4qK1ewI9ibRI/EL6LhRr9LyI7Nff95YMDA51te37VUh5X2GBlnDF6XflfE5umUMEHgsxzBa7UD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDLh2KyT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718723535; x=1750259535;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kiewTNom2O47OTfFgOcrJGUfRo6DrcAKHxtaAdWUzTQ=;
  b=oDLh2KyTUJtj/Chyl839AYqxnm+F0LDr7CE7fRjmAZVOvqf5HngAp/76
   j6WhZKcBsPcfmRvUaHvHuXyc98GVczkIJJUkPrXMMPJX8uPDTNnY4IJ7v
   IWuzjaNoMPs/hJNoA+4mwb05vSuoSvNoPu0me6AKL9t4Q7a4JxlD9MLHb
   CzyJjeRKxoFVRLUDmcBbRlx/WCJyrJMrL1HQHLJD/4aqmbTG1bS2tX4Xr
   hNLt+k6SqMGBgaPzHvOT7TQkP+gzmZkzMVs0r1JUiLPhhLhWqTAK1lnbA
   bc/bIYugIvmm2RM8drKHI4mx67BEWj3MIzc5QP4tY5CujYzYK1f2OOiBo
   A==;
X-CSE-ConnectionGUID: LLJhLg2FS2eO0eWIHBQ3gg==
X-CSE-MsgGUID: lcMDCmNkS/qjRRI8v32H8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15374175"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15374175"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 08:12:14 -0700
X-CSE-ConnectionGUID: vKnAiQhbTd6SK7nWUg7ALg==
X-CSE-MsgGUID: JlX7slZ7SxC+JxQpickPIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41426916"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 18 Jun 2024 08:12:14 -0700
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
Subject: [RESEND PATCH 00/12] Support Lunar Lake and Arrow Lake core PMU
Date: Tue, 18 Jun 2024 08:10:32 -0700
Message-Id: <20240618151044.1318612-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

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

Kan Liang (12):
  perf/x86/intel: Support the PEBS event mask
  perf/x86: Support counter mask
  perf/x86: Add Lunar Lake and Arrow Lake support
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
 arch/x86/events/intel/core.c         | 466 ++++++++++++++++++++-------
 arch/x86/events/intel/ds.c           | 267 +++++++++++++--
 arch/x86/events/intel/knc.c          |   2 +-
 arch/x86/events/intel/p4.c           |  12 +-
 arch/x86/events/intel/p6.c           |   2 +-
 arch/x86/events/perf_event.h         |  81 ++++-
 arch/x86/events/perf_event_flags.h   |   2 +-
 arch/x86/events/zhaoxin/core.c       |  14 +-
 arch/x86/include/asm/intel_ds.h      |   6 +
 arch/x86/include/asm/msr-index.h     |   6 +
 arch/x86/include/asm/perf_event.h    |  27 ++
 include/uapi/linux/perf_event.h      |   6 +-
 kernel/events/core.c                 |  15 +-
 tools/perf/Documentation/topdown.txt |   9 +-
 16 files changed, 810 insertions(+), 254 deletions(-)

-- 
2.35.1


