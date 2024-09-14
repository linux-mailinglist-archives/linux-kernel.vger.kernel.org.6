Return-Path: <linux-kernel+bounces-329395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8279790C5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 14:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D09284B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9081CF7BC;
	Sat, 14 Sep 2024 12:15:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994891CF5F4
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726316105; cv=none; b=icQl+Lf3bSHrWPdCuG6a3JK7g+0jyeKYPBrjO/l7Z6nSzdFET4C9QE3eshhqkfoFeejDWxNfSOfi4hITeoy1UB9ff0PQvpfIG959/OBhSLQOyAqbE7iHneTNmw4RHdjpKxN5+KOHFojQ3cucNkXooIYEm29C6jYTW+KFDp8H4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726316105; c=relaxed/simple;
	bh=jWChWfgfN+58Jr1U9s7nAsadg0GktEvvZErgoD0Bhik=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NT4VEpqvHFi8HFAAyaavzBgXQ9xInAtmO5cVJKqUEvv1yVCFXhTSFNX4mNZbVrtCaUKLcf/88ZqtF8Mj58uDZf3uDLCT4Rju7w+idE0Tb5JSsrCMYx9KPXg8i5svfuemHHNGvef+uXtTtljlk3O9Ed7AB0PgNLpnO3LTaXaaPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a08d90c938so46814245ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 05:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726316102; x=1726920902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzGv6iFwh1lE0Ji83jyaP5V8lNuOWsUXua3UnU6JHbs=;
        b=gtKLSWvAXgWhQmtlSmm84TwyocrxYnygbKVUF87hzaClo98cNo28jxIf4hIBVpE+X5
         5zSVMV6zipiAahZrL6Yxyu3x+s+BBm8hNY9fhCLPBglFvbdkfe8P251afvegfytIbjSP
         2dYXvW4wmzzzaYeKPy9q3ntOjd2J6StCiKkrLSB+zBh9qoAMeoF6TRqILQ3wxZ/EcjIq
         sard4lt0B0PlYzfFYp0kJwEh5kTC0OnYw9ludiU0mATYGCnZu9MVLczxV3sO/fbx36tO
         Lcmh3ddaeLxfqTcZLnvHQ0JpWT4VrL1CcraDlYkPbafRMYvtramxIqdaQ5dr87vACpUY
         T+IA==
X-Gm-Message-State: AOJu0YzbyAPMzlQFXq/8iXsJlEwJAsz8TPkPSIpGWRW9RYdynW6veh8h
	HKavQFXtLG3yVo3Z4pAZa7BSj0V0PXhuZMZujt8+d/IjRpP3hUM8E7UAVHZnbQjeDfKhKSoPtzG
	cXe0g/VvoZBJGVo7rw7LzPSaHiOaK6C7lB1Bu4JlxsEiMJqzjzDS5kAI=
X-Google-Smtp-Source: AGHT+IGAdVnVJgs/ifGHJFkZXdGs+sV9hQ3jNs0C9+iqyj3oKwPIbiE7oUIDAKL0KMwCtfs/aTRYEKUtZT8tLlY7dLhABL7OYpj8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c549:0:b0:383:4a12:b77c with SMTP id
 e9e14a558f8ab-3a084902ac6mr108353875ab.8.1726316102536; Sat, 14 Sep 2024
 05:15:02 -0700 (PDT)
Date: Sat, 14 Sep 2024 05:15:02 -0700
In-Reply-To: <Vb6itTIqiK_hBcmPGWEcD1s6-FXS_btlvF1QhQYj6P33qEOyDUlGjdEAQz_lTPdXxCX09q4bEPzeE7mTrcy4R8mublQS8aUISzxZKCYeppQ=@pm.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e57e46.050a0220.115905.0002.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bkey_cmp_packed_inlined
From: syzbot <syzbot+6f655a60d3244d0c6718@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@pm.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: corrupted stack end in x64_sys_call

bucket 0:127 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:127 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
 done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay...
Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 UID: 0 PID: 5945 Comm: syz.0.15 Not tainted 6.11.0-rc7-syzkaller-g57719771a244-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x216/0x2d0 lib/dump_stack.c:119
 dump_stack+0x1e/0x30 lib/dump_stack.c:128
 panic+0x4e2/0xcd0 kernel/panic.c:354
 schedule_debug kernel/sched/core.c:5745 [inline]
 __schedule+0x660/0x6580 kernel/sched/core.c:6411
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x13d/0x380 kernel/sched/core.c:6621
 __closure_sync+0x163/0x1c0 lib/closure.c:146
 closure_sync include/linux/closure.h:195 [inline]
 bch2_journal_flush_pins+0x263/0x3b0 fs/bcachefs/journal_reclaim.c:851
 bch2_journal_flush_all_pins fs/bcachefs/journal_reclaim.h:76 [inline]
 bch2_journal_replay+0x4923/0x4d20 fs/bcachefs/recovery.c:383
 bch2_run_recovery_pass fs/bcachefs/recovery_passes.c:183 [inline]
 bch2_run_recovery_passes+0x400/0xec0 fs/bcachefs/recovery_passes.c:230
 bch2_fs_recovery+0x42d2/0x5c60 fs/bcachefs/recovery.c:859
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0x13e8/0x22d0 fs/bcachefs/fs.c:1954
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1800
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3472
 path_mount+0x742/0x1f10 fs/namespace.c:3799
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:3997
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3997
 x64_sys_call+0x255a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6261f7e69a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6262e37e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6262e37ef0 RCX: 00007f6261f7e69a
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007f6262e37eb0
RBP: 00000000200058c0 R08: 00007f6262e37ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020005900
R13: 00007f6262e37eb0 R14: 0000000000005905 R15: 00000000200001c0
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         57719771 Merge tag 'sound-6.11' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162ce900580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea008021530b2de3
dashboard link: https://syzkaller.appspot.com/bug?extid=6f655a60d3244d0c6718
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11026200580000


