Return-Path: <linux-kernel+bounces-571979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBBFA6C4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9717A52D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457C2230BFA;
	Fri, 21 Mar 2025 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5sBnF3O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2871E9B34
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591937; cv=none; b=E9G/YOX5ecdlTnPlQGpzoDaTVdB5IQpkY3B3Efo0uHsOMVFacvxgsKk1nvGHdQRaxsTbS6eC5hKgUfkhiFUaUSD17xkDAqW1Jg9KplLPi5ab6cSoYgSLzwufupRKn7+DLJukME0yqEFt0K8Xw2hqyJiqWTHL8wO1x/FJWgaoajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591937; c=relaxed/simple;
	bh=oWOxUHoZbCBYAAApwK4uk+aXEHpdmJzb25fS08G7hcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm0QmSQ8HsEzD/Caerq2E/CSmMxU1X40t4X06APi5lVhbT0ihP7x7mhffiuedeEqHmpq8rpErcrMoR7XTgA7vqKM8ocfoUXDPzq2bsPlQ6ZcNoXSWDuyXM8oQa7CatfEy14nDPOlAM211hH9UwyzoKrEPF1nPQYTII20FWTCrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5sBnF3O; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742591936; x=1774127936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oWOxUHoZbCBYAAApwK4uk+aXEHpdmJzb25fS08G7hcc=;
  b=J5sBnF3O61tagSVgmErzlFJs/ClgTUEj/KKR4SqSMm4YzIdXvs40HpVU
   khFrojqpiDGY/SAlKgL2Yde4NFfpl6wKVoiYjaLTjQDuBdlM/1A6pwUhX
   H4FM+u24RMidrnAEWTFr6AobCbRfcOKYgGG+3KhRKyICxcCeQE0JJ7D1b
   WRUPh2Paq+5vKtViJ5LStaUIg6P7mJOPzezFmwVN4ic9y6oDXaCw6heSa
   HZBsI7KaxEOIXU+ArHYjn6UAWkwTK+KwYdbuIZA9QPOW8QrXWDUvCQZ4y
   Stza1qfWALmMbUG3JhrK0897XKux4bvk0WZVCDbScKdjnd8ABolwqqatg
   g==;
X-CSE-ConnectionGUID: XyJA6SJPTX+lhQF8RtbDtA==
X-CSE-MsgGUID: ttVSnnXoQUWEHn80DPtSKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="55256172"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="55256172"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 14:18:55 -0700
X-CSE-ConnectionGUID: jEqgzW+uTA+T0aS1hps6KQ==
X-CSE-MsgGUID: byuvoT62RGqHUFYsfSQe6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="160739899"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.168.117])
  by orviesa001.jf.intel.com with ESMTP; 21 Mar 2025 14:18:54 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2a 3/6] x86/microcode/intel: Establish staging control logic
Date: Fri, 21 Mar 2025 14:18:53 -0700
Message-ID: <20250321211853.13909-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234104.8288-4-chang.seok.bae@intel.com>
References: <20250320234104.8288-4-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When microcode staging is initiated, operations are carried out through
an MMIO interface. Each package has a unique interface specified by the
IA32_MCU_STAGING_MBOX_ADDR MSR, which maps to a set of 32-bit registers.

Prepare staging with the following steps:

  1.  Ensure the microcode image is 32-bit aligned to match the MMIO
      register size.

  2.  Identify each MMIO interface based on its per-package scope.

  3.  Invoke the staging function for each identified interface, which
      will be implemented separately.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/all/871pznq229.ffs@tglx
---
V2 -> V2a:
* Remove a global variable and adjust stage_microcode() (Dave [1]).

Note: this quick revision is just intended to ensure that the feedback
has been properly addressed.

[1]: https://lore.kernel.org/lkml/b01224ee-c935-4b08-a76f-5dc49341182d@intel.com/
---
 arch/x86/include/asm/msr-index.h      |  2 ++
 arch/x86/kernel/cpu/microcode/intel.c | 49 +++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index bc6d2de109b5..f123abfdffcb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -891,6 +891,8 @@
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
+#define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
+
 /* Intel SGX Launch Enclave Public Key Hash MSRs */
 #define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
 #define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 57ed5d414cd1..5d0216e9aee5 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -320,6 +320,54 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	return size ? NULL : patch;
 }
 
+/*
+ * Handle the staging process using the mailbox MMIO interface.
+ * Return the result state.
+ */
+static enum ucode_state do_stage(u64 mmio_pa)
+{
+	pr_debug_once("Staging implementation is pending.\n");
+	return UCODE_ERROR;
+}
+
+static void stage_microcode(void)
+{
+	unsigned int pkg_id = UINT_MAX;
+	enum ucode_state ret;
+	u64 mmio_pa;
+	int cpu;
+
+	if (!IS_ALIGNED(get_totalsize(&ucode_patch_late->hdr), sizeof(u32)))
+		return;
+
+	lockdep_assert_cpus_held();
+
+	/*
+	 * The MMIO address is unique per package, and all the SMT
+	 * primary threads are online here. Find each MMIO space by
+	 * their package ids to avoid duplicate staging.
+	 */
+	for_each_cpu(cpu, cpu_online_mask) {
+		if (!topology_is_primary_thread(cpu) ||
+		     topology_logical_package_id(cpu) == pkg_id)
+			continue;
+		pkg_id = topology_logical_package_id(cpu);
+
+		rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
+
+		ret = do_stage(mmio_pa);
+		if (ret != UCODE_OK) {
+			pr_err("Error: staging failed with %s for CPU%d at package %u.\n",
+			       ret == UCODE_TIMEOUT ? "timeout" : "error state",
+			       cpu, pkg_id);
+			return;
+		}
+	}
+
+	pr_info("Staging of patch revision 0x%x succeeded.\n",
+		((struct microcode_header_intel *)ucode_patch_late)->rev);
+}
+
 static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
 					  struct microcode_intel *mc,
 					  u32 *cur_rev)
@@ -648,6 +696,7 @@ static struct microcode_ops microcode_intel_ops = {
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
+	.stage_microcode	= stage_microcode,
 	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
 };
 
-- 
2.45.2


