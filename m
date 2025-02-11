Return-Path: <linux-kernel+bounces-509950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDECBA31671
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39B87A1D03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F5526158E;
	Tue, 11 Feb 2025 20:11:26 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52B265603
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304686; cv=none; b=im2ulY+gawb1xCIOfQpMzqEvKO97+0/MWFqZXsUaEl8yd96Tvik1tleeQD7RIvMgCxkQsTLm/zTZvvmox8ssqwT6lcj+RnJ6lp9ip5XtQQ5pgIsCsqAWP5T5+qVqDqvRdrSQsdoRFTw5CZ7M/rRB7LbjH4zBC+Cgi+ZvMa54c7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304686; c=relaxed/simple;
	bh=qkTtrfTVE2e5VnCCfLqDdAUacevlSdasx1HzE+O11r4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F0NgO419408P+R7HU6HYEMWuO407GsmF299GUxinc9UKSUz3ZogvikX2GKijLifIHeAe5nMTAzOn9H0A4w36ZOcr0sDD/cZ9vp19Zid5813uMKfG0wDVdPjuT27r34yYCIFj5x2nIWXt5OCI4heDJKfSvOFegMtFIg6qbpPf3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cf6ceaccdbso44250675ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 12:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739304684; x=1739909484;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRVAjGpy53j9eMkWE5h3z1GKtU13K2c7lkx79j1/V8k=;
        b=e5DMPgg1LC3WO+E6suhP+iU/MbqSmKr5K0YqE/taElnEl/XhoX7XN+dG3uBmJtK9Lz
         JWfkyhlUEIIhS436meTmERzn3utDgFKfqfajxTE91hbzcLO7HeTarg/Hn2X+cdsTQz8f
         X+4hKHHhHePD4K72Yh5876Y7HBND20oryPkB9z7Thk9PwU+9Y82E7h8at8wrw4hnrgGU
         aXDaaYwoC7nPQZFBGm5VVe+suALSrvmU/4mHw9kDMcivPtFi0O7G9k/Q99h5DuKaIZHk
         2R0eXBPi9OdeOZjZbUymEPKQ6md5Cr6abNgprQixcJFLCg9i+1LJFiKQ2qx6tnQn7ysQ
         Ql7A==
X-Forwarded-Encrypted: i=1; AJvYcCVs4Vszp8qeieF/LPVbUtmpU96KSvf+4MxWN46rREqMp39K3m/rId8GFLiNEVPduVzBriOkbNQ9lhYx35Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoU7RsB7ZpdXtPq3QQV5hFzFuKsdtuHaho7K4n37ILuq9Gi/L6
	+3EICQR3iUZ5pcQgl7xyUNK3i0/GExUIw3lYAUBohUDSY8uXDBM3nAiYe6UKTqLRX6El41/sNnT
	1h+NVDcecd6ub5bZ+N7Rsi965Av3hTGk9z9FfsresKl2RvHcM1Ca8OkA=
X-Google-Smtp-Source: AGHT+IEB0erOopqlfKrN/oqmh8lDIEhXJynd0cj6id7WlVR43LgxciVegxBjDWXuto70F+E5kupPmj6oIrriPnUDIaYNc6jvPyHb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3cf:fd28:852 with SMTP id
 e9e14a558f8ab-3d17bdfe77amr9760125ab.3.1739304684201; Tue, 11 Feb 2025
 12:11:24 -0800 (PST)
Date: Tue, 11 Feb 2025 12:11:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67abaeec.050a0220.3d72c.0087.GAE@google.com>
Subject: [syzbot] [v9fs?] KCSAN: data-race in p9_conn_cancel / p9_write_work (7)
From: syzbot <syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    febbc555cf0f Merge tag 'nfsd-6.14-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114123f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7722a092753bcf03
dashboard link: https://syzkaller.appspot.com/bug?extid=d69a7cc8c683c2cb7506
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34e7d4c83286/disk-febbc555.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483282168b02/vmlinux-febbc555.xz
kernel image: https://storage.googleapis.com/syzbot-assets/510fcf6f96a7/bzImage-febbc555.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in p9_conn_cancel / p9_write_work

write to 0xffff88810db66428 of 4 bytes by task 23357 on cpu 1:
 p9_conn_cancel+0x89/0x400 net/9p/trans_fd.c:199
 p9_poll_mux net/9p/trans_fd.c:631 [inline]
 p9_poll_workfn+0x133/0x410 net/9p/trans_fd.c:1177
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3317
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3398
 kthread+0x4ae/0x520 kernel/kthread.c:464
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

read to 0xffff88810db66428 of 4 bytes by task 23378 on cpu 0:
 p9_write_work+0x26/0x750 net/9p/trans_fd.c:453
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3317
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3398
 kthread+0x4ae/0x520 kernel/kthread.c:464
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x00000000 -> 0xffffff98

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 23378 Comm: kworker/0:8 Tainted: G        W          6.14.0-rc2-syzkaller-00034-gfebbc555cf0f #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: events p9_write_work
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

