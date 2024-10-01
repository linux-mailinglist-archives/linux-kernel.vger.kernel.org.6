Return-Path: <linux-kernel+bounces-346322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A14098C320
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3C41C23B74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0551CCEDB;
	Tue,  1 Oct 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCWUtAAp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E221CCB3B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799063; cv=none; b=LQ2GW2yhEU6UlZbf0fJmcFSLLADFFTDjojNb4orruAwwef34rmMF8RpZ4jxW+BjQQv1GCi3V/8EblXKvKLqFder7Uz5j2fMCH+9oz5Eb7JDYCuazFv5mlfpE0vT7KXLTJyd9gVio7DM3OnAarBzWXpcuF9HlQWLMvs9rasi5GHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799063; c=relaxed/simple;
	bh=GEw4i2sw/lvYbQl7umLqQFJk+Qso2Qgb1x2/tZS8Tv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eAHSWlx1LmBLKguu/yF+1o5Xelvgl8ce8irSSxLWxBjVZ6x92cGJNNyWkCdEMZ+koswX8HkO5xK7R/QWxqMSYDaz/rWZwIFsyqzStUAT2/agFUuaI191QecVRLIIJ1dD2EShwjx/pm7YlNBjK4JAWEgntg9lW3f2vxWk37YXaWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCWUtAAp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727799062; x=1759335062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GEw4i2sw/lvYbQl7umLqQFJk+Qso2Qgb1x2/tZS8Tv8=;
  b=TCWUtAApgG2roLUkx5GMjr/GPxfzxM9+HEbCAZ7z41ES/I4lKiU7mFTg
   qa3XNGRCCPATN0oHm12llOapu0qnHlVlg+jzJ49dbJhAlNpX4l79BfblZ
   VK290nyf1/dBCFroui4ExAjeyLU6S1GMihMDa21xbxV4ATBDzIQ8ujvl8
   uBCKxZ+0oyC8RZ6And5QAJfXNeZ5/iE2rqvHNATD2ud9IXQC8E+T5gcxd
   OE1Qu9m8AkGcnDp1AGBpvtBLD1oDwioYB/5xjJgg9zKdwa63yFiApxoC+
   UbIkS9BR8VjWEdJplTI/+25HrXxWM4kSoW0Qc1mEWXD/n1aeoQO29TjKV
   Q==;
X-CSE-ConnectionGUID: RVzhF5ziSf2IwXCsqbAXpQ==
X-CSE-MsgGUID: intSRL8rSs6O7Vjn6MVQaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37539389"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37539389"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:11:02 -0700
X-CSE-ConnectionGUID: gUdkz1ZNTrGyWTIOizE/9w==
X-CSE-MsgGUID: 6dRYHtK8SrS3786Uaf5yFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78585989"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.136.21])
  by orviesa003.jf.intel.com with ESMTP; 01 Oct 2024 09:11:02 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC 4/7] x86/microcode/intel: Prepare for microcode staging
Date: Tue,  1 Oct 2024 09:10:39 -0700
Message-Id: <20241001161042.465584-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001161042.465584-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When microcode staging is initiated, operations are carried out through
an MMIO interface. Each interface is independently discoverable per CPU
via the IA32_MCU_STAGING_MBOX_ADDR MSR, which points to a set of
dword-sized registers.

Software must first ensure the microcode image is dword-aligned, then
proceed to stage the update for each exposed MMIO space as specified.

Follow these two steps to arrange staging process. Identify each unique
MMIO interface by iterating over the CPUs and reading the MSR for each
one. While this process can be tedious, it remains simple enough and
acceptable in the slow path.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Note:

1. Initially, a per-package and parallel staging invocation approach was
considered, but it seemed overly complex. Dave helped to identify a
simpler way.

2. Ideally, the staging_work() function would be as simple as a single
WRMSR execution. If this were the case, the staging flow could be
completed with this patch. From this perspective, the software handling
for interacting with the staging firmware has been separated from this
vendor code and moved into a new file dedicated to staging logic.
---
 arch/x86/kernel/cpu/microcode/intel.c    | 50 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h |  5 +++
 2 files changed, 55 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f3d534807d91..03c4b0e7e97c 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -299,6 +299,55 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	return size ? NULL : patch;
 }
 
+static inline u64 staging_addr(u32 cpu)
+{
+	u32 lo, hi;
+
+	rdmsr_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &lo, &hi);
+	return lo | ((u64)hi << 32);
+}
+
+static bool need_staging(u64 *mmio_addrs, u64 pa)
+{
+	unsigned int i;
+
+	for (i = 0; mmio_addrs[i] != 0; i++) {
+		if (mmio_addrs[i] == pa)
+			return false;
+	}
+	mmio_addrs[i] = pa;
+	return true;
+}
+
+static void staging_microcode(void)
+{
+	u64 *mmio_addrs, mmio_pa;
+	unsigned int totalsize;
+	int cpu;
+
+	totalsize = get_totalsize(&ucode_patch_late->hdr);
+	if (!IS_ALIGNED(totalsize, sizeof(u32)))
+		return;
+
+	mmio_addrs = kcalloc(nr_cpu_ids, sizeof(*mmio_addrs), GFP_KERNEL);
+	if (WARN_ON_ONCE(!mmio_addrs))
+		return;
+
+	for_each_cpu(cpu, cpu_online_mask) {
+		mmio_pa = staging_addr(cpu);
+
+		if (need_staging(mmio_addrs, mmio_pa) &&
+		    !staging_work(mmio_pa, ucode_patch_late, totalsize)) {
+			pr_err("Error: staging failed.\n");
+			goto out;
+		}
+	}
+
+	pr_info("Staging succeeded.\n");
+out:
+	kfree(mmio_addrs);
+}
+
 static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
 					  struct microcode_intel *mc,
 					  u32 *cur_rev)
@@ -627,6 +676,7 @@ static struct microcode_ops microcode_intel_ops = {
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
+	.staging_microcode	= staging_microcode,
 	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
 };
 
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index cb58e83e4934..06c3c8db4ceb 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -120,6 +120,11 @@ void load_ucode_intel_bsp(struct early_load_data *ed);
 void load_ucode_intel_ap(void);
 void reload_ucode_intel(void);
 struct microcode_ops *init_intel_microcode(void);
+static inline bool staging_work(u64 mmio_pa, void *ucode_ptr, unsigned int totalsize)
+{
+	pr_debug_once("Need to implement the Staging code.\n");
+	return false;
+}
 #else /* CONFIG_CPU_SUP_INTEL */
 static inline void load_ucode_intel_bsp(struct early_load_data *ed) { }
 static inline void load_ucode_intel_ap(void) { }
-- 
2.43.0


