Return-Path: <linux-kernel+bounces-425147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AA49DBE21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34FA161435
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4761C4606;
	Thu, 28 Nov 2024 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdozwbon"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28C145B1D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732836676; cv=none; b=LE/BXx+NsEyfZV0edrC5nHawo7YFx3kGeHmREVZ/qhU7C7UYUFXr+Ldm091+Sfn5hCWMFZN0H1oSB6hd6G9e0+euOhkttiX6La84+/aF5cxwbRTIS/W7r3p8slBzA+G7a0I4IzUZjVkuOr9r+/tC50agKSZpIFnQJpGpiGCxEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732836676; c=relaxed/simple;
	bh=EQXAJ08tUnlBvyrjKDbPFZFspw50tpSxRdVT8Q7hr5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d55bBGQnSun3gnD4DFHtKzlrs6IFp2AX9Pg5tjUtf6Ya3P1p4NfcmI80ojr8fBJkyqn2MsQc3Ph2zycp//v1psYOmzJ8qK/UuT3yoCt1RnpvAv4Yp/qLaEVRuFniv8tX6w1a1GtU0YHp3Wpz6F6jvXxUCxmhGN0BwJlpLz8MZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xdozwbon; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so10568a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732836672; x=1733441472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgYjQEiw9LHmDSPL4yUSc4EUk9VqZlNda+SIAj1FUFk=;
        b=xdozwbongmdEt1zexvqq+LEa6mvAsfUnpgl3WuEgol5x/XjlaD9qJLh9a91o35C6Qe
         zGjG8jweM+s77c47cCsvo83zXuyPdCMn5got24cV1UXzFEe6fXEGhjlYD/QvfpMoZMLL
         BUOoq6sNo1QKUrMXhZWD8QC6KKhuWm4BRE3hoHnWpKy0mAAA2VBd5MDeULmBM0A9aua8
         8j2U+msQWkkbcNSdo48D8qUHrvSp2kx9DCJnTC8rnvAw5wRbaO2P8dve495vCYr3Q+Tb
         y1dXHLeDk3D87/K+f5h5WKpSsjAVK8XPfs3p5YZh4c6aBHTwOB5vpq+hfpgiyAt4qzrG
         3k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732836672; x=1733441472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgYjQEiw9LHmDSPL4yUSc4EUk9VqZlNda+SIAj1FUFk=;
        b=V8U8Y+O3Mxposb253vJ6WrAhwzrhPB9vFy2wPUU+rWnW42sq24k+yqO9Y/MXFTdabB
         mwTXWugafDkKOSDxhvSttGM06hkJLxuN4a9SdJjmPuJmkChfF75bcEtWTjszXCYk+UKo
         8qVf4VzCU68Nvh8uDdEkjFkCos8wehmdS8iF4uTDYrQmpRWbzedgc2YFCGjurWTrbbJL
         2kSR6fy18BKnwgvwqBNx5dplB35Czc/ngEmfPEG/8GaVSor3MnQskwTgU8IWcFyMSVmn
         IowvmQ9KjNaNd2p8N5r3h63HS46iFNtDOMSXeQ9GXArcSnhYB6vHK+28eH4LSe8HhmkB
         ILaA==
X-Forwarded-Encrypted: i=1; AJvYcCXiuN/8GTI5vG4YGrK82fm5dXijrUN4oD82/HECFxQ0Fsu+TtCET2hQXEYM+GN4oB+2w15/d8aoR3goZ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHOmYo3Fj3iDDonBemwCdvGi3KJf+h6zDrPIh3FanKIV71T6R
	3LCB4VchlxDJoCBgjbiG6vlF+r1eJ5Exf9V0p4okt7qUxIcyWfVtNC+ANmMKX+tfETBvsqgkbII
	SubudJ8lssiy0MjRQJEs8LlpYzJ6YVn7pRkW+
X-Gm-Gg: ASbGncvsPde8VR9lYjmTK4YPLpJS4iNgAL8FJBAcUubyvJ4e5A6N9oLbisTnX0Ahr2O
	/HkB2VHfkQ2vVzKUReD1j2u4+3wmQzqoUeAV0fkd4EKsCxy9//K/6IuCUh1E=
X-Google-Smtp-Source: AGHT+IH+TVxMX3dg0faFFoM9K64QmaJRCnPpv51YUm8E8cf99TmdKomtFn7U/+TGYymaHS5h356gf4BPsFZKAIngk3k=
X-Received: by 2002:a50:fb86:0:b0:5d0:f39:9c7 with SMTP id 4fb4d7f45d1cf-5d09827c3f0mr72367a12.7.1732836671653;
 Thu, 28 Nov 2024 15:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <673c1643.050a0220.87769.0066.GAE@google.com>
In-Reply-To: <673c1643.050a0220.87769.0066.GAE@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 29 Nov 2024 00:30:35 +0100
Message-ID: <CAG48ez0uhdGNCopX2nspLzWZKfuZp0XLyUk90kYku=sP7wsWfg@mail.gmail.com>
Subject: Re: [syzbot] [io-uring?] WARNING in __io_uring_free
To: syzbot <syzbot+cc36d44ec9f368e443d3@syzkaller.appspotmail.com>, 
	Matthew Wilcox <willy@infradead.org>
Cc: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Matthew for xarray

On Tue, Nov 19, 2024 at 5:38=E2=80=AFAM syzbot
<syzbot+cc36d44ec9f368e443d3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cfaaa7d010d1 Merge tag 'net-6.12-rc8' of git://git.kernel=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13005cc058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd2aeec8c0b2e4=
20c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dcc36d44ec9f368e=
443d3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-cfaaa7d0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/63eae0d3e67f/vmlinu=
x-cfaaa7d0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6495d9e4ddee/b=
zImage-cfaaa7d0.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+cc36d44ec9f368e443d3@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 16 at io_uring/tctx.c:51 __io_uring_free+0xfa/0x140 =
io_uring/tctx.c:51

This warning is a check for WARN_ON_ONCE(!xa_empty(&tctx->xa)); and as
Jens pointed out, this was triggered after error injection caused a
memory allocation inside xa_store() to fail.

Is there maybe an issue where xa_store() can fail midway through while
allocating memory for the xarray, so that xa_empty() is no longer true
even though there is nothing in the xarray? (And if yes, is that
working as intended?)

> Modules linked in:
> CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc7-syzkaller-=
00125-gcfaaa7d010d1 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> RIP: 0010:__io_uring_free+0xfa/0x140 io_uring/tctx.c:51
> Code: 80 7c 25 00 00 74 08 4c 89 f7 e8 a1 8a 49 fd 49 c7 06 00 00 00 00 5=
b 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 37 ad df fc 90 <0f> 0b 90 e9 6a=
 ff ff ff e8 29 ad df fc 90 0f 0b 90 eb 84 e8 1e ad
> RSP: 0018:ffffc900004279b8 EFLAGS: 00010246
> RAX: ffffffff84b53cd9 RBX: ffff88804fc3b8e0 RCX: ffff88801b7e8000
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffff88801f058000
> RBP: 0000000000000001 R08: ffffffff8154d881 R09: 1ffff11003e0b005
> R10: dffffc0000000000 R11: ffffed1003e0b006 R12: dffffc0000000000
> R13: 1ffff11003e0b120 R14: ffff88801f058900 R15: ffff88804fc3b800
> FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005594393ad338 CR3: 000000000e734000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  io_uring_free include/linux/io_uring.h:31 [inline]
>  __put_task_struct+0xd5/0x290 kernel/fork.c:975
>  put_task_struct include/linux/sched/task.h:144 [inline]
>  delayed_put_task_struct+0x125/0x300 kernel/exit.c:228
>  rcu_do_batch kernel/rcu/tree.c:2567 [inline]
>  rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
>  handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
>  run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
>  smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
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

