Return-Path: <linux-kernel+bounces-570520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC956A6B1B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199D38A454C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F0922AE49;
	Thu, 20 Mar 2025 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbIUSJ/G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A122B8B1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514084; cv=none; b=A0BQ/KitEfUFjxTgMKlq2cC7qeAv69LJH7/nZ4LtqgZa9k5vB/rDDbUxblocehnsf1YIHoef53TxQA3nJvB1ftvXSZOP9isLQCk2EZmyV97I2jEi33KLmEI9FMgiOLWL95WiTOhnc3JL3OyLP8TWoZNndbHLgzNZnMa9D2/yGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514084; c=relaxed/simple;
	bh=HzxvhWptpt+PUVAgJgNC/pa0J4idK6WbpPo+RPBZ6xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQjIwaR/vaFrzPSMdTH7QhU1S75JekiocVf+DrACfCR366rvsWCQWcTjVtCJWSp8rj9KWBZ0HttvRM1wVsG/Z3fyy/3wuDGaoKRiii7tCutnMeYW2cVXoD5ErVy+LQCP+jHsXFCd7j2Bi3CYCFCy7aBHJTryPjB4GxKgwfVraSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbIUSJ/G; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514081; x=1774050081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HzxvhWptpt+PUVAgJgNC/pa0J4idK6WbpPo+RPBZ6xY=;
  b=kbIUSJ/GEffgQ4jclup186avNPSPDsAVChPMggvEoGxPdRe+S287NU02
   iTFWnrBJLWVUfhhnvU5ZoYZJVUZoLO6c+EwJsskO9iXhXo4+FqZQ2l3F2
   sxQXCK9Pmodwa0jFt0Wt1u+bfmT4rrHfsFPl/4F2oszen3tI76UyKIAPU
   JXsfDqNcBdzKkVTGFrYK+jBZJaUo52vRpl3u6h34Nf2T7AWQe9FNpPeNj
   InKnM4vmYliD3D7KLaqbqZIOX+qvya6KHOwv77M/axib12h6MwoWIXVVl
   tk6aGxx4DategJyRp3UfsJXjZe+XRxuLV6F0YT7UxmrJkUlLnT/CzGluM
   A==;
X-CSE-ConnectionGUID: CHc8ctWAQmeRMinUtCr+Vg==
X-CSE-MsgGUID: 9/8UkOnhR0CA9JdBYtEpzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54439145"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54439145"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:41:20 -0700
X-CSE-ConnectionGUID: fU8Rj+iXQZmTYTfI+einGA==
X-CSE-MsgGUID: HlFA+PQZReKlhXLNs4zuuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123418042"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2025 16:41:19 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2 3/6] x86/microcode/intel: Establish staging control logic
Date: Thu, 20 Mar 2025 16:40:55 -0700
Message-ID: <20250320234104.8288-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234104.8288-1-chang.seok.bae@intel.com>
References: <20250320234104.8288-1-chang.seok.bae@intel.com>
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
V1 -> V2:
* Adjust to reference the staging_state struct.

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
   with this patch.
---
 arch/x86/include/asm/msr-index.h      |  2 +
 arch/x86/kernel/cpu/microcode/intel.c | 57 ++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

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
index 57ed5d414cd1..14c20b53f14d 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -64,8 +64,11 @@ struct extended_sigtable {
  * @bytes_sent:		Total bytes transmitted so far
  * @offset:		Current offset in the microcode image
  * @state:		Current state of the staging process
+ *
+ * Staging is performed sequentially per package, so concurrent access is
+ * not expected.
  */
-struct staging_state {
+static struct staging_state {
 	void __iomem		*mmio_base;
 	void			*ucode_ptr;
 	unsigned int		ucode_len;
@@ -73,7 +76,7 @@ struct staging_state {
 	unsigned int		bytes_sent;
 	unsigned int		offset;
 	enum ucode_state	state;
-};
+} staging;
 
 #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
 #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
@@ -320,6 +323,55 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	return size ? NULL : patch;
 }
 
+/*
+ * Handle the staging process using the mailbox MMIO interface. The
+ * caller is expected to check the result in staging.state.
+ */
+static void do_stage(u64 mmio_pa)
+{
+	pr_debug_once("Staging implementation is pending.\n");
+	staging.state = UCODE_ERROR;
+}
+
+static void stage_microcode(void)
+{
+	unsigned int pkg_id = UINT_MAX;
+	u64 mmio_pa;
+	int cpu;
+
+	staging.ucode_ptr = ucode_patch_late;
+	staging.ucode_len = get_totalsize(&ucode_patch_late->hdr);
+	if (!IS_ALIGNED(staging.ucode_len, sizeof(u32)))
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
+		do_stage(mmio_pa);
+		if (staging.state != UCODE_OK) {
+			pr_err("Error: staging failed with %s for CPU%d at package %u.\n",
+			       staging.state == UCODE_TIMEOUT ? "timeout" : "error state",
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
@@ -648,6 +700,7 @@ static struct microcode_ops microcode_intel_ops = {
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
+	.stage_microcode	= stage_microcode,
 	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
 };
 
-- 
2.45.2


