Return-Path: <linux-kernel+bounces-279037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8F94B82A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC81D289FDE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B5188013;
	Thu,  8 Aug 2024 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzogCLvv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E47184114
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103274; cv=none; b=Ys2eKn2YEnqeDnr2ZFW22tYRTc369FuvJBPBQoj0jxLJDX7fdf/hSihZiQtYGtfedgbCkVTGAisnA5mEjz9Wi8/epZmMmLncxi8JcEZOib58P0ycjdpR+GF86NbJtd/r+aa5Fc+FgkRzrF8XrMBXO/XXkweytOzhTaR6xa22NgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103274; c=relaxed/simple;
	bh=aLrysMICIZ8rcQbMTNkI3tN5comTbWaiCqJT5h7gI5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wd2h8ca9jEyCvc7Z2lLOvPfv6Dac2x2v190DypBdyERBBKuXTkEi7YPRHt/b6r3zOs88P/l8A4lsvODEPFGKkpKCm1+qP8RO8dEv5wNwxsu1cFEEWbUD8znFn0s1bkN3oWMXh+eL644xrMGwgqijsoe9u0EvvH9TrekCKSnrxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzogCLvv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723103273; x=1754639273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aLrysMICIZ8rcQbMTNkI3tN5comTbWaiCqJT5h7gI5U=;
  b=fzogCLvvGQwK8wDtAfJggNoEwBRx849OTuYa4B0ym4N9GCw1a/L4rNGo
   KWVKe3MhpiqeblPfKlYDeqm7IONnk+NLwOaxPY5NoaAVdTyik/M8z0TeS
   ikzGr0IOwxb5r6yMBe9vjaNgFNC9vChAMFMjSjlDoY7ZS9GYqayUJ80Or
   T1e/fvUkiFd6eA7veb/M7fWhDjmhA7WalblID2TfS21MdPa7BNn93Mlb0
   j6o2D5cHgNbp1fORQBw1AZFEFcRolHADIcykdJwB4c9Bq8h5br3xqL5I/
   fGLHToVODk/DSw4vyhSicWyl2ODeneMjuIEEhFGkeYqMGrQ4eXKLA1PlK
   A==;
X-CSE-ConnectionGUID: Xt8EtryWSuSkwAXgpbeBmQ==
X-CSE-MsgGUID: 7lGroUjXSuSoUS2inYuBfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38720972"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="38720972"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:47:52 -0700
X-CSE-ConnectionGUID: aF5CdXUXQuObz1qHWol4fg==
X-CSE-MsgGUID: yPQcgfVXSWy0NbNY6z6sCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57090927"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2024 00:47:49 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 0/4] Enable PMU for ArrowLake-H
Date: Thu,  8 Aug 2024 14:02:06 +0000
Message-Id: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ArrowLake-H is a specific variant of regular ArrowLake. It shares same
PMU features on lioncove P-cores and skymont E-cores with regular
ArrowLake except ArrowLake-H adds extra crestmont uarch E-cores.

Thus ArrowLake-H contains two different atom uarchs. This is totally
different with previous Intel hybrid platforms which contains only one
kind of atom uarchs. In this case, it's not enough to distinguish the
uarchs just by core type. So CPUID.1AH.EAX[23:0] provides an unique
native model ID for each uarch, this unique native model ID combining
the core type can be used to uniquely identity the uarch.

This patch series introduces PMU support for ArrowLake-H. Besides
inheriting the same PMU support from regular ArrowLake, it leverages
the native model ID to detect the 2nd kind of atom uarch core and
enables PMU support. To distinguish the two atom uarchs in sysfs, the
PMU of 2nd atom uarch is named to "cpu_atom2".

Run basic counting, PMI based sampling, PEBS based sampling, LBR and
topdown metrics tests on ArrowLake-H platform, no issue is found.

Dapeng Mi (4):
  perf/x86: Refine hybrid_pmu_type defination
  x86/cpu/intel: Define helper to get CPU core native ID
  perf/x86/intel: Support hybrid PMU with multiple atom uarchs
  perf/x86/intel: Add PMU support for ArrowLake-H

 arch/x86/events/intel/core.c | 129 ++++++++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c   |  21 ++++++
 arch/x86/events/perf_event.h |  33 ++++++---
 arch/x86/include/asm/cpu.h   |   6 ++
 arch/x86/kernel/cpu/intel.c  |  15 ++++
 5 files changed, 186 insertions(+), 18 deletions(-)


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.40.1


