Return-Path: <linux-kernel+bounces-400797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D1C9C127D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD0FB22408
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF9215F58;
	Thu,  7 Nov 2024 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKm8NYfV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808E1E25F5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022311; cv=none; b=luGNsZHx3hckD3CjiBTHrNXjiVczzng3XwIHOUWJDVhQ1eS/W3uL92ufpDw0igyE/eEPQdRlw5IFQf6OwkVdO9CT38dBHoH+gG+bkG/i7HzmMlhnnOt1wRrlb4sK8wa0kSRG5fvA1eWKD4htzqSYhT35hF/Obd/qZtjxvBeOqZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022311; c=relaxed/simple;
	bh=YucaGSAuRAKtRsTzpZqjt2RuENf7r3Tx5PTUKMDWF4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Px/ezm7kELInd4fIy6p5Ay+z/R3Fb6tmE9ioeASKQp53Q4s4Ivdp4kkuWJx45poEYTpdaewi84QAn0gg5t7HBui+Q027rVTOeuDKEosbe27GMEUlfeyb/FdDPOoiRAbtDgRRKXXAfyCSMa00fjc6GF2ZNZzkh17coYs4m8Z1GaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKm8NYfV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731022309; x=1762558309;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YucaGSAuRAKtRsTzpZqjt2RuENf7r3Tx5PTUKMDWF4Y=;
  b=QKm8NYfVqVm6axXKoDOqB/3vWW8UWSzmRwbRJKL41hlAfQEOyWa1THYa
   4lVAuyeUtV5GkYFPv+h5cvlujMvfiuAlSGrPSfo8dPR/iKtHfETW33pkR
   TifUg3OU5e/rxJHbcqCkob2ACcRLMgWGvSw/LDz4+M+q28JmK+AreQkvk
   5MEnWiZPDs/ugLs0zYOIi1oaqqli2VRfIMiqF/PYmaRFtnL1Ussllmls9
   nXncB8bzOnscSeZprrhiWs0n/46rdakdy/JvzygMJPxGuyokpg51gUwlN
   fPOZTwGMPIE88CJlq+UU+zeMsqBUhjVjR+LY9tz5yxOJ+ZcCzPqZx17Db
   Q==;
X-CSE-ConnectionGUID: Z3FDr7b8STyr76Cdhnl/rA==
X-CSE-MsgGUID: aYxW5gxdRIqfXKngBI9AbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="56292176"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="56292176"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 15:31:46 -0800
X-CSE-ConnectionGUID: Z/Pq55q/SYes4uFhvTKNUA==
X-CSE-MsgGUID: 8Bn/tjQ5TXmYKwvFKsruOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="84805893"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa006.fm.intel.com with ESMTP; 07 Nov 2024 15:31:46 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpufeatures: Free up unused feature bits
Date: Thu,  7 Nov 2024 23:30:00 +0000
Message-Id: <20241107233000.2742619-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux defined feature bits X86_FEATURE_P3 and X86_FEATURE_P4 are not
used anywhere, neither are they visible to userspace.
commit f31d731e4467 ("x86: use X86_FEATURE_NOPL in alternatives") got
rid of the last usage. Remove the related mappings and code.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 4 ++--
 arch/x86/kernel/cpu/intel.c        | 5 -----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 913fd3a7bac6..f5c4ea3fd364 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -83,8 +83,8 @@
 #define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* "centaur_mcr" Centaur MCRs (= MTRRs) */
 #define X86_FEATURE_K8			( 3*32+ 4) /* Opteron, Athlon64 */
 #define X86_FEATURE_ZEN5		( 3*32+ 5) /* CPU based on Zen5 microarchitecture */
-#define X86_FEATURE_P3			( 3*32+ 6) /* P3 */
-#define X86_FEATURE_P4			( 3*32+ 7) /* P4 */
+/* Free                                 ( 3*32+ 6) */
+/* Free                                 ( 3*32+ 7) */
 #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* "constant_tsc" TSC ticks at a constant rate */
 #define X86_FEATURE_UP			( 3*32+ 9) /* "up" SMP kernel running on UP */
 #define X86_FEATURE_ART			( 3*32+10) /* "art" Always running timer (ART) */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e7656cbef68d..1c892ebaa68c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -628,11 +628,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 		if (p)
 			strcpy(c->x86_model_id, p);
 	}
-
-	if (c->x86 == 15)
-		set_cpu_cap(c, X86_FEATURE_P4);
-	if (c->x86 == 6)
-		set_cpu_cap(c, X86_FEATURE_P3);
 #endif
 
 	/* Work around errata */
-- 
2.34.1


