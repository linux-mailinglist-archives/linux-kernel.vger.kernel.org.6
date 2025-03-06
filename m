Return-Path: <linux-kernel+bounces-549513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46FBA55366
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1611771EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CD725B67E;
	Thu,  6 Mar 2025 17:48:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C37212D69
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283284; cv=none; b=JQrgMN2Vp1YFxXFCq4ccv0ilYPJbk0iAJeBa5tc4dY5mhXlTFybpXbxSSc/clCJBhg3lte3FToD+APM8jJOBAJj8J4xLlCg+oOWnK/bx0T+yOqJ5yMPScFqeTG7tkfkhAUakCVjZKwd9Ye4pxgLS/MeUTUvWCKE8iY6KhdYwgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283284; c=relaxed/simple;
	bh=DAhoYEYrYYl1U2ckkckiEsFZ2YDZ5s6eLPhPU59sYI0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JNN48SwbPybI9RiEWLZ2gitxBx7GczXMSr2KyengdqpkdzJ0ATCVXkV4caiDreahE90my9dGSKbEqKsrJc2jk+XiGL7zizBCK3zJ8/ahkVqsyGqNltclsxO4GxJNn9N9FiUZjK1fIT8vk/1gp0fF6RQmYNLFB8PcvCwYZqFDp50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce8cdf1898so6579975ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741283282; x=1741888082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWcpTlHBnq0hArgDg9Bi21W22wNdZEZieUrXbJJbhas=;
        b=LdX88/UMWHDfqanrZQKoAow6wruFz5xwjSu6M74jX7wtxVVqePVwG5V7Uxqo6HPi+F
         Q81evvi2CbmMssH64TZCREg1okJ4LqS4/BhshAcSrMeFGTq83vzRfSycGOAOS6P30wL2
         AlNwK0Mch0woqp+IAsFqjwjGBA92JrDcLC9L7JSzuwF1REmqXH630bPklBxIYUV/E//u
         zZgtBSAecXAU1kPLuV2hmySzDp+GU5NmNyPEu082Eb68bnCgvmKMZR1lRe849X81WNeK
         UGXFyJaW3X1VGDAYt6oL3V4AhIuvqoxaxbxsyI8Uro2HQMtzPdCsAp8EAd051x7FxM67
         gE+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIpe7+aSMh/tjHLxvjBtO3eP7uN9IFF71XnLoNwkUN5dlnfVQZ1+R5+qmyiJmYiPERs8oIK0CUqzMsMRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTQ+/k4QE1tmPAQVqKZM2gyhG6y6zHDeAcfWH4xMwQO/bU87J
	Pc0OkPB1ZhuhTxkjrUHeKenzaBCnSEHfKjkCbsfMAG3NFUnbU5gkFH61hmMnLwdngCencLq98g+
	FFAvUHWd1EtPFNBonPUxmM0lTxCzQTgGkO62RGLFLlKBkU5uUag+NWRs=
X-Google-Smtp-Source: AGHT+IElggfWytvhCoj21mhQHVopwI4m/+9lXItL5pDNuALaKGqOA1ntppDbknBOlpcYcRPkYJEiRhdsaagYuqP/iFSIg5LYcSS+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:3d4:3ab3:daf5 with SMTP id
 e9e14a558f8ab-3d4418dcc7amr5367595ab.6.1741283282064; Thu, 06 Mar 2025
 09:48:02 -0800 (PST)
Date: Thu, 06 Mar 2025 09:48:02 -0800
In-Reply-To: <1EE34FAC-7796-4D28-AA51-1A85E3489DDD@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c9dfd2.050a0220.15b4b9.0042.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in validate_bset_keys
From: syzbot <syzbot+3cb3d9e8c3f197754825@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __bch2_btree_node_write

bucket 0:127 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
 done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay...
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_io.c:2079!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 8204 Comm: syz.0.85 Not tainted 6.14.0-rc5-syzkaller-g14d05f12084d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __bch2_btree_node_write+0x3514/0x3660 fs/bcachefs/btree_io.c:2079
lr : __bch2_btree_node_write+0x3514/0x3660 fs/bcachefs/btree_io.c:2079
sp : ffff80009bd66420
x29: ffff80009bd666f0 x28: dfff800000000000 x27: 0000000000000003
x26: ffff80009bd66540 x25: 0000000000007c00 x24: 0000000000000863
x23: ffff0000d5a930b8 x22: ffff0000d5a930b8 x21: ffff0000eb480000
x20: 0000000000000001 x19: 0000000000000001 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008b729288 x15: 0000000000000001
x14: 1ffff000137accd2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7000137accd3 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000da4f9e80 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000829b0b3c
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __bch2_btree_node_write+0x3514/0x3660 fs/bcachefs/btree_io.c:2079 (P)
 bch2_btree_node_write_trans+0x9c/0x650 fs/bcachefs/btree_io.c:2360
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 __btree_node_flush+0x254/0x2e8 fs/bcachefs/btree_trans_commit.c:252
 bch2_btree_node_flush0+0x38/0x50 fs/bcachefs/btree_trans_commit.c:261
 journal_flush_pins+0x6f4/0xc98 fs/bcachefs/journal_reclaim.c:589
 journal_flush_pins_or_still_flushing fs/bcachefs/journal_reclaim.c:861 [inline]
 journal_flush_done+0xe8/0x6ac fs/bcachefs/journal_reclaim.c:879
 bch2_journal_flush_pins+0xf4/0x348 fs/bcachefs/journal_reclaim.c:911
 bch2_journal_flush_all_pins fs/bcachefs/journal_reclaim.h:76 [inline]
 bch2_journal_replay+0x1c28/0x1f64 fs/bcachefs/recovery.c:442
 bch2_run_recovery_pass+0xe4/0x1d4 fs/bcachefs/recovery_passes.c:226
 bch2_run_recovery_passes+0x260/0x92c fs/bcachefs/recovery_passes.c:291
 bch2_fs_recovery+0x20e0/0x32ec fs/bcachefs/recovery.c:936
 bch2_fs_start+0x32c/0x570 fs/bcachefs/super.c:1041
 bch2_fs_get_tree+0xa50/0x11d4 fs/bcachefs/fs.c:2203
 vfs_get_tree+0x90/0x28c fs/super.c:1814
 do_new_mount+0x278/0x900 fs/namespace.c:3560
 path_mount+0x590/0xe04 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount fs/namespace.c:4088 [inline]
 __arm64_sys_mount+0x4f4/0x5d0 fs/namespace.c:4088
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: d4210000 9773b6fe d4210000 9773b6fc (d4210000) 
---[ end trace 0000000000000000 ]---


Tested on:

commit:         14d05f12 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12e78a64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afb3000d0159783f
dashboard link: https://syzkaller.appspot.com/bug?extid=3cb3d9e8c3f197754825
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1236ca54580000


