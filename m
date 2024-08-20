Return-Path: <linux-kernel+bounces-293139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA36957B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD9F1F234EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B311BC4E;
	Tue, 20 Aug 2024 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arS5xy8q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786D208D1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118933; cv=none; b=fARZKDL4cGq6wsKurbhbUCLzwIDCOJMXvOuGPlycLiy9kQH9AlJFTur1f8Cj2jbuePPTTvtD7Wodp5HQ5E8IdAX2SRJk/+LSpIX++qH8Vadm9ajO5UD8WKJGdl8Pnf4voQh3mtiJtSmmSX6Uz6fvurva/8FqsLThiR/mPy2G95k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118933; c=relaxed/simple;
	bh=Fs6hkqs4+nnM/y3MBMIDnu+N1GXOdKH7Gg1wV/jG0vM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mN/i8fLOjh7h2AAIImVwhOG1BPXsbqaGosIPMhb97UR+XkSLXPguPJZw+1va9h/Sx0L1Yd2N1nu+8KBH07gHpJHuoKY+rZ1a+oo1ieNpYTwL7mNcZpGeT1wFhxn518o41NP5EWYYSxZ5398S6e8SQPrl68Kitx0M3rXYGT03mec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arS5xy8q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724118933; x=1755654933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fs6hkqs4+nnM/y3MBMIDnu+N1GXOdKH7Gg1wV/jG0vM=;
  b=arS5xy8qq5g5EYSYJ1bVaF6JueNzHkYdtOrJ4xrmHSuN9R564zNQ+3mf
   gkZa160vUmXSju1gCiyJ0kShhD07GVz3W1a+DIrzjiOhE2vKXVkAna+e7
   6/tvJsKmakSqrvPp6R8pujemRHVE8D55WEx9P2RFA1W/7vDBoqL2CRMQ1
   IgVJN9vzdoG+rFOFgKJK3eX/WTrO4WnpzfaNHzJpWvszc2sTiSBEbi2M+
   CWONp5mDBgjz+BZKvMscfy/YwgXYSZqT/P9aePcliKxqcKepcbBVZ2Nr9
   bOJvrEsfLPoj+uE3dC6pE35o7hm49aSOPknVjDc1EdF3IGruoBhBpcTd3
   A==;
X-CSE-ConnectionGUID: puZdpvK1QRy1mH6clZHPtw==
X-CSE-MsgGUID: Cn34mRU7SECNa0E31nuwJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26191770"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="26191770"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 18:55:32 -0700
X-CSE-ConnectionGUID: QO16maRRRdyvDAKhmK9b6A==
X-CSE-MsgGUID: 8Gx4zTJ9RbGFSxmVhiM7Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="83759616"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa002.fm.intel.com with ESMTP; 19 Aug 2024 18:55:28 -0700
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
	Yongwei Ma <yongwei.ma@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 0/4] Enable PMU for ArrowLake-H
Date: Tue, 20 Aug 2024 07:38:49 +0000
Message-Id: <20240820073853.1974746-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No code changes comparing v2, just add back the missed reviewed-by.

Changes:
  v2 -> v3:
    * Add Kan's review-by.
  v1 -> v2:
    * Change PMU name of 2nd atom uarch cores to "cpu_lowpower" (Peter)
    * Rename "hybrid_small2" to "hybrid_tiny" (Peter)
    * Rebase to 6.11-rc4

History:
  * v2: https://lore.kernel.org/all/20240819145543.1833126-1-dapeng1.mi@linux.intel.com/
  * v1: https://lore.kernel.org/all/20240808140210.1666783-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (4):
  perf/x86: Refine hybrid_pmu_type defination
  x86/cpu/intel: Define helper to get CPU core native ID
  perf/x86/intel: Support hybrid PMU with multiple atom uarchs
  perf/x86/intel: Add PMU support for ArrowLake-H

 arch/x86/events/intel/core.c | 129 ++++++++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c   |  21 ++++++
 arch/x86/events/perf_event.h |  34 ++++++---
 arch/x86/include/asm/cpu.h   |   6 ++
 arch/x86/kernel/cpu/intel.c  |  15 ++++
 5 files changed, 187 insertions(+), 18 deletions(-)


base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.40.1


