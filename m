Return-Path: <linux-kernel+bounces-291759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A35956677
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003D61C218BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DEC15CD42;
	Mon, 19 Aug 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnzXFBPR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DA15B12A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058721; cv=none; b=EIxOOY1kB2Q87Xy8JCF1+7jZRCJyxfSkaPVJD62Zvn+NFQ3Sx9MRlIaKkxVVz5CSRJkjT/gXR7S76AdU0Gp6H/P/kTFwompd01gT/bdtR1uTAHgPNkfCiQXLApIjxQppb61VgSRWa4Rxtyb2/EYX8GKC4H8eMLHJggl0NX6Jfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058721; c=relaxed/simple;
	bh=pqZfyJTJ1/8PqnS8FcutnA0VtCKDLURR0MjAxPAGrxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CazLkLyEyO6EOlpu0SauGF1o12GoKbipq9/rB0meKCns9bE0chM9d8dYKOWrYnR7xBwdqk7BBfNysC8wwjDhrDrmVlTqajzIwNoW6SpZLj3tYruDYF7a7nf0QTt3+gtit7RVMG4/twS5nw/VSKRbB4ppzctioG51AnRXE0PVln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnzXFBPR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724058720; x=1755594720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pqZfyJTJ1/8PqnS8FcutnA0VtCKDLURR0MjAxPAGrxw=;
  b=gnzXFBPRneZgzKGQMM1Le9JLucNT66POfz1s1PVwogPNfB65H2to4W3r
   cV60mFQ9M/ovVlRaEvOLyPhWlvr3JDge4usJ8khrJn26a6WVnjeFG9K4c
   loNdBCQxJF0M+v6LNz6RDP/eyYgk1G4iBfE8C4U9uYy41b94c5moZP5a9
   7IPw7tWrKYqjABRWJY48iJT6wfeI87VV0ajSAT9NuNedeB5biIhzxQxyQ
   IOnGGQuxnkmU5nkpV2X+n+NIqPnIoIJW8HenQYcp5SDEaB5JEYmDaz64Y
   +LNIBPeMH7y0hnPQvltqRgpF8arLLuNMtRuquZNjKfnKqCliKsFtoXWi9
   w==;
X-CSE-ConnectionGUID: LbipWh50QEatF52v0JVQ+w==
X-CSE-MsgGUID: zpfJSTBdRHK5IbiZWjQdlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33446098"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33446098"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 02:11:59 -0700
X-CSE-ConnectionGUID: acNDG/XuTvKUDkV5SS4a7A==
X-CSE-MsgGUID: f8kgktYdS2GQDrlhP20YUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="61086717"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa008.jf.intel.com with ESMTP; 19 Aug 2024 02:11:57 -0700
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
Subject: [Patch v2 2/4] x86/cpu/intel: Define helper to get CPU core native ID
Date: Mon, 19 Aug 2024 14:55:41 +0000
Message-Id: <20240819145543.1833126-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240819145543.1833126-1-dapeng1.mi@linux.intel.com>
References: <20240819145543.1833126-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define helper get_this_hybrid_cpu_native_id() to return the CPU core
native ID. This core native ID combining with core type can be used to
figure out the CPU core uarch uniquely.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/include/asm/cpu.h  |  6 ++++++
 arch/x86/kernel/cpu/intel.c | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index aa30fd8cad7f..5af69b5be2fb 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -32,6 +32,7 @@ extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
 u8 get_this_hybrid_cpu_type(void);
+u32 get_this_hybrid_cpu_native_id(void);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
@@ -50,6 +51,11 @@ static inline u8 get_this_hybrid_cpu_type(void)
 {
 	return 0;
 }
+
+static inline u32 get_this_hybrid_cpu_native_id(void)
+{
+	return 0;
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 08b95a35b5cb..dbc457626207 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1297,3 +1297,18 @@ u8 get_this_hybrid_cpu_type(void)
 
 	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
 }
+
+/**
+ * get_this_hybrid_cpu_native_id() - Get the native id of this hybrid CPU
+ *
+ * Returns the uarch native ID [23:0] of a CPU in a hybrid processor.
+ * If the processor is not hybrid, returns 0.
+ */
+u32 get_this_hybrid_cpu_native_id(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		return 0;
+
+	return cpuid_eax(0x0000001a) &
+	       (BIT_ULL(X86_HYBRID_CPU_TYPE_ID_SHIFT) - 1);
+}
-- 
2.40.1


