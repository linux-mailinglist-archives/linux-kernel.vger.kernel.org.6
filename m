Return-Path: <linux-kernel+bounces-208906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AAB902A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5607C1C22E10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63E850289;
	Mon, 10 Jun 2024 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi6Qgmzc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EB1879
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054033; cv=none; b=JnN1VxoCw3OL7zSlzfmelau9rhgxvZRBVqM1N0bgbA53wAbZDnPziXhMnnm9AjAMtkzMu/0kkHm9JQWrGSBzIKVamaSlYdJbZvBcB8WO2JzYZ8aPhPrBB/Y39a+jh9k5qrwwWrkB6ijqjzUiyJ4XGF8QBOuT1ClZlSvY8CyoL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054033; c=relaxed/simple;
	bh=uLLOWbGzkYJa/5ueKKs2Rflht3VwAfI/HmVMCbLohSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th165A+6eHoxf39mnATv0D3TFWbzRF38DV4ET1EfPSv9Ol4TGynkEVkk152iD0KfhhIiJE6zzkFN3l031jRxTykfy7DCdv/Hpp2N4grT5B/YjHK4VadzdFnchpyu/5fXLKn16823KudYbNdn75c0tSdLsHSeoDfniWB2jCIjjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi6Qgmzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438CCC2BBFC;
	Mon, 10 Jun 2024 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718054033;
	bh=uLLOWbGzkYJa/5ueKKs2Rflht3VwAfI/HmVMCbLohSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hi6Qgmzceo7QwVsu2iTcigbMjLujwb6T0IqzpgCEgFv+pVLBUY4h8SRpDlqoIqEEH
	 +C1RLz+noGt4rTKimAVkfAEcYx0KRabFujlVvKMbNds7rX0WfT4I+4sa2zeSzFKfz6
	 u95V3aJ+WOFlJNPRVnZQHuOrbqO+yx3v2AYKd7V37yZqc9jXcw4k6JsetSazRrCCHc
	 9MOj1x8+8ZV9A/1ohV9AD3IUy22ih+lKuIT5nsL1X8SEjjCziVvqc7bHa6Qe1HVuMm
	 pH5Jgcoav2hsBkutl7Wpeao6BBLomClMva3RRwB1SDqztvdsKf5cRLaltH8iCG4ZNR
	 v2nnVwWRbPQpA==
Date: Mon, 10 Jun 2024 14:13:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 3/9] x86/fpu: Make task_struct::thread constant size
Message-ID: <20240610211350.GA1613053@thelio-3990X>
References: <20240608073134.264210-1-mingo@kernel.org>
 <20240608073134.264210-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608073134.264210-4-mingo@kernel.org>

Hi Ingo,

On Sat, Jun 08, 2024 at 09:31:28AM +0200, Ingo Molnar wrote:
> Turn thread.fpu into a pointer. Since most FPU code internals work by passing
> around the FPU pointer already, the code generation impact is small.
> 
> This allows us to remove the old kludge of task_struct being variable size:
> 
>   struct task_struct {
> 
>        ...
>        /*
>         * New fields for task_struct should be added above here, so that
>         * they are included in the randomized portion of task_struct.
>         */
>        randomized_struct_fields_end
> 
>        /* CPU-specific state of this task: */
>        struct thread_struct            thread;
> 
>        /*
>         * WARNING: on x86, 'thread_struct' contains a variable-sized
>         * structure.  It *MUST* be at the end of 'task_struct'.
>         *
>         * Do not put anything below here!
>         */
>   };
> 
> ... which creates a number of problems, such as requiring thread_struct to be
> the last member of the struct - not allowing it to be struct-randomized, etc.
> 
> But the primary motivation is to allow the decoupling of task_struct from
> hardware details (<asm/processor.h> in particular), and to eventually allow
> the per-task infrastructure:
> 
>    DECLARE_PER_TASK(type, name);
>    ...
>    per_task(current, name) = val;
> 
> ... which requires task_struct to be a constant size struct.
> 
> The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
> now that the FPU structure is not embedded in the task struct anymore, which
> reduces text footprint a bit.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Link: https://lore.kernel.org/r/20240605083557.2051480-2-mingo@kernel.org
> ---
>  arch/x86/include/asm/processor.h | 20 +++++++++-----------
>  arch/x86/kernel/fpu/core.c       | 23 ++++++++++++-----------
>  arch/x86/kernel/fpu/init.c       | 19 ++++++++++++-------
>  arch/x86/kernel/process.c        |  2 +-
>  include/linux/sched.h            | 13 +++----------
>  5 files changed, 37 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 35aa8f652964..64509c7f26c8 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -504,21 +504,19 @@ struct thread_struct {
>  #endif
>  
>  	/* Floating point and extended processor state */
> -	struct fpu		fpu;
> -	/*
> -	 * WARNING: 'fpu' is dynamically-sized.  It *MUST* be at
> -	 * the end.
> -	 */
> +	struct fpu		*fpu;
>  };
>  
> -#define x86_task_fpu(task) (&(task)->thread.fpu)
> +#define x86_task_fpu(task) ((task)->thread.fpu)
>  
> -extern void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size);
> -
> -static inline void arch_thread_struct_whitelist(unsigned long *offset,
> -						unsigned long *size)
> +/*
> + * X86 doesn't need any embedded-FPU-struct quirks:
> + */
> +static inline void
> +arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
>  {
> -	fpu_thread_struct_whitelist(offset, size);
> +	*offset = 0;
> +	*size = 0;
>  }
>  
>  static inline void
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index ca6745f8ac2a..f0c4367804b3 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -584,8 +584,19 @@ static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
>  int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
>  	      unsigned long ssp)
>  {
> +	/*
> +	 * We allocate the new FPU structure right after the end of the task struct.
> +	 * task allocation size already took this into account.
> +	 *
> +	 * This is safe because task_struct size is a multiple of cacheline size.
> +	 */
>  	struct fpu *src_fpu = x86_task_fpu(current);
> -	struct fpu *dst_fpu = x86_task_fpu(dst);
> +	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
> +
> +	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
> +	BUG_ON(!src_fpu);
> +
> +	dst->thread.fpu = dst_fpu;
>  
>  	/* The new task's FPU state cannot be valid in the hardware. */
>  	dst_fpu->last_cpu = -1;
> @@ -654,16 +665,6 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
>  	return 0;
>  }
>  
> -/*
> - * Whitelist the FPU register state embedded into task_struct for hardened
> - * usercopy.
> - */
> -void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
> -{
> -	*offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
> -	*size = fpu_kernel_cfg.default_size;
> -}
> -
>  /*
>   * Drops current FPU state: deactivates the fpregs and
>   * the fpstate. NOTE: it still leaves previous contents
> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> index ad5cb2943d37..4e8d37b5a90b 100644
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -71,8 +71,17 @@ static bool __init fpu__probe_without_cpuid(void)
>  	return fsw == 0 && (fcw & 0x103f) == 0x003f;
>  }
>  
> +static struct fpu x86_init_fpu __read_mostly;
> +
>  static void __init fpu__init_system_early_generic(void)
>  {
> +	int this_cpu = smp_processor_id();
> +
> +	fpstate_reset(&x86_init_fpu);
> +	current->thread.fpu = &x86_init_fpu;
> +	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
> +	x86_init_fpu.last_cpu = this_cpu;
> +
>  	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
>  	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
>  		if (fpu__probe_without_cpuid())
> @@ -150,6 +159,8 @@ static void __init fpu__init_task_struct_size(void)
>  {
>  	int task_size = sizeof(struct task_struct);
>  
> +	task_size += sizeof(struct fpu);
> +
>  	/*
>  	 * Subtract off the static size of the register state.
>  	 * It potentially has a bunch of padding.
> @@ -164,14 +175,9 @@ static void __init fpu__init_task_struct_size(void)
>  
>  	/*
>  	 * We dynamically size 'struct fpu', so we require that
> -	 * it be at the end of 'thread_struct' and that
> -	 * 'thread_struct' be at the end of 'task_struct'.  If
> -	 * you hit a compile error here, check the structure to
> -	 * see if something got added to the end.
> +	 * 'state' be at the end of 'it:
>  	 */
>  	CHECK_MEMBER_AT_END_OF(struct fpu, __fpstate);
> -	CHECK_MEMBER_AT_END_OF(struct thread_struct, fpu);
> -	CHECK_MEMBER_AT_END_OF(struct task_struct, thread);
>  
>  	arch_task_struct_size = task_size;
>  }
> @@ -213,7 +219,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
>   */
>  void __init fpu__init_system(void)
>  {
> -	fpstate_reset(x86_task_fpu(current));
>  	fpu__init_system_early_generic();
>  
>  	/*
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index adfeefd6375a..5bb73bc0e31a 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -97,7 +97,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  	dst->thread.vm86 = NULL;
>  #endif
>  	/* Drop the copied pointer to current's fpstate */
> -	x86_task_fpu(dst)->fpstate = NULL;
> +	dst->thread.fpu = NULL;
>  
>  	return 0;
>  }
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 61591ac6eab6..215a7380e41c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1554,21 +1554,14 @@ struct task_struct {
>  	struct user_event_mm		*user_event_mm;
>  #endif
>  
> +	/* CPU-specific state of this task: */
> +	struct thread_struct		thread;
> +
>  	/*
>  	 * New fields for task_struct should be added above here, so that
>  	 * they are included in the randomized portion of task_struct.
>  	 */
>  	randomized_struct_fields_end
> -
> -	/* CPU-specific state of this task: */
> -	struct thread_struct		thread;
> -
> -	/*
> -	 * WARNING: on x86, 'thread_struct' contains a variable-sized
> -	 * structure.  It *MUST* be at the end of 'task_struct'.
> -	 *
> -	 * Do not put anything below here!
> -	 */
>  };
>  
>  #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
> -- 
> 2.43.0
> 

I am seeing a crash with this change in -next as
commit 018d456409d6 ("x86/fpu: Make task_struct::thread constant size")
and I still see it in WIP.x86/fpu from commit 4f4a9b399357 ("x86/fpu:
Make task_struct::thread constant size").

$ make -skj"$(nproc)" ARCH=i386 CROSS_COMPILE=i386-linux- defconfig bzImage

$ qemu-system-i386 \
    -display none \
    -nodefaults \
    -M q35 \
    -d unimp,guest_errors \
    -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
    -kernel arch/x86/boot/bzImage \
    -initrd rootfs.cpio \
    -cpu host \
    -enable-kvm \
    -m 512m \
    -smp 8 \
    -serial mon:stdio
[    0.000000] Linux version 6.10.0-rc2-00003-g4f4a9b399357 (nathan@thelio-3990X) (i386-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Mon Jun 10 13:58:20 MST 2024
...
[    0.337514] ------------[ cut here ]------------
[    0.338184] Bad FPU state detected at restore_fpregs_from_fpstate+0x38/0x6c, reinitializing FPU registers.
[    0.338195] WARNING: CPU: 2 PID: 100 at arch/x86/mm/extable.c:127 fixup_exception+0x41e/0x45c
[    0.340506] Modules linked in:
[    0.340905] CPU: 2 PID: 100 Comm: modprobe Not tainted 6.10.0-rc2-00003-g4f4a9b399357 #1
[    0.341939] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    0.343363] EIP: fixup_exception+0x41e/0x45c
[    0.343916] Code: e8 cb c0 00 00 0f 0b eb cb 0f 0b ba 4c e9 7f da eb b6 b2 01 88 15 16 bf 6c da 89 44 24 04 c7 04 24 18 39 3b da e8 a6 c0 00 00 <0f> 0b e9 ee fd ff ff 8d b4 26 00 00 00 00 0f 0b ba 4c e9 7f da e9
[    0.346288] EAX: 0000005e EBX: da4e53f0 ECX: 00000000 EDX: da5d606c
[    0.347082] ESI: c1ba5ef0 EDI: 0000000d EBP: c1ba5e58 ESP: c1ba5dd8
[    0.347882] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010086
[    0.348744] CR0: 80050033 CR2: bfe4afcb CR3: 012f5000 CR4: 00350ed0
[    0.349540] Call Trace:
[    0.349855]  ? show_regs+0x4d/0x54
[    0.350300]  ? fixup_exception+0x41e/0x45c
[    0.350828]  ? __warn+0x84/0x150
[    0.351242]  ? fixup_exception+0x41e/0x45c
[    0.351765]  ? fixup_exception+0x41e/0x45c
[    0.352289]  ? report_bug+0x186/0x1b0
[    0.352756]  ? exc_overflow+0x50/0x50
[    0.353230]  ? handle_bug+0x2d/0x50
[    0.353675]  ? exc_invalid_op+0x1b/0x70
[    0.354171]  ? console_unlock+0x53/0xc4
[    0.354658]  ? handle_exception+0x14b/0x14b
[    0.355196]  ? exc_overflow+0x50/0x50
[    0.355663]  ? fixup_exception+0x41e/0x45c
[    0.356184]  ? exc_overflow+0x50/0x50
[    0.356651]  ? fixup_exception+0x41e/0x45c
[    0.357172]  ? restore_fpregs_from_fpstate+0x38/0x6c
[    0.357809]  ? _get_random_bytes+0x65/0x190
[    0.358341]  ? mt_find+0xd1/0x458
[    0.358766]  ? exc_bounds+0xac/0xac
[    0.359213]  exc_general_protection+0x97/0x358
[    0.359775]  ? randomize_page+0x37/0x54
[    0.360271]  ? exc_bounds+0xac/0xac
[    0.360722]  handle_exception+0x14b/0x14b
[    0.361232] EIP: restore_fpregs_from_fpstate+0x38/0x6c
[    0.361885] Code: 7d fc 89 ca eb 09 cc cc cc db e2 0f 77 db 03 3e 8d 74 26 00 8b 3d ec 31 46 da 8b 0d e8 31 46 da 21 fa 8d 7b 40 21 c8 0f c7 1f <8b> 5d f8 8b 7d fc 89 ec 5d c3 66 90 3e 8d 74 26 00 0f ae 4b 40 8b
[    0.364284] EAX: 00000007 EBX: c1a73860 ECX: 00000007 EDX: 00000000
[    0.365077] ESI: c1a73820 EDI: c1a738a0 EBP: c1ba5f54 ESP: c1ba5f4c
[    0.365870] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
[    0.366728]  ? exc_bounds+0xac/0xac
[    0.367171]  ? exc_bounds+0xac/0xac
[    0.367621]  ? restore_fpregs_from_fpstate+0x35/0x6c
[    0.368255]  switch_fpu_return+0x49/0xd0
[    0.368756]  syscall_exit_to_user_mode+0x181/0x1a8
[    0.369364]  ? call_usermodehelper_exec_async+0xbe/0x1ac
[    0.370040]  ? call_usermodehelper+0x8c/0x8c
[    0.370586]  ret_from_fork+0x23/0x44
[    0.371048]  ? call_usermodehelper+0x8c/0x8c
[    0.371592]  ret_from_fork_asm+0x12/0x18
[    0.372092]  entry_INT80_32+0x108/0x108
[    0.372581] EIP: 0xb7f77087
[    0.372941] Code: Unable to access opcode bytes at 0xb7f7705d.
[    0.373679] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[    0.374477] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bfe4aed0
[    0.375271] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000200
[    0.376134] ---[ end trace 0000000000000000 ]---
...

The rootfs is from [1] if you should need it (x86-rootfs.cpio.zst,
decompress with zstd first). I am more than happy to provide any
additional information or test patches as necessary.

[1]: https://github.com/ClangBuiltLinux/boot-utils/releases

Cheers,
Nathan

# bad: [d35b2284e966c0bef3e2182a5c5ea02177dd32e4] Add linux-next specific files for 20240607
# good: [8a92980606e3585d72d510a03b59906e96755b8a] Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect start 'd35b2284e966c0bef3e2182a5c5ea02177dd32e4' '8a92980606e3585d72d510a03b59906e96755b8a'
# good: [faef37a085e57f29479f853624948cdc7df6e366] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect good faef37a085e57f29479f853624948cdc7df6e366
# good: [822946749b5f02d9f49dde4b4cb8f2535c247ce5] Merge branch 'drm-xe-next' of https://gitlab.freedesktop.org/drm/xe/kernel
git bisect good 822946749b5f02d9f49dde4b4cb8f2535c247ce5
# bad: [9ffebdc86bc23fdf0622eb0c38d395c2b99b7f32] Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
git bisect bad 9ffebdc86bc23fdf0622eb0c38d395c2b99b7f32
# good: [9a85e49be89a9150fd2ec9964f48013a00c261d1] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good 9a85e49be89a9150fd2ec9964f48013a00c261d1
# bad: [0435675ef6ba0b3e14859bd4c6edb0d81093d28e] Merge branch 'edac-for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
git bisect bad 0435675ef6ba0b3e14859bd4c6edb0d81093d28e
# bad: [8f4652aac08030f2d5110be87229ad0f15c33496] Merge branch into tip/master: 'timers/core'
git bisect bad 8f4652aac08030f2d5110be87229ad0f15c33496
# bad: [0724c2b228bef4ea71cf5be0ab64de1065e32299] Merge branch into tip/master: 'irq/core'
git bisect bad 0724c2b228bef4ea71cf5be0ab64de1065e32299
# good: [51d8bfbcae9aeedee48cddefe6776c96acb2d83e] Merge branch into tip/master: 'x86/urgent'
git bisect good 51d8bfbcae9aeedee48cddefe6776c96acb2d83e
# bad: [80b691d02d005beafcd120a3b92c951155db543a] x86/fpu: Use 'fpstate' variable names consistently
git bisect bad 80b691d02d005beafcd120a3b92c951155db543a
# bad: [eb6428fd2eb4f72c735ba6fddd62147ac8d544c2] x86/fpu: Remove the thread::fpu pointer
git bisect bad eb6428fd2eb4f72c735ba6fddd62147ac8d544c2
# bad: [7329f3c69f07a502eb2ab5a6b4d27cd6a067579b] x86/fpu: Introduce the x86_task_fpu() helper method
git bisect bad 7329f3c69f07a502eb2ab5a6b4d27cd6a067579b
# bad: [018d456409d6c9ef4046eb5db95ce357acfeba23] x86/fpu: Make task_struct::thread constant size
git bisect bad 018d456409d6c9ef4046eb5db95ce357acfeba23
# first bad commit: [018d456409d6c9ef4046eb5db95ce357acfeba23] x86/fpu: Make task_struct::thread constant size

