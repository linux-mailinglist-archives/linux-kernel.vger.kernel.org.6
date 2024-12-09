Return-Path: <linux-kernel+bounces-436659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F285D9E891F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AE41614E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF18381AF;
	Mon,  9 Dec 2024 02:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ctt4VKgD"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3E44C6F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733710159; cv=none; b=LAM0CpE1M3ARlP3q2+Ydkk5s/AGMJ+6EdxdqO3qysllJPNQhJ35JRix5ToAATMtfgoIGsRVFfEYICZnhU3uszS3GOqhE+Ch5cKTTe7cSAg/z0RUGoZpnnMwYC0SGvGco4J+Ok2Yf2Jaa4W9qK/aS80UhG4HW4Wg5+jEy7SpZlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733710159; c=relaxed/simple;
	bh=9O9pWs4kUKmvU4fetS1LqPCPby0E+QddQr35BAvOjkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gF3OGbrVsx/ctpDYhIG83I7yZlcaPgm74l01m491U7DvTO1QSFWrWbiSut+NSw853N1ecNgSdlz0styhZOyofEIF/x+yzAVelxXC6Bqt63hCDA/3ORWoyj1MVVUZ27edrROZSsV3o0Bk9T25RdXa6G1bae/P2XFY/nAz65/80hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ctt4VKgD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467431402deso255791cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 18:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733710157; x=1734314957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Bo4HBWAqousHOYJdPF3EMPMGka7vrl2TiE+JGDByw8=;
        b=Ctt4VKgD351GicCTEygoU4EKk2HyKgWDIJKYz//juwDhQni9CLHn7yjghGwgCrRJaQ
         s/UFd6Jg7VvDcTaT+y4aXBY0jqQmtkFFTDT84ltZM0yWY5A61uuYJr6ZPzK/Cm4oken0
         6d4fcrr2SsQ4UIy+pZGHUJer1fs+haopu2qOTQ8IWm29uvOGqC1q5SGxxDWpLVUXIZCX
         ngTxgT3cHCSR6vqesjz8I5g29T1ng3SosWQGBH3jwURKZgBMe39qVVqOlffEyx9uTJTC
         L71IQ3o65lPXNSxf24D9KWujgxOMyrzcsWzVaqaAlYvcV5oYjVbQTPM5hevbTqcgMIMg
         GL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733710157; x=1734314957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Bo4HBWAqousHOYJdPF3EMPMGka7vrl2TiE+JGDByw8=;
        b=KRl/yc2rPyo9rjP3SJVYUTLbPhwUlCXR7Q5dbaIFSMf4UcufoRYP/PK+9sju+9sH9N
         MusqqIJN1IRSvhC/IXRWWERdYYVXvemo1fAV5dQC21weYZrw2hqv2OADicMVYbUwQbug
         iSbJpRxxj9JJFN15c24OAMLatu8OCUqpSPUtFA4SQt/0jhXKH91xj1/J5B3oQFucQqx/
         wnK8lw9Pkjq24iPSFjeqUotntlFd+3hjTc1uE0yw+yFwS5vcjoETA8wdKGYABdOfhDI1
         9xJW41rDYKdX9iPSoo8oYYkhg0msC8MTWi8UqmwbxGr+FrlwOQ+5FlaLaKxudr3IQlkE
         HjAg==
X-Forwarded-Encrypted: i=1; AJvYcCWXCRrdbXHQ/9pfJ1U+UZG+lJsizP5bB9x+F7F4PA3TfH1ew0rKHTs8XHDHSA0akgJS+IY5yE8PWH2ikeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypPDNILri1IS4W5Bfr9pm/NwSIBEP2y+0i80ePQV4fhA9zpDeJ
	mjNt5wSnAtR1spkjqwJ7pgjJohP2OSsolCmIkXzTGCTIWpMyZ3iftiICNYIPSJYzZHhJtBO9U5R
	Nmxp4exYdcUC1l8DJz/omjL8B+h8q8hJb7/2D
X-Gm-Gg: ASbGncuqQbi5Vto5uhCt19C7TiegU/hhvzMgD3SY9+ohKDp+miuaU2IxYBs737ZJNbt
	TCc2oc8GZ6gCemp9hvRuYiRAYFkeu4mQ=
X-Google-Smtp-Source: AGHT+IGyVdOaH3CJDTjUh7NqZc3tkr+a64QziAJ9EgHIPVClMGxk/UwhPqp5tjdHMLGCvGZgQ0jnVHdShP2JR9uzjpI=
X-Received: by 2002:a05:622a:5e13:b0:466:a3bf:41ab with SMTP id
 d75a77b69052e-4674c9ac794mr5372731cf.21.1733710156700; Sun, 08 Dec 2024
 18:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202412082208.db1fb2c9-lkp@intel.com>
In-Reply-To: <202412082208.db1fb2c9-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 8 Dec 2024 18:09:05 -0800
Message-ID: <CAJuCfpGeKgOgqq69OD-TMoQLhyy+HuTKK=cQPHMY2DgNcJf5Xg@mail.gmail.com>
Subject: Re: [akpm-mm:mm-unstable] [mm] 85ad413389: BUG:kernel_NULL_pointer_dereference,address
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@redhat.com>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Hillf Danton <hdanton@sina.com>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, 
	Minchan Kim <minchan@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Sourav Panda <souravpanda@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 7:26=E2=80=AFAM kernel test robot <oliver.sang@intel=
.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" o=
n:
>
> commit: 85ad413389aec04cfaaba043caa8128b76c6e491 ("mm: make vma cache SLA=
B_TYPESAFE_BY_RCU")
> https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-unstable
>
> in testcase: boot
>
> config: i386-randconfig-141-20241208
> compiler: gcc-11
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +------------------------------------------------+------------+----------=
--+
> |                                                | 98d5eefb97 | 85ad41338=
9 |
> +------------------------------------------------+------------+----------=
--+
> | BUG:kernel_NULL_pointer_dereference,address    | 0          | 12       =
  |
> | Oops                                           | 0          | 12       =
  |
> | EIP:lock_anon_vma_root                         | 0          | 12       =
  |
> | Kernel_panic-not_syncing:Fatal_exception       | 0          | 12       =
  |
> +------------------------------------------------+------------+----------=
--+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202412082208.db1fb2c9-lkp@intel.=
com

Thanks for the report!
It looks like anon_vma passed to lock_anon_vma_root() is NULL but it's
not obvious to me why my patch would cause that.

Oliver, how can I reproduce this locally?

>
>
> [    6.680723][    T1] BUG: kernel NULL pointer dereference, address: 000=
00000
> [    6.681291][    T1] #PF: supervisor read access in kernel mode
> [    6.681706][    T1] #PF: error_code(0x0000) - not-present page
> [    6.682122][    T1] *pde =3D 00000000
> [    6.682389][    T1] Oops: Oops: 0000 [#1] PREEMPT
> [    6.682741][    T1] CPU: 0 UID: 0 PID: 1 Comm: init Tainted: G        =
        T  6.13.0-rc1-00162-g85ad413389ae #1 b25e7d42bdbf00dd0b477b43b1be4c=
6af368b663
> [    6.683729][    T1] Tainted: [T]=3DRANDSTRUCT
> [ 6.684044][ T1] EIP: lock_anon_vma_root (mm/rmap.c:245)
> [ 6.684422][ T1] Code: 31 d2 31 c9 c3 55 89 e5 e8 55 68 15 00 5d 31 c0 31=
 d2 31 c9 c3 55 8b 00 83 c0 04 89 e5 e8 64 5f f2 ff 5d 31 c0 c3 55 89 e5 53=
 <8b> 1a 39 c3 74 18 85 c0 74 0a 0f 0b 83 c0 04 e8 48 5f f2 ff 8d 43
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   31 d2                   xor    %edx,%edx
>    2:   31 c9                   xor    %ecx,%ecx
>    4:   c3                      ret
>    5:   55                      push   %rbp
>    6:   89 e5                   mov    %esp,%ebp
>    8:   e8 55 68 15 00          call   0x156862
>    d:   5d                      pop    %rbp
>    e:   31 c0                   xor    %eax,%eax
>   10:   31 d2                   xor    %edx,%edx
>   12:   31 c9                   xor    %ecx,%ecx
>   14:   c3                      ret
>   15:   55                      push   %rbp
>   16:   8b 00                   mov    (%rax),%eax
>   18:   83 c0 04                add    $0x4,%eax
>   1b:   89 e5                   mov    %esp,%ebp
>   1d:   e8 64 5f f2 ff          call   0xfffffffffff25f86
>   22:   5d                      pop    %rbp
>   23:   31 c0                   xor    %eax,%eax
>   25:   c3                      ret
>   26:   55                      push   %rbp
>   27:   89 e5                   mov    %esp,%ebp
>   29:   53                      push   %rbx
>   2a:*  8b 1a                   mov    (%rdx),%ebx              <-- trapp=
ing instruction
>   2c:   39 c3                   cmp    %eax,%ebx
>   2e:   74 18                   je     0x48
>   30:   85 c0                   test   %eax,%eax
>   32:   74 0a                   je     0x3e
>   34:   0f 0b                   ud2
>   36:   83 c0 04                add    $0x4,%eax
>   39:   e8 48 5f f2 ff          call   0xfffffffffff25f86
>   3e:   8d                      .byte 0x8d
>   3f:   43                      rex.XB
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   8b 1a                   mov    (%rdx),%ebx
>    2:   39 c3                   cmp    %eax,%ebx
>    4:   74 18                   je     0x1e
>    6:   85 c0                   test   %eax,%eax
>    8:   74 0a                   je     0x14
>    a:   0f 0b                   ud2
>    c:   83 c0 04                add    $0x4,%eax
>    f:   e8 48 5f f2 ff          call   0xfffffffffff25f5c
>   14:   8d                      .byte 0x8d
>   15:   43                      rex.XB
> [    6.685810][    T1] EAX: 00000000 EBX: 4ccbd680 ECX: 00000000 EDX: 000=
00000
> [    6.686314][    T1] ESI: 4ccbd678 EDI: 4ccbd800 EBP: 416e1c60 ESP: 416=
e1c5c
> [    6.686817][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAG=
S: 00010202
> [    6.687338][    T1] CR0: 80050033 CR2: 00000000 CR3: 0ccbc000 CR4: 000=
406d0
> [    6.687821][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 000=
00000
> [    6.688313][    T1] DR6: fffe0ff0 DR7: 00000400
> [    6.688632][    T1] Call Trace:
> [ 6.688880][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/ke=
rnel/dumpstack.c:465)
> [ 6.689181][ T1] ? __die_body (arch/x86/kernel/dumpstack.c:421)
> [ 6.689478][ T1] ? __die (arch/x86/kernel/dumpstack.c:435)
> [ 6.689745][ T1] ? page_fault_oops (arch/x86/mm/fault.c:712)
> [ 6.690080][ T1] ? lock_anon_vma_root (mm/rmap.c:245)
> [ 6.690427][ T1] ? kernelmode_fixup_or_oops+0x50/0x5e
> [ 6.690891][ T1] ? __bad_area_nosemaphore+0x2c/0x17c
> [ 6.691343][ T1] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835)
> [ 6.691700][ T1] ? do_user_addr_fault (arch/x86/mm/fault.c:1280 (discrimi=
nator 1))
> [ 6.692055][ T1] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arc=
h/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x8=
6/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
> [ 6.692391][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:149=
4)
> [ 6.692815][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1048)
> [ 6.693136][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:149=
4)
> [ 6.693560][ T1] ? lock_anon_vma_root (mm/rmap.c:245)
> [ 6.693913][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:149=
4)
> [ 6.694352][ T1] ? lock_anon_vma_root (mm/rmap.c:245)
> [ 6.694717][ T1] ? anon_vma_clone (mm/rmap.c:298)
> [ 6.695053][ T1] ? __split_vma (mm/vma.c:486)
> [ 6.695375][ T1] ? vms_gather_munmap_vmas (mm/vma.c:1289)
> [ 6.695763][ T1] ? __mmap_prepare (mm/vma.c:2242)
> [ 6.696108][ T1] ? __mmap_region (mm/vma.c:2443)
> [ 6.696454][ T1] ? mmap_region (mm/mmap.c:1037)
> [ 6.696782][ T1] ? do_mmap (mm/mmap.c:499)
> [ 6.697091][ T1] ? vm_mmap_pgoff (mm/util.c:580)
> [ 6.697433][ T1] ? ksys_mmap_pgoff (mm/mmap.c:545)
> [ 6.697782][ T1] ? __ia32_sys_mmap_pgoff (mm/mmap.c:552)
> [ 6.698159][ T1] ? ia32_sys_call (kbuild/obj/consumer/i386-randconfig-141=
-20241208/./arch/x86/include/generated/asm/syscalls_32.h:193)
> [ 6.698507][ T1] ? do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/=
x86/entry/common.c:339)
> [ 6.698869][ T1] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945)
> [    6.699231][    T1] Modules linked in:
> [    6.699518][    T1] CR2: 0000000000000000
> [    6.699858][    T1] ---[ end trace 0000000000000000 ]---
> [ 6.700258][ T1] EIP: lock_anon_vma_root (mm/rmap.c:245)
> [ 6.700625][ T1] Code: 31 d2 31 c9 c3 55 89 e5 e8 55 68 15 00 5d 31 c0 31=
 d2 31 c9 c3 55 8b 00 83 c0 04 89 e5 e8 64 5f f2 ff 5d 31 c0 c3 55 89 e5 53=
 <8b> 1a 39 c3 74 18 85 c0 74 0a 0f 0b 83 c0 04 e8 48 5f f2 ff 8d 43
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   31 d2                   xor    %edx,%edx
>    2:   31 c9                   xor    %ecx,%ecx
>    4:   c3                      ret
>    5:   55                      push   %rbp
>    6:   89 e5                   mov    %esp,%ebp
>    8:   e8 55 68 15 00          call   0x156862
>    d:   5d                      pop    %rbp
>    e:   31 c0                   xor    %eax,%eax
>   10:   31 d2                   xor    %edx,%edx
>   12:   31 c9                   xor    %ecx,%ecx
>   14:   c3                      ret
>   15:   55                      push   %rbp
>   16:   8b 00                   mov    (%rax),%eax
>   18:   83 c0 04                add    $0x4,%eax
>   1b:   89 e5                   mov    %esp,%ebp
>   1d:   e8 64 5f f2 ff          call   0xfffffffffff25f86
>   22:   5d                      pop    %rbp
>   23:   31 c0                   xor    %eax,%eax
>   25:   c3                      ret
>   26:   55                      push   %rbp
>   27:   89 e5                   mov    %esp,%ebp
>   29:   53                      push   %rbx
>   2a:*  8b 1a                   mov    (%rdx),%ebx              <-- trapp=
ing instruction
>   2c:   39 c3                   cmp    %eax,%ebx
>   2e:   74 18                   je     0x48
>   30:   85 c0                   test   %eax,%eax
>   32:   74 0a                   je     0x3e
>   34:   0f 0b                   ud2
>   36:   83 c0 04                add    $0x4,%eax
>   39:   e8 48 5f f2 ff          call   0xfffffffffff25f86
>   3e:   8d                      .byte 0x8d
>   3f:   43                      rex.XB
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   8b 1a                   mov    (%rdx),%ebx
>    2:   39 c3                   cmp    %eax,%ebx
>    4:   74 18                   je     0x1e
>    6:   85 c0                   test   %eax,%eax
>    8:   74 0a                   je     0x14
>    a:   0f 0b                   ud2
>    c:   83 c0 04                add    $0x4,%eax
>    f:   e8 48 5f f2 ff          call   0xfffffffffff25f5c
>   14:   8d                      .byte 0x8d
>   15:   43                      rex.XB
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>

