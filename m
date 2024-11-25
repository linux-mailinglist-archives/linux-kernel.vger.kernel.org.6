Return-Path: <linux-kernel+bounces-420504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE09D7BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070E2162C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD1A183CC1;
	Mon, 25 Nov 2024 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/a+hGb+"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E017557C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517810; cv=none; b=hyZrBFDaP/xiBooSJ/spubpXmxDSDEcqerAFYYAi/vRSQ75z+a4PLOPkhXrIbyiJwFCCs9Xd8y5eof1Kkg2a7jv1fki5Z4YFVVdr7i5ooRg2ou6M7iO/pWMjjy2BtAb+w2ApdnvxhkBYizhSX5qPcB7N6/GHG4taah3X8GW0JR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517810; c=relaxed/simple;
	bh=iCRRLK9uj/Y6IrY+71B8S2fV1VIYj9A3NpYVBKumzYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWhehPyNhoMkf7u6NL9VuwChA1ke8FdN/Hr3f8oRApO9gWsYZv4/+0IJxGaRicL+luCcmLCcz7ZdWTrpQcl0e5Ie+yyN703rByiSUt+vwlIgbaxb1QAu0AK4ljAj/zPvL7fF5ZepnqwCz2nMC8nGy2Ir48ds6kEg5RvrcNLvLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/a+hGb+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f1292a9bso4876385e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732517806; x=1733122606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bttVSNC5UJ8SMEUrm4rMfCHFghupGIJXNX3Pb8vSx7E=;
        b=A/a+hGb+c/rtBugKfuNWcN3YB2rjuhpVpR0d18MxboBb+QU8FqVkwp6c7Y5CCMJcs5
         8wriMYOIdWfhxansVToVLoV6P1CxQeMjvy6E9R7VISpANNGa9yoqh1b87slaYHlyRfMS
         ur4qY26DzdzBHQhm9Tmjfcfl5IL6RegIk1p3HfUkk9vL+ZijZJ7WybbkwiYWYVcuL5of
         9s/OBqVlR7IQIgmCnM2T8aT1ux1JGek578TzrppK8pODNZMKh6on9dq5fK9xIFbzDuDM
         o39aqfv49lktnnpMniK7wtABTp4ydfYJ88lcmx/nOCo8O4BjpWlgcWNcKFWQkWk7i+sY
         QqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732517806; x=1733122606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bttVSNC5UJ8SMEUrm4rMfCHFghupGIJXNX3Pb8vSx7E=;
        b=qR28W7E1CaD4aHW3e02IbS0RCzK7MGjdiw+LSOxBsC/Xs3J2fZI8xoXuWmQQqh/xvO
         zGdTOvTTTx7xIvkPovIoADlt5jVtv7OJzU2O/AhI3KZ/IJ0F+7Fra9uxKNl8v0c2hE0D
         eQrkWNkwosr442E4GmlPhmuxuFtCX0m0NikGK/m9kH7UJhBh0YnZSW0TuA3ZhsYgbEmf
         ldP9DX3t/dotSwa2T7CoPgR+KGyf88998XNnVDvjC9fQa0xYEgJrsZncAwPAe0itxKuW
         RlulypRzCIJvNXtv2pewxxE/THH5/+/MV7aV1dIYFIqw99nXKT8uhE47KBeYDM1y4Etn
         imlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtN1UupLz9C7RPvpN8DJmWSRwLYt9hGRQVn5IEqN3Z+xG3gJSBpRhqk5GpdHIXybMq/s4pz+p5tgdRdqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aHb6SAvm43ewocYmD0izHs8DR6qPTU5sujyGZ/WUKrM3fFOE
	OJ0Db3TJn7QIhf2ZU0A7rNEml5bh3E+d3Nd42N6fzpD4/UXbYl1BKTjyI7R/dV1yDXP/Z+3nxvO
	yhZp/9llsf1wqAH1th3/2czh6LGY=
X-Gm-Gg: ASbGncstXul8PVKcmh3+NaYH6FU4j8WyTXV5ocwg5O7kdUaqu9VWomUD+7yIlATa7kv
	NKMhrx4qjh0RV1ZPTayTmVwIH90X73Tg=
X-Google-Smtp-Source: AGHT+IHcQxbEc3Au9IB40R4tpLu+RR7MImVlZrNOTLE1LlziZ4AqezAqaUyUvA0IncMvckZyBSyxTEtEvM2qrbpNkgw=
X-Received: by 2002:a05:6512:3d8b:b0:53d:e65e:aeec with SMTP id
 2adb3069b0e04-53de65eafc2mr153940e87.55.1732517805844; Sun, 24 Nov 2024
 22:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <674184c9.050a0220.1cc393.0001.GAE@google.com>
In-Reply-To: <674184c9.050a0220.1cc393.0001.GAE@google.com>
From: Suraj Sonawane <surajsonawane0215@gmail.com>
Date: Mon, 25 Nov 2024 12:26:07 +0530
Message-ID: <CAHiZj8j2EyaMeTCwOQNAx8zvaB=dLtO_FPB5zW==N-YqDo5=nQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
To: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000631faf0627b73ccc"

--000000000000631faf0627b73ccc
Content-Type: multipart/alternative; boundary="000000000000631fad0627b73cca"

--000000000000631fad0627b73cca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Sat, Nov 23, 2024 at 1:01=E2=80=AFPM syzbot <
syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9fb2cfa4635a Merge tag 'pull-ufs' of git://git.kernel.org=
/
> ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1004293058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc4515f1b6a4e5=
0b7
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D9f9a7f73fb079b2387a6
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D105ff2e8580=
000
>
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/7c0c61a15f60/disk-9fb2cfa4.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/3363d84eeb74/vmlinux-9fb2cfa=
4.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/2b1a270af550/bzImage-9fb2cfa=
4.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com
>
>  madvise_pageout_page_range mm/madvise.c:609 [inline]
>  madvise_pageout+0x326/0x820 mm/madvise.c:636
>  madvise_vma_behavior+0x58c/0x19e0 mm/madvise.c:1045
>  madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1274
>  do_madvise+0x29d/0x700 mm/madvise.c:1461
>  __do_sys_madvise mm/madvise.c:1477 [inline]
>  __se_sys_madvise mm/madvise.c:1475 [inline]
>  __x64_sys_madvise+0xa9/0x110 mm/madvise.c:1475
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> ------------[ cut here ]------------
> kernel BUG at include/linux/page-flags.h:309!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 7269 Comm: syz.1.183 Not tainted
> 6.12.0-syzkaller-00233-g9fb2cfa4635a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 10/30/2024
> RIP: 0010:const_folio_flags.constprop.0+0x12e/0x150
> include/linux/page-flags.h:309
> Code: 86 cb ff e8 f4 86 cb ff 48 8d 45 ff 48 39 c3 0f 84 38 ff ff ff e8 e=
2
> 86 cb ff 48 c7 c6 00 19 58 8b 48 89 df e8 e3 4b 11 00 90 <0f> 0b e8 6b 0d
> 2d 00 e9 f1 fe ff ff e8 61 0d 2d 00 eb a3 48 89 df
> RSP: 0018:ffffc9000c55ee30 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0000496f80 RCX: ffffc9000c55ecd8
> RDX: ffff88805f401e00 RSI: ffffffff81c1362d RDI: ffff88805f402244
> RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff203a591
> R10: ffffffff901d2c8f R11: 0000000000000001 R12: 00000000000014df
> R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920018abdf4
> FS:  00007f08b31bc6c0(0000) GS:ffff8880b8600000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c0025ff000 CR3: 00000000341ce000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  folio_test_locked include/linux/page-flags.h:509 [inline]
>  next_uptodate_folio+0xac/0x4b0 mm/filemap.c:3505
>  filemap_map_pages+0x1c6/0x16a0 mm/filemap.c:3647
>  do_fault_around mm/memory.c:5255 [inline]
>  do_read_fault mm/memory.c:5288 [inline]
>  do_fault mm/memory.c:5431 [inline]
>  do_pte_missing+0xdae/0x3e70 mm/memory.c:3965
>  handle_pte_fault mm/memory.c:5766 [inline]
>  __handle_mm_fault+0x100a/0x2a10 mm/memory.c:5909
>  handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077
>  faultin_page mm/gup.c:1187 [inline]
>  __get_user_pages+0x8d9/0x3b50 mm/gup.c:1485
>  __get_user_pages_locked mm/gup.c:1751 [inline]
>  get_dump_page+0xfb/0x220 mm/gup.c:2269
>  dump_user_range+0x135/0x8c0 fs/coredump.c:943
>  elf_core_dump+0x2766/0x3840 fs/binfmt_elf.c:2121
>  do_coredump+0x2c42/0x4160 fs/coredump.c:758
>  get_signal+0x237c/0x26d0 kernel/signal.c:2903
>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> RIP: 0033:0x1000
> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 002b:000000000000010c EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00007f08b41363b8 RCX: 00007f08b3f7e759
> RDX: ffffffffff600000 RSI: 0000000000000104 RDI: 8000000000000000
> RBP: 00007f08b3ff175e R08: 0000000100000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f08b41363b8 R15: 00007fff7656a008
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:const_folio_flags.constprop.0+0x12e/0x150
> include/linux/page-flags.h:309
> Code: 86 cb ff e8 f4 86 cb ff 48 8d 45 ff 48 39 c3 0f 84 38 ff ff ff e8 e=
2
> 86 cb ff 48 c7 c6 00 19 58 8b 48 89 df e8 e3 4b 11 00 90 <0f> 0b e8 6b 0d
> 2d 00 e9 f1 fe ff ff e8 61 0d 2d 00 eb a3 48 89 df
> RSP: 0018:ffffc9000c55ee30 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0000496f80 RCX: ffffc9000c55ecd8
> RDX: ffff88805f401e00 RSI: ffffffff81c1362d RDI: ffff88805f402244
> RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff203a591
> R10: ffffffff901d2c8f R11: 0000000000000001 R12: 00000000000014df
> R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920018abdf4
> FS:  00007f08b31bc6c0(0000) GS:ffff8880b8700000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff76568ff8 CR3: 00000000341ce000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit
> https://groups.google.com/d/msgid/syzkaller-bugs/674184c9.050a0220.1cc393=
.0001.GAE%40google.com
> .
>

--000000000000631fad0627b73cca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">#syz test<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Nov 23, 2024 at 1:01=E2=80=AFPM syzbo=
t &lt;<a href=3D"mailto:syzbot%2B9f9a7f73fb079b2387a6@syzkaller.appspotmail=
.com">syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
syzbot found the following issue on:<br>
<br>
HEAD commit:=C2=A0 =C2=A0 9fb2cfa4635a Merge tag &#39;pull-ufs&#39; of git:=
//<a href=3D"http://git.kernel.org/" rel=3D"noreferrer" target=3D"_blank">g=
it.kernel.org/</a>..<br>
git tree:=C2=A0 =C2=A0 =C2=A0 =C2=A0upstream<br>
console output: <a href=3D"https://syzkaller.appspot.com/x/log.txt?x=3D1004=
2930580000" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.=
com/x/log.txt?x=3D10042930580000</a><br>
kernel config:=C2=A0 <a href=3D"https://syzkaller.appspot.com/x/.config?x=
=3Dc4515f1b6a4e50b7" rel=3D"noreferrer" target=3D"_blank">https://syzkaller=
.appspot.com/x/.config?x=3Dc4515f1b6a4e50b7</a><br>
dashboard link: <a href=3D"https://syzkaller.appspot.com/bug?extid=3D9f9a7f=
73fb079b2387a6" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.apps=
pot.com/bug?extid=3D9f9a7f73fb079b2387a6</a><br>
compiler:=C2=A0 =C2=A0 =C2=A0 =C2=A0gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40<br>
syz repro:=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://syzkaller.appspot.com/x/r=
epro.syz?x=3D105ff2e8580000" rel=3D"noreferrer" target=3D"_blank">https://s=
yzkaller.appspot.com/x/repro.syz?x=3D105ff2e8580000</a><br>
<br>
Downloadable assets:<br>
disk image: <a href=3D"https://storage.googleapis.com/syzbot-assets/7c0c61a=
15f60/disk-9fb2cfa4.raw.xz" rel=3D"noreferrer" target=3D"_blank">https://st=
orage.googleapis.com/syzbot-assets/7c0c61a15f60/disk-9fb2cfa4.raw.xz</a><br=
>
vmlinux: <a href=3D"https://storage.googleapis.com/syzbot-assets/3363d84eeb=
74/vmlinux-9fb2cfa4.xz" rel=3D"noreferrer" target=3D"_blank">https://storag=
e.googleapis.com/syzbot-assets/3363d84eeb74/vmlinux-9fb2cfa4.xz</a><br>
kernel image: <a href=3D"https://storage.googleapis.com/syzbot-assets/2b1a2=
70af550/bzImage-9fb2cfa4.xz" rel=3D"noreferrer" target=3D"_blank">https://s=
torage.googleapis.com/syzbot-assets/2b1a270af550/bzImage-9fb2cfa4.xz</a><br=
>
<br>
IMPORTANT: if you fix the issue, please add the following tag to the commit=
:<br>
Reported-by: <a href=3D"mailto:syzbot%2B9f9a7f73fb079b2387a6@syzkaller.apps=
potmail.com" target=3D"_blank">syzbot+9f9a7f73fb079b2387a6@syzkaller.appspo=
tmail.com</a><br>
<br>
=C2=A0madvise_pageout_page_range mm/madvise.c:609 [inline]<br>
=C2=A0madvise_pageout+0x326/0x820 mm/madvise.c:636<br>
=C2=A0madvise_vma_behavior+0x58c/0x19e0 mm/madvise.c:1045<br>
=C2=A0madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1274<br>
=C2=A0do_madvise+0x29d/0x700 mm/madvise.c:1461<br>
=C2=A0__do_sys_madvise mm/madvise.c:1477 [inline]<br>
=C2=A0__se_sys_madvise mm/madvise.c:1475 [inline]<br>
=C2=A0__x64_sys_madvise+0xa9/0x110 mm/madvise.c:1475<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83<br>
------------[ cut here ]------------<br>
kernel BUG at include/linux/page-flags.h:309!<br>
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI<br>
CPU: 0 UID: 0 PID: 7269 Comm: syz.1.183 Not tainted 6.12.0-syzkaller-00233-=
g9fb2cfa4635a #0<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 10/30/2024<br>
RIP: 0010:const_folio_flags.constprop.0+0x12e/0x150 include/linux/page-flag=
s.h:309<br>
Code: 86 cb ff e8 f4 86 cb ff 48 8d 45 ff 48 39 c3 0f 84 38 ff ff ff e8 e2 =
86 cb ff 48 c7 c6 00 19 58 8b 48 89 df e8 e3 4b 11 00 90 &lt;0f&gt; 0b e8 6=
b 0d 2d 00 e9 f1 fe ff ff e8 61 0d 2d 00 eb a3 48 89 df<br>
RSP: 0018:ffffc9000c55ee30 EFLAGS: 00010293<br>
RAX: 0000000000000000 RBX: ffffea0000496f80 RCX: ffffc9000c55ecd8<br>
RDX: ffff88805f401e00 RSI: ffffffff81c1362d RDI: ffff88805f402244<br>
RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff203a591<br>
R10: ffffffff901d2c8f R11: 0000000000000001 R12: 00000000000014df<br>
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920018abdf4<br>
FS:=C2=A0 00007f08b31bc6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000=
000000<br>
CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
CR2: 000000c0025ff000 CR3: 00000000341ce000 CR4: 00000000003526f0<br>
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000<br>
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400<br>
Call Trace:<br>
=C2=A0&lt;TASK&gt;<br>
=C2=A0folio_test_locked include/linux/page-flags.h:509 [inline]<br>
=C2=A0next_uptodate_folio+0xac/0x4b0 mm/filemap.c:3505<br>
=C2=A0filemap_map_pages+0x1c6/0x16a0 mm/filemap.c:3647<br>
=C2=A0do_fault_around mm/memory.c:5255 [inline]<br>
=C2=A0do_read_fault mm/memory.c:5288 [inline]<br>
=C2=A0do_fault mm/memory.c:5431 [inline]<br>
=C2=A0do_pte_missing+0xdae/0x3e70 mm/memory.c:3965<br>
=C2=A0handle_pte_fault mm/memory.c:5766 [inline]<br>
=C2=A0__handle_mm_fault+0x100a/0x2a10 mm/memory.c:5909<br>
=C2=A0handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077<br>
=C2=A0faultin_page mm/gup.c:1187 [inline]<br>
=C2=A0__get_user_pages+0x8d9/0x3b50 mm/gup.c:1485<br>
=C2=A0__get_user_pages_locked mm/gup.c:1751 [inline]<br>
=C2=A0get_dump_page+0xfb/0x220 mm/gup.c:2269<br>
=C2=A0dump_user_range+0x135/0x8c0 fs/coredump.c:943<br>
=C2=A0elf_core_dump+0x2766/0x3840 fs/binfmt_elf.c:2121<br>
=C2=A0do_coredump+0x2c42/0x4160 fs/coredump.c:758<br>
=C2=A0get_signal+0x237c/0x26d0 kernel/signal.c:2903<br>
=C2=A0arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337<br>
=C2=A0exit_to_user_mode_loop kernel/entry/common.c:111 [inline]<br>
=C2=A0exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]<b=
r>
=C2=A0irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231<br>
=C2=A0asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623<br>
RIP: 0033:0x1000<br>
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 &lt;00&gt; 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
RSP: 002b:000000000000010c EFLAGS: 00010246<br>
RAX: 0000000000000000 RBX: 00007f08b41363b8 RCX: 00007f08b3f7e759<br>
RDX: ffffffffff600000 RSI: 0000000000000104 RDI: 8000000000000000<br>
RBP: 00007f08b3ff175e R08: 0000000100000000 R09: 0000000000000000<br>
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000<br>
R13: 0000000000000000 R14: 00007f08b41363b8 R15: 00007fff7656a008<br>
=C2=A0&lt;/TASK&gt;<br>
Modules linked in:<br>
---[ end trace 0000000000000000 ]---<br>
RIP: 0010:const_folio_flags.constprop.0+0x12e/0x150 include/linux/page-flag=
s.h:309<br>
Code: 86 cb ff e8 f4 86 cb ff 48 8d 45 ff 48 39 c3 0f 84 38 ff ff ff e8 e2 =
86 cb ff 48 c7 c6 00 19 58 8b 48 89 df e8 e3 4b 11 00 90 &lt;0f&gt; 0b e8 6=
b 0d 2d 00 e9 f1 fe ff ff e8 61 0d 2d 00 eb a3 48 89 df<br>
RSP: 0018:ffffc9000c55ee30 EFLAGS: 00010293<br>
RAX: 0000000000000000 RBX: ffffea0000496f80 RCX: ffffc9000c55ecd8<br>
RDX: ffff88805f401e00 RSI: ffffffff81c1362d RDI: ffff88805f402244<br>
RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff203a591<br>
R10: ffffffff901d2c8f R11: 0000000000000001 R12: 00000000000014df<br>
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920018abdf4<br>
FS:=C2=A0 00007f08b31bc6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000=
000000<br>
CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
CR2: 00007fff76568ff8 CR3: 00000000341ce000 CR4: 00000000003526f0<br>
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000<br>
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400<br>
<br>
<br>
---<br>
This report is generated by a bot. It may contain errors.<br>
See <a href=3D"https://goo.gl/tpsmEJ" rel=3D"noreferrer" target=3D"_blank">=
https://goo.gl/tpsmEJ</a> for more information about syzbot.<br>
syzbot engineers can be reached at <a href=3D"mailto:syzkaller@googlegroups=
.com" target=3D"_blank">syzkaller@googlegroups.com</a>.<br>
<br>
syzbot will keep track of this issue. See:<br>
<a href=3D"https://goo.gl/tpsmEJ#status" rel=3D"noreferrer" target=3D"_blan=
k">https://goo.gl/tpsmEJ#status</a> for how to communicate with syzbot.<br>
<br>
If the report is already addressed, let syzbot know by replying with:<br>
#syz fix: exact-commit-title<br>
<br>
If you want syzbot to run the reproducer, reply with:<br>
#syz test: git://repo/address.git branch-or-commit-hash<br>
If you attach or paste a git patch, syzbot will apply it before testing.<br=
>
<br>
If you want to overwrite report&#39;s subsystems, reply with:<br>
#syz set subsystems: new-subsystem<br>
(See the list of subsystem names on the web dashboard)<br>
<br>
If the report is a duplicate of another one, reply with:<br>
#syz dup: exact-subject-of-another-report<br>
<br>
If you want to undo deduplication, reply with:<br>
#syz undup<br>
<br>
-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;syzkaller-bugs&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:syzkaller-bugs%2Bunsubscribe@googlegroups.com" ta=
rget=3D"_blank">syzkaller-bugs+unsubscribe@googlegroups.com</a>.<br>
To view this discussion visit <a href=3D"https://groups.google.com/d/msgid/=
syzkaller-bugs/674184c9.050a0220.1cc393.0001.GAE%40google.com" rel=3D"noref=
errer" target=3D"_blank">https://groups.google.com/d/msgid/syzkaller-bugs/6=
74184c9.050a0220.1cc393.0001.GAE%40google.com</a>.<br>
</blockquote></div>

--000000000000631fad0627b73cca--
--000000000000631faf0627b73ccc
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fix-kernel-BUG-in-const_folio_flags-2.patch"
Content-Disposition: attachment; 
	filename="0001-fix-kernel-BUG-in-const_folio_flags-2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3woceu90>
X-Attachment-Id: f_m3woceu90

RnJvbSAyNmI4OTJkMTE2ZmFiZDAzOTVkZTRkY2RkYmViMmRmZGJkNGE3NDI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhaiBTb25hd2FuZSA8c3VyYWpzb25hd2FuZTAyMTVAZ21h
aWwuY29tPgpEYXRlOiBNb24sIDI1IE5vdiAyMDI0IDEyOjIyOjEyICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gZml4IGtlcm5lbCBCVUcgaW4gY29uc3RfZm9saW9fZmxhZ3MgKDIpCgpzeXogdGVzdAoK
U2lnbmVkLW9mZi1ieTogU3VyYWogU29uYXdhbmUgPHN1cmFqc29uYXdhbmUwMjE1QGdtYWlsLmNv
bT4KLS0tCiBpbmNsdWRlL2xpbnV4L3BhZ2UtZmxhZ3MuaCB8IDYgKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wYWdlLWZs
YWdzLmggYi9pbmNsdWRlL2xpbnV4L3BhZ2UtZmxhZ3MuaAppbmRleCA5MDhlZTBhYWQuLmFiNTYy
ZmY0NSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmgKKysrIGIvaW5jbHVk
ZS9saW51eC9wYWdlLWZsYWdzLmgKQEAgLTMwNiw2ICszMDYsMTIgQEAgc3RhdGljIGNvbnN0IHVu
c2lnbmVkIGxvbmcgKmNvbnN0X2ZvbGlvX2ZsYWdzKGNvbnN0IHN0cnVjdCBmb2xpbyAqZm9saW8s
CiB7CiAJY29uc3Qgc3RydWN0IHBhZ2UgKnBhZ2UgPSAmZm9saW8tPnBhZ2U7CiAKKwkvKiBBZGQg
YSBjaGVjayBmb3IgbiB0byBlbnN1cmUgaXQncyB3aXRoaW4gYm91bmRzLiAqLworCWlmIChuID49
IGZvbGlvX25yX3BhZ2VzKGZvbGlvKSkgeworCQlwcl9lcnIoIkludmFsaWQgZm9saW8gaW5kZXg6
IG49JXUsIGZvbGlvX25yX3BhZ2VzPSV1XG4iLCBuLCBmb2xpb19ucl9wYWdlcyhmb2xpbykpOwor
CQlyZXR1cm4gLUVJTlZBTDsKKwl9CisKIAlWTV9CVUdfT05fUEdGTEFHUyhQYWdlVGFpbChwYWdl
KSwgcGFnZSk7CiAJVk1fQlVHX09OX1BHRkxBR1MobiA+IDAgJiYgIXRlc3RfYml0KFBHX2hlYWQs
ICZwYWdlLT5mbGFncyksIHBhZ2UpOwogCXJldHVybiAmcGFnZVtuXS5mbGFnczsKLS0gCjIuMzQu
MQoK
--000000000000631faf0627b73ccc--

