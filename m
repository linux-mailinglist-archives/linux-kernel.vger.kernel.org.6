Return-Path: <linux-kernel+bounces-246184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EB292BEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02ABD1C22022
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141719DF8B;
	Tue,  9 Jul 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TKKM5aCs"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3777119D8A4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539695; cv=none; b=hNXTdBi9WNZa6F53CPu3kiVh2I3zSqrLJK7F5lJ3JQq6/cD03wCe2sQrRzQpENGjUZZGkcvI+suqpNnDRh3ZudH2JiXlEt7+mep12swvuFmBcypdzdlp7Sw5NfTgMgVYRUbs20s5u47IepNmvZwPpdnjBqiEu3KggerKYYgvqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539695; c=relaxed/simple;
	bh=O8ek/YwTIjQFtI7v9g9Gq5ZPtEmuNrIJkMOoJPqId2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3rprksukCXY9jzURbcSlB1lkJEAwhvsHQ4dvXrZiimT/Pjdz9y1Xvhps3zwOfn8wz7MgpaLGJS8dRkweEu78yIGcyg84MdAaJ08ftze2pZRqxkvQtAeJ9GoGzF9t4G+Gr1msEjCaQyx2FLPh3XF2N32154zajfi0SZdAwuzqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=TKKM5aCs; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 469FemH33543378
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 9 Jul 2024 08:41:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 469FemH33543378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720539663;
	bh=qfun97Jg+BIQEJ3LYgyV2vxqbqRdLnKMxvQ2b7HT42I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKKM5aCs0rovstLABu+Hh7Y4R9pFBlfuWr7lfH4ZYBDA8YESDYVjdPXO89ne0bMP6
	 koyDpyIbjmDsYyHxOAJHJv886LbfK4QWcrnL7ezBSZ1QzbWrOxTlfd76mu1jzLvbsY
	 C/qUIhdxjPjIjZA+pLqsv9c+eAc04xWY5V2GN/J1gNDLuIvzlpZq6Kx5N/DQaXAqDi
	 sIGdlnBL5ZA5OF9d9slUqH6xqObxaMXsdyJCsnQlZj5YFEhwVqQcubn422zhWG9Osy
	 gUk5G0UF5+oGgMndoAXAKbJBR9k6rRG/r9GuUn2foMnN2qlC92nkd/EEoxawJU9+r9
	 gu3uUdHe21rGg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: [PATCH v2 3/3] x86/fred: Enable FRED right after init_mem_mapping()
Date: Tue,  9 Jul 2024 08:40:48 -0700
Message-ID: <20240709154048.3543361-4-xin@zytor.com>
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

Enable FRED right after init_mem_mapping() to avoid #PF handler,
exc_page_fault(), fetching its faulting address from the stack
before FRED is enabled.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/kernel/cpu/common.c |  6 +-----
 arch/x86/kernel/setup.c      | 11 ++++++++++-
 arch/x86/kernel/smpboot.c    |  6 ++++++
 arch/x86/kernel/traps.c      |  4 ++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6de12b3c1b04..42d4136ed6ac 100644
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
index 728927e4ba51..36403b901eb2 100644
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
@@ -1040,7 +1041,15 @@ void __init setup_arch(char **cmdline_p)
 
 	init_mem_mapping();
 
-	idt_setup_early_pf();
+	/*
+	 * init_mem_mapping() uses early IDT to setup memory mappings, thus FRED
+	 * can't be enabled earlier than that, unless FRED adds support to setup
+	 * memory mappings.
+	 */
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


