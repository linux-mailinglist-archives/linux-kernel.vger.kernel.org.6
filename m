Return-Path: <linux-kernel+bounces-269372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDF943227
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1F0281CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CD81BBBDC;
	Wed, 31 Jul 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0zN1AA3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3B1BBBD5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436676; cv=none; b=QoDzo0hjjL+Q3QwFPhKRj8cipps2T32FlGz5qSrXQMZWmUng7cEqFsdFw6q05ja2IQpQk4HOSgBwnE/Ec1SKyizefs5A+rDb/Q1eshB2n+X8Bw/EyAi4Ey4dHRUNgT7MYcdMmgUiBDO/V95JvgoluBwm3E0yxpANhV5GLSV+KBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436676; c=relaxed/simple;
	bh=ocK8I5MRnB/BavWNEJvdK0kaxoLu8jgyDj/VE96icl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hIRgRtRfXqng0IduI4dIICKOKX2FoGWYzv76alUfDyC616Ig9mB4xCKdhnj9lylmaZEuRsCHLk/7P5jdf5Clx7+/g42EG1FU4NQxSzMLMBYqJ1sjxZsp2Or0MO7BAp/BBH1754VmKMLOvDH/WXFPtz0jBkHawtNFg6344EFE0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0zN1AA3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722436674; x=1753972674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ocK8I5MRnB/BavWNEJvdK0kaxoLu8jgyDj/VE96icl0=;
  b=S0zN1AA3PulSwik8Hv164AeYUJkHwwfHNz19Dypo1qakQ1miPP0v8iQH
   sCmlBZ9ee7198HjfYBXFhlmP0qGM3OeifGLJvdLcY4NB15Hc1XYTSajv9
   r6fqdEx243qFy8KQUEA8+z8yI/DBro4Y4KCKW4bCXpWxPF9ZipMIzAsNU
   N+gyeQNgnHcOtk3QooUeGL4/M/RFQqtLRIm8cEraAHRLfosVDg0ObEXX6
   vLzt8TFP6M3uDBG/54Io0auwDXTIz+sQ2hDa+RbyXiInVrNs2SwRcrdWX
   e2vb2aVvlFgf0aB7O+MQw7s9YIPXeEgup4hGEl3y5soDe7cngtYFUvsLM
   w==;
X-CSE-ConnectionGUID: D+10kj/bTrS+aKoByTSEOw==
X-CSE-MsgGUID: jv+fgG1QSJOKJurDDE8Ccw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="37835845"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="37835845"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:37:53 -0700
X-CSE-ConnectionGUID: M3nz2vDTS6e6+6c7Vgk5DA==
X-CSE-MsgGUID: XLljP2i8QIaBIl1EKamFkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54698382"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa009.jf.intel.com with ESMTP; 31 Jul 2024 07:37:53 -0700
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
Subject: [PATCH V4 0/5] Support Lunar Lake and Arrow Lake core PMU
Date: Wed, 31 Jul 2024 07:38:30 -0700
Message-Id: <20240731143835.771618-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V3:
- Rebase on top of the 6.11-rc1
- Remove the patches which has been merged.
V3 can be found at
https://lore.kernel.org/lkml/20240626143545.480761-1-kan.liang@linux.intel.com/

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

Kan Liang (5):
  perf/x86: Extend event update interface
  perf: Extend perf_output_read
  perf/x86/intel: Move PEBS event update after the sample output
  perf/x86/intel: Support PEBS counters snapshotting
  perf/x86/intel: Support RDPMC metrics clear mode

 arch/x86/events/amd/core.c           |   2 +-
 arch/x86/events/core.c               |  13 +--
 arch/x86/events/intel/core.c         |  93 +++++++++++++++-----
 arch/x86/events/intel/ds.c           | 122 ++++++++++++++++++++++++---
 arch/x86/events/intel/p4.c           |   2 +-
 arch/x86/events/perf_event.h         |   8 +-
 arch/x86/events/perf_event_flags.h   |   2 +-
 arch/x86/events/zhaoxin/core.c       |   2 +-
 arch/x86/include/asm/perf_event.h    |  19 +++++
 kernel/events/core.c                 |  15 ++--
 tools/perf/Documentation/topdown.txt |   9 +-
 11 files changed, 236 insertions(+), 51 deletions(-)

-- 
2.38.1


