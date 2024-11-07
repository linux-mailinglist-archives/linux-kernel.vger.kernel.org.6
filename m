Return-Path: <linux-kernel+bounces-400367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558289C0C97
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695891C22BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0D2178F9;
	Thu,  7 Nov 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsDkkzEY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0C216DE0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999194; cv=none; b=a7q5k/lskumzfvrGkyRDRkUNI2OxWnX+KImPqvd9qIPf8/qek1YWBhnFwxv7APjcziODiGBnA5U/VIrJiGUQ6elSKCA607pvf660zU+M0MYZuoSg6ZfwzMJuI8qggEBq9d3q49IqelbhQoSFpUAshztQooz3UeGL2OOvJV+RWxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999194; c=relaxed/simple;
	bh=OK0f+5lJrvwLpOqaQ5V322eEBNDZKa79//bt026i2kg=;
	h=Subject:To:Cc:From:Date:Message-Id; b=JEI45S8wxx7M7Cbi7xgW/WR8TdOBQ1NfFmlenBr2jOPZyPhvuLMsYOH41hoC51aKpFEJm00TvxuPjZc2oi367ZH8sEJJ6bHLNfAqpmtP2FjRXQNSARO5WprNvZOVtJ+Cy5yTbpJAXdqRQnfVWLt2fAblpr/LCtRU+iXuUc1cY3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsDkkzEY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730999192; x=1762535192;
  h=subject:to:cc:from:date:message-id;
  bh=OK0f+5lJrvwLpOqaQ5V322eEBNDZKa79//bt026i2kg=;
  b=YsDkkzEY46H3Nuv6MCBnJqDp+p/cvv8jju39l6Kh85KGq3yurHE/z6eL
   rrLQcy2yhBXyOtMkhr6f/k24U5PA8J/dNJ1actDfyUe7zHaCXXn7Xms9O
   kTxDzI13aUf9yO7ekVocmsXDkazvjxISd9cU3o3IBKNkatvYouk2ZhN0M
   RUbsWHy/DOcmY2swyAzbpGeyYKkzSIUsW3E3SOu0MQMjucjPbJRmIolcm
   W7ckyTEROXaoiAde+XKXbNQaxr0hzefFZ2bMqdr3Hjnzs0HpBfxnxeeJl
   ICTTR8I40deoUUdxwjZ8l3CPqa9hTZ5BBmp1P+diT6mJHSw2vowPUIY2O
   Q==;
X-CSE-ConnectionGUID: uEQShe9PQHKN70IHbXy7mQ==
X-CSE-MsgGUID: 1T9iMWs7RCSsoBEabwAHNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41964251"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41964251"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 09:06:31 -0800
X-CSE-ConnectionGUID: Vfay7i5dQyeHIway0tL+og==
X-CSE-MsgGUID: q480YEz+SRq24Bd2SzqGFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="85152639"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 07 Nov 2024 09:06:31 -0800
Subject: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode to be a vulnerability
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 07 Nov 2024 09:06:30 -0800
Message-Id: <20241107170630.2A92B8D3@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

You can't practically run old microcode and consider a system secure
these days.  So, let's call old microcode what it is: a vulnerability.
Expose that vulnerability in a place that folks can find it:

	/sys/devices/system/cpu/vulnerabilities/old_microcode

This is obviously imperfect.  But it means that a single file can be
maintained with a single list of microcode versions and there is no need
to track which version fixed a given bug.

== Microcode Revision Discussion ==

The microcode versions in the table were generated from the Intel
microcode git repo:

	29f82f7429c ("microcode-20241029 Release")

It can be argued that the versions that the kernel picks to call "old"
should be a revision or two old.  Which specific version is picked is
less important to me than picking *a* version and enforcing it.

This repository contains only microcode versions that Intel has deemed
to be OS-loadable.  It is quite possible that the BIOS has loaded a
newer microcode than the latest in this repo.  That means that the
vulnerability can be considered to answer this question:

	Are we running on the latest OS-loadable microcode,
	or something even later that the BIOS loaded?

In other words, Intel never publishes an authoritative list of CPUs
and latest microcode revisions.  Until it does, this is the best that
Linux can do.

Also note that the "intel-ucode-defs.h" file is simple, ugly and
has lots of magic numbers.  That's on purpose and should allow a
single file to be shared across lots of stable kernel regardless of if
they have the new "VFM" infrastructure or not.  It was generated with
a dumb script.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/cpufeatures.h               |    1 
 b/arch/x86/kernel/cpu/bugs.c                       |    8 +
 b/arch/x86/kernel/cpu/common.c                     |   28 +++
 b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h |  150 +++++++++++++++++++++
 b/drivers/base/cpu.c                               |    3 
 b/include/linux/cpu.h                              |    2 
 6 files changed, 192 insertions(+)

diff -puN arch/x86/include/asm/cpufeatures.h~old-ucode-0 arch/x86/include/asm/cpufeatures.h
--- a/arch/x86/include/asm/cpufeatures.h~old-ucode-0	2024-11-06 07:51:07.364536033 -0800
+++ b/arch/x86/include/asm/cpufeatures.h	2024-11-06 07:51:07.372536037 -0800
@@ -525,4 +525,5 @@
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* "div0" AMD DIV0 speculation bug */
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
+#define X86_BUG_OLD_MICROCODE		X86_BUG(1*32 + 4) /* "old_microcode" CPU has old microcode, it is surely vulnerable to something */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff -puN arch/x86/kernel/cpu/common.c~old-ucode-0 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~old-ucode-0	2024-11-06 07:51:07.368536035 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-11-07 09:01:58.709687132 -0800
@@ -1317,6 +1317,31 @@ static bool __init vulnerable_to_rfds(u6
 	return cpu_matches(cpu_vuln_blacklist, RFDS);
 }
 
+struct x86_cpu_id cpu_latest_microcdoe[] = {
+#include "microcode/intel-ucode-defs.h"
+	{}
+};
+
+static bool __init cpu_has_old_microcode(void)
+{
+	const struct x86_cpu_id *m = x86_match_cpu(cpu_latest_microcdoe);
+
+	/* Give unknown CPUs a pass: */
+	if (!m)
+		return false;
+
+	/* Consider all debug microcode to be old: */
+	if (boot_cpu_data.microcode & BIT(31))
+		return true;
+
+	/* Give new microocode a pass: */
+	if (boot_cpu_data.microcode >= m->driver_data)
+		return false;
+
+	/* Uh oh, too old: */
+	return true;
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 x86_arch_cap_msr = x86_read_arch_cap_msr();
@@ -1443,6 +1468,9 @@ static void __init cpu_set_bug_bits(stru
 	     boot_cpu_has(X86_FEATURE_HYPERVISOR)))
 		setup_force_cpu_bug(X86_BUG_BHI);
 
+	if (cpu_has_old_microcode())
+		setup_force_cpu_bug(X86_BUG_OLD_MICROCODE);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff -puN arch/x86/kernel/cpu/microcode/intel-ucode-defs.h~old-ucode-0 arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
--- a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h~old-ucode-0	2024-11-06 07:51:07.368536035 -0800
+++ b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h	2024-11-07 09:01:21.269674736 -0800
@@ -0,0 +1,150 @@
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x03, .steppings = 0x0004, .driver_data = 0x2 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0001, .driver_data = 0x45 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0002, .driver_data = 0x40 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0004, .driver_data = 0x2c }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0008, .driver_data = 0x10 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x0001, .driver_data = 0xa }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x0020, .driver_data = 0x3 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x0400, .driver_data = 0xd }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x2000, .driver_data = 0x7 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x07, .steppings = 0x0002, .driver_data = 0x14 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x07, .steppings = 0x0004, .driver_data = 0x38 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x07, .steppings = 0x0008, .driver_data = 0x2e }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0002, .driver_data = 0x11 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0008, .driver_data = 0x8 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0040, .driver_data = 0xc }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0400, .driver_data = 0x5 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x09, .steppings = 0x0020, .driver_data = 0x47 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0a, .steppings = 0x0001, .driver_data = 0x3 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0a, .steppings = 0x0002, .driver_data = 0x1 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0b, .steppings = 0x0002, .driver_data = 0x1d }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0b, .steppings = 0x0010, .driver_data = 0x2 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0d, .steppings = 0x0040, .driver_data = 0x18 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0e, .steppings = 0x0100, .driver_data = 0x39 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0e, .steppings = 0x1000, .driver_data = 0x59 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0004, .driver_data = 0x5d }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0040, .driver_data = 0xd2 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0080, .driver_data = 0x6b }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0400, .driver_data = 0x95 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0800, .driver_data = 0xbc }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x2000, .driver_data = 0xa4 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x16, .steppings = 0x0002, .driver_data = 0x44 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x17, .steppings = 0x0040, .driver_data = 0x60f }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x17, .steppings = 0x0080, .driver_data = 0x70a }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x17, .steppings = 0x0400, .driver_data = 0xa0b }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1a, .steppings = 0x0010, .driver_data = 0x12 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1a, .steppings = 0x0020, .driver_data = 0x1d }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1c, .steppings = 0x0004, .driver_data = 0x219 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1c, .steppings = 0x0400, .driver_data = 0x107 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1d, .steppings = 0x0002, .driver_data = 0x29 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1e, .steppings = 0x0020, .driver_data = 0xa }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x25, .steppings = 0x0004, .driver_data = 0x11 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x25, .steppings = 0x0020, .driver_data = 0x7 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x26, .steppings = 0x0002, .driver_data = 0x105 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2a, .steppings = 0x0080, .driver_data = 0x2f }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2c, .steppings = 0x0004, .driver_data = 0x1f }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2d, .steppings = 0x0040, .driver_data = 0x621 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2d, .steppings = 0x0080, .driver_data = 0x71a }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2e, .steppings = 0x0040, .driver_data = 0xd }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2f, .steppings = 0x0004, .driver_data = 0x3b }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x37, .steppings = 0x0100, .driver_data = 0x838 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x37, .steppings = 0x0200, .driver_data = 0x90d }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3a, .steppings = 0x0200, .driver_data = 0x21 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3c, .steppings = 0x0008, .driver_data = 0x28 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3d, .steppings = 0x0010, .driver_data = 0x2f }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3e, .steppings = 0x0010, .driver_data = 0x42e }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3e, .steppings = 0x0040, .driver_data = 0x600 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3e, .steppings = 0x0080, .driver_data = 0x715 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3f, .steppings = 0x0004, .driver_data = 0x49 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3f, .steppings = 0x0010, .driver_data = 0x1a }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x45, .steppings = 0x0002, .driver_data = 0x26 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x46, .steppings = 0x0002, .driver_data = 0x1c }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x47, .steppings = 0x0002, .driver_data = 0x22 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4c, .steppings = 0x0008, .driver_data = 0x368 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4c, .steppings = 0x0010, .driver_data = 0x411 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4d, .steppings = 0x0100, .driver_data = 0x12d }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4e, .steppings = 0x0008, .driver_data = 0xf0 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0008, .driver_data = 0x1000191 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0010, .driver_data = 0x2007006 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0020, .driver_data = 0x3000010 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0040, .driver_data = 0x4003605 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0080, .driver_data = 0x5003707 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0800, .driver_data = 0x7002904 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0004, .driver_data = 0x1c }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0008, .driver_data = 0x700001c }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0010, .driver_data = 0xf00001a }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0020, .driver_data = 0xe000015 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5c, .steppings = 0x0004, .driver_data = 0x14 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5c, .steppings = 0x0200, .driver_data = 0x48 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5c, .steppings = 0x0400, .driver_data = 0x28 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5e, .steppings = 0x0008, .driver_data = 0xf0 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5f, .steppings = 0x0002, .driver_data = 0x3e }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x66, .steppings = 0x0008, .driver_data = 0x2a }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6a, .steppings = 0x0020, .driver_data = 0xc0002f0 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6a, .steppings = 0x0040, .driver_data = 0xd0003e7 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6c, .steppings = 0x0002, .driver_data = 0x10002b0 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7a, .steppings = 0x0002, .driver_data = 0x42 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7a, .steppings = 0x0100, .driver_data = 0x24 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7e, .steppings = 0x0020, .driver_data = 0xc6 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8a, .steppings = 0x0002, .driver_data = 0x33 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8c, .steppings = 0x0002, .driver_data = 0xb8 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8c, .steppings = 0x0004, .driver_data = 0x38 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8d, .steppings = 0x0002, .driver_data = 0x52 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0200, .driver_data = 0xf6 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0400, .driver_data = 0xf6 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0800, .driver_data = 0xf6 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x1000, .driver_data = 0xfc }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0100, .driver_data = 0x2c000390 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0080, .driver_data = 0x2b0005c0 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0040, .driver_data = 0x2c000390 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0020, .driver_data = 0x2c000390 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0010, .driver_data = 0x2c000390 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x96, .steppings = 0x0002, .driver_data = 0x1a }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x97, .steppings = 0x0004, .driver_data = 0x36 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x97, .steppings = 0x0020, .driver_data = 0x36 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0004, .driver_data = 0x36 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0020, .driver_data = 0x36 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9a, .steppings = 0x0008, .driver_data = 0x434 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9a, .steppings = 0x0010, .driver_data = 0x434 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9c, .steppings = 0x0001, .driver_data = 0x24000026 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0200, .driver_data = 0xf8 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0400, .driver_data = 0xf8 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0800, .driver_data = 0xf6 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x1000, .driver_data = 0xf8 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x2000, .driver_data = 0x100 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0004, .driver_data = 0xfc }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0008, .driver_data = 0xfc }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0020, .driver_data = 0xfc }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa6, .steppings = 0x0001, .driver_data = 0xfe }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa6, .steppings = 0x0002, .driver_data = 0xfc }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa7, .steppings = 0x0002, .driver_data = 0x62 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xaa, .steppings = 0x0010, .driver_data = 0x1f }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xb7, .steppings = 0x0002, .driver_data = 0x12b }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0004, .driver_data = 0x4122 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0008, .driver_data = 0x4122 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0100, .driver_data = 0x4122 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbe, .steppings = 0x0001, .driver_data = 0x1a }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xcf, .steppings = 0x0004, .driver_data = 0x21000230 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xcf, .steppings = 0x0002, .driver_data = 0x21000230 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x00, .steppings = 0x0080, .driver_data = 0x12 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x00, .steppings = 0x0400, .driver_data = 0x15 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x01, .steppings = 0x0004, .driver_data = 0x2e }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0010, .driver_data = 0x21 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0020, .driver_data = 0x2c }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0040, .driver_data = 0x10 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0080, .driver_data = 0x39 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0200, .driver_data = 0x2f }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x03, .steppings = 0x0004, .driver_data = 0xa }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x03, .steppings = 0x0008, .driver_data = 0xc }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x03, .steppings = 0x0010, .driver_data = 0x17 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0002, .driver_data = 0x17 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0008, .driver_data = 0x5 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0010, .driver_data = 0x6 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0080, .driver_data = 0x3 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0100, .driver_data = 0xe }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0200, .driver_data = 0x3 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0400, .driver_data = 0x4 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0004, .driver_data = 0xf }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0010, .driver_data = 0x4 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0020, .driver_data = 0x8 }
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0100, .driver_data = 0x9 }
diff -puN arch/x86/kernel/cpu/bugs.c~old-ucode-0 arch/x86/kernel/cpu/bugs.c
--- a/arch/x86/kernel/cpu/bugs.c~old-ucode-0	2024-11-06 07:58:23.256734986 -0800
+++ b/arch/x86/kernel/cpu/bugs.c	2024-11-06 08:31:44.045967210 -0800
@@ -2945,6 +2945,9 @@ static ssize_t cpu_show_common(struct de
 	case X86_BUG_RFDS:
 		return rfds_show_state(buf);
 
+	case X86_BUG_OLD_MICROCODE:
+		return sysfs_emit(buf, "Vulnerable\n");
+
 	default:
 		break;
 	}
@@ -3024,6 +3027,11 @@ ssize_t cpu_show_reg_file_data_sampling(
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
 }
+
+ssize_t cpu_show_old_microcode(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_OLD_MICROCODE);
+}
 #endif
 
 void __warn_thunk(void)
diff -puN drivers/base/cpu.c~old-ucode-0 drivers/base/cpu.c
--- a/drivers/base/cpu.c~old-ucode-0	2024-11-06 08:26:51.505813735 -0800
+++ b/drivers/base/cpu.c	2024-11-06 08:29:56.925911521 -0800
@@ -599,6 +599,7 @@ CPU_SHOW_VULN_FALLBACK(retbleed);
 CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
 CPU_SHOW_VULN_FALLBACK(gds);
 CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
+CPU_SHOW_VULN_FALLBACK(old_microcode);
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -614,6 +615,7 @@ static DEVICE_ATTR(retbleed, 0444, cpu_s
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
+static DEVICE_ATTR(old_microcode, 0444, cpu_show_old_microcode, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -630,6 +632,7 @@ static struct attribute *cpu_root_vulner
 	&dev_attr_spec_rstack_overflow.attr,
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_reg_file_data_sampling.attr,
+	&dev_attr_old_microcode.attr,
 	NULL
 };
 
diff -puN include/linux/cpu.h~old-ucode-0 include/linux/cpu.h
--- a/include/linux/cpu.h~old-ucode-0	2024-11-06 08:32:44.333998355 -0800
+++ b/include/linux/cpu.h	2024-11-06 08:33:02.998007967 -0800
@@ -77,6 +77,8 @@ extern ssize_t cpu_show_gds(struct devic
 			    struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
 					       struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_old_microcode(struct device *dev,
+				      struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
_

