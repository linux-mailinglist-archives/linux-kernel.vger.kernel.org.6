Return-Path: <linux-kernel+bounces-214956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9759F908CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967561C230B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0A379E1;
	Fri, 14 Jun 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcElkRG1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244787464
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372872; cv=none; b=DKYvV25fYcrJWOA29P12nXlWsrmYnsiqAYxhkTN1t99TZX261XXud9crNmZFRQYkY16jfTi7nsHoToUPAJ+LtYyIEw/ah5PKQaet//Ymm4quITJ+IEHE1mghI+enqGI0JceqG31QMyju6HZxI+g4gcH/48Lp1lt0Gm/cVUAUIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372872; c=relaxed/simple;
	bh=X5lWuRC9cQCfM/Lx3VW6kbFigETvm9nUWQ204bvMWeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mRPLIM9LF5ZGCjWiQFb6cwThFYUtPcBRJRuAyl2dodOmxVKKuQoBslD0fLn2wO9GeiTr/j6Mqz4fbqa0A2GmE62SFLz7jGngl9IYVoHPjamIpJXUj5NPKylCfJDXYojX8qiTGMMFt8JBXupoPBh5Vk716L6Jb307rKs2Bw0Rz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcElkRG1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718372872; x=1749908872;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X5lWuRC9cQCfM/Lx3VW6kbFigETvm9nUWQ204bvMWeE=;
  b=KcElkRG1slineCGb5C1FM9YOxY/xOoHnUW5EWnI9X+5gtK40ddwgNgBz
   hUhFqNS7pDjDgfwPpubc9ZD/B2XY5ph7ZSiOKZ6pPHIUOi5lQMUEUlRp9
   +pHsfbBMcfJG11rshEUZE2vuUzGtTu9jOCJgkp6DDUsGk9fO2uW3oQ1bR
   gstPaSPIORvrvwryN7CPyr5EnoG5rGVH4pa9it5a0wimWpdGMKaBGqcp5
   lX2FklI75snSihDoUL+yzaIAucynWgf/uX+BKTDTx/09TMKG+U1uo2IUd
   odO25DxKPQ/m5oMPtllx4S38hU/igR7ykF+iDrS+btVNZ17CMnbeKSvth
   A==;
X-CSE-ConnectionGUID: XgewpyPISG+3daMjBX7Onw==
X-CSE-MsgGUID: nYdOF6ZVQvehnVedOX5c1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19079142"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="19079142"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:47:51 -0700
X-CSE-ConnectionGUID: Dvl8LunhQc++GEFUGFdTdg==
X-CSE-MsgGUID: XosrriLTStKbB5UnHxAzbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40386661"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jun 2024 06:47:50 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	eranian@google.com,
	ak@linux.intel.com,
	yunying.sun@intel.com,
	tim.c.chen@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/8] Support HBM and CXL PMON uncore counters
Date: Fri, 14 Jun 2024 06:46:23 -0700
Message-Id: <20240614134631.1092359-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V2:
- Update the description of patch 1 to explain the design of the new
  RB tree. (Tim)

The uncore PMON information of both HBM and CXL can be retrieved from
the discovery table. However, the CXL entries break the driver's
assumption for the discovery table. The first 7 patches update the
generic support of the discovery table. The last patch enables the HBM
and CXL PMON uncore counters.

The discovery table support was introduced since commit edae1f06c2cd
("perf/x86/intel/uncore: Parse uncore discovery tables"). It's a
self-describing mechanism for the uncore PerfMon hardware. By reading
through an MMIO page worth of information, SW can ‘discover’ all the
standard uncore PMON registers.

The entire discovery table could be big and contain duplicate
information. To save space, the perf uncore driver only stores some key
data. Others are calculated from the key data. The driver further
assumes that the uncore PMON units are symmetric among dies.
So only the unit control addresses on Die 0 are completely stored.
The addresses on other Dies can be calculated via the address of the
first entry on the Die + a fixed offset.

However, it doesn't work for the CXL PMON units. The CXL PMON units
could be asymmetric among Dies. The offset between CXL PMON units may be
different on different Die.

To address the issue, the complete unit control addresses for all
Dies are stored in an RB tree. For a 2-socket EMR, it requires
at most ~6KB extra space, which should be acceptable.

Kan Liang (8):
  perf/x86/uncore: Save the unit control address of all units
  perf/x86/uncore: Support per PMU cpumask
  perf/x86/uncore: Retrieve the unit ID from the unit control RB tree
  perf/x86/uncore: Apply the unit control RB tree to MMIO uncore units
  perf/x86/uncore: Apply the unit control RB tree to MSR uncore units
  perf/x86/uncore: Apply the unit control RB tree to PCI uncore units
  perf/x86/uncore: Cleanup unused unit structure
  perf/x86/intel/uncore: Support HBM and CXL PMON counters

 arch/x86/events/intel/uncore.c           |  97 ++++---
 arch/x86/events/intel/uncore.h           |   8 +-
 arch/x86/events/intel/uncore_discovery.c | 306 +++++++++++++++--------
 arch/x86/events/intel/uncore_discovery.h |  22 +-
 arch/x86/events/intel/uncore_snbep.c     | 128 ++++++++--
 5 files changed, 388 insertions(+), 173 deletions(-)

-- 
2.35.1


