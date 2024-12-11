Return-Path: <linux-kernel+bounces-440611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8B99EC1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE66188683B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73D1A0BCF;
	Wed, 11 Dec 2024 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LS8EsN+Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1717D358
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881344; cv=none; b=QS00FD9kfzrvyupVGGwsvjYTYZXfwp2t9jGNGFJgg8X+lzJJ+VKV5rzxS5TxAwRsQ2U0zi+U0xmIbdzV1pGt4cze6aosQXikiR1NOrzv0spg+HUO735TYRRwSICjPLrK2ewH0GuYHKpIKL4BHVWORj3uL0CA3MXFvXvwg70J6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881344; c=relaxed/simple;
	bh=s8zd5KKT7bLDGEnc2DPSJFBeXiiU6rD6ciO1nDnYBio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjvFkI3UrunkPv77IRMyxON4ld38sQ8IcwFu7GefdIgB2lU+N92eroTQvho+viGkWWYEWxebMGKJ7tVlkdtIpDm56abzNYZ+XsRtEHQlh5RBZ5abx0ub0ovnaeSuHc02hewmHlA4gU+VTlUyX/0GJf3Kqisz3DtyeBCsn944c0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LS8EsN+Y; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733881341; x=1765417341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s8zd5KKT7bLDGEnc2DPSJFBeXiiU6rD6ciO1nDnYBio=;
  b=LS8EsN+YeC+NqJ1VZ+ctKNhMU5ROAUcnoexhKkyEcLOeDz7AAVBcohHA
   N/2rR9btjTMrM3PmVdYMmQ/x8njCquwj+FW5i0QobUSGQHOzS2Ku5HvpR
   IZc3aJ+iCHo9DRNaLSC8BVzwiLi2h8yC4ZBffPVg0p7pbomF+bvmJXp1F
   Tlo0dpw/DNnbNEh8mOB7jAUQmCqAf54MyBdNCc+9Nd7t6tF/pmZLWLEb2
   bCfLM+tD5RgqzoKWJAMQaFL6FB0VjaCFLIgr3WfiIfGn3I9+wIX0AGSzo
   vjY2W/VwTxxRYIUsPuFOujD6/ObQn4ZWniQa4/ONcfMHWekdYHLjrlLih
   A==;
X-CSE-ConnectionGUID: zkV8UPVWQNKRS5KbdZ5pgA==
X-CSE-MsgGUID: FQWzJTLISCm/dGpqBzlm5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33570548"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="33570548"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 17:42:18 -0800
X-CSE-ConnectionGUID: fJ1ry+HFTCWe8X6XDWSdiQ==
X-CSE-MsgGUID: ykI9WMBTSGGJXfxGF1k6zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96051756"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.134.127])
  by orviesa007.jf.intel.com with ESMTP; 10 Dec 2024 17:42:18 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH 3/6] x86/microcode/intel: Prepare for microcode staging
Date: Tue, 10 Dec 2024 17:42:09 -0800
Message-ID: <20241211014213.3671-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211014213.3671-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When microcode staging is initiated, operations are carried out through
an MMIO interface. Each package has a unique interface specified by the
IA32_MCU_STAGING_MBOX_ADDR MSR, which points to a set of dword-sized
registers.

Prepare staging with the following steps: First, ensure the microcode
image is dword-aligned to correspond with MMIO registers. Next,
identify each MMIO interface based on its per-package scope. Then,
invoke the staging function for each identified interface.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
RFC-V1 -> V1:
* Simplify code by leveraging the architectural per-package staging scope
  (Thomas).
* Fix MSR read code (Boris and Dave).
* Rename the staging function: staging_work() -> do_stage() (Boris).
* Polish the result messages (Boris).
* Add a prototype for builds without CONFIG_CPU_SUP_INTEL (Boris).
* Massage the changelog.

Note:

1. Using a direct reference to 'cpu_primary_thread_mask' in
   for_each_cpu(...) causes a build error when !CONFIG_SMP. Instead, use
   the wrapper function topology_is_primary_thread() to avoid it.

2. Ideally, the do_stage() function would be as simple as a single WRMSR
   execution. If this were the case, the staging flow could be completed
   with this patch. From this perspective, the software handling for
   interacting with the staging firmware has been separated from this
   vendor code and moved into a new file dedicated to staging logic.
---
 arch/x86/kernel/cpu/microcode/intel.c    | 36 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h |  7 +++++
 2 files changed, 43 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f3d534807d91..325068bb5524 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -299,6 +299,41 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	return size ? NULL : patch;
 }
 
+static void stage_microcode(void)
+{
+	unsigned int totalsize, pkg_id = UINT_MAX;
+	enum ucode_state state;
+	int cpu;
+	u64 pa;
+
+	totalsize = get_totalsize(&ucode_patch_late->hdr);
+	if (!IS_ALIGNED(totalsize, sizeof(u32)))
+		return;
+
+	/*
+	 * The MMIO address is unique per package, and all the SMT
+	 * primary threads are online here. Find each MMIO space by
+	 * their package ids to avoid duplicate staging.
+	 */
+	for_each_cpu(cpu, cpu_online_mask) {
+		if (!topology_is_primary_thread(cpu) || topology_logical_package_id(cpu) == pkg_id)
+			continue;
+		pkg_id = topology_logical_package_id(cpu);
+
+		rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &pa);
+
+		state = do_stage(pa, ucode_patch_late, totalsize);
+		if (state != UCODE_OK) {
+			pr_err("Error: staging failed with %s for CPU%d at package %u.\n",
+			       state == UCODE_TIMEOUT ? "timeout" : "error state", cpu, pkg_id);
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
@@ -627,6 +662,7 @@ static struct microcode_ops microcode_intel_ops = {
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
+	.stage_microcode	= stage_microcode,
 	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
 };
 
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index b27cb8e1228d..158429d80f93 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -120,11 +120,18 @@ void load_ucode_intel_bsp(struct early_load_data *ed);
 void load_ucode_intel_ap(void);
 void reload_ucode_intel(void);
 struct microcode_ops *init_intel_microcode(void);
+static inline enum ucode_state do_stage(u64 pa, void *ucode_ptr, unsigned int totalsize)
+{
+	pr_debug_once("Need to implement the staging code.\n");
+	return UCODE_ERROR;
+}
 #else /* CONFIG_CPU_SUP_INTEL */
 static inline void load_ucode_intel_bsp(struct early_load_data *ed) { }
 static inline void load_ucode_intel_ap(void) { }
 static inline void reload_ucode_intel(void) { }
 static inline struct microcode_ops *init_intel_microcode(void) { return NULL; }
+static inline enum ucode_state
+do_stage(u64 pa, void *ucode_ptr, unsigned int totalsize) { return UCODE_ERROR; }
 #endif  /* !CONFIG_CPU_SUP_INTEL */
 
 #endif /* _X86_MICROCODE_INTERNAL_H */
-- 
2.45.2


