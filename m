Return-Path: <linux-kernel+bounces-550104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F98A55B66
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B636C1899D1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E127464;
	Fri,  7 Mar 2025 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiB21l5k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B63FE4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741305871; cv=none; b=mncbVNfDaI3fnA+t3vl0o8HvTgenBduBYc0Xk+BWSO8K1zOIYqsCgli9jXQ8Cm5CAv9uG0aCi3jYfCUWS3WxYvytGApzILgHlh0M2atXytNqRA/1B749OfKCamcJlgz0VKizn/46sTBbKn0IidqqRSJleudl7+N60oUQm9R4Lbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741305871; c=relaxed/simple;
	bh=L4j43FN8u0nH0qweYUWLARYbl/n9oWfCtUi1l78AP5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0pfPxkkDvqyMZ2iXm5vEUA85WDcZNTVtnFahnRuzfRjqaJvRyCOPLkzbH4pfD8oTimNeLB/FwkwFoAC6pCk021PRn5r8iVOCj98X51SzXRws91DOFmMIth3Sb6cqP5jHsgJAE74vTgm5IJMF0y1sYzGey53xIn2w5Ojt98zUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiB21l5k; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741305869; x=1772841869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L4j43FN8u0nH0qweYUWLARYbl/n9oWfCtUi1l78AP5M=;
  b=NiB21l5kep8RmsLyXti960iHurb4Z5BkBt1D9MCf+1hI9LxV7B/TGEjq
   +hz3IrjosgAdZS5UDsPnZYkgpxqAGBIpmc5htAS3fQgCDnnz9sX+uj2qI
   dwVutnJBXqgcDVLhMQCOfNBmndNKMuXPkJCwP7QcWQcH9TRSHEjwMYACW
   3DGqerZdaX1qu6bZipmJEsQj+Q4JVPNOnXEExtihH3DTSJ+po/HThOLdx
   lFPXWHtP0Cc9YQupmvEvAKfcYPmNjJUSa36JD3iEJmasbhTwtLrYgYiwo
   DZLzFsM75m4zQ408pM1folVCMiT9TKa8l5nHyPUn70pHKkFF1H0TguoQm
   g==;
X-CSE-ConnectionGUID: M21+PZGJR1mUcgzEQ0p1kA==
X-CSE-MsgGUID: V0xNZ1eFQ8e+dSnPP74M3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42482769"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42482769"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 16:04:29 -0800
X-CSE-ConnectionGUID: wXBsjPsZTOq7da4k7vm1Sg==
X-CSE-MsgGUID: +UBmSuvuQcuP9mJRMYcY3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="124099874"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa003.jf.intel.com with ESMTP; 06 Mar 2025 16:04:28 -0800
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
Subject: [PATCH v5] x86/cpufeature: Warn about unmet feature dependencies
Date: Fri,  7 Mar 2025 00:02:04 +0000
Message-ID: <20250307000204.3581369-1-sohil.mehta@intel.com>
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
feature. Add a simple boot time scan of the cpuid_deps[] table to detect
the missing dependencies. One option is to disable all of such features
during boot but that may cause regressions in existing systems. For now,
just warn about the missing dependencies to create awareness.

As a trade-off between spamming the kernel log and keeping track of all
the features that have been warned about, only warn about the first
missing dependency. Any subsequent unmet dependency will only be logged
after the first one has been resolved.

Features are typically represented through unsigned integers within the
kernel though some of them have user friendly names if they are exposed
via cpuinfo.  Show the friendlier name if available otherwise display
the X86_FEATURE_* numerals to make it easier to identify the feature.

Suggested-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v5: Don't disable features with unmet dependencies (Ingo)
    Use pr_warn_once() for the warning (Ingo)

v4: https://lore.kernel.org/lkml/20241210224037.3052555-1-sohil.mehta@intel.com/
    Update the log level to pr_info() (Ingo)
    Update the char buffer size to 16 (0day warning)
    Dropped Dave's review tag since the code has changed a bit more
    than usual.

v3: Picked up the review tag.
    Reworded the commit message.

v2: Use cpu_has() instead of boot_cpu_has() (Sean)
---
 arch/x86/include/asm/cpufeature.h |  1 +
 arch/x86/kernel/cpu/common.c      |  4 ++++
 arch/x86/kernel/cpu/cpuid-deps.c  | 35 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index de1ad09fe8d7..1bb30e82ea77 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -149,6 +149,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
+void scan_feature_dependencies(struct cpuinfo_x86 *c);
 
 #define setup_force_cpu_cap(bit) do {			\
 							\
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b19fb2..52111d97c8ae 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1610,6 +1610,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 		c->cpu_index = 0;
 		filter_cpuid_features(c, false);
+		scan_feature_dependencies(c);
 
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
@@ -1870,6 +1871,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Filter out anything that depends on CPUID levels we don't have */
 	filter_cpuid_features(c, true);
 
+	/* Scan for unmet dependencies based on the CPUID dependency table */
+	scan_feature_dependencies(c);
+
 	/* If the model name is still unset, do table lookup. */
 	if (!c->x86_model_id[0]) {
 		const char *p;
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index df838e3bdbe0..1b02dbd43cf4 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -147,3 +147,38 @@ void setup_clear_cpu_cap(unsigned int feature)
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
+void scan_feature_dependencies(struct cpuinfo_x86 *c)
+{
+	char feature_buf[16], depends_buf[16];
+	const struct cpuid_dep *d;
+
+	for (d = cpuid_deps; d->feature; d++) {
+		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
+			/*
+			 * Only warn about the first unmet dependency on the
+			 * first CPU where it is encountered to avoid spamming
+			 * the kernel log.
+			 */
+			pr_warn_once("CPU%d: feature:%s may not work properly without feature:%s\n",
+				     smp_processor_id(),
+				     x86_feature_name(d->feature, feature_buf),
+				     x86_feature_name(d->depends, depends_buf));
+		}
+	}
+}
-- 
2.43.0


