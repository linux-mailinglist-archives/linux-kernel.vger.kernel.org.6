Return-Path: <linux-kernel+bounces-443185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C839EE883
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7E1282F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A5215041;
	Thu, 12 Dec 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="kBfQoS1G"
Received: from 7.mo584.mail-out.ovh.net (7.mo584.mail-out.ovh.net [178.33.253.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BA211A0E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.253.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012751; cv=none; b=eGfeZmReA40M1XlQVP5vtcC3s5arLTPORnUlKORIVcV0a2tz35X/t52ISIN7JudSOAmfdRv80EbCoZzITxrMoJE9KjtDdCx2s1XJbMXqzQpdoVOFr6njAW14U+GXOQTj8eR6y+b3RT1K/Xc0XwgxSpx6i5sOoybf4dPVjd86s0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012751; c=relaxed/simple;
	bh=LKNUFFZfKSKOHNSpdPcuOO5Dy/4I5beAwCC4Zvt7BUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HH95fErpMRWX4hwPP64HKgq1cuFmWnGqAAcdqefB1LIVr2/BGBgQXEkaV9eH+/3D2qPHAKzzVn8cY28xGfSRGgIMg2adb8cUEWCLK44NLj0WTqTjK9vSIDImxrYcmBzcg19+BwmCPo8Mz+GvGBRgPZl0Pe0pW/z0NXXOdFm4yfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=kBfQoS1G; arc=none smtp.client-ip=178.33.253.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.2.21])
	by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4Y8D4P5K6dz1VxB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:33 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-55ssz (unknown [10.110.164.228])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1C34F1FEAE;
	Thu, 12 Dec 2024 13:35:33 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.97])
	by ghost-submission-5b5ff79f4f-55ssz with ESMTPSA
	id ibp9OKTmWmcwAgAA4pvnYw
	(envelope-from <sergii.dmytruk@3mdeb.com>); Thu, 12 Dec 2024 13:35:33 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-97G002d8dfedd3-b9b0-4d74-80c7-c1db180e7dc3,
                    B639BF7A6EC39DD0505FDBB1524E94DB3A46F08D) smtp.auth=sergii.dmytruk@3mdeb.com
X-OVh-ClientIp:176.111.183.174
From: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
To: linux-kernel@vger.kernel.org
Cc: trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 6/9] x86: Prepare CPUs for post SKINIT launch
Date: Thu, 12 Dec 2024 15:35:04 +0200
Message-ID: <c855fab58cfee5fb994a5b24b279430a58cecf02.1734008878.git.sergii.dmytruk@3mdeb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
References: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16619690000474158236
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgvrhhgihhiucffmhihthhruhhkuceoshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpefhheefheduieelieekfffgfffgfedutdevleevvdfhfffgledvgfdtuddtheefieenucfkphepuddvjedrtddrtddruddpudejiedrudduuddrudekfedrudejgedpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvghrghhiihdrughmhihtrhhukhesfehmuggvsgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekgegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=izgwlQ46nNmMsHssEh28+oXsbfGiczF61EsDbUUYuQs=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734010533; v=1;
 b=kBfQoS1G9xQJ0upDtw6MEgncKqFru1S4Tykr2bwjoB3hYVeZXWwFYGeyG7CJQpR6nPdMuUJw
 g0EPDwQb6EhBVUmvh3HV1nqDVEO+JIEfTQ2rpkfCL1Z0Lzw9Drc2Lvxya4DNUJD+n+7RAc06t/q
 iAL1Qe3PA0FqncYQhWLtL6DPwHd/wud8pbVUZKssMKtsoC4JV04YwXB1PtMNtNMBRPLIWW1ehZk
 hW5Y3OrEwvbphG002pOJmF3kC2uO9MDRtdU5GxE6IoG8NDDKeWFlpVI7ewuRDCIEjA/IJDvUbDQ
 0O2Hwdmmxhxd2llVs7UDRV+u+cZ8LyXy2yAhVEQRNcbxg==

From: Ross Philipson <ross.philipson@oracle.com>

The SKINIT instruction disables the GIF and it must be re-enabled
on the BSP and APs as they are started. Since enabling GIF also
re-enables NMIs, it should be done after a valid IDT is loaded for
each CPU.

SKINIT also already performed #INIT on the APs and it should be
bypassed before issuing the startup IPIs.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
---
 arch/x86/kernel/slaunch.c | 23 +++++++++++++++++++++++
 arch/x86/kernel/smpboot.c | 15 ++++++++++++++-
 arch/x86/kernel/traps.c   |  4 ++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index ff05f032e44f..3a6e4d22b54d 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -17,6 +17,7 @@
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/e820/api.h>
+#include <asm/svm.h>
 #include <asm/setup.h>
 #include <asm/svm.h>
 #include <asm/realmode.h>
@@ -716,3 +717,25 @@ void slaunch_finalize(int do_sexit)
 	else if (boot_cpu_has(X86_FEATURE_SKINIT))
 		slaunch_finalize_skinit();
 }
+
+/*
+ * AMD specific SKINIT CPU setup and initialization.
+ */
+void slaunch_cpu_setup_skinit(void)
+{
+	u64 val;
+
+	if (!slaunch_is_skinit_launch())
+		return;
+
+	/*
+	 * We don't yet handle #SX. Disable INIT_REDIRECTION first, before
+	 * enabling GIF, so a pending INIT resets us, rather than causing a
+	 * panic due to an unknown exception.
+	 */
+	rdmsrl(MSR_VM_CR, val);
+	wrmsrl(MSR_VM_CR, val & ~(1 << SVM_VM_CR_INIT_REDIRECTION));
+
+	/* Enable Global Interrupts flag */
+	asm volatile ("stgi" ::: "memory");
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0c915e105a9b..a0e5971725d9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -249,6 +249,12 @@ static void notrace start_secondary(void *unused)
 
 	cpu_init_exception_handling();
 
+	/*
+	 * If this is an AMD SKINIT secure launch, some extra work is done
+	 * to prepare to start the secondary CPUs.
+	 */
+	slaunch_cpu_setup_skinit();
+
 	/*
 	 * Load the microcode before reaching the AP alive synchronization
 	 * point below so it is not part of the full per CPU serialized
@@ -735,7 +741,14 @@ static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_ei
 
 	preempt_disable();
 	maxlvt = lapic_get_maxlvt();
-	send_init_sequence(phys_apicid);
+
+	/*
+	 * If this is an SKINIT secure launch, #INIT is already done on the APs
+	 * by issuing the SKINIT instruction. For security reasons #INIT
+	 * should not be done again.
+	 */
+	if (!slaunch_is_skinit_launch())
+		send_init_sequence(phys_apicid);
 
 	mb();
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17e5043..1603b2e6faa5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -42,6 +42,7 @@
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
 #include <linux/iommu.h>
+#include <linux/slaunch.h>
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -1443,5 +1444,8 @@ void __init trap_init(void)
 	if (!cpu_feature_enabled(X86_FEATURE_FRED))
 		idt_setup_traps();
 
+	/* If SKINIT was done on the BSP, this is the spot to enable GIF */
+	slaunch_cpu_setup_skinit();
+
 	cpu_init();
 }
-- 
2.47.1


