Return-Path: <linux-kernel+bounces-565138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D8CA661AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412101784D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF988205AD2;
	Mon, 17 Mar 2025 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mcx0m63w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583A20551E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250654; cv=none; b=tgCDCiV4yNk9GJsjhx6ZVebEC9bpN3X2Hs41BS4OgYGe5jv1WCAJpkKh/CLXDArEHPs+Pogn/Dov/i28jz5SY5zWB71Mj0uT/CZcb2QAczIHj53uIIUmry11XDcw69hd+JtrLQEgSjQzLGWd5BjHIneO7fhkhF7LaGTm0N1kI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250654; c=relaxed/simple;
	bh=pqgXvmQEwCRm+NoMxc9rxEtfuUyeT4SNW94jBXjByHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAaYZVAFKSoElojYr1Jde06sWtHyxtjCmb3BZCstLolJ01tVi+B2foJEpj4uZN0B8/a6w8Wbx/D5gs0KQERgLTBBOGBnGNkFbYm7ysQ08KDIogOUfaMB/XtPvu5nhx5hBPHiJ0xNK/+VwieC0tJtJMEJZiUk6pXl6/iR990/mmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mcx0m63w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D38C4CEE9;
	Mon, 17 Mar 2025 22:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742250653;
	bh=pqgXvmQEwCRm+NoMxc9rxEtfuUyeT4SNW94jBXjByHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mcx0m63wFlyuNjuocYvnghKG1Ek/fwHThspcZW1mVfS96LsMc2T0EZmH0yYYiBAcC
	 81wpkeQoR+P8HQGIeb/nL4deB3kG5p3qosO6WbeTwcdF3Zt4Fg1MqB8rUQ1o3xElPV
	 5z9nKCB79g+KdnTjeVj4X/Qe8SStDasVBN+Sb7db5UXKI6QKv8D6qn/Z7qIpSPzTvS
	 LvjJ7D+0A4rH8TGzgMuP4RxkQwqYBgSg0kEXxjsDiL7X93aE02pRPVxA1j+p/baEWK
	 3nSxIDO9S5NIdYN0RiuD+EnvyZEhK4Ri2ccFRk4ad0eJKOsYa9DBfApS8KZ0n2+qHQ
	 Ld4JFJkVEZClQ==
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
Subject: [PATCH 2/5] x86/cpuid: Clean up <asm/cpuid/types.h>
Date: Mon, 17 Mar 2025 23:30:36 +0100
Message-ID: <20250317223039.3741082-3-mingo@kernel.org>
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

 - We have 0x0d, 0x9 and 0x1d as literals for the CPUID_LEAF definitions,
   pick a single, consistent style of 0xZZ literals.

 - Likewise, harmonize the style of the 'struct cpuid_regs' list of
   registers with that of 'enum cpuid_regs_idx'. Because while computers
   don't care about unnecessary visual noise, humans do.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/types.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 724002aaff4d..8582e27e836d 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -5,11 +5,14 @@
 #include <linux/types.h>
 
 /*
- * Types for raw CPUID access
+ * Types for raw CPUID access:
  */
 
 struct cpuid_regs {
-	u32 eax, ebx, ecx, edx;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
 };
 
 enum cpuid_regs_idx {
@@ -19,8 +22,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_LEAF_MWAIT	0x5
-#define CPUID_LEAF_DCA		0x9
+#define CPUID_LEAF_MWAIT	0x05
+#define CPUID_LEAF_DCA		0x09
 #define CPUID_LEAF_XSTATE	0x0d
 #define CPUID_LEAF_TSC		0x15
 #define CPUID_LEAF_FREQ		0x16
-- 
2.45.2


