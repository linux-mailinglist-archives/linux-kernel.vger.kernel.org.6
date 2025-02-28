Return-Path: <linux-kernel+bounces-539296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C4A4A304
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834203A855E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057D927CCDD;
	Fri, 28 Feb 2025 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K0M6voRW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36592277803
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772087; cv=none; b=pMfoY59mBrC2KSIPevvvvDk3rMOfmzATvFlwk1t23W9JaY4JdXlndxaPJ+vTrZOghMfdVsIfGa1KSN/dxsgiFDnKrNlERXuYruqp1PNyRf86ZxJbBVxvanB2OePfklVGthilCoGYME+MFVNDEWaOrhGahmjN+6hWOdpgde8SV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772087; c=relaxed/simple;
	bh=LyFdTCxPT4J2RZQkoAgXr4esZ0py0dabSkHAcUA6HRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLX+0auOpMvvs+LoWFCjwY/0sWW+XALzMGp3rDmFnr4JFjcvyR6uzFEEo4XoyFfb5C1bKuMgMMU9iTlKgp/X9xgZOjPjsiY6RY7U3+6MsBmtyM1S9kOBLhVmR9TJ3wgD++I1vJqd53fEaD4HZs+6JGl+11TfJ6TvbGaCFUPtjZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K0M6voRW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7C63640E01C5;
	Fri, 28 Feb 2025 19:48:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2onyYHBaD317; Fri, 28 Feb 2025 19:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740772077; bh=0SzmodUXTclpxnZRp7IzVUT4gYGfpQPgKhQxXZ5liLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0M6voRWvsoR+4hspNFZ3zXaVZOFVhfXlOZwNUQgISfLGpGziazs8c3R/gOodKaqK
	 d1Au7kFY8/2M6xDqsYFZfdrtSUcFuT65mSTve0pz9epbSNOCoZ/jG18/9uXJuKXGG8
	 EEFllENCaKji5kC9rzBCV/s2wXzzfyVg8mATZREaf7Pmq67OBEJ2jsPJxB+Zhoe/Qk
	 ZJDiHCpbNpxFGg0pYRyIOXimcJ52LbsnB7cjdVLWkcCsMVczouFzxXe4oXhPPnAW5M
	 JNm6OK2HC93Ozlh9dDoos8jmZh+dtN6UnWvP9WExaLRGc7leXL25KU6Rwqksu+dnGa
	 uejF6GV5cOrOPlgjaSt6w5wcpPSd8TZHnSm/A1o9zwXIpg5E1JsPO+E1r/E3mL7I8c
	 NIVQdsj5SLGUAFGUyquns5ShlxrMraehdifxCgNk7WgukpN9asrUphRRw5D33GcGd0
	 7+OA+G0+8p138Cf4Q2rjJ0osCEgvz8Pfl7pF1eyJPMs40eBMYXUvzcKbEgR8gTIm6p
	 jAGUZMrztErSTBQHfepKQnqO9EtnTwSmL8FcJ7rBt9t5krhhai20uVCGVYjwj214VP
	 C03tiRCbR9FjmLJuQGfgh6GLuLNthyEqjaDkUbUiFXNF6kOq4vuH4zZT3id07cV/7g
	 Sy3Ncv5OtbNpz/TY5H6PWR8k=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61E4140E01AE;
	Fri, 28 Feb 2025 19:47:39 +0000 (UTC)
Date: Fri, 28 Feb 2025 20:47:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v14 03/13] x86/mm: add INVLPGB support code
Message-ID: <20250228194734.GGZ8IS1iFVpPzmEyYl@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-4-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-4-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:38PM -0500, Rik van Riel wrote:
> Add helper functions and definitions needed to use broadcast TLB
> invalidation on AMD EPYC 3 and newer CPUs.
> 
> All the functions defined in invlpgb.h are used later in the series.
> 
> Compile time disabling X86_FEATURE_INVLPGB when the config
> option is not set allows the compiler to omit unnecessary code.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> ---
>  arch/x86/include/asm/disabled-features.h |  8 +-
>  arch/x86/include/asm/tlb.h               | 98 ++++++++++++++++++++++++
>  2 files changed, 105 insertions(+), 1 deletion(-)

My edits ontop.

x86/cpu has dropped {disabled,required}-features.h in favor of a new, better
mechanism to compile-time disable X86 features, see below.

--- /tmp/current.patch	2025-02-28 20:44:40.765404608 +0100
+++ /tmp/0001-x86-mm-Add-INVLPGB-support-code.patch	2025-02-28 20:44:18.492326903 +0100
@@ -1,55 +1,38 @@
+From ce22946ea806ae459b4d88767a59b010e70682d5 Mon Sep 17 00:00:00 2001
 From: Rik van Riel <riel@surriel.com>
-Date: Tue, 25 Feb 2025 22:00:38 -0500
-Subject: x86/mm: Add INVLPGB support code
+Date: Fri, 28 Feb 2025 20:32:30 +0100
+Subject: [PATCH]  x86/mm: Add INVLPGB support code
 
 Add helper functions and definitions needed to use broadcast TLB
-invalidation on AMD EPYC 3 and newer CPUs.
+invalidation on AMD CPUs.
 
-All the functions defined in invlpgb.h are used later in the series.
-
-Compile time disabling X86_FEATURE_INVLPGB when the config
-option is not set allows the compiler to omit unnecessary code.
+  [ bp:
+      - Cleanup commit message
+      - port it to new Kconfig.cpufeatures machinery
+      - add a comment about flushing any PCID and ASID ]
 
 Signed-off-by: Rik van Riel <riel@surriel.com>
 Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
-Acked-by: Dave Hansen <dave.hansen@intel.com>
-Tested-by: Manali Shukla <Manali.Shukla@amd.com>
-Tested-by: Brendan Jackman <jackmanb@google.com>
-Tested-by: Michael Kelley <mhklinux@outlook.com>
 Link: https://lore.kernel.org/r/20250226030129.530345-4-riel@surriel.com
 ---
- arch/x86/include/asm/disabled-features.h |  8 +-
- arch/x86/include/asm/tlb.h               | 98 ++++++++++++++++++++++++
- 2 files changed, 105 insertions(+), 1 deletion(-)
-
-diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
-index c492bdc97b05..625a89259968 100644
---- a/arch/x86/include/asm/disabled-features.h
-+++ b/arch/x86/include/asm/disabled-features.h
-@@ -129,6 +129,12 @@
- #define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
- #endif
- 
-+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
-+#define DISABLE_INVLPGB		0
-+#else
-+#define DISABLE_INVLPGB		(1 << (X86_FEATURE_INVLPGB & 31))
-+#endif
-+
- /*
-  * Make sure to add features to the correct mask
-  */
-@@ -146,7 +152,7 @@
- #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
- 			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
- #define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
--#define DISABLED_MASK13	0
-+#define DISABLED_MASK13	(DISABLE_INVLPGB)
- #define DISABLED_MASK14	0
- #define DISABLED_MASK15	0
- #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
+ arch/x86/Kconfig.cpufeatures |   4 ++
+ arch/x86/include/asm/tlb.h   | 101 +++++++++++++++++++++++++++++++++++
+ 2 files changed, 105 insertions(+)
+
+diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
+index 5dcc49d928c5..f9af51205f07 100644
+--- a/arch/x86/Kconfig.cpufeatures
++++ b/arch/x86/Kconfig.cpufeatures
+@@ -195,3 +195,7 @@ config X86_DISABLED_FEATURE_FRED
+ config X86_DISABLED_FEATURE_SEV_SNP
+ 	def_bool y
+ 	depends on !KVM_AMD_SEV
++
++config X86_DISABLED_FEATURE_BROADCAST_TLB_FLUSH
++	def_bool y
++	depends on !X86_BROADCAST_TLB_FLUSH
 diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
-index 77f52bc1578a..91c9a4da3ace 100644
+index 77f52bc1578a..45d9c7687d61 100644
 --- a/arch/x86/include/asm/tlb.h
 +++ b/arch/x86/include/asm/tlb.h
 @@ -6,6 +6,9 @@
@@ -62,7 +45,7 @@ index 77f52bc1578a..91c9a4da3ace 100644
  
  static inline void tlb_flush(struct mmu_gather *tlb)
  {
-@@ -25,4 +28,99 @@ static inline void invlpg(unsigned long addr)
+@@ -25,4 +28,102 @@ static inline void invlpg(unsigned long addr)
  	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
  }
  
@@ -157,11 +140,14 @@ index 77f52bc1578a..91c9a4da3ace 100644
 +/* Flush all mappings for all PCIDs except globals. */
 +static inline void invlpgb_flush_all_nonglobals(void)
 +{
++	/*
++	 * @addr=0 means both rax[1] (valid PCID) and rax[2] (valid ASID) are clear
++	 * so flush *any* PCID and ASID.
++	 */
 +	__invlpgb(0, 0, 0, 1, 0, 0);
 +	__tlbsync();
 +}
-+
  #endif /* _ASM_X86_TLB_H */
 -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

