Return-Path: <linux-kernel+bounces-237347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52C591EF86
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB291F23C36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796A212E1E0;
	Tue,  2 Jul 2024 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mzq7sTl6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41E12E1CD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903360; cv=none; b=UacGjP6iTbxAGe0a/DwybQmfztBGhcblEmsg8OeFU0VNuGlCnJIu3yRwDJMqmOzlQVwnPoQhY/ODqh2KucoPZUAmwhrK3rB7p9llB7n2SWrlkwthoc0z/P6PHb7EchAkFbtbxjJds2h48f3TXHm+QYqTnKNG6DVfqdD8AmqkW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903360; c=relaxed/simple;
	bh=916JHf1x7pQxiP1w5zb4l22Bh5FMWLpzdyrqfqetWw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GBtbeh2gJB+37jLcscfOEzIpV7r60CbDRqjruoks1/bu1IxCnpssWYKB/ztVBwqInargpsCpUd8rC7bgRpjet8hyOsrfYN/zMFaUV9rkUjZSdX/htnI53HPk/Dfp8ID6XcrotSYFh4tbROsTYZ8px74mBj491DdvFovHc9bpTyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mzq7sTl6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719903359; x=1751439359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=916JHf1x7pQxiP1w5zb4l22Bh5FMWLpzdyrqfqetWw8=;
  b=Mzq7sTl6Nw3tvoKKPsBz4+BheBwwPAPzbQkrWLN/6QO+NbkzrS5TU+2O
   cIgUdx4sxCK2j0S3k2eJs90JFgyxEWnT2hJbKUdNhBDvLFEiapPbx4h85
   ZAv5ZgWr2mO8nKLZojwssgoB2buVyhrprFRJHjtwq69/H/AJRZGI1hfYC
   VI6Ilx1Ii32qyaqhRSDuc5VxFp6KuQbo/WrBpP5bCntLZXbaHKuQoZkGz
   a6fww/HY8rrcPJpKU+IOIUiZw5Ksm9Ixwx114+XdlMtzXyYcTN38ZYgAq
   fYQclyOigKFHp8/5bqBXmvjikWAantVp/lpqSjLzJDbycY+Yx41+GT9MV
   g==;
X-CSE-ConnectionGUID: pOjzZjUUQMW7s4o1Eywa0g==
X-CSE-MsgGUID: mHY9khdeTIGbnmZaQ6VNbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="12352634"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="12352634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:55:58 -0700
X-CSE-ConnectionGUID: xom5wlJkQTqOoRKLtycdyg==
X-CSE-MsgGUID: DT4JYkzrSzuPBVJIiyOBWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50405617"
Received: from unknown (HELO dell-3650.sh.intel.com) ([10.239.159.147])
  by fmviesa004.fm.intel.com with ESMTP; 01 Jul 2024 23:55:55 -0700
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [RESEND Patch 1/2] perf/x86: Remove perf_events_lapic_init() calling from x86_pmu_enable()
Date: Wed,  3 Jul 2024 06:57:02 +0800
Message-Id: <20240702225703.346951-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_events_lapic_init() helper is called to configure PMI to NMI vector
and clear MASK bit simultaneously by writing APIC_LVTPC MSR. It's called
firstly to initialize APIC_LVTPC MSR by init_hw_perf_events(), and the
PMI handler would always to clear the MASK bit in APIC_LVTPC MSR by
writing APIC_LVTPC MSR directly.

So it becomes unnecessary to call perf_events_lapic_init() again in
x86_pmu_enable(), and worse x86_pmu_enable() could be called very
frequently in some scenarios with very high context-switches. This would
cause performance overhead which can't be ignored especially in KVM guest
environment since frequent APIC_LVTPC writing would cause huge number
of VM-Exits.

For example, in guest environment Geekbench score (running multiplxing
perf-stat command in background) increases 1% and perf-sched benchmark
increases 7% after removing perf_events_lapic_init() calling from
x86_pmu_enable().

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..580923443813 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1347,7 +1347,6 @@ static void x86_pmu_enable(struct pmu *pmu)
 			x86_pmu_start(event, PERF_EF_RELOAD);
 		}
 		cpuc->n_added = 0;
-		perf_events_lapic_init();
 	}
 
 	cpuc->enabled = 1;

base-commit: 73e931504f8e0d42978bfcda37b323dbbd1afc08
-- 
2.40.1


