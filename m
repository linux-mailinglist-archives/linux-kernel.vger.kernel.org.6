Return-Path: <linux-kernel+bounces-246181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9D92BEA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3061F22BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09A19D889;
	Tue,  9 Jul 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Tpg1ZNep"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3749818FC6E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539692; cv=none; b=uSc6AEPyNkFmXeyGgTnhentFbCP4vbwp2mZvOwKvld3SamlYu/HkaUVc7/dZLGhjZWb80z3raKYZ0UKwBpEHmM0WlAEkl4f7Iybca0zfObdFrXbDWaPv/q8VS7etJH7F74o2jO1/bUxG3YMeQNqazOkgg6BtkZZAquVBXDaQlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539692; c=relaxed/simple;
	bh=oQ5rHh/qVIUVk3bU5g69AR53OwoI0yLAz7n/fyMP8ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e36v2XQ+5KSzSphFOVKZRiP3fV/And9R5hFNoiadM+5MdHkSMiBAjp4uaAjNy5T1mUSem8qw3ncbcJY21fFqATocVYd7fls4F2hTRTTxb6VaKVN4H/yTd4mRswP1aOQoSOU81V//EIakRL8FGPVB4yZ96L5UEH63xUCZOo1dxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Tpg1ZNep; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 469FemH13543378
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 9 Jul 2024 08:41:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 469FemH13543378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720539661;
	bh=pR4B9H85x4ggNeQfQfQV1EF3QFKnnueIe5cRPRm/ZjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tpg1ZNepji5w0QuBNN367hst5fztm0wW2xQF0Cq63MI9t2DpK3HyDobP8i4/tdz2+
	 kyVpY5jcCKDp03r0ZgCgmW9GsJZ2zq91p34A9ks4V7LARVGgd65wsy+TQWWw6gXilF
	 H6zozDHq6/eTt4vnjlKgJBQhir66InfEv1GU0uNzedSaioJxW1OOGmTkcvHruMuBab
	 3dwkuwAubSGPtbORsxS+SIIydBpRno7wl7qpP/hDla6QI8YsdIhM7vSFbr355iFCEJ
	 evxxajpi51N6kNsIfycFxCezhEZNXoQQ9202p8vnVlr0oJllLnBXJf9rB97CyEvMRZ
	 R3OrvwKgaaNFQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: [PATCH v2 1/3] x86/fred: Parse cmdline param "fred=" in cpu_parse_early_param()
Date: Tue,  9 Jul 2024 08:40:46 -0700
Message-ID: <20240709154048.3543361-2-xin@zytor.com>
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

Depending on whether FRED will be used, sysvec_install() installs
a system interrupt handler into FRED system vector dispatch table
or IDT.  However FRED can be disabled later in trap_init(), after
sysvec_install() is called.  E.g., the HYPERVISOR_CALLBACK_VECTOR
handler is registered with sysvec_install() in kvm_guest_init(),
which is called in setup_arch() but way before trap_init().  IOW,
there is a gap between FRED is available and available but disabled.
As a result, when FRED is available but disabled, its IDT handler
is not installed thus spurious_interrupt() will be invoked.

Fix it by parsing cmdline param "fred=" in cpu_parse_early_param()
to minimize the gap between FRED is available and available but
disabled.

Fixes: 3810da12710a ("x86/fred: Add a fred= cmdline param")
Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Change since v1:
* Use strncmp() instead of strcmp().
---
 arch/x86/kernel/cpu/common.c |  5 +++++
 arch/x86/kernel/traps.c      | 26 --------------------------
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..10a5402d8297 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1510,6 +1510,11 @@ static void __init cpu_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
 		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
 
+	/* Minimize the gap between FRED is available and available but disabled. */
+	arglen = cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
+	if (arglen != 2 || strncmp(arg, "on", 2))
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+
 	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
 	if (arglen <= 0)
 		return;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17e5043..6afb41e6cbbb 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1402,34 +1402,8 @@ DEFINE_IDTENTRY_SW(iret_error)
 }
 #endif
 
-/* Do not enable FRED by default yet. */
-static bool enable_fred __ro_after_init = false;
-
-#ifdef CONFIG_X86_FRED
-static int __init fred_setup(char *str)
-{
-	if (!str)
-		return -EINVAL;
-
-	if (!cpu_feature_enabled(X86_FEATURE_FRED))
-		return 0;
-
-	if (!strcmp(str, "on"))
-		enable_fred = true;
-	else if (!strcmp(str, "off"))
-		enable_fred = false;
-	else
-		pr_warn("invalid FRED option: 'fred=%s'\n", str);
-	return 0;
-}
-early_param("fred", fred_setup);
-#endif
-
 void __init trap_init(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
-		setup_clear_cpu_cap(X86_FEATURE_FRED);
-
 	/* Init cpu_entry_area before IST entries are set up */
 	setup_cpu_entry_areas();
 
-- 
2.45.2


