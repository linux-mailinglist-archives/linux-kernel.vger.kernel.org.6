Return-Path: <linux-kernel+bounces-397598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AA19BDDD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C53B23825
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7099419046E;
	Wed,  6 Nov 2024 03:57:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CB24B26
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865427; cv=none; b=sQHOSEO2DQhtZNafKIO5kit39SM80crqWtqi9NDh1m8VUAVD09/l9rOVn4zGCDFKq9EU+XBYyEA40I5T8jhXRC3siUbplojUMakGAk8BLj3iK2DCmpeExeieIvKJlWCUiHFV+P6zPtM/ziGE6I6ApsQcAYxMRrDyz3aVRupkV1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865427; c=relaxed/simple;
	bh=oj83BaBI2W/r+TShi/B5/JFFcIoNqkPdcP66U8eMhik=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fOJxXHpRrla7JazwD2Qx+WepPIeStmhE6NmDy7vLD4oAExNl8QEtB6+0km1hRIzHp9KA5gjExijhm9sQkY5sgio0bwiRlsK5tyVpuxOIfTF1N+l+sl1K+cLSd6b7EH8Uzz/2rDpqXUVRxYxCMkNLaBbE6KoI0fq1Pb2XpdaVTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b2aee1a3so68653215ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 19:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730865425; x=1731470225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDPOxyqp9NxDCammuw+iyPXC5CP5joSuI9EWZ4GzeUg=;
        b=GwAVhvYrzCettMxIuaTl8zY6zG6Ag6PSgIzzxxDqmXl2GputFy1tUR/YzuRX6GxV4/
         a1Pkbw+4X4astL4rtiOAfvD2TqKJzp3vIbC0+wUa84zM3xU2VxKvIVxnnJtKeuA9lj6G
         fDcJ1wd9ctAW0D1UO2PDW/LZY0oVGkrQ1PhT94gZcug44xkiJXwTE78LV7J8vAEV4qDw
         8xIgm+lpssO9MZXV35Q6KDo5QjuQ6APaEHbB7HYQwg6YKZiSqsyneVGhMkyz8euVnsfn
         XEHZROF+MiiNcXqSy2lMNnCXi6oGBMyfRiCfRGyV8ncBVea1lCVYju7wu5Od9/yhDOvt
         hy+w==
X-Gm-Message-State: AOJu0Yy5UtYf9bHuzX1kHCxbGCQA5L8iswcDZvFN4Cj91/PXa9LJl0Z7
	+et2d1WEHb9rTyYqIh5OK1wAbOpiCIkx5UpNwSSTW9v1aEt1p5wl8TZ71Lc4d/ay81iV2ipswWC
	leLxCqnZsijNoPQTXTaUUJVu+tGV3buB0UfPlLw9mC/1VFJwiU+uHRDg=
X-Google-Smtp-Source: AGHT+IEOUGgoXAwVysWK4aoqVPmv0LmSSDcScYpUXDoEusloZea7107q+6h0Wunhnx4U9+dMgbcqypmCEKHtRA3GHREuELTJxMDz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cc:b0:3a6:b5b9:3e51 with SMTP id
 e9e14a558f8ab-3a6b5b9415dmr157478585ab.8.1730865424817; Tue, 05 Nov 2024
 19:57:04 -0800 (PST)
Date: Tue, 05 Nov 2024 19:57:04 -0800
In-Reply-To: <CAN=OONw=P_=3i7RSj67ZqW++8wcrmzuE-oN_fwjS7aR1t_B94g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ae910.050a0220.2edce.151b.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sarvesh20123@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __hfs_ext_cache_extent

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:163 [inline]
BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x779/0x7e0 fs/hfs/extent.c:179
 __hfs_ext_read_extent fs/hfs/extent.c:163 [inline]
 __hfs_ext_cache_extent+0x779/0x7e0 fs/hfs/extent.c:179
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_get_block+0x733/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
 notify_change+0x1a8e/0x1b80 fs/attr.c:503
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
 x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:77
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable fd.i created at:
 hfs_ext_read_extent fs/hfs/extent.c:193 [inline]
 hfs_get_block+0x295/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121

CPU: 0 UID: 0 PID: 6068 Comm: syz.0.15 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10194e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8a4f4c5365f96b
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129d9d5f980000


