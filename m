Return-Path: <linux-kernel+bounces-413356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD209D1811
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050AA282ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3051E0DF4;
	Mon, 18 Nov 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOmecg0P"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030A2E3EB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954499; cv=none; b=GWMUHnSgeF693c8TTjBmLr/DPgaRdu2K5RBR14Bhi6zWLTiI8bmhC/zifzEqXqEr7DX+f2JY81dVVq88lLXi8CihDpahYGYkCKj7axrrf/OW5mAFdRMu8JdazY5v6rDUCrTp86+sfc0HvzZV95z4FGY7lfXG9al1jSyWDvDahu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954499; c=relaxed/simple;
	bh=OVmd4B2Py/CK8hsegerm1zvbTenDemOZofpp13JbFPU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rO7EJjTEC4AaPmXjOGcWOQxP16nhceTkrftqcCxsDgPbNmHQ9/ZDvJ5EygbYO6RFKX+/XENh6A66epw+yRC4pQQrVzxP/nPO0lrze4hDMEslWvwOic1PaTCZMJZP8VJHzUPGH2KfqXvZOI/1D/DTGMgGNehVurAmJfP5mZB0yic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOmecg0P; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83b430a4cfdso2760639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731954496; x=1732559296; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WKxUgmJ8YEN4+fzjwyJhbS+iHMcs0Y+0QP5Lgxe7JwU=;
        b=aOmecg0P/jRmgbI1FhoY2mo3+WVqN9/7ZTJk2xI8PiZMUZDF8D2B8MlKoKHLnhHeJl
         EwL9Z8i/aQMggsLQb1nKB6b/l/LlyBIyySodC0UQr30ljCM2r1XX/6D8k9ljm0lrzEFS
         pX36rZKk2iaEtXclPBPhXECE4RGMZcC+YTAHWQkPco9orio+aAlmGxzKuukTpkh3ldPe
         3CPRqAaYZAZq9SL/5jkVWjKWw0czHPldAfRAsohY8IOjL5cIWAGyrJp5G1IgL9p+RFTA
         Nc+CGgqUnkdUTHv7o/les41idJmUTvLHnYLgJ1vPdHmAlgTj8jzEGLQuJQANQkHLAFUx
         4RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731954496; x=1732559296;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKxUgmJ8YEN4+fzjwyJhbS+iHMcs0Y+0QP5Lgxe7JwU=;
        b=mbTAfY4uO1LL4DnzEbEOMW1+osF2HNRpPo/ujWEViBekuxEq3Rkmx6+9/Rx1k+QHBT
         pVpUKkiEHSaImtLb42rKp5zIuj6vAMf9nl3tzsnfEdWJ+8KQZPDAMgt9QK1Wg8+cx/Ne
         iw8GIYjMj451/F9WkVFZZneP3fq/ChX7aQtI4Sa9YmHlL2GDxbCrqG/Ljq8TGA1pdqqB
         vVRLP+LPAnPNlvhp9lQhTd1QAanaUKbCbPwREthBE0VxKXa23vNHYybiCwRxuy5L6m+6
         o42F0B4KUiSvCDYCa3E/REkOSCfFYRZL0Tx6G85ckkDvWKbqbOCi9sOlq9bqrxmnCgNP
         YK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb0iQyMazgQdYnpICRva1EaCqWnFphXgmreWIxAfkiNRH0BULbDFwZQpe4flVabnuSL5e/vS+bm60uJdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkx824anzIm0w5AtmnGjXS6ph0l13x40+MnF8RmeTq/GTasfV
	USkOPUOmV287lMsQ0X4vdbsTJFZhG4NaJrsJN3AT6j649iBZysTtMQgq1OCd+LiCvrteGfOpUWd
	v38MTWxdaoJIqY18C8gdv6dZs5oozOaC9
X-Google-Smtp-Source: AGHT+IFnruqOWZUGwQ14X6b0cgUPUS6suv6gu0bP1IkpYy1adtAwU5k2XYDvl6qMinAoVFupTRAROpjO5iwguA1AUKg=
X-Received: by 2002:a05:6602:29cd:b0:83a:9f64:6c75 with SMTP id
 ca18e2360f4ac-83e6c2641b1mr1659061639f.3.1731954496407; Mon, 18 Nov 2024
 10:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Mon, 18 Nov 2024 13:28:04 -0500
Message-ID: <CA+-ZZ_jGP42Kt=2MFJ7-JXFtkba+gXVKSn9Ey1LBFnJxaqSOpg@mail.gmail.com>
Subject: Report "KASAN: null-ptr-deref in __rb_erase_color"
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

We found a kernel crash at `__rb_erase_color` when running a test generated
by Syzkaller on Linux kernel 6.10, both of which are unmodified. We would l=
ike
to report it for your reference because this crash has not been observed be=
fore.

This crash is likely due to a concurrency bug because it requires running t=
he
test, which repeatedly executes system calls, for a few minutes to trigger.

This report comes with:
- the console log of the guest VM
- the test (syzlang syntax)
- the test (c program) (url)
- the compiled test (url)
- kernel configuration (url)
- the compiled kernel (url)


- Crash
syzkaller login: [   90.703937] loop1: detected capacity change from 0 to 2=
048
[   90.706327] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO
[  153.091671] ata1: lost interrupt (Status 0x58)
[  154.135548] clocksource: Long readout interval, skipping watchdog
check: cs_nsec: 1103985354 wd_nsec: 1103985308
[  154.295963] ata1: found unknown device (class 0)
[  154.300620] BUG: Bad rss-counter state mm:00000000a161b843
type:MM_FILEPAGES val:159
[  154.302952] BUG: Bad rss-counter state mm:00000000a161b843
type:MM_ANONPAGES val:13
[  154.305174] BUG: non-zero pgtables_bytes on freeing mm: 8192
[  154.320256] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO
[  214.531549] ata1: lost interrupt (Status 0x58)
[  215.751874] ata1: found unknown device (class 0)
[  215.769343] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO
[  280.059705] ata1: lost interrupt (Status 0x58)
[  281.351944] ata1: found unknown device (class 0)
[  281.362860] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO
[  341.499646] ata1: lost interrupt (Status 0x58)
[  342.530588] ata1.00: limiting speed to MWDMA1:PIO4
[  342.687867] ata1: found unknown device (class 0)
[  342.696934] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO
[  402.947532] ata1: lost interrupt (Status 0x58)
[  404.191938] ata1: found unknown device (class 0)
[  404.202275] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO
[  468.475663] ata1: lost interrupt (Status 0x58)
[  469.671959] ata1: found unknown device (class 0)
[  469.681397] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO
[  529.915667] ata1: lost interrupt (Status 0x58)
[  531.127989] ata1: found unknown device (class 0)
[  531.140982] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO
[  591.363666] ata1: lost interrupt (Status 0x58)
[  592.437779] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
PTI
[  592.440735] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
[  592.442545] CPU: 0 PID: 143 Comm: in:imuxsock Not tainted 6.10.0 #2
[  592.444076] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  592.446257] RIP: 0010:__rb_erase_color+0x15d/0x11f0
[  592.447551] Code: 89 ee 48 89 c5 e9 f2 fe ff ff 4c 8d 45 10 4c 89
c0 48 c1 e8 03 80 3c 18 00 0f 85 7c 0a 00 00 4c 8b 65 10 4c 89 e0 48
c19
[  592.452437] RSP: 0018:ffff88800cc7f8c0 EFLAGS: 00010246
[  592.454124] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 1ffff110012=
c6d91
[  592.456342] RDX: ffffffff81617b80 RSI: ffff888007348cc8 RDI: ffff8880096=
36c78
[  592.458501] RBP: ffff888009636c78 R08: ffff888009636c88 R09: ffffed1000e=
691a4
[  592.460734] R10: ffffed1000e691a3 R11: ffff888007348d1f R12: 00000000000=
00000
[  592.462944] R13: ffffed1000e69199 R14: 0000000000000000 R15: ffff8880073=
48cc8
[  592.465136] FS:  0000000000000000(0000) GS:ffff88806d200000(0000)
knlGS:0000000000000000
[  592.467607] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  592.469449] CR2: 0000000000000000 CR3: 0000000004e66000 CR4: 00000000000=
006f0
[  592.471678] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  592.473909] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  592.476150] Call Trace:
[  592.476949]  <TASK>
[  592.477632]  ? show_regs+0x73/0x80
[  592.478735]  ? __die_body+0x1f/0x70
[  592.479865]  ? die_addr+0x4c/0x90
[  592.481047]  ? exc_general_protection+0x15c/0x2a0
[  592.482549]  ? asm_exc_general_protection+0x26/0x30
[  592.484114]  ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
[  592.486011]  ? __rb_erase_color+0x15d/0x11f0
[  592.487424]  vma_interval_tree_remove+0x6d2/0xe40
[  592.488818]  ? __pfx_down_write+0x10/0x10
[  592.489823]  ? unlink_anon_vmas+0x462/0x770
[  592.490868]  unlink_file_vma+0x80/0xb0
[  592.491846]  free_pgtables+0x2b6/0x750
[  592.492787]  exit_mmap+0x299/0x810
[  592.493650]  ? __pfx_exit_mmap+0x10/0x10
[  592.494631]  ? exit_aio+0x260/0x340
[  592.495542]  ? delayed_uprobe_remove+0x21/0x130
[  592.496788]  mmput+0x64/0x290
[  592.497801]  do_exit+0x7fd/0x2850
[  592.498892]  ? __pfx_try_to_wake_up+0x10/0x10
[  592.500296]  ? plist_del+0x18e/0x3f0
[  592.501440]  ? sysvec_apic_timer_interrupt+0xf/0x90
[  592.502996]  ? __pfx_do_exit+0x10/0x10
[  592.504233]  do_group_exit+0xb6/0x260
[  592.505395]  get_signal+0x19e3/0x1b00
[  592.506450]  ? __pfx_mm_cid_get+0x10/0x10
[  592.507687]  ? __pfx_get_signal+0x10/0x10
[  592.508979]  ? do_futex+0xfd/0x330
[  592.510083]  arch_do_signal_or_restart+0x81/0x750
[  592.511591]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[  592.513158]  ? __x64_sys_futex+0x1b1/0x400
[  592.514461]  ? __x64_sys_futex+0x1ba/0x400
[  592.515770]  ? __x64_sys_poll+0xf6/0x470
[  592.517006]  ? __pfx___x64_sys_poll+0x10/0x10
[  592.518390]  syscall_exit_to_user_mode+0xf6/0x140
[  592.519892]  do_syscall_64+0x57/0x110
[  592.521070]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  592.522667] RIP: 0033:0x7f9dd268196f
[  592.523851] Code: Unable to access opcode bytes at 0x7f9dd2681945.
[  592.525743] RSP: 002b:00007f9dd2201cf0 EFLAGS: 00000293 ORIG_RAX:
0000000000000007
[  592.527947] RAX: fffffffffffffdfc RBX: 0000000000000002 RCX: 00007f9dd26=
8196f
[  592.529679] RDX: 00000000ffffffff RSI: 0000000000000001 RDI: 00007f9dcc0=
00b80
[  592.531421] RBP: 0000000000000058 R08: 0000000000000000 R09: 000055a70c7=
c5e68
[  592.533244] R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000=
00000
[  592.535373] R13: 00007f9dcc000b80 R14: 000055a6f41caa50 R15: 00007f9dd22=
d5840
[  592.537201]  </TASK>
[  592.537781] Modules linked in:
[  592.538790] ---[ end trace 0000000000000000 ]---
[  592.540002] RIP: 0010:__rb_erase_color+0x15d/0x11f0
[  592.541251] Code: 89 ee 48 89 c5 e9 f2 fe ff ff 4c 8d 45 10 4c 89
c0 48 c1 e8 03 80 3c 18 00 0f 85 7c 0a 00 00 4c 8b 65 10 4c 89 e0 48
c19
[  592.545761] RSP: 0018:ffff88800cc7f8c0 EFLAGS: 00010246
[  592.547108] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 1ffff110012=
c6d91
[  592.548891] RDX: ffffffff81617b80 RSI: ffff888007348cc8 RDI: ffff8880096=
36c78
[  592.550682] RBP: ffff888009636c78 R08: ffff888009636c88 R09: ffffed1000e=
691a4
[  592.552491] R10: ffffed1000e691a3 R11: ffff888007348d1f R12: 00000000000=
00000
[  592.554286] R13: ffffed1000e69199 R14: 0000000000000000 R15: ffff8880073=
48cc8
[  592.556082] FS:  0000000000000000(0000) GS:ffff88806d200000(0000)
knlGS:0000000000000000
[  592.558086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  592.559571] CR2: 0000000000000000 CR3: 0000000004e66000 CR4: 00000000000=
006f0
[  592.561380] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  592.563187] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  592.564961] Fixing recursive fault but reboot is needed!
[  592.566322] BUG: scheduling while atomic: in:imuxsock/143/0x00000000
[  592.567925] Modules linked in:
[  592.568756] CPU: 0 PID: 143 Comm: in:imuxsock Tainted: G      D
       6.10.0 #2
[  592.570680] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  592.572893] Call Trace:
[  592.573528]  <TASK>
[  592.574097]  dump_stack_lvl+0x7d/0xa0
[  592.575038]  __schedule_bug+0xaa/0xf0
[  592.575968]  ? irq_work_queue+0x23/0x60
[  592.576931]  __schedule+0x17ce/0x2010
[  592.577864]  ? __wake_up_klogd.part.0+0x69/0x80
[  592.578996]  ? vprintk_emit+0x239/0x300
[  592.579982]  ? __pfx___schedule+0x10/0x10
[  592.580989]  ? vprintk+0x6b/0x80
[  592.581828]  ? _printk+0xbf/0x100
[  592.582677]  ? __pfx__printk+0x10/0x10
[  592.583625]  ? _raw_spin_lock_irqsave+0x86/0xe0
[  592.584764]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  592.586028]  ? __pfx___x64_sys_poll+0x10/0x10
[  592.587132]  do_task_dead+0x9d/0xc0
[  592.588019]  make_task_dead+0x2f6/0x340
[  592.588984]  rewind_stack_and_make_dead+0x16/0x20
[  592.590158] RIP: 0033:0x7f9dd268196f
[  592.591075] Code: Unable to access opcode bytes at 0x7f9dd2681945.
[  592.591988] ata1: found unknown device (class 0)
[  592.592604] RSP: 002b:00007f9dd2201cf0 EFLAGS: 00000293 ORIG_RAX:
0000000000000007
[  592.592612] RAX: fffffffffffffdfc RBX: 0000000000000002 RCX: 00007f9dd26=
8196f
[  592.592615] RDX: 00000000ffffffff RSI: 0000000000000001 RDI: 00007f9dcc0=
00b80
[  592.592618] RBP: 0000000000000058 R08: 0000000000000000 R09: 000055a70c7=
c5e68
[  592.592621] R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000=
00000
[  592.592624] R13: 00007f9dcc000b80 R14: 000055a6f41caa50 R15: 00007f9dd22=
d5840
[  592.592629]  </TASK>
[  592.613008] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO
[  652.803528] ata1: lost interrupt (Status 0x58)
[  654.024010] ata1: found unknown device (class 0)
[  654.039570] program syz-executor is using a deprecated SCSI ioctl,
please convert it to SG_IO


- syzlang test
prctl$PR_SET_MM_AUXV(0x23, 0xc, &(0x7f0000000e80)=3D"84", 0x1)
r0 =3D syz_open_dev$sg(&(0x7f0000000000), 0x0, 0x0)
rseq(&(0x7f0000000000), 0x20, 0x0, 0x0)
ioctl$KDENABIO(0xffffffffffffffff, 0x4b36)
signalfd(0xffffffffffffffff, 0x0, 0x0)
syz_mount_image$msdos(&(0x7f0000000500),
&(0x7f0000000540)=3D'./file0\x00', 0x0, &(0x7f00000002c0)=3DANY=3D[], 0x1,
0x522, &(0x7f0000000580)=3D"$eJzs1zGL02AYB/An16qH083i8IKL03G6uZ1IDw4DgtJBJw=
tXl0bEZkk79RP4CfyQ0kFui2jKnRWFG+wlJb/fkj/554XnzZCXvH/4cXbxqfzw+cvXODzNYngac=
XCZxVEcxCAaq7j2vQ4AYM9d1nV8q3/Jhm0PAwDcit/Of3/2ANATzn8A6B/nPwD0z5u3714+z/PR=
65QOI9aralyNm2vTn53no5OUUtpata6q8eCqf5Ia2/2duL/pn/61vxuPHzX9z+7Fq/yP/l5c7Hj=
vAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAADQd8fpytH13XVVjQdNf/yvvkln5/noZPPAdj+MB8Nb2wYAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAADwH5SL5WxSFNO5sDeh3ujKPJ0Pz6L1MbKIVUfexg1D218mAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACgLeV=
iOZsUxXRe3nBBlu14IgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACgbeViOZsUxXS+w9D2Hg=
EAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgG76EQAA//9xKFC/")
mkdir(&(0x7f0000000000)=3D'.\x00', 0x0)
mknod$loop(&(0x7f0000000000)=3D'./file0\x00', 0x0, 0x0)
ioctl$SCSI_IOCTL_SEND_COMMAND(r0, 0x1,
&(0x7f0000000040)=3DANY=3D[@ANYBLOB=3D"00000000420d0000850aaa",
@ANYRESHEX=3Dr0])

- c test
https://docs.google.com/document/d/1t9QaPHpOqHYOPfUhXVvjGErvE4s6fkZIm5PBsz_=
6oUI/view?usp=3Dsharing

- compiled test (please run inside VM)
https://drive.google.com/file/d/1qnMi9BxVlL-CVDeXeNtVeFLPL9srSbT6/view?usp=
=3Dsharing

- kernel config
https://drive.google.com/file/d/1LMJgfJPhTu78Cd2DfmDaRitF6cdxxcey/view?usp=
=3Dsharing

- compiled kernel
https://drive.google.com/file/d/1B22XKuDqrtk8gvWFFEMXR0o-VcVdYvB4/view?usp=
=3Dsharing

