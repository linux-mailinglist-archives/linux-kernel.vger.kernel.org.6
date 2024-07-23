Return-Path: <linux-kernel+bounces-259543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E62939819
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81B11C219CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6C513A24A;
	Tue, 23 Jul 2024 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7Q+bZ9p"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F07EC2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721699911; cv=none; b=pAg7lnU5zciNlx+BMC6svHieyybKHxUnRWZTpPqZt71Z/ZVEM4jDBCiGG+yUsfgJd+pNTv02VGbeXeESsTR0juw2sWSzXmyk15f6k5ZKBQFV8aUESdJiRLrz0igro99Vg7g4nP2rupFEGm5g3ZvgomMCUlOZn1tJYS+vKLm/BHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721699911; c=relaxed/simple;
	bh=WJwC5qh5wy/FRLTMz7TMy7yzxlOo/8ztGPQRWt+ug2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ips0ZTCpqiKqfAG8GTMfo9nRveYISMInTFNrCm16gwTGL7KIGNDzb1KvEo/CbsyVuLJ+wx2nk3CLybAdphy762tM9NDZVm2ONmgTrLkDh0J0PdyIwJJtEfNOEkp/wdZa5fyKzbSHYL7M4IAzTvzvr3UAG5H+39KoHbYSGnMqawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7Q+bZ9p; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e05eccfcdb3so4643001276.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721699909; x=1722304709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1FL16yC/5cLD7+pYmKefDxXMFl0UGnDZKblvc9Ca7s=;
        b=m7Q+bZ9pm1ED7rfd0p47RzYiGWmDC4xU8clUsNtnduB9aRMgNlDCdaEpf0teZnmwSe
         i047qC9Jb7UqD5xCzDv4Ez6DxeQq0mpMLFm9lSV3R1BaW00px4c5JBJOm8WBpyuHdLO4
         SKAzLQsAVU6sF8uXcy8+DAENCorCdreHh4ScuMJzZfG+YND1fuFipAQv7pdgdUtKwj7j
         6D97kIb/nVs6Rg+0XAqxotd4oGUT+RcxVE54bKPKBTV8v1t0+nXMEEO8YF2sqbZxrxiM
         BeYUxNNfLs2aw6/UWyJH3xpdWHREcl2y62yKSkb41B97AydPt46pAHBiuOqrDrpsxh0h
         eAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721699909; x=1722304709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1FL16yC/5cLD7+pYmKefDxXMFl0UGnDZKblvc9Ca7s=;
        b=Je3RtDJwAFRuWZo86AxwF2sJVDyZgWRX3gSW0jufa6g06vKYbRXnXobLi0eyatzDsy
         Ni2j6/ngbJqYb6BV0htEvS0cWoWpizNwOMr4Ke+1mNBFRZ3dUkaZ/b8lORXBRWFYHHn1
         EzpE531q/4EGj8+Q08eXVD2ihry1vTYBlpSSoMrlibX1tlckyClfoRdDvq+fOwN8bC8r
         qUTHnK+J9U9n9Jb5fSsZ5WNNkyeK5IvigUWUCsHjBPZaAzydjaZ5A2tBSy4K+PYrm8FY
         YG2xgYb+lPwMJE5IBTOjWvZE/fnV6RdXESbgSYfXQ3/YGqrjA5xT9Z3lZO0BeTtJHpWm
         W2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzfDsO/M3TQwIfbHi1z2ctcz8upruodZDNY+N/TV6JLy/FQikXCE7hWgZ5RKvR2M+mNcXo01XTZtUgRyOujmaVNKUM1r/1jvMrjx4B
X-Gm-Message-State: AOJu0YyPjXrevg90d1tr2TvdDULFPsaA91j3b1FZJbvqR99Bu6S0arV6
	RSQ7sFj/WszNV6SXYGLXXlbx69yvBUr1sPXI9vx0aCWZ+lIVPqSB
X-Google-Smtp-Source: AGHT+IG46eYkI+AJi5EnaT4MbvIAjMxOa+EkQuy6Zb1VYmuq8JdjtpvC+WQwCqPQPphxxsCp1xDYgg==
X-Received: by 2002:a05:6902:f83:b0:e03:4c64:c814 with SMTP id 3f1490d57ef6-e087b327b50mr8640202276.22.1721699908942;
        Mon, 22 Jul 2024 18:58:28 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a2ab2e353csm2167510a12.55.2024.07.22.18.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 18:58:28 -0700 (PDT)
Message-ID: <a634bf58-9195-4c6f-b3d8-468d47e71033@gmail.com>
Date: Tue, 23 Jul 2024 09:58:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [alexshi:mmunstable2] 934c05f8c5:
 BUG:unable_to_handle_page_fault_for_address
To: kernel test robot <oliver.sang@intel.com>, Alex Shi <alexs@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <202407221607.49138a71-oliver.sang@intel.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <202407221607.49138a71-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/24 9:05 AM, kernel test robot wrote:
> 
> hi, Alex Shi,
> 
> we noticed there is a mmunstable3 branch now, but there is no same title patch
> there. not sure if this report is still useful, below report just FYI.

Hi Oliver,

Thanks a lot for your testing and founding on my unreleased code branch!
The problem should be resolved on my latest code yesterday.
But multiple archs maybe still are fragile in the branch. Are there bootable in virtual machine, like arm, s390, etc?

Thanks again for your great work!

Alex

> 
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:
> 
> commit: 934c05f8c50fed91942a8aa9db46a0feae38594c ("use ptdesc in free_pte_range and pte_free_tlb series functions")
> https://github.com/alexshi/linux.git mmunstable2
> 
> in testcase: boot
> 
> compiler: gcc-11
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +---------------------------------------------+------------+------------+
> |                                             | 5977eb9785 | 934c05f8c5 |
> +---------------------------------------------+------------+------------+
> | BUG:unable_to_handle_page_fault_for_address | 0          | 6          |
> | EIP:clear_user                              | 0          | 6          |
> +---------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202407221607.49138a71-oliver.sang@intel.com
> 
> 
> [    3.645340][    T1] BUG: unable to handle page fault for address: 00100016
> [    3.645713][    T1] #PF: supervisor read access in kernel mode
> [    3.646020][    T1] #PF: error_code(0x0000) - not-present page
> [    3.646326][    T1] *pdpt = 000000002e992001 *pde = 0000000000000000
> [    3.646663][    T1] Oops: Oops: 0000 [#1] PREEMPT SMP
> [    3.646933][    T1] CPU: 0 PID: 1 Comm: init Not tainted 6.10.0-rc6-00481-g934c05f8c50f #1 c5190225c17d1f7c5bcc60b13088ed2c9e32ac25
> [ 3.647536][ T1] EIP: __lock_acquire (kernel/locking/lockdep.c:5006 (discriminator 1)) 
> [ 3.647797][ T1] Code: 8b 75 d0 e8 d8 9b 3c 00 85 c0 0f 85 a0 01 00 00 31 db 83 c4 38 89 d8 5b 5e 5f 5d 31 d2 31 c9 e9 60 6d be 01 8d 74 26 00 31 c0 <81> 3b a0 cb 44 c4 0f 45 45 0c 83 fa 01 89 45 f0 0f 87 10 fb ff ff
> All code
> ========
>    0:	8b 75 d0             	mov    -0x30(%rbp),%esi
>    3:	e8 d8 9b 3c 00       	call   0x3c9be0
>    8:	85 c0                	test   %eax,%eax
>    a:	0f 85 a0 01 00 00    	jne    0x1b0
>   10:	31 db                	xor    %ebx,%ebx
>   12:	83 c4 38             	add    $0x38,%esp
>   15:	89 d8                	mov    %ebx,%eax
>   17:	5b                   	pop    %rbx
>   18:	5e                   	pop    %rsi
>   19:	5f                   	pop    %rdi
>   1a:	5d                   	pop    %rbp
>   1b:	31 d2                	xor    %edx,%edx
>   1d:	31 c9                	xor    %ecx,%ecx
>   1f:	e9 60 6d be 01       	jmp    0x1be6d84
>   24:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>   28:	31 c0                	xor    %eax,%eax
>   2a:*	81 3b a0 cb 44 c4    	cmpl   $0xc444cba0,(%rbx)		<-- trapping instruction
>   30:	0f 45 45 0c          	cmovne 0xc(%rbp),%eax
>   34:	83 fa 01             	cmp    $0x1,%edx
>   37:	89 45 f0             	mov    %eax,-0x10(%rbp)
>   3a:	0f 87 10 fb ff ff    	ja     0xfffffffffffffb50
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	81 3b a0 cb 44 c4    	cmpl   $0xc444cba0,(%rbx)
>    6:	0f 45 45 0c          	cmovne 0xc(%rbp),%eax
>    a:	83 fa 01             	cmp    $0x1,%edx
>    d:	89 45 f0             	mov    %eax,-0x10(%rbp)
>   10:	0f 87 10 fb ff ff    	ja     0xfffffffffffffb26
> [    3.648776][    T1] EAX: 00000000 EBX: 00100016 ECX: 00000000 EDX: 00000000
> [    3.649136][    T1] ESI: 00100016 EDI: 00000000 EBP: c01f1b7c ESP: c01f1b38
> [    3.649504][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010046
> [    3.649890][    T1] CR0: 80050033 CR2: 00100016 CR3: 0054bd80 CR4: 000406b0
> [    3.650252][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    3.650611][    T1] DR6: fffe0ff0 DR7: 00000400
> [    3.650863][    T1] Call Trace:
> [ 3.651036][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
> [ 3.651256][ T1] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
> [ 3.651457][ T1] ? oops_enter (kernel/panic.c:642) 
> [ 3.651680][ T1] ? page_fault_oops (arch/x86/mm/fault.c:715) 
> [ 3.651927][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5137) 
> [ 3.652177][ T1] ? kernelmode_fixup_or_oops+0x68/0x8c 
> [ 3.652513][ T1] ? __bad_area_nosemaphore+0x133/0x238 
> [ 3.652850][ T1] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835) 
> [ 3.653116][ T1] ? do_user_addr_fault (arch/x86/mm/fault.c:1452) 
> [ 3.653389][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359) 
> [ 3.653693][ T1] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
> [ 3.653952][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
> [ 3.654265][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
> [ 3.654524][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
> [ 3.654838][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5006 (discriminator 1)) 
> [ 3.655087][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
> [ 3.655400][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5006 (discriminator 1)) 
> [ 3.655650][ T1] ? register_lock_class (kernel/locking/lockdep.c:1285 (discriminator 13)) 
> [ 3.655916][ T1] ? filemap_get_entry (include/linux/rcupdate.h:339 include/linux/rcupdate.h:812 mm/filemap.c:1858) 
> [ 3.656179][ T1] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756) 
> [ 3.656408][ T1] ? pmd_install (mm/memory.c:424) 
> [ 3.656638][ T1] ? slow_virt_to_phys (arch/x86/mm/pat/set_memory.c:811) 
> [ 3.656896][ T1] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
> [ 3.657130][ T1] ? pmd_install (mm/memory.c:424) 
> [ 3.657451][ T1] pmd_install (mm/memory.c:424) 
> [ 3.657669][ T1] finish_fault (mm/memory.c:4870) 
> [ 3.657902][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63 (discriminator 13)) 
> [ 3.658156][ T1] do_pte_missing (mm/memory.c:5100 mm/memory.c:5193 mm/memory.c:3947) 
> [ 3.658398][ T1] handle_pte_fault (mm/memory.c:5522) 
> [ 3.658647][ T1] ? __lock_release+0x4f/0x17c 
> [ 3.658921][ T1] __handle_mm_fault (mm/memory.c:5666) 
> [ 3.659174][ T1] ? mt_find (lib/maple_tree.c:6952) 
> [ 3.659394][ T1] ? __handle_mm_fault (mm/memory.c:5800) 
> [ 3.659656][ T1] handle_mm_fault (mm/memory.c:5745 mm/memory.c:5832) 
> [ 3.659897][ T1] ? lock_mm_and_find_vma (mm/memory.c:5921) 
> [ 3.660167][ T1] do_user_addr_fault (include/linux/sched/signal.h:425 arch/x86/mm/fault.c:1391) 
> [ 3.660426][ T1] exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
> [ 3.660663][ T1] ? find_held_lock (kernel/locking/lockdep.c:5244) 
> [ 3.660905][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
> [ 3.661221][ T1] handle_exception (arch/x86/entry/entry_32.S:1054) 
> [ 3.661478][ T1] EIP: clear_user (arch/x86/lib/usercopy_32.c:66) 
> [ 3.661712][ T1] Code: 34 b8 00 00 00 c0 29 d8 39 c7 77 29 ba 42 00 00 00 b8 63 1d 95 c3 e8 fe 6f 5c fe 89 da 31 c0 c1 eb 02 83 e2 03 89 d9 8d 76 00 <f3> ab 89 d1 f3 aa 8d 76 00 89 cb 89 d8 5b 5f 5d 31 d2 31 c9 e9 4a
> All code
> ========
>    0:	34 b8                	xor    $0xb8,%al
>    2:	00 00                	add    %al,(%rax)
>    4:	00 c0                	add    %al,%al
>    6:	29 d8                	sub    %ebx,%eax
>    8:	39 c7                	cmp    %eax,%edi
>    a:	77 29                	ja     0x35
>    c:	ba 42 00 00 00       	mov    $0x42,%edx
>   11:	b8 63 1d 95 c3       	mov    $0xc3951d63,%eax
>   16:	e8 fe 6f 5c fe       	call   0xfffffffffe5c7019
>   1b:	89 da                	mov    %ebx,%edx
>   1d:	31 c0                	xor    %eax,%eax
>   1f:	c1 eb 02             	shr    $0x2,%ebx
>   22:	83 e2 03             	and    $0x3,%edx
>   25:	89 d9                	mov    %ebx,%ecx
>   27:	8d 76 00             	lea    0x0(%rsi),%esi
>   2a:*	f3 ab                	rep stos %eax,%es:(%rdi)		<-- trapping instruction
>   2c:	89 d1                	mov    %edx,%ecx
>   2e:	f3 aa                	rep stos %al,%es:(%rdi)
>   30:	8d 76 00             	lea    0x0(%rsi),%esi
>   33:	89 cb                	mov    %ecx,%ebx
>   35:	89 d8                	mov    %ebx,%eax
>   37:	5b                   	pop    %rbx
>   38:	5f                   	pop    %rdi
>   39:	5d                   	pop    %rbp
>   3a:	31 d2                	xor    %edx,%edx
>   3c:	31 c9                	xor    %ecx,%ecx
>   3e:	e9                   	.byte 0xe9
>   3f:	4a                   	rex.WX
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	f3 ab                	rep stos %eax,%es:(%rdi)
>    2:	89 d1                	mov    %edx,%ecx
>    4:	f3 aa                	rep stos %al,%es:(%rdi)
>    6:	8d 76 00             	lea    0x0(%rsi),%esi
>    9:	89 cb                	mov    %ecx,%ebx
>    b:	89 d8                	mov    %ebx,%eax
>    d:	5b                   	pop    %rbx
>    e:	5f                   	pop    %rdi
>    f:	5d                   	pop    %rbp
>   10:	31 d2                	xor    %edx,%edx
>   12:	31 c9                	xor    %ecx,%ecx
>   14:	e9                   	.byte 0xe9
>   15:	4a                   	rex.WX
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240722/202407221607.49138a71-oliver.sang@intel.com
> 
> 
> 

