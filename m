Return-Path: <linux-kernel+bounces-334747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D351597DB9A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 06:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2388BB218CE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 04:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D8222331;
	Sat, 21 Sep 2024 04:07:22 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32344208D0
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726891641; cv=none; b=kYdzzKeAujBe2xB6pV9QqInvR4EKUqOGsAqVx/ANVnNmbLiqAy5icrFs0vSSt0K7Ad+UOCIxREnvR5F848388jyE4KXDC1VuwrDi2AjFjpjHuWXL2Yl1PTM7eoMh2dtXxF9JSz+lV53OATMnEw3WSOdthAcGqaKJi+GrVpobZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726891641; c=relaxed/simple;
	bh=VFvOmUySZZIcdyA1DakRRVjey24WAgi+hZXh7DxvdEc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f80hXIan3BMm/eFDwmS7l+2tGIAWdIcwyVxiU6wZw5+On4wxkmX7tgoNvfm+6nZSn6m+JQoEuDG52clgVLcUYx4H/XwwozSuAK0I1baLePng2wwr3UycPyoEq+hJGGG2bmVcBA+OSxfL3EyB3SMB7D+q/xt+Af6xQCF7FT4GwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f53b1932aso33825705ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 21:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726891639; x=1727496439;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZyQv0qbFTPikDnecwxXC+O2lerTNeJjpgnb1XX0/fw=;
        b=c4KuDvwzUjBY707QgcM2B43eyDaOmGaQPzUKGPIUFRqQCl6TtRglfYvFjyjKd59nzE
         +jaVLd+8/f4P/bpX/4ilIiUZs9VpZUdNln/bxuA76qHRgP/9qkGzYd68SHONMQFEvAZF
         wHh4WfeIZbnEaygkcL6wQ1+d945okQae+FJzI5M0jvdeJo6HxzIVxwn2VAVQC29D/pql
         8wHulATDO7Vm5Im7kfVqMjzL9SiYZClx8wsLxsd+FcndUdtP7qFPbPOgalAkgqO+d1wv
         4bjGgBkiiViPgSc3lpwWf5ZSAx5iGEJilmhRC0IJJUrV7+EdJ5qi2otBo4dquDu4SPuj
         p+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXnqOaZ+2xIuq8qoQ682PyXFpL9cNZDA38xQfApuu1+7C6a6xsc/22VIki+m9+Ar+3U7aZPL38/D+wxkNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBevRLQlKVTm20ut0tmEXWOskwPB7uBJQcapc8HzuH6eOd0ffV
	i5R+uxqC5x4uKDQBpw4OY/exksgLBqer8VyB3X3H6PD0w+g4k0cD+Hlj/21zFYvL2G/4Ti50ZRb
	5Y+mcdzMVA9IJKvxUn+kung7vpyWMVReQH7bI1SlValkNGfqJ13b46KY=
X-Google-Smtp-Source: AGHT+IGagEIbUYS/f7DaoR1Nmc3vTRJc9NH3Fxg4o8jW3sMbO5Ea0a8swYel3t3i29Xazx//m8sNEIOwC3paOecwtQF/34bDOhBS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:3a0:4de2:3257 with SMTP id
 e9e14a558f8ab-3a0c8d28fcdmr41963305ab.18.1726891639107; Fri, 20 Sep 2024
 21:07:19 -0700 (PDT)
Date: Fri, 20 Sep 2024 21:07:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee4677.050a0220.3195df.002a.GAE@google.com>
Subject: [syzbot] [f2fs?] WARNING: locking bug in f2fs_getxattr (2)
From: syzbot <syzbot+44090b62afaabafe828a@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13c8e200580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=44090b62afaabafe828a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44090b62afaabafe828a@syzkaller.appspotmail.com

F2FS-fs (loop1): invalid namelen(0), ino:0, run fsck to fix.
------------[ cut here ]------------
Looking for class "c->lock" with key init_kmem_cache_cpus.__key, but found a different class "&c->lock" with the same key
WARNING: CPU: 1 PID: 6409 at kernel/locking/lockdep.c:934 look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:931
Modules linked in:
CPU: 1 UID: 0 PID: 6409 Comm: syz-executor Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:931
lr : look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:931
sp : ffff80009d476c80
x29: ffff80009d476c80 x28: dfff800000000000 x27: 0000000000000000
x26: ffff800097041700 x25: ffff800097041000 x24: 0000000000000001
x23: 0000000000000000 x22: 1ffff00011eae0b1 x21: ffff8000970a13b0
x20: fffffdffbf769c10 x19: ffff800092b14580 x18: 0000000000000008
x17: 2c79656b5f5f2e73 x16: ffff800083032784 x15: 0000000000000001
x14: 1fffe000366d7a5a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : b8f830333a1c6900
x8 : b8f830333a1c6900 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009d4763d8 x4 : ffff80008f65b620 x3 : ffff8000806051a0
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:931
 register_lock_class+0x8c/0x6ac kernel/locking/lockdep.c:1283
 __lock_acquire+0x18c/0x779c kernel/locking/lockdep.c:5019
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
 local_lock_acquire+0x3c/0x98 include/linux/local_lock_internal.h:29
 ___slab_alloc+0xcbc/0xf38 mm/slub.c:3776
 __slab_alloc+0x74/0xd0 mm/slub.c:3817
 __slab_alloc_node mm/slub.c:3870 [inline]
 slab_alloc_node mm/slub.c:4029 [inline]
 kmem_cache_alloc_noprof+0x26c/0x350 mm/slub.c:4048
 f2fs_kmem_cache_alloc fs/f2fs/f2fs.h:2835 [inline]
 xattr_alloc fs/f2fs/xattr.c:30 [inline]
 lookup_all_xattrs fs/f2fs/xattr.c:333 [inline]
 f2fs_getxattr+0x3b4/0x111c fs/f2fs/xattr.c:533
 f2fs_xattr_generic_get+0x130/0x174 fs/f2fs/xattr.c:63
 __vfs_getxattr+0x394/0x3c0 fs/xattr.c:423
 smk_fetch+0xc8/0x150 security/smack/smack_lsm.c:306
 smack_d_instantiate+0x594/0x880 security/smack/smack_lsm.c:3613
 security_d_instantiate+0x98/0xf0 security/security.c:3942
 d_splice_alias+0x70/0x310 fs/dcache.c:2987
 f2fs_lookup+0x270/0xaf4 fs/f2fs/namei.c:591
 __lookup_slow+0x250/0x374 fs/namei.c:1718
 lookup_slow+0x60/0x84 fs/namei.c:1735
 walk_component+0x280/0x36c fs/namei.c:2039
 lookup_last fs/namei.c:2542 [inline]
 path_lookupat+0x13c/0x3d0 fs/namei.c:2566
 filename_lookup+0x1d4/0x4e0 fs/namei.c:2595
 user_path_at+0x50/0x74 fs/namei.c:3002
 ksys_umount fs/namespace.c:2033 [inline]
 __do_sys_umount fs/namespace.c:2041 [inline]
 __se_sys_umount fs/namespace.c:2039 [inline]
 __arm64_sys_umount+0xf4/0x178 fs/namespace.c:2039
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 261568
hardirqs last  enabled at (261567): [<ffff8000809d8e84>] seqcount_lockdep_reader_access+0x6c/0xd4 include/linux/seqlock.h:74
hardirqs last disabled at (261568): [<ffff8000809ef7cc>] ___slab_alloc+0xc90/0xf38 mm/slub.c:3776
softirqs last  enabled at (261538): [<ffff8000800307f8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (261536): [<ffff8000800307c4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

