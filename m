Return-Path: <linux-kernel+bounces-233152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024C91B2F4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2A82830AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8F1A2FC6;
	Thu, 27 Jun 2024 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfmHfDfh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB913E04F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532273; cv=none; b=Ie4WUvnnwTTQCPNJ2NFSPkxvu+2L8aJ8DGEab9LEfUcqEc/wTUmoWxUj4fSuwe3JMPlmQi8xhoNQ95TfdryV0QP98hyUfXBFN7h1x6j+V/LWNNLW4tXnOhmeyrWH2JyD2ALGG51MNnoUUgY4GKxUZj5XfdO+0isgVtY5nyeM3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532273; c=relaxed/simple;
	bh=eVU6qMjuVBUApmISteIcnKmkrC/Lb84Kp/EaKiZPKV0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jrMsoyRY273COjLmxBesAv5HXFC/sNf5VoYjKYCN1Dd/z8MSVyyyDH0jHRJXfhqeTfFm575hjcYEIgPPfpKzLcNXoICvI+xGZBCSS2Ufmv5znLppYPTDO8/lGAh1fPklJQK+hHHfunvQJDKdFFehE5qhhryMIZk5AM/tpu1FWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfmHfDfh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719532270; x=1751068270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eVU6qMjuVBUApmISteIcnKmkrC/Lb84Kp/EaKiZPKV0=;
  b=bfmHfDfhtOUshnwmdSLMjPXk80PSkN/wSrhuO3jDMu3eCeOHKznfB4Xw
   0rv6LruJ1dgf1NzD4tm2Z4SPB5HuNykIZac4llcD8QV0qsY+FQfpFtKeX
   vvciTx8lK8Dw1xj60VMg4UhP7+uRRp+/B16AL+VUGX8imZjEKfRXZqvwT
   6MzGQo4mj8BFTq2AFDypjb/FyTejixqU68KozO3cwOX3L6oI9SuyDwvt6
   ndP0UCx0ABRFsZO3LSFhPNF6brNCcV5xaGN1XaAWlFQTLZaXpoQ2ZQ2Rg
   vbBfM0brTxNLEtczXY2pwrnQx26cmGC3znx1Hbz6g8y063K632KjH7lV4
   A==;
X-CSE-ConnectionGUID: zBEdrW28S+ajhPtkmoMFww==
X-CSE-MsgGUID: E8NXWzjOTCSKkN9srNzrEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27385024"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="27385024"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 16:51:10 -0700
X-CSE-ConnectionGUID: k2qjuoGzTpiSz0kzSUjMDA==
X-CSE-MsgGUID: Yp/QBxqdTneCfgNBL8zqtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="48888651"
Received: from gbpfeiff-mobl.amr.corp.intel.com (HELO desk) ([10.255.229.132])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 16:51:10 -0700
Date: Thu, 27 Jun 2024 16:51:09 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: [PATCH v2] x86/entry_32: Move CLEAR_CPU_BUFFERS before restoring
 segments
Message-ID: <20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAG/6fWYC/3WNwQqDMBBEf0X23BU3EQ099T+KBzFrXdCkJBos4
 r839d7jG2beHBA5CEe4FwcEThLFuwzqVsAw9e7FKDYzqErVVa0aHGVH6yMvG6bFNGgtEfUVtbp
 lyKt34Fy5jM8u8yRx9eFzHST6pf9diZDQmMGoptejbs1jFrftpbiV53LwC3TneX4Bs+KqOLQAA
 AA=
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
This is because segment registers can have funky values with vm86() that
can result in #GP when executing VERW. Intel SDM vol. 2C documents the
following behavior for VERW instruction:

  #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
	   FS, or GS segment limit.

CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to
user space. Add CLEAR_CPU_BUFFERS to the macro RESTORE_REGS before it
restores segment registers. In vm86 mode kernel does not support SYSCALL
and SYSENTER instructions, so the problem is only limited to int80 path
in 32-bit mode. In the opportunistic SYSEXIT path use
CLEAR_CPU_BUFFERS_SAFE that ensures a sane %ds value.

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
   verw   0xc0fb0fc0       <-------------
   pop    %ds
   pop    %es
   pop    %fs

* Opportunistic SYSEXIT explicitly does CLEAR_CPU_BUFFERS_SAFE:

   [...]
   pop    %eax
   verw   0xc0fb0fc0       <-------------
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
   verw   0xc0fb0fc0      <-------------
   pop    %ds
   pop    %es
   pop    %fs

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Cc: stable@vger.kernel.org # 5.10+
Reported-by: Robert Gill <rtgill82@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
v2:
- Safe guard against any other system calls like vm86() that might change %ds (Dave).

v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com
---
 arch/x86/entry/entry_32.S | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d3a814efbff6..44b21f7b6da6 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -253,6 +253,20 @@
 .Lend_\@:
 .endm
 
+/*
+ * Safer version of CLEAR_CPU_BUFFERS that temporarily sets %ds to KERNEL_DS.
+ * This ensures VERW will not #GP when referencing the memory operand.
+ */
+.macro CLEAR_CPU_BUFFERS_SAFE
+	ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
+	pushl	%ds
+	pushl	$(__KERNEL_DS)
+	popl	%ds
+	verw	_ASM_RIP(mds_verw_sel)
+	popl	%ds
+.Lskip_verw\@:
+.endm
+
 .macro RESTORE_INT_REGS
 	popl	%ebx
 	popl	%ecx
@@ -263,8 +277,15 @@
 	popl	%eax
 .endm
 
-.macro RESTORE_REGS pop=0
+.macro RESTORE_REGS pop=0 clear_cpu_buf=0
 	RESTORE_INT_REGS
+	/*
+	 * CLEAR_CPU_BUFFERS must be done before restoring segment
+	 * registers to avoid #GP when executing VERW in vm86 mode.
+	 */
+	.if \clear_cpu_buf
+	CLEAR_CPU_BUFFERS
+	.endif
 1:	popl	%ds
 2:	popl	%es
 3:	popl	%fs
@@ -299,7 +320,7 @@
 
 	BUG_IF_WRONG_CR3
 
-	RESTORE_REGS pop=\pop
+	RESTORE_REGS pop=\pop clear_cpu_buf=1
 .endm
 
 .macro CHECK_AND_APPLY_ESPFIX
@@ -871,6 +892,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Now ready to switch the cr3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	CLEAR_CPU_BUFFERS_SAFE
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
@@ -881,7 +903,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
-	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -950,8 +971,7 @@ restore_all_switch_stack:
 	BUG_IF_WRONG_CR3
 
 	/* Restore user state */
-	RESTORE_REGS pop=4			# skip orig_eax/error_code
-	CLEAR_CPU_BUFFERS
+	RESTORE_REGS pop=4 clear_cpu_buf=1	# skip orig_eax/error_code
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1144,7 +1164,6 @@ SYM_CODE_START(asm_exc_nmi)
 
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



