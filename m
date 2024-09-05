Return-Path: <linux-kernel+bounces-317491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A285F96DF0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E671F2553D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AEA19F479;
	Thu,  5 Sep 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoomji14"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE619E82C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552061; cv=none; b=WMp3pcSIyqCiLhwXbXfKCbr1goRqDkibe9QfxvLAWoIAy9ich7rbvJiVMD/5x+TeXeASUqmKqzqkhxewxg8MZY+KzMdfZeyVCxbqxJRtDdH1UpoY4yhZC5Zbn4soI1hz0mIuHdIIkbc74G9/x1JgyX38w18Co7pxu3zY7iO7uAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552061; c=relaxed/simple;
	bh=Sf2H0pfrE9E267/+P/2+hCZdeQu4EoaUhRD5j7PnoGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmQ/czh3HVxJZA5GHorOBG3aBWUqnXJJn5faTW9pP/DlXjLHWjL5XrL1W7ytdRls0wYbr6E4Y5KQTW8s4D27hFZpFhtR7Bmnqo6i5C8Rds10hYzTChQ6a2OM/gOQQdNEa5+Bawx82tHqLrdm3JK21LEEOhhpAM00kcbd/tsSuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoomji14; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725552059; x=1757088059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sf2H0pfrE9E267/+P/2+hCZdeQu4EoaUhRD5j7PnoGo=;
  b=hoomji14eohQFA64yvc5pAXvO0QkutjtpJWrHBaQSjTblAYYBLLdhpzB
   CBOflq+nmm4w940LGh9wcmW9/M7oDiPaItjUAtmGI/ATrWXECj9jbbd8H
   50VWw61VRKbFkYDdVTlJiTaci3VtwyFecLO4vTLJyzi0E0xwMV8Vp5Wvv
   HJ4yo0+RcR62wE+5Op21lVy3W6G1QwxDr/TDLW5NV2UoLxnuym0DGmJ7H
   UennIpKt5CmjCF6hd8L1x+Zq+TBOE5O+hrX/Tt6bmM4kCglryOSa5OKyt
   Ld6STVAbUamIyx0LJwIW1IO9APen4fMF2ye3Uk5zJG4Mu4cQYOIxNlS5d
   w==;
X-CSE-ConnectionGUID: xlHzhciBT8S7FN7MMpMS+w==
X-CSE-MsgGUID: HlC3hUQWQy+INQydtcbmsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="35666013"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="35666013"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:00:59 -0700
X-CSE-ConnectionGUID: gl709AT7S6GaieBeYcgDhQ==
X-CSE-MsgGUID: a7rQtfz4RNOAedfdHDtXow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="69816301"
Received: from bllerma-mobl2.amr.corp.intel.com (HELO desk) ([10.125.147.102])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:00:59 -0700
Date: Thu, 5 Sep 2024 09:00:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: [PATCH v6 3/3] x86/bugs: Use stack segment selector for VERW operand
Message-ID: <20240905-fix-dosemu-vm86-v6-3-7aff8e53cbbf@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com>

Robert Gill reported below #GP in 32-bit mode when dosemu software was
executing vm86() system call:

  general protection fault: 0000 [#1] PREEMPT SMP
  CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
  Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
  EIP: restore_all_switch_stack+0xbe/0xcf
  EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
  ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
  DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
  CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
  Call Trace:
   show_regs+0x70/0x78
   die_addr+0x29/0x70
   exc_general_protection+0x13c/0x348
   exc_bounds+0x98/0x98
   handle_exception+0x14d/0x14d
   exc_bounds+0x98/0x98
   restore_all_switch_stack+0xbe/0xcf
   exc_bounds+0x98/0x98
   restore_all_switch_stack+0xbe/0xcf

This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
are enabled. This is because segment registers with an arbitrary user value
can result in #GP when executing VERW. Intel SDM vol. 2C documents the
following behavior for VERW instruction:

  #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
	   FS, or GS segment limit.

CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
space. Use %ss selector to reference VERW operand. This ensures VERW will
not #GP for an arbitrary user %ds.

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Cc: stable@vger.kernel.org # 5.10+
Reported-by: Robert Gill <rtgill82@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Brian Gerst <brgerst@gmail.com> # Use %ss
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ff5f1ecc7d1e..aa5ed1a59cde 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -318,12 +318,14 @@
 /*
  * Macro to execute VERW instruction that mitigate transient data sampling
  * attacks such as MDS. On affected systems a microcode update overloaded VERW
- * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
+ * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %ss
+ * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
+ * 32-bit mode.
  *
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", __stringify(verw %ss:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
 .endm
 
 #ifdef CONFIG_X86_64

-- 
2.34.1



