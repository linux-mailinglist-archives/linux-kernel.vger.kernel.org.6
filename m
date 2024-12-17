Return-Path: <linux-kernel+bounces-448437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88BA9F4017
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805AD1886424
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670C67C6E6;
	Tue, 17 Dec 2024 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHE9vLU1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF454738
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734399565; cv=none; b=Zl+oNOGh/y0cwh/CyYTdwFsUyazBIE6k0evFzq8VZKItoEBeHgubYISYCOHCQZLMQyhQofENFwRNCHXtI8utBhwkw0Xp76O0Vknmx8VYLduFnH9PFMZZBVnwWazWveED8y648w7S6/UiEAbmErrY84Sr5YpSg71p23793Rdu5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734399565; c=relaxed/simple;
	bh=owtD71z+IWbnShFjd+nn0WbTtuvKmXnIospnD/Ddb3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6rx0auOnGxPEPyaAja9wIlbePtqlFwP/l6M4qvXkKpdaaqsMvi1BawTc4WIkPstGooznIyMqDfnhH4oTMRyNZH72Dm7tnrCYkb894J8nfpDDy/ubRSSLZZH3BO+/9YUXBWOEh6uESwcsIFBkggdoQYpLsc+F1p9TpPzXyBHg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHE9vLU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F776C4CED7;
	Tue, 17 Dec 2024 01:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734399565;
	bh=owtD71z+IWbnShFjd+nn0WbTtuvKmXnIospnD/Ddb3k=;
	h=From:To:Cc:Subject:Date:From;
	b=lHE9vLU1SALL4Wjd473bayDvWzGcr8PYXDKRN9tSbtc/3FkzlJu395WJig3IQ1OQ9
	 2aixo5mXa2I7YwDQTtqP59SeC9FPB7GjotBwHLWR66v3Os+OqJe9+PxqySUwRNuaYY
	 dtuihK1hU62fAYs4edoj5uIY6y1JolnQr0JkRz9mKr04oKvpOEJzEhlVKuyZVNhICz
	 ShOlsR3ZGZQ/zCntcYQMlCdTRxewetFapCpV6AY70kbEkA/23RKagR58T5PjHI9VW7
	 fouLApl/6n++qdpQbcTRxR4mClnnKJ0VEJWPy7FH3ojejtC9EVCJSBrkHNmLoUFGTw
	 +mmSB/bcaxp4A==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	guoren@kernel.org,
	bjorn@rivosinc.com,
	conor@kernel.org,
	leobras@redhat.com,
	alexghiti@rivosinc.com,
	christoph.muellner@vrull.eu
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	ericchancf@google.com,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2] riscv: Implement smp_cond_load8/16() with Zawrs
Date: Mon, 16 Dec 2024 20:39:10 -0500
Message-Id: <20241217013910.1039923-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

RISC-V code uses the queued spinlock implementation, which calls
the macros smp_cond_load_acquire for one byte. So, complement the
implementation of byte and halfword versions.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Andrew Jones <ajones@ventanamicro.com>
---
Changes in V2:
 - Fixup mask typo (0xf -> 0xff, 0xff -> 0xffff) by Andrew.
---
 arch/riscv/include/asm/cmpxchg.h | 38 +++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 4cadc56220fe..aa4410beb065 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -365,16 +365,48 @@ static __always_inline void __cmpwait(volatile void *ptr,
 {
 	unsigned long tmp;
 
+	u32 *__ptr32b;
+	ulong __s, __val, __mask;
+
 	asm goto(ALTERNATIVE("j %l[no_zawrs]", "nop",
 			     0, RISCV_ISA_EXT_ZAWRS, 1)
 		 : : : : no_zawrs);
 
 	switch (size) {
 	case 1:
-		fallthrough;
+		__ptr32b = (u32 *)((ulong)(ptr) & ~0x3);
+		__s = ((ulong)(ptr) & 0x3) * BITS_PER_BYTE;
+		__val = val << __s;
+		__mask = 0xff << __s;
+
+		asm volatile(
+		"	lr.w	%0, %1\n"
+		"	and	%0, %0, %3\n"
+		"	xor	%0, %0, %2\n"
+		"	bnez	%0, 1f\n"
+			ZAWRS_WRS_NTO "\n"
+		"1:"
+		: "=&r" (tmp), "+A" (*(__ptr32b))
+		: "r" (__val), "r" (__mask)
+		: "memory");
+		break;
 	case 2:
-		/* RISC-V doesn't have lr instructions on byte and half-word. */
-		goto no_zawrs;
+		__ptr32b = (u32 *)((ulong)(ptr) & ~0x3);
+		__s = ((ulong)(ptr) & 0x2) * BITS_PER_BYTE;
+		__val = val << __s;
+		__mask = 0xffff << __s;
+
+		asm volatile(
+		"	lr.w	%0, %1\n"
+		"	and	%0, %0, %3\n"
+		"	xor	%0, %0, %2\n"
+		"	bnez	%0, 1f\n"
+			ZAWRS_WRS_NTO "\n"
+		"1:"
+		: "=&r" (tmp), "+A" (*(__ptr32b))
+		: "r" (__val), "r" (__mask)
+		: "memory");
+		break;
 	case 4:
 		asm volatile(
 		"	lr.w	%0, %1\n"
-- 
2.40.1


