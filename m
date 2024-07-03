Return-Path: <linux-kernel+bounces-239085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852CD9255F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062701F24106
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082013D523;
	Wed,  3 Jul 2024 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RtTNXEpB"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD213B5A1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996913; cv=none; b=uhR7a6HrfpQdajI+Fn2C7ZZvLToJNMiSYx9wwWiJsUudfgBTEAgL1HVVAYzYEEKFKO4cK1OmDuAwtsSwY7HdvJ+LugMJ7fOIUiD6818Fnd17pfTL98XSkDpBe5DxW0D2aNqIkyhpguggzwe4tKHMm9w+kn2+oMQ9bgA+vJyFzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996913; c=relaxed/simple;
	bh=kdikNib9x+eTgS5GaTuz0ap4G90ilWCwk8wef1VJOOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/fjJ0QgKexqk1p1HqiYALIHMMcaH/crzC9wD6wugOY3a++Wlzg7ynAS7q8Hn+QVPHLY2bGrEigPl9nTP8M500gM71nAprFN/T7k6is22gtqGfE1140yMBlYb13KznlOU7pjIwkmfq23FUHOfSHep0guD3VlRZ07si/jqykjlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=RtTNXEpB; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4638sQ1A274819
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 3 Jul 2024 01:54:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4638sQ1A274819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719996874;
	bh=Ko+FE7nG9WBnR7O9m6WOO/3Vh122gx7NsoMXFF+ciuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtTNXEpBkHFfKjaLaqu7V8zjxdM8U+AwvSJ12KTjjGK2DSCiYsKg/IiiGGfz2/hNf
	 b4IUHgoRAMu65YQBkKdRjn7oOtgeO35pb9NuZ/XQCVbzJ+61YNi9rRl4G4Vi8b2mcc
	 f3e6x2k0b/paIvlnlqbYbqhNVwdvWYnHXF2EGMq3yIxSk5/Deb/bKi1n3UCjjLNzQe
	 Nnv/rzo9vGe8tVIArLjN+ns5B03Y/O00vMYzGHuaWrX7rEVyd9cQR7ljcnk0u6kGJO
	 +NgTpmQuGW1sr9fyhrcN2ME8Q88HRs2nZroddv9GN6nsDifKnRDsXFYKVZ/n/eed3J
	 gaOGn0svYavYA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: [PATCH v1 4/4] x86/fred: Enable FRED right after init_mem_mapping()
Date: Wed,  3 Jul 2024 01:54:26 -0700
Message-ID: <20240703085426.274801-5-xin@zytor.com>
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

Enable FRED right after init_mem_mapping() to avoid #PF handler,
exc_page_fault(), fetching its faulting address from the stack
before FRED is enabled.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/kernel/cpu/common.c | 6 +-----
 arch/x86/kernel/setup.c      | 7 ++++++-
 arch/x86/kernel/smpboot.c    | 6 ++++++
 arch/x86/kernel/traps.c      | 4 ++++
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 022ae4ba7997..8d454b6f7def 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2195,12 +2195,8 @@ void cpu_init_exception_handling(void)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
 
-	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
-		cpu_init_fred_exceptions();
-		cpu_init_fred_rsps();
-	} else {
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
 		load_current_idt();
-	}
 }
 
 /*
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 728927e4ba51..d866136a89ff 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -39,6 +39,7 @@
 #include <asm/coco.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
+#include <asm/fred.h>
 #include <asm/gart.h>
 #include <asm/hypervisor.h>
 #include <asm/io_apic.h>
@@ -1040,7 +1041,11 @@ void __init setup_arch(char **cmdline_p)
 
 	init_mem_mapping();
 
-	idt_setup_early_pf();
+	/* Switch to FRED from early IDT ASAP */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		cpu_init_fred_exceptions();
+	else
+		idt_setup_early_pf();
 
 	/*
 	 * Update mmu_cr4_features (and, indirectly, trampoline_cr4_features)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0c35207320cb..0d83377f9dcd 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -64,6 +64,7 @@
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
 #include <asm/desc.h>
+#include <asm/fred.h>
 #include <asm/nmi.h>
 #include <asm/irq.h>
 #include <asm/realmode.h>
@@ -248,6 +249,11 @@ static void notrace start_secondary(void *unused)
 
 	cpu_init_exception_handling();
 
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		cpu_init_fred_exceptions();
+		cpu_init_fred_rsps();
+	}
+
 	/*
 	 * Load the microcode before reaching the AP alive synchronization
 	 * point below so it is not part of the full per CPU serialized
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6afb41e6cbbb..81648bd07576 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1407,6 +1407,10 @@ void __init trap_init(void)
 	/* Init cpu_entry_area before IST entries are set up */
 	setup_cpu_entry_areas();
 
+	/* FRED RSPs pointing to memory from CPU entry areas */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		cpu_init_fred_rsps();
+
 	/* Init GHCB memory pages when running as an SEV-ES guest */
 	sev_es_init_vc_handling();
 
-- 
2.45.2


