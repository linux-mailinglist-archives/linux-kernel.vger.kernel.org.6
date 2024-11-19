Return-Path: <linux-kernel+bounces-414932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BBB9D2F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513681F23864
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA301D2F55;
	Tue, 19 Nov 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HV780k2u"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5B1D1F6B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048231; cv=none; b=JkiJnJiEbAAz9NpO5F1w2aFGaMkLtUwgJgk4j7sYUPK46WjeUvdwf5dgZyHom86fo5S477L5HuJmX/9jgWtNUWN6+Frs8GAitpkBBFwtLYsuJYMrbdheTCdQ0UPJ2BKFTles3xZQghlNfDnMCeUkEcs/BC9jllBklPKGXjDGkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048231; c=relaxed/simple;
	bh=6VVGIr7Ys4ulOXwsMuZ6GwDZL0pJ37g/m9ZfNxdOMZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4pnADd2Z6d9EazhxRY5aBcXGbuEZB2bOOPBuBhIYM1DFGjIkcHbeZXoOX0h2m7A+lB03UeQEBEXhDjyEoku0+2soAC1WJbP/SOToa5SvMA6Y3OeyOT86j5sRiRNIIecP6M+xsVRkz7wz7GJL5Dx14Q69vTilEyQ1n+Uw07OegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HV780k2u; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460a8d1a9b7so389181cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732048227; x=1732653027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laovRPuTDT80AGDsSKY4+0qzZmV9xhUGaDChPDN0TL0=;
        b=HV780k2uXKMyD0PcQt5sxY94B33RQXr0o9xJXoMXTcVAt7fFe6DUdphq2lClWlWdw5
         MqVTGnICNmRCLGSyW3XkCMXRA6XdNX8vIB3Aa8hZy3w9R4TemJOuZFF9gYZlMEWSD+y5
         xAnBFyONia5+12DNGdCNyYvUMKVyQoSTImMgTgWK0d/os4Mj0wxFPz9nwBVRfer2bqcg
         UOa2msXVWLfB4iMHmry1qxdExSmVqC8qSvUivR/FZUQwu03vQCTYCydq/ZHDO4zLjCCY
         n+kMGDfU/RCFa/2pv4b6jTXs3j2bK5L6Z8EPrklJEk+T0X7f5toU330rzJHE2p5i6793
         CyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732048227; x=1732653027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laovRPuTDT80AGDsSKY4+0qzZmV9xhUGaDChPDN0TL0=;
        b=g90y2dCirwWUWQOQo1J9bP75Xq9Rnd8WMSADr+KhvTeWGYeR2RmP6kEESqE0zIqkgz
         mjvO+me6eWH99l7/8rarT3c4c44mKnA4pJxv/bCAib38H7ZFvMz8QikRL4bupPLykguo
         M8K8NeOyA4/NWeFKYl+HSOX/ksWYLxJN4CjR16iC0VECEYEowhQXcjmpnKS7yiuyJmBD
         wKwyOE7LKBh7LqDTOLj7Sph41O8efAq3Bfc7hgDZveF0az7Sbd/1J4JoXpF4WXxr4at6
         GtYV/YBbFfl7L83l/zO7P7zx7FhLrP7fA4k5hBRXUeGq+zuaesU9VrTxTXhy9E9uVEAj
         rtdg==
X-Forwarded-Encrypted: i=1; AJvYcCXzuIBf/3PsLIIXaBw1To9cQijW+zIt6LgsvdU+zOGyLWfRtn1uw4cMPrQpsSaZgQLKpMQtSSsJTmx2VoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlp7d8Kg3j/9ZHT9vQLHt3J6VNifnoc+7Z4LuFjD93aqnAYBRc
	nc4oNqHVtK8hZTAn4tgwA8CWO4EcJ+LwtD9pjn1Sb7DEZs9z8F+Lz7NYHIfkYreWlI6fff9d/0N
	m62kbcYO4vv4xF6jWUcgPuBlxIvBgaEFvzayP
X-Gm-Gg: ASbGnctEzLSfoHIoknMJ0sjklhvYuBeUKxTc0PKBS0QQmkirlVh23PpEaK9x2tV6nbI
	REnQyj2hsQPC0aCt8jie6r0lj3psZ89SXbFX178WU+HOiqyIh69VpVZq48oo=
X-Google-Smtp-Source: AGHT+IHRJelR513IpRflcSXOnmABzdJHwWan9D8lehhGQSG6jpHraUvdwhBrGxxIZWxbjHFVPPnmYCyGQLOkwxqJcos=
X-Received: by 2002:a05:622a:27c8:b0:460:8444:d017 with SMTP id
 d75a77b69052e-4643015edc1mr301441cf.27.1732048226240; Tue, 19 Nov 2024
 12:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411132111.6a221562-lkp@intel.com> <CAJuCfpGMM1=3eS_1yCEFrwdFHv_dYZ3f1fXaFaKzT-hcNfjxfw@mail.gmail.com>
 <CAJuCfpH4Vz_CxGFT7qbziF6jZ448Riss89KNXzDw3CG3gecHhw@mail.gmail.com> <ZzrlO9wi8P8cyrk7@xsang-OptiPlex-9020>
In-Reply-To: <ZzrlO9wi8P8cyrk7@xsang-OptiPlex-9020>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 19 Nov 2024 20:30:15 +0000
Message-ID: <CAJuCfpGRwqUq063pwfL3HiQ-8g1HSDz+EKdW1CWKMXbxS1=2pQ@mail.gmail.com>
Subject: Re: [linux-next:master] [alloc_tag] 0f9b685626: BUG:KASAN:vmalloc-out-of-bounds_in_move_module
To: Oliver Sang <oliver.sang@intel.com>
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

On Mon, Nov 18, 2024 at 6:57=E2=80=AFAM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Suren,
>
> On Thu, Nov 14, 2024 at 03:40:08PM -0800, Suren Baghdasaryan wrote:
> > On Wed, Nov 13, 2024 at 1:34=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Wed, Nov 13, 2024 at 2:07=E2=80=AFPM kernel test robot <oliver.san=
g@intel.com> wrote:
> > > >
> > > >
> > > >
> > > > Hello,
> > > >
> > > >
> > > > we reported
> > > > "[linux-next:master] [alloc_tag]  a9c60bb0d0: BUG:KASAN:vmalloc-out=
-of-bounds_in_load_module"
> > > > in
> > > > https://lore.kernel.org/all/202410281441.216670ac-lkp@intel.com/
> > > >
> > > > we noticed it seems there is following patch.
> > > >
> > > > we made below report just FYI that the commit still cause similar i=
ssue on
> > > > linux-next/master and not fixed on tip of linux-next/master when th=
is bisect
> > > > is done.
> > > >
> > > >
> > > > kernel test robot noticed "BUG:KASAN:vmalloc-out-of-bounds_in_move_=
module" on:
> > > >
> > > > commit: 0f9b685626daa2f8e19a9788625c9b624c223e45 ("alloc_tag: popul=
ate memory for module tags as needed")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git ma=
ster
> > > >
> > > > [test failed on linux-next/master 929beafbe7acce3267c06115e13e03ff6=
e50548a]
> > > >
> > > > in testcase: rcuscale
> > > > version:
> > > > with following parameters:
> > > >
> > > >         runtime: 300s
> > > >         scale_type: srcu
> > > >
> > > >
> > > >
> > > > config: x86_64-randconfig-014-20241107
> > > > compiler: gcc-12
> > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp =
2 -m 16G
> > > >
> > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > >
> > > >
> > > > +------------------------------------------------+------------+----=
--------+
> > > > |                                                | 0db6f8d782 | 0f9=
b685626 |
> > > > +------------------------------------------------+------------+----=
--------+
> > > > | boot_successes                                 | 18         | 0  =
        |
> > > > | boot_failures                                  | 0          | 18 =
        |
> > > > | BUG:KASAN:vmalloc-out-of-bounds_in_move_module | 0          | 18 =
        |
> > > > | BUG:unable_to_handle_page_fault_for_address    | 0          | 18 =
        |
> > > > | Oops                                           | 0          | 18 =
        |
> > > > | RIP:kasan_metadata_fetch_row                   | 0          | 18 =
        |
> > > > | Kernel_panic-not_syncing:Fatal_exception       | 0          | 18 =
        |
> > > > +------------------------------------------------+------------+----=
--------+
> > > >
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a ne=
w version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-lkp/202411132111.6a221562-lkp@=
intel.com
> > >
> > >
> > > Thanks for the report! I'm looking into this but so far could not fin=
d
> > > an obvious issue. Will try to reproduce.
> >
> > For some reason I'm getting this panic when trying to follow the repro =
steps:
>
> sorry about this. kernel test robot run into some cluster issues these da=
ys
> and most of my time is occupied to solve them.
>
> I will look at this later when our cluster back to normal and give you an=
 update

Thanks! I would appreciate that. I tried several hints I found online
but still unsuccessful.

>
> sorry again for any inconvenience.
>
> >
> > # bin/lkp qemu -k /home/suren/linux-next/arch/x86_64/boot/bzImage -m
> > /home/suren/linux-next/out/modules.cgz job-script
> > ...
> > [   22.813623][    T1] Kernel panic - not syncing: VFS: Unable to
> > mount root fs on unknown-block(0,0)
> > [   22.815461][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted
> > 6.12.0-rc7-next-20241113 #1 060e60d2378c08a3d0121faf43856b671a45697c
> > [   22.817822][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > 1996), BIOS 1.15.0-1 04/01/2014
> > [   22.819655][    T1] Call Trace:
> > [   22.820399][    T1]  <TASK>
> > [   22.821077][    T1]  panic+0x243/0x486
> > [   22.821965][    T1]  ? crash_smp_send_stop+0x1c/0x1c
> > [   22.823019][    T1]  ? lock_release+0x17c/0x1b1
> > [   22.824006][    T1]  mount_root_generic+0x31d/0x3d0
> > [   22.825064][    T1]  ? init_rootfs+0x4c/0x4c
> > [   22.826011][    T1]  ? init_stat+0xd8/0xd8
> > [   22.826920][    T1]  ? __asan_memcpy+0x3c/0x65
> > [   22.827880][    T1]  ? getname_kernel+0x3dc/0x41e
> > [   22.828887][    T1]  prepare_namespace+0x21e/0x289
> > [   22.829895][    T1]  ? mount_root+0xc6/0xc6
> > [   22.830819][    T1]  ? fput+0x1b/0x194
> > [   22.831682][    T1]  ? rest_init+0x183/0x183
> > [   22.832624][    T1]  kernel_init+0x17/0x138
> > [   22.833535][    T1]  ? rest_init+0x183/0x183
> > [   22.834490][    T1]  ret_from_fork+0x20/0x54
> > [   22.835419][    T1]  ? rest_init+0x183/0x183
> > [   22.836343][    T1]  ret_from_fork_asm+0x11/0x20
> > [   22.837335][    T1]  </TASK>
> > [   22.838082][    T1] Kernel Offset: disabled
> >
> > I see that PeterZ had the same issue back in September:
> > https://lore.kernel.org/lkml/20240909091531.GA4723@noisy.programming.ki=
cks-ass.net/
> > , so might this be a known issue? If anyone has an idea what I'm doing
> > wrong I would appreciate your help.
> > Thanks,
> > Suren.
> >
> >
> > >
> > > >
> > > >
> > > > [ 153.897376][ T402] BUG: KASAN: vmalloc-out-of-bounds in move_modu=
le (kernel/module/main.c:2357)
> > > > [  153.899141][  T402] Write of size 40 at addr ffffffffa0000000 by=
 task modprobe/402
> > > > [  153.900837][  T402]
> > > > [  153.901496][  T402] CPU: 0 UID: 0 PID: 402 Comm: modprobe Tainte=
d: G                T  6.12.0-rc6-00146-g0f9b685626da #1 87c8486a909ba2f90e=
ff061a4c9c1fa5c9cd90ea
> > > > [  153.904537][  T402] Tainted: [T]=3DRANDSTRUCT
> > > > [  153.905500][  T402] Hardware name: QEMU Standard PC (i440FX + PI=
IX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > [  153.907702][  T402] Call Trace:
> > > > [  153.908510][  T402]  <TASK>
> > > > [ 153.909241][ T402] print_address_description+0x65/0x2fa
> > > > [ 153.910663][ T402] print_report (mm/kasan/report.c:489)
> > > > [ 153.911771][ T402] ? move_module (kernel/module/main.c:2357)
> > > > [ 153.912825][ T402] kasan_report (mm/kasan/report.c:603)
> > > > [ 153.913821][ T402] ? move_module (kernel/module/main.c:2357)
> > > > [ 153.914904][ T402] kasan_check_range (mm/kasan/generic.c:183 mm/k=
asan/generic.c:189)
> > > > [ 153.916029][ T402] __asan_memcpy (mm/kasan/shadow.c:105 (discrimi=
nator 1))
> > > > [ 153.917057][ T402] move_module (kernel/module/main.c:2357)
> > > > [ 153.918071][ T402] layout_and_allocate+0x446/0x523
> > > > [ 153.919459][ T402] load_module (kernel/module/main.c:2985)
> > > > [ 153.920457][ T402] ? mode_strip_umask (fs/namei.c:3248)
> > > > [ 153.921557][ T402] init_module_from_file (kernel/module/main.c:32=
66)
> > > > [ 153.922825][ T402] ? __ia32_sys_init_module (kernel/module/main.c=
:3266)
> > > > [ 153.923992][ T402] ? __lock_release+0x106/0x38c
> > > > [ 153.925173][ T402] ? idempotent_init_module (kernel/module/main.c=
:3301)
> > > > [ 153.926364][ T402] ? lock_release (kernel/locking/lockdep.c:467 k=
ernel/locking/lockdep.c:5848)
> > > > [ 153.944053][ T402] idempotent_init_module (kernel/module/main.c:3=
302)
> > > > [ 153.945164][ T402] ? init_module_from_file (kernel/module/main.c:=
3294)
> > > > [ 153.946268][ T402] ? security_capable (security/security.c:1143)
> > > > [ 153.947421][ T402] __do_sys_finit_module (include/linux/file.h:68=
 kernel/module/main.c:3330)
> > > > [ 153.948495][ T402] do_syscall_64 (arch/x86/entry/common.c:52 arch=
/x86/entry/common.c:83)
> > > > [ 153.949540][ T402] entry_SYSCALL_64_after_hwframe (arch/x86/entry=
/entry_64.S:130)
> > > > [  153.950855][  T402] RIP: 0033:0x7f0f37df7719
> > > > [ 153.951869][ T402] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 0=
0 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 2=
4 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01=
 48
> > > > All code
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >    0:   08 89 e8 5b 5d c3       or     %cl,-0x3ca2a418(%rcx)
> > > >    6:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
> > > >    d:   00 00 00
> > > >   10:   90                      nop
> > > >   11:   48 89 f8                mov    %rdi,%rax
> > > >   14:   48 89 f7                mov    %rsi,%rdi
> > > >   17:   48 89 d6                mov    %rdx,%rsi
> > > >   1a:   48 89 ca                mov    %rcx,%rdx
> > > >   1d:   4d 89 c2                mov    %r8,%r10
> > > >   20:   4d 89 c8                mov    %r9,%r8
> > > >   23:   4c 8b 4c 24 08          mov    0x8(%rsp),%r9
> > > >   28:   0f 05                   syscall
> > > >   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax    =
     <-- trapping instruction
> > > >   30:   73 01                   jae    0x33
> > > >   32:   c3                      ret
> > > >   33:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # =
0xd06f1
> > > >   3a:   f7 d8                   neg    %eax
> > > >   3c:   64 89 01                mov    %eax,%fs:(%rcx)
> > > >   3f:   48                      rex.W
> > > >
> > > > Code starting with the faulting instruction
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >    0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> > > >    6:   73 01                   jae    0x9
> > > >    8:   c3                      ret
> > > >    9:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # =
0xd06c7
> > > >   10:   f7 d8                   neg    %eax
> > > >   12:   64 89 01                mov    %eax,%fs:(%rcx)
> > > >   15:   48                      rex.W
> > > > [  153.955810][  T402] RSP: 002b:00007ffccd7f7198 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000139
> > > > [  153.957666][  T402] RAX: ffffffffffffffda RBX: 000055cc9f9fddd0 =
RCX: 00007f0f37df7719
> > > > [  153.959411][  T402] RDX: 0000000000000000 RSI: 000055cc9f9f24a0 =
RDI: 0000000000000004
> > > > [  153.961142][  T402] RBP: 000055cc9f9f24a0 R08: 0000000000000000 =
R09: 000055cc9f9ff250
> > > > [  153.962910][  T402] R10: 0000000000000004 R11: 0000000000000246 =
R12: 0000000000040000
> > > > [  153.964665][  T402] R13: 0000000000000000 R14: 000055cc9f9fdd80 =
R15: 0000000000000000
> > > > [  153.966393][  T402]  </TASK>
> > > > [  153.967209][  T402]
> > > > [  153.967856][  T402] Memory state around the buggy address:
> > > > [  153.969123][  T402] BUG: unable to handle page fault for address=
: fffffbfff3ffffe0
> > > > [  153.970807][  T402] #PF: supervisor read access in kernel mode
> > > > [  153.972036][  T402] #PF: error_code(0x0000) - not-present page
> > > > [  153.973220][  T402] PGD 417fdb067 P4D 417fdb067 PUD 417fd7067 PM=
D 0
> > > > [  153.974560][  T402] Oops: Oops: 0000 [#1] PREEMPT KASAN
> > > > [  153.975758][  T402] CPU: 0 UID: 0 PID: 402 Comm: modprobe Tainte=
d: G                T  6.12.0-rc6-00146-g0f9b685626da #1 87c8486a909ba2f90e=
ff061a4c9c1fa5c9cd90ea
> > > > [  153.978853][  T402] Tainted: [T]=3DRANDSTRUCT
> > > > [  153.979851][  T402] Hardware name: QEMU Standard PC (i440FX + PI=
IX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > [ 153.982008][ T402] RIP: 0010:kasan_metadata_fetch_row (mm/kasan/r=
eport_generic.c:186)
> > > > [ 153.983368][ T402] Code: 40 08 48 89 43 58 5b 31 c0 31 d2 31 c9 3=
1 f6 31 ff c3 cc cc cc cc 66 0f 1f 00 b8 ff ff 37 00 48 c1 ee 03 48 c1 e0 2=
a 48 01 c6 <48> 8b 06 48 89 07 48 8b 46 08 48 89 47 08 31 c0 31 f6 31 ff c3=
 cc
> > > > All code
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >    0:   40 08 48 89             rex or %cl,-0x77(%rax)
> > > >    4:   43 58                   rex.XB pop %r8
> > > >    6:   5b                      pop    %rbx
> > > >    7:   31 c0                   xor    %eax,%eax
> > > >    9:   31 d2                   xor    %edx,%edx
> > > >    b:   31 c9                   xor    %ecx,%ecx
> > > >    d:   31 f6                   xor    %esi,%esi
> > > >    f:   31 ff                   xor    %edi,%edi
> > > >   11:   c3                      ret
> > > >   12:   cc                      int3
> > > >   13:   cc                      int3
> > > >   14:   cc                      int3
> > > >   15:   cc                      int3
> > > >   16:   66 0f 1f 00             nopw   (%rax)
> > > >   1a:   b8 ff ff 37 00          mov    $0x37ffff,%eax
> > > >   1f:   48 c1 ee 03             shr    $0x3,%rsi
> > > >   23:   48 c1 e0 2a             shl    $0x2a,%rax
> > > >   27:   48 01 c6                add    %rax,%rsi
> > > >   2a:*  48 8b 06                mov    (%rsi),%rax              <--=
 trapping instruction
> > > >   2d:   48 89 07                mov    %rax,(%rdi)
> > > >   30:   48 8b 46 08             mov    0x8(%rsi),%rax
> > > >   34:   48 89 47 08             mov    %rax,0x8(%rdi)
> > > >   38:   31 c0                   xor    %eax,%eax
> > > >   3a:   31 f6                   xor    %esi,%esi
> > > >   3c:   31 ff                   xor    %edi,%edi
> > > >   3e:   c3                      ret
> > > >   3f:   cc                      int3
> > > >
> > > > Code starting with the faulting instruction
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >    0:   48 8b 06                mov    (%rsi),%rax
> > > >    3:   48 89 07                mov    %rax,(%rdi)
> > > >    6:   48 8b 46 08             mov    0x8(%rsi),%rax
> > > >    a:   48 89 47 08             mov    %rax,0x8(%rdi)
> > > >    e:   31 c0                   xor    %eax,%eax
> > > >   10:   31 f6                   xor    %esi,%esi
> > > >   12:   31 ff                   xor    %edi,%edi
> > > >   14:   c3                      ret
> > > >   15:   cc                      int3
> > > > [  153.987254][  T402] RSP: 0018:ffffc9000218f9f8 EFLAGS: 00010082
> > > > [  153.988595][  T402] RAX: dffffc0000000000 RBX: ffffffff9fffff00 =
RCX: 0000000000000000
> > > > [  153.990325][  T402] RDX: 0000000000000000 RSI: fffffbfff3ffffe0 =
RDI: ffffc9000218fa04
> > > > [  153.992086][  T402] RBP: 00000000fffffffe R08: 0000000000000000 =
R09: 0000000000000000
> > > > [  153.993786][  T402] R10: 0000000000000000 R11: 0000000000000000 =
R12: ffffffffa0000000
> > > > [  153.995554][  T402] R13: ffffffff864b4994 R14: ffffffff9fffff80 =
R15: 0000000000000028
> > > > [  153.997305][  T402] FS:  00007f0f37cf5040(0000) GS:ffffffff86989=
000(0000) knlGS:0000000000000000
> > > > [  153.999133][  T402] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
> > > > [  154.000578][  T402] CR2: fffffbfff3ffffe0 CR3: 0000000128853000 =
CR4: 00000000000006b0
> > > > [  154.002367][  T402] Call Trace:
> > > > [  154.003318][  T402]  <TASK>
> > > > [ 154.004087][ T402] ? __die_body (arch/x86/kernel/dumpstack.c:421)
> > > > [ 154.005074][ T402] ? page_fault_oops (arch/x86/mm/fault.c:710)
> > > > [ 154.006242][ T402] ? show_fault_oops (arch/x86/mm/fault.c:643)
> > > > [ 154.007368][ T402] ? search_module_extables (kernel/module/main.c=
:3369)
> > > > [ 154.008525][ T402] ? fixup_exception (arch/x86/mm/extable.c:321)
> > > > [ 154.009629][ T402] ? exc_page_fault (arch/x86/mm/fault.c:1479 arc=
h/x86/mm/fault.c:1539)
> > > > [ 154.010771][ T402] ? asm_exc_page_fault (arch/x86/include/asm/idt=
entry.h:623)
> > > > [ 154.011853][ T402] ? kasan_metadata_fetch_row (mm/kasan/report_ge=
neric.c:186)
> > > > [ 154.013072][ T402] print_report (mm/kasan/report.c:466 mm/kasan/r=
eport.c:489)
> > > > [ 154.014122][ T402] ? move_module (kernel/module/main.c:2357)
> > > > [ 154.015238][ T402] kasan_report (mm/kasan/report.c:603)
> > > > [ 154.016231][ T402] ? move_module (kernel/module/main.c:2357)
> > > > [ 154.017255][ T402] kasan_check_range (mm/kasan/generic.c:183 mm/k=
asan/generic.c:189)
> > > > [ 154.018379][ T402] __asan_memcpy (mm/kasan/shadow.c:105 (discrimi=
nator 1))
> > > > [ 154.019400][ T402] move_module (kernel/module/main.c:2357)
> > > > [ 154.020435][ T402] layout_and_allocate+0x446/0x523
> > > > [ 154.021792][ T402] load_module (kernel/module/main.c:2985)
> > > > [ 154.022822][ T402] ? mode_strip_umask (fs/namei.c:3248)
> > > > [ 154.023928][ T402] init_module_from_file (kernel/module/main.c:32=
66)
> > > > [ 154.025069][ T402] ? __ia32_sys_init_module (kernel/module/main.c=
:3266)
> > > > [ 154.026265][ T402] ? __lock_release+0x106/0x38c
> > > > [ 154.027496][ T402] ? idempotent_init_module (kernel/module/main.c=
:3301)
> > > > [ 154.028688][ T402] ? lock_release (kernel/locking/lockdep.c:467 k=
ernel/locking/lockdep.c:5848)
> > > > [ 154.029766][ T402] idempotent_init_module (kernel/module/main.c:3=
302)
> > > > [ 154.030985][ T402] ? init_module_from_file (kernel/module/main.c:=
3294)
> > > > [ 154.032192][ T402] ? security_capable (security/security.c:1143)
> > > > [ 154.033310][ T402] __do_sys_finit_module (include/linux/file.h:68=
 kernel/module/main.c:3330)
> > > > [ 154.034478][ T402] do_syscall_64 (arch/x86/entry/common.c:52 arch=
/x86/entry/common.c:83)
> > > > [ 154.035532][ T402] entry_SYSCALL_64_after_hwframe (arch/x86/entry=
/entry_64.S:130)
> > > > [  154.036819][  T402] RIP: 0033:0x7f0f37df7719
> > > > [ 154.037865][ T402] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 0=
0 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 2=
4 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01=
 48
> > > > All code
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >    0:   08 89 e8 5b 5d c3       or     %cl,-0x3ca2a418(%rcx)
> > > >    6:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
> > > >    d:   00 00 00
> > > >   10:   90                      nop
> > > >   11:   48 89 f8                mov    %rdi,%rax
> > > >   14:   48 89 f7                mov    %rsi,%rdi
> > > >   17:   48 89 d6                mov    %rdx,%rsi
> > > >   1a:   48 89 ca                mov    %rcx,%rdx
> > > >   1d:   4d 89 c2                mov    %r8,%r10
> > > >   20:   4d 89 c8                mov    %r9,%r8
> > > >   23:   4c 8b 4c 24 08          mov    0x8(%rsp),%r9
> > > >   28:   0f 05                   syscall
> > > >   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax    =
     <-- trapping instruction
> > > >   30:   73 01                   jae    0x33
> > > >   32:   c3                      ret
> > > >   33:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # =
0xd06f1
> > > >   3a:   f7 d8                   neg    %eax
> > > >   3c:   64 89 01                mov    %eax,%fs:(%rcx)
> > > >   3f:   48                      rex.W
> > > >
> > > > Code starting with the faulting instruction
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >    0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> > > >    6:   73 01                   jae    0x9
> > > >    8:   c3                      ret
> > > >    9:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # =
0xd06c7
> > > >   10:   f7 d8                   neg    %eax
> > > >   12:   64 89 01                mov    %eax,%fs:(%rcx)
> > > >   15:   48                      rex.W
> > > >
> > > >
> > > > The kernel config and materials to reproduce are available at:
> > > > https://download.01.org/0day-ci/archive/20241113/202411132111.6a221=
562-lkp@intel.com
> > > >
> > > >
> > > >
> > > > --
> > > > 0-DAY CI Kernel Test Service
> > > > https://github.com/intel/lkp-tests/wiki
> > > >

