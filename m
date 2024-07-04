Return-Path: <linux-kernel+bounces-241252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC17927907
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B674728FBEE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9D31B121E;
	Thu,  4 Jul 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rEIhdvNR"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0DE1B0117
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104059; cv=none; b=DBsq8CDi8Yf+jH9PHQaLBmdFIEOx35Qk6zjZzrsLJ6m3PLd5lg4l7nirDitWC+36R3xvgJZY206fsTK5ssMp2mPznR7lXSUfDEy1JO1XvNcMQwuBG2331r7VcoRDxd0QxG6MNSLXdEIDfwwQVEx0P7kvCsA2R5icOT1bfsBL9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104059; c=relaxed/simple;
	bh=7HbxzxvZ6O54ybYuKdJocY8kqKrkHXVIvqjIhkTKOqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr3gibCrZr90UZWTZQVlnyjoMz7Ip9qZe9UqSh+bD9VC57z6iTH8/7DFqSjqegmmgRe620VCrI8ktvLUBvPuCnXyCLdFF6GWsbiXK3hs7Emnvuawr+pRKV4gnY3gJC1hcUmbS3ONxInNFWWyQt1nce/s7Fy5TLHkyLLMQnkxLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rEIhdvNR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so10264a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720104055; x=1720708855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PoLPRA+i9BYRAbwvGDWgm7HQ9jCtDQ1wLiDIU38H3hE=;
        b=rEIhdvNRUayBzS3U7ZgPFsuefAfDj95pLjMg22C8cnJLSQdIePJ5UW6nnFtRt3O92N
         h8TaTZdq4ryMVZohRqLRPoJPVx4OodQ0cZN6hrdxi98NUe/ig4JKBVjPURspzL9Vpfrt
         GldwuagWY5b0BNLOc+6yqAGeniJG/j0vH2A3b4i2K98UbXnqTtJ6VAC9BOVn7VyEyefs
         qT6L9KF96i8jxMwLdkwdTWbkCRg36FWSmEcp1CSwCPyQxwpB/WLK74//EDUUmfBV78gA
         enEz/Ystn2adXsSXfCnr18njxVhTARG7Qji4B177SkDli/S6qsmPKX5XChGcOCfy4R78
         cjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104055; x=1720708855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoLPRA+i9BYRAbwvGDWgm7HQ9jCtDQ1wLiDIU38H3hE=;
        b=DNoGEUGgTiQ7So48Tb/wl/U1GSfOOUlwoqiqmahmh97HfrK2AZF+bxAyfevk9XCIQ0
         Py6HMD+C8d4oi0vAmkovWEln8JKFmVF8eXGWRpyA+xWEmfb2CY9nLBl+TXNewwEHQYZz
         MJNGpVv93/ReTsIL+S1szCCcFMWlkHy0yIqX7G3te+8HpdXnUFSZ3CqVp1B9v45DnLu+
         +esQPl8lQyxmE391PD6DCyaf03bU81nELArFCGdg0uvAnYZ5MG2cwkJZ0oc9BijnbgmG
         5NL0+SAJHX0j0SoZM1LXG19JALMY/IjkZgSnWLtCDLh5F5I34KoRa7+n8pf61NMtIcqq
         tCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzHISJcMZWBGXWqyjMm3tp8OJQeACP6zyhkyefl6uVoxKpLHZSmOjZYZAVLz9Qj23441bNxcp/Ks98qwj/JmAI2hyMn+RA9FFTLeTJ
X-Gm-Message-State: AOJu0YwHRUmQw4Ni2AT5l7YvfcujgTeJVlJ9XOFpes5IeTYsMBlDY/fn
	eaD/gfsVDDrErsIlTNNfrhGcz4CZVCWZDbjsR6jyf/f5ahbGGC7DXzLgWMIITXsT2ALxBmXvcJU
	fT22lQy0+YvvyBbNUB3PKj/hmVIUBkBDHmW2x
X-Google-Smtp-Source: AGHT+IFrlXTCWuQfrcbv3kCuJEf2AxaTnkqg7uLz0SX7b6g3ZVoMlN3HPnKhGi/0cay3T6b6sdaWjs6Tg5SR3YNd8xw=
X-Received: by 2002:a50:934f:0:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-58e2942d74fmr114676a12.7.1720104052327; Thu, 04 Jul 2024
 07:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fbb100061c6ce567@google.com>
In-Reply-To: <000000000000fbb100061c6ce567@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 16:40:40 +0200
Message-ID: <CACT4Y+Z34Mc_Vv8-dDvD+HE57tMez0Rd17zr_s-3Gn23tOVG3A@mail.gmail.com>
Subject: Re: [syzbot] [fs?] KCSAN: data-race in __ep_remove / __fput (4)
To: syzbot <syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 16:38, syzbot
<syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    22a40d14b572 Linux 6.10-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f94dae980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3195ed1f3a2ab8bea49a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ebe2f3933faf/disk-22a40d14.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7227032da0fe/vmlinux-22a40d14.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a330dc1e107b/bzImage-22a40d14.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com


Double-checked locking in eventpoll_release_file() should prevent NULL
derefs in eventpoll_release_file(), right? If so, it's probably
benign-ish.


> ==================================================================
> BUG: KCSAN: data-race in __ep_remove / __fput
>
> write to 0xffff88810f2358d0 of 8 bytes by task 6036 on cpu 1:
>  __ep_remove+0x3c9/0x450 fs/eventpoll.c:826
>  ep_remove_safe fs/eventpoll.c:864 [inline]
>  ep_clear_and_put+0x158/0x260 fs/eventpoll.c:900
>  ep_eventpoll_release+0x32/0x50 fs/eventpoll.c:937
>  __fput+0x2c2/0x660 fs/file_table.c:422
>  ____fput+0x15/0x20 fs/file_table.c:450
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff88810f2358d0 of 8 bytes by task 6037 on cpu 0:
>  eventpoll_release include/linux/eventpoll.h:45 [inline]
>  __fput+0x234/0x660 fs/file_table.c:413
>  ____fput+0x15/0x20 fs/file_table.c:450
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0xffff888102f1e010 -> 0x0000000000000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 6037 Comm: syz.0.1032 Not tainted 6.10.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> ==================================================================
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
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000fbb100061c6ce567%40google.com.

