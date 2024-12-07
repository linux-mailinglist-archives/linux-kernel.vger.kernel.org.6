Return-Path: <linux-kernel+bounces-435817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872239E7D93
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E81886346
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF133DF;
	Sat,  7 Dec 2024 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqLedrLw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182A17FE
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733532206; cv=none; b=W5FA8DiFEr3gbhXqqdsHnd3G7jz15Mpap8DnilT96rZJntVymYLeYIQAVaqQy+3b2WvRwisNPo/uMSpE/1wT/2wjkdLKpxF1lhyWAp2ygVNXKKxeMemvFSwNpcD9nxJ1cgY0mOltW3d86xDWrKoQbCvMwNKfrSyzHZC6fdU8hns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733532206; c=relaxed/simple;
	bh=VSsBK4ATzwvPNKqgWXj3V8xsd7g0hHh1aMlUGSrHf4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9SE15mhLGVgl5OBZmi48PbSTtunN28BuvhIY439w5LFNBzz42TQKExo0dZQTwQLf2aLfFYHr5iuJBX5J6/BnSNrD7Cpn3tfTArG6pMb6UCwIy/f4KJiXhqUFHtATjx70EQHnHbeGqK6OgbtAcXUr7KPqMbZN1F9vmfmRS1tMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqLedrLw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733532204; x=1765068204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VSsBK4ATzwvPNKqgWXj3V8xsd7g0hHh1aMlUGSrHf4M=;
  b=hqLedrLwxUyhf+mZYt/efNy+eS50VE31L6wk3PE1+nt36SBmcdI/6e8U
   BatiMpxoi0sG97OJRL73tPFE7cf37EQYeSmZU2xEvqe8ZsNltyfASCOBd
   Xvx80SecjjQDQtXyGsE2muDqVV51BxIt6wNX41gRWsBYEdO4XVH3JeH6i
   vyaugtwosFs0dyXKbfY5bZhf6vMrRc/JWWHiD1nvxiCoNdxbtG0B2yu+Y
   V9rQqQJmmwiVqcxbHkgr9oLurslUUpL/3M8J3U2kn5dzE4kAptSdIXgSQ
   JkQ+egV4Kx002c77oGgaUyUUzXEuMfolZzDGmpC6NzNZsH6EeHwbilc9t
   Q==;
X-CSE-ConnectionGUID: 0t4GccYgQTqYVp8dsPyi4w==
X-CSE-MsgGUID: Rg12poh8QXqoe7uDfXZQDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="44573518"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="44573518"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 16:43:23 -0800
X-CSE-ConnectionGUID: k5j0TAzeSF2WIgIaf9Laaw==
X-CSE-MsgGUID: Odn7X156TFKd5TIQF3fkrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="131954295"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa001.jf.intel.com with ESMTP; 06 Dec 2024 16:43:23 -0800
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
	Alexander Shishkin <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] x86/cpufeature: Add feature dependency checks
Date: Sat,  7 Dec 2024 00:41:25 +0000
Message-ID: <20241207004126.2054658-1-sohil.mehta@intel.com>
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

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v3: Picked up the review tag.
    Reworded the commit message.

v2: Use cpu_has() instead of boot_cpu_has() (Sean)
    https://lore.kernel.org/lkml/20241030233118.615493-1-sohil.mehta@intel.com/

RFC-v1: New patch.
---
 arch/x86/include/asm/cpufeature.h |  1 +
 arch/x86/kernel/cpu/common.c      |  4 ++++
 arch/x86/kernel/cpu/cpuid-deps.c  | 10 ++++++++++
 3 files changed, 15 insertions(+)

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
index 8bd84114c2d9..8bea5c5e4fd2 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -146,3 +146,13 @@ void setup_clear_cpu_cap(unsigned int feature)
 {
 	do_clear_cpu_cap(NULL, feature);
 }
+
+void filter_feature_dependencies(struct cpuinfo_x86 *c)
+{
+	const struct cpuid_dep *d;
+
+	for (d = cpuid_deps; d->feature; d++) {
+		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends))
+			do_clear_cpu_cap(c, d->feature);
+	}
+}
-- 
2.43.0


