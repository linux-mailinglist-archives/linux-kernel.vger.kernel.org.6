Return-Path: <linux-kernel+bounces-358927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF36998565
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1A5281B59
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B01C3306;
	Thu, 10 Oct 2024 11:57:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAD1A0737
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561452; cv=none; b=VF4mw1/1HZA8TFc8J0BA8MJhFAxicCV3oIXaBpxdavv7kd6HUXFMQaqTdizKM1Od5PeKUaB2WTTkyunwcvMZhPBvUygVPDLwefjJpU3mMZi/8gVbEEMn7+gGFQGW/9oTrgdAhYZGT4OVifSF/Mflde0tk1164TMrqfEG0Ei8/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561452; c=relaxed/simple;
	bh=A5+ejR8hMt45d9AY0q6Xcf92ImwEi+/HezPrR5DMwOY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nobNQ9lqU0IqGCaJ6OgO4rnJuQuqb6TyHaaFe/KFEN38UPIwpEegD0G1rIddzPcUhoGakZhSvBoABBLy9DRLAOAXAuFfWxkp0fTaWIdRHf8r0GpNLWVQmvEAN/aOZVtgystLrHXYz4EUL4DvN8z07W/3d6zecDDvhLaHhAY9XGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3972c435dso8940895ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728561450; x=1729166250;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7BVJPzn00GP8MlvjyIVBuV6OLbqf66PANXGmxIHvu8=;
        b=iukKnnu1GOR85sypGdiiYUojr2eecAwhfqMiSHhEIbSfCdzM9zNn/E9w/BVFKxM0OV
         uIay+nT64YdM1mTsOneIRIlmC6yrfStcyUM9gSyxGOUmsUq5KfRQ19xGkHCzP3BE4tUp
         7Gfk8DzXoMnAbRe7kZ4aFPxtcxZEwKq4Lb7XUQKIf4UhtjEUlDbXbxdS36wyqbr2Tvm6
         Av6e/mf6hBp/i5Dpr8kQCo/DzXoUzJ7FzU7MYIRha33n7uvBXoBvCahIuW9qP04v8qvE
         yIQJ+rBM/WMOf4Uy7Mua8UpBtfb/ES0l7BSurfN73N84vnzMODIZqNI0r5hwpITCj8Me
         8Lrg==
X-Forwarded-Encrypted: i=1; AJvYcCUznsT2S/dkKb79nrCCvbBkalS77BvWhr1SntY9rLTqhiw3Wtj6jDqPuQT6064TunxtW4V3wnStRb23y04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx287SVu4Cq0QGV7sp6xCxJKbLWbUzRQkiQEYbtCqxBx9T1GZXU
	1E6lwbWvG9KUYTXGKbfWNxR89Vnvaw1bcabjZ6yFyMJVJryvG+jEiMQoYN6EbjjBu+a6ftD0bfd
	JZ2FmuYOuK886nPelAbB/BxOQidRkJfayTsHp+veJI/6PZI5YcmoeC70=
X-Google-Smtp-Source: AGHT+IEQPcUNvrJLEU7d7xlJ0ZQq++hRsnZQ1POdFHrA5/4/IztvyioxlOWkApLGwBivdU2vRJ6Qydzvs9jABzdQlAmKxRQfFs21
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b745:0:b0:3a3:b256:f31f with SMTP id
 e9e14a558f8ab-3a3b256f33cmr7929745ab.19.1728561449731; Thu, 10 Oct 2024
 04:57:29 -0700 (PDT)
Date: Thu, 10 Oct 2024 04:57:29 -0700
In-Reply-To: <66feec23.050a0220.9ec68.0059.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707c129.050a0220.64b99.0017.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtInsertEntry
From: syzbot <syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d3d1556696c1 Merge tag 'mm-hotfixes-stable-2024-10-09-15-4..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1354cb27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=5f7f0caf9979e9d09ff8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f66fd0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ed005f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea459972f07f/disk-d3d15566.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8dcb9ab73d3/vmlinux-d3d15566.xz
kernel image: https://storage.googleapis.com/syzbot-assets/686f1b595c23/bzImage-d3d15566.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/73f0c7d76431/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:3624:7
index -1 is out of range for type 'struct dtslot[128]'
CPU: 0 UID: 0 PID: 5218 Comm: syz-executor135 Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 dtInsertEntry+0x1735/0x1780 fs/jfs/jfs_dtree.c:3624
 dtInsert+0xbc1/0x6c10 fs/jfs/jfs_dtree.c:893
 jfs_create+0x7ba/0xbb0 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3595 [inline]
 open_last_lookups fs/namei.c:3694 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3930
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2b371c0639
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff164f4418 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fff164f45f8 RCX: 00007f2b371c0639
RDX: 0000000000000000 RSI: 0000000000141042 RDI: 0000000020000000
RBP: 00007f2b37239610 R08: 0000000000005d93 R09: 0000000000000000
R10: 00007fff164f42e0 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff164f45e8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

