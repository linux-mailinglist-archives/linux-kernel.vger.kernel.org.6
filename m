Return-Path: <linux-kernel+bounces-172545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9798BF356
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CB928B9E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4421EAFA;
	Wed,  8 May 2024 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PelcyOD8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66E1A2C02;
	Wed,  8 May 2024 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127002; cv=none; b=PMQ56N72Nhpja3cqWCn3pKHuPtLL3FdsI4f0gFKFQdtxVE+lPYtT2rdioLpvPEiYYvJlSl7Bx7fpx3JfpUrO25Bg0T1rbs80mesFypS6krG982W/Am5yrJn1Q0LOjpsvbYHWPkmmY6hCa1hC5rvChbyiWKvpEraTKvTfRSyajD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127002; c=relaxed/simple;
	bh=BMYB6GrdTF0ESBfyYIuH1/LQgNrQo2990o5hHbH2KNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9oCOfly7Hym0rhL5TJ1wAST6Hyd0JUvtGitSetEvBlmn7WiXK/ILiuUhz3OI2c/Fr9UPOS3u4sCC87o6oava+nfkTj+a/GkOEqSlcVD4QJqQs+TH6j/EmHHU5dta3482UXUfC16g5N1jCBX58XhMUGQnBhhPgOjlFb88EX7xuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PelcyOD8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715127000; x=1746663000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BMYB6GrdTF0ESBfyYIuH1/LQgNrQo2990o5hHbH2KNM=;
  b=PelcyOD8BKmB4zVgziFWhNXNF8bSlimwAZSBlJKpcj2YNRnP5KZvz6W8
   KyKuEmnqTnX2HfaG9v146B2hNi/ITYQfIIXdGjgCR8ph+6afTiM87PnDM
   Hof/+iGAUeVpaDaOATWGlI8WhQ1vo5394avW74lL4CQDhE1105busgTS9
   Hs75XZaWv04aCm2qlgh9c4LPON4wLboJrGI5nGx3u6fyj1L7L04dYghwY
   FIujAn1Cgwu8F2Zhr4hrN3hPRl/rLZ/516ttPXGdNUrTXZCbFV7GnXyTN
   tj+5/35ZtQhKYdYwE5THKe+uKzCey9zg0firexVmqewcFuzUFyuI+AVdL
   g==;
X-CSE-ConnectionGUID: IBheI8fDRPen0OIFI9G7jg==
X-CSE-MsgGUID: Dpbscn0oT4KDIzDWgm+CbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10898744"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10898744"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:09:59 -0700
X-CSE-ConnectionGUID: zIKibQ7rQYqml7JWeTPykA==
X-CSE-MsgGUID: ebU8ZyfpRzaUTctwA+/iQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29108945"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 07 May 2024 17:09:59 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	platform-driver-x86@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	ashok.raj@intel.com,
	jithu.joseph@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to initialize AMX state
Date: Tue,  7 May 2024 16:53:43 -0700
Message-Id: <20240507235344.249103-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507235344.249103-1-chang.seok.bae@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The In-Field Scan (IFS) test [1] is a destructive process, overwriting
the existing state to test the logic on the fly. As part of this test
process, the architectural state is saved before the test begins and
then restored upon completion.

However, due to resource constraints in storage, AMX state is excluded
from the scope of state recovery. Consequently, AMX state must be in its
initialized state for the IFS test to run.

When AMX workloads are running, an active user AMX state remains even
after a context switch, optimizing to reduce the state reload cost. In
such cases, the test cannot proceed if it is scheduled.

System administrators may attempt to mitigate this issue, by arranging
AMX workloads not to run on CPUs selected for the tests. However, this
approach is disruptive for managing large-scaled systems, diminishing the
benefit of the live testing.

The kernel can help by properly initializing the state before the test.
This initialization impacts the performance to some degree. But, this
approach is considerably cheaper than adding hardware resources and
simpler than a userspace approach.

While fpu_idle_fpregs() can initialize the AMX state, its usage should be
limited to specialized cases, primarily before entering the sleep state.
The restore_fpregs_from_fpstate() function offers a suitable mechanism
for initializing fpstate in general, which remains within the core code.

Extend kernel_fpu_begin_mask() to allow the IFS driver to initialize AMX
state through restore_fpregs_from_fpstate().

[1]: https://docs.kernel.org/arch/x86/ifs.html
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V1 -> V2: Revise the changelog (Dave Hansen and Ashok Raj).

The recently published IFS documentation [2] elaborates its purpose and
the requirements of the context restoration after the scan test.

Additionally, the necessity for AMX initialization is emphasized in the
Intel Software Development Manual as of March 2024, in Section 18.2 of
Vol.1.

Side note: restore_fpregs_from_fpstate() also sets the x87 state to a
fixed value. However, this only applies to AMD CPUs with the FXSAVE_LEAK
quirk.

[2] IFS Technical Paper: Finding Faulty Components in a Live Fleet
    Environment
    https://www.intel.com/content/www/us/en/content-details/822279/finding-faulty-components-in-a-live-fleet-environment.html
---
 arch/x86/include/asm/fpu/api.h | 1 +
 arch/x86/kernel/fpu/core.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index a2be3aefff9f..67887fc45c24 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -25,6 +25,7 @@
 /* Kernel FPU states to initialize in kernel_fpu_begin_mask() */
 #define KFPU_387	_BITUL(0)	/* 387 state will be initialized */
 #define KFPU_MXCSR	_BITUL(1)	/* MXCSR will be initialized */
+#define KFPU_AMX	_BITUL(2)	/* AMX will be initialized */
 
 extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
 extern void kernel_fpu_end(void);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1209c7aebb21..04cc6f14ca42 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -440,6 +440,9 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 
 	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
 		asm volatile ("fninit");
+
+	if (unlikely(kfpu_mask & KFPU_AMX) && boot_cpu_has(X86_FEATURE_AMX_TILE))
+		restore_fpregs_from_fpstate(&init_fpstate, XFEATURE_MASK_XTILE);
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
 
-- 
2.34.1


