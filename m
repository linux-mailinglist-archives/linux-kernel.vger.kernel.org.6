Return-Path: <linux-kernel+bounces-565140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8B0A661AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1123B701A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681192063EB;
	Mon, 17 Mar 2025 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaybL5dF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEAF2063E7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250660; cv=none; b=ufif9OHdDUayTm6zA9j+lTkCP87p6Rd606J8YcKlmKwxhPtAk62iR/89tnuqdFmfFs/gx9SBtTUOcAFGVSA06hvAzULumI8BD1bTJ5lUxN9APS79ddccMlWrlzmdcsek9T0XRVmV3zZx1rrV+8j+MuIwZsSLM3JSYhJOOLuZTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250660; c=relaxed/simple;
	bh=bqvVUagYkYFiGO2Hv9VCfYL4nMH2z5rutC4NBzLIUY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2P+kicoFQ5aYIVqNJLgr4Q6rH7C1i2ESSPD4rd7MaTYUXv084FyZre+ajyqWFjArRSCDnwC4eTGdTheQqA94KFXv2Q7SHtfTrbmRVxEkIBllrSloRasBeYx3iehdehWKqI6Y+njlxdB5+hV6oLHB8oChMVQ6KycldPaGIifLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaybL5dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79798C4CEE9;
	Mon, 17 Mar 2025 22:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742250660;
	bh=bqvVUagYkYFiGO2Hv9VCfYL4nMH2z5rutC4NBzLIUY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XaybL5dFMoMPWwz0KBpZR+QpHUawzR0NR+lplQcDVaW0Qmgf2LcyGu6mmmDmlzsQT
	 gUWMcSq962b6OMGIX3RTYUkJTxAeCaKepS2+4ocwHrVsXqUjWnA66UjHurcy3X2zY1
	 JaC8gnn5lQBk4Gvo1AOaN5OlQVhDahaMMB4zp5/c+W5OZZW+mR4LZH3goBHSkqZKis
	 TI8+ls9B28ukfVaVYGMqM0CTFl5BFXR2LsnbddouEJdseg33qJHn8TlW9urf0MUTOW
	 LA1GtA5uyetfEnPei5F2a1KLsJUSr84bdECSyBCF9f9nUy/nIcU/k0COeU7yiq0HX7
	 RnU1C3miDNOsA==
From: mingo@kernel.org
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/5] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
Date: Mon, 17 Mar 2025 23:30:38 +0100
Message-ID: <20250317223039.3741082-5-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317223039.3741082-1-mingo@kernel.org>
References: <20250317223039.3741082-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ingo Molnar <mingo@kernel.org>

Convert all uses of 'unsigned int' to 'u32' in <asm/cpuid/api.h>.

This is how a lot of the call sites are doing it, and the two
types are equivalent in the C sense - but 'u32' better expresses
that these are expressions of an immutable hardware ABI.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/api.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index f26926ba5289..356db1894588 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -22,8 +22,8 @@ static inline bool have_cpuid_p(void)
 }
 #endif
 
-static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
-				unsigned int *ecx, unsigned int *edx)
+static inline void native_cpuid(u32 *eax, u32 *ebx,
+				u32 *ecx, u32 *edx)
 {
 	/* ecx is often an input as well as an output. */
 	asm volatile("cpuid"
@@ -36,9 +36,9 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 }
 
 #define NATIVE_CPUID_REG(reg)					\
-static inline unsigned int native_cpuid_##reg(unsigned int op)	\
+static inline u32 native_cpuid_##reg(u32 op)	\
 {								\
-	unsigned int eax = op, ebx, ecx = 0, edx;		\
+	u32 eax = op, ebx, ecx = 0, edx;		\
 								\
 	native_cpuid(&eax, &ebx, &ecx, &edx);			\
 								\
@@ -65,9 +65,9 @@ NATIVE_CPUID_REG(edx)
  * Clear ECX since some CPUs (Cyrix MII) do not set or clear ECX
  * resulting in stale register contents being returned.
  */
-static inline void cpuid(unsigned int op,
-			 unsigned int *eax, unsigned int *ebx,
-			 unsigned int *ecx, unsigned int *edx)
+static inline void cpuid(u32 op,
+			 u32 *eax, u32 *ebx,
+			 u32 *ecx, u32 *edx)
 {
 	*eax = op;
 	*ecx = 0;
@@ -75,9 +75,9 @@ static inline void cpuid(unsigned int op,
 }
 
 /* Some CPUID calls want 'count' to be placed in ECX */
-static inline void cpuid_count(unsigned int op, int count,
-			       unsigned int *eax, unsigned int *ebx,
-			       unsigned int *ecx, unsigned int *edx)
+static inline void cpuid_count(u32 op, int count,
+			       u32 *eax, u32 *ebx,
+			       u32 *ecx, u32 *edx)
 {
 	*eax = op;
 	*ecx = count;
@@ -88,43 +88,43 @@ static inline void cpuid_count(unsigned int op, int count,
  * CPUID functions returning a single datum:
  */
 
-static inline unsigned int cpuid_eax(unsigned int op)
+static inline u32 cpuid_eax(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return eax;
 }
 
-static inline unsigned int cpuid_ebx(unsigned int op)
+static inline u32 cpuid_ebx(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return ebx;
 }
 
-static inline unsigned int cpuid_ecx(unsigned int op)
+static inline u32 cpuid_ecx(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return ecx;
 }
 
-static inline unsigned int cpuid_edx(unsigned int op)
+static inline u32 cpuid_edx(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return edx;
 }
 
-static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
+static inline void __cpuid_read(u32 leaf, u32 subleaf, u32 *regs)
 {
 	regs[CPUID_EAX] = leaf;
 	regs[CPUID_ECX] = subleaf;
@@ -141,7 +141,7 @@ static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *re
 	__cpuid_read(leaf, 0, (u32 *)(regs));		\
 }
 
-static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
+static inline void __cpuid_read_reg(u32 leaf, u32 subleaf,
 				    enum cpuid_regs_idx regidx, u32 *reg)
 {
 	u32 regs[4];
-- 
2.45.2


