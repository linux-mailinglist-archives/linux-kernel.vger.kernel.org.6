Return-Path: <linux-kernel+bounces-316623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2D96D20E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA0287172
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C601925BB;
	Thu,  5 Sep 2024 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NI+aBjN"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A9189518
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524767; cv=none; b=n7eoV/ad3t/Ws60LDVHu+Pw8LkoWAt6RxmqFQkFlu39ZUkTGnveAVQjLWdfRNxDQ9CMdWcEqV8xgzPxCAn2MNbxcvmOyUYo7Hj8VqD7JgFrPCxdnfepr469fthE/JARxsfY8d/DegfN0ze4WDtLRWwJqWIEyNTDhACuCLApQtQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524767; c=relaxed/simple;
	bh=vYMVDeaVS3nk36UjoXWscki3cHGga/h/ahtkP0Ml0gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eb8hYIGPR3/LTCif6GRwRq4D2ylsaGPm+/mU73AccIZLdboMwaqVFHtwFbTYJYSj6cU4kP4elnvnLmgGLt9whdKFQYIlxaZ79sKr3NjP5L8tuqHrNmz+OvGwYXOBjlhViCrqB31BMiqiC9UTP8PCuyg3ST1po1DFWh0N9GjaJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NI+aBjN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f4f8742138so5358761fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725524763; x=1726129563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HamwCCcPJT62KPA+Ewi5cXBkIpS9Qury5+XEZP/GM9Y=;
        b=2NI+aBjN4UZPySLciKU/Wr3Uz3lrvlmC+MAfX8t7Kbq4cq5QF/VqaPuAK2qzzHKmFD
         TWXW3OgEAHHcdjXJ22c2EgmdrzPK9mHnXFHSGq2DNMZaPD3DSzP5sqbGmwNM9bGNYpEn
         VmFN+MxUCemMf3wEgykDrCXj8xFQk4IrXqyoHwelncW9XW9tuVm7RuFt/MtZA0lgknvL
         DZYaWTRd0SJ400OH+rvI8whcqhqQ0pTLqNMoN3aTgYLfmF+urCcim27xvNd5Y3eKOZgo
         bIriMRzalfLr+Z6H+OkOlrgLA6K5h8m89Sw8gjuKAMjFTn2oy52inI+gbFUHKWxkexv5
         BRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524763; x=1726129563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HamwCCcPJT62KPA+Ewi5cXBkIpS9Qury5+XEZP/GM9Y=;
        b=T6SdYQh253YD1NwSn3JUnwivRSywiPez+IUHGl7ysevO5pctgcZAMF+IorxK47xlJQ
         WDuMTuxnoGvwYZ4nfELLMsklLv/h0gcCH0jh6cTLAMQ3LoeR0XsevU92XSCHK17McQEc
         K1XHqDLYclYMu4gaymYRY5gidtqhGjrCwu4DmzvNoTvG9/6Uw7zWSasKoU+c9jiqDqkA
         +Q5ObM4dFcji7yWg9M89HT521V2SyjuLE/hAEXR8Ib67Hv5KA+adW5BTdhprZI3nLp/J
         /oLysVHYK2uqBrT+Fwbn26lhw0RdtvlC4jlb5YIxWJFz7+/Fqv7KPb8DJoqX7MuQ+C/V
         t+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCW1GkJ5fdPfHVU4Hw7yrQZI9yQ3lWhy99rHCU2YIyq4Y8M0oVnoXc3YEHhbbNuKjAlRgeSwrtiSKu+0uzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwInB4/pmR0QJoPJG00Q2A7iOjG+BumT8EIktwjLXh5JMxxty
	0fuHfxVureQyI/o56KylEZTImxBBk0DawjTsOeO3cb0hnXWNtE0t/GdzDUKo7aGrp0zBMd9EgY6
	FSFuZRX+NqmpFpODRUbYk3rA5RHSu+hR+ic4e
X-Google-Smtp-Source: AGHT+IHUl60Zp5FtBMCZokZowxWRDoV9+Xabc8FwwMYeboZDuvpv+GBY48gUTFJPkQMmAL6JuK9jUifMQKDEJwMPAw0=
X-Received: by 2002:a2e:b8c6:0:b0:2f3:e2f0:2b74 with SMTP id
 38308e7fff4ca-2f64d54ff96mr48371221fa.36.1725524763188; Thu, 05 Sep 2024
 01:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f20106061fc9699c@google.com> <e8ce9858-87ab-4f0b-85a8-8817ec376986n@googlegroups.com>
 <CACT4Y+YkXFCQ8sUX7rgL9j23_mxKpoxR15_w=5+aJ=A_cg3C0w@mail.gmail.com>
In-Reply-To: <CACT4Y+YkXFCQ8sUX7rgL9j23_mxKpoxR15_w=5+aJ=A_cg3C0w@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 5 Sep 2024 10:25:51 +0200
Message-ID: <CACT4Y+Zf8Gegr_rpiCjpH2isp78zC9MWbYhuoXvrGL6Cj-cR1w@mail.gmail.com>
Subject: Re: [moderation] [f2fs?] WARNING: still has locks held in f2fs_ioc_start_atomic_write
To: Chao Yu <yuchaochina@gmail.com>
Cc: syzkaller-upstream-moderation <syzkaller-upstream-moderation@googlegroups.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	syzbot+a2197ed0ab131bbc9d02@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Sept 2024 at 10:16, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Hi Chao,
>
> The commands should not have space at the beginning of the line, and
> also preferably sent not in HTML (I did n't check what is in the
> plain/text section of your email).
> You can always check if syzbot has received your command at the bug page:
> https://syzkaller.appspot.com/bug?extid=3Da2197ed0ab131bbc9d02
>
> But thanks for marking it as fixed:
>
>

Also one needs to keep syzbot email in CC, otherwise it does not know
the bug you refer to.
Let's try again:

#syz fix: f2fs: atomic: fix to forbid dio in atomic_file

> On Thu, 5 Sept 2024 at 08:49, Chao Yu <yuchaochina@gmail.com> wrote:
> >
> >  #syz fix: f2fs: atomic: fix to forbid dio in atomic_file
> >
> > =E5=9C=A82024=E5=B9=B48=E6=9C=8816=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=94 =
UTC+8 17:16:28<syzbot> =E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit: 9e6869691724 Add linux-next specific files for 20240812
> >> git tree: linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14d27ae598=
0000
> >> kernel config: https://syzkaller.appspot.com/x/.config?x=3D61ba6f3b22e=
e5467
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da2197ed0ab13=
1bbc9d02
> >> compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian=
) 2.40
> >> CC: [ch...@kernel.org jae...@kernel.org linux-f2...@lists.sourceforge.=
net linux-...@vger.kernel.org]
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/=
disk-9e686969.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vml=
inux-9e686969.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98=
a/bzImage-9e686969.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+a2197e...@syzkaller.appspotmail.com
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> WARNING: syz.0.454/7910 still has locks held!
> >> 6.11.0-rc3-next-20240812-syzkaller #0 Not tainted
> >> ------------------------------------
> >> 1 lock held by syz.0.454/7910:
> >> #0: ffff888011f98f50 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_dow=
n_write fs/f2fs/f2fs.h:2196 [inline]
> >> #0: ffff888011f98f50 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_ioc=
_start_atomic_write+0x2ed/0xac0 fs/f2fs/file.c:2163
> >>
> >> stack backtrace:
> >> CPU: 0 UID: 0 PID: 7910 Comm: syz.0.454 Not tainted 6.11.0-rc3-next-20=
240812-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 06/27/2024
> >> Call Trace:
> >> <TASK>
> >> __dump_stack lib/dump_stack.c:94 [inline]
> >> dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >> do_exit+0x1b67/0x28e0 kernel/exit.c:969
> >> do_group_exit+0x207/0x2c0 kernel/exit.c:1088
> >> get_signal+0x176f/0x1810 kernel/signal.c:2936
> >> arch_do_signal_or_restart+0x96/0x830 arch/x86/kernel/signal.c:337
> >> exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
> >> exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >> __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >> syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
> >> do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
> >> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> RIP: 0033:0x7f7ba21779f9
> >> Code: Unable to access opcode bytes at 0x7f7ba21779cf.
> >> RSP: 002b:00007f7ba2fa4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> >> RAX: fffffffffffffffb RBX: 00007f7ba2306208 RCX: 00007f7ba21779f9
> >> RDX: 0000000000000000 RSI: 000000000000f501 RDI: 0000000000000005
> >> RBP: 00007f7ba21e58ee R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >> R13: 0000000000000001 R14: 00007f7ba2306208 R15: 00007ffc9069b428
> >> </TASK>
> >>
> >>
> >> ---
> >> This report is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzk...@googlegroups.com.
> >>
> >> syzbot will keep track of this issue. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >>
> >> If the report is already addressed, let syzbot know by replying with:
> >> #syz fix: exact-commit-title
> >>
> >> If you want to overwrite report's subsystems, reply with:
> >> #syz set subsystems: new-subsystem
> >> (See the list of subsystem names on the web dashboard)
> >>
> >> If the report is a duplicate of another one, reply with:
> >> #syz dup: exact-subject-of-another-report
> >>
> >> If you want to undo deduplication, reply with:
> >> #syz undup
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "syzkaller-upstream-moderation" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to syzkaller-upstream-moderation+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/syzkaller-upstream-moderation/e8ce9858-87ab-4f0b-85a8-8817ec376986n%40g=
ooglegroups.com.

