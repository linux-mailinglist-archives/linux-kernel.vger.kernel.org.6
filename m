Return-Path: <linux-kernel+bounces-277337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1227E949F6A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CDB1C20AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7455198A21;
	Wed,  7 Aug 2024 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VrQkO1Kb"
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5769C1917D1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009842; cv=none; b=mjUXeOi3bWm9Sb35pBOmvsrNmkrNHKoqbt7kXKD3f/3R386uNUi9gkKqhdzGqQ6zhl+Z26F/qGDDyJGP2er9Fagj8l7A1anGuTLQoKgFJf5VlKcWerOyAXZQJO2bsAh1Qu/UB1kN3NjxR2gtrBl+LVhnZeKjmmPPkrVqsoW9usA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009842; c=relaxed/simple;
	bh=lD9I8tRZPS0k7uL2HJKU9ym34dZ+T+CgRY2H+dTSx24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U83ViKdvFFzu+Pw0iTRr+CLIjWjCL3mba6cmTjSLhkY38jwd3PhZwSyNZOwHDs+QenrBYHWpvcSOyOOCw+fOwuqwcrGPgeUUojvKy9ysl4lS5RpCzZjFdVOAr9BZEagETC5tT/DlxfBkFIyHkVqC7X3phqV45XTcDzymNYkcib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=VrQkO1Kb; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4775lNio682395
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 6 Aug 2024 22:47:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4775lNio682395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723009648;
	bh=BP04zkUdKGpcBnf3pCpXskdtXCY1mJ3F+84Z6xYrrYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VrQkO1KbaUXMGzxyKneXHTFlKhN489h9P4yr3jDgiGNqVVJYwN5zdZqrSKZRXMQz2
	 kLxQBSxzVYwQxpW/hK+BwiGZOsHrZFfZxe2WV9TyHV2dsLLj6vIj6uDZRnOCOIhf0O
	 e2ktzuKmC4IzeWnZj48Pbn6STKosFS709ERDHVPZfGBKeIw038+nMYzAAC/eSrqHoI
	 NKm8TmcIY0JCrSS3eY972sBa4IDPJz4yX/nQz2IHusoa9bFAY/tLmOiNwCfA7az/vn
	 tgbSoAVM9kpoGEwOLdKUvW8TTsF2qKp/XCLaO/jVp4kKwSMM0J8LRXBtCigw9Z7yF4
	 b5xZMqA/Ha5Vw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com, seanjc@google.com
Subject: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the alternatives mechanism
Date: Tue,  6 Aug 2024 22:47:21 -0700
Message-ID: <20240807054722.682375-3-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807054722.682375-1-xin@zytor.com>
References: <20240807054722.682375-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Cooper <andrew.cooper3@citrix.com>

Per the discussion about FRED MSR writes with WRMSRNS instruction [1],
use the alternatives mechanism to choose WRMSRNS when it's available,
otherwise fallback to WRMSR.

[1] https://lore.kernel.org/lkml/15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com/

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/msr.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index d642037f9ed5..3e402d717815 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -99,19 +99,6 @@ static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
-/*
- * WRMSRNS behaves exactly like WRMSR with the only difference being
- * that it is not a serializing instruction by default.
- */
-static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
-{
-	/* Instruction opcode for WRMSRNS; supported in binutils >= 2.40. */
-	asm volatile("1: .byte 0x0f,0x01,0xc6\n"
-		     "2:\n"
-		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
-		     : : "c" (msr), "a"(low), "d" (high));
-}
-
 #define native_rdmsr(msr, val1, val2)			\
 do {							\
 	u64 __val = __rdmsr((msr));			\
@@ -312,9 +299,22 @@ do {							\
 
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
+/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
+#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
+
+/* Non-serializing WRMSR, when available.  Falls back to a serializing WRMSR. */
 static __always_inline void wrmsrns(u32 msr, u64 val)
 {
-	__wrmsrns(msr, val, val >> 32);
+	/*
+	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
+	 * DS prefix to avoid a trailing NOP.
+	 */
+	asm volatile("1: "
+		     ALTERNATIVE("ds wrmsr",
+				 WRMSRNS, X86_FEATURE_WRMSRNS)
+		     "2:\n"
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
+		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)));
 }
 
 /*
-- 
2.45.2


