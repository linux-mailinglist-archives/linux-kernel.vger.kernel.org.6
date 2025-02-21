Return-Path: <linux-kernel+bounces-524980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1A1A3E96F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA2D701E09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43730199236;
	Fri, 21 Feb 2025 00:54:15 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08F2D05E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099254; cv=none; b=PQeBKTnr/5LXPRFHcTV5dc7/4Q3h2WkCjaKqrXZSFSCFXNfxnpx6ZotMujgdY4fqiaR2a6vYIjsnGE81SxLZ83Fe314YCrhvCrXEvRIEXuRebLWM2gc+q4iPuoudHkdNXF6TVXCiThfmEcJ+5K5rnY7QBkKYcPwiMlwy7AgX/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099254; c=relaxed/simple;
	bh=lh+A7FGZ/xcbD6h7jXGxge0ahgwrOCQ8qpUKrqlbAZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rcf8ZTDhfkHr8GWrcIEz81oVj9itAk5dT6ZT2G79XGDnWXrrWhrAvao8WEfASGNYj9t6EQ72r2HCskDd6cgIJpRkg4b0BC99n6LdP+VEhH6mSgUHVlcbKg/fK2L1S7ajS/aD4+iG/d/XU/cgnOnoAbAzwXdLK7p2dSH83RYrFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlHIZ-000000003Qf-26S8;
	Thu, 20 Feb 2025 19:53:47 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v12 15/16] x86/mm: only invalidate final translations with INVLPGB
Date: Thu, 20 Feb 2025 19:53:14 -0500
Message-ID: <20250221005345.2156760-16-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221005345.2156760-1-riel@surriel.com>
References: <20250221005345.2156760-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Use the INVLPGB_FINAL_ONLY flag when invalidating mappings with INVPLGB.
This way only leaf mappings get removed from the TLB, leaving intermediate
translations cached.

On the (rare) occasions where we free page tables we do a full flush,
ensuring intermediate translations get flushed from the TLB.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/include/asm/tlb.h | 10 ++++++++--
 arch/x86/mm/tlb.c          | 13 +++++++------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index f69b243683e1..b1a18fe30d9b 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -86,9 +86,15 @@ static inline void __tlbsync(void)
 static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
 						  unsigned long addr,
 						  u16 nr,
-						  bool pmd_stride)
+						  bool pmd_stride,
+						  bool freed_tables)
 {
-	__invlpgb(0, pcid, addr, nr, pmd_stride, INVLPGB_PCID | INVLPGB_VA);
+	u8 flags = INVLPGB_PCID | INVLPGB_VA;
+
+	if (!freed_tables)
+		flags |= INVLPGB_FINAL_ONLY;
+
+	__invlpgb(0, pcid, addr, nr, pmd_stride, flags);
 }
 
 /* Flush all mappings for a given PCID, not including globals. */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 9ca22c504f82..8494d14d2fb7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -495,9 +495,10 @@ static inline void tlbsync(void)
 
 static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
 						unsigned long addr,
-						u16 nr, bool pmd_stride)
+						u16 nr, bool pmd_stride,
+						bool freed_tables)
 {
-	__invlpgb_flush_user_nr_nosync(pcid, addr, nr, pmd_stride);
+	__invlpgb_flush_user_nr_nosync(pcid, addr, nr, pmd_stride, freed_tables);
 	if (!this_cpu_read(cpu_tlbstate.need_tlbsync))
 		this_cpu_write(cpu_tlbstate.need_tlbsync, true);
 }
@@ -540,9 +541,9 @@ static void broadcast_tlb_flush(struct flush_tlb_info *info)
 			nr = clamp_val(nr, 1, invlpgb_count_max);
 		}
 
-		invlpgb_flush_user_nr_nosync(kern_pcid(asid), addr, nr, pmd);
+		invlpgb_flush_user_nr_nosync(kern_pcid(asid), addr, nr, pmd, info->freed_tables);
 		if (static_cpu_has(X86_FEATURE_PTI))
-			invlpgb_flush_user_nr_nosync(user_pcid(asid), addr, nr, pmd);
+			invlpgb_flush_user_nr_nosync(user_pcid(asid), addr, nr, pmd, info->freed_tables);
 
 		addr += nr << info->stride_shift;
 	} while (addr < info->end);
@@ -1696,10 +1697,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 	u16 asid = mm_global_asid(mm);
 
 	if (asid) {
-		invlpgb_flush_user_nr_nosync(kern_pcid(asid), uaddr, 1, false);
+		invlpgb_flush_user_nr_nosync(kern_pcid(asid), uaddr, 1, false, false);
 		/* Do any CPUs supporting INVLPGB need PTI? */
 		if (static_cpu_has(X86_FEATURE_PTI))
-			invlpgb_flush_user_nr_nosync(user_pcid(asid), uaddr, 1, false);
+			invlpgb_flush_user_nr_nosync(user_pcid(asid), uaddr, 1, false, false);
 
 		/*
 		 * Some CPUs might still be using a local ASID for this
-- 
2.47.1


