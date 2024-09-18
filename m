Return-Path: <linux-kernel+bounces-332253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169A97B748
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC20D282705
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59913A3F2;
	Wed, 18 Sep 2024 04:58:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39322B2D7
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 04:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726635484; cv=none; b=NYKOuJFWFxaEQ+v+2pfwD3477oZpVtPppdEdHkc84zYsva8dPar5sv8dpGNnrWsWFK9L7K/yow74xcT4lEffcAeJNV3oy2MrUbh6XHx8xmldB4yYH/Qx5cKsUNy0xgFuk9rDgm9eGjfpCpdJhgg7C6/qx45gB+hYbqAeCceXinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726635484; c=relaxed/simple;
	bh=OYOva2N2oEy3+7ofy6L2tWpAhUcQfY8GQGjqNOEvRrM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h22fe496EWZkFXBliQGo9Aepm0cFq8IWKxsIbWawtMFrLtkiygiQYRTh9MrmeI3k01aGlxfyCWeH/pxhpp2Il4cQ6VQbm/oq4wGD8yIUw4xip3Opa8fdh9iDvFmNXfv1l8AtZ4h4VmF7QIH3y/gOZebYKRSzHpKgYffyYEARsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a049f9738fso99160165ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 21:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726635482; x=1727240282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5iWlzom4+ZJTobOcv9G6iiHOTB3GkrwQjltrlVFqpw=;
        b=B4yP3w5ALjmqGFgflzEghVch3JqlQjqennYG5hjMPu7Y3wZRXmHEPduG1oH+AwmyKd
         hq8fIZvxVDf5Pu/Ffh0EQWv6FK5cIaFjM819Y5sU4r3/ve7z4SQ8HMSDIFcEU7q2Qon+
         mN9n/T4omnKMjZB08tX7zIz4Lw8nwOwtBqzc4PEeHp9ah6yf/uPkrsoPb+Ce9yCSoCqt
         RKDgMiJjWVo97dVtfdqFJFe/pfJWXhqWMmVClmbwu8hOlLZKy0USeLlhOfGAWPImnjTy
         k4TMT2229lG/9a6yvv7vrkPPBkN+azVRqFBol2jVpDR4Fkj5qqLX+x02he1ntDBqoqac
         UE5w==
X-Forwarded-Encrypted: i=1; AJvYcCXe3PrlNGIz91ZoLSBLYw3CuSila9mNEFW/XUWmaI1wsj9QQtaAearkphwFUNxqrIrjV4Rn0n3gp6TEV74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvkxE6xnrQGHX3F6dgUZ9te2IZjqQg85CbTv/JD2biSiVE9FAR
	wnjAb3ybxPqwVMvB56RHREAzuyyhQ6Iq4Lui2h5T5Lfvuy7F5LnhF9eqwcr3TW+BZ5RexIsXZV0
	qouOpssVtIvYsMd94SS7bm1AakKhmbBTlVsHTJ8grR8GqYoYak+8F+g0=
X-Google-Smtp-Source: AGHT+IFyHns1jOVJf05SgvMveag/B1Tj3i2O7BFIJTNydbcv6esbsFtrE+mCiFPWhDYu8IUVVW9vro7hxhDjNs5BdbB0Hdfef6+X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:3a0:90c7:f1b with SMTP id
 e9e14a558f8ab-3a090c7116bmr121456945ab.12.1726635481834; Tue, 17 Sep 2024
 21:58:01 -0700 (PDT)
Date: Tue, 17 Sep 2024 21:58:01 -0700
In-Reply-To: <20240918040359.189212-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d509306225da626@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KCSAN: data-race in ext4_free_inodes_count / ext4_free_inodes_set

==================================================================
BUG: KCSAN: data-race in ext4_free_inodes_count / ext4_free_inodes_set

write to 0xffff88810404300e of 2 bytes by task 6254 on cpu 1:
 ext4_free_inodes_set+0x1f/0x80 fs/ext4/super.c:405
 __ext4_new_inode+0x15ca/0x2200 fs/ext4/ialloc.c:1216
 ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
 vfs_symlink+0xca/0x1d0 fs/namei.c:4615
 do_symlinkat+0xe3/0x340 fs/namei.c:4641
 __do_sys_symlinkat fs/namei.c:4657 [inline]
 __se_sys_symlinkat fs/namei.c:4654 [inline]
 __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4654
 x64_sys_call+0x1dda/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:267
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff88810404300e of 2 bytes by task 6257 on cpu 0:
 ext4_free_inodes_count+0x1c/0x80 fs/ext4/super.c:349
 find_group_other fs/ext4/ialloc.c:594 [inline]
 __ext4_new_inode+0x6ec/0x2200 fs/ext4/ialloc.c:1017
 ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
 vfs_symlink+0xca/0x1d0 fs/namei.c:4615
 do_symlinkat+0xe3/0x340 fs/namei.c:4641
 __do_sys_symlinkat fs/namei.c:4657 [inline]
 __se_sys_symlinkat fs/namei.c:4654 [inline]
 __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4654
 x64_sys_call+0x1dda/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:267
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x185c -> 0x185b

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 6257 Comm: syz-executor.4 Not tainted 6.11.0-syzkaller-04557-g2f27fce67173-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


Tested on:

commit:         2f27fce6 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138f469f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dac6637d61966e53
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bc9207980000


