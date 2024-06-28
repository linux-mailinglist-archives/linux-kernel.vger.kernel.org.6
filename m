Return-Path: <linux-kernel+bounces-233232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65C91B494
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE951C21613
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F963D0;
	Fri, 28 Jun 2024 01:20:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104E191
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719537604; cv=none; b=SDVL62h85o0ZY6cKxYaf80gptWGHKC675oP0EOeZjOWfkMPun4juoaAZa5bz9LbLjOKm+ZseOvF/rjmEtgSb9UG3FGr6UsABEPBO2IP8QVkdEARIhB/Ma9OB2CoUUl0066LSYL82KO23mNjZDb0BQRcImyn06ELm+SmuQIqWFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719537604; c=relaxed/simple;
	bh=Ji/Gg8U4lhfYtt02DzayyKvZN8tH6symuFCYLqn9Jyc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ie9u80RMZWA5JDmIhS6ckImNKpVvrbt1L89is3XGktUM6UCzpsIH/wZH8L3pLSpIBcy/y0O6VPtNYGzagA1qjPJ7gx7gEtenzQsuVbEvsT1NOgiV2942ecn5Z2L1eUmw+A3my+f4f6pzORfFGOmmfRe3U1i2QGbOs2wBmDzOIaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3760aaa46a4so1619405ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719537602; x=1720142402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpWLsX90e/hE7U+B4St+2+eLs/0LrOg7foYXKcFL9B0=;
        b=HzM2V1pkFqxEOrNaK/qK/fZd3RCRzmViegQKkQ6HulWQPrmlNxOcmME97dyHr6qMLY
         32HyfDGmUQyeuCcuviY28WDxbtix4kIIw0+GTX5LxdsgbSrG/SOHfkk2sIA6MZeJwy4m
         GdmawqPe6AKqX+0Ut5ACyIJEp1GmQu6knAIzvR4Eqg4eVge5khIJrjF0tEh/r+ZtRIDS
         Vz8k8LfCqfrhJAd57NLecPaU0TE+go5cx+o4R8u+2VMzF0wGo6TesNeScgOU9LWAxVax
         bHU871AQAUvSAS+d3fbauGGbmKVUax/yl3xy8i02yEEx8I84elx/iQpaIHQ5nccrYTpb
         SA9A==
X-Gm-Message-State: AOJu0YzS2qD10FY3iZWOruQPs5QOQglKRb8YTMQKRxsWtvCqa3LPxjA9
	x4AKaoEZLRy+2hAhTMjGyIdtzf5T3cy/SlRid/CjjuWcjFYfTdZyQ+wjQfz147+yhngeuM9Zpfa
	xctdJ2vmvuMN4nInBAVI4mHtkwNdIHm/B9fwvAKgz0fTw0p2Yd6IAn8Y=
X-Google-Smtp-Source: AGHT+IHrrVydodAPGoY9ksEBSOT84E6G0G077rkyNObng0ofZiIurQJmGzIYzcZJLsLbGNABiS/c0EwtCYDIHJUanVO+xzO9AEhJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d702:0:b0:37a:330c:1979 with SMTP id
 e9e14a558f8ab-37a330c1c32mr938475ab.5.1719537602534; Thu, 27 Jun 2024
 18:20:02 -0700 (PDT)
Date: Thu, 27 Jun 2024 18:20:02 -0700
In-Reply-To: <20240628010120.3584455-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa30a9061be90b81@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in __btrfs_free_extent (2)
From: syzbot <syzbot+fe3566bcb509ae7764ef@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __btrfs_free_extent

------------[ cut here ]------------
BTRFS: Transaction aborted (error -2)
WARNING: CPU: 1 PID: 5913 at fs/btrfs/extent-tree.c:2985 do_free_extent_accounting fs/btrfs/extent-tree.c:2985 [inline]
WARNING: CPU: 1 PID: 5913 at fs/btrfs/extent-tree.c:2985 __btrfs_free_extent+0x3564/0x3a40 fs/btrfs/extent-tree.c:3360
Modules linked in:
CPU: 1 PID: 5913 Comm: syz-executor.2 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:do_free_extent_accounting fs/btrfs/extent-tree.c:2985 [inline]
RIP: 0010:__btrfs_free_extent+0x3564/0x3a40 fs/btrfs/extent-tree.c:3360
Code: ff ff 48 89 df e8 9c f9 50 fe e9 9d e0 ff ff e8 22 7f ee fd 90 48 c7 c7 00 2e 0b 8c 44 8b 6c 24 18 44 89 ee e8 ad ad b0 fd 90 <0f> 0b 90 90 4c 8b 24 24 e9 13 f5 ff ff 48 8b 4c 24 20 80 e1 07 80
RSP: 0018:ffffc900042af340 EFLAGS: 00010246

RAX: 6c4a53fef53c7400 RBX: ffff88807135c001 RCX: ffff88802ae55a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900042af510 R08: ffffffff81585742 R09: 1ffff92000855e08
R10: dffffc0000000000 R11: fffff52000855e09 R12: dffffc0000000000
R13: 00000000fffffffe R14: 0000000000000000 R15: ffff88806f7cf818
FS:  0000555588813480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558881c938 CR3: 000000007124e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1736 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1762 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2027 [inline]
 __btrfs_run_delayed_refs+0x117c/0x4670 fs/btrfs/extent-tree.c:2097
 btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2209
 btrfs_commit_transaction+0xf5d/0x3740 fs/btrfs/transaction.c:2400
 sync_filesystem+0x1c8/0x230 fs/sync.c:66
 generic_shutdown_super+0x72/0x2d0 fs/super.c:621
 kill_anon_super+0x3b/0x70 fs/super.c:1226
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2096
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9668a7e257
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffdf71b8e28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9668a7e257
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffdf71b8ee0
RBP: 00007ffdf71b8ee0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdf71b9f90
R13: 00007f9668ad96c6 R14: 0000000000019832 R15: 0000000000000002
 </TASK>


Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16868cd1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=fe3566bcb509ae7764ef
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1666bda9980000


