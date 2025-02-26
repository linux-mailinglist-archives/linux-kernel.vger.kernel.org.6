Return-Path: <linux-kernel+bounces-532902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE822A45393
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB9F3AA12D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE4C220699;
	Wed, 26 Feb 2025 03:01:50 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5621C189
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538909; cv=none; b=XNExRwQMw5n0pZKnyAzFeV3C7hJuJ4oaX6A9tiRNEi4orE1IU54gNJLAyn1Pb/PuOGKllLRoRH2JZlB035bxYpArtz3qdi1x/QfVq09ixnHEvASL0Ls84qRFnJHfLifJZ29yPNcxO3QT4Cz3OkZ8H9JMnk24tHveuc86CJ5/U0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538909; c=relaxed/simple;
	bh=Lh+tGf93XScZQgKqnSe27rnoFgCKCAHyXq4xGx840sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbG82mbQxxqQ+1V0HiJ3MP1aFW4TAnhQ7P/r+zhv+Y8Yb17tfPz6N/Kok8Zb/IXe8/jMA4Hl9XBAxzzonJtVcIH+/JabStw+cM47YxCCY6hT4xv8ZEkhuX/rbDpo5DY2AVYc5hICs9c+uyIQaPLa5YLldwGwxYifkWIJcaPjx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tn7fw-000000001Y5-1Tjt;
	Tue, 25 Feb 2025 22:01:32 -0500
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
	mingo@kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v14 13/13] x86/mm: only invalidate final translations with INVLPGB
Date: Tue, 25 Feb 2025 22:00:48 -0500
Message-ID: <20250226030129.530345-14-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226030129.530345-1-riel@surriel.com>
References: <20250226030129.530345-1-riel@surriel.com>
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
index e645884a1877..8d78667a2d1b 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -92,9 +92,15 @@ static inline void __tlbsync(void)
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
index 4d56d22b9893..91680cfd5868 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -497,9 +497,10 @@ static inline void tlbsync(void)
 
 static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
 						unsigned long addr,
-						u16 nr, bool pmd_stride)
+						u16 nr, bool pmd_stride,
+						bool freed_tables)
 {
-	__invlpgb_flush_user_nr_nosync(pcid, addr, nr, pmd_stride);
+	__invlpgb_flush_user_nr_nosync(pcid, addr, nr, pmd_stride, freed_tables);
 	if (!cpu_need_tlbsync())
 		cpu_write_tlbsync(true);
 }
@@ -542,9 +543,9 @@ static void broadcast_tlb_flush(struct flush_tlb_info *info)
 			nr = clamp_val(nr, 1, invlpgb_count_max);
 		}
 
-		invlpgb_flush_user_nr_nosync(kern_pcid(asid), addr, nr, pmd);
+		invlpgb_flush_user_nr_nosync(kern_pcid(asid), addr, nr, pmd, info->freed_tables);
 		if (static_cpu_has(X86_FEATURE_PTI))
-			invlpgb_flush_user_nr_nosync(user_pcid(asid), addr, nr, pmd);
+			invlpgb_flush_user_nr_nosync(user_pcid(asid), addr, nr, pmd, info->freed_tables);
 
 		addr += nr << info->stride_shift;
 	} while (addr < info->end);
@@ -1688,10 +1689,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
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


