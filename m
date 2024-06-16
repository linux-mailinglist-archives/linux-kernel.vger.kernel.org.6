Return-Path: <linux-kernel+bounces-216429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7755909F30
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA81283F55
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8231044C84;
	Sun, 16 Jun 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSLsOV5y"
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D728BFF
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562570; cv=none; b=GMWsJqsZXSaTB0pwqIDsVL6DJRC4cG4nPxsVZ/cnghRDKg52t8fjGe5hHUVEwywNj+EcOEj+jcqBLtyYablaFw5twTF7lmoPvDbFAoqQpK/rhXDgHKh+ICjqaqbIbu+Clo7EncX1f7iMDoPdW37sJzNj16qK2dwacRrXwycEEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562570; c=relaxed/simple;
	bh=4WCiIjBk4n3FfEQgtoHf6KgIDNNLbEwE4OPY5FO5RDU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SZR09jQyoDakwV3U+ViAugd1yos6C3Rf7Pf3J+k8w731VUlvH8ko/SPaGdBWBErDn/7TmYjAK6ZhTke6vmcBbBekSW5Y24pbZm2024+fjqt5USatt9n50bMl3TvX9FFL59Je3Vjxm7nc3QYnX7jAwgsxs6/uuijB9UHwX05lSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSLsOV5y; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-6f9ca219760so2133990a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718562567; x=1719167367; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzOBUJKVGBcXTxPxkmcTEjq3y0W75ulAEPu5F86doEI=;
        b=SSLsOV5yELZ5jPl7ck/PYjWXUssJ2jLmoFN0iBhHOGZj3C7F8POsU4s3q90V9iztwf
         3OnjadiJ9uWHBGptMTqHbICSatMsz/epAVnZeKNRfq3Epx4Tl8B8Nm27a2mxkcvCyUr7
         s3OingQooatDPCtAXUEnvl0hiyeDSzz/lmOp8jfiJx8MPMDFRwd2ob+p131IrbFXKtDH
         2jp5Ol1X52dArhDmJqG4b8+ukTOtM7BVAQhHjsBQmoaFKRA4oCRwvDjAlF1hremv9ilB
         dmffrlEX8szQSL5jK8AFF66iQUVb6crwgqJm6kSInmc1KiIc8/51qYo0rI4DMCwfrsQu
         F5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718562567; x=1719167367;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzOBUJKVGBcXTxPxkmcTEjq3y0W75ulAEPu5F86doEI=;
        b=WgiI/dxk2WLDbHRGRWFIQI5tkGD5+3enlyftHltGUxK5gH5dQ1hlxOmymUzloBdrUe
         Ku9oXl0vwGJt1hDvDaWdhkFN3sj9lNJAOEKHpWN7cNSajzwUM7Y+EARF2xTudYZGRFs2
         Radhz9sr7KsKC4MOR3LSUuG4vEJl4F6IgQtudRk4hU1K/T3A5Ux9kKUrzEcvwIAmUSq5
         UlZDi23egtqF8v/AHTFEAnhAO6TA4qtDwNDBzot6+PyQw/gL1sO1Z2WDR1hlP+7OnSwZ
         8S94yieR6C1F1t6r4F/7YOP1OqykHw9zvwnCJ9DZ/SdintUO8xKIQZ8nbueSXKiPRY1D
         am7w==
X-Gm-Message-State: AOJu0Yxa4i7uHe3CZ0DZP7z+0ZF12d/9PGiOpYRSOoRnlgmwbEO3hcp5
	HFuCu8WfUG22VwH/a6axl1y6thdcli1BA+Ku3QkTScmv4ky3o0PP
X-Google-Smtp-Source: AGHT+IEoJne5s8Ize7L7o73PaocEGfwZzqbMKaitPtBp5jtVGDymnegTWmvStJi+76821ZYJgVgzTA==
X-Received: by 2002:a05:6830:cd:b0:6f9:968e:f364 with SMTP id 46e09a7af769-6fb939fef29mr8004755a34.28.1718562566919;
        Sun, 16 Jun 2024 11:29:26 -0700 (PDT)
Received: from smtpclient.apple ([2601:98a:4102:7e80:259d:4052:a449:ce6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f30f0df4sm38674991cf.88.2024.06.16.11.29.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2024 11:29:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Follow-Up on Reported Kernel Bug KASAN: slab-use-after-free in
 jfs_readdir 
From: Shuangpeng Bai <shuangpengbai@gmail.com>
In-Reply-To: <ED1DF88E-FF34-4A3E-9B8D-B23129018880@gmail.com>
Date: Sun, 16 Jun 2024 14:29:15 -0400
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB6267EA-85B0-46D1-B661-B62DC4984FC9@gmail.com>
References: <ED1DF88E-FF34-4A3E-9B8D-B23129018880@gmail.com>
To: shaggy@kernel.org,
 osmtendev@gmail.com,
 ghandatmanas@gmail.com
X-Mailer: Apple Mail (2.3774.300.61.1.2)


Dear Kernel Maintainers,

I hope this message finds you well.

I am writing to follow up on the recent bug report KASAN: =
slab-use-after-free in jfs_readdir. I was wondering if there have been =
any updates or progress on this issue. Additionally, please let me know =
if there is any assistance I can provide.

Thank you for your time and attention to this matter.

Best regards,
Shuangpeng

> On May 21, 2024, at 23:37, Shuangpeng Bai <shuangpengbai@gmail.com> =
wrote:
>=20
> Hi Kernel Maintainers,
>=20
> Our tool found a kernel bug KASAN: slab-use-after-free in jfs_readdir. =
Please see the details below.
>=20
> Kernel commit: v6.9 (Commits on May 12, 2024)
> Kernel config: attachment
> C/Syz reproducer: attachment
>=20
> Please let me know for anything I can help.
>=20
> Best,
> Shuangpeng
>=20
>=20
> [   99.923868][ T8134] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 99.927244][ T8134] BUG: KASAN: slab-use-after-free in jfs_readdir =
(fs/jfs/jfs_dtree.c:2867)=20
> [   99.930329][ T8134] Read of size 8 at addr ffff888015b4b030 by task =
a.out/8134
> [   99.932158][ T8134]
> [   99.932758][ T8134] CPU: 0 PID: 8134 Comm: a.out Not tainted 6.9.0 =
#8
> [   99.934454][ T8134] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.15.0-1 04/01/2014
> [   99.936720][ T8134] Call Trace:
> [   99.937548][ T8134]  <TASK>
> [ 99.938278][ T8134] dump_stack_lvl (lib/dump_stack.c:117)=20
> [ 99.940734][ T8134] print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:488)=20
> [ 99.941776][ T8134] ? __phys_addr (arch/x86/mm/physaddr.c:32 =
(discriminator 4))=20
> [ 99.942884][ T8134] ? jfs_readdir (fs/jfs/jfs_dtree.c:2867)=20
> [ 99.944073][ T8134] kasan_report (mm/kasan/report.c:603)=20
> [ 99.945162][ T8134] ? jfs_readdir (fs/jfs/jfs_dtree.c:2867)=20
> [ 99.946340][ T8134] jfs_readdir (fs/jfs/jfs_dtree.c:2867)=20
> [ 99.947428][ T8134] ? __x64_sys_openat (fs/open.c:1432)=20
> [ 99.948441][ T8134] ? entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:130)=20
> [ 99.949671][ T8134] ? __pfx_path_openat (fs/namei.c:3781)=20
> [ 99.950690][ T8134] ? __pfx__raw_spin_lock_irqsave =
(kernel/locking/spinlock.c:161)=20
> [ 99.951849][ T8134] ? page_table_check_set (mm/page_table_check.c:126 =
mm/page_table_check.c:97)=20
> [ 99.952953][ T8134] ? __pfx_jfs_readdir (fs/jfs/jfs_dtree.c:2701)=20
> [ 99.954027][ T8134] ? debug_check_no_obj_freed =
(lib/debugobjects.c:1000 lib/debugobjects.c:1019)=20
> [ 99.955184][ T8134] ? _raw_spin_lock =
(./arch/x86/include/asm/atomic.h:115 =
./include/linux/atomic/atomic-arch-fallback.h:2170 =
./include/linux/atomic/atomic-instrumented.h:1302 =
./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:187 =
./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)=20
> [ 99.956205][ T8134] ? putname (fs/namei.c:274)=20
> [ 99.957098][ T8134] ? down_write =
(./arch/x86/include/asm/preempt.h:103 kernel/locking/rwsem.c:1309 =
kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1580)=20
> [ 99.958044][ T8134] ? __pfx_down_write (kernel/locking/rwsem.c:1577)=20=

> [ 99.959308][ T8134] ? down_read_killable =
(./arch/x86/include/asm/preempt.h:103 kernel/locking/rwsem.c:1257 =
kernel/locking/rwsem.c:1273 kernel/locking/rwsem.c:1551)=20
> [ 99.960630][ T8134] ? __pfx_down_read_killable =
(kernel/locking/rwsem.c:1547)=20
> [ 99.961940][ T8134] ? selinux_file_permission =
(security/selinux/hooks.c:3643)=20
> [ 99.963309][ T8134] ? __pfx_jfs_readdir (fs/jfs/jfs_dtree.c:2701)=20
> [ 99.964537][ T8134] wrap_directory_iterator (fs/readdir.c:67)=20
> [ 99.965930][ T8134] iterate_dir (fs/readdir.c:111)=20
> [ 99.967099][ T8134] __x64_sys_getdents64 (fs/readdir.c:410 =
fs/readdir.c:394 fs/readdir.c:394)=20
> [ 99.968427][ T8134] ? __pfx___x64_sys_getdents64 (fs/readdir.c:394)=20=

> [ 99.969867][ T8134] ? mutex_unlock =
(./arch/x86/include/asm/atomic64_64.h:109 =
./include/linux/atomic/atomic-arch-fallback.h:4329 =
./include/linux/atomic/atomic-long.h:1506 =
./include/linux/atomic/atomic-instrumented.h:4481 =
kernel/locking/mutex.c:181 kernel/locking/mutex.c:545)=20
> [ 99.970927][ T8134] ? __pfx_filldir64 (fs/readdir.c:352)=20
> [ 99.972073][ T8134] ? fpregs_assert_state_consistent =
(arch/x86/kernel/fpu/context.h:38 arch/x86/kernel/fpu/core.c:822)=20
> [ 99.973562][ T8134] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 99.974580][ T8134] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:130)=20
> [   99.975780][ T8134] RIP: 0033:0x7fd5a43b473d
> [ 99.976695][ T8134] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 =
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c =
24 08 0f 05 <48> 3d 01 f0 ff ff 78
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>   0: 00 c3                 add    %al,%bl
>   2: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
>   9: 00 00 00=20
>   c: 90                    nop
>   d: f3 0f 1e fa           endbr64=20
>  11: 48 89 f8              mov    %rdi,%rax
>  14: 48 89 f7              mov    %rsi,%rdi
>  17: 48 89 d6              mov    %rdx,%rsi
>  1a: 48 89 ca              mov    %rcx,%rdx
>  1d: 4d 89 c2              mov    %r8,%r10
>  20: 4d 89 c8              mov    %r9,%r8
>  23: 4c 8b 4c 24 08        mov    0x8(%rsp),%r9
>  28: 0f 05                 syscall=20
>  2a:* 48 3d 01 f0 ff ff     cmp    $0xfffffffffffff001,%rax <-- =
trapping instruction
>  30: 78                    .byte 0x78
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   0: 48 3d 01 f0 ff ff     cmp    $0xfffffffffffff001,%rax
>   6: 78                    .byte 0x78
> [   99.980674][ T8134] RSP: 002b:00007ffc8e81ca28 EFLAGS: 00000203 =
ORIG_RAX: 00000000000000d9
> [   99.982594][ T8134] RAX: ffffffffffffffda RBX: 00005616907c2360 =
RCX: 00007fd5a43b473d
> [   99.984540][ T8134] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI: 0000000000000004
> [   99.986532][ T8134] RBP: 00007ffc8e81ca40 R08: 00007ffc8e81cb30 =
R09: 00007ffc8e81cb30
> [   99.988451][ T8134] R10: 00007ffc8e81cb30 R11: 0000000000000203 =
R12: 00005616907c03c0
> [   99.990408][ T8134] R13: 00007ffc8e81cb30 R14: 0000000000000000 =
R15: 0000000000000000
> [   99.992446][ T8134]  </TASK>
> [   99.993198][ T8134]
> [   99.993769][ T8134] Allocated by task 8101:
> [ 99.994870][ T8134] kasan_save_stack (mm/kasan/common.c:48)=20
> [ 99.996017][ T8134] kasan_save_track =
(./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 =
mm/kasan/common.c:69)=20
> [ 99.997094][ T8134] __kasan_slab_alloc (mm/kasan/common.c:341)=20
> [ 99.998119][ T8134] kmem_cache_alloc (mm/slub.c:3805 mm/slub.c:3851 =
mm/slub.c:3858)=20
> [ 99.999428][ T8134] mempool_alloc (mm/mempool.c:409)=20
> [ 100.001222][ T8134] __get_metapage (fs/jfs/jfs_metapage.c:178 =
fs/jfs/jfs_metapage.c:651)=20
> [ 100.003051][ T8134] dtSplitRoot (fs/jfs/jfs_dtree.c:1908 =
(discriminator 3))=20
> [ 100.004820][ T8134] dtSplitUp (fs/jfs/jfs_dtree.c:992)=20
> [ 100.006625][ T8134] dtInsert (fs/jfs/jfs_dtree.c:868)=20
> [ 100.008164][ T8134] jfs_create (fs/jfs/namei.c:137)=20
> [ 100.009763][ T8134] path_openat (fs/namei.c:3499 fs/namei.c:3566 =
fs/namei.c:3796)=20
> [ 100.011622][ T8134] do_filp_open (fs/namei.c:3827)=20
> [ 100.013413][ T8134] do_sys_openat2 (fs/open.c:1407)=20
> [ 100.015181][ T8134] __x64_sys_openat (fs/open.c:1432)=20
> [ 100.016978][ T8134] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 100.018664][ T8134] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:130)=20
> [  100.020899][ T8134]
> [  100.021806][ T8134] Freed by task 8134:
> [ 100.023259][ T8134] kasan_save_stack (mm/kasan/common.c:48)=20
> [ 100.025141][ T8134] kasan_save_track =
(./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 =
mm/kasan/common.c:69)=20
> [ 100.027001][ T8134] kasan_save_free_info (mm/kasan/generic.c:582)=20
> [ 100.028923][ T8134] __kasan_slab_free (mm/kasan/common.c:274)=20
> [ 100.030752][ T8134] kmem_cache_free (mm/slub.c:4286 mm/slub.c:4350)=20=

> [ 100.032665][ T8134] mempool_free (mm/mempool.c:555)=20
> [ 100.034385][ T8134] release_metapage (fs/jfs/jfs_metapage.c:788)=20
> [ 100.036318][ T8134] jfs_readdir (fs/jfs/jfs_dtree.c:3172 =
fs/jfs/jfs_dtree.c:2860)=20
> [ 100.038083][ T8134] wrap_directory_iterator (fs/readdir.c:67)=20
> [ 100.040219][ T8134] iterate_dir (fs/readdir.c:111)=20
> [ 100.042567][ T8134] __x64_sys_getdents64 (fs/readdir.c:410 =
fs/readdir.c:394 fs/readdir.c:394)=20
> [ 100.044639][ T8134] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 100.046310][ T8134] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:130)=20
> [  100.048685][ T8134]
> [  100.049566][ T8134] The buggy address belongs to the object at =
ffff888015b4b000
> [  100.049566][ T8134]  which belongs to the cache jfs_mp of size 128
> [  100.054906][ T8134] The buggy address is located 48 bytes inside of
> [  100.054906][ T8134]  freed 128-byte region [ffff888015b4b000, =
ffff888015b4b080)
> [  100.059909][ T8134]
> [  100.060839][ T8134] The buggy address belongs to the physical page:
> [  100.063438][ T8134] page: refcount:1 mapcount:0 =
mapping:0000000000000000 index:0x0 pfn:0x15b4b
> [  100.066660][ T8134] flags: =
0xfff00000000800(slab|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> [  100.069588][ T8134] page_type: 0xffffffff()
> [  100.071264][ T8134] raw: 00fff00000000800 ffff8881462b5140 =
dead000000000122 0000000000000000
> [  100.074666][ T8134] raw: 0000000000000000 0000000080150015 =
00000001ffffffff 0000000000000000
> [  100.077860][ T8134] page dumped because: kasan: bad access detected
> [  100.084408][ T8134] page_owner tracks the page as allocated
> [  100.085611][ T8134] page last allocated via order 0, migratetype =
Unmovable, gfp_mask 0x92800(GFP_NOWAIT|__GFP_NORETRY|__GFP_NOMEMALLOC), =
pid 8101, tgid 8101 (a.out), ts 85516
> [ 100.089422][ T8134] post_alloc_hook (./include/linux/page_owner.h:32 =
mm/page_alloc.c:1534)=20
> [ 100.090456][ T8134] get_page_from_freelist (mm/page_alloc.c:1543 =
mm/page_alloc.c:3317)=20
> [ 100.091556][ T8134] __alloc_pages (mm/page_alloc.c:4576)=20
> [ 100.092516][ T8134] allocate_slab (mm/slub.c:2181 mm/slub.c:2343)=20
> [ 100.094078][ T8134] ___slab_alloc (mm/slub.c:3531)=20
> [ 100.095051][ T8134] __slab_alloc.constprop.0 (mm/slub.c:3615)=20
> [ 100.096199][ T8134] kmem_cache_alloc (mm/slub.c:3668 mm/slub.c:3841 =
mm/slub.c:3858)=20
> [ 100.097220][ T8134] mempool_alloc (mm/mempool.c:409)=20
> [ 100.098198][ T8134] __get_metapage (fs/jfs/jfs_metapage.c:178 =
fs/jfs/jfs_metapage.c:651)=20
> [ 100.099189][ T8134] dtSplitRoot (fs/jfs/jfs_dtree.c:1908 =
(discriminator 3))=20
> [ 100.100170][ T8134] dtSplitUp (fs/jfs/jfs_dtree.c:992)=20
> [ 100.101104][ T8134] dtInsert (fs/jfs/jfs_dtree.c:868)=20
> [ 100.101958][ T8134] jfs_create (fs/jfs/namei.c:137)=20
> [ 100.102871][ T8134] path_openat (fs/namei.c:3499 fs/namei.c:3566 =
fs/namei.c:3796)=20
> [ 100.103852][ T8134] do_filp_open (fs/namei.c:3827)=20
> [ 100.104830][ T8134] do_sys_openat2 (fs/open.c:1407)=20
> [  100.105871][ T8134] page last free pid 8101 tgid 8101 stack trace:
> [ 100.107227][ T8134] free_unref_page_prepare =
(./include/linux/page_owner.h:25 mm/page_alloc.c:1141 =
mm/page_alloc.c:2347)=20
> [ 100.108596][ T8134] free_unref_folios (mm/page_alloc.c:2536)=20
> [ 100.109856][ T8134] folios_put_refs (mm/swap.c:1034)=20
> [ 100.111000][ T8134] free_pages_and_swap_cache (mm/swap_state.c:329)=20=

> [ 100.112311][ T8134] __tlb_batch_free_encoded_pages =
(mm/mmu_gather.c:137)=20
> [ 100.113623][ T8134] tlb_finish_mmu (mm/mmu_gather.c:148 =
mm/mmu_gather.c:366 mm/mmu_gather.c:373 mm/mmu_gather.c:465)=20
> [ 100.114741][ T8134] unmap_region (mm/mmap.c:2303 (discriminator 8))=20=

> [ 100.115892][ T8134] do_vmi_align_munmap =
(./include/linux/instrumented.h:96 =
./include/linux/atomic/atomic-instrumented.h:435 =
./include/linux/maple_tree.h:719 ./include/linux/maple_tree.h:739 =
./include/linux/maple_tree.h:754 mm/mmap.c:2631)=20
> [ 100.117053][ T8134] do_vmi_munmap (mm/mmap.c:2696)=20
> [ 100.118168][ T8134] __vm_munmap (mm/mmap.c:2973)=20
> [ 100.119257][ T8134] __x64_sys_munmap (mm/mmap.c:2986)=20
> [ 100.120429][ T8134] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 100.121550][ T8134] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:130)=20
> [  100.123223][ T8134]
> [  100.123801][ T8134] Memory state around the buggy address:
> [  100.125169][ T8134]  ffff888015b4af00: fa fb fb fb fb fb fb fb fc =
fc fc fc fc fc fc fc
> [  100.126886][ T8134]  ffff888015b4af80: fa fb fb fb fb fb fb fb fc =
fc fc fc fc fc fc fc
> [  100.128502][ T8134] >ffff888015b4b000: fa fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb fb
> [  100.130113][ T8134]                                      ^
> [  100.131238][ T8134]  ffff888015b4b080: fc fc fc fc fc fc fc fc 00 =
00 00 00 00 00 00 00
> [  100.133164][ T8134]  ffff888015b4b100: 00 00 00 00 00 00 00 00 fc =
fc fc fc fc fc fc fc
> [  100.134828][ T8134] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  100.151463][ T8134] Kernel panic - not syncing: KASAN: =
panic_on_warn set ...
> [  100.153291][ T8134] CPU: 1 PID: 8134 Comm: a.out Not tainted 6.9.0 =
#8
> [  100.154827][ T8134] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.15.0-1 04/01/2014
> [  100.167902][ T8134] Call Trace:
> [  100.168696][ T8134]  <TASK>
> [ 100.169393][ T8134] dump_stack_lvl (lib/dump_stack.c:118 =
(discriminator 4))=20
> [ 100.170478][ T8134] panic (kernel/panic.c:348)=20
> [ 100.171389][ T8134] ? __pfx_panic (kernel/panic.c:282)=20
> [ 100.172412][ T8134] ? preempt_schedule_thunk =
(arch/x86/entry/thunk_64.S:12)=20
> [ 100.173697][ T8134] ? preempt_schedule_common =
(./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6927)=20
> [ 100.175009][ T8134] ? check_panic_on_warn (kernel/panic.c:240)=20
> [ 100.176172][ T8134] ? jfs_readdir (fs/jfs/jfs_dtree.c:2867)=20
> [ 100.177262][ T8134] check_panic_on_warn (kernel/panic.c:241)=20
> [ 100.178420][ T8134] end_report (mm/kasan/report.c:226)=20
> [ 100.179385][ T8134] kasan_report (./arch/x86/include/asm/smap.h:56 =
mm/kasan/report.c:606)=20
> [ 100.180334][ T8134] ? jfs_readdir (fs/jfs/jfs_dtree.c:2867)=20
> [ 100.181430][ T8134] jfs_readdir (fs/jfs/jfs_dtree.c:2867)=20
> [ 100.182446][ T8134] ? __x64_sys_openat (fs/open.c:1432)=20
> [ 100.183564][ T8134] ? entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:130)=20
> [ 100.184891][ T8134] ? __pfx_path_openat (fs/namei.c:3781)=20
> [ 100.185956][ T8134] ? __pfx__raw_spin_lock_irqsave =
(kernel/locking/spinlock.c:161)=20
> [ 100.187271][ T8134] ? page_table_check_set =
(mm/page_table_check.c:126 mm/page_table_check.c:97)=20
> [ 100.188421][ T8134] ? __pfx_jfs_readdir (fs/jfs/jfs_dtree.c:2701)=20
> [ 100.189486][ T8134] ? debug_check_no_obj_freed =
(lib/debugobjects.c:1000 lib/debugobjects.c:1019)=20
> [ 100.190742][ T8134] ? _raw_spin_lock =
(./arch/x86/include/asm/atomic.h:115 =
./include/linux/atomic/atomic-arch-fallback.h:2170 =
./include/linux/atomic/atomic-instrumented.h:1302 =
./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:187 =
./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)=20
> [ 100.191793][ T8134] ? putname (fs/namei.c:274)=20
> [ 100.192661][ T8134] ? down_write =
(./arch/x86/include/asm/preempt.h:103 kernel/locking/rwsem.c:1309 =
kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1580)=20
> [ 100.193513][ T8134] ? __pfx_down_write (kernel/locking/rwsem.c:1577)=20=

> [ 100.194537][ T8134] ? down_read_killable =
(./arch/x86/include/asm/preempt.h:103 kernel/locking/rwsem.c:1257 =
kernel/locking/rwsem.c:1273 kernel/locking/rwsem.c:1551)=20
> [ 100.195660][ T8134] ? __pfx_down_read_killable =
(kernel/locking/rwsem.c:1547)=20
> [ 100.196844][ T8134] ? selinux_file_permission =
(security/selinux/hooks.c:3643)=20
> [ 100.198212][ T8134] ? __pfx_jfs_readdir (fs/jfs/jfs_dtree.c:2701)=20
> [ 100.199278][ T8134] wrap_directory_iterator (fs/readdir.c:67)=20
> [ 100.200487][ T8134] iterate_dir (fs/readdir.c:111)=20
> [ 100.201542][ T8134] __x64_sys_getdents64 (fs/readdir.c:410 =
fs/readdir.c:394 fs/readdir.c:394)=20
> [ 100.202668][ T8134] ? __pfx___x64_sys_getdents64 (fs/readdir.c:394)=20=

> [ 100.204027][ T8134] ? mutex_unlock =
(./arch/x86/include/asm/atomic64_64.h:109 =
./include/linux/atomic/atomic-arch-fallback.h:4329 =
./include/linux/atomic/atomic-long.h:1506 =
./include/linux/atomic/atomic-instrumented.h:4481 =
kernel/locking/mutex.c:181 kernel/locking/mutex.c:545)=20
> [ 100.205107][ T8134] ? __pfx_filldir64 (fs/readdir.c:352)=20
> [ 100.206145][ T8134] ? fpregs_assert_state_consistent =
(arch/x86/kernel/fpu/context.h:38 arch/x86/kernel/fpu/core.c:822)=20
> [ 100.207628][ T8134] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 100.208698][ T8134] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:130)=20
> [  100.210104][ T8134] RIP: 0033:0x7fd5a43b473d
> [ 100.211167][ T8134] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 =
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c =
24 08 0f 05 <48> 3d 01 f0 ff ff 78
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>   0: 00 c3                 add    %al,%bl
>   2: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
>   9: 00 00 00=20
>   c: 90                    nop
>   d: f3 0f 1e fa           endbr64=20
>  11: 48 89 f8              mov    %rdi,%rax
>  14: 48 89 f7              mov    %rsi,%rdi
>  17: 48 89 d6              mov    %rdx,%rsi
>  1a: 48 89 ca              mov    %rcx,%rdx
>  1d: 4d 89 c2              mov    %r8,%r10
>  20: 4d 89 c8              mov    %r9,%r8
>  23: 4c 8b 4c 24 08        mov    0x8(%rsp),%r9
>  28: 0f 05                 syscall=20
>  2a:* 48 3d 01 f0 ff ff     cmp    $0xfffffffffffff001,%rax <-- =
trapping instruction
>  30: 78                    .byte 0x78
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   0: 48 3d 01 f0 ff ff     cmp    $0xfffffffffffff001,%rax
>   6: 78                    .byte 0x78
> [  100.216055][ T8134] RSP: 002b:00007ffc8e81ca28 EFLAGS: 00000203 =
ORIG_RAX: 00000000000000d9
> [  100.218175][ T8134] RAX: ffffffffffffffda RBX: 00005616907c2360 =
RCX: 00007fd5a43b473d
> [  100.220331][ T8134] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI: 0000000000000004
> [  100.222587][ T8134] RBP: 00007ffc8e81ca40 R08: 00007ffc8e81cb30 =
R09: 00007ffc8e81cb30
> [  100.224629][ T8134] R10: 00007ffc8e81cb30 R11: 0000000000000203 =
R12: 00005616907c03c0
> [  100.226728][ T8134] R13: 00007ffc8e81cb30 R14: 0000000000000000 =
R15: 0000000000000000
> [  100.228901][ T8134]  </TASK>
> [  100.230006][ T8134] Kernel Offset: disabled
>=20
> <.config><repro.c>
>=20


