Return-Path: <linux-kernel+bounces-293141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A68C957B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D76F1C23919
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6BD3AC36;
	Tue, 20 Aug 2024 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfWppJyU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E535280
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118939; cv=none; b=Ba5/KfBWOFi18hSjDitoRQOyoMIOQaV8GGSm/3tVjkIhgxp985zQA3fTxXxlD3ylpBFn/qtYVgkJXKYWlxwZ2qxqq/KisF9ZRLJJnrV+Zl55teALqD43g4c75wUevWVMyo6MT6nnXXBcNrzhanFDq1Qo2aKbQbu30PvW/XFvbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118939; c=relaxed/simple;
	bh=0L/c4bXlFyjgwTDoAzB6FMCS77E5k5i0VDONYeU+Fs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNTify3MEURNkvFxka+gzbWZnr8s98ekpjm3akiKGTrOr2F+YL6ZDex1FwjtdD3RTvRPcINOO+aeU/aR1KVddiDCYSmzPjRCzALFvfRcMMsqlCkGAnmKpiqpi7dVM/kOUq4xDS+Y7MB6V59ypdeqD71hxvU6A85yHEqfTY5qCI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfWppJyU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724118938; x=1755654938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0L/c4bXlFyjgwTDoAzB6FMCS77E5k5i0VDONYeU+Fs4=;
  b=mfWppJyUv6BFhce+7ggeZI6yiCQ7vTS2jooHdWQKSoJp5oyCzQMLMycv
   Hs96lvzoqKbWcCGFuFBjgYeoHY75+VN5dtY3ZnWGGTK1LYRnUakxYFZRh
   Pe/CA2dKEayyvnXjTFaYWL/E+eGJQvl092ofI1M+sZMDJiCinbIZtLXMG
   XIVDUnoMAGLvBqn6rQegkFn1+LWmkGd+MYoapeizjo2IbEDoYQ2ds+sI0
   fju9ZErAyTz2lpQKjSSsM8M9Qj799por6RMPPn/0BofdE04d865cOJZ5n
   /2iiaNVS5sOxAzD4MUwAVl1ZaiThcWmJ5XhqTJqoxjayvJwrCO6S6rtQY
   Q==;
X-CSE-ConnectionGUID: 6PXcAC5yTHWYjJNBJ4cMhg==
X-CSE-MsgGUID: 5Vl+kNm9SICO6a7Rk7xPRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26191799"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="26191799"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 18:55:38 -0700
X-CSE-ConnectionGUID: h5ilPXOaSRqHQJuJ+ZIfQA==
X-CSE-MsgGUID: Hxb5JerYRESWhDRRcIh2FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="83759634"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa002.fm.intel.com with ESMTP; 19 Aug 2024 18:55:35 -0700
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
Subject: [Patch v3 2/4] x86/cpu/intel: Define helper to get CPU core native ID
Date: Tue, 20 Aug 2024 07:38:51 +0000
Message-Id: <20240820073853.1974746-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820073853.1974746-1-dapeng1.mi@linux.intel.com>
References: <20240820073853.1974746-1-dapeng1.mi@linux.intel.com>
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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


