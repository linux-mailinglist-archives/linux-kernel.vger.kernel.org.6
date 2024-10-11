Return-Path: <linux-kernel+bounces-361175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B0B99A49D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9D3285841
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6921949C;
	Fri, 11 Oct 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkfHdAM/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B823218D80;
	Fri, 11 Oct 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652316; cv=none; b=XOqSmiG8SV3oYdhOpa74Sy3I4sa9iy3+lll+6bBvrtYYzkb6Bz7CY5yRbfizYep+och9wt5ZJIyJUGvx+X4ie/U9HmBfZ3BMEDWhg6+/BxzHf1CxvsFUgvpSG00CU+4V3ylPEiYKz2bjzFMFD6OMIbByZhziTng6cQc5/s/csAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652316; c=relaxed/simple;
	bh=7pS2FYk9N9B4YqopZOxx9CZfs1CwCBBuU1c1xPtkC0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFbrwbHf5Ypixr+7QdWQB9iPk6x/e58/RSbvIz44NVXSyu5TIaHW2sVaJI3YHpZRT0A9hADP7Z+TGAqX0aZ+JqbK78vkfZW4p3gB4kJ5/8/cUlb0APzHX14cunubIizltqSzPxj5FHPqkE70VBMp/BaSjmH89gqjoa1KOgrH7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkfHdAM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA1C4CEC3;
	Fri, 11 Oct 2024 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728652315;
	bh=7pS2FYk9N9B4YqopZOxx9CZfs1CwCBBuU1c1xPtkC0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkfHdAM/O2j0+o7F0ia+QL7UdbrNu2y1z3BvD4hyPXKMHT9CsznTwaLY3L0oxzPVw
	 N+8eDqbjCJgPfU8NrVndW6fdXieVprlD9s6pHGcpa0RNy5KR+qq82dgacIfFUzWEv4
	 VCx/HYcga6hc1emJLs+2bsf0ILcO+Biq7Ngq5kC13+7FMUWGH9wyjtkcCbUWxRtpgf
	 9RIr/YUoD0wfiaQ7mpacJD6dsbCtqv17Q78k1FRMItzPTefkFmMNus9ibPaVyd6p4W
	 9otfJ1G6NZlOPgdUY9g4dIK2Jg/uNybQK6JdUNzy5QKNZVWZoxDhoUKtOptuhyDM3n
	 YPE5xKDErE/rg==
Date: Fri, 11 Oct 2024 16:08:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [x86/module]  6661cae1aa:
 WARNING:at_arch/x86/mm/pat/set_memory.c:#__cpa_process_fault
Message-ID: <ZwkjPKKxRKUoJuOE@kernel.org>
References: <202410111408.8fe6f604-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410111408.8fe6f604-lkp@intel.com>

On Fri, Oct 11, 2024 at 02:30:50PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_arch/x86/mm/pat/set_memory.c:#__cpa_process_fault" on:
> 
> commit: 6661cae1aa66d826b7ecd7044d0d76c66c015266 ("x86/module: enable ROX caches for module text")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 0cca97bf23640ff68a6e8a74e9b6659fdc27f48c]
> 
> in testcase: boot
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

It would have been nice if the report mentioned it was 32-bit kernel.

This patch disables ROX caches on 32-bit, it should fix the issue.

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index a0ec99fb9385..8ea2355f701a 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1065,20 +1065,30 @@ static void execmem_fill_trapping_insns(void *ptr, size_t size, bool writeable)
 struct execmem_info __init *execmem_arch_setup(void)
 {
 	unsigned long start, offset = 0;
+	enum execmem_range_flags flags;
+	pgprot_t pgprot;
 
 	if (kaslr_enabled())
 		offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
 
 	start = MODULES_VADDR + offset;
 
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		pgprot = PAGE_KERNEL_ROX;
+		flags = EXECMEM_KASAN_SHADOW | EXECMEM_ROX_CACHE;
+	} else {
+		pgprot = PAGE_KERNEL;
+		flags = EXECMEM_KASAN_SHADOW;
+	}
+
 	execmem_info = (struct execmem_info){
 		.fill_trapping_insns = execmem_fill_trapping_insns,
 		.ranges = {
 			[EXECMEM_MODULE_TEXT] = {
-				.flags	= EXECMEM_KASAN_SHADOW | EXECMEM_ROX_CACHE,
+				.flags	= flags,
 				.start	= start,
 				.end	= MODULES_END,
-				.pgprot	= PAGE_KERNEL_ROX,
+				.pgprot	= pgprot,
 				.alignment = MODULE_ALIGN,
 			},
 			[EXECMEM_KPROBES ... EXECMEM_BPF] = {
 
> +--------------------------------------------------------------+------------+------------+
> |                                                              | d44c348582 | 6661cae1aa |
> +--------------------------------------------------------------+------------+------------+
> | WARNING:at_arch/x86/mm/pat/set_memory.c:#__cpa_process_fault | 0          | 6          |
> | EIP:__cpa_process_fault                                      | 0          | 6          |
> +--------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202410111408.8fe6f604-lkp@intel.com
> 
> 
> [    8.158938][   T98] ------------[ cut here ]------------
> [    8.161035][   T98] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
> [ 8.163217][ T98] WARNING: CPU: 0 PID: 98 at arch/x86/mm/pat/set_memory.c:1620 __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
> [    8.166598][   T98] Modules linked in:
> [    8.167997][   T98] CPU: 0 UID: 0 PID: 98 Comm: udevd Not tainted 6.12.0-rc2-00142-g6661cae1aa66 #1
> [    8.170966][   T98] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 8.174383][ T98] EIP: __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
> [ 8.176288][ T98] Code: d8 51 89 f9 e8 39 fb ff ff 83 c4 0c 85 c0 0f 89 95 fe ff ff e9 60 fe ff ff 8b 03 ff 30 ff 75 e8 68 e0 05 ff c1 e8 7c a8 00 00 <0f> 0b c7 45 ec f2 ff ff ff 83 c4 0c e9 fb fc ff ff 8d 76 00 55 89
> All code
> ========
>    0:	d8 51 89             	fcoms  -0x77(%rcx)
>    3:	f9                   	stc
>    4:	e8 39 fb ff ff       	call   0xfffffffffffffb42
>    9:	83 c4 0c             	add    $0xc,%esp
>    c:	85 c0                	test   %eax,%eax
>    e:	0f 89 95 fe ff ff    	jns    0xfffffffffffffea9
>   14:	e9 60 fe ff ff       	jmp    0xfffffffffffffe79
>   19:	8b 03                	mov    (%rbx),%eax
>   1b:	ff 30                	push   (%rax)
>   1d:	ff 75 e8             	push   -0x18(%rbp)
>   20:	68 e0 05 ff c1       	push   $0xffffffffc1ff05e0
>   25:	e8 7c a8 00 00       	call   0xa8a6
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	c7 45 ec f2 ff ff ff 	movl   $0xfffffff2,-0x14(%rbp)
>   33:	83 c4 0c             	add    $0xc,%esp
>   36:	e9 fb fc ff ff       	jmp    0xfffffffffffffd36
>   3b:	8d 76 00             	lea    0x0(%rsi),%esi
>   3e:	55                   	push   %rbp
>   3f:	89                   	.byte 0x89
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	c7 45 ec f2 ff ff ff 	movl   $0xfffffff2,-0x14(%rbp)
>    9:	83 c4 0c             	add    $0xc,%esp
>    c:	e9 fb fc ff ff       	jmp    0xfffffffffffffd0c
>   11:	8d 76 00             	lea    0x0(%rsi),%esi
>   14:	55                   	push   %rbp
>   15:	89                   	.byte 0x89
> [    8.182574][   T98] EAX: 00000032 EBX: edb81db0 ECX: 0000021d EDX: 00000000
> [    8.185016][   T98] ESI: edb81d4a EDI: 00000000 EBP: edb81d30 ESP: edb81cf8
> [    8.187433][   T98] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010202
> [    8.190182][   T98] CR0: 80050033 CR2: b7c8e548 CR3: 2db88000 CR4: 00040690
> [    8.192564][   T98] Call Trace:
> [ 8.193877][ T98] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
> [ 8.195475][ T98] ? __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
> [ 8.197352][ T98] ? __warn (kernel/panic.c:748) 
> [ 8.198883][ T98] ? __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
> [ 8.200760][ T98] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
> [ 8.202456][ T98] ? __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
> [ 8.204259][ T98] ? exc_overflow (arch/x86/kernel/traps.c:301) 
> [ 8.205893][ T98] ? handle_bug (arch/x86/kernel/traps.c:260) 
> [ 8.207451][ T98] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
> [ 8.209215][ T98] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
> [ 8.210933][ T98] ? exc_overflow (arch/x86/kernel/traps.c:301) 
> [ 8.212585][ T98] ? __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
> [ 8.214504][ T98] ? exc_overflow (arch/x86/kernel/traps.c:301) 
> [ 8.216170][ T98] ? __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
> [ 8.218077][ T98] ? __change_page_attr_set_clr (arch/x86/mm/pat/set_memory.c:1808) 
> [ 8.220025][ T98] __change_page_attr (arch/x86/mm/pat/set_memory.c:1644) 
> [ 8.221883][ T98] __change_page_attr_set_clr (arch/x86/mm/pat/set_memory.c:1808) 
> [ 8.223837][ T98] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
> [ 8.225669][ T98] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 arch/x86/include/asm/irqflags.h:155 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
> [ 8.227684][ T98] ? page_address (mm/highmem.c:778) 
> [ 8.229415][ T98] set_direct_map_valid_noflush (arch/x86/mm/pat/set_memory.c:2453) 
> [ 8.231211][ T98] execmem_set_direct_map_valid (mm/execmem.c:53) 
> [ 8.233327][ T98] execmem_alloc (mm/execmem.c:263 mm/execmem.c:291 mm/execmem.c:335 mm/execmem.c:357) 
> [ 8.234958][ T98] move_module (kernel/module/main.c:1220 kernel/module/main.c:2291) 
> [ 8.236569][ T98] layout_and_allocate+0xe7/0x160 
> [ 8.238634][ T98] load_module (kernel/module/main.c:2955) 
> [ 8.240229][ T98] init_module_from_file (kernel/module/main.c:3262) 
> [ 8.242074][ T98] idempotent_init_module (kernel/module/main.c:3196 kernel/module/main.c:3274) 
> [ 8.243946][ T98] __ia32_sys_finit_module (include/linux/file.h:68 kernel/module/main.c:3301 kernel/module/main.c:3283 kernel/module/main.c:3283) 
> [ 8.245807][ T98] ia32_sys_call (arch/x86/entry/syscall_32.c:44) 
> [ 8.247342][ T98] do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:339) 
> [ 8.249008][ T98] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
> [    8.250662][   T98] EIP: 0xb7dc0222
> [ 8.252022][ T98] Code: 06 89 8a f0 02 00 00 c3 55 57 56 53 8b 6c 24 2c 8b 7c 24 28 8b 74 24 24 8b 54 24 20 8b 4c 24 1c 8b 5c 24 18 8b 44 24 14 cd 80 <5b> 5e 5f 5d 3d 01 f0 ff ff 0f 83 8f b5 f3 ff c3 66 90 66 90 66 90
> All code
> ========
>    0:	06                   	(bad)
>    1:	89 8a f0 02 00 00    	mov    %ecx,0x2f0(%rdx)
>    7:	c3                   	ret
>    8:	55                   	push   %rbp
>    9:	57                   	push   %rdi
>    a:	56                   	push   %rsi
>    b:	53                   	push   %rbx
>    c:	8b 6c 24 2c          	mov    0x2c(%rsp),%ebp
>   10:	8b 7c 24 28          	mov    0x28(%rsp),%edi
>   14:	8b 74 24 24          	mov    0x24(%rsp),%esi
>   18:	8b 54 24 20          	mov    0x20(%rsp),%edx
>   1c:	8b 4c 24 1c          	mov    0x1c(%rsp),%ecx
>   20:	8b 5c 24 18          	mov    0x18(%rsp),%ebx
>   24:	8b 44 24 14          	mov    0x14(%rsp),%eax
>   28:	cd 80                	int    $0x80
>   2a:*	5b                   	pop    %rbx		<-- trapping instruction
>   2b:	5e                   	pop    %rsi
>   2c:	5f                   	pop    %rdi
>   2d:	5d                   	pop    %rbp
>   2e:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
>   33:	0f 83 8f b5 f3 ff    	jae    0xfffffffffff3b5c8
>   39:	c3                   	ret
>   3a:	66 90                	xchg   %ax,%ax
>   3c:	66 90                	xchg   %ax,%ax
>   3e:	66 90                	xchg   %ax,%ax
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	5b                   	pop    %rbx
>    1:	5e                   	pop    %rsi
>    2:	5f                   	pop    %rdi
>    3:	5d                   	pop    %rbp
>    4:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
>    9:	0f 83 8f b5 f3 ff    	jae    0xfffffffffff3b59e
>    f:	c3                   	ret
>   10:	66 90                	xchg   %ax,%ax
>   12:	66 90                	xchg   %ax,%ax
>   14:	66 90                	xchg   %ax,%ax
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241011/202410111408.8fe6f604-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

-- 
Sincerely yours,
Mike.

