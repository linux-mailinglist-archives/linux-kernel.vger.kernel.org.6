Return-Path: <linux-kernel+bounces-258894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3EB938DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36231281743
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921ED16CD1F;
	Mon, 22 Jul 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S/XLcyWn"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3A16CD19
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646849; cv=none; b=WVjKlggtz0ITfkZ7R4oPL9j0+IDCfr49O35r5JBJ3Z/ldV9UewATd1OL/ouIRxAukTLXnIOOPYyRQp2khwhMiZcC8g8/fFJtkahC1iD8n/1fmZE+++3Zwo/zfqIRyBO+pMMnb+m6vob69GhtRb2/hR5P0oA6s77FDX+dSjzYujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646849; c=relaxed/simple;
	bh=Lx1df/P1YIPn1K2EDzNkCNWL6DIk//CqJwytFoey0KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGnIU9X1WJaE/qOk3Q0Xm5w0s+cXkzcgfqkBulEPHo3RwDuRQ/drkv654j2Rb6y/+voJt8BOekDOFE6JfcCLu8szqPF73ipJ9WP9N0iCg2QpKj2Sb7QYPkb0CygcHbr7AA0Lo+BBl+mSx5PNZs3yX4HEC5Z0zTI5YDfjXVFrKg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S/XLcyWn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e9a550e9fso3347652e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721646845; x=1722251645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZXKLz5P0ywNhoP8JTwYu3CGZOE/ombj7NQm0gRurZc=;
        b=S/XLcyWndAcZDBen+5notzMd89WEjYiSefv7Xm9vFZGKW+3JODQjrcA422p5S8fx5U
         5UqysJqWwJKHILURsnEkAnp3Pijpm5CZz7xxs0cKJIyL2Sm5lvSP1S0nM3Ed6Xg+u3+q
         DSvezdYbRGMAK24LKRTNkSWr5ytCiVwP+neoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721646845; x=1722251645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZXKLz5P0ywNhoP8JTwYu3CGZOE/ombj7NQm0gRurZc=;
        b=uQb503BPsyP4GAi80Gb3IfzHZVw4EhzeEsMqfjF97F8nP+UAIm392GAaJy3jZ63YFD
         lUZM0k4EfsMXSov4ci0BNmS7JewnpyYMTvsImeLHTRbwp2lV/+OCwfEykWX/AiHD67TL
         4XRkbwNZhJjj9f5lxF7PiRhauFpgxXDltJZkmVyWiY9UXjhZv6Z2LrICPXbBF8fyt6J+
         ttPkMUCHXGN4k5CVJJFM7ZbPwzc2YxhY2gHY2pvRXrwjMvpj8joP7yPae6uX9+aKIcqg
         7IGyXdGPELJaJVAIcDKAJqTkBISaqEQT0A3knSBMVh9QPhsilX9M/KK1XxlmZKCzY0qO
         V6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXhtEajBnqLo52kERbvWGAFz1xUxNFCnsaYzaMoB63QhKKdVhHsyPPp+V5DlzZp+ZP1RTIgwrpeVGIYKGXBefiQmXkiwnWQ45g2IPXL
X-Gm-Message-State: AOJu0YxgyE7GBd0ctniqhNGoTDmPqMZ/qaSmyeZRAapb4w23JaGf2IFs
	kwdeE6jOv5g7ZbLeRJIejN1ASolgBkQrFhcZYBvT9WuRFqM+LV42eobnxoJTinAddAi5pKG7dgm
	qaHHnl1KiXfXkO/z/7YnXKiQFpmUBofI35y0F
X-Google-Smtp-Source: AGHT+IFGuuTqrpDONyESpB2eij3Xy7ahNtfI4rTGFC3pPCpy6bUi8Xwm55MEoYvW2Jq69p2dznPY1gEzgyevW711/N4=
X-Received: by 2002:a05:6512:6c4:b0:52c:81ba:aeba with SMTP id
 2adb3069b0e04-52ef8a0c3c2mr1729458e87.14.1721646844820; Mon, 22 Jul 2024
 04:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719204701.1605950-1-minipli@grsecurity.net>
In-Reply-To: <20240719204701.1605950-1-minipli@grsecurity.net>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Mon, 22 Jul 2024 16:43:52 +0530
Message-ID: <CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
Subject: Re: tracing: user events UAF crash report
To: Mathias Krause <minipli@grsecurity.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	=?UTF-8?B?SWxra2EgTmF1bGFww6TDpA==?= <digirigawa@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@leemhuis.info, Dan Carpenter <dan.carpenter@linaro.org>, 
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 2:17=E2=80=AFAM Mathias Krause <minipli@grsecurity.=
net> wrote:
>
> Hi Steven, Ajay,
>
> [ @Cc list: I found out issues with tracefs have been reported /
>   attempted to get fixed in the past, so you may be interested. ]
>
> I noticed, the user events ftrace selftest is crashing every now and
> then in our automated tests. Digging into, I found that the following
> is triggering the issue very reliable:
>
> - in one shell, as root:
>   # while true; do ./kselftest/user_events/ftrace_test; done
>
> - in a second shell, again as root:
>   # cd /sys/kernel/tracing
>   # while true; do cat events/user_events/__test_event/format; done 2>/de=
v/null
>

Tried to reproduced on 6.10.0-rc7-100.ph5+, only getting repeated output as=
:

# while true; do cat events/user_events/__test_event/format; done 2>/dev/nu=
ll
print fmt: ""
name: __test_event
ID: 2390
format:
field:unsigned short common_type; offset:0; size:2; signed:0;
field:unsigned char common_flags; offset:2; size:1; signed:0;
field:unsigned char common_preempt_count; offset:3; size:1; signed:0;
field:int common_pid; offset:4; size:4; signed:1;

# while true; do ./kselftest/user_events/ftrace_test; done
TAP version 13
1..6
# Starting 6 tests from 1 test cases.
#  RUN           user.register_events ...
#            OK  user.register_events
ok 1 user.register_events
#  RUN           user.write_events ...
#            OK  user.write_events
ok 2 user.write_events
#  RUN           user.write_empty_events ...
#            OK  user.write_empty_events
ok 3 user.write_empty_events
#  RUN           user.write_fault ...
#            OK  user.write_fault
ok 4 user.write_fault
#  RUN           user.write_validator ...
#            OK  user.write_validator
ok 5 user.write_validator
#  RUN           user.print_fmt ...
#            OK  user.print_fmt
ok 6 user.print_fmt
# PASSED: 6 / 6 tests passed.
# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Am I missing any step?

> Ignoring that the selftest fails for half of its tests -- which is a
> regression and therefore yet another bug, I guess -- this triggers an
> access fault (GFP/PF/NULL deref) after a few iterations, usually within
> a minute, mostly mere seconds. With KASAN enabled it generates a splat
> almost instantly, like following:
>
> [   23.790955] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   23.791692] BUG: KASAN: slab-use-after-free in f_show+0x43b/0x470
> [   23.792244] Read of size 8 at addr ffff888007076878 by task cat/755
> [   23.792753]
> [   23.792947] CPU: 1 PID: 755 Comm: cat Tainted: G      D          N 6.1=
0.0-vanilla-dirty #30
> [   23.793563] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   23.794280] Call Trace:
> [   23.794470]  <TASK>
> [   23.794642]  dump_stack_lvl+0x66/0xa0
> [   23.794909]  print_report+0xd0/0x630
> [   23.795180]  ? f_show+0x43b/0x470
> [   23.795415]  ? __virt_addr_valid+0x208/0x3f0
> [   23.795700]  ? f_show+0x43b/0x470
> [   23.795935]  kasan_report+0xd8/0x110
> [   23.796183]  ? f_show+0x43b/0x470
> [   23.796418]  f_show+0x43b/0x470
> [   23.796645]  seq_read_iter+0x418/0x11e0
> [   23.796907]  ? __page_table_check_ptes_set+0x166/0x1a0
> [   23.797280]  seq_read+0x261/0x350
> [   23.797537]  ? lock_release+0x453/0x600
> [   23.797819]  ? __pfx_seq_read+0x10/0x10
> [   23.798103]  ? set_ptes.isra.0+0x11b/0x150
> [   23.798402]  vfs_read+0x171/0x9e0
> [   23.798657]  ? lock_acquire+0x408/0x4b0
> [   23.798970]  ? __pfx_vfs_read+0x10/0x10
> [   23.799267]  ? lock_release+0x453/0x600
> [   23.799549]  ? do_user_addr_fault+0x45b/0x8b0
> [   23.799862]  ? __pfx_lock_release+0x10/0x10
> [   23.800162]  ? __pfx___up_read+0x10/0x10
> [   23.800448]  ksys_read+0xdd/0x1a0
> [   23.800704]  ? __pfx_ksys_read+0x10/0x10
> [   23.801007]  ? do_user_addr_fault+0x465/0x8b0
> [   23.801341]  do_syscall_64+0x66/0x130
> [   23.801615]  entry_SYSCALL_64_after_hwframe+0x71/0x79
> [   23.801959] RIP: 0033:0x7f1fdb9df40e
> [   23.802230] Code: c0 e9 b6 fe ff ff 50 48 8d 3d 2e 08 0b 00 e8 69 01 0=
2 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <=
48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> [   23.803352] RSP: 002b:00007fff86d62658 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000000
> [   23.803848] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f1fd=
b9df40e
> [   23.804302] RDX: 0000000000020000 RSI: 00007f1fdb8d3000 RDI: 000000000=
0000003
> [   23.804753] RBP: 00007f1fdb8d3000 R08: 00007f1fdb8d2010 R09: 000000000=
0000000
> [   23.805239] R10: fffffffffffffbc5 R11: 0000000000000246 R12: 000000000=
0000000
> [   23.805694] R13: 0000000000000003 R14: 0000000000020000 R15: 000000000=
0020000
> [   23.806153]  </TASK>
> [   23.806352]
> [   23.806518] Allocated by task 753:
> [   23.806781]  kasan_save_stack+0x20/0x40
> [   23.807094]  kasan_save_track+0x14/0x30
> [   23.807377]  __kasan_kmalloc+0x8f/0xa0
> [   23.807656]  user_event_parse_cmd+0x590/0x25e0
> [   23.807969]  user_events_ioctl+0xa52/0x17f0
> [   23.808267]  __x64_sys_ioctl+0x133/0x190
> [   23.808555]  do_syscall_64+0x66/0x130
> [   23.808830]  entry_SYSCALL_64_after_hwframe+0x71/0x79
> [   23.809208]
> [   23.809370] Freed by task 58:
> [   23.809609]  kasan_save_stack+0x20/0x40
> [   23.809890]  kasan_save_track+0x14/0x30
> [   23.810173]  kasan_save_free_info+0x3b/0x60
> [   23.810473]  poison_slab_object+0x10a/0x170
> [   23.810771]  __kasan_slab_free+0x14/0x30
> [   23.811090]  kfree+0xe0/0x2f0
> [   23.811338]  destroy_user_event+0x305/0x450
> [   23.811639]  delayed_destroy_user_event+0x5c/0xe0
> [   23.811965]  process_one_work+0x81c/0x1970
> [   23.812259]  worker_thread+0x608/0x1160
> [   23.812542]  kthread+0x2be/0x3b0
> [   23.812794]  ret_from_fork+0x2c/0x70
> [   23.813098]  ret_from_fork_asm+0x1a/0x30
> [   23.813387]
> [   23.813551] Last potentially related work creation:
> [   23.813885]  kasan_save_stack+0x20/0x40
> [   23.814168]  __kasan_record_aux_stack+0x8e/0xa0
> [   23.814489]  insert_work+0x20/0x1b0
> [   23.814756]  __queue_work+0x67a/0xc60
> [   23.815079]  queue_work_on+0x63/0x90
> [   23.815350]  user_event_put+0x1f9/0x390
> [   23.815631]  user_events_ioctl+0x11ed/0x17f0
> [   23.815935]  __x64_sys_ioctl+0x133/0x190
> [   23.816223]  do_syscall_64+0x66/0x130
> [   23.816498]  entry_SYSCALL_64_after_hwframe+0x71/0x79
> [   23.816841]
> [   23.817019] The buggy address belongs to the object at ffff88800707680=
0
> [   23.817019]  which belongs to the cache kmalloc-cg-512 of size 512
> [   23.817799] The buggy address is located 120 bytes inside of
> [   23.817799]  freed 512-byte region [ffff888007076800, ffff888007076a00=
)
> [   23.818530]
> [   23.818694] The buggy address belongs to the physical page:
> [   23.819092] page: refcount:1 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x7074
> [   23.819602] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped=
:0 pincount:0
> [   23.820323] memcg:ffff88800277fd01
> [   23.820595] anon flags: 0x40(head|zone=3D0)
> [   23.820885] page_type: 0xffffefff(slab)
> [   23.821203] raw: 0000000000000040 ffff88800014cdc0 0000000000000000 00=
00000000000001
> [   23.821706] raw: 0000000000000000 0000000080100010 00000001ffffefff ff=
ff88800277fd01
> [   23.822206] head: 0000000000000040 ffff88800014cdc0 0000000000000000 0=
000000000000001
> [   23.822711] head: 0000000000000000 0000000080100010 00000001ffffefff f=
fff88800277fd01
> [   23.823261] head: 0000000000000002 ffffea00001c1d01 ffffffffffffffff 0=
000000000000000
> [   23.823764] head: ffff888000000004 0000000000000000 00000000ffffffff 0=
000000000000000
> [   23.824271] page dumped because: kasan: bad access detected
> [   23.824638]
> [   23.824799] Memory state around the buggy address:
> [   23.825162]  ffff888007076700: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   23.825641]  ffff888007076780: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   23.826116] >ffff888007076800: fa fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   23.826588]                                                           =
      ^
> [   23.827070]  ffff888007076880: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   23.827545]  ffff888007076900: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   23.828018] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I did a bisect run and ended up on commit 27152bceea1d ("eventfs: Move
> tracing/events to eventfs"). This is, of cause, only the enabling
> commit. The bug is likely in one of the preceeding commits introducing
> eventfs infrastructure.
>
> The git bisect log (I jumped around a little in the beginning, but yeah,
> v6.10 is still broken):
>
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
> git bisect bad a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> # status: waiting for good commit(s), bad commit known
> # bad: [0c3836482481200ead7b416ca80c68a29cfdaabd] Linux 6.10
> git bisect bad 0c3836482481200ead7b416ca80c68a29cfdaabd
> # status: waiting for good commit(s), bad commit known
> # bad: [ffc253263a1375a65fa6c9f62a893e9767fbebfa] Linux 6.6
> git bisect bad ffc253263a1375a65fa6c9f62a893e9767fbebfa
> # status: waiting for good commit(s), bad commit known
> # good: [6995e2de6891c724bfeb2db33d7b87775f913ad1] Linux 6.4
> git bisect good 6995e2de6891c724bfeb2db33d7b87775f913ad1
> # good: [692f5510159c79bfa312a4e27a15e266232bfb4c] Merge tag 'asoc-v6.6' =
of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-l=
inus
> git bisect good 692f5510159c79bfa312a4e27a15e266232bfb4c
> # good: [0e72db77672ff4758a31fb5259c754a7bb229751] Merge tag 'soc-dt-6.6'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good 0e72db77672ff4758a31fb5259c754a7bb229751
> # bad: [5eea5820c7340d39e56e169e1b87199391105f6b] Merge tag 'mm-stable-20=
23-09-04-14-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad 5eea5820c7340d39e56e169e1b87199391105f6b
> # good: [28a4f91f5f251689c69155bc6a0b1afc9916c874] Merge tag 'driver-core=
-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-co=
re
> git bisect good 28a4f91f5f251689c69155bc6a0b1afc9916c874
> # bad: [f7e97ce26972ae7be8bbbae8d819ff311d4c5900] Merge tag 'for-linus' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
> git bisect bad f7e97ce26972ae7be8bbbae8d819ff311d4c5900
> # good: [9a5d660fdb25d20748d7f9e9559c86073c3bb368] media: ivsc: Add ACPI =
dependency
> git bisect good 9a5d660fdb25d20748d7f9e9559c86073c3bb368
> # good: [704e2c6107f1a5353a1038bac137dda0df2a6dd0] Merge tag 'icc-6.6-rc1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-mis=
c-next
> git bisect good 704e2c6107f1a5353a1038bac137dda0df2a6dd0
> # good: [bd30fe6a7d9b72e73c5ac9109cbc3066dde08034] Merge tag 'wq-for-6.6'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq
> git bisect good bd30fe6a7d9b72e73c5ac9109cbc3066dde08034
> # good: [d952f54d01ec2ea5ee9d5e21f2ea3a5807b4bcbc] RDMA/hns: Remove unuse=
d declaration hns_roce_modify_srq()
> git bisect good d952f54d01ec2ea5ee9d5e21f2ea3a5807b4bcbc
> # bad: [34232fcfe9a383bea802af682baae5c99f22376c] Merge tag 'trace-v6.6' =
of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
> git bisect bad 34232fcfe9a383bea802af682baae5c99f22376c
> # bad: [7c1130ea5cae215588e6d51242b877fd405e6c32] test: ftrace: Fix kprob=
e test for eventfs
> git bisect bad 7c1130ea5cae215588e6d51242b877fd405e6c32
> # good: [5bdcd5f5331a276a3ddf1fba8605986d0d15298a] eventfs: Implement rem=
oval of meta data from eventfs
> git bisect good 5bdcd5f5331a276a3ddf1fba8605986d0d15298a
> # bad: [27152bceea1df27ffebb12ac9cd9adbf2c4c3f35] eventfs: Move tracing/e=
vents to eventfs
> git bisect bad 27152bceea1df27ffebb12ac9cd9adbf2c4c3f35
> # first bad commit: [27152bceea1df27ffebb12ac9cd9adbf2c4c3f35] eventfs: M=
ove tracing/events to eventfs
>
> I stared quite hard at the inode/dentry/file handling and, imho, it's
> quite broken as it leaks pointers to refcounted objects which may go
> away anytime, e.g. &user->call via trace_add_event_call() in
> user_event_set_call_visible(). That'll lead to a user reachable file
> hierarchy below events/user_events/$eventname/ that isn't bound to the
> creator's mm.
>
> Assume one process opens events/user_events/$eventname/format, then the
> walked fields -- the whole object, actually -- may go away anytime, once
> the creator either removes the user probe again or closes its fd to
> /sys/kernel/tracing/user_events_data, leading to user_events_release()
> doing the final user_event_put() leading to object destruction. The
> concurrent reader of events/user_events/$eventname/format will now
> operate on a free'd object. Boom!
>
> As mentioned, I stared quite hard at the code and tried to fix it via
> numerous ways but the core issue is, imho, the lack of refcounting the
> &user->call object, or even better, 'user', for the files created below
> events/user_events/$eventname/. However, I found no easy way to do that.
>
> My hopes are, you may be able to, now that there's an easy reproducer.
>
> Beside the obvious bug, I noticed the following (not fixing the issue,
> tho):
>
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 5d88c184f0fc..687ad0a26458 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -112,7 +112,7 @@ static void release_ei(struct kref *ref)
>                         entry->release(entry->name, ei->data);
>         }
>
> -       call_rcu(&ei->rcu, free_ei_rcu);
> +       call_srcu(&eventfs_srcu, &ei->rcu, free_ei_rcu);
>  }
>
>  static inline void put_ei(struct eventfs_inode *ei)
> @@ -735,7 +735,9 @@ struct eventfs_inode *eventfs_create_dir(const char *=
name, struct eventfs_inode
>
>         /* Was the parent freed? */
>         if (list_empty(&ei->list)) {
> +               mutex_lock(&eventfs_mutex);
>                 cleanup_ei(ei);
> +               mutex_unlock(&eventfs_mutex);
>                 ei =3D NULL;
>         }
>         return ei;
>
> The s/call_rcu/call_srcu/ one is because not only do the comments talk
> about SRCU protection, the code does so as well, e.g. eventfs_iterate().
>
> Similar argumentation for taking the mutex around cleanup_ei(). It sets
> the 'is_freed' member which others expect only to be set -- or at least
> to have a stable value -- when the mutex is hold. As 'ei' was exposed to
> its parent before, it may have escaped to other users, e.g. via
> eventfs_iterate().
>
> I may have missed something, painting these changes completely void,
> therefore spared me the time to do proper patches. However, below one is
> legit ("git am --scissors ..." yada yada):
>
> ---8<---
> Subject: [PATCH] eventfs: Don't return NULL in eventfs_create_dir()
>
> Commit 77a06c33a22d ("eventfs: Test for ei->is_freed when accessing
> ei->dentry") added another check, testing if the parent was freed after
> we released the mutex. If so, the function returns NULL. However, all
> callers expect it to either return a valid pointer or an error pointer,
> at least since commit 5264a2f4bb3b ("tracing: Fix a NULL vs IS_ERR() bug
> in event_subsystem_dir()"). Returning NULL will therefore fail the error
> condition check in the caller.
>
> Fix this by substituting the NULL return value with a fitting error
> pointer.
>
> Fixes: 77a06c33a22d ("eventfs: Test for ei->is_freed when accessing ei->d=
entry")
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  fs/tracefs/event_inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 5d88c184f0fc..a9c28a1d5dc8 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -736,7 +736,7 @@ struct eventfs_inode *eventfs_create_dir(const char *=
name, struct eventfs_inode
>         /* Was the parent freed? */
>         if (list_empty(&ei->list)) {
>                 cleanup_ei(ei);
> -               ei =3D NULL;
> +               ei =3D ERR_PTR(-EBUSY);
>         }
>         return ei;
>  }

Must have. LGTM. Thanks.
Reviewed-by: Ajay Kaher <ajay.kaher@broadcom.com>

- Ajay

