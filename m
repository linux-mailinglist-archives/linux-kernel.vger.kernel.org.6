Return-Path: <linux-kernel+bounces-573097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD491A6D303
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4921894C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8471339A4;
	Mon, 24 Mar 2025 02:23:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379C584FAD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742782987; cv=none; b=IBuBW0kf6J/YzCmmlqW4iL8U5qAM4qNzocIn1hOz+M1QHG9IDr76iHQrTVTYl1npnYv+9Zn3bLdIzUMZH24oeMMmiKeZ6XnrQUbLjcYg/5bXmvpgVT0Rye4erv3W0QO4JYlgQRkgqAQSxG2i5LKbvK0w6MVrILbIS8DKQZhkIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742782987; c=relaxed/simple;
	bh=+e5ffWsoJaBNl4TqcP2TPhMnuCc9KE+HiMolKSFB1Cg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NZCKZe3MTd2+7HzTtQesjGzuaEEf8PiLzTVgs+2UGri4zKNBkS5zdoIzGIjXEHbphskdcLZCPgE0ybPBJ3m8C2Ht5Rg+kCtJ80ZtcTCHbVC4DHhrQsSEnH0l5JxRxA1Mo9GTguAXLVx1FTqIkk1pppDk+9Efo1JbUfr5eA87tcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b418faf73so920248839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742782985; x=1743387785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi5ySRgdQ/KxJgbcKLB5tqrU5XZ/08vGTpnyucIbSM0=;
        b=fM3mSnjfTBiz1p5++V4inP+SGSaJH7mLg+MbgLmNBNxQHx9CnpNhjNgG6w/1Zsfe7p
         8MQKuCReHch+d5pp3fbWmrQ+4S03BSp0yNOQGFelK2DCHnVQlvkAidFjxJ/5qwCBh2t0
         FQpvFN5ig7cYyHJgCGgsuqImu5v+BPERXtzWPZct8/SWgbOiEkA9Yb3EuGSDCDcPeQ+C
         YkRAV93TBJi/ol1HL5XXowt9XVxmIbVq3A1Vdvb15YEEIO/28iI+umWdz0KQOOKG/o8A
         B+KCrvhExWkBYYONsDFD2ZoiipIs3PVVg6PA303Qj0+nWXQl/iOW8k4ircvt3ZMAvWdp
         YGZw==
X-Gm-Message-State: AOJu0YyTUCZhm3m6Jcj0FcvBNrnQu3BRENjKRz3xVviXNJyMxQySHqlC
	QXJhCVcSI0vUhTURcCn+hdx8b86LrK4/cKN46XTLMuLEvc+rQgRwsFRx7+jABYtUhEPsLbkAyWb
	9G7tZkRKc+xDYJFF9rtXhDesUL30FNsUtYNJHBJqVjwxpI/En6ajoI98=
X-Google-Smtp-Source: AGHT+IG/IFeUaYJV9AEQfw9cPnmJhz1ZuRlTzrivPYH5Oad5lW+P7Aj5g0H+N9yX96okV3Z6l7NRsh/lkUDizSMLno1gBSKJnSgz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:3d3:dfa2:4642 with SMTP id
 e9e14a558f8ab-3d59611b1famr89894995ab.13.1742782985182; Sun, 23 Mar 2025
 19:23:05 -0700 (PDT)
Date: Sun, 23 Mar 2025 19:23:05 -0700
In-Reply-To: <20250324013855.2122966-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e0c209.050a0220.a7ebc.000a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
From: syzbot <syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in _find_next_bit

(syz.0.16,6650,0):ocfs2_block_check_validate:402 ERROR: CRC32 failed: stored: 0xb3775c19, computed 0x2dd1c265. Applying ECC.
JBD2: Ignoring recovery information on journal
ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
=====================================================
BUG: KMSAN: uninit-value in _find_next_bit+0x11c/0x130 lib/find_bit.c:145
 _find_next_bit+0x11c/0x130 lib/find_bit.c:145
 find_next_bit include/linux/find.h:69 [inline]
 ocfs2_add_recovery_chunk fs/ocfs2/quota_local.c:313 [inline]
 ocfs2_recovery_load_quota+0x68e/0x1350 fs/ocfs2/quota_local.c:362
 ocfs2_local_read_info+0x139e/0x2c10 fs/ocfs2/quota_local.c:755
 dquot_load_quota_sb+0xa35/0xdc0 fs/quota/dquot.c:2459
 dquot_load_quota_inode+0x662/0x9f0 fs/quota/dquot.c:2496
 ocfs2_enable_quotas+0x1d4/0x6e0 fs/ocfs2/super.c:930
 ocfs2_fill_super+0xa6b7/0xb550 fs/ocfs2/super.c:1140
 get_tree_bdev_flags+0x6ec/0x910 fs/super.c:1636
 get_tree_bdev+0x37/0x50 fs/super.c:1659
 ocfs2_get_tree+0x34/0x40 fs/ocfs2/super.c:1184
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3560
 path_mount+0x742/0x1f10 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x71f/0x800 fs/namespace.c:4088
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4088
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __do_kmalloc_node mm/slub.c:4293 [inline]
 __kmalloc_noprof+0x923/0x1230 mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 ocfs2_add_recovery_chunk fs/ocfs2/quota_local.c:305 [inline]
 ocfs2_recovery_load_quota+0x404/0x1350 fs/ocfs2/quota_local.c:362
 ocfs2_local_read_info+0x139e/0x2c10 fs/ocfs2/quota_local.c:755
 dquot_load_quota_sb+0xa35/0xdc0 fs/quota/dquot.c:2459
 dquot_load_quota_inode+0x662/0x9f0 fs/quota/dquot.c:2496
 ocfs2_enable_quotas+0x1d4/0x6e0 fs/ocfs2/super.c:930
 ocfs2_fill_super+0xa6b7/0xb550 fs/ocfs2/super.c:1140
 get_tree_bdev_flags+0x6ec/0x910 fs/super.c:1636
 get_tree_bdev+0x37/0x50 fs/super.c:1659
 ocfs2_get_tree+0x34/0x40 fs/ocfs2/super.c:1184
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3560
 path_mount+0x742/0x1f10 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x71f/0x800 fs/namespace.c:4088
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4088
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6650 Comm: syz.0.16 Not tainted 6.14.0-rc7-syzkaller-00205-g586de92313fc-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
=====================================================


Tested on:

commit:         586de923 Merge tag 'i2c-for-6.14-rc8' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157bfe98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d4644c4063c5098
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea0b96c4ddb49fd1a70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1613fe98580000


