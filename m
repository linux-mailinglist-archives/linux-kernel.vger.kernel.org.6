Return-Path: <linux-kernel+bounces-510021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A54A31758
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30DC188B8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA62267F6A;
	Tue, 11 Feb 2025 21:08:39 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88AD265CB1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308118; cv=none; b=Rob9eiH2LbcoeKjta5sSem/80KwNINtDqO3bM7H+qZ74Yve1MoGvxoRapj7IrKsPGrYX8gKuAu/GDu4K8Rnr84E095tEvkp/riqt0QbjlyOTCZKfkBpkrnCGOu1M7BqM/ftdE81m8DlxMc17WQ5iZ66DMwkC7wa5vEw+7ffu74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308118; c=relaxed/simple;
	bh=UtuFvFsmUy02U+c14rBYp+5jQtbSyROBxzSrga3V2RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7PCuXCFLzWv85mRN9A0CuQA5JSvNPS8Mi3lLPHcAUvJHer30mv6yFIkO2Gr7KLGFQgv5agHoGXI62JGBwqGgrf7PbXSPKlJ7rNWazb4W8tAnZn1a5fBrDUE5WdnfQAWIa0dqC/wQe/CFACHD7HgZwJRCVncddcjWDiei6f3FO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1thxUX-000000008HU-3Re4;
	Tue, 11 Feb 2025 16:08:25 -0500
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
	Rik van Riel <riel@surriel.com>,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: [PATCH v10 11/12] x86/mm: enable AMD translation cache extensions
Date: Tue, 11 Feb 2025 16:08:06 -0500
Message-ID: <20250211210823.242681-12-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211210823.242681-1-riel@surriel.com>
References: <20250211210823.242681-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

With AMD TCE (translation cache extensions) only the intermediate mappings
that cover the address range zapped by INVLPG / INVLPGB get invalidated,
rather than all intermediate mappings getting zapped at every TLB invalidation.

This can help reduce the TLB miss rate, by keeping more intermediate
mappings in the cache.

From the AMD manual:

Translation Cache Extension (TCE) Bit. Bit 15, read/write. Setting this bit
to 1 changes how the INVLPG, INVLPGB, and INVPCID instructions operate on
TLB entries. When this bit is 0, these instructions remove the target PTE
from the TLB as well as all upper-level table entries that are cached
in the TLB, whether or not they are associated with the target PTE.
When this bit is set, these instructions will remove the target PTE and
only those upper-level entries that lead to the target PTE in
the page table hierarchy, leaving unrelated upper-level entries intact.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/msr-index.h       | 2 ++
 arch/x86/kernel/cpu/amd.c              | 4 ++++
 tools/arch/x86/include/asm/msr-index.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..dc1c1057f26e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -25,6 +25,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_TCE		15 /* Enable Translation Cache Extensions */
 #define _EFER_AUTOIBRS		21 /* Enable Automatic IBRS */
 
 #define EFER_SCE		(1<<_EFER_SCE)
@@ -34,6 +35,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_TCE		(1<<_EFER_TCE)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
 /*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bcf73775b4f8..21076252a491 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1071,6 +1071,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	/* AMD CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
 	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
+
+	/* Enable Translation Cache Extension */
+	if (cpu_feature_enabled(X86_FEATURE_TCE))
+		msr_set_bit(MSR_EFER, _EFER_TCE);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..dc1c1057f26e 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -25,6 +25,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_TCE		15 /* Enable Translation Cache Extensions */
 #define _EFER_AUTOIBRS		21 /* Enable Automatic IBRS */
 
 #define EFER_SCE		(1<<_EFER_SCE)
@@ -34,6 +35,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_TCE		(1<<_EFER_TCE)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
 /*
-- 
2.47.1


