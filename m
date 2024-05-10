Return-Path: <linux-kernel+bounces-175370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F88C1E96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5158CB2227A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DDF153BE2;
	Fri, 10 May 2024 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yk72pFNq"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70E5490E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324461; cv=none; b=eOMD38SMXxJ1retZIpiR9zYDLurimMhMaHVUqBjUVc1vMaazOXCSu317guVZn2vjxbQ8b6dwNSZu2hhElq0TzWQQ5siZjdMbXl94jFV3Jjujdi0v5kYK2uSsSIgNG8NsJCHgW2lCqvWlXeQjzwmNtW32plNuXIXM7Rb85JzTM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324461; c=relaxed/simple;
	bh=NfCDVEGQKAmhqIlU2SH8ENF1F3a/gULwNGwtst9pANY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V30Ddy6OxP6UWuxlyPkQd2zloZl/HE3uOz2UpUgIZ2vqB95eP8hW9MXiSFLuYO9s+Gsaxj7kswoSQWk/aS6z8z6FX8Z40vxaw+NK0AMpkST4obMnnREPg/krtuhbxnJ8+nCWvVjYilcZN9D+xxBjEK/uNx/hhDKyG4yyBnBIu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yk72pFNq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1eed90a926fso101925ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715324459; x=1715929259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7fAfR/YvubQmTlKcecp7yTW1a+n3HiW6E0aJQVtriU=;
        b=yk72pFNqMjWYbFObpXxt7Lf4bt3yQwo/cyay4QAc96ySgMU5hZzIbVRpbYbxfV7lqc
         a0cMEq5Ssr27gQVdjb3DCZGiJbWZGW0nXJjKODdgf/yEWLKaQWt7bf+4dpSMYmQMvs54
         2ILZXadp2AL6K5WRWmXc0gcGd9+Gj6HJe6MGGdGHfqSIBtJHm0IIYufBtQP93iWXj2U5
         sBkN4mktWbBvtK1fIfA9sYsLm58rRF/b//YIU4MhP4sqaSt4uDSD9er6042A2TNQExw2
         +pHRG2V+I5d8QB1hKBySL9CaNTMptNgC72lXnvHfW5zvQF3viNKTPV/pWTeQu58SKpiV
         Q4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715324459; x=1715929259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7fAfR/YvubQmTlKcecp7yTW1a+n3HiW6E0aJQVtriU=;
        b=DeaL0I63xd9LIuJUccXPXFzhvRR0bLtHXBTOAOq3Q0j1xw4AEdnTCTjbX6ErBwIhhM
         YdwKmJCLNOhfYZLcWe9yYce7y+SEAiYtG1uT3TtBsbII6DEBfdtVcVbzZy1piQYjLzrk
         yu89e+xxw8zn28ezwN/ZkXW3WM931YfU9dqV9mYJnjxLym79UMSr+m4aILAm9hxAXsq6
         BQ9XaguuGDR4M6GcVJZWURRu7BBSgoD+MQdlwXZm+2JsRvJWWI3EZxxewPk+ZwoV+bAd
         8W1O2IefHGWKI4U+HhLGkCqDe2y6kUkk+D/l9Mtt6wbXmKbIE01K4eeEmXzZVIa38k0T
         aw8g==
X-Forwarded-Encrypted: i=1; AJvYcCUaI5cNv8da97fh6rY64pgD0wlhJkB4V04eMHhoZCC6NpZ9w4qG+RDZynLk/H/CUQWVeUyGxTN18eBIHFjQZ/pVmxyrYT96HCGQ3yPl
X-Gm-Message-State: AOJu0Yz0GrpwIgbVsBi4+XJ/T7VPondgyojtMeYlYeHA9pRgREIe088L
	BV8yeaLz4uWuhjDAfuP1zJVFxMWQ77py4QNycP0kjrFnHMTayvjCn5KF17BCUoRC2NO0MSFsYFP
	z7Rjk+UOH12pccJk2aw+TCzpMr68UEFgyAKvI
X-Google-Smtp-Source: AGHT+IHa7LFHhfORljUbni+YKq8i4ruqUHTF3GMICNUBOgBY9hBCf84LwALGphYv6fZQpyVp7w8Mtodg1UM066aJCAg=
X-Received: by 2002:a17:902:e848:b0:1e0:984b:6215 with SMTP id
 d9443c01a7336-1ef46b88af0mr1539675ad.16.1715324459128; Fri, 10 May 2024
 00:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f5f83206180101e7@google.com> <CAHC9VhSinu25_9evZZmLaiJL=R-LNOmB+Yz-3NtdMi5b+vQiRg@mail.gmail.com>
In-Reply-To: <CAHC9VhSinu25_9evZZmLaiJL=R-LNOmB+Yz-3NtdMi5b+vQiRg@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 10 May 2024 09:00:47 +0200
Message-ID: <CANp29Y74qSm4_VTVT-j5n5kwpJaPk1zTMXPRO_xxWViXADUNeg@mail.gmail.com>
Subject: Re: [syzbot] [audit?] BUG: unable to handle kernel NULL pointer
 dereference in kauditd_hold_skb
To: Paul Moore <paul@paul-moore.com>
Cc: syzbot <syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com>, 
	audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:27=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, May 9, 2024 at 4:14=E2=80=AFAM syzbot
> <syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6d7ddd805123 Merge tag 'soc-fixes-6.9-3' of git://git.k=
ern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10c901b8980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D758bb5b8f72=
4c7ba
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D8ffdaad8822ca=
df6ff4e
> > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld=
 (GNU Binutils for Debian) 2.40
> > userspace arch: arm
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17ed19b89=
80000
>
> Is syzbot no longer providing reproducers in C?  I see the syzbot
> reproducer but no vanilla C code ...

Syzbot still provides them, but in this particular case when syzbot
tried to translate the .syz repro to C, it was unable to reproduce the
problem anymore. So it didn't report it. It usually doesn't stay too
long like this, in some time it will find a working C reproducer.

>
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/8ead8862021c/non_bootable_disk-6d7ddd80.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/4c2b52b97a0d/vmli=
nux-6d7ddd80.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/73131a832637=
/zImage-6d7ddd80.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com
> >
> > audit: type=3D1400 audit(66.700:100): avc:  denied  { ioctl } for  pid=
=3D3015 comm=3D"syz-executor.1" path=3D"/dev/loop1" dev=3D"devtmpfs" ino=3D=
636 ioctlcmd=3D0x4c01 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u=
:object_r:device_t tclass=3Dblk_file permissive=3D1
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
00000 when read
> > [00000000] *pgd=3D80000080004003, *pmd=3D00000000
> > Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 0 PID: 30 Comm: kauditd Not tainted 6.9.0-rc7-syzkaller #0
> > Hardware name: ARM-Versatile Express
> > PC is at printk_get_level include/linux/printk.h:21 [inline]
> > PC is at printk_parse_prefix+0xc/0x90 kernel/printk/printk.c:2137
> > LR is at printk_sprint+0x10c/0x164 kernel/printk/printk.c:2177
> > pc : [<802bc524>]    lr : [<802bc6b4>]    psr: 60000093
> > sp : df8d9d70  ip : df8d9d80  fp : df8d9d7c
> > r10: 8262a180  r9 : 00000000  r8 : 00000000
> > r7 : df8d9dc8  r6 : 00000000  r5 : 00000000  r4 : 00000000
> > r3 : df8d9ebc  r2 : 00000000  r1 : 00000000  r0 : 00000000
> > Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> > Control: 30c5387d  Table: 84b70e80  DAC: fffffffd
> > Register r0 information: NULL pointer
> > Register r1 information: NULL pointer
> > Register r2 information: NULL pointer
> > Register r3 information: 2-page vmalloc region starting at 0xdf8d8000 a=
llocated at kernel_clone+0xac/0x3cc kernel/fork.c:2797
> > Register r4 information: NULL pointer
> > Register r5 information: NULL pointer
> > Register r6 information: NULL pointer
> > Register r7 information: 2-page vmalloc region starting at 0xdf8d8000 a=
llocated at kernel_clone+0xac/0x3cc kernel/fork.c:2797
> > Register r8 information: NULL pointer
> > Register r9 information: NULL pointer
> > Register r10 information: non-slab/vmalloc memory
> > Register r11 information: 2-page vmalloc region starting at 0xdf8d8000 =
allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2797
> > Register r12 information: 2-page vmalloc region starting at 0xdf8d8000 =
allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2797
> > Process kauditd (pid: 30, stack limit =3D 0xdf8d8000)
> > Stack: (0xdf8d9d70 to 0xdf8da000)
> > 9d60:                                     df8d9d9c df8d9d80 802bc6b4 80=
2bc524
> > 9d80: 00000000 00000000 dddc5595 00000000 df8d9e24 df8d9da0 802bc918 80=
2bc5b4
> > 9da0: 81fce794 df8d9ebc 8029d704 0000000f ac9b579a df8d9dc0 0000001e 81=
fce794
> > 9dc0: 60000013 00000005 00000000 df8d9ebc 8263bdf8 00000000 00000000 82=
62a22c
> > 9de0: 60000093 3fffe339 00000000 75613501 00746964 3d7ed298 df8d9e44 00=
000000
> > 9e00: ffffffff 82622ec4 00000000 00000000 00000000 81fce794 df8d9e64 df=
8d9e28
> > 9e20: 802bda40 802bc718 df8d9ebc 3d7ed298 df8d9e7c 82ee8000 df8d9e6c 82=
ee8000
> > 9e40: 85080000 00000000 8033fd34 8462d6c0 00000000 00000000 df8d9e7c df=
8d9e68
> > 9e60: 802bdbdc 802bd948 df8d9ebc df8d9e78 df8d9e9c df8d9e80 802bec18 80=
2bdbc0
> > 9e80: 81893374 818cdd00 8462d6c0 ffffff91 df8d9eb4 df8d9ea0 818a62e0 80=
2bebb0
> > 9ea0: df8d9ebc 3d7ed298 df8d9ee4 df8d9ec8 803404e4 818a62bc 81fce794 00=
000579
> > 9ec0: 85080010 00000000 826fb6ec 8462d6c0 00000000 8033fd34 df8d9f24 df=
8d9ee8
> > 9ee0: 8033ff54 80340414 df8d9f04 00000001 00000000 8289fa50 df8d9f24 82=
6fb6ec
> > 9f00: 8289f9f8 00000000 00000000 82e98300 00000000 00000000 df8d9f84 df=
8d9f28
> > 9f20: 8034080c 8033fe64 8033fd34 80340408 8027cd5c 80340408 8033fcdc 80=
33fd34
> > 9f40: 00000000 82ee8000 802a5074 df8d9f4c df8d9f4c 3d7ed298 df8d9f84 82=
f26480
> > 9f60: 82ee8000 8034058c 00000000 82e98300 df819e50 00000000 df8d9fac df=
8d9f88
> > 9f80: 802702a0 80340598 82f26480 8027019c 00000000 00000000 00000000 00=
000000
> > 9fa0: 00000000 df8d9fb0 80200104 802701a8 00000000 00000000 00000000 00=
000000
> > 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00=
000000
> > 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00=
000000
> > Call trace:
> > [<802bc518>] (printk_parse_prefix) from [<802bc6b4>] (printk_sprint+0x1=
0c/0x164 kernel/printk/printk.c:2177)
> > [<802bc5a8>] (printk_sprint) from [<802bc918>] (vprintk_store+0x20c/0x4=
50 kernel/printk/printk.c:2279)
> >  r7:00000000 r6:dddc5595 r5:00000000 r4:00000000
> > [<802bc70c>] (vprintk_store) from [<802bda40>] (vprintk_emit+0x104/0x27=
8 kernel/printk/printk.c:2329)
> >  r10:81fce794 r9:00000000 r8:00000000 r7:00000000 r6:82622ec4 r5:ffffff=
ff
> >  r4:00000000
> > [<802bd93c>] (vprintk_emit) from [<802bdbdc>] (vprintk_default+0x28/0x3=
0 kernel/printk/printk.c:2363)
> >  r10:00000000 r9:00000000 r8:8462d6c0 r7:8033fd34 r6:00000000 r5:850800=
00
> >  r4:82ee8000
> > [<802bdbb4>] (vprintk_default) from [<802bec18>] (vprintk+0x74/0x94 ker=
nel/printk/printk_safe.c:45)
> > [<802beba4>] (vprintk) from [<818a62e0>] (_printk+0x34/0x58 kernel/prin=
tk/printk.c:2373)
> >  r6:ffffff91 r4:8462d6c0
> > [<818a62ac>] (_printk) from [<803404e4>] (kauditd_printk_skb kernel/aud=
it.c:546 [inline])
> > [<818a62ac>] (_printk) from [<803404e4>] (kauditd_hold_skb+0xdc/0xf8 ke=
rnel/audit.c:581)
> >  r3:00000000 r2:85080010 r1:00000579 r0:81fce794
> > [<80340408>] (kauditd_hold_skb) from [<8033ff54>] (kauditd_send_queue+0=
xfc/0x16c kernel/audit.c:766)
> >  r7:8033fd34 r6:00000000 r5:8462d6c0 r4:826fb6ec
> > [<8033fe58>] (kauditd_send_queue) from [<8034080c>] (kauditd_thread+0x2=
80/0x2d8 kernel/audit.c:890)
> >  r10:00000000 r9:00000000 r8:82e98300 r7:00000000 r6:00000000 r5:8289f9=
f8
> >  r4:826fb6ec
> > [<8034058c>] (kauditd_thread) from [<802702a0>] (kthread+0x104/0x134 ke=
rnel/kthread.c:388)
> >  r10:00000000 r9:df819e50 r8:82e98300 r7:00000000 r6:8034058c r5:82ee80=
00
> >  r4:82f26480
> > [<8027019c>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/=
arm/kernel/entry-common.S:134)
> > Exception stack(0xdf8d9fb0 to 0xdf8d9ff8)
> > 9fa0:                                     00000000 00000000 00000000 00=
000000
> > 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00=
000000
> > 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8027019c r4:82f2648=
0
> > Code: e89da800 e1a0c00d e92dd800 e24cb004 (e5d03000)
> > ---[ end trace 0000000000000000 ]---
>
> It would be nice to see the C version of the reproducer to try and
> debug this, but I'm somewhat skeptical that this is an audit issue as
> this chunk of code hasn't changed in some time and I would have
> expected syzbot to hit any issues with this code well before now.
>
> --
> paul-moore.com
>

