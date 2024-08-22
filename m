Return-Path: <linux-kernel+bounces-296820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40695AF79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABE31C22247
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7822175D45;
	Thu, 22 Aug 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ccHnrX5z"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA801531DD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312411; cv=none; b=QSrwQbiMYRmVr0Ir8DZqNqax44K/wo1zTQy/gRoOl5fTWB3z7zyvhv1BFS4SHFjlzM227aSudCO5iEuYiEGj7Ztb0qxRHIwvjEV+6n6hTi6c4ydsuOY3V+QJfG5hsDShTRrfTTnUe4sv6EMDHPX8Z7tGQc7UT9OqoOA6NrZejrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312411; c=relaxed/simple;
	bh=qv5IMD9jfZqw9E3gyg3gYpHIvZkme5FZDalGfFBfbzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHqjeq17GYhDaEm/DZ1j27ZJeU+2+zDGn6iAthmKpcUVtYbOye3gQ6CY6D3If4g+1Rx3j80dKDE2BikxbNZbHLa9BXUR6ScaUbyZVDwt1BX0+a2CRofzgTyYIl1JTezd4sT3pGthiB+UOheCDoFIqOdt5mv8Gy6xcHTJpc983zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ccHnrX5z; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47M7d7s72176365
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 22 Aug 2024 00:39:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47M7d7s72176365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1724312353;
	bh=W8Bu9+mIy9ZYM1EaY/aDq6EBee6SbMv0QtR5ansMrtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccHnrX5zofHcDdfZ48vt/FBiftC+RiHYP7j0SdSoU01sqwQYWDBfDUp8uqMWHRl4p
	 Q0N3NPEwZ4WAulr6gww0vwjDuupSfdc7bS+sdMjsFOFkYy8tB71YGkx6aB1h3P9va6
	 3oO1CBkFBH54o/SOsfj5AyhwI/PBEsrnhuuxfbKXwCUDiCOcG7wef2NdTQ9ehltjU1
	 3XrjZqDvkuXqVSCPnTBgZ8y/vDYL2N7xjN38U/UH25c5pzTf+yXVQ68R5GrH7VT7gS
	 o8WoxIm7nVJKTACJ0MJHAj9NWhr0m4+sDdBzjgQfTHnblEOb5LuYpcJleoRNu5wf5a
	 UvD3LzihLesPA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com, seanjc@google.com
Subject: [PATCH v2 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the alternatives mechanism
Date: Thu, 22 Aug 2024 00:39:05 -0700
Message-ID: <20240822073906.2176342-3-xin@zytor.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822073906.2176342-1-xin@zytor.com>
References: <20240822073906.2176342-1-xin@zytor.com>
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

Remove the dependency on X86_FEATURE_WRMSRNS as WRMSRNS is no longer
dependent on FRED.

[1] https://lore.kernel.org/lkml/15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com/

Note, keep as DS prefix unless we get information to the contrary.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Changes since v1:
* Remove the dependency on X86_FEATURE_WRMSRNS. (Thomas Gleixner)
---
 arch/x86/include/asm/msr.h       | 25 +++++++++++--------------
 arch/x86/include/asm/switch_to.h |  1 -
 arch/x86/kernel/cpu/cpuid-deps.c |  1 -
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index d642037f9ed5..001853541f1e 100644
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
@@ -312,9 +299,19 @@ do {							\
 
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
+	asm volatile("1: " ALTERNATIVE("ds wrmsr", WRMSRNS, X86_FEATURE_WRMSRNS)
+		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
+		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)));
 }
 
 /*
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index c3bd0c0758c9..e9ded149a9e3 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -71,7 +71,6 @@ static inline void update_task_stack(struct task_struct *task)
 	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
 	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
-		/* WRMSRNS is a baseline feature for FRED. */
 		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);
 	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		/* Xen PV enters the kernel on the thread stack. */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b7d9f530ae16..8bd84114c2d9 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -83,7 +83,6 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
-	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
 	{}
 };
 
-- 
2.46.0


