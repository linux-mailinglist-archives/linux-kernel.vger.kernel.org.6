Return-Path: <linux-kernel+bounces-318702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C102196F1CF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B368B23A4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBDF1C9EC1;
	Fri,  6 Sep 2024 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zAoqS5Gz"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F751C8FAD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619471; cv=none; b=przrHClmlxbskck2IJgM37uYK0IEa/xy3zrPX15AIsNqDOf/ny19WtYMnHCGf8hoK2SkheEbZ2OAKyRBjSXobE1MZtV+y8f10XKTk1RM7JrMSZJ+nPY66Cj+1fSHzcxJHiaLjMUfUw7342nlATV/5gsj8okNsBEMRzNLEXgNjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619471; c=relaxed/simple;
	bh=EPZXNYChmsgpn0FiCj/12zuLDOBkntz/EicMBD0Qyjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4+7/IZ19Zftkz2leDeMxfpM/mJQEhiWIkP8Ouy9cYzFrx27DahTHwly3x16CAJrKNtdRQYPBSBNbAX8Dh/Ay5MnzrGpkXYIYozj7i96LWWzmrt2kP0aAlMZgISNnozrUHuHpLNxI0xee4v+4ZWX/Mznm0wxm9Mze0szBild+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zAoqS5Gz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201d5af11a4so17596015ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725619469; x=1726224269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEDhjs1dPGhHsTTS8KRGYVRNqk+5eA18KbLWBWUQD1g=;
        b=zAoqS5GzXfT8pk8b1G9EYF741gSwHRsNzHpv+fGy8bckQURc2Uk78954QfxhubkgGi
         vodEr5gXEjEmCXsGPrZzEhSf9YXNHkhOpLEIddTCjcoCHQl5NLf7WtGkglZhzAQqejog
         ZtlTvMtU4PHOXsbzTbW/Tp0VW6/j0FgkHxXakN/ltYZvwjI8ORWYfppgB18MtqdAf4fl
         vNCJ74X8K3eOlQ0kdmB/g1E72vUv8aSuLBFLHdPCOKn/YnmFbcTcCvm5t1TDoRA8wTvl
         BZXxGiFs98C2ldkUmKbtO3YlriEX8vMdWFGXqE+9irreJ/iwY5jy6MY1LfVVGdPv0ZUz
         MHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725619469; x=1726224269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEDhjs1dPGhHsTTS8KRGYVRNqk+5eA18KbLWBWUQD1g=;
        b=BlHoV/QKVaCjcYTjoVLDYk8TeQYiMxR257tSo3FbbGljozqxK8Jxp5pC2OHneMKhp2
         21QwH7MBSb8INGH9STC/l+uMy2fNpFRVn4oq2/dOzakHJcwq4ox/JDUdad5nk98GY/QY
         8yIdExQypBCbxypfjVLQaq7Vo0aLj+RcqySH8MHe4sI33KjsqoJ1xSrlg04OPc/j6Uhp
         +QZvdoBH9wfXxyFXsicnlTOY/GxzriaAGuT98TX0X04I7qmWbxT2rytUU1mxqhljNwKo
         CQ4apfqc8WKwnWj8Z1nZSz15R4Eesy1CLk1PMPVThfBG7zLNdvCwIYHQLz5kDmzh/P9D
         o6oA==
X-Gm-Message-State: AOJu0YyoLVIe1Szq/7RFxrtdnl7OuU7I72Prux/zG8/XHw8zEStkA4Oh
	SNYZQxaUjl10GMXxvoNM3plelMrKcbPzzsje8ld/oBjpzKUhCsPXIz99NHZqzF7gZj6P6l/iItZ
	svj7Al7QiaSr0+LjF5c2PAcsj1pY9eSdi73ICAmtvaWIA44NsaGGJ
X-Google-Smtp-Source: AGHT+IF8xAPFE32dNLBRqKgAJ914EV4I6V2zL0dI2YFPfxede0fAesRpSeJtry6v/kGrvSMaRqTjUPEl2lpJ0xKHV9Q=
X-Received: by 2002:a17:903:2405:b0:206:96ad:e826 with SMTP id
 d9443c01a7336-206f05500a0mr22641525ad.32.1725619468426; Fri, 06 Sep 2024
 03:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004235960620ff3c77@google.com>
In-Reply-To: <0000000000004235960620ff3c77@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 6 Sep 2024 12:44:14 +0200
Message-ID: <CANp29Y7zck3_Ymhw1tC6oNLnNxw6qPWr94FjXwRGGE=UKyj7Kw@mail.gmail.com>
Subject: Re: [syzbot] [v9fs?] WARNING in p9_client_create
To: syzbot <syzbot+3c38ca819d922062d22a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Very likely a false positive.

#syz invalid

On Sat, Aug 31, 2024 at 8:54=E2=80=AFPM syzbot
<syzbot+3c38ca819d922062d22a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6f923748057a Add linux-next specific files for 20240827
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D117f47a798000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D65c4a779aad26=
33f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3c38ca819d92206=
2d22a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4398d0ec73ed/dis=
k-6f923748.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1f7e004ef90a/vmlinu=
x-6f923748.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/333e975a3aac/b=
zImage-6f923748.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3c38ca819d922062d22a@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> kmem_cache of name '9p-fcall-cache' already exists
> WARNING: CPU: 0 PID: 5316 at mm/slab_common.c:108 kmem_cache_sanity_check=
 mm/slab_common.c:107 [inline]
> WARNING: CPU: 0 PID: 5316 at mm/slab_common.c:108 kmem_cache_create_userc=
opy+0xb6/0x370 mm/slab_common.c:311
> Modules linked in:
> CPU: 0 UID: 0 PID: 5316 Comm: syz.1.7 Not tainted 6.11.0-rc5-next-2024082=
7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
> RIP: 0010:kmem_cache_create_usercopy+0xb6/0x370 mm/slab_common.c:311
> Code: 48 8b 6d 00 48 39 dd 74 25 48 8b 7d f8 4c 89 f6 e8 ff 16 dd 09 85 c=
0 75 e7 90 48 c7 c7 38 0a 0a 8e 4c 89 f6 e8 9b c1 79 ff 90 <0f> 0b 90 90 4c=
 89 f7 be 20 00 00 00 e8 59 18 dd 09 48 85 c0 0f 85
> RSP: 0018:ffffc900040d77a8 EFLAGS: 00010246
> RAX: 2c465ce8c6b42a00 RBX: ffffffff8ea1ba80 RCX: 0000000000040000
> RDX: ffffc90004ba2000 RSI: 0000000000005a3c RDI: 0000000000005a3d
> RBP: ffff88802203e068 R08: ffffffff8155a5b2 R09: 1ffff9200081ae90
> R10: dffffc0000000000 R11: fffff5200081ae91 R12: 0000000000020018
> R13: 0000000000000000 R14: ffffffff8d2d3620 R15: 000000000000000b
> FS:  00007f80561806c0(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020001000 CR3: 000000002b984000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  p9_client_create+0xb0b/0x1040 net/9p/client.c:1042
>  v9fs_session_init+0x1e4/0x1b80 fs/9p/v9fs.c:410
>  v9fs_mount+0xcf/0xaa0 fs/9p/vfs_super.c:122
>  legacy_get_tree+0xee/0x190 fs/fs_context.c:662
>  vfs_get_tree+0x90/0x2b0 fs/super.c:1800
>  do_new_mount+0x2be/0xb40 fs/namespace.c:3507
>  do_mount fs/namespace.c:3847 [inline]
>  __do_sys_mount fs/namespace.c:4055 [inline]
>  __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8055379e79
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f8056180038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f8055515f80 RCX: 00007f8055379e79
> RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000000000000
> RBP: 00007f80553e793e R08: 0000000020000440 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f8055515f80 R15: 00007ffc6f15d8c8
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
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/0000000000004235960620ff3c77%40google.com.

