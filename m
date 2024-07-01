Return-Path: <linux-kernel+bounces-236837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BA791E7AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4568C1C22A30
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D310016F0C1;
	Mon,  1 Jul 2024 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNwWMI+n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367716EB67
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858849; cv=none; b=RUkl5taRrvk48XJY7bffiFPZ8FBQZYDQLlNVi0sUGfkSFVgQjjd/aPxwKp83/7Jrj8Glr+pinKBBzFHo2cXKbplpYgezwPojGD24x4qw81iweobUSSfUeXaoPQxEu/t4xES/Gp0Np+Y22pXv0skxtfYqSC/MYb/jRcbMvdXCNmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858849; c=relaxed/simple;
	bh=4y9oP0WlGIH3k3oJpLsN3TV9687VpTW/RDrYJVRNngo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GayNV64UaFieSZS4fHVgNQgn9vjCFysz/GIl8svjImgOt0IGK2TtVa9nNyFK4Q9QnWYs2ZLGEsDwqXi7Yf/RhBhMjYfkFn5prhiXzQJZ5WY7o7IteNUkgZU0v1RWanDheOtur9U/hRkf5boeuO24uD6TWaq91wg/edzwYY4EdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNwWMI+n; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719858847; x=1751394847;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4y9oP0WlGIH3k3oJpLsN3TV9687VpTW/RDrYJVRNngo=;
  b=BNwWMI+nFZOWffR2vgQZE5pdFu7oFghRHdZb2WIBEmcBpxKhufSTZKq4
   3i3pC3M39y2ODEnxMwp47tMG7fqAiaMLgO9Ip2gdR1wPBF4mJkFuOi+r2
   vj2rk4PNiwBH0e/8KOq9fTyXwrCi/Umm00drWq8skqRJ1+ChBpaALJBAd
   YjH7O5JnG1rdP06yI0Dj1qx3Bi7S+qt+pZ6uusqmLwcOuDKQ2WABX71Vs
   xbUifbzc3HchqvR3WLM7maibUNW6MWpgDxY9xjBraijAadhRn75ECy6fM
   vRxar7Hfm+14u5Si4D2ixNw9kFf8tgECkqN83HzsDbAs5bLBlJYgR2HrD
   A==;
X-CSE-ConnectionGUID: ZRsLdCyvQmm/0nl+yMvRnw==
X-CSE-MsgGUID: gaN0RvoeTfigLDtLu44L8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17136337"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17136337"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 11:34:06 -0700
X-CSE-ConnectionGUID: Xf+bzlsaRX+cJKwHo3NuNA==
X-CSE-MsgGUID: 8ACbuJQKQHO2se8NkLHinQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45695455"
Received: from aadeosun-mobl.amr.corp.intel.com (HELO desk) ([10.209.8.130])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 11:34:05 -0700
Date: Mon, 1 Jul 2024 11:34:04 -0700
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
Subject: [PATCH v3] x86/entry_32: Move CLEAR_CPU_BUFFERS before restoring
 segments
Message-ID: <20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAM71gmYC/3XNwQ6DIAyA4VcxnIcRUMCd9h7LDkbqbKJgQImL8
 d2HXnYwO/5N+3UjATxCIPdsIx4iBnQ2hbhlpO0b+waKJjXhBS+Lkkva4UqNCzAuNI5aUmMYY03
 BlFBA0tXkIa2c4vOVuscwO/85H0R2TP9bkVFGtW41l43ohNKPAe2y5mhnGPLWjeQQI/8pkqurw
 pNiqkrVnaw1KHVV9n3/Al5G5Ln6AAAA
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Robert Gill reported below #GP when dosemu software was executing vm86()
system call:

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

This only happens when VERW based mitigations like MDS, RFDS are enabled.
This is because segment registers with an arbitrary user value can result
in #GP when executing VERW. Intel SDM vol. 2C documents the following
behavior for VERW instruction:

  #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
	   FS, or GS segment limit.

CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
space. Move CLEAR_CPU_BUFFERS to the macro RESTORE_REGS such that VERW is
executed before user segments are restored. In the opportunistic SYSEXIT
path use CLEAR_CPU_BUFFERS_SAFE that uses %ss instead.

Below are the locations where CLEAR_CPU_BUFFERS* is currently being used:

* entry_INT80_32(), entry_SYSENTER_32() and interrupts (via
  handle_exception_return) do:

restore_all_switch_stack:
  [...]
  RESTORE_REGS pop=4 clear_cpu_buf=1
   pop    %ebx
   pop    %ecx
   pop    %edx
   pop    %esi
   pop    %edi
   pop    %ebp
   pop    %eax
   verw   0xc0fc92c0       <-------------
   pop    %ds
   pop    %es
   pop    %fs

* Opportunistic SYSEXIT explicitly does CLEAR_CPU_BUFFERS_SAFE:

   [...]
   verw   %ss:0xc0fc92c0  <-------------
   btrl   $0x9,(%esp)
   popf
   pop    %eax
   sti
   sysexit

* NMIs use RESTORE_ALL_NMI -> RESTORE_REGS:

   nmi_return:
   [...]
   RESTORE_ALL_NMI cr3_reg=%edi
   jmp    0xc0fb22e0 <asm_exc_nmi+612>
   test   $0x1000,%edi
   je     0xc0fb22e0 <asm_exc_nmi+612>
   mov    %edi,%cr3
   pop    %ebx
   pop    %ecx
   pop    %edx
   pop    %esi
   pop    %edi
   pop    %ebp
   pop    %eax
   verw   0xc0fc92c0      <-------------
   pop    %ds
   pop    %es
   pop    %fs

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Cc: stable@vger.kernel.org # 5.10+
Reported-by: Robert Gill <rtgill82@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Brian Gerst <brgerst@gmail.com> # Use %ss
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
v3:
- Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian).
- Do verw before popf in SYSEXIT path (Jari).

v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com
- Safe guard against any other system calls like vm86() that might change %ds (Dave).

v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com
---
 arch/x86/entry/entry_32.S | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d3a814efbff6..6a135478dc2e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -253,6 +253,17 @@
 .Lend_\@:
 .endm
 
+/*
+ * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW operand
+ * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %ds
+ * value.
+ */
+.macro CLEAR_CPU_BUFFERS_SAFE
+	ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
+	verw	%ss:_ASM_RIP(mds_verw_sel)
+.Lskip_verw\@:
+.endm
+
 .macro RESTORE_INT_REGS
 	popl	%ebx
 	popl	%ecx
@@ -263,8 +274,15 @@
 	popl	%eax
 .endm
 
-.macro RESTORE_REGS pop=0
+.macro RESTORE_REGS pop=0 clear_cpu_buf=0
 	RESTORE_INT_REGS
+	/*
+	 * CLEAR_CPU_BUFFERS must be done before restoring segment
+	 * registers to avoid #GP when executing VERW with user %ds.
+	 */
+	.if \clear_cpu_buf
+	CLEAR_CPU_BUFFERS
+	.endif
 1:	popl	%ds
 2:	popl	%es
 3:	popl	%fs
@@ -299,7 +317,7 @@
 
 	BUG_IF_WRONG_CR3
 
-	RESTORE_REGS pop=\pop
+	RESTORE_REGS pop=\pop clear_cpu_buf=1
 .endm
 
 .macro CHECK_AND_APPLY_ESPFIX
@@ -871,6 +889,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Now ready to switch the cr3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	CLEAR_CPU_BUFFERS_SAFE
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
@@ -881,7 +900,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
-	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -950,8 +968,7 @@ restore_all_switch_stack:
 	BUG_IF_WRONG_CR3
 
 	/* Restore user state */
-	RESTORE_REGS pop=4			# skip orig_eax/error_code
-	CLEAR_CPU_BUFFERS
+	RESTORE_REGS pop=4 clear_cpu_buf=1	# skip orig_eax/error_code
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1144,7 +1161,6 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
-	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:

---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240426-fix-dosemu-vm86-dd111a01737e

Best regards,
-- 
Thanks,
Pawan



