Return-Path: <linux-kernel+bounces-446758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44DC9F28CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4C27A1DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48634153565;
	Mon, 16 Dec 2024 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjuVY9PG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A832F852
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734319389; cv=none; b=Gx1BA/0Jc8nDACemZUvQ8athy9ttAfBKERCDagzuzm7y+tA+6pyq3+NdIQFKL5wwGZ/Y7oans1F0JmpRAhD0W0Lsj6pN30TvK1FQUKVV25/aoLgfWl/InddN2ZkYi6fm7aPzFoD9GjbI/CXv/kdNmEXQ1+UIBYPNqTCZxOECTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734319389; c=relaxed/simple;
	bh=V4jM3CVSCQm1TaO1otXw7852w/swq8OZFbl3RxkIYK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XYkSnS1wWGVJpmD/xLSyl0ET7nAU8dFd2VC/76mCts0Vq7bzqtMtkme2Msc3Nauu/RN3bj+l3q6EU2z0nvZ//jVU0Twgfy2cV4LfpvnxoOFD1OT3BkYJmzrQBmOh2urGHyA7uc3ZWTW6ybZY1J7v8uZncXjG/XJ/VVOJRD1cPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjuVY9PG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48104C4CED0;
	Mon, 16 Dec 2024 03:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734319389;
	bh=V4jM3CVSCQm1TaO1otXw7852w/swq8OZFbl3RxkIYK4=;
	h=From:To:Cc:Subject:Date:From;
	b=kjuVY9PGhDTtrEHi/eH9u8pArsgTdG3NHgqlKH9cBtPvf+LGHxw0mZ/wK/sHWxQPe
	 H/bZk4C+cC1a4BWJyFCpHnhMz1UM2ybo9yn4gjGYKCQ9phC+s875/LSrqSpGSXBK4n
	 jBa/ZZzVOwJoGT5ohcQNioboygexWAg2IfcPSt/rOn8xcUWSJtRZk+fcZG9lq7qBsn
	 vbVngoME1TjByjp6y9CxwGSd9ZOuiguO7DkSRllgLyk2ysrGVdODtjcsoJ+gDPJ4NL
	 oknWLJRF9DZMt+r7ne2xAcBaeh2uDzGFguujf80RXHPaXA6A6GGSu1gNS5ZhzuIdKx
	 0fsS87gW9evnw==
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
Subject: [PATCH] riscv: Implement smp_cond_load8/16() with Zawrs
Date: Sun, 15 Dec 2024 22:22:53 -0500
Message-Id: <20241216032253.685728-1-guoren@kernel.org>
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
---
 arch/riscv/include/asm/cmpxchg.h | 38 +++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 4cadc56220fe..2bd42a11ff8f 100644
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
+		__mask = 0xf << __s;
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
 	case 4:
 		asm volatile(
 		"	lr.w	%0, %1\n"
-- 
2.40.1


