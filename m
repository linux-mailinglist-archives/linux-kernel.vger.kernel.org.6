Return-Path: <linux-kernel+bounces-544108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF1A4DD73
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271DD169299
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB91F3BAD;
	Tue,  4 Mar 2025 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YkV2XnKS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F31FAC50
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089923; cv=none; b=Y8+hxqaeExaOYcX2ZTqgJfGP1x62oYH9KJf9G7AmYE8h4sCThUFwOpT1O7rkGTGjDzuLMDPVS9UFvBQUhThQMs3BNHrw54Tsx4lZess2mKzGIXnRR+NbfYpx9+NJ4Jhz4TqlwZ6Je/ccTmeZ2R+morUs1Viff0OvMER2O4yKPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089923; c=relaxed/simple;
	bh=UHb4GMe3UFbd/knaN71Hr8P4eZRibZS8A1+p1T/CccM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7eRDC6w87X4bSuOCChEZykzn4YIhVzOjsEaz42bGaovIFEk20Qo4XcWyQp3aMbPCIw9EeCYnbg4S4wcX/MwMMToPFWBTcQ7TpyCBLRynMnQwdNSI1twFky1BTUJgl98stqqxZo3GfiabPGGQn0Ufc6FTgFJdhCS5Vk78xi4jtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YkV2XnKS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 399D240E0214;
	Tue,  4 Mar 2025 12:05:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5rp5czbxZx6k; Tue,  4 Mar 2025 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741089913; bh=vSIowNyCqsQ3yQ5qd5aOdrOx5Br2Nf7cQMl4V4s4NFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkV2XnKSHaOiTk0OF/6kS1haFPLjq46gR2peMMrngiX5KptleErgGxN7RdJDPwS/r
	 fwhb3x/TgfIs4Ltw0iYNEcI6u6dMrGREsPGBm8yU6WAz2yTr/Nbv5Ce93dChg8Bu9E
	 zr1rZ9EMJUm7f0GMSL8jLDW9NugrajFtvE1nsabCTDVlY0YMDPFwoazzh9+CUjccTv
	 1I3UsSET6YQAirEMobmLphjdu7feNel210HJo3PCmt8iLSu7N7aUd7o16kLVFX6vPW
	 0RdLGpmI8P1mF/tpPWor+7UGOnqcCUXGSgQd9ll1DGuZYK5vZLzQi5VcF+xTEZ2Vof
	 Ue2bOkZSoR+STn136u5TbpR+HJWpVhEQojVRoXnwkMN1rvB9u1gk6KaVhPnGTICqnx
	 6trVSM/EbI2l1nenGrzj5ILDE3KQp25YRYO12mXGFsp0UhjtrGDala/iO27dBS+nO9
	 cqsMnPeWS28m6g0iWzGE2UCFhluYB+sPu9zzVbgHDWr775MKGOhEhvyU/ug/W+Q2Aq
	 jlsNgAIBpIEpWY1QGuj27dKFA3qjnfjo5k54a3CTfymqPxpj2ucS6zJZD+v55mPLZ/
	 HssgeyVzhT37H7dvbkndyYyVDup2GevoqLgPGigHiqzWSY4nPzIwvsd7K2r2I0RItg
	 iN2DAPM99F4Co7lFRstS1XcY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3DF8240E020E;
	Tue,  4 Mar 2025 12:04:56 +0000 (UTC)
Date: Tue, 4 Mar 2025 13:04:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: [PATCH] x86/mm: Always set the ASID valid bit for the INVLPGB
 instruction
Message-ID: <20250304120449.GHZ8bsYYyEBOKQIxBm@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-1-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:35PM -0500, Rik van Riel wrote:
> Add support for broadcast TLB invalidation using AMD's INVLPGB instruction.

One more patch ontop from Tom.

Now lemme test this a bit again...

From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Tue, 4 Mar 2025 12:59:56 +0100
Subject: [PATCH] x86/mm: Always set the ASID valid bit for the INVLPGB instruction

When executing the INVLPGB instruction on a bare-metal host or hypervisor, if
the ASID valid bit is not set, the instruction will flush the TLB entries that
match the specified criteria for any ASID, not just the those of the host. If
virtual machines are running on the system, this may result in inadvertent
flushes of guest TLB entries.

When executing the INVLPGB instruction in a guest and the INVLPGB instruction is
not intercepted by the hypervisor, the hardware will replace the requested ASID
with the guest ASID and set the ASID valid bit before doing the broadcast
invalidation. Thus a guest is only able to flush its own TLB entries.

So to limit the host TLB flushing reach, always set the ASID valid bit using an
ASID value of 0 (which represents the host/hypervisor). This will will result in
the desired effect in both host and guest.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/tlb.h | 58 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index e8561a846754..56fe331fb797 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -33,6 +33,27 @@ enum addr_stride {
 	PMD_STRIDE = 1
 };
 
+/*
+ * INVLPGB can be targeted by virtual address, PCID, ASID, or any combination
+ * of the three. For example:
+ * - FLAG_VA | FLAG_INCLUDE_GLOBAL: invalidate all TLB entries at the address
+ * - FLAG_PCID:			    invalidate all TLB entries matching the PCID
+ *
+ * The first is used to invalidate (kernel) mappings at a particular
+ * address across all processes.
+ *
+ * The latter invalidates all TLB entries matching a PCID.
+ */
+#define INVLPGB_FLAG_VA			BIT(0)
+#define INVLPGB_FLAG_PCID		BIT(1)
+#define INVLPGB_FLAG_ASID		BIT(2)
+#define INVLPGB_FLAG_INCLUDE_GLOBAL	BIT(3)
+#define INVLPGB_FLAG_FINAL_ONLY		BIT(4)
+#define INVLPGB_FLAG_INCLUDE_NESTED	BIT(5)
+
+/* The implied mode when all bits are clear: */
+#define INVLPGB_MODE_ALL_NONGLOBALS	0UL
+
 #ifdef CONFIG_BROADCAST_TLB_FLUSH
 /*
  * INVLPGB does broadcast TLB invalidation across all the CPUs in the system.
@@ -40,14 +61,20 @@ enum addr_stride {
  * The INVLPGB instruction is weakly ordered, and a batch of invalidations can
  * be done in a parallel fashion.
  *
- * The instruction takes the number of extra pages to invalidate, beyond
- * the first page, while __invlpgb gets the more human readable number of
- * pages to invalidate.
+ * The instruction takes the number of extra pages to invalidate, beyond the
+ * first page, while __invlpgb gets the more human readable number of pages to
+ * invalidate.
  *
  * The bits in rax[0:2] determine respectively which components of the address
  * (VA, PCID, ASID) get compared when flushing. If neither bits are set, *any*
  * address in the specified range matches.
  *
+ * Since it is desired to only flush TLB entries for the ASID that is executing
+ * the instruction (a host/hypervisor or a guest), the ASID valid bit should
+ * always be set. On a host/hypervisor, the hardware will use the ASID value
+ * specified in EDX[15:0] (which should be 0). On a guest, the hardware will
+ * use the actual ASID value of the guest.
+ *
  * TLBSYNC is used to ensure that pending INVLPGB invalidations initiated from
  * this CPU have completed.
  */
@@ -55,9 +82,9 @@ static inline void __invlpgb(unsigned long asid, unsigned long pcid,
 			     unsigned long addr, u16 nr_pages,
 			     enum addr_stride stride, u8 flags)
 {
-	u32 edx = (pcid << 16) | asid;
+	u64 rax = addr | flags | INVLPGB_FLAG_ASID;
 	u32 ecx = (stride << 31) | (nr_pages - 1);
-	u64 rax = addr | flags;
+	u32 edx = (pcid << 16) | asid;
 
 	/* The low bits in rax are for flags. Verify addr is clean. */
 	VM_WARN_ON_ONCE(addr & ~PAGE_MASK);
@@ -87,27 +114,6 @@ static inline void __invlpgb(unsigned long asid, unsigned long pcid,
 static inline void __tlbsync(void) { }
 #endif
 
-/*
- * INVLPGB can be targeted by virtual address, PCID, ASID, or any combination
- * of the three. For example:
- * - FLAG_VA | FLAG_INCLUDE_GLOBAL: invalidate all TLB entries at the address
- * - FLAG_PCID:			    invalidate all TLB entries matching the PCID
- *
- * The first is used to invalidate (kernel) mappings at a particular
- * address across all processes.
- *
- * The latter invalidates all TLB entries matching a PCID.
- */
-#define INVLPGB_FLAG_VA			BIT(0)
-#define INVLPGB_FLAG_PCID		BIT(1)
-#define INVLPGB_FLAG_ASID		BIT(2)
-#define INVLPGB_FLAG_INCLUDE_GLOBAL	BIT(3)
-#define INVLPGB_FLAG_FINAL_ONLY		BIT(4)
-#define INVLPGB_FLAG_INCLUDE_NESTED	BIT(5)
-
-/* The implied mode when all bits are clear: */
-#define INVLPGB_MODE_ALL_NONGLOBALS	0UL
-
 static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
 						  unsigned long addr,
 						  u16 nr, bool stride)
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

