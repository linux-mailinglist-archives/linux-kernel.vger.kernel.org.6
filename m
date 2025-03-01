Return-Path: <linux-kernel+bounces-539923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4D9A4AAE7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0A2167E14
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F4A1DE885;
	Sat,  1 Mar 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SEa8ZM6Z"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395E1CAA99
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740831656; cv=none; b=DIonJADAOOjtBbiO//qVkEtVx72rtjHkHEjlTI/0S/ookbimHz2hoDBRSHoGOefmBW2ZCo1L8z6W1O3rWaqBe5dVH8MOpvIxrLf8VMsufDPL1eeCXmHWviIAA+KxnRPeoHKvSbBGb19S/aADNHV9gZg0a1wW1o82H1RsYZmFxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740831656; c=relaxed/simple;
	bh=kz921Cs1XkcZDSEr0ctN/p4JB6f0/L0k5bISSnHlmJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhJu6jbHHcdLT6EM76nYH4kUxcUJeQOx/dCZI4orvhvg7sVg5f/O7tt23xLy5ZlU4bqcFoWepDESlDYLFcSoaXiZPqvkU6Qp3RZC3PeCsorqtJUlVpiYMCrEJNVAFFGBtg0g/fTmKRBjbnZhZK9YHKQDP1pxoTnsRFdQbCbXkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SEa8ZM6Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 306A240E0173;
	Sat,  1 Mar 2025 12:20:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aAMgY6Qui3vK; Sat,  1 Mar 2025 12:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740831646; bh=2HKI4C6iYTI8d0b77jQiRO2WBjPRZTq44Ez/ai+zb8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEa8ZM6ZDzgwLG1Sy6X1VKsTnDNPNiDmWVUcx54keQW6LFpqTrkOaJmOSC0ZjxABP
	 UumLuYDhnxiGSEMB+06g60r5RKI3RJmzefY6DhBxAMAZAgpEr2Dw5lF0bEzn3eNM5K
	 jTAeWntzw8EJHllnk/lOgzLhkG1cTXIM3T7UyDZLqKwVgYZ36p44S/RDc39IJtxd8l
	 d4xGpXUbk53A9BDaBCeTWXoRBohC4Oyc1jrh5O4dLogucJCMxwjmg+XmBVleqOgDns
	 FuUwAEp3hq14jQXuZE1cZEUauWkXWAMPCAtBM4VoPVz3m2vRz3w6Jh/hSPRghc3oKF
	 OVWof9edTegcqpknaIDt2YWD0AczI6+FXqoqXy5lxO0nVuXrTL0b++oE6pnADETqxb
	 IlAdrQmT2JQdiZbvfxKN9a9vLRGUTKomYnt/8jCEVMHcfGDUUYrFs223aX/LpSgeBC
	 vwxxCjLYKwz8of/uAASFk0CphkDYN88JvygkjII1bVWLYd4CjVVuAZ4zmeWTMmV68i
	 A8FITSN0yo0NjMNlv9BnFeEiyY+7KPrLPbl0DJ44lC1MoyGR0Nyr0tcgUnooKuLHCu
	 2gxdAR1iWpeGJXMk/g0HPt1dw0fMOo72wGlm+BE8vVu7FaBgOWllAa8b5Q+baef/PY
	 nT/mGJz88bIstsHanta9E2Qg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37F6E40E015F;
	Sat,  1 Mar 2025 12:20:28 +0000 (UTC)
Date: Sat, 1 Mar 2025 13:20:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 05/13] x86/mm: use INVLPGB in flush_tlb_all
Message-ID: <20250301122022.GBZ8L7hlwP5cUffJA2@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-6-riel@surriel.com>
 <f57b0b8c-1df4-4c6c-820e-20940aee7d0d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f57b0b8c-1df4-4c6c-820e-20940aee7d0d@intel.com>

On Fri, Feb 28, 2025 at 11:18:04AM -0800, Dave Hansen wrote:
> We haven't talked at all about the locking rules for
> invlpgb_flush_all(). It was used once in this series without any
> explicit preempt twiddling. I assume that was because it was used in a
> path where preempt is disabled.
> 
> If it does need a universal rule about preempt, can we please add an:
> 
> 	lockdep_assert_preemption_disabled()
> 
> along with a comment about why it needs preempt disabled?

So, after talking on IRC last night, below is what I think we should do ontop.

More specifically:

- I've pushed the preemption guard inside the functions which do
  INVLPGB+TLBSYNC so that callers do not have to think about it.

- invlpgb_kernel_range_flush() I still don't like and we have to rely there on
  cant_migrate() in __tlbsync() - I'd like for all of them to be nicely packed
  but don't have an idea yet how to do that cleanly...

- document what means for bits rax[0:2] being clear when issuing INVLPGB


That ok?

Anything I've missed?

If not, I'll integrate this into the patches.

Thx.

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 45d9c7687d61..0d90ceeb472b 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -39,6 +39,10 @@ static inline void invlpg(unsigned long addr)
  * the first page, while __invlpgb gets the more human readable number of
  * pages to invalidate.
  *
+ * The bits in rax[0:2] determine respectively which components of the address
+ * (VA, PCID, ASID) get compared when flushing. If neither bits are set, *any*
+ * address in the specified range matches.
+ *
  * TLBSYNC is used to ensure that pending INVLPGB invalidations initiated from
  * this CPU have completed.
  */
@@ -60,10 +64,10 @@ static inline void __invlpgb(unsigned long asid, unsigned long pcid,
 static inline void __tlbsync(void)
 {
 	/*
-	 * tlbsync waits for invlpgb instructions originating on the
-	 * same CPU to have completed. Print a warning if we could have
-	 * migrated, and might not be waiting on all the invlpgbs issued
-	 * during this TLB invalidation sequence.
+	 * TLBSYNC waits for INVLPGB instructions originating on the same CPU
+	 * to have completed. Print a warning if the task has been migrated,
+	 * and might not be waiting on all the INVLPGBs issued during this TLB
+	 * invalidation sequence.
 	 */
 	cant_migrate();
 
@@ -106,6 +110,13 @@ static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
 /* Flush all mappings, including globals, for all PCIDs. */
 static inline void invlpgb_flush_all(void)
 {
+	/*
+	 * TLBSYNC at the end needs to make sure all flushes done on the
+	 * current CPU have been executed system-wide. Therefore, make
+	 * sure nothing gets migrated in-between but disable preemption
+	 * as it is cheaper.
+	 */
+	guard(preempt)();
 	__invlpgb(0, 0, 0, 1, 0, INVLPGB_INCLUDE_GLOBAL);
 	__tlbsync();
 }
@@ -119,10 +130,7 @@ static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
 /* Flush all mappings for all PCIDs except globals. */
 static inline void invlpgb_flush_all_nonglobals(void)
 {
-	/*
-	 * @addr=0 means both rax[1] (valid PCID) and rax[2] (valid ASID) are clear
-	 * so flush *any* PCID and ASID.
-	 */
+	guard(preempt)();
 	__invlpgb(0, 0, 0, 1, 0, 0);
 	__tlbsync();
 }
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f49627e02311..8cd084bc3d98 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1075,19 +1075,11 @@ void flush_tlb_all(void)
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
 
 	/* First try (faster) hardware-assisted TLB invalidation. */
-	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
-		/*
-		 * TLBSYNC at the end needs to make sure all flushes done
-		 * on the current CPU have been executed system-wide.
-		 * Therefore, make sure nothing gets migrated
-		 * in-between but disable preemption as it is cheaper.
-		 */
-		guard(preempt)();
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
 		invlpgb_flush_all();
-	} else {
+	else
 		/* Fall back to the IPI-based invalidation. */
 		on_each_cpu(do_flush_tlb_all, NULL, 1);
-	}
 }
 
 /* Flush an arbitrarily large range of memory with INVLPGB. */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

