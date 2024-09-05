Return-Path: <linux-kernel+bounces-316603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5039C96D1D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A78B218D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D449419539F;
	Thu,  5 Sep 2024 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwXma4Jc"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13E18BC0A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524226; cv=none; b=K6M8RrUz3W0Xw82rC2x90KhUduyN+n6wW8XuFyqdNK9od1J20ELkjcbFqVBO3y0L1HClSWdP+UpRfe5yrLh+fUOYFVujk8sJ7MoVgKASWIi/Ga9PEnOmW5MibXXuleCboFEmy5KRWadzc9KMOUp1lrTfGzeDcgT5HfJBAxY/OHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524226; c=relaxed/simple;
	bh=Qfxn9H3ry+F0Oj7greBnvGOnapk6JHpmd2+qAh7VX0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMqxvirUs7z5l54omYNchVol7rnCuA6ymAg7e4+K1WsvFH+VMr3b6rvL6sP6D9s7YEmSfgLwwv59iYZnSf/Lu6FQFmew6AGsNgqikpH4ohH3ob1mKAcCrL8prIrEnRyN6S9xoivpCdF5gR9oACCNcs5W0kP4WBXP3P306/Ngl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwXma4Jc; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f64e82aeacso5619781fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725524222; x=1726129022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT70TXKUlQhNC2PwKI0955WZeFuTwWA14N7hSRPfHWw=;
        b=NwXma4Jc1MwDGOZ6f5dqC+EJMWauZ/EAOKgPFZFCOcRVw0jijjC1wOL0rATTPdXB8X
         Q6acEMlwNzYfCgXVggIfXfFxMOyxdGMPzeOwZFiXQq9JAjNPnM21xGKNr1Q83dGW2yv6
         WJdK6a/cViJbYbSbupFMi79fSEq4ofHyU5w2+V/0BCShW9NLSnLQpSGNFtYKYlsM6r5h
         9Hk9Z5c6eO7xPeu5P3sQqJTAibDvD/jEkepf3Q2eb/uQT41VIL84Ut3I6d8NBs/kaw8X
         W2mSk70Llgj4dWgmLJpx7RlImCk+L/ZMJBpDjFoBpUx+HqsnVcglT+f/2TpIgshA4710
         nguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524222; x=1726129022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT70TXKUlQhNC2PwKI0955WZeFuTwWA14N7hSRPfHWw=;
        b=hMNE4Bzdku8QutoFrsTknxWERQVWmV0Olzn5PMFPN/MrNAQ7cJZhxTf1okbD5hUO8K
         0eWgn//tXuUxYdt+g8Im1R9OBv4xUGD1ylymIfVHhDz5ljkNcx9Q7fJUT1GBqfyhrk64
         U0NW8ddrUTrruFD3TX0s61hiJfwstHK7ipIJ8R7lvXC8TH8SQ7IC77i2sD5jWPnx/okV
         YY8q9ALDQOoZVKrUSN9FvFGBDEMcAgM9w4jG2XBfOcGNhsd/GeTnaJG/D3T+rEnoQthv
         1PHNVfJjVAr4OAIUVaoPKPaQ+Iu11D3qVaE6L4P+RfgyxmhAr7MBma9/sTcP6iX+KsPK
         8+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWmIXRKvJne7L30otD+Cf2RClTzTc8zU68++lsgTk5IWkHI9Bhy1B/HlpvMlH1xxHEj+ZBbg3S54JV0HH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/S3IFmjqHUPy0Jcz11BcG39QAc8b/2t4drxIsOSEUxCWWHhti
	HoezUOdHFpWrRKAxTcf5J4FylWSbPCFlawup/KW71BOreL+BSGjs2UkZdLDwz5DD+Tu1HM0omPM
	2x7IFRgeM0o8DCBbmY9yrQrhBuZJW0t7M3GiGO9+tVvwNFoG19g==
X-Google-Smtp-Source: AGHT+IHvwIPNEPW9S8/vI7CUn5oWcJgZ0SuPji0JqdYtgvFObtbkrI2o4zthmS5rgCxWriAm97eFKT7Bqm1pyEhWRmo=
X-Received: by 2002:a05:651c:4ca:b0:2f6:4f5f:9702 with SMTP id
 38308e7fff4ca-2f64f5f9b95mr55815101fa.4.1725524221941; Thu, 05 Sep 2024
 01:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f20106061fc9699c@google.com> <e8ce9858-87ab-4f0b-85a8-8817ec376986n@googlegroups.com>
In-Reply-To: <e8ce9858-87ab-4f0b-85a8-8817ec376986n@googlegroups.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 5 Sep 2024 10:16:50 +0200
Message-ID: <CACT4Y+YkXFCQ8sUX7rgL9j23_mxKpoxR15_w=5+aJ=A_cg3C0w@mail.gmail.com>
Subject: Re: [moderation] [f2fs?] WARNING: still has locks held in f2fs_ioc_start_atomic_write
To: Chao Yu <yuchaochina@gmail.com>
Cc: syzkaller-upstream-moderation <syzkaller-upstream-moderation@googlegroups.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chao,

The commands should not have space at the beginning of the line, and
also preferably sent not in HTML (I did n't check what is in the
plain/text section of your email).
You can always check if syzbot has received your command at the bug page:
https://syzkaller.appspot.com/bug?extid=3Da2197ed0ab131bbc9d02

But thanks for marking it as fixed:

#syz fix: f2fs: atomic: fix to forbid dio in atomic_file

On Thu, 5 Sept 2024 at 08:49, Chao Yu <yuchaochina@gmail.com> wrote:
>
>  #syz fix: f2fs: atomic: fix to forbid dio in atomic_file
>
> =E5=9C=A82024=E5=B9=B48=E6=9C=8816=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=94 UT=
C+8 17:16:28<syzbot> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit: 9e6869691724 Add linux-next specific files for 20240812
>> git tree: linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14d27ae59800=
00
>> kernel config: https://syzkaller.appspot.com/x/.config?x=3D61ba6f3b22ee5=
467
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da2197ed0ab131b=
bc9d02
>> compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) =
2.40
>> CC: [ch...@kernel.org jae...@kernel.org linux-f2...@lists.sourceforge.ne=
t linux-...@vger.kernel.org]
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/di=
sk-9e686969.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlin=
ux-9e686969.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/=
bzImage-9e686969.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
>> Reported-by: syzbot+a2197e...@syzkaller.appspotmail.com
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> WARNING: syz.0.454/7910 still has locks held!
>> 6.11.0-rc3-next-20240812-syzkaller #0 Not tainted
>> ------------------------------------
>> 1 lock held by syz.0.454/7910:
>> #0: ffff888011f98f50 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_down_=
write fs/f2fs/f2fs.h:2196 [inline]
>> #0: ffff888011f98f50 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_ioc_s=
tart_atomic_write+0x2ed/0xac0 fs/f2fs/file.c:2163
>>
>> stack backtrace:
>> CPU: 0 UID: 0 PID: 7910 Comm: syz.0.454 Not tainted 6.11.0-rc3-next-2024=
0812-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 06/27/2024
>> Call Trace:
>> <TASK>
>> __dump_stack lib/dump_stack.c:94 [inline]
>> dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>> do_exit+0x1b67/0x28e0 kernel/exit.c:969
>> do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>> get_signal+0x176f/0x1810 kernel/signal.c:2936
>> arch_do_signal_or_restart+0x96/0x830 arch/x86/kernel/signal.c:337
>> exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>> exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>> __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>> syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
>> do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f7ba21779f9
>> Code: Unable to access opcode bytes at 0x7f7ba21779cf.
>> RSP: 002b:00007f7ba2fa4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: fffffffffffffffb RBX: 00007f7ba2306208 RCX: 00007f7ba21779f9
>> RDX: 0000000000000000 RSI: 000000000000f501 RDI: 0000000000000005
>> RBP: 00007f7ba21e58ee R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000000001 R14: 00007f7ba2306208 R15: 00007ffc9069b428
>> </TASK>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzk...@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-upstream-moderation" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-upstream-moderation+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-upstream-moderation/e8ce9858-87ab-4f0b-85a8-8817ec376986n%40goo=
glegroups.com.

