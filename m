Return-Path: <linux-kernel+bounces-414205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4B9D24B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C5281B80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F71C3021;
	Tue, 19 Nov 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0XqqpAo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562851BD4E1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015298; cv=none; b=EaN79L1md+CHhEx1+xizG22DJnCCjwDy09FA3gSLrpUg98giGawF0KyP5w/1BCxVajI6KcdoKKr2AtoUZRBxlDtwcXKDgFP9Q1GYFhzB9R/4dx1Pk6YnWgBLSZvBtwu7P1naH7VSCTRmkqHETS+cI4xLcjslVWaPO5vKHYSPD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015298; c=relaxed/simple;
	bh=tKrElLzYsByfd7u6hD7DHL+UGEr4m/wNjFwPu4J+DJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgvnjiZrRHmBmXjqRsiOuyD8CEKnRoPhHCODMv84MpVye/NLJJS1qvCSOsBMcPnvvsTtpRM3iBsbgowfeLr4g9q5d3EGtLCGWh6RfUfiphhEUZ48NfrF5b/2PkkQHXdse6G10oS2q/LBMbj1T4fIKtgKghMaANab2hnr41HY9mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0XqqpAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B222FC4CECF;
	Tue, 19 Nov 2024 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732015298;
	bh=tKrElLzYsByfd7u6hD7DHL+UGEr4m/wNjFwPu4J+DJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0XqqpAoHsPSs9Ni9AMe9srEq8xKq+7bF29sdls610AJW9hmnH97s8fU+zFTlUOPq
	 O+mYSIwWoMVJs+aAvxc/+s5b+SoFiYFqv98jsLAEMr0nPcwZ2rwSubIr8gc7cBSav3
	 +CGLhMownEqksqENWg8WNCN1mwWpLILOUsLGqNl65F1DllUWqApO8jqTs90msCwgGz
	 KDguR1tTb+/Yvei6U/AM+yJRw5tNvNifnTPjZVIvv42UPJ1Ecpr/h+h+jLg7+2k+wk
	 CpY2HtLH1x3PA1tdIxXAYHfeHv1tzRRilQe3sMGJ8VBi5Xrz9ta7TZMMlsRUqnFfVb
	 tQ3+CaIT/dE4A==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 1/2] x86/mm: Carve out INVLPG inline asm for use by others
Date: Tue, 19 Nov 2024 12:21:32 +0100
Message-ID: <20241119112133.20552-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZyulbYuvrkshfsd2@antipodes>
References: <ZyulbYuvrkshfsd2@antipodes>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/tlb.h | 4 ++++
 arch/x86/mm/tlb.c          | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 580636cdc257..4d3c9d00d6b6 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -34,4 +34,8 @@ static inline void __tlb_remove_table(void *table)
 	free_page_and_swap_cache(table);
 }
 
+static inline void invlpg(unsigned long addr)
+{
+	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+}
 #endif /* _ASM_X86_TLB_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 86593d1b787d..b0678d59ebdb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -20,6 +20,7 @@
 #include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/perf_event.h>
+#include <asm/tlb.h>
 
 #include "mm_internal.h"
 
@@ -1140,7 +1141,7 @@ STATIC_NOPV void native_flush_tlb_one_user(unsigned long addr)
 	bool cpu_pcide;
 
 	/* Flush 'addr' from the kernel PCID: */
-	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+	invlpg(addr);
 
 	/* If PTI is off there is no user PCID and nothing to flush. */
 	if (!static_cpu_has(X86_FEATURE_PTI))
-- 
2.43.0


