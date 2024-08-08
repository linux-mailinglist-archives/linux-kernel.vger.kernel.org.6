Return-Path: <linux-kernel+bounces-279039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED4894B82C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF501C24110
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADBF188008;
	Thu,  8 Aug 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7AzptOk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DBF1891A3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103280; cv=none; b=BfBCFPtuwEQCZgjG1k9sgy9yUxrkUgsDzZyHG3BPYI8a+mu3iduf8g541zKzUDoRdVLf810CHhNmupYWMdBE3VSkoAHDLOWIkIPAMb/pfunNIIzgSpXbViz/JEDMQQXORXoxW/CqvhOYKpEQXiJkRVmHxAgSIX3DX38UM2FmHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103280; c=relaxed/simple;
	bh=pqZfyJTJ1/8PqnS8FcutnA0VtCKDLURR0MjAxPAGrxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIsODF15fVj5CpQ2Aqi+Q7dNoNzDR4jtnxN2qae8YqUFsvGhbZnpa/FdgBXF4RiFYE3KvA+sh+AN96gpeAn2W0t28+0OHXqtTwUvEcfmExrOYPAb69uNKVHHtxKWFOj6iGNyHYYkNFsI0fMH3/pv/L+5L65ZOKkeRXVZes2W+EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7AzptOk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723103279; x=1754639279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pqZfyJTJ1/8PqnS8FcutnA0VtCKDLURR0MjAxPAGrxw=;
  b=Z7AzptOkj/E9n8gOsDKi6UJUpo3VJ7c2Jc71a9fyutJRXTQW9h3eUHGc
   IS127Dfq9qHvbmgU710fTS33GFeeO7+fymHteAZlFJc/BGSrJ0N+omhv5
   riourjep6z8pam3DpxM+6ZaBtEUzXpwM1WNLw2tTUqW8P1oS6RDjT0IBh
   1hqHujNwiQBYd6HL9TXS84zDYFfWkXW36j6/qkpgp5LTe37hpejR+KTdE
   w1YBkNBL7pg0SBHryOOZ2woNRLjc0zu+HuzTbdWwb5KBlGSMGG7EyN8eJ
   voXA7SNZoOukK7zhLNW24yPIsFomhl6VKnzBgCMHyWkrooFgAdZnGPhIB
   A==;
X-CSE-ConnectionGUID: EgOqTOLlQ4agufuqFFO8mQ==
X-CSE-MsgGUID: 58oYlVJ/RmmgNal/NznrHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38720986"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="38720986"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:47:58 -0700
X-CSE-ConnectionGUID: n2RKBaqoQ7ikYA9eOH6l/A==
X-CSE-MsgGUID: EEEmD7DnQZ2Q5wQRIVUUeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57090937"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2024 00:47:56 -0700
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
Subject: [PATCH 2/4] x86/cpu/intel: Define helper to get CPU core native ID
Date: Thu,  8 Aug 2024 14:02:08 +0000
Message-Id: <20240808140210.1666783-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
References: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
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


