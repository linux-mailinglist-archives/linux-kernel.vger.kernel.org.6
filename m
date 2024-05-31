Return-Path: <linux-kernel+bounces-197195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDF68D6746
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FFC1C22739
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98B16F904;
	Fri, 31 May 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNpL/sBF"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC61422DF
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174265; cv=none; b=J8FAJZNK3g/omgfEFqBFuNaPoe7cwCV+fGWx/c/Uy+o8dxW/O8wDHRoYTALDmfCPQvKe+m9tvAbYz0tRQgmxsKAWtuzdNq2bXmUNrVI6pucC22eevaGc529icjVXlZI48M9PABt8UfPDMb4bSjKEJeKGywcmQuEoSRc+EtcA2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174265; c=relaxed/simple;
	bh=zFDlnUOABzbm0Y8IJoia/HMlDqx62L8DjNoj5BXjoIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fr8s1DsZw2YY6H00cyymVqSLaFnWg++SXx1z78dgPTK7rk7VnmvRLb7L9fqpsN+GMIrTqsJ6oIzTefv9Zte784g4NV30gWgb2nGp9zAaJ+0CZc0JmPKsRdi7O4RgpXtQtXJZLudpzd/3562Zg6puVcdZuyOoGYhh0LiyBctzvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNpL/sBF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b7ebb2668so2785278e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717174261; x=1717779061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTdBaIoL0Lzn6UKudMwOpLD6UeAtQ4Fc8a6qF5F/gao=;
        b=DNpL/sBFcVr7rtLI1bGb7qEw5MhRancKCEKl1qA724xFfwwEiRZ2mzA9epmin7Dl5v
         6PigpPoqzntcK9TxPYhp+VEctm3NXPC537nHGa2hwwAxjB4Xkn6Sg8Y+wcKuAAskC1Mj
         VDxkp7Ymbwtw9fz/WziV4HQeaGy14eW27o2qHQ3VtnOUlkN3FHVnpwEUYCI42TMM6p4G
         C3G0BWzNzauX/N2Qo0XG8U4iF1QlZI3JEWbRcsVsuCq6sMVYJDm1PnTfEhAPXAP2xw+G
         V3eWe43I0kyUeJasgSydLnDcTjmPh6Qde8kNCSr3B8MdsHu4nP/YOxDfRUPkDkqfLFCJ
         52nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717174261; x=1717779061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTdBaIoL0Lzn6UKudMwOpLD6UeAtQ4Fc8a6qF5F/gao=;
        b=l9BFbCVPmwuq6lBhOwFW01FZfT+Nz9Kq48qWOo+TlhgmR0th4J16eFM64P8WcQZjJ4
         wyLbtH8x0PMWyXKLiXXSN+HOVgBS3Fg3diEgKmenAyNx+u3/p9galyZauqxnLCBmDRNd
         h7m2azLNNsSktN2ekj3JO5HF8pGRuWsR0fAfQGcg07MXf7oqYJSQDs5OMS5QbrrqFaN8
         Cp+5FyeNFda9CEQDkQEI9xy79usXMF7Mqz1Sq7Nnl4AImEA4Zq37C8tjOztuWPUUNuzR
         2dDDnMV4FOxJh6qKL5H1da7Vs4Wckhz2I3dXLhayhlQzUnZMRtbQNBniaouxJH473ayt
         dBGA==
X-Forwarded-Encrypted: i=1; AJvYcCXMSVuR14VmYq9jJlrwJcX624bzMZoFv+V+HmvEZcKtNwMetnY33MRoyREOXFfWH9TQd/xRUUsNmbcE8poykci6XB2pNqXw2Y7AZgZE
X-Gm-Message-State: AOJu0YwGv5MJuZ+qgAQOUJf7MJ6u35INBvdNQPE20ZickgThY+v/idfv
	y0pm7rbgWZm57KA+ZAYYY8QtmX8JYls1vhBJtxeXaqpc6bdth3sXZc7MCy52Xgaocn/aUSOdCZt
	7FzKUqIBAOAv32RiDfWb0nDr7XK8=
X-Google-Smtp-Source: AGHT+IFscK86GJQnejKA+fHrKfVDFcA+gtglkE7K7XUBHRhgjdLQUPphF2OOH9DGbQIlMY5cl0NyIVRmf/39yrAWInw=
X-Received: by 2002:ac2:4e91:0:b0:522:2ada:c02e with SMTP id
 2adb3069b0e04-52b896aeb75mr2014316e87.53.1717174260555; Fri, 31 May 2024
 09:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405311534.86cd4043-lkp@intel.com>
In-Reply-To: <202405311534.86cd4043-lkp@intel.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 31 May 2024 09:50:48 -0700
Message-ID: <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:24=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "kernel_BUG_at_include/linux/page_ref.h" on:
>
> commit: efa7df3e3bb5da8e6abbe37727417f32a37fba47 ("mm: align larger anony=
mous mappings on THP boundaries")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master      e0cce98fe279b64f4a7d81b7f5c3a23d80b92fb=
c]
> [test failed on linux-next/master 6dc544b66971c7f9909ff038b62149105272d26=
a]
>
> in testcase: trinity
> version: trinity-x86_64-6a17c218-1_20240527
> with following parameters:
>
>         runtime: 300s
>         group: group-00
>         nr_groups: 5
>
>
>
> compiler: gcc-13
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> we noticed the issue does not always happen. 34 times out of 50 runs as b=
elow.
> the parent is clean.
>
> 1803d0c5ee1a3bbe efa7df3e3bb5da8e6abbe377274
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :50          68%          34:50    dmesg.Kernel_panic-not_sync=
ing:Fatal_exception
>            :50          68%          34:50    dmesg.RIP:try_get_folio
>            :50          68%          34:50    dmesg.invalid_opcode:#[##]
>            :50          68%          34:50    dmesg.kernel_BUG_at_include=
/linux/page_ref.h
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202405311534.86cd4043-lkp@intel.=
com
>
>
> [  275.267158][ T4335] ------------[ cut here ]------------
> [  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
> [  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
> [  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted 6.7.=
0-rc4-00061-gefa7df3e3bb5 #1
> [  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_ref.h:2=
75 (discriminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.271159][ T4335] Code: c3 cc cc cc cc 44 89 e6 48 89 df e8 e4 54 11 =
00 eb ae 90 0f 0b 90 31 db eb d5 9c 58 0f 1f 40 00 f6 c4 02 0f 84 46 ff ff =
ff 90 <0f> 0b 48 c7 c6 a0 54 d2 87 48 89 df e8 a9 e9 ff ff 90 0f 0b be 04

If I read this BUG correctly, it is:

VM_BUG_ON(!in_atomic() && !irqs_disabled());

try_grab_folio() actually assumes it is in an atomic context (irq
disabled or preempt disabled) for this call path. This is achieved by
disabling irq in gup fast or calling it in rcu critical section in
page cache lookup path.

And try_grab_folio() is used when the folio is a large folio. The
bisected commit made the fuzzy test get PMD aligned address and large
folio more likely than before, and process_vm_readv/writev actually
doesn't take care of the large folio case at all. A properly aligned
address, for example, allocated by posix_memalign, should be able to
trigger this BUG even though the bisected commit doesn't exist.

We can't call pin_user_pages_remote() in rcu critical section since it
may sleep, and I don't think we have GUP fast remote either if I
remember correctly. It also doesn't make sense to disallow large folio
for process_vm_readv/writev either.

Maybe a new GUP flag or just use FOLL_LONGTERM to let GUP call
try_glab_folio() in rcu critical section? Added more GUP folks in this
loop.


> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   c3                      ret
>    1:   cc                      int3
>    2:   cc                      int3
>    3:   cc                      int3
>    4:   cc                      int3
>    5:   44 89 e6                mov    %r12d,%esi
>    8:   48 89 df                mov    %rbx,%rdi
>    b:   e8 e4 54 11 00          call   0x1154f4
>   10:   eb ae                   jmp    0xffffffffffffffc0
>   12:   90                      nop
>   13:   0f 0b                   ud2
>   15:   90                      nop
>   16:   31 db                   xor    %ebx,%ebx
>   18:   eb d5                   jmp    0xffffffffffffffef
>   1a:   9c                      pushf
>   1b:   58                      pop    %rax
>   1c:   0f 1f 40 00             nopl   0x0(%rax)
>   20:   f6 c4 02                test   $0x2,%ah
>   23:   0f 84 46 ff ff ff       je     0xffffffffffffff6f
>   29:   90                      nop
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   48 c7 c6 a0 54 d2 87    mov    $0xffffffff87d254a0,%rsi
>   33:   48 89 df                mov    %rbx,%rdi
>   36:   e8 a9 e9 ff ff          call   0xffffffffffffe9e4
>   3b:   90                      nop
>   3c:   0f 0b                   ud2
>   3e:   be                      .byte 0xbe
>   3f:   04                      .byte 0x4
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 0b                   ud2
>    2:   48 c7 c6 a0 54 d2 87    mov    $0xffffffff87d254a0,%rsi
>    9:   48 89 df                mov    %rbx,%rdi
>    c:   e8 a9 e9 ff ff          call   0xffffffffffffe9ba
>   11:   90                      nop
>   12:   0f 0b                   ud2
>   14:   be                      .byte 0xbe
>   15:   04                      .byte 0x4
> [  275.272813][ T4335] RSP: 0018:ffffc90005dcf650 EFLAGS: 00010202
> [  275.273346][ T4335] RAX: 0000000000000246 RBX: ffffea00066e0000 RCX: 0=
000000000000000
> [  275.274032][ T4335] RDX: fffff94000cdc007 RSI: 0000000000000004 RDI: f=
fffea00066e0034
> [  275.274719][ T4335] RBP: ffffea00066e0000 R08: 0000000000000000 R09: f=
ffff94000cdc006
> [  275.275404][ T4335] R10: ffffea00066e0037 R11: 0000000000000000 R12: 0=
000000000000136
> [  275.276106][ T4335] R13: ffffea00066e0034 R14: dffffc0000000000 R15: f=
fffea00066e0008
> [  275.276790][ T4335] FS:  00007fa2f9b61740(0000) GS:ffffffff89d0d000(00=
00) knlGS:0000000000000000
> [  275.277570][ T4335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  275.278143][ T4335] CR2: 00007fa2f6c00000 CR3: 0000000134b04000 CR4: 0=
0000000000406f0
> [  275.278833][ T4335] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [  275.279521][ T4335] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [  275.280201][ T4335] Call Trace:
> [  275.280499][ T4335]  <TASK>
> [ 275.280751][ T4335] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/ker=
nel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
> [ 275.281087][ T4335] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/ker=
nel/traps.c:153)
> [ 275.281463][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (disc=
riminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.281884][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (disc=
riminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.282300][ T4335] ? do_error_trap (arch/x86/kernel/traps.c:174)
> [ 275.282711][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (disc=
riminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.283129][ T4335] ? handle_invalid_op (arch/x86/kernel/traps.c:212)
> [ 275.283561][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (disc=
riminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.283990][ T4335] ? exc_invalid_op (arch/x86/kernel/traps.c:264)
> [ 275.284415][ T4335] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry=
h:568)
> [ 275.284859][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (disc=
riminator 3) mm/gup.c:79 (discriminator 3))
> [ 275.285278][ T4335] try_grab_folio (mm/gup.c:148)
> [ 275.285684][ T4335] __get_user_pages (mm/gup.c:1297 (discriminator 1))
> [ 275.286111][ T4335] ? __pfx___get_user_pages (mm/gup.c:1188)
> [ 275.286579][ T4335] ? __pfx_validate_chain (kernel/locking/lockdep.c:38=
25)
> [ 275.287034][ T4335] ? mark_lock (kernel/locking/lockdep.c:4656 (discrim=
inator 1))
> [ 275.287416][ T4335] __gup_longterm_locked (mm/gup.c:1509 mm/gup.c:2209)
> [ 275.288192][ T4335] ? __pfx___gup_longterm_locked (mm/gup.c:2204)
> [ 275.288697][ T4335] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722=
)
> [ 275.289135][ T4335] ? __pfx___might_resched (kernel/sched/core.c:10106)
> [ 275.289595][ T4335] pin_user_pages_remote (mm/gup.c:3350)
> [ 275.290041][ T4335] ? __pfx_pin_user_pages_remote (mm/gup.c:3350)
> [ 275.290545][ T4335] ? find_held_lock (kernel/locking/lockdep.c:5244 (di=
scriminator 1))
> [ 275.290961][ T4335] ? mm_access (kernel/fork.c:1573)
> [ 275.291353][ T4335] process_vm_rw_single_vec+0x142/0x360
> [ 275.291900][ T4335] ? __pfx_process_vm_rw_single_vec+0x10/0x10
> [ 275.292471][ T4335] ? mm_access (kernel/fork.c:1573)
> [ 275.292859][ T4335] process_vm_rw_core+0x272/0x4e0
> [ 275.293384][ T4335] ? hlock_class (arch/x86/include/asm/bitops.h:227 ar=
ch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non=
-atomic.h:142 kernel/locking/lockdep.c:228)
> [ 275.293780][ T4335] ? __pfx_process_vm_rw_core+0x10/0x10
> [ 275.294350][ T4335] process_vm_rw (mm/process_vm_access.c:284)
> [ 275.294748][ T4335] ? __pfx_process_vm_rw (mm/process_vm_access.c:259)
> [ 275.295197][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (d=
iscriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c=
:504 (discriminator 1))
> [ 275.295634][ T4335] __x64_sys_process_vm_readv (mm/process_vm_access.c:=
291)
> [ 275.296139][ T4335] ? syscall_enter_from_user_mode (kernel/entry/common=
c:94 kernel/entry/common.c:112)
> [ 275.296642][ T4335] do_syscall_64 (arch/x86/entry/common.c:51 (discrimi=
nator 1) arch/x86/entry/common.c:82 (discriminator 1))
> [ 275.297032][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (d=
iscriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c=
:504 (discriminator 1))
> [ 275.297470][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockd=
ep.c:4300 kernel/locking/lockdep.c:4359)
> [ 275.297988][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:=
171 arch/x86/entry/common.c:97)
> [ 275.298389][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockd=
ep.c:4300 kernel/locking/lockdep.c:4359)
> [ 275.298906][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:=
171 arch/x86/entry/common.c:97)
> [ 275.299304][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:=
171 arch/x86/entry/common.c:97)
> [ 275.299703][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:=
171 arch/x86/entry/common.c:97)
> [ 275.300115][ T4335] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entr=
y_64.S:129)
> [  275.300622][ T4335] RIP: 0033:0x7fa2f9c65719
> [ 275.301011][ T4335] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 =
00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 =
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   08 89 e8 5b 5d c3       or     %cl,-0x3ca2a418(%rcx)
>    6:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
>    d:   00 00 00
>   10:   90                      nop
>   11:   48 89 f8                mov    %rdi,%rax
>   14:   48 89 f7                mov    %rsi,%rdi
>   17:   48 89 d6                mov    %rdx,%rsi
>   1a:   48 89 ca                mov    %rcx,%rdx
>   1d:   4d 89 c2                mov    %r8,%r10
>   20:   4d 89 c8                mov    %r9,%r8
>   23:   4c 8b 4c 24 08          mov    0x8(%rsp),%r9
>   28:   0f 05                   syscall
>   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax         <=
-- trapping instruction
>   30:   73 01                   jae    0x33
>   32:   c3                      ret
>   33:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd06f=
1
>   3a:   f7 d8                   neg    %eax
>   3c:   64 89 01                mov    %eax,%fs:(%rcx)
>   3f:   48                      rex.W
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
>    6:   73 01                   jae    0x9
>    8:   c3                      ret
>    9:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd06c=
7
>   10:   f7 d8                   neg    %eax
>   12:   64 89 01                mov    %eax,%fs:(%rcx)
>   15:   48                      rex.W
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240531/202405311534.86cd4043-lk=
p@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

