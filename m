Return-Path: <linux-kernel+bounces-346321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F9398C31F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE97B23775
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20DA1CCB57;
	Tue,  1 Oct 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmIkRLSM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C11CCB29
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799063; cv=none; b=Do+Iz7qA0OzrC1yhyhRvQA3Njpr4ChOjjPdAClvOqMJdVzHVjjEzEg4tvoI5wDhQ8a1/5/jk8C43Ahk64fd1EruMQfsj+PGmwXy3NHvtJaYQR+ZjSlBDQx3THlz/AGVD6lMx0MhiGj2UMSn/igfbNPjYBvumxidQ32yyB/BTc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799063; c=relaxed/simple;
	bh=HjFxiO3WVk8mwE4QkGACUCunEYQwJJOVvDqryVYukaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JDW0EF/r/Zmep8huS/L4bC3kPfLoNih/uGaerAfyviFZhYRVsrXIvDBEQzU4snpOPjqZq/+dk/PG3r1Ah4wqvmsghWy/bXhqDEP0pNWQNOomA5VOEy9PsldJU0ZqHtJ9Y1dMXqiDcFqOi4jNJnjymQyB1MHT25sCnOwi6Lh4ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmIkRLSM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727799061; x=1759335061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HjFxiO3WVk8mwE4QkGACUCunEYQwJJOVvDqryVYukaE=;
  b=UmIkRLSMHulLc9tZBjrfzWfT/14uwMEoOyxVx5LxRmaBaJ89eauOX2Pc
   5j1o5eOnwy6YF9l6waG6iyQK1Eenx4pN8znYO+wiCz5faoQ7yn1TI1bZ9
   7oKHIN95CPI3OoFZV6WSvco0cgPzrx/fg+RtflxVd0BEc+99jPhd3Wm4V
   Y0+yV/Ub7qMBnzxZhl+3hJWn2w1h05zER3IR27cHCnRCblbOhdKvBzllh
   4HjX5wxAR7gnYcvg9SLJSJfmXV+kMKQMzCoSG8ocEFlFgOGvF+JPDKCI+
   YLPMSYMExeiH6ipdgzWTaRe/yJjIMV23qzB7Olp8aBJRv2p+nJHhNtW1s
   Q==;
X-CSE-ConnectionGUID: et4nnwtlREOjDmwOGLFYrQ==
X-CSE-MsgGUID: E1O1MlCdTxO1aUHarrfCxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37539383"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37539383"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:11:00 -0700
X-CSE-ConnectionGUID: 9RDTAcOxREmi2M+hA0ONYQ==
X-CSE-MsgGUID: Z/PZhaeeSpSkvBQXDB5iHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78585984"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.136.21])
  by orviesa003.jf.intel.com with ESMTP; 01 Oct 2024 09:11:01 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC 3/7] x86/msr-index: Define MSR index and bit for the microcode staging feature
Date: Tue,  1 Oct 2024 09:10:38 -0700
Message-Id: <20241001161042.465584-4-chang.seok.bae@intel.com>
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

The microcode staging feature involves two key MSR entities, the
presence of which is indicated by bit 16 of IA32_ARCH_CAPABILITIES:

* Bit 4 in IA32_MCU_ENUMERATION shows the availability of the microcode
  staging feature.

* Staging is managed through MMIO registers, with
  IA32_MCU_STAGING_MBOX_ADDR MSR specifying the physical address of the
  first MMIO register.

Define the MSR index and bit assignments, helping the upcoming staging
code to make use of the hardware feature.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/include/asm/msr-index.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..2840a2fe340b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -164,6 +164,10 @@
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
@@ -884,6 +888,11 @@
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
+#define MSR_IA32_MCU_ENUMERATION	0x0000007b
+#define MCU_STAGING			BIT(4)
+
+#define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
+
 /* Intel SGX Launch Enclave Public Key Hash MSRs */
 #define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
 #define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
-- 
2.43.0


