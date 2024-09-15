Return-Path: <linux-kernel+bounces-330092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D09799A0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 01:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4642835C2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 23:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE6B129E93;
	Sun, 15 Sep 2024 23:58:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC142BCF5
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726444708; cv=none; b=hyITg8qiKZgYyAYYKsFcI/2L8Shk/6KHeJKtgdg3BXQA7PDRMvaTuDK/Z4nq6vgUIQ2b9oNRAZxegNyWt7PSF7vQ5mvqcjlL3dQXTfJGXjcvAewb3M3Ovmdz3IiadSKOf/dcFPst/ZNCId0Wn7euScigAMGPiWFlTffi0goxgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726444708; c=relaxed/simple;
	bh=YT6W8xPPORdTQDKc+9s6VglfSmHQVltTpx+L7vxGzF4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ggmnvq3iVYQr0Fo1lt44hnEWeolsAw47HiJlZaoHi1BBgnuDfQQlPx34zMLd3UhhQVmUirGb69sLKdE7YidsucT7A/Q6iYxPUm6fOOc4q0bVV7xzndEeUXuoA9bypukPAedKbII2iouHEvpEncYBvd/btmJEzOgG5KbrZDptZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a093440d95so43526945ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 16:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726444706; x=1727049506;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzuOqO4wqEv+PtD0PaWI9Fw6/V+K3rI/dC13ElCW4XU=;
        b=Jx0dLcnvj+UJWatmNsYuRUZaBv2yR++xcbZqjjuoMTEiqESH/Z4SwqbXFERlTHwr1f
         J50ZgqdMbyksSzg3sDCsRYJtb//jDDKZznXKa9MFFY5wJc/w3yvU/nVxE0JHDvoYDqjx
         mm4K2MwsZuHPmWZyBOU4ds1sKFkObb20828gveejiqq3iGfsIrhdUuMlfQvG05/h5E5S
         sLOQEG2uwKfLeKOFxT1D+aMCX+mCnyfVkAEtKy2V4TkFYWmelo5TSEsGvlPVRVqM9fNL
         Refuz6Bw+AdTusyjHwxHJ0k5fjRV0OFAa0Zkw19HgpfouO1VKfEYh24Q1Zzik78Wrwwp
         TZEg==
X-Forwarded-Encrypted: i=1; AJvYcCWjrRL1+HpuTw8p0WA33A1mEv1c+kWS+7BDfLd4bPfhVoLpXaS64WwHbzzXP0CeIIuBLtOGjh3HlKbaFf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+QLafKBQUqi04CfWtzociJ87S0558pbd3+oDay/KAUKV4uy8A
	CEhuBFPTGNBQBl41KSi3HhSGfCvBa6fwj4dQKrSLfZYNuEPZpCPJjW3On6pBYK3PPrtP911E7j5
	nzAvJxiJh0sUo6zY+pRkBdFhkGeUdcCdr5IYwSPC78T8h8dk/S1Wxsns=
X-Google-Smtp-Source: AGHT+IE50g+BqsF8wZ9q/VbWre86oQ6vYUZTw9ILbOLxq3XUOBStl7kwSwXSahjF1sH7Vr0lIniSHSbuHSEATN9U9U39C3LG9lkg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:3a0:9fc6:5437 with SMTP id
 e9e14a558f8ab-3a09fc656cfmr18347855ab.18.1726444705949; Sun, 15 Sep 2024
 16:58:25 -0700 (PDT)
Date: Sun, 15 Sep 2024 16:58:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c3f660622313b3c@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in jfs_statfs (2)
From: syzbot <syzbot+bb0aa125eb8d70475ebd@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15105807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=bb0aa125eb8d70475ebd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/06208dec0174/disk-7c6a3a65.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd09f189e9df/vmlinux-7c6a3a65.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25e56ca1462d/bzImage-7c6a3a65.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb0aa125eb8d70475ebd@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/super.c:140:14
shift exponent 770 is too large for 64-bit type 's64' (aka 'long long')
CPU: 0 UID: 0 PID: 8224 Comm: syz.2.276 Not tainted 6.11.0-rc7-syzkaller-00021-g7c6a3a65ace7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 jfs_statfs+0x503/0x510 fs/jfs/super.c:140
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x13b/0x2c0 fs/statfs.c:90
 ovl_check_namelen fs/overlayfs/super.c:375 [inline]
 ovl_lower_dir fs/overlayfs/super.c:391 [inline]
 ovl_get_lowerstack fs/overlayfs/super.c:1132 [inline]
 ovl_fill_super+0x8ed/0x3560 fs/overlayfs/super.c:1392
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0xb7/0x140 fs/super.c:1299
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f54f4d7def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f54f5b25038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f54f4f35f80 RCX: 00007f54f4d7def9
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 0000000000000000
RBP: 00007f54f4df0b76 R08: 00000000200001c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f54f4f35f80 R15: 00007fff0587cfb8
 </TASK>
---[ end trace ]---


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

