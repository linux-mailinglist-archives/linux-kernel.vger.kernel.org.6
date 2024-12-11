Return-Path: <linux-kernel+bounces-440608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB59EC1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1D62850C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B815C14F;
	Wed, 11 Dec 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwHXfvLV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093D3A8F7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881339; cv=none; b=hCx/7h0AIngq/0/M+uNv9IigDljLrtaJMkQC32v1FwAWaTeijVGsYOMBp7h688n7sAmnB6YT0B8IA8TcReMVouCaywesJsWAOLSXcAUXPKfNKpvzjC25NKi+dRhHJDCX/fG4WiHAoEBvdgjmoMJ9eTZnhLbcR2sPpaE5mLHPNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881339; c=relaxed/simple;
	bh=VneD3LX91mMVNS9V8upIgzYFKlv4ELAQ7huR/BuL67s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWfMaQNJ4OTwEvy+RccfiqKoPwYrj7rMXbufVw/XEcbHY1FOSOaX0kUB7w5jt2E8AnNIGq0FtyNCr//GGkjgK1pHpKIOPM/+oaSzl/nIWUmEaUWh87NUht5W5wwWbo9sFmDDnwnQwWOv4NuamL2/j7TmZlu/GxyaEzj9GcmtB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwHXfvLV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733881338; x=1765417338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VneD3LX91mMVNS9V8upIgzYFKlv4ELAQ7huR/BuL67s=;
  b=TwHXfvLVcObxhOvzDV+/y8I260CkRKiQVtDQbDTkSAxwIE2SlPPYb2HP
   pyqFLZ00svmsWWNKrS4Rgasxy6lNq/lhbOVsIek0MtKWiewoOX5CM9HT2
   9T4GqijCH17+oTQbg2OBWOhDLLYRx6J2Bn0AvQkIhN3CN00vya5BtOv8A
   oI50oTMFlpNaDvT6T0npc2OQFOxv+AVMHrxfo/VkPKxUzkhTE1Y9kD2zK
   1mfRUq5d6eJehbizPscFRkQoYDU41e522B4cUOke5R6HzQHDAYmnfpJ2G
   brZzJh767+k9pVeOWA6sj3dobtfUNUk9vFMpJEwBtn4xpEb3vbGq0gGJ/
   Q==;
X-CSE-ConnectionGUID: 471NLaQkTyKlbTXbyNGzxg==
X-CSE-MsgGUID: IzgFHl0ZTBmn0+kD12PH2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33570542"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="33570542"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 17:42:17 -0800
X-CSE-ConnectionGUID: XlCur5jzQS2volmAQWlBYg==
X-CSE-MsgGUID: tMrViD0DQN+iZxjVa8Gqog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96051745"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.134.127])
  by orviesa007.jf.intel.com with ESMTP; 10 Dec 2024 17:42:17 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH 2/6] x86/msr-index: Define MSR index and bit for the microcode staging feature
Date: Tue, 10 Dec 2024 17:42:08 -0800
Message-ID: <20241211014213.3671-3-chang.seok.bae@intel.com>
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
2.45.2


