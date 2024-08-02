Return-Path: <linux-kernel+bounces-272697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFC94600A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7DC1F2314A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEC121C16B;
	Fri,  2 Aug 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePP/CUrv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB30E20FAB5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611761; cv=none; b=fTjFSm3JC1prUJCIN0Lj+iZLm93+98Qasw30+MtPsTpWITCrM7+bgcloeTLQqxlz3sTEHFE0zjWV7ZUX+rgUKcC8NIw5GQ01CQq9gUqDFIx6lS3ggrMbMJjDBCsJCUMT8GKuNpI91f/NxH1qqZj5r0BzYuMpaib/1dXGhNgh/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611761; c=relaxed/simple;
	bh=PpAcpAVDVkKF4KmgfzNR4dgg+sTFJr4Xk7f+vDDE6/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hpqwz+2L9fuRDCnIsPrnGJzdmJ04VUINk7XDMJmC6S8+oGlg4F7h+GZodoioM5Xa9C+QasMqWo5qLEY76UrjXYWfHJf8b0Ok8Pdk5cFCIbhSEajD6GENlRcIde49ikHNlDLJXGmxdrkRruE4u2jKQo3WLKH/szHXz86oDDPXop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePP/CUrv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722611760; x=1754147760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PpAcpAVDVkKF4KmgfzNR4dgg+sTFJr4Xk7f+vDDE6/c=;
  b=ePP/CUrvo6v4BEWuX07kqF6s1GTRZs91hAuy9dNAuCNOD5SVt+bE6ZbB
   OAfodsblhRbuDDaPIkJFWTXVngMQWZTXnRgsLCweTzGJtLGLHW25MMjEZ
   2h/cmQzcaL2tSkBaGqzONq1eoa9iitqiU+E+jCrjY6wZ7d7E9lIFHvCmS
   jjme/bdp1pIXAkGIJlW3beVtxJj/3/iDxfeNY0t6VO4SvCtW7YNYvNK8G
   BAcZn321WMJSKVVclkLWBpNx7opQq9O75jjnGpyuIAs6MhgClzCCTNQ0Y
   bWd3HlB+UDQ2Djqvd9k/hgnT6ePtk2A59OvSzoaFT/kijzBwEetB90H7o
   Q==;
X-CSE-ConnectionGUID: mBPYhPHgQ02mBBQ04GlYTg==
X-CSE-MsgGUID: mjK1DlHTSHSOA3fObOgGyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20473754"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20473754"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:15:59 -0700
X-CSE-ConnectionGUID: wnPu3v0ZShW6x7JJFrvvjA==
X-CSE-MsgGUID: FyMPbt2CSXmd+1O8+hikxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55516927"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 02 Aug 2024 08:15:58 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/7] Generic hotplug support for a PMU with a scope
Date: Fri,  2 Aug 2024 08:16:36 -0700
Message-Id: <20240802151643.1691631-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The perf subsystem assumes that the counters of a PMU are per-CPU. So
the user space tool reads a counter from each CPU in the system wide
mode. However, many PMUs don't have a per-CPU counter. The counter is
effective for a scope, e.g., a die or a socket. To address this, a
cpumask is exposed by the kernel driver to restrict to one CPU to stand
for a specific scope. In case the given CPU is removed,
the hotplug support has to be implemented for each such driver.

The codes to support the cpumask and hotplug are very similar.
- Expose a cpumask into sysfs
- Pickup another CPU in the same scope if the given CPU is removed.
- Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
- In event init, always set the CPU in the cpumask to event->cpu
- Usually, an event can be read from any CPU of the scope. (For now,
  it is only supported by the pkg scope PMU, via
  PERF_EV_CAP_READ_ACTIVE_PKG, e.g., cstate_pkg, rapl, etc)

Similar duplicated codes are implemented for each such PMU driver. It
would be good to introduce a generic infrastructure to avoid such
duplication.

The patch series introduce 5 popular scopes, core, die, cluster, pkg,
and the system-wide. The PMU drivers for cstate, iommu, idxd and rapl
are updated to apply the new infrastructure. The new infrastructure
can also be applied for other PMU drivers from different ARCHs as well.
But I don't have such platforms. It's not done in this patch series.
They can be added later separately.

The uncore driver isn't updated either. Because a per-PMU cpumask is
required since commit c74443d92f68 ("perf/x86/uncore: Support per PMU
cpumask"). Since different types of PMU share the same hotplug codes,
more factor out works and verification are expected. The cleanup of the
uncore driver can be done later separately.

Kan Liang (7):
  perf: Generic hotplug support for a PMU with a scope
  perf: Add PERF_EV_CAP_READ_SCOPE
  perf/x86/intel/cstate: Clean up cpumask and hotplug
  iommu/vt-d: Clean up cpumask and hotplug
  dmaengine: idxd: Clean up cpumask and hotplug
  perf/x86/rapl: Move the pmu allocation out of CPU hotplug
  perf/x86/rapl: Clean up cpumask and hotplug

 arch/x86/events/intel/cstate.c | 140 +-------------------------
 arch/x86/events/rapl.c         | 119 ++++++----------------
 drivers/dma/idxd/idxd.h        |   7 --
 drivers/dma/idxd/init.c        |   3 -
 drivers/dma/idxd/perfmon.c     |  98 +-----------------
 drivers/iommu/intel/iommu.h    |   2 -
 drivers/iommu/intel/perfmon.c  | 111 +--------------------
 include/linux/cpuhotplug.h     |   3 -
 include/linux/perf_event.h     |  21 ++++
 kernel/events/core.c           | 176 ++++++++++++++++++++++++++++++++-
 10 files changed, 229 insertions(+), 451 deletions(-)

-- 
2.38.1


