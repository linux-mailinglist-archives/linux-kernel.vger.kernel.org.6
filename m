Return-Path: <linux-kernel+bounces-297943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB4595BF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C344B228CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DF61CF29B;
	Thu, 22 Aug 2024 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGsntdyJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBE31BF3A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358300; cv=none; b=BUf8J+o6lJiSu6n3pEIEM3reKLpgifb/ZUAGYW6SpEkO9PdRaWmIebwIRbMYpZRxvXxkoyrvv1mmruG8Ax/F7F2LR+8OBAXx8DZZXRhW0m42ISQdpc7X55PxokWWy/qTB+WD5SetIVMkDuMajx1kcRnRCAnMbCsd5KqCln9ks8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358300; c=relaxed/simple;
	bh=ODXxwWsZRuB/xaOJxWZoPoyhHYrEBnJSvP9txjZBXHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JuIM5NEXQ5gjAOot4OyH/zFRdPO4phLaboPhIMpGTim9owq6E9CjgLCXrNBO3bKT6WzDNGKqyvG13hd+yIE5+HagdGpp80Pkv2J3k4f07L8J5FTckqfANJWjkbdl2mKdm2hLN0Y38n4G5pPVHvJUxZyjqwchV7cJsyq26/E3rcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGsntdyJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724358298; x=1755894298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ODXxwWsZRuB/xaOJxWZoPoyhHYrEBnJSvP9txjZBXHQ=;
  b=HGsntdyJ9Svb7y3ogsXU9vSY8UGdfemKe7wuGQZ1NkEjiSnPoDfRSQoO
   WxT9Vr2MhktqZ+0bqkbU42/dnhuORs7E8LVsgyJe137wz9dgK2QamSnkn
   cD9hWbZmsp7lYAcJTKloXL1xCMUzZW4m8my0jaxmYYZgKgs06snqaoohM
   zO1p/stEai+i9d9+SVSfC0nJxQ2ggQuhdDgjgUIg0gFNy6IE/hRDpqOkk
   As1wyVqFTJdA7i8W5I7lu2yYZEE+WnPFrKxBgMavCVaMHJNYjxiAPdh5a
   Hf7S/dEh8fi8WLaVNaaQOR4hlT9CJxS2Bn4UpHshh3tY4przS0AaoLPmd
   g==;
X-CSE-ConnectionGUID: BhwQMryPQ0OXycnSOxOZlg==
X-CSE-MsgGUID: U4S71afBSO+o/HO6nBJIng==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22927276"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="22927276"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 13:24:56 -0700
X-CSE-ConnectionGUID: lUup3UHkQUCrp1fUWM7sbg==
X-CSE-MsgGUID: MRdPn298RpSa8ddmTdj5BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="61242295"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa006.fm.intel.com with ESMTP; 22 Aug 2024 13:24:55 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Eric Biggers <ebiggers@google.com>,
	Xin Li <xin3.li@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] x86/cpufeature: Add feature dependency checks
Date: Thu, 22 Aug 2024 20:22:26 +0000
Message-Id: <20240822202226.862398-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the cpuid-deps[] table is only exercised when a particular
feature gets explicitly disabled and clear_cpu_cap() is called. However,
some of these listed dependencies might already be missing during boot.
Unexpected failures can occur when the kernel tries to use such a
feature.

Therefore, add boot time checks for missing feature dependencies and
disable any feature whose dependencies are not met.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
Arguably, this situation should only happen on broken hardware and it may not
make sense to add such a check to the kernel. OTOH, this can be viewed as a
safety mechanism to make failures more graceful on such configurations in real
or virtual environments.

I feel since we already have the cpuid-deps[] table and the incremental changes
are small, this patch might be a useful addition.

Also, if this check seems worthwhile, would it be useful to combine and rewrite
it with filter_cpuid_features() since it tries to do something similar?
---

 arch/x86/include/asm/cpufeature.h |  1 +
 arch/x86/kernel/cpu/common.c      |  4 ++++
 arch/x86/kernel/cpu/cpuid-deps.c  | 10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 0b9611da6c53..347ef04f65ef 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -148,6 +148,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
+extern void filter_feature_dependencies(struct cpuinfo_x86 *c);
 
 #define setup_force_cpu_cap(bit) do {			\
 							\
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..6b725dbd8db7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1602,6 +1602,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 		c->cpu_index = 0;
 		filter_cpuid_features(c, false);
+		filter_feature_dependencies(c);
 
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
@@ -1854,6 +1855,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Filter out anything that depends on CPUID levels we don't have */
 	filter_cpuid_features(c, true);
 
+	/* Filter out features that don't have their dependencies met */
+	filter_feature_dependencies(c);
+
 	/* If the model name is still unset, do table lookup. */
 	if (!c->x86_model_id[0]) {
 		const char *p;
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b7d9f530ae16..88b34a97278a 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -147,3 +147,13 @@ void setup_clear_cpu_cap(unsigned int feature)
 {
 	do_clear_cpu_cap(NULL, feature);
 }
+
+void filter_feature_dependencies(struct cpuinfo_x86 *c)
+{
+	const struct cpuid_dep *d;
+
+	for (d = cpuid_deps; d->feature; d++) {
+		if (boot_cpu_has(d->feature) && !boot_cpu_has(d->depends))
+			do_clear_cpu_cap(c, d->feature);
+	}
+}
-- 
2.34.1


