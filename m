Return-Path: <linux-kernel+bounces-570523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74747A6B1B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E673E488280
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0138E22AE7F;
	Thu, 20 Mar 2025 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cX7SwNzT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0722CBD9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514092; cv=none; b=cIszkhVjt7WIKxQOuH4BmB8f/6u2Mnr9cRKMMAAg2OudvEn0YOR7QdHXsm4DJE67M392VqVtBTsq2GzLSR764wXMLrCX/UVNTe48h0IFfnyJJSaX24QtCr+OAoxZ2qjxoDsrORD0Rbr91UuUkbBNUim5U95qagLIcrZeY2axt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514092; c=relaxed/simple;
	bh=2SytMdOfTKn+KUKq8zhEEcNnHiEIOfPDJfVIV/16T1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDZJhTn5O52YUPg4nswewiwZ1gqRW7Itu1Wlhyob9VerJMJiOp7vqaMvEuJvNXczbs0kQIs3w1KsNtgUWTJZOBd0ScS9YPa3EQiocCKE8LaWJ2o6t7RKodbcyw2OOPZhbUv3z2ZmjquHKyisiyMK+4+CgRIpFefImFqqjH5MaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cX7SwNzT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514089; x=1774050089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2SytMdOfTKn+KUKq8zhEEcNnHiEIOfPDJfVIV/16T1o=;
  b=cX7SwNzTNjjUB+ZmigtLmdPT8oCfk4oEJ38wlVoMOFXd3PCDJU//Qe7X
   EHu0jwSQ35KaKJAvKK2gcD3p0qZKYFHfvv28FCAlwICNNxQYqfBAX38DI
   p+0HZtuX5a8iMyDkCNjAG807U16Rn9/sLfbKqByAdiXoRBo1GJdpAwvSA
   oKBQIUAQMK38ZFmLaPtG2xaDNf+aWYB/9EnNvHo/DptQ6ue8PzIFtMAHV
   69AYywDrFdckDeUYIcjIAVuDlwE6ga1xHa+3j275gJahWVqB+Sh3B+Iqk
   qjDihnsyBU9YopTg5rrquPUosmmFUEvYsXiqv+/dVzcbjjwMpJyn2r2n9
   Q==;
X-CSE-ConnectionGUID: HZInPIKeQ4OtNyDllRogWg==
X-CSE-MsgGUID: 94njHTN6RGq3YbihxmoUAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54439172"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54439172"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:41:28 -0700
X-CSE-ConnectionGUID: gt9fm9+nRdSdbgcwbJ9RkA==
X-CSE-MsgGUID: T7na1EwVRxGrNH5S+wrAxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123418101"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2025 16:41:28 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2 6/6] x86/microcode/intel: Enable staging when available
Date: Thu, 20 Mar 2025 16:40:58 -0700
Message-ID: <20250320234104.8288-7-chang.seok.bae@intel.com>
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

With the staging code being ready, check for staging availability by
reading these following MSRs:

  * IA32_ARCH_CAPABILITIES (bit 16) for the presence of
    IA32_MCU_ENUMERATION

  * IA32_MCU_ENUMERATION (bit 4) for the staging feature availability.

When available, enable it by setting the feature bit.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V1     -> V2: Fold MSR definings (Boris).
RFC-V1 -> V1: Massage the enabling message.
---
 arch/x86/include/asm/msr-index.h      |  7 +++++++
 arch/x86/kernel/cpu/microcode/intel.c | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f123abfdffcb..50c8c0914454 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -166,6 +166,10 @@
 						 * Processor MMIO stale data
 						 * vulnerabilities.
 						 */
+#define ARCH_CAP_MCU_ENUM		BIT(16) /*
+						 * Indicates the presence of microcode update
+						 * feature enumeration and status information
+						 */
 #define ARCH_CAP_FB_CLEAR		BIT(17)	/*
 						 * VERW clears CPU fill buffer
 						 * even on MDS_NO CPUs.
@@ -891,6 +895,9 @@
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
+#define MSR_IA32_MCU_ENUMERATION	0x0000007b
+#define MCU_STAGING			BIT(4)
+
 #define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
 
 /* Intel SGX Launch Enclave Public Key Hash MSRs */
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index b0d530db72dd..add0c1edd212 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -962,6 +962,18 @@ static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
 	llc_size_per_core = (unsigned int)llc_size;
 }
 
+static __init bool staging_available(void)
+{
+	u64 val;
+
+	val = x86_read_arch_cap_msr();
+	if (!(val & ARCH_CAP_MCU_ENUM))
+		return false;
+
+	rdmsrl(MSR_IA32_MCU_ENUMERATION, val);
+	return !!(val & MCU_STAGING);
+}
+
 struct microcode_ops * __init init_intel_microcode(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
@@ -972,6 +984,11 @@ struct microcode_ops * __init init_intel_microcode(void)
 		return NULL;
 	}
 
+	if (staging_available()) {
+		microcode_intel_ops.use_staging = true;
+		pr_info("Enabled staging feature.\n");
+	}
+
 	calc_llc_size_per_core(c);
 
 	return &microcode_intel_ops;
-- 
2.45.2


