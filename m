Return-Path: <linux-kernel+bounces-246182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24D92BEA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838DE1F22BB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C383B19D893;
	Tue,  9 Jul 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="B0v0cL+h"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F319CD0C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539693; cv=none; b=aAFTWwWL6e3Qp0vT98yB7pC7PkdDE/Q/so/oxYAtK+lbuEAn6ED4m+aVFsr8//r8ayeNf7mFDVAbat3DGJeuwXd6qH47wITi62iw9hY8wohl+8/iDF1Scwdi5Do39EQooPwZLj2LyTKfGUS7fIQId2Y39TzsKePe76owqucEfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539693; c=relaxed/simple;
	bh=i6iI5igdpfgHFwkessxPLUb0pQclZbrgDsIDnR26y3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGyg6MsWpAaa6EfqvEf692Nbta5TTzZ8ogP3b5YSXRDN3npGDHmUkjxM89pOYJZpWCH7x43y0bgFKvZYWsv8BEpW6V/6twkKLE2hFe5Sq18vuJwss5M1aLzZlkZIH44h67ClQV406WFemEXSGKvwqDW9ySi4R7sUVZ92PUJPQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=B0v0cL+h; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 469FemH23543378
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 9 Jul 2024 08:41:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 469FemH23543378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720539662;
	bh=Y3T6o5mCEOAL/OthkgfETflzFrViYS0KVTQMPve51XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0v0cL+hvAQnD4zPUvLZ98YLKgNf1DZ8n2VRW+LfuqQRALzztYh+Jb8yfTZ90m9Wu
	 b9VGGcGLNUzxM4zRMt0S0WPBouDNxR0TEEvSEf8BNSGiEK3kAlimAwCYb8QzF0ub94
	 jJkLsQ8hubfHDNWeLrLF2pMyJ4MpOgIHzMRd2t2cZjnw+kr9w6/BEsCVj/rd7p0sKz
	 B/i0avsNezrE87vQ6X23k8sB3bog+9nbsqzamQ5UgK+UvgEqG0AM0XRxmnQEvgLc1K
	 U9+D97YeXzwOmW5l/S9t3vjOPatseA8+evQHDLcpeLJKoS8GB22ynUuFE9oYcg7dqV
	 szWetbbgjpbyA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: [PATCH v2 2/3] x86/fred: Split FRED RSP initialization into a separate function
Date: Tue,  9 Jul 2024 08:40:47 -0700
Message-ID: <20240709154048.3543361-3-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709154048.3543361-1-xin@zytor.com>
References: <20240709154048.3543361-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable FRED earlier, split FRED RSP initialization into a separate
function, as they are initialized with memory from CPU entry areas,
thus their initialization has to be kept after setup_cpu_entry_areas().

No functional change intended.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/fred.h  |  2 ++
 arch/x86/kernel/cpu/common.c |  6 ++++--
 arch/x86/kernel/fred.c       | 28 +++++++++++++++++++---------
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index e86c7ba32435..66d7dbe2d314 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -84,11 +84,13 @@ static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int
 }
 
 void cpu_init_fred_exceptions(void);
+void cpu_init_fred_rsps(void);
 void fred_complete_exception_setup(void);
 
 #else /* CONFIG_X86_FRED */
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
 static inline void cpu_init_fred_exceptions(void) { }
+static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
 static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
 #endif /* CONFIG_X86_FRED */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 10a5402d8297..6de12b3c1b04 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2195,10 +2195,12 @@ void cpu_init_exception_handling(void)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
 
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
 		cpu_init_fred_exceptions();
-	else
+		cpu_init_fred_rsps();
+	} else {
 		load_current_idt();
+	}
 }
 
 /*
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 4bcd8791ad96..99a134fcd5bf 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -32,6 +32,25 @@ void cpu_init_fred_exceptions(void)
 	       FRED_CONFIG_INT_STKLVL(0) |
 	       FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
 
+	wrmsrl(MSR_IA32_FRED_STKLVLS, 0);
+	wrmsrl(MSR_IA32_FRED_RSP0, 0);
+	wrmsrl(MSR_IA32_FRED_RSP1, 0);
+	wrmsrl(MSR_IA32_FRED_RSP2, 0);
+	wrmsrl(MSR_IA32_FRED_RSP3, 0);
+
+	/* Enable FRED */
+	cr4_set_bits(X86_CR4_FRED);
+	/* Any further IDT use is a bug */
+	idt_invalidate();
+
+	/* Use int $0x80 for 32-bit system calls in FRED mode */
+	setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
+	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
+}
+
+/* Must be called after setup_cpu_entry_areas() */
+void cpu_init_fred_rsps(void)
+{
 	/*
 	 * The purpose of separate stacks for NMI, #DB and #MC *in the kernel*
 	 * (remember that user space faults are always taken on stack level 0)
@@ -47,13 +66,4 @@ void cpu_init_fred_exceptions(void)
 	wrmsrl(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
 	wrmsrl(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
 	wrmsrl(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
-
-	/* Enable FRED */
-	cr4_set_bits(X86_CR4_FRED);
-	/* Any further IDT use is a bug */
-	idt_invalidate();
-
-	/* Use int $0x80 for 32-bit system calls in FRED mode */
-	setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
-	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
 }
-- 
2.45.2


