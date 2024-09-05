Return-Path: <linux-kernel+bounces-316183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA2496CC4A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E2F1F27E51
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A3BE4A;
	Thu,  5 Sep 2024 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rST3eLeR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F52564
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499886; cv=none; b=ayqQCc+EL0JWHJi3PF7bJ4r9520x9LivSUaOH5KPjiOJD5FzNVh29u5Vx3Ouvjm/4XmRlpukTu96qqm9z/fidJmBfIYZHCBXKI8gGa2f7mbDjHRjeKB3LM2ZZvUJ2JHs4CFN3ANSXwNx29KePr5T1ALrGoXoJ4hpMFoWExlKK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499886; c=relaxed/simple;
	bh=Ph/6qaJzU/+WIbwmHZbnkqbtumQLhKkN93l0OQ/Xlq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cBMIcrqHrPj8LNL8BGNK/vnDfyawib66P/B+s2OJgG2Dz5y0RDtwAt8EiqImD4/s/q7M9tH31kxUbwbemW6Vnn+gcTjOTcLhSZsPvVQHbhvptgnS4hrGIEemBwj2X4jzUbiwsXFg6Jc5OgrAvcmC4/b1CkcUs7zRI8q8q2t55Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rST3eLeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FEAC4CEC2;
	Thu,  5 Sep 2024 01:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725499886;
	bh=Ph/6qaJzU/+WIbwmHZbnkqbtumQLhKkN93l0OQ/Xlq8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rST3eLeRijya2kYTWzqTAjwtwWxURZla45Rdglh9sw1hBvVkGfAF22P8JG2CMfNcs
	 vQYDdohf7fP7pCgYo3j4jxAroYwQTw211wB0XDNq05Skh6xZoTVeC9E4o1Jb6FJ/iT
	 m39LwQlhEAX58uayJjEguzQENgybgZc76/1/d+FE2/PaYXhQAwm1ovrAXGHhor06UR
	 SeF/AoRDSPZL75zu5KU3Ong/TWJtLsW/1uhkn8OiRrg8EN6LTXKRR+7zvcHnTfb7PH
	 kvQn9Sv9IRfg/dZ2iGVBzrZ+9/SE8VzCI0J+fkcOVk5rje1jaYxezrAGwda63KPtvR
	 WRUQHCt+QN2zA==
Message-ID: <41db7268-7a58-4989-b7f0-3b03f31acdfd@kernel.org>
Date: Thu, 5 Sep 2024 09:31:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] WARNING: lock held when returning to
 user space in f2fs_commit_atomic_write
To: syzbot <syzbot+78ff2855f26377625419@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ebae95061f96be85@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <000000000000ebae95061f96be85@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz invalid

Becuase commit "f2fs: atomic: fix to not allow GC to pollute atomic_file" has
been dropped from linux-next git repo.

On 2024/8/14 4:49, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9e6869691724 Add linux-next specific files for 20240812
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=177ea68d980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
> dashboard link: https://syzkaller.appspot.com/bug?extid=78ff2855f26377625419
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13deecd5980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c1fdd9980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/disk-9e686969.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinux-9e686969.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/bzImage-9e686969.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/a0c7f05fa485/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 7566a155c666dd23b413a002a50cd9ae7b95f053
> Author: Chao Yu <chao@kernel.org>
> Date:   Tue Jun 25 03:13:49 2024 +0000
> 
>      f2fs: atomic: fix to not allow GC to pollute atomic_file
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1255068d980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1155068d980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1655068d980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com
> Fixes: 7566a155c666 ("f2fs: atomic: fix to not allow GC to pollute atomic_file")
> 
> F2FS-fs (loop0): Found nat_bits in checkpoint
> F2FS-fs (loop0): Try to recover 1th superblock, ret: 0
> F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
> syz-executor306: attempt to access beyond end of device
> loop0: rw=2049, sector=45096, nr_sectors = 64 limit=40427
> ================================================
> WARNING: lock held when returning to user space!
> 6.11.0-rc3-next-20240812-syzkaller #0 Not tainted
> ------------------------------------------------
> syz-executor306/5229 is leaving the kernel with locks still held!
> 1 lock held by syz-executor306/5229:
>   #0: ffff8880473a18b0 (&fi->i_gc_rwsem[WRITE]){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2196 [inline]
>   #0: ffff8880473a18b0 (&fi->i_gc_rwsem[WRITE]){+.+.}-{3:3}, at: f2fs_commit_atomic_write+0x105/0x1510 fs/f2fs/segment.c:388
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


