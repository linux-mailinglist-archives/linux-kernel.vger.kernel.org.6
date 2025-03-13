Return-Path: <linux-kernel+bounces-560325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FBDA60250
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997B9166196
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3001F3FE8;
	Thu, 13 Mar 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1c8C+K6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653ADDDC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897115; cv=none; b=n+p8MegvJl0MirPMU6rAWej/KIKRIG8mdNTGpsYPgTDeGi5ctcFs7cz5fRAUQwtK7zZ8Q73KxmjCZUh1vLoZTFIy5N9+Dj8RmXMgRuRs5D4aa+EUr58xf4m+vxsid1hU0Xu6qDegWnz9z+02IwTCEaGJgDF/Wy9djIugmC7spDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897115; c=relaxed/simple;
	bh=qtWBkPrVTBT9asQjq8csr8AjAImGhr6AZdO7KfBXHLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxYzn0Siq+C82taSVNtauifRFfUmWfgObS2QZOIaEoMSMSYjPe32kMjPQ0aQmOp0skmIFnOOF0MkxniatR301k8lF3lQ6b/O5hmHPQ1fTX+9O+wa29BQ8crnXphg8SIWLfOUXovfNWwC9FcwIGVhGFhVef2F84BboJRwK3/VZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1c8C+K6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741897114; x=1773433114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qtWBkPrVTBT9asQjq8csr8AjAImGhr6AZdO7KfBXHLU=;
  b=T1c8C+K6jAeIToQb+IyB97+iCQcj8IxmJZcPpEDIjm7yhmbo6JwznHRl
   3axurfarxnm4ekUpXslzx8G2nWiHHIY1+kLacve7m/ic8AIrpvOgbjdhM
   x4yeIiEAmwK6SOcNut7oRAJVctIDWe6ieVJhY410c7as5+xvbwSQTOEJk
   cgRd8HkzegWuNOpCKVupRdBbAu6TjDDidtJGqa9L9kxPRpokDHts5KhNX
   Ts9buqT3kscY5bSjFwaeqJ0cOFFLXto9fTURTm2hQb/7yipZZKcGjW/el
   KM9S4LhtzDvngujSt4e+KN7Z/YJfHJezilRIFh3WvWSYSob6QHeJe6d1l
   g==;
X-CSE-ConnectionGUID: kqt070n3QLCV9wVEqPvazg==
X-CSE-MsgGUID: soHxGPUHRZqVlzsQ0fRGJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53687809"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="53687809"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 13:18:33 -0700
X-CSE-ConnectionGUID: 195l6/kIRu60Lv142oT+fQ==
X-CSE-MsgGUID: X8yG9rsXR1GfGizSGhiXng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="125944720"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa003.jf.intel.com with ESMTP; 13 Mar 2025 13:18:33 -0700
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
Subject: [PATCH v6] x86/cpufeature: Warn about unmet feature dependencies
Date: Thu, 13 Mar 2025 20:16:08 +0000
Message-ID: <20250313201608.3304135-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the cpuid_deps[] table is only exercised when a particular
feature is explicitly disabled and clear_cpu_cap() is called. However,
some of these listed dependencies might already be missing during boot.

These types of errors shouldn't generally happen in production
environments, but they could sometimes sneak through, especially when
VMs and Kconfigs are in the mix. Also, the kernel might introduce
artificial dependencies between unrelated features, such as making LAM
depend on LASS.

Unexpected failures can occur when the kernel tries to use such
features. Add a simple boot-time scan of the cpuid_deps[] table to
detect the missing dependencies. One option is to disable all of such
features during boot, but that may cause regressions in existing
systems. For now, just warn about the missing dependencies to create
awareness.

As a trade-off between spamming the kernel log and keeping track of all
the features that have been warned about, only warn about the first
missing dependency. Any subsequent unmet dependency will only be logged
after the first one has been resolved.

Features are typically represented through unsigned integers within the
kernel, though some of them have user-friendly names if they are exposed
via cpuinfo.  Show the friendlier name if available, otherwise display
the X86_FEATURE_* numerals to make it easier to identify the feature.

Suggested-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v6: Change name to check_cpufeature_deps() (Ingo)
    Improve kernel log message (Ingo)

v5: https://lore.kernel.org/lkml/20250307000204.3581369-1-sohil.mehta@intel.com/
    Don't disable features with unmet dependencies (Ingo)
    Use pr_warn_once() for the warning (Ingo)

v4: Update the log level to pr_info() (Ingo)
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
index de1ad09fe8d7..9c9fff960093 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -149,6 +149,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
+void check_cpufeature_deps(struct cpuinfo_x86 *c);
 
 #define setup_force_cpu_cap(bit) do {			\
 							\
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b19fb2..fe9c1c42ff49 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1610,6 +1610,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 		c->cpu_index = 0;
 		filter_cpuid_features(c, false);
+		check_cpufeature_deps(c);
 
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
@@ -1870,6 +1871,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Filter out anything that depends on CPUID levels we don't have */
 	filter_cpuid_features(c, true);
 
+	/* Check for unmet dependencies based on the CPUID dependency table */
+	check_cpufeature_deps(c);
+
 	/* If the model name is still unset, do table lookup. */
 	if (!c->x86_model_id[0]) {
 		const char *p;
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index df838e3bdbe0..a2fbea0be535 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -147,3 +147,38 @@ void setup_clear_cpu_cap(unsigned int feature)
 {
 	do_clear_cpu_cap(NULL, feature);
 }
+
+/*
+ * Return the feature "name" if available, otherwise return
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
+void check_cpufeature_deps(struct cpuinfo_x86 *c)
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
+			pr_warn_once("x86 CPU feature dependency check failure: CPU%d has '%s' enabled but '%s' disabled. Kernel might be fine, but no guarantees.\n",
+				     smp_processor_id(),
+				     x86_feature_name(d->feature, feature_buf),
+				     x86_feature_name(d->depends, depends_buf));
+		}
+	}
+}
-- 
2.43.0


