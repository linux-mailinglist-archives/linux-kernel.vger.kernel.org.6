Return-Path: <linux-kernel+bounces-315306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B8496C0CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646601C2105F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7BF1DB53B;
	Wed,  4 Sep 2024 14:37:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484CB29402
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460624; cv=none; b=QYfzZVQM+75/6EDUNWmK2pnf3IZSTYnRhtTSAC1FlLKuR3MvjzIgZg3SY4qIC6I/hlmuVscj8ShiLnu43K5SBKRMV7me9QvmEmLbDDvdDKq4D+afphYi7PaLPDdUpqoQ2l1SCx/V+1fNDr6FLK5E9dNFw3wljmqQk1C2rnsOaOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460624; c=relaxed/simple;
	bh=ZPaxWUJQgukT3+KV+S9H9yUh9aRNhsE0ySYUEWr63jI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HsUeL6vAA1svlcOy2Bx4MnY50XGWUFWg8JTxitjNAe4WeEIafrbAf5AnTPqGi6G7sJodPeMXNB4IwlDtgAgzHZNsczF4UwWaz6grD6cVrLT3RsS4zDgLs9CfN8YbC4GerwOFt8vpaj42Vm9VR4/nN5ad6UC5zS6ou+wHL5n+vNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a72792dacso258345739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460622; x=1726065422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XGZeDRu/OrEJskDDOpGs61DlYMxxGFWI44hP9TATJY=;
        b=WmW/JvausZSrnTtPTouV98tNrgQHd33dCFGcVQPfVtovzNqC4xf6cANQkHrH4DC1Y2
         NRzV8A+VSqgUhdq9wjEQce1ZHDjTTKIRF+ayBoiAcF9mpR7LKnVsEZNu5JbbiYaMltG8
         87NL4hxvW1HA9hc9QtJ+k2ebVgZCsaQfGjqwDRTZFV0ogSQIn4NlKeDfw8pOb9sZIhMe
         Qx2V7FMtIySIlu0s3dxQK9UINgj2tBO5FqVQW26gquKmzpEH5hUgKb9O7+d/lXTfLXYF
         gvACErgg69RxdyS7/QHF64QpPLtcwpVwjs2dVhskFrviBLJ3zP4KFTI//jK4zheUultV
         DHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhqEYE8e/StjPu3uKsFZQt18sBFCZkXthghPAUqq0tMFw/ny/epgc3FPej28OfEC/bqXg+FGGuy26Yfeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaLoAMuzASXZQUjCqop1QXy+1tPgSkPakqg33mMimXBOrlU0k
	pBWPMbbC2Jpp25uTiD7iZ5ZKVpGWvPakwaSB7NBbWwLwqmyX5xr5S7MAp/BidKd1AHWtWow0+ML
	7R0Iyu/oGKZNVQzEKNw0fNIym9ei2xaP+E9VVEZB4SfGgemfp0wEy5sA=
X-Google-Smtp-Source: AGHT+IGeY6s09sRnaIh9w9stogz5TD+Aujy4qLK7yof3SfbYdBrznlgH6SuzZKM+s8e50SZtlC5moSLJQCxtnR/OpFTBG/KqY5/5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c7:b0:824:d801:5490 with SMTP id
 ca18e2360f4ac-82a262c338emr39382739f.2.1725460622317; Wed, 04 Sep 2024
 07:37:02 -0700 (PDT)
Date: Wed, 04 Sep 2024 07:37:02 -0700
In-Reply-To: <20240904142214.13333-1-almaz.alexandrovich@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077c20d06214c1bba@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in vprintk_emit
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: stack is corrupted in vprintk_emit

ntfs3: loop0: Different NTFS sector size (1024) and media sector size (512).
ntfs3: loop0: Failed to load UpCase (-22).
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: vprintk_emit+0x764/0x770
CPU: 0 UID: 0 PID: 5705 Comm: syz.0.15 Not tainted 6.11.0-rc1-syzkaller-00017-g689ecd06ef8d-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 panic+0x349/0x860 kernel/panic.c:348
 __stack_chk_fail+0x15/0x20 kernel/panic.c:821
 vprintk_emit+0x764/0x770
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 ntfs_printk+0x3ad/0x420 fs/ntfs3/super.c:93
 ntfs_fill_super+0x2eb8/0x4730
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc24b57b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc24c381e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc24c381ef0 RCX: 00007fc24b57b0ba
RDX: 000000002001f800 RSI: 000000002001f840 RDI: 00007fc24c381eb0
RBP: 000000002001f800 R08: 00007fc24c381ef0 R09: 0000000000000801
R10: 0000000000000801 R11: 0000000000000246 R12: 000000002001f840
R13: 00007fc24c381eb0 R14: 000000000001f829 R15: 0000000020000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         689ecd06 fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12273163980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0cca2f3880513d
dashboard link: https://syzkaller.appspot.com/bug?extid=4d2aaeff9eb5a2cfec70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d41fdb980000


