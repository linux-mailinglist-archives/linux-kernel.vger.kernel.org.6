Return-Path: <linux-kernel+bounces-227653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B35F91551B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6091C2221E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0725C19EEBA;
	Mon, 24 Jun 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPYkF+DB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A81EA87
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248986; cv=none; b=qIHwsejvqj9TIvJubRs1mNPfwRygp9pZcJ3WoPC3BGeUUQd4110uAnZwHZlOY/DbhTnCAHNgcNqRP8lu2DpQ8CyykZj5yhzsi25nggjOSO22bf1lSKwwhr/2a1pjcbJBBGbNOnrf6uDo48pf8VIQTGizYLR6ZpkIJAPUqEf7YUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248986; c=relaxed/simple;
	bh=hjpGcZWpASZoRBIJ6W0UvMgug/JfCWhySi/Y+KimVoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0A7b0PXsZx9rD0zhcR6lTbigwjTb4bgbm56kJBusuFVPGNyeTe5EVVoXjQW113E8kfnv6bTjTa8xhAQ0eEeuoOswQS4/gLYacKXMrYKyy94uD1JoQPihCkrUk8unI0+CRZ0lpKzEbzMJrDoK2rIc4o1oiljGXRO0MjkvrhYuVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPYkF+DB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719248984; x=1750784984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hjpGcZWpASZoRBIJ6W0UvMgug/JfCWhySi/Y+KimVoc=;
  b=fPYkF+DB6z0CElsfVjMm2A9KavhuHwIBPk1bSpRlvk/esjsdJCGR7Y68
   lFGgaPmLY7fw9vdbn+/QQXOn/SFEE9maJtx6RIw66CTLR83xRgbxrgzYN
   SU+wXMOecS9gyolIp7a/GlWfABDoHaR/NfpHHs1CqscxCORv3aVqNm+It
   Gt43DAtfJxEFLlORVUOHsaGOJwLe2NyzQZz+VeMAbjb4fI5XdaYrOfssv
   dxK+bcqMyMGF5o6Zb/HuB/5gDhBhiJFHH+N+Vru+tkj8rZicnqVB2gqd/
   xta7VquOtIN6GNhTL0Fi696RYWbJ3bzVEPpCevP+lGFW1AEDDiO5Q09ua
   A==;
X-CSE-ConnectionGUID: IS8UXCBiRPqVBk4Rvsthvg==
X-CSE-MsgGUID: tKUeuR0TSZio/8MfpWwe2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16364338"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16364338"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 10:09:44 -0700
X-CSE-ConnectionGUID: Z2fSWANMRB+xoImvO4JYIQ==
X-CSE-MsgGUID: qqQrV0smTiCj2RxhjFIk8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43241982"
Received: from mabir-mobl.amr.corp.intel.com (HELO desk) ([10.209.7.244])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 10:09:44 -0700
Date: Mon, 24 Jun 2024 10:09:21 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Stable linux-5.10.x regression triggered by MDS mitigation
Message-ID: <20240624170921.mep2x6pg4aiui4wh@desk>
References: <IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com>

On Sun, Jun 23, 2024 at 02:34:12PM +0000, Jari Ruusu wrote:
> I have 32-bit x86 linux virtual machine running on
> QEMU-8.2.2+ds-0ubuntu1 with KVM acceleration. QEMU emulated
> CPU model is pentium2. Host is 64-bit linux running on Intel
> i5-7200U with latest microcode. Inside that 32-bit x86 linux
> VM I sometimes start dosemu to run some old MS-DOS programs.
> 
> Now dosemu fails to start with "Segmentation fault" error,
> and this shows up in dmesg output:
> 
> [   23.768348] general protection fault: 0000 [#1]
> [   23.768353] CPU: 0 PID: 1730 Comm: dosemu.bin Not tainted 5.10.214-test12345 #1
> [   23.768354] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   23.768358] EIP: restore_all_switch_stack+0xbd/0xc5
> [   23.768359] Code: 10 36 89 48 fc 8b 4c 24 0c 81 e1 ff ff 00 00 36 89 48 f8 8b 4c 24 08 36 89 48 f4 8b 4c 24 04 36 89 48 f0 59 8d 60 f0 58 89 f6 <0f> 00 2d 80 87 5c c1 cf fc 0f a0 50 b8 00 00 00 00 8e e0 8c d0 66
> [   23.768361] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> [   23.768362] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ffc03fdc
> [   23.768363] DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
> [   23.768366] CR0: 80050033 CR2: 00a33020 CR3: 0fc3b000 CR4: 00000290
> [   23.768368] Call Trace:
> [   23.768371]  ? show_regs+0x5d/0x60
> [   23.768373]  ? __die_body+0x10/0x43
> [   23.768374]  ? die_addr+0x27/0x3c
> [   23.768376]  ? exc_general_protection+0x1e6/0x239
> [   23.768378]  ? exc_bounds+0x8a/0x8a
> [   23.768379]  ? handle_exception+0x147/0x147
> [   23.768381]  ? exc_bounds+0x8a/0x8a
> [   23.768386]  ? restore_all_switch_stack+0xbd/0xc5
> [   23.768388]  ? exc_bounds+0x8a/0x8a
> [   23.768389]  ? restore_all_switch_stack+0xbd/0xc5
> [   23.768390] Modules linked in:
> [   23.768392] ---[ end trace 960c0712f12c2f48 ]---
> [   23.768394] EIP: restore_all_switch_stack+0xbd/0xc5
> [   23.768395] Code: 10 36 89 48 fc 8b 4c 24 0c 81 e1 ff ff 00 00 36 89 48 f8 8b 4c 24 08 36 89 48 f4 8b 4c 24 04 36 89 48 f0 59 8d 60 f0 58 89 f6 <0f> 00 2d 80 87 5c c1 cf fc 0f a0 50 b8 00 00 00 00 8e e0 8c d0 66
> [   23.768396] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> [   23.768397] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ffc03fdc
> [   23.768398] DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
> [   23.768400] CR0: 80050033 CR2: 00a33020 CR3: 0fc3b000 CR4: 00000290
> 
> Inside that 32-bit VM, kernel.org linux-5.10.214 and earlier
> 5.10.x versions start dosemu normally.
> 
> Inside that 32-bit VM, linux-5.10.215 and later 5.10.x
> versions fail to start dosemu.
> 
> Inside that 32-bit VM, linux-5.10.215 and later 5.10.x
> versions work if "mitigations=off" kernel parameter is
> added to the kernel running inside the VM.
> 
> I have narrowed down the problem so that linux-5.10.214 plus
> following 5 patches trigger that failure. Above dmesg output
> from "5.10.214-test12345" kernel includes following 5
> patches.
> 
> 
> 
> x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=8b20c6f894b7d7d87d3aa1a85cbc7d57378e1346
> 
> x86/bugs: Add asm helpers for executing VERW
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=35e36eac881cddea42ca5fd93facc145a2d5369d
> 
> x86/entry_64: Add VERW just before userspace transition
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=edc702b4a820fc7ffc20e732db1c421cfffbb746
> 
> x86/entry_32: Add VERW just before userspace transition
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=50f021f0b985629accf10481a6e89af8b9700583
> 
> x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=6192d9ed311f70eb7e8ab4a874631a98c5a9217e
> 
> 
> 
> My reading of above dmesg output indicates that it is that
> VERW opcode that fails inside CLEAR_CPU_BUFFERS macro in
> arch/x86/include/asm/nospec-branch.h file. My reading of
> (possibly outdated) Intel Instruction Set Reference
> indicates this: "The VERR and VERW instructions are not
> recognized in virtual-8086 mode". My understanding is that
> dosemu uses virtual-8086 mode if that is available. Did
> above patch-set just kill virtual-8086 mode and dosemu
> permanently despite my 32-bit VM kernel .config having
> these?
> 
>  CONFIG_X86_LEGACY_VM86=y
>  CONFIG_VM86=y
> 
> I know that I am doing weird stuff and I understand that
> 32-bit linux and dosemu are probably something that most
> people don't care about, but this is still stable
> linux-5.10.x kernel regression that should be fixed.
> 
> Upstream Linux-6.10-rc4 seems to have similarly functioning
> CLEAR_CPU_BUFFERS macro with VERW opcode that is used in
> restore_all_switch_stack code path, so the same problem may
> well be with all newer kernels.
> 
> Pawan Gupta,
> Since you seem to be the author of above mentioned breakage,
> is there any chance of you sorting this out?

Below patch (for v6.10-rc5) should fix this. I didn't send this patch
earlier because I havn't got a chance to make sure if it will work for
other cases like modify_ldt().

---
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH] x86/entry_32: Move CLEAR_CPU_BUFFERS before restoring
 segments

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

CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
space. Add CLEAR_CPU_BUFFERS to the macro RESTORE_REGS before it restores
segment registers. In vm86 mode kernel does not support SYSCALL and
SYSENTER instructions, so the problem is only limited to int80 path in
32-bit mode. Leave the CLEAR_CPU_BUFFERS in the opportunistic SYSEXIT path
as it is.

Below are the locations where CLEAR_CPU_BUFFERS is currently being done.

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

* Opportunistic SYSEXIT explicitly does CLEAR_CPU_BUFFERS:

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
Reported-by: Robert Gill <rtgill82@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_32.S | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d3a814efbff6..c963abc17a96 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -263,8 +263,15 @@
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
@@ -299,7 +306,7 @@
 
 	BUG_IF_WRONG_CR3
 
-	RESTORE_REGS pop=\pop
+	RESTORE_REGS pop=\pop clear_cpu_buf=1
 .endm
 
 .macro CHECK_AND_APPLY_ESPFIX
@@ -950,8 +957,7 @@ restore_all_switch_stack:
 	BUG_IF_WRONG_CR3
 
 	/* Restore user state */
-	RESTORE_REGS pop=4			# skip orig_eax/error_code
-	CLEAR_CPU_BUFFERS
+	RESTORE_REGS pop=4 clear_cpu_buf=1	# skip orig_eax/error_code
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1144,7 +1150,6 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
-	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
-- 
2.34.1


