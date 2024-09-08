Return-Path: <linux-kernel+bounces-320036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DA3970549
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE83B21788
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05994D8CE;
	Sun,  8 Sep 2024 06:59:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E598817BA4
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725778744; cv=none; b=hQNcdo7jtJwYXN2Cr5VdZhdhwrPygoVgI34h0z14dWX1pgdkea/DoQp5mK/qlVKCZRMrA81fcUIR2ri3bMyqiFvSFyvdaynn+sfBPklO8uOufTJ9EW6HDNupYMvYEinwkUQa4D9FFxeQ+FMiC1zw+u/8VDblCTqkB6xwiv2fiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725778744; c=relaxed/simple;
	bh=eXkKctP4i/JY+sFuFxaG9LcxHxOTQE0gqM7icL5uxW4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BVTySlUlo7+uvgsXLrAHUKKtXxRp3BHwABRc+qpjg8c3gmgf6VRHqzdoRBpyKdnHgcKzFHDl4hGtPZvl47kltKRWFKZYOwB0NZz2MoY9bfDFezTLTvENGemCQay4eXsCSmuXoXDyqfUqB01my5/O58SGqzQyfvDd/FMLjXP6704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82b930cd6b2so140228539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 23:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725778742; x=1726383542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLbyLOm4pDURvbelREyUfi4i7B4L3RLqCgIrV10lApg=;
        b=mgrVFyAJQ/ERcBVOZ/FnhSG8ch6TaoHnI39T8TsOQrsmHF/zLsMNVhM+Ci7Svm4lJZ
         qXeNg57TuqslD5UN2sl7ggGaztaV9g60NIKTk144KdNJMBeAN84a05cWXFjszWGOFoiB
         UhRLJuLutWVxdAOw8spS2xSDgNgSyc1dqh+OzI23qkjXdY9UQQxhanl3Hh6sUfMza24n
         4mTQNnFbI/Aox23fD/dLfOn/VTc9QAwSIOU2Kn9kwTwls9W1yxIlNbqudDjrlDTaiVsC
         x8yr9clQN+0rnMvP2c0NNkQv42Ls44j6X/+YUk5mIpIVN8Zy/9/W6pvCwpTPGUP1+WWD
         kmHA==
X-Forwarded-Encrypted: i=1; AJvYcCXAVPxh4gijXLaSlXxoiCqjbiQqox2HX9LBtoW7CDU8tbqTDzSGk3UdGJEq8Ez5rdlQJEIAS0EE1m/lYEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVro6Nh+CiSoB+RmW0QaVfo7XZf83vgpDMeMECWidaRERlnh4
	H7yctD/yLt1LizUdfH6t/uwf956QknDlAttx5uZThy1RRBGU7wBGXnbaHBeMU/Mfs+vhbxkGbm0
	X+xrLOC+zOpiT0UmkxKYLPmIfEF2c9b3tPO2bAivtkRa7G/Zs1GhepHM=
X-Google-Smtp-Source: AGHT+IEuEArf0Y/a3NtJOgYkRaQzooug+GlFgDpq2K84udWIKTUS33Le4zwUF0C4vCC2mhaqiTnL6qGP+q4kb+jTzXedtc2vGKx0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c246:0:b0:37a:a9f0:f263 with SMTP id
 e9e14a558f8ab-3a04f0cce6cmr90016845ab.20.1725778742063; Sat, 07 Sep 2024
 23:59:02 -0700 (PDT)
Date: Sat, 07 Sep 2024 23:59:02 -0700
In-Reply-To: <20240908062701.7906-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1c7010621962c35@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KCSAN: data-race in ext4_fill_raw_inode / ext4_orphan_del

==================================================================
BUG: KCSAN: data-race in ext4_fill_raw_inode / ext4_orphan_del

write to 0xffff88810fc69b6c of 4 bytes by task 3364 on cpu 0:
 ext4_orphan_del+0x54d/0x6e0 fs/ext4/orphan.c:296
 ext4_evict_inode+0xac3/0xdc0 fs/ext4/inode.c:289
 evict+0x2d7/0x560 fs/inode.c:704
 iput_final fs/inode.c:1838 [inline]
 iput+0x432/0x5c0 fs/inode.c:1864
 d_delete_notify include/linux/fsnotify.h:332 [inline]
 vfs_rmdir+0x29f/0x320 fs/namei.c:4306
 do_rmdir+0x194/0x320 fs/namei.c:4352
 __do_sys_unlinkat fs/namei.c:4528 [inline]
 __se_sys_unlinkat fs/namei.c:4522 [inline]
 __x64_sys_unlinkat+0xa2/0xb0 fs/namei.c:4522
 x64_sys_call+0x25fd/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:264
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff88810fc69b6c of 4 bytes by task 3413 on cpu 1:
 ext4_fill_raw_inode+0x64b/0xe80 fs/ext4/inode.c:4348
 ext4_do_update_inode fs/ext4/inode.c:5151 [inline]
 ext4_mark_iloc_dirty+0x2e9/0xe10 fs/ext4/inode.c:5781
 __ext4_mark_inode_dirty+0x314/0x440 fs/ext4/inode.c:5985
 ext4_dirty_inode+0x91/0xb0 fs/ext4/inode.c:6014
 __mark_inode_dirty+0x16d/0x7d0 fs/fs-writeback.c:2486
 mark_inode_dirty_sync include/linux/fs.h:2437 [inline]
 dquot_free_space include/linux/quotaops.h:380 [inline]
 dquot_free_block include/linux/quotaops.h:390 [inline]
 ext4_mb_clear_bb fs/ext4/mballoc.c:6534 [inline]
 ext4_free_blocks+0xe8b/0x14b0 fs/ext4/mballoc.c:6653
 ext4_remove_blocks fs/ext4/extents.c:2521 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2686 [inline]
 ext4_ext_remove_space+0x16ba/0x2c80 fs/ext4/extents.c:2934
 ext4_ext_truncate+0xc4/0x150 fs/ext4/extents.c:4441
 ext4_truncate+0x773/0xb10 fs/ext4/inode.c:4218
 ext4_evict_inode+0x8b4/0xdc0 fs/ext4/inode.c:258
 evict+0x2d7/0x560 fs/inode.c:704
 iput_final fs/inode.c:1838 [inline]
 iput+0x432/0x5c0 fs/inode.c:1864
 d_delete_notify include/linux/fsnotify.h:332 [inline]
 vfs_rmdir+0x29f/0x320 fs/namei.c:4306
 do_rmdir+0x194/0x320 fs/namei.c:4352
 __do_sys_unlinkat fs/namei.c:4528 [inline]
 __se_sys_unlinkat fs/namei.c:4522 [inline]
 __x64_sys_unlinkat+0xa2/0xb0 fs/namei.c:4522
 x64_sys_call+0x25fd/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:264
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x0000079b -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 3413 Comm: syz-executor.5 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1400589f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81d40b0108ea8fe
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a50e00580000


