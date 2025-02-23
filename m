Return-Path: <linux-kernel+bounces-527929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D8A41156
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8489E1896845
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942261DD9AC;
	Sun, 23 Feb 2025 19:50:16 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7F194A44
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740340215; cv=none; b=X/aVoq6ir0QuAaw/uzc102iPgIm3T4/IK2ELLUwKOvYELQB9ht37hFCDN46kw2PaFdFeC6msNsbxkcQgHAvNYQXE9KLJl1vWNJQUlBJY8APawAqG+FM263SPr/dQzcEHustP/T8+IF8trZPPQ+cVyvpqqG8MWF/IW1Ql5yQ8X0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740340215; c=relaxed/simple;
	bh=BsV55aOc9EcS8MtD+xK+PDskb7GxviGFkOkYsUMrJp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufTleC8r7LnFK2rQvYhy4XC+wik96IpE5wn6D/hiBd2fa6A3rdmMPABB46zDLtirSrltFa56vMlujFlbNeQBQXi1/nuoLVEURWa/QtPLOdn9/OH/gi+KtypHHhwz+5LIFSBVPHTdGMONnY+FDHKUTyRwCPkExOMjA9DLsxKq8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tmHyz-000000001hX-03Bc;
	Sun, 23 Feb 2025 14:49:45 -0500
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
Subject: [PATCH v13 09/14] x86/mm: global ASID process exit helpers
Date: Sun, 23 Feb 2025 14:48:59 -0500
Message-ID: <20250223194943.3518952-10-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250223194943.3518952-1-riel@surriel.com>
References: <20250223194943.3518952-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

A global ASID is allocated for the lifetime of a process.

Free the global ASID at process exit time.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/include/asm/mmu_context.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 795fdd53bd0a..d670699d32c2 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -139,6 +139,8 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 #define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
+extern void destroy_context_free_global_asid(struct mm_struct *mm);
+
 /*
  * Init a new mm.  Used on mm copies, like at fork()
  * and on mm's that are brand-new, like at execve().
@@ -161,6 +163,14 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.execute_only_pkey = -1;
 	}
 #endif
+
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		mm->context.global_asid = 0;
+		mm->context.asid_transition = false;
+	}
+#endif
+
 	mm_reset_untag_mask(mm);
 	init_new_context_ldt(mm);
 	return 0;
@@ -170,6 +180,10 @@ static inline int init_new_context(struct task_struct *tsk,
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		destroy_context_free_global_asid(mm);
+#endif
 }
 
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-- 
2.47.1


