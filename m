Return-Path: <linux-kernel+bounces-239086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D129255FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF691F22D6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E6013D602;
	Wed,  3 Jul 2024 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fjru07oX"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42B313BAE5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996913; cv=none; b=oloiH601OMeHhKo+udV2fq2oWWe3PEdUiPxC0XJinXg/E878aLxh7plWU8sNkTD89LaHPRs5iShxsKxh4xY+m8LoCHLuVXhxsc0DmvKbs7coll8YZaseJBCtjwhLheeJ1V6kQLMHDdTIh0NgJXKYC4rlQdDWN2iG6THmlhbImps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996913; c=relaxed/simple;
	bh=qWdd/U5P843zZgQZi8pLesLG9Ojih5CBGvIIxi8Vhjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=da5m4VVhS5xMVw2gdwZOQKlG3NNRakknEh81C5xhVcVKWvnBqQZtTVXl6clm14shXKbo5jH5CuhmhxnobMktv2tETOZx3YGN0mQxqC2Dk521NbjZrvsDT0dM+a0jqqhfvT8nLE1UJ4lC7LgQuoOqVVXFLlMg/5eGBj/C7kJX+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=fjru07oX; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4638sQ19274819
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 3 Jul 2024 01:54:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4638sQ19274819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719996874;
	bh=ioOo8doTD6S3vVDLWeOjIsJkTYwDmB9mJWFS1Qkccb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjru07oXkjTbBgMZ/4zzzBEtGbyCK7dRi9pKBpayaskwjRWeSJK6ujK9hPPq414E5
	 UzeUmE3DT2YRX1fUDHpSAfqOY7cfRKFlM8k4+iLvF2Vdta627cg9n8Ikz2ZNvG6SpV
	 V3PLlya2xZknZ0W2wkxwiosQ38XiakKvv/Sroct48UvkaEb5nsEEpP4cCgJXmDxJuF
	 FxMTXf1WXPUnKlS+uSvdaa2ZYV2Xn8HYHm1IwYQudMVTsFGcV520eAHv5bypcD0et2
	 E/pw2UrCx6wGS5LDf87KAXrhv0p89lrffJBadZG9AyO/j7nBWvxM82ebS5FirAhNQ/
	 Ap+KPueGqXL+A==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: [PATCH v1 3/4] x86/fred: Split FRED RSP initialization into a separate function
Date: Wed,  3 Jul 2024 01:54:25 -0700
Message-ID: <20240703085426.274801-4-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703085426.274801-1-xin@zytor.com>
References: <20240703085426.274801-1-xin@zytor.com>
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
index 9a904fe7c829..022ae4ba7997 100644
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
index b202685b8e77..1788f28754f3 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -32,6 +32,25 @@ void cpu_init_fred_exceptions(void)
 		FRED_CONFIG_INT_STKLVL(0) |
 		FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
 
+	wrmsrns(MSR_IA32_FRED_STKLVLS, 0);
+	wrmsrns(MSR_IA32_FRED_RSP0, 0);
+	wrmsrns(MSR_IA32_FRED_RSP1, 0);
+	wrmsrns(MSR_IA32_FRED_RSP2, 0);
+	wrmsrns(MSR_IA32_FRED_RSP3, 0);
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
 	wrmsrns(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
 	wrmsrns(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
 	wrmsrns(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
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


