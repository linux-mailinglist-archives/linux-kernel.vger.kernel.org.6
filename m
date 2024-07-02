Return-Path: <linux-kernel+bounces-237348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DC891EF87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6448D287B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91412FB39;
	Tue,  2 Jul 2024 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7wQiXUx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619F12E1C6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903362; cv=none; b=u6aKqDJ1wfCY2Cv3P2X0hUSKByOTwNwj5zfG3+xudHNzntC5WL38q8nN9OJNaEaO21T/yOv6/klDc66Q8Na/EeVLMnn/SHgu47vhpz2iQAX1JoICO1pOlhPC5MTni7PyVcQT8H9AW5/R4tXPb7s8hZrtgVxlWVtXFb8DiB+Sr6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903362; c=relaxed/simple;
	bh=dG7WcnqU1MnAsJE6b1Kc0O6TyKO5hB3dIVlYUfwOOyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UH+gNrULYPnN/4rFYef4K4yCZFX43SrJzlAI58ey8Y++cy2iYOFfDoYIlHTqEcnqgbonlcyYdYob1PapvkJ9HiowCSLpMsjAFy4Z3v2HbO59RrkZMUOms2/Ptbizdy5Aejyw7poD21wpfdxHV+drLTXc7SO1QlK6rqXjnUZmmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7wQiXUx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719903361; x=1751439361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dG7WcnqU1MnAsJE6b1Kc0O6TyKO5hB3dIVlYUfwOOyU=;
  b=n7wQiXUxYdCIjfZGmBbVM2i1pNqV0NWz5V3LuQOuuD3JVhbdiRk1Htlp
   DHBozGMQFTGfOnTdjTS5ha6zg0o5tKCDNsKHL+ZcZpsd+h0qVIp28KYCQ
   9y9mxNaSTxDe73GxyIFKbaU8UzVKwedZANTTidKpfIQ4dFAu1+DGM32IZ
   MQKGkCTFuHHpXTjK78j/bWfitfBaLAnsGdE4apEKobkY+Do43Bhbriq+m
   C11XIbf4fojSMHDLFG4mRIY4QYbZ0ETrp/5JyOH3a3KPkHEXOUEy4ndVb
   k9POqQXGwUv/U0wUlLv1G7oACi5rulsqXrCs7DZMn1/C4wEaPmwpvSrh2
   w==;
X-CSE-ConnectionGUID: x/QEADb3RZCmVBOXn/8kGA==
X-CSE-MsgGUID: icqb3RWySUaJR4grfLHonA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="12352636"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="12352636"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:56:01 -0700
X-CSE-ConnectionGUID: 2ePaUZTcTiOzyCaZGd77Nw==
X-CSE-MsgGUID: CWnKZAjAQXuFxZVz/I9quw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50405628"
Received: from unknown (HELO dell-3650.sh.intel.com) ([10.239.159.147])
  by fmviesa004.fm.intel.com with ESMTP; 01 Jul 2024 23:55:58 -0700
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
Subject: [RESEND Patch 2/2] perf/x86: Typos and invalid indents fix
Date: Wed,  3 Jul 2024 06:57:03 +0800
Message-Id: <20240702225703.346951-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702225703.346951-1-dapeng1.mi@linux.intel.com>
References: <20240702225703.346951-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several typos and invalid indents.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 2 +-
 arch/x86/include/asm/perf_event.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 38c1b1f1deaa..9600af53d1bc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3697,7 +3697,7 @@ static void intel_put_event_constraints(struct cpu_hw_events *cpuc,
 	intel_put_shared_regs_event_constraints(cpuc, event);
 
 	/*
-	 * is PMU has exclusive counter restrictions, then
+	 * If PMU has exclusive counter restrictions, then
 	 * all events are subject to and must call the
 	 * put_excl_constraints() routine
 	 */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 7f1e17250546..d54aa3eb65f5 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -399,15 +399,15 @@ static inline bool is_topdown_idx(int idx)
  *
  * With this fake counter assigned, the guest LBR event user (such as KVM),
  * can program the LBR registers on its own, and we don't actually do anything
- * with then in the host context.
+ * with them in the host context.
  */
-#define INTEL_PMC_IDX_FIXED_VLBR	(GLOBAL_STATUS_LBRS_FROZEN_BIT)
+#define INTEL_PMC_IDX_FIXED_VLBR		(GLOBAL_STATUS_LBRS_FROZEN_BIT)
 
 /*
  * Pseudo-encoding the guest LBR event as event=0x00,umask=0x1b,
  * since it would claim bit 58 which is effectively Fixed26.
  */
-#define INTEL_FIXED_VLBR_EVENT	0x1b00
+#define INTEL_FIXED_VLBR_EVENT			0x1b00
 
 /*
  * Adaptive PEBS v4
-- 
2.40.1


