Return-Path: <linux-kernel+bounces-170646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B178D8BDA24
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FFAB22951
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37F51C3F;
	Tue,  7 May 2024 04:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9UsGpZj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B8E1EB5E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055868; cv=none; b=a6QhM0QoSzIFHujL6xJ5hqpaW5weQZhcqox2MSNIzIZVLljlDsuMGWT+bmpLkpAALB/3NSG2Xf4z0JOQy/KpFWTbbfcSs+cjlj5w1KicM7HuQ4QhE6ztvGqki8Q/J1nUu3FX3tF4BInT8ZuByXJT90BxVK9nWnd2rHPrbF8eyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055868; c=relaxed/simple;
	bh=sbvMvmZ1xrFtTdjVcorWScV5WUeQXDFq/Ip36zjitQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZGSyse/KLmvC1DYEU508D3yZ16swhkvBctrO4QlGgNfBBrPTO7LjUK8WWr2duCxCO4pIjWFCHzY15+0tJhgZ/UZlu86ckcNLvQA+QNPaJ7DVageKRLF8LQU3T12DSZNX2/UtxPyZhxmZKz1ONEAI4bCUFDHRcCf1shOlWhcAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9UsGpZj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715055867; x=1746591867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sbvMvmZ1xrFtTdjVcorWScV5WUeQXDFq/Ip36zjitQU=;
  b=n9UsGpZj3cONI5JBdfpGt+c9vW9e2o6EwB6+dNpmZ9aU8BrMmzJNTX0k
   eKabTNhNZokcU52tl74UtfLRWc1JhRYUoSD/Rvko8k3xN5oXqHA+f3nit
   abAh8bshaHK4Opmw9m6jgdO/ftIR1E3MBb/6N8ysggSCKCrfcsAd+gWIX
   MgHOpJaHTWcEM7GkMF0MefkUc7eOjL5iGdx2YNG9ODHJjBwAgsuIH/3gl
   jxAXSghswNMaNYrGEdEBmYvXF5E3oI5xhgUhoeiS2KIF3Jt6AANE6iDDO
   O0o597IT8EQ94CmNKusdZmYsAQEbtCo2Cvf4fEln4ZZXxCcXSrXY9Ey4M
   A==;
X-CSE-ConnectionGUID: IZiTnj26Q/maD62yJhofjw==
X-CSE-MsgGUID: vlxZe6VtQ8WMAs2MGWrl0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22230754"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="22230754"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 21:24:25 -0700
X-CSE-ConnectionGUID: 2Les3HCDSPKEKstdTEqvcQ==
X-CSE-MsgGUID: y64pocR+TLCzvg+Mpim4bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="33047158"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.193.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 21:24:25 -0700
From: alison.schofield@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/cpu: Remove useless work in detect_tme_early()
Date: Mon,  6 May 2024 21:24:21 -0700
Message-Id: <86dfdf6ced8c9b790f9376bf6c7e22b5608f47c2.1715054189.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1715054189.git.alison.schofield@intel.com>
References: <cover.1715054189.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

TME (Total Memory Encryption) and MKTME (Multi-Key Total Memory
Encryption) BIOS detection were introduced together here [1] and
are loosely coupled in the Intel CPU init code.

TME is a hardware only feature and its BIOS status is all that needs
to be shared with the kernel user: enabled or disabled. The TME
algorithm the BIOS is using and whether or not the kernel recognizes
that algorithm is useless to the kernel user.

MKTME is a hardware feature that requires kernel support. MKTME
detection code was added in advance of broader kernel support for
MKTME that never followed. So, rather than continuing to spew
needless and confusing messages about BIOS MKTME status, remove
most of the MKTME pieces from detect_tme_early().

Keep one useful message: alert the user when BIOS enabled MKTME
reduces the available physical address bits. Recovery of the MKTME
consumed bits requires a reboot with MKTME disabled in BIOS.

There is no functional change for the user, only a change in boot
messages. Below is one example when both TME and MKTME are enabled
in BIOS with AES_XTS_256 which is unknown to the detect tme code.

Before:
[] x86/tme: enabled by BIOS
[] x86/tme: Unknown policy is active: 0x2
[] x86/mktme: No known encryption algorithm is supported: 0x4
[] x86/mktme: enabled by BIOS
[] x86/mktme: 127 KeyIDs available

After:
[] x86/tme: enabled by BIOS
[] x86/mktme: BIOS enable: x86_phys_bits reduced by 8


[1]
commit cb06d8e3d020 ("x86/tme: Detect if TME and MKTME is activated by BIOS")

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 72 +++++++------------------------------
 1 file changed, 12 insertions(+), 60 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3c3e7e5695ba..3ef4e0137d21 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -190,83 +190,35 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 #define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
 #define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
 
-#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
-#define TME_ACTIVATE_POLICY_AES_XTS_128	0
-
 #define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
 
-#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
-#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
-
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
-
 static void detect_tme_early(struct cpuinfo_x86 *c)
 {
-	u64 tme_activate, tme_policy, tme_crypto_algs;
-	int keyid_bits = 0, nr_keyids = 0;
-	static u64 tme_activate_cpu0 = 0;
+	u64 tme_activate;
+	int keyid_bits;
 
 	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
 
-	if (mktme_status != MKTME_UNINITIALIZED) {
-		if (tme_activate != tme_activate_cpu0) {
-			/* Broken BIOS? */
-			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
-			pr_err_once("x86/tme: MKTME is not usable\n");
-			mktme_status = MKTME_DISABLED;
-
-			/* Proceed. We may need to exclude bits from x86_phys_bits. */
-		}
-	} else {
-		tme_activate_cpu0 = tme_activate;
-	}
-
 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
-		mktme_status = MKTME_DISABLED;
 		clear_cpu_cap(c, X86_FEATURE_TME);
 		return;
 	}
-
-	if (mktme_status != MKTME_UNINITIALIZED)
-		goto detect_keyid_bits;
-
-	pr_info("x86/tme: enabled by BIOS\n");
-
-	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
-	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
-		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
-
-	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
-	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
-		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
-				tme_crypto_algs);
-		mktme_status = MKTME_DISABLED;
-	}
-detect_keyid_bits:
+	pr_info_once("x86/tme: enabled by BIOS\n");
 	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
-	nr_keyids = (1UL << keyid_bits) - 1;
-	if (nr_keyids) {
-		pr_info_once("x86/mktme: enabled by BIOS\n");
-		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
-	} else {
-		pr_info_once("x86/mktme: disabled by BIOS\n");
-	}
-
-	if (mktme_status == MKTME_UNINITIALIZED) {
-		/* MKTME is usable */
-		mktme_status = MKTME_ENABLED;
-	}
+	if (!keyid_bits)
+		return;
 
 	/*
-	 * KeyID bits effectively lower the number of physical address
-	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
+	 * KeyID bits are set by BIOS and can be present regardless
+	 * of whether the kernel is using them. They effectively lower
+	 * the number of physical address bits.
+	 *
+	 * Update cpuinfo_x86::x86_phys_bits accordingly.
 	 */
 	c->x86_phys_bits -= keyid_bits;
+	pr_info_once("x86/mktme: BIOS enabled: x86_phys_bits reduced by %d\n",
+		     keyid_bits);
 }
 
 static void early_init_intel(struct cpuinfo_x86 *c)
-- 
2.37.3


