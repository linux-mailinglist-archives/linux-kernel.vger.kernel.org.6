Return-Path: <linux-kernel+bounces-524973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDDCA3E969
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA26E188E081
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8D62A1C9;
	Fri, 21 Feb 2025 00:54:11 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25C79F2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099251; cv=none; b=pbQ4IW1whh970Y2VHGPX5UbNa2OV6fY1Gmy+rFDL8GTmZb+dvgim/aGpIhMvGnd1QCtZnlfs/HQ3IydhXdy+0RDN5iwyJ7oVml8F7o1gnJfyp72IbOpg9YTI6Xc1LWRC+w+7I5aA0OgyZMeHJ/j2hlnux57eOPeh1BPiDLIf4HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099251; c=relaxed/simple;
	bh=BsV55aOc9EcS8MtD+xK+PDskb7GxviGFkOkYsUMrJp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJivCrf4FrFk/Hv4CECD/eSvGlaBFW6rpbbkSZpbzSJ8TF95mU3cDVfc1/4vME9MQAfFdmfNODjpxusRATZhCY1uWopvK2Ijjn1vvqPVgec+wDz2SLJw0XaayFpNtpS2F/yl0sVzuaL4OzjLpyk8k8olpcxTQ4oFCl1JhCWl4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlHIZ-000000003Qf-1eSr;
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
Subject: [PATCH v12 11/16] x86/mm: global ASID process exit helpers
Date: Thu, 20 Feb 2025 19:53:10 -0500
Message-ID: <20250221005345.2156760-12-riel@surriel.com>
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


