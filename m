Return-Path: <linux-kernel+bounces-410072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F049C9634
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C602D281158
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5321B21B7;
	Thu, 14 Nov 2024 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BbBG4HS5"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEA1AF4EE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627623; cv=none; b=bdaL8KTGFg+GdFdAQCpAG1QsGrad6txAp8L+s3nLYtJL5VI+dADKvUctQ47LfAZxAq+OPYxyh2o+HQRNq8mhwFlwY0fVSjmTlz5rxg6KE98FFOmocRA18cn9nkT+DSUPfyrItW7oU+XXM9KSERXjwkV4wu9V2B3bKfI0nMlYb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627623; c=relaxed/simple;
	bh=DMtVX9eRbcA//1qkoVvSOBBrR76isl6SSA10Sin2K2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3j5s832c2R/Np4RO+Sw6yX5vyFctKq5Tpcr/B+q7xjkkSIqOGcRKlagdOhP7jYmrcLmg1dFxusZNbitr/jk8zJpst71f03I9GChzIKKQulQWP3A2dkYn2qe06b2FPggsJ5OatQ5Zj29tACLnpMwNK0dghXuaQAULZuHeQnHdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BbBG4HS5; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4635b03a3cdso33451cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731627619; x=1732232419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/mYu1uf/OogqfnJuVw7gNYHLp5xGrDHdo9WzrZTnF4=;
        b=BbBG4HS5bimD9JbF7pZpshckl9dTfGC0Nhq90rT/fTWl6rGWTpQczfNfskNvsn56Js
         C1vCR5Hf4gsA77q5I4IrjTyCJdycMIJsPpp6ui+ET3HkR+NIkcCC75EcdKQZ7C2L6wTT
         jQFbY3KssBuPYABK7rUPUkf4Sw+des2F1je67W2pdZrIKTOzUJtylWTVUFNb0cqkd6i8
         l/G5fy1XHWk3LnY+tGg0Mzl/S+Q/lLnHQ+4mmTMmv3Z8clA4BwI/WWtclQ2mMtpBxdK4
         FRz88QYGorc4Tq7WkL2j1lR/RVvj7BC9ycOtMvIGPscW81rulmZaoYiM7pmyDf6/aCFv
         99Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627619; x=1732232419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/mYu1uf/OogqfnJuVw7gNYHLp5xGrDHdo9WzrZTnF4=;
        b=wmijBMjSngcrpFrKd3novWIh82pBzQv7+Il6lCBUXtQBwITPP3gVzp3Ke/Fn1vUYH3
         FSlQUr5sCLmtJOAX+fkEvQVKUeu5ErNgSyfUKfJz9a71yib0jqFUSmI/OnYWJvKMY2B0
         +kXddwqtMfC01ZUXt9kq9/bK3QRNWWIWU47TreicNg600s7OLDLkiQhwQDfn5hnbqj6q
         nv+wZ7dkolKIk+sOrTXu3sxqWyGqdCoWi9AY8qlJ90ZzOFGvrqp6HhUj1W5OBzEsU4XJ
         mtTEPPtk14uuxS9xirl5cg5/bI7Gy7nly5SleHpzbpebayH72CXDtzXAQ0D1MFgROMJl
         lqqA==
X-Forwarded-Encrypted: i=1; AJvYcCXWffbPUS+fIgw4K3YbUvU5JfWlEaO2l0R20rUr4e5833GuPl7G0ogfDjOHHED4NdxkjBOM5Sy0yLpb00E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cVMoFusg3E4Gmreb2qPGiYFb1SJ9esP0BBMLXI2Z8wIKOQ7t
	kcLsHXyKBHbW9IRAEL1BehYPpChxJyqxsgRrhghHivMxY7KpLwusF9D9xQDad1/5bXqe96TQr66
	K8mFMLn7j59dhHkNwSrOmjVAynM/oxOTEw+JL
X-Gm-Gg: ASbGncsQ8Rk2yXQc4QG6wbahM70w5493Z+HJipsMpgcUFos4xVENbh+P37bMI0M+u/6
	318GIclweQO/lP1mS8pkjlyKGa6oZ1zY=
X-Google-Smtp-Source: AGHT+IGR9AhlnFKHQyFrI06bTxVO+2Tjsift6wNOPa3DaSoeAk5nPlvY67KrX29+jwbC1I58Vs5bvlxMXEZ6Oug0MXg=
X-Received: by 2002:ac8:5f8b:0:b0:462:b2f5:b24c with SMTP id
 d75a77b69052e-46364da6c83mr383071cf.29.1731627619268; Thu, 14 Nov 2024
 15:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411132111.6a221562-lkp@intel.com> <CAJuCfpGMM1=3eS_1yCEFrwdFHv_dYZ3f1fXaFaKzT-hcNfjxfw@mail.gmail.com>
In-Reply-To: <CAJuCfpGMM1=3eS_1yCEFrwdFHv_dYZ3f1fXaFaKzT-hcNfjxfw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 14 Nov 2024 15:40:08 -0800
Message-ID: <CAJuCfpH4Vz_CxGFT7qbziF6jZ448Riss89KNXzDw3CG3gecHhw@mail.gmail.com>
Subject: Re: [linux-next:master] [alloc_tag] 0f9b685626: BUG:KASAN:vmalloc-out-of-bounds_in_move_module
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, 
	Christoph Hellwig <hch@infradead.org>, Daniel Gomez <da.gomez@samsung.com>, 
	David Hildenbrand <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	David Rientjes <rientjes@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Kees Cook <keescook@chromium.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sami Tolvanen <samitolvanen@google.com>, 
	Sourav Panda <souravpanda@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Yu Zhao <yuzhao@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:34=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Nov 13, 2024 at 2:07=E2=80=AFPM kernel test robot <oliver.sang@in=
tel.com> wrote:
> >
> >
> >
> > Hello,
> >
> >
> > we reported
> > "[linux-next:master] [alloc_tag]  a9c60bb0d0: BUG:KASAN:vmalloc-out-of-=
bounds_in_load_module"
> > in
> > https://lore.kernel.org/all/202410281441.216670ac-lkp@intel.com/
> >
> > we noticed it seems there is following patch.
> >
> > we made below report just FYI that the commit still cause similar issue=
 on
> > linux-next/master and not fixed on tip of linux-next/master when this b=
isect
> > is done.
> >
> >
> > kernel test robot noticed "BUG:KASAN:vmalloc-out-of-bounds_in_move_modu=
le" on:
> >
> > commit: 0f9b685626daa2f8e19a9788625c9b624c223e45 ("alloc_tag: populate =
memory for module tags as needed")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > [test failed on linux-next/master 929beafbe7acce3267c06115e13e03ff6e505=
48a]
> >
> > in testcase: rcuscale
> > version:
> > with following parameters:
> >
> >         runtime: 300s
> >         scale_type: srcu
> >
> >
> >
> > config: x86_64-randconfig-014-20241107
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > +------------------------------------------------+------------+--------=
----+
> > |                                                | 0db6f8d782 | 0f9b685=
626 |
> > +------------------------------------------------+------------+--------=
----+
> > | boot_successes                                 | 18         | 0      =
    |
> > | boot_failures                                  | 0          | 18     =
    |
> > | BUG:KASAN:vmalloc-out-of-bounds_in_move_module | 0          | 18     =
    |
> > | BUG:unable_to_handle_page_fault_for_address    | 0          | 18     =
    |
> > | Oops                                           | 0          | 18     =
    |
> > | RIP:kasan_metadata_fetch_row                   | 0          | 18     =
    |
> > | Kernel_panic-not_syncing:Fatal_exception       | 0          | 18     =
    |
> > +------------------------------------------------+------------+--------=
----+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202411132111.6a221562-lkp@inte=
l.com
>
>
> Thanks for the report! I'm looking into this but so far could not find
> an obvious issue. Will try to reproduce.

For some reason I'm getting this panic when trying to follow the repro step=
s:

# bin/lkp qemu -k /home/suren/linux-next/arch/x86_64/boot/bzImage -m
/home/suren/linux-next/out/modules.cgz job-script
...
[   22.813623][    T1] Kernel panic - not syncing: VFS: Unable to
mount root fs on unknown-block(0,0)
[   22.815461][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted
6.12.0-rc7-next-20241113 #1 060e60d2378c08a3d0121faf43856b671a45697c
[   22.817822][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   22.819655][    T1] Call Trace:
[   22.820399][    T1]  <TASK>
[   22.821077][    T1]  panic+0x243/0x486
[   22.821965][    T1]  ? crash_smp_send_stop+0x1c/0x1c
[   22.823019][    T1]  ? lock_release+0x17c/0x1b1
[   22.824006][    T1]  mount_root_generic+0x31d/0x3d0
[   22.825064][    T1]  ? init_rootfs+0x4c/0x4c
[   22.826011][    T1]  ? init_stat+0xd8/0xd8
[   22.826920][    T1]  ? __asan_memcpy+0x3c/0x65
[   22.827880][    T1]  ? getname_kernel+0x3dc/0x41e
[   22.828887][    T1]  prepare_namespace+0x21e/0x289
[   22.829895][    T1]  ? mount_root+0xc6/0xc6
[   22.830819][    T1]  ? fput+0x1b/0x194
[   22.831682][    T1]  ? rest_init+0x183/0x183
[   22.832624][    T1]  kernel_init+0x17/0x138
[   22.833535][    T1]  ? rest_init+0x183/0x183
[   22.834490][    T1]  ret_from_fork+0x20/0x54
[   22.835419][    T1]  ? rest_init+0x183/0x183
[   22.836343][    T1]  ret_from_fork_asm+0x11/0x20
[   22.837335][    T1]  </TASK>
[   22.838082][    T1] Kernel Offset: disabled

I see that PeterZ had the same issue back in September:
https://lore.kernel.org/lkml/20240909091531.GA4723@noisy.programming.kicks-=
ass.net/
, so might this be a known issue? If anyone has an idea what I'm doing
wrong I would appreciate your help.
Thanks,
Suren.


>
> >
> >
> > [ 153.897376][ T402] BUG: KASAN: vmalloc-out-of-bounds in move_module (=
kernel/module/main.c:2357)
> > [  153.899141][  T402] Write of size 40 at addr ffffffffa0000000 by tas=
k modprobe/402
> > [  153.900837][  T402]
> > [  153.901496][  T402] CPU: 0 UID: 0 PID: 402 Comm: modprobe Tainted: G=
                T  6.12.0-rc6-00146-g0f9b685626da #1 87c8486a909ba2f90eff06=
1a4c9c1fa5c9cd90ea
> > [  153.904537][  T402] Tainted: [T]=3DRANDSTRUCT
> > [  153.905500][  T402] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [  153.907702][  T402] Call Trace:
> > [  153.908510][  T402]  <TASK>
> > [ 153.909241][ T402] print_address_description+0x65/0x2fa
> > [ 153.910663][ T402] print_report (mm/kasan/report.c:489)
> > [ 153.911771][ T402] ? move_module (kernel/module/main.c:2357)
> > [ 153.912825][ T402] kasan_report (mm/kasan/report.c:603)
> > [ 153.913821][ T402] ? move_module (kernel/module/main.c:2357)
> > [ 153.914904][ T402] kasan_check_range (mm/kasan/generic.c:183 mm/kasan=
/generic.c:189)
> > [ 153.916029][ T402] __asan_memcpy (mm/kasan/shadow.c:105 (discriminato=
r 1))
> > [ 153.917057][ T402] move_module (kernel/module/main.c:2357)
> > [ 153.918071][ T402] layout_and_allocate+0x446/0x523
> > [ 153.919459][ T402] load_module (kernel/module/main.c:2985)
> > [ 153.920457][ T402] ? mode_strip_umask (fs/namei.c:3248)
> > [ 153.921557][ T402] init_module_from_file (kernel/module/main.c:3266)
> > [ 153.922825][ T402] ? __ia32_sys_init_module (kernel/module/main.c:326=
6)
> > [ 153.923992][ T402] ? __lock_release+0x106/0x38c
> > [ 153.925173][ T402] ? idempotent_init_module (kernel/module/main.c:330=
1)
> > [ 153.926364][ T402] ? lock_release (kernel/locking/lockdep.c:467 kerne=
l/locking/lockdep.c:5848)
> > [ 153.944053][ T402] idempotent_init_module (kernel/module/main.c:3302)
> > [ 153.945164][ T402] ? init_module_from_file (kernel/module/main.c:3294=
)
> > [ 153.946268][ T402] ? security_capable (security/security.c:1143)
> > [ 153.947421][ T402] __do_sys_finit_module (include/linux/file.h:68 ker=
nel/module/main.c:3330)
> > [ 153.948495][ T402] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86=
/entry/common.c:83)
> > [ 153.949540][ T402] entry_SYSCALL_64_after_hwframe (arch/x86/entry/ent=
ry_64.S:130)
> > [  153.950855][  T402] RIP: 0033:0x7f0f37df7719
> > [ 153.951869][ T402] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00=
 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08=
 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   08 89 e8 5b 5d c3       or     %cl,-0x3ca2a418(%rcx)
> >    6:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
> >    d:   00 00 00
> >   10:   90                      nop
> >   11:   48 89 f8                mov    %rdi,%rax
> >   14:   48 89 f7                mov    %rsi,%rdi
> >   17:   48 89 d6                mov    %rdx,%rsi
> >   1a:   48 89 ca                mov    %rcx,%rdx
> >   1d:   4d 89 c2                mov    %r8,%r10
> >   20:   4d 89 c8                mov    %r9,%r8
> >   23:   4c 8b 4c 24 08          mov    0x8(%rsp),%r9
> >   28:   0f 05                   syscall
> >   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax        =
 <-- trapping instruction
> >   30:   73 01                   jae    0x33
> >   32:   c3                      ret
> >   33:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd0=
6f1
> >   3a:   f7 d8                   neg    %eax
> >   3c:   64 89 01                mov    %eax,%fs:(%rcx)
> >   3f:   48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> >    6:   73 01                   jae    0x9
> >    8:   c3                      ret
> >    9:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd0=
6c7
> >   10:   f7 d8                   neg    %eax
> >   12:   64 89 01                mov    %eax,%fs:(%rcx)
> >   15:   48                      rex.W
> > [  153.955810][  T402] RSP: 002b:00007ffccd7f7198 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000139
> > [  153.957666][  T402] RAX: ffffffffffffffda RBX: 000055cc9f9fddd0 RCX:=
 00007f0f37df7719
> > [  153.959411][  T402] RDX: 0000000000000000 RSI: 000055cc9f9f24a0 RDI:=
 0000000000000004
> > [  153.961142][  T402] RBP: 000055cc9f9f24a0 R08: 0000000000000000 R09:=
 000055cc9f9ff250
> > [  153.962910][  T402] R10: 0000000000000004 R11: 0000000000000246 R12:=
 0000000000040000
> > [  153.964665][  T402] R13: 0000000000000000 R14: 000055cc9f9fdd80 R15:=
 0000000000000000
> > [  153.966393][  T402]  </TASK>
> > [  153.967209][  T402]
> > [  153.967856][  T402] Memory state around the buggy address:
> > [  153.969123][  T402] BUG: unable to handle page fault for address: ff=
fffbfff3ffffe0
> > [  153.970807][  T402] #PF: supervisor read access in kernel mode
> > [  153.972036][  T402] #PF: error_code(0x0000) - not-present page
> > [  153.973220][  T402] PGD 417fdb067 P4D 417fdb067 PUD 417fd7067 PMD 0
> > [  153.974560][  T402] Oops: Oops: 0000 [#1] PREEMPT KASAN
> > [  153.975758][  T402] CPU: 0 UID: 0 PID: 402 Comm: modprobe Tainted: G=
                T  6.12.0-rc6-00146-g0f9b685626da #1 87c8486a909ba2f90eff06=
1a4c9c1fa5c9cd90ea
> > [  153.978853][  T402] Tainted: [T]=3DRANDSTRUCT
> > [  153.979851][  T402] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 153.982008][ T402] RIP: 0010:kasan_metadata_fetch_row (mm/kasan/repor=
t_generic.c:186)
> > [ 153.983368][ T402] Code: 40 08 48 89 43 58 5b 31 c0 31 d2 31 c9 31 f6=
 31 ff c3 cc cc cc cc 66 0f 1f 00 b8 ff ff 37 00 48 c1 ee 03 48 c1 e0 2a 48=
 01 c6 <48> 8b 06 48 89 07 48 8b 46 08 48 89 47 08 31 c0 31 f6 31 ff c3 cc
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   40 08 48 89             rex or %cl,-0x77(%rax)
> >    4:   43 58                   rex.XB pop %r8
> >    6:   5b                      pop    %rbx
> >    7:   31 c0                   xor    %eax,%eax
> >    9:   31 d2                   xor    %edx,%edx
> >    b:   31 c9                   xor    %ecx,%ecx
> >    d:   31 f6                   xor    %esi,%esi
> >    f:   31 ff                   xor    %edi,%edi
> >   11:   c3                      ret
> >   12:   cc                      int3
> >   13:   cc                      int3
> >   14:   cc                      int3
> >   15:   cc                      int3
> >   16:   66 0f 1f 00             nopw   (%rax)
> >   1a:   b8 ff ff 37 00          mov    $0x37ffff,%eax
> >   1f:   48 c1 ee 03             shr    $0x3,%rsi
> >   23:   48 c1 e0 2a             shl    $0x2a,%rax
> >   27:   48 01 c6                add    %rax,%rsi
> >   2a:*  48 8b 06                mov    (%rsi),%rax              <-- tra=
pping instruction
> >   2d:   48 89 07                mov    %rax,(%rdi)
> >   30:   48 8b 46 08             mov    0x8(%rsi),%rax
> >   34:   48 89 47 08             mov    %rax,0x8(%rdi)
> >   38:   31 c0                   xor    %eax,%eax
> >   3a:   31 f6                   xor    %esi,%esi
> >   3c:   31 ff                   xor    %edi,%edi
> >   3e:   c3                      ret
> >   3f:   cc                      int3
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   48 8b 06                mov    (%rsi),%rax
> >    3:   48 89 07                mov    %rax,(%rdi)
> >    6:   48 8b 46 08             mov    0x8(%rsi),%rax
> >    a:   48 89 47 08             mov    %rax,0x8(%rdi)
> >    e:   31 c0                   xor    %eax,%eax
> >   10:   31 f6                   xor    %esi,%esi
> >   12:   31 ff                   xor    %edi,%edi
> >   14:   c3                      ret
> >   15:   cc                      int3
> > [  153.987254][  T402] RSP: 0018:ffffc9000218f9f8 EFLAGS: 00010082
> > [  153.988595][  T402] RAX: dffffc0000000000 RBX: ffffffff9fffff00 RCX:=
 0000000000000000
> > [  153.990325][  T402] RDX: 0000000000000000 RSI: fffffbfff3ffffe0 RDI:=
 ffffc9000218fa04
> > [  153.992086][  T402] RBP: 00000000fffffffe R08: 0000000000000000 R09:=
 0000000000000000
> > [  153.993786][  T402] R10: 0000000000000000 R11: 0000000000000000 R12:=
 ffffffffa0000000
> > [  153.995554][  T402] R13: ffffffff864b4994 R14: ffffffff9fffff80 R15:=
 0000000000000028
> > [  153.997305][  T402] FS:  00007f0f37cf5040(0000) GS:ffffffff86989000(=
0000) knlGS:0000000000000000
> > [  153.999133][  T402] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [  154.000578][  T402] CR2: fffffbfff3ffffe0 CR3: 0000000128853000 CR4:=
 00000000000006b0
> > [  154.002367][  T402] Call Trace:
> > [  154.003318][  T402]  <TASK>
> > [ 154.004087][ T402] ? __die_body (arch/x86/kernel/dumpstack.c:421)
> > [ 154.005074][ T402] ? page_fault_oops (arch/x86/mm/fault.c:710)
> > [ 154.006242][ T402] ? show_fault_oops (arch/x86/mm/fault.c:643)
> > [ 154.007368][ T402] ? search_module_extables (kernel/module/main.c:336=
9)
> > [ 154.008525][ T402] ? fixup_exception (arch/x86/mm/extable.c:321)
> > [ 154.009629][ T402] ? exc_page_fault (arch/x86/mm/fault.c:1479 arch/x8=
6/mm/fault.c:1539)
> > [ 154.010771][ T402] ? asm_exc_page_fault (arch/x86/include/asm/idtentr=
y.h:623)
> > [ 154.011853][ T402] ? kasan_metadata_fetch_row (mm/kasan/report_generi=
c.c:186)
> > [ 154.013072][ T402] print_report (mm/kasan/report.c:466 mm/kasan/repor=
t.c:489)
> > [ 154.014122][ T402] ? move_module (kernel/module/main.c:2357)
> > [ 154.015238][ T402] kasan_report (mm/kasan/report.c:603)
> > [ 154.016231][ T402] ? move_module (kernel/module/main.c:2357)
> > [ 154.017255][ T402] kasan_check_range (mm/kasan/generic.c:183 mm/kasan=
/generic.c:189)
> > [ 154.018379][ T402] __asan_memcpy (mm/kasan/shadow.c:105 (discriminato=
r 1))
> > [ 154.019400][ T402] move_module (kernel/module/main.c:2357)
> > [ 154.020435][ T402] layout_and_allocate+0x446/0x523
> > [ 154.021792][ T402] load_module (kernel/module/main.c:2985)
> > [ 154.022822][ T402] ? mode_strip_umask (fs/namei.c:3248)
> > [ 154.023928][ T402] init_module_from_file (kernel/module/main.c:3266)
> > [ 154.025069][ T402] ? __ia32_sys_init_module (kernel/module/main.c:326=
6)
> > [ 154.026265][ T402] ? __lock_release+0x106/0x38c
> > [ 154.027496][ T402] ? idempotent_init_module (kernel/module/main.c:330=
1)
> > [ 154.028688][ T402] ? lock_release (kernel/locking/lockdep.c:467 kerne=
l/locking/lockdep.c:5848)
> > [ 154.029766][ T402] idempotent_init_module (kernel/module/main.c:3302)
> > [ 154.030985][ T402] ? init_module_from_file (kernel/module/main.c:3294=
)
> > [ 154.032192][ T402] ? security_capable (security/security.c:1143)
> > [ 154.033310][ T402] __do_sys_finit_module (include/linux/file.h:68 ker=
nel/module/main.c:3330)
> > [ 154.034478][ T402] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86=
/entry/common.c:83)
> > [ 154.035532][ T402] entry_SYSCALL_64_after_hwframe (arch/x86/entry/ent=
ry_64.S:130)
> > [  154.036819][  T402] RIP: 0033:0x7f0f37df7719
> > [ 154.037865][ T402] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00=
 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08=
 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   08 89 e8 5b 5d c3       or     %cl,-0x3ca2a418(%rcx)
> >    6:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
> >    d:   00 00 00
> >   10:   90                      nop
> >   11:   48 89 f8                mov    %rdi,%rax
> >   14:   48 89 f7                mov    %rsi,%rdi
> >   17:   48 89 d6                mov    %rdx,%rsi
> >   1a:   48 89 ca                mov    %rcx,%rdx
> >   1d:   4d 89 c2                mov    %r8,%r10
> >   20:   4d 89 c8                mov    %r9,%r8
> >   23:   4c 8b 4c 24 08          mov    0x8(%rsp),%r9
> >   28:   0f 05                   syscall
> >   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax        =
 <-- trapping instruction
> >   30:   73 01                   jae    0x33
> >   32:   c3                      ret
> >   33:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd0=
6f1
> >   3a:   f7 d8                   neg    %eax
> >   3c:   64 89 01                mov    %eax,%fs:(%rcx)
> >   3f:   48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> >    6:   73 01                   jae    0x9
> >    8:   c3                      ret
> >    9:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd0=
6c7
> >   10:   f7 d8                   neg    %eax
> >   12:   64 89 01                mov    %eax,%fs:(%rcx)
> >   15:   48                      rex.W
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20241113/202411132111.6a221562-=
lkp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >

