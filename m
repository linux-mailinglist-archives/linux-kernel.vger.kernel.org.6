Return-Path: <linux-kernel+bounces-239083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509A9255F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED73B257A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F5C13BC0E;
	Wed,  3 Jul 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YT7KmYad"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898C13B584
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996911; cv=none; b=E6V8Lf4YT1+iURH6vSK8nRWDa8E37KpRYK4Hl7Pq7pRcfH8K+6a7RY7rzG7yD8QLs8R4n3dTrvHO4Qzw25kJSHumezDX69qAjpnFBksKOQGTVN/MqH8VQwo5ygleyQhbHmVY9rpVaJYLDM5URZ4F+Hi9njMMKQEIY7ntKP84FiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996911; c=relaxed/simple;
	bh=xpI+15o/ggAcbKaDEyciMD3Vb9gLEsyJeQ86OGReybc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAMM+gH8I8Aujjdc0wIGh7JIfMZQeMzw3Sn48ET6+38kqhL74CZCDfH5HgTN4pWgJgdT7zgxa43CnWuKX39PR+DvmxswYRrysSLSe7lX2JzaVTsE7sgXPVG9F0Kdii/aqye1SK8r557p102Lwl65AC6Y7P9tSOr1dUUXh6A+r5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=YT7KmYad; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4638sQ17274819
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 3 Jul 2024 01:54:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4638sQ17274819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719996872;
	bh=kyoFq7oawAKp06S/tI3mHScc7IohshnSow91+CyJz78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YT7KmYadpSiqzMhoAHY5uxMYobVALTVwQDI3guXxVBO5u2Xnq362DPTD/K+g0fgMd
	 s2NKRcdM6xauVQH6NW9SAFU/fq7ydQTfkchVqHoD2k5qRGKjkgRga2/+J89EuiB5mC
	 sf8NcGuNvUSi9UuOnATruREHvcGBTfn60u3QXF+f3UynyvFT5VxenAEvvIuCcFR3uX
	 HrVn8ZNf23gaqHuO3nkPHNxjVruUymFvq+rRMqaNmvcKbhaxHAlr37pkueM8VF4Rrs
	 hvDBHzIkmAj/FSpHM1hnMe5VRzsLWSfHHVnaYV678fkVbt5SGxdcLZqBeB+ZQPVX6E
	 Hx+qttqT23Mfg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: [PATCH v1 1/4] x86/fred: Parse cmdline param "fred=" in cpu_parse_early_param()
Date: Wed,  3 Jul 2024 01:54:23 -0700
Message-ID: <20240703085426.274801-2-xin@zytor.com>
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
 arch/x86/kernel/cpu/common.c |  5 +++++
 arch/x86/kernel/traps.c      | 26 --------------------------
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..9a904fe7c829 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1510,6 +1510,11 @@ static void __init cpu_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
 		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
 
+	/* Minimize the gap between FRED is available and available but disabled. */
+	arglen = cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
+	if (arglen != strlen("on") || strcmp(arg, "on"))
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


