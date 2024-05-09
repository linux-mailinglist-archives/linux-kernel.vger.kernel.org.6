Return-Path: <linux-kernel+bounces-175073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C788C19EC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98B01F22DD8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCB312EBD6;
	Thu,  9 May 2024 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IYrrFcma"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA11212D758
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715297278; cv=none; b=Rvb+cm6nX8+HIgLlRJS6Qxgvj6arsqZP5BMODuv4I/ofdCHPl6RGQ6H8hMMCNmjSke3G2ywmMZ0QLqZfq9phtmGG/oOGYzPb7SLvaenHdc87zebXwK6Vy3Ca90cJp5QE3O2akscEC7Cx+TjAvsuQqETZUMmx5sHq06jMEUqw56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715297278; c=relaxed/simple;
	bh=dz1tcecyznKU4y4Zbhc8+BbLyI72tull6rQtOU9UqSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHhvH3rSk1BdO5JPh9XTolLHLcH4uIQ7WHmBs2bdPw09O7lCpIY8Zmks/BrQ5BUr1IhXI2Rgup9oFF87SpgMBXixEIfBWzDitGAP8QGgllTy7aBPS83qfgTBqWvQ/n3KvT/i2z7qBvTBVa+N6goKblimHPhzQfwuftB7J5nELGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IYrrFcma; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61be74097cbso15141457b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 16:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715297275; x=1715902075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjAF/yRSqqrlh3jHbUDFBym4ZWG5WyWadBqM5Gs3okc=;
        b=IYrrFcma7/SuSvHv3iIuOdlcsN+i5pqlvZ0i5vaqseFcrLwituiYu+MGqTrMPAlNRy
         kg7f7YfndG1Qi8VwGh7NSRuMs9dhrtFgHj88RekwbSLSXBmDGHN8azo67qEWH/V6tkAB
         AQNsCf824RaISE1DBLz5JPL2Q0f5ppwLX3ZZtB0mlqjOPD7ZLWqcjIvYk9/UtEBHJRF1
         to46tOwbvWE6OhJJFJhpDo+BO0uwlkI/CJQHjDSkl07g5TT/y3bimCfxK/kZfyk4Ck+m
         Vwff2MHmTVTM0RbA8tZcJjWDhoLg4T+812esJ+Dr4CE6c86QStoOYnoh7Y9PMc70QmTw
         4dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715297275; x=1715902075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjAF/yRSqqrlh3jHbUDFBym4ZWG5WyWadBqM5Gs3okc=;
        b=bIvLNNxN1DWHd3TjD3C+TiFnsBelKnA47Sr6lnufFiX+5CxzadfSe5l7jR0A5tiCW7
         zQwIRl5R0ROjrtyyWWbSHEciwAx1WxxskZRVTuYOnYJEG2pbE/+69wbnOxINCipNkvgN
         iUaGu7PA79h8cAfN6gZV9yZ/ErvIlmzZ6ux3UYMO8eXvakrucCrtP5iSW1unBcl/Ihwv
         8qny9u4qdEotHckZTz6rJ0JqpvqXESmrm3FfhAzj9YM7uzElwvKDtw5a/7jh7yl+l5W4
         DVqyafgKvB5vtupUsgjAyb+CXgdXcPR1grRb23NG2r90fJ5V/pITuiCWBPEPfgE3hjTh
         5LZw==
X-Forwarded-Encrypted: i=1; AJvYcCUk1t0bIfa1bnlxUpp9jLLSJsoKTvBVUpzn7C5r46Nvye7BoEEbrmSjjiPDR9e3ifPhrsDMF5c/vfqhfSZxY3u5GzIYfilERGFh4EgJ
X-Gm-Message-State: AOJu0YxXRnLciPdYENAkhmX7EkW2cp2Rz4++R2qYcNdlBnZCGY9ROoyZ
	DfiUXNj9BqBMhbWDaBQwHpUwPbBDnDb+p46Qs7rOyJp39jXGrndEFz4IA3kok3NQKx5M5LMN9r3
	4yhbqTeH9unih0dN4Do4OrQmfMBHHLFfg8aFC
X-Google-Smtp-Source: AGHT+IEoBEfVs9G/vw8jClslpq1DNg0Gtk4dNmsuGg3BMS0UuT2kiSa25ix9iCadn/rfdKuB3oODzPuz6EJTjfSznqM=
X-Received: by 2002:a05:690c:4b0c:b0:61b:763e:6831 with SMTP id
 00721157ae682-622affc57admr12336587b3.27.1715297274156; Thu, 09 May 2024
 16:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f5f83206180101e7@google.com>
In-Reply-To: <000000000000f5f83206180101e7@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 May 2024 19:27:43 -0400
Message-ID: <CAHC9VhSinu25_9evZZmLaiJL=R-LNOmB+Yz-3NtdMi5b+vQiRg@mail.gmail.com>
Subject: Re: [syzbot] [audit?] BUG: unable to handle kernel NULL pointer
 dereference in kauditd_hold_skb
To: syzbot <syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com>
Cc: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 4:14=E2=80=AFAM syzbot
<syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6d7ddd805123 Merge tag 'soc-fixes-6.9-3' of git://git.ker=
n..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10c901b898000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D758bb5b8f724c=
7ba
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8ffdaad8822cadf=
6ff4e
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40
> userspace arch: arm
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17ed19b8980=
000

Is syzbot no longer providing reproducers in C?  I see the syzbot
reproducer but no vanilla C code ...

> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8=
ead8862021c/non_bootable_disk-6d7ddd80.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4c2b52b97a0d/vmlinu=
x-6d7ddd80.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/73131a832637/z=
Image-6d7ddd80.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com
>
> audit: type=3D1400 audit(66.700:100): avc:  denied  { ioctl } for  pid=3D=
3015 comm=3D"syz-executor.1" path=3D"/dev/loop1" dev=3D"devtmpfs" ino=3D636=
 ioctlcmd=3D0x4c01 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:ob=
ject_r:device_t tclass=3Dblk_file permissive=3D1
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
000 when read
> [00000000] *pgd=3D80000080004003, *pmd=3D00000000
> Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 30 Comm: kauditd Not tainted 6.9.0-rc7-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at printk_get_level include/linux/printk.h:21 [inline]
> PC is at printk_parse_prefix+0xc/0x90 kernel/printk/printk.c:2137
> LR is at printk_sprint+0x10c/0x164 kernel/printk/printk.c:2177
> pc : [<802bc524>]    lr : [<802bc6b4>]    psr: 60000093
> sp : df8d9d70  ip : df8d9d80  fp : df8d9d7c
> r10: 8262a180  r9 : 00000000  r8 : 00000000
> r7 : df8d9dc8  r6 : 00000000  r5 : 00000000  r4 : 00000000
> r3 : df8d9ebc  r2 : 00000000  r1 : 00000000  r0 : 00000000
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 84b70e80  DAC: fffffffd
> Register r0 information: NULL pointer
> Register r1 information: NULL pointer
> Register r2 information: NULL pointer
> Register r3 information: 2-page vmalloc region starting at 0xdf8d8000 all=
ocated at kernel_clone+0xac/0x3cc kernel/fork.c:2797
> Register r4 information: NULL pointer
> Register r5 information: NULL pointer
> Register r6 information: NULL pointer
> Register r7 information: 2-page vmalloc region starting at 0xdf8d8000 all=
ocated at kernel_clone+0xac/0x3cc kernel/fork.c:2797
> Register r8 information: NULL pointer
> Register r9 information: NULL pointer
> Register r10 information: non-slab/vmalloc memory
> Register r11 information: 2-page vmalloc region starting at 0xdf8d8000 al=
located at kernel_clone+0xac/0x3cc kernel/fork.c:2797
> Register r12 information: 2-page vmalloc region starting at 0xdf8d8000 al=
located at kernel_clone+0xac/0x3cc kernel/fork.c:2797
> Process kauditd (pid: 30, stack limit =3D 0xdf8d8000)
> Stack: (0xdf8d9d70 to 0xdf8da000)
> 9d60:                                     df8d9d9c df8d9d80 802bc6b4 802b=
c524
> 9d80: 00000000 00000000 dddc5595 00000000 df8d9e24 df8d9da0 802bc918 802b=
c5b4
> 9da0: 81fce794 df8d9ebc 8029d704 0000000f ac9b579a df8d9dc0 0000001e 81fc=
e794
> 9dc0: 60000013 00000005 00000000 df8d9ebc 8263bdf8 00000000 00000000 8262=
a22c
> 9de0: 60000093 3fffe339 00000000 75613501 00746964 3d7ed298 df8d9e44 0000=
0000
> 9e00: ffffffff 82622ec4 00000000 00000000 00000000 81fce794 df8d9e64 df8d=
9e28
> 9e20: 802bda40 802bc718 df8d9ebc 3d7ed298 df8d9e7c 82ee8000 df8d9e6c 82ee=
8000
> 9e40: 85080000 00000000 8033fd34 8462d6c0 00000000 00000000 df8d9e7c df8d=
9e68
> 9e60: 802bdbdc 802bd948 df8d9ebc df8d9e78 df8d9e9c df8d9e80 802bec18 802b=
dbc0
> 9e80: 81893374 818cdd00 8462d6c0 ffffff91 df8d9eb4 df8d9ea0 818a62e0 802b=
ebb0
> 9ea0: df8d9ebc 3d7ed298 df8d9ee4 df8d9ec8 803404e4 818a62bc 81fce794 0000=
0579
> 9ec0: 85080010 00000000 826fb6ec 8462d6c0 00000000 8033fd34 df8d9f24 df8d=
9ee8
> 9ee0: 8033ff54 80340414 df8d9f04 00000001 00000000 8289fa50 df8d9f24 826f=
b6ec
> 9f00: 8289f9f8 00000000 00000000 82e98300 00000000 00000000 df8d9f84 df8d=
9f28
> 9f20: 8034080c 8033fe64 8033fd34 80340408 8027cd5c 80340408 8033fcdc 8033=
fd34
> 9f40: 00000000 82ee8000 802a5074 df8d9f4c df8d9f4c 3d7ed298 df8d9f84 82f2=
6480
> 9f60: 82ee8000 8034058c 00000000 82e98300 df819e50 00000000 df8d9fac df8d=
9f88
> 9f80: 802702a0 80340598 82f26480 8027019c 00000000 00000000 00000000 0000=
0000
> 9fa0: 00000000 df8d9fb0 80200104 802701a8 00000000 00000000 00000000 0000=
0000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 0000=
0000
> Call trace:
> [<802bc518>] (printk_parse_prefix) from [<802bc6b4>] (printk_sprint+0x10c=
/0x164 kernel/printk/printk.c:2177)
> [<802bc5a8>] (printk_sprint) from [<802bc918>] (vprintk_store+0x20c/0x450=
 kernel/printk/printk.c:2279)
>  r7:00000000 r6:dddc5595 r5:00000000 r4:00000000
> [<802bc70c>] (vprintk_store) from [<802bda40>] (vprintk_emit+0x104/0x278 =
kernel/printk/printk.c:2329)
>  r10:81fce794 r9:00000000 r8:00000000 r7:00000000 r6:82622ec4 r5:ffffffff
>  r4:00000000
> [<802bd93c>] (vprintk_emit) from [<802bdbdc>] (vprintk_default+0x28/0x30 =
kernel/printk/printk.c:2363)
>  r10:00000000 r9:00000000 r8:8462d6c0 r7:8033fd34 r6:00000000 r5:85080000
>  r4:82ee8000
> [<802bdbb4>] (vprintk_default) from [<802bec18>] (vprintk+0x74/0x94 kerne=
l/printk/printk_safe.c:45)
> [<802beba4>] (vprintk) from [<818a62e0>] (_printk+0x34/0x58 kernel/printk=
/printk.c:2373)
>  r6:ffffff91 r4:8462d6c0
> [<818a62ac>] (_printk) from [<803404e4>] (kauditd_printk_skb kernel/audit=
c:546 [inline])
> [<818a62ac>] (_printk) from [<803404e4>] (kauditd_hold_skb+0xdc/0xf8 kern=
el/audit.c:581)
>  r3:00000000 r2:85080010 r1:00000579 r0:81fce794
> [<80340408>] (kauditd_hold_skb) from [<8033ff54>] (kauditd_send_queue+0xf=
c/0x16c kernel/audit.c:766)
>  r7:8033fd34 r6:00000000 r5:8462d6c0 r4:826fb6ec
> [<8033fe58>] (kauditd_send_queue) from [<8034080c>] (kauditd_thread+0x280=
/0x2d8 kernel/audit.c:890)
>  r10:00000000 r9:00000000 r8:82e98300 r7:00000000 r6:00000000 r5:8289f9f8
>  r4:826fb6ec
> [<8034058c>] (kauditd_thread) from [<802702a0>] (kthread+0x104/0x134 kern=
el/kthread.c:388)
>  r10:00000000 r9:df819e50 r8:82e98300 r7:00000000 r6:8034058c r5:82ee8000
>  r4:82f26480
> [<8027019c>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/ar=
m/kernel/entry-common.S:134)
> Exception stack(0xdf8d9fb0 to 0xdf8d9ff8)
> 9fa0:                                     00000000 00000000 00000000 0000=
0000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8027019c r4:82f26480
> Code: e89da800 e1a0c00d e92dd800 e24cb004 (e5d03000)
> ---[ end trace 0000000000000000 ]---

It would be nice to see the C version of the reproducer to try and
debug this, but I'm somewhat skeptical that this is an audit issue as
this chunk of code hasn't changed in some time and I would have
expected syzbot to hit any issues with this code well before now.

--=20
paul-moore.com

