Return-Path: <linux-kernel+bounces-532899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B35EA45391
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B043A8948
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6693220687;
	Wed, 26 Feb 2025 03:01:50 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E41A3BA1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538908; cv=none; b=LSBi53SOgNy77U1unmUYDDY4pUvCy3+2npvFB/BHV5TqxIyuWzbQiT2/fxw6HUwhlX8ORDS7Ef3GrBz29ydivvZvLAbXFWetMqs/kQqBReLB36pCuOAt0qiOW5DqNNySyyhq9xD3ZOYoFNkVfKxdd4BfEM3RQBE8RXXtRDwRXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538908; c=relaxed/simple;
	bh=E3yTmPp1Y2FS7fWsvI/a3/TXWwQQc0TEFegC0pOxfzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzGAxpNZwTNN74CcTgJAxWpQGkq1VAgoHmF+m66bhO5UQ1hjgxnKuWo3f1+ATM1QUngaIuYzma+AKe5kNSPsEBxq9bHI1G9u6gnxk42IEI3X5nxzf8JHcrxOU+29MTbfcrBgtOElpFvRrbFQMZwnAji9mcxUfEqrabKYZd6ItAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tn7fw-000000001Y5-16PD;
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
Subject: [PATCH v14 09/13] x86/mm: global ASID process exit helpers
Date: Tue, 25 Feb 2025 22:00:44 -0500
Message-ID: <20250226030129.530345-10-riel@surriel.com>
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

A global ASID is allocated for the lifetime of a process.

Free the global ASID at process exit time.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/include/asm/mmu_context.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index a2c70e495b1b..b47ac6d270e6 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -163,6 +163,14 @@ static inline int init_new_context(struct task_struct *tsk,
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
@@ -172,6 +180,10 @@ static inline int init_new_context(struct task_struct *tsk,
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		mm_free_global_asid(mm);
+#endif
 }
 
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-- 
2.47.1


