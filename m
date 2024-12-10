Return-Path: <linux-kernel+bounces-440441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12D9EBDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF41284008
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CED1F1907;
	Tue, 10 Dec 2024 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkpIqAVJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938C1EE7BC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870553; cv=none; b=WsgEOEQf+js0GbxOtHh5Gmp5t6rNNyThWw1TSQx2cuo4dujhpPFwMcgM3Tp8WcuXx1HwDkiR8HvrUHK/u1ojhQm6XhpLOo6tgsEabrfKRo8uXre6NrKy/3fvci114xXhTl94evqe8NPSQ015MCk2JRNXHEV+p7mXaGxA367vbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870553; c=relaxed/simple;
	bh=LjRgyjkMHvKNuBg5ABubkFCQGFOmuTn88Eoyif7AetA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zq2wJISgCg7ww6cJIRY/0gaA3Acd2w8UxSbQYfL1PV4MjRB+8EsoqZUFmRMgDWTJ/eLk9jQ+PHBBJRBbriZIOfQtNoMXev40qXuP4k/kAA7rjPWaYxsnGgl0cBqrorFodRgmEXDF9zFCOwSMmORVVMGmJpGb8xTSQgR9bkv7O6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkpIqAVJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733870551; x=1765406551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LjRgyjkMHvKNuBg5ABubkFCQGFOmuTn88Eoyif7AetA=;
  b=ZkpIqAVJBZTos4o5AcjL+Z0gh2kmEWisaILkfmBUD+zOEfWF27648Npi
   jgzQuBY1dYgzt3zR4fjINYvVnvhwwR/+du59zVjWf3AzPWHGbGh69Jbc4
   IZ8Zwn0Kl02KYqWhW3ZJICxr4E5sq2TsB5n6vY4hIKf+hioJVmExNYcC5
   LwTYqvAEc4++T7XMDKBJYoN0zKnkvjjC87Pk7fQoNinMbXNhrEJhDqo3F
   q8N1UG6sTGJ1OZIethgIErbKgEqcX8KiOmnjOJLgcx1js3buEKLLEa0A3
   FZfBO7GCLCxuOaNJ6wD4dUH9ngBx1bZgU1LvaF5oYEBTHaU14l7/jFrzy
   Q==;
X-CSE-ConnectionGUID: 27ntWyu3QrCn/zHiW7bcyA==
X-CSE-MsgGUID: R6BlVbu7RUSN7P9TXBqZBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33571695"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="33571695"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 14:42:30 -0800
X-CSE-ConnectionGUID: uvuTRZrYQA6QWVqZ0dXyow==
X-CSE-MsgGUID: b9yq1N50TF+/euxYPSDaEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100609161"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa003.jf.intel.com with ESMTP; 10 Dec 2024 14:42:30 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
	Alexander Shishkin <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] x86/cpufeature: Add feature dependency checks
Date: Tue, 10 Dec 2024 22:40:37 +0000
Message-ID: <20241210224037.3052555-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the cpuid_deps[] table is only exercised when a particular
feature gets explicitly disabled and clear_cpu_cap() is called. However,
some of these listed dependencies might already be missing during boot.

These types of errors shouldn't generally happen in production
environments but they could sometimes sneak through, especially when VMs
and Kconfigs are in the mix. Also, the kernel might introduce artificial
dependencies between unrelated features such as making LAM depend on
LASS.

Unexpected failures can occur when the kernel tries to use such a
feature. Rather than debug such scenarios, it would be better to disable
the feature upfront.

Add a simple boot time scan of the cpuid_deps[] table and disable any
feature with unmet dependencies. do_clear_cpu_cap() makes sure that the
dependency tree reaches a stable state in the end.

Also, add a print to the kernel log which might be useful to users if a
feature gets unexpectedly disabled. Features are typically represented
through unsigned integers within the kernel though some of them have
user friendly names if they are exposed via cpuinfo.  Show the
friendlier name if available otherwise display the X86_FEATURE_*
numerals to make it easier to identify the feature.

Suggested-by: Tony Luck <tony.luck@intel.com> # Kernel log print
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v4: Update the log level to pr_info() (Ingo)
    Update the char buffer size to 16 (0day warning)
    Dropped Dave's review tag since the code has changed a bit more
    than usual.

v3: https://lore.kernel.org/lkml/20241207004126.2054658-1-sohil.mehta@intel.com/
    Picked up the review tag.
    Reworded the commit message.

v2: Use cpu_has() instead of boot_cpu_has() (Sean)

RFC-v1: New patch.
---
 arch/x86/include/asm/cpufeature.h |  1 +
 arch/x86/kernel/cpu/common.c      |  4 ++++
 arch/x86/kernel/cpu/cpuid-deps.c  | 31 +++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 0b9611da6c53..8821336a6c73 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -148,6 +148,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
+void filter_feature_dependencies(struct cpuinfo_x86 *c);
 
 #define setup_force_cpu_cap(bit) do {			\
 							\
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a5c28975c608..bd27cf5974d4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1608,6 +1608,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 		c->cpu_index = 0;
 		filter_cpuid_features(c, false);
+		filter_feature_dependencies(c);
 
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
@@ -1862,6 +1863,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Filter out anything that depends on CPUID levels we don't have */
 	filter_cpuid_features(c, true);
 
+	/* Filter out features that don't have their dependencies met */
+	filter_feature_dependencies(c);
+
 	/* If the model name is still unset, do table lookup. */
 	if (!c->x86_model_id[0]) {
 		const char *p;
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 8bd84114c2d9..dccb547cbf0d 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -146,3 +146,34 @@ void setup_clear_cpu_cap(unsigned int feature)
 {
 	do_clear_cpu_cap(NULL, feature);
 }
+
+/*
+ * Return the feature "name" if available otherwise return
+ * the X86_FEATURE_* numerals to make it easier to identify
+ * the feature.
+ */
+static const char *x86_feature_name(unsigned int feature, char *buf)
+{
+	if (x86_cap_flags[feature])
+		return x86_cap_flags[feature];
+
+	snprintf(buf, 16, "%d*32+%2d", feature / 32, feature % 32);
+
+	return buf;
+}
+
+void filter_feature_dependencies(struct cpuinfo_x86 *c)
+{
+	char feature_buf[16], depends_buf[16];
+	const struct cpuid_dep *d;
+
+	for (d = cpuid_deps; d->feature; d++) {
+		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
+			pr_info("CPU%d: Disabling feature %s due to missing feature %s\n",
+				smp_processor_id(),
+				x86_feature_name(d->feature, feature_buf),
+				x86_feature_name(d->depends, depends_buf));
+			do_clear_cpu_cap(c, d->feature);
+		}
+	}
+}
-- 
2.43.0


