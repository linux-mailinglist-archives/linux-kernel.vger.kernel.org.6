Return-Path: <linux-kernel+bounces-316182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F268096CC46
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39C1288D11
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FBA946F;
	Thu,  5 Sep 2024 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rejBnJm5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2346B5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499797; cv=none; b=ozehiniQgnABWao4GqnCh1j5J5/nBLzVJ1wHDQIYpnk6fTQtVEQt146Fp5EDYdrom+6Jkcq1YyFGnIFFRxUqBZ0AZ/s/6VhxBO5t1rxyfB8EtdNpysH3PGlQ75pppExOvswAMnV7coyVQEcpHH7/ZJjQ6jFJn7F8/lzky0mrUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499797; c=relaxed/simple;
	bh=isoZFrkj3HFjQpOArSk4EpDG37UlOrHX9AepiwxVVE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VBCC5vuUYOjKFCzYkqEsdtVswI7sNNcOsZur6B7uTaWRJsa4LwA7GYUpmVPg6ApohXw1KNn2mIKnbxcRVyHX9aFCSDqLL+F3TTdiAa1Re9Am7zsTRzh3il6fXM/qhiPQNu0wZB6m8oWyVGvlygOGRgzqB0/EMTRNGuIrDjYYeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rejBnJm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA817C4CEC2;
	Thu,  5 Sep 2024 01:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725499797;
	bh=isoZFrkj3HFjQpOArSk4EpDG37UlOrHX9AepiwxVVE8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rejBnJm5VPnPwJixHXNKoh6ESVI3dl/HzrUTe8Qpcze1fFcmLmXE2pTwypYa3hf+C
	 z91RzTxUaRoxtnPnhE4YMpPPoPWDcaz5ttcHlpL9BUEeLkjEcB303uz/IYOcW36Nc6
	 cvSBsoj2JF6RIpOO/NDYAUdEdlmOFCl/WbaDEu2EXiFNSFcL8FqboOo8JbUN2mccmB
	 ZlDzoG3P8aEYF2cFdK4Jg2HyDreq07tyWyAifPNhsAuPcGWJCJ2klvHxxExuzaJa3h
	 DKVFugQWdT9nMZntK3uLq0IpxgWDwjoy7nZNGraxoKRfc/9YMUi4t/3+uc6JJytcGr
	 A/wpPaCdIt0Hw==
Message-ID: <d4106e72-8a88-42d4-9300-233751e239bb@kernel.org>
Date: Thu, 5 Sep 2024 09:29:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_ioc_start_atomic_write
To: syzbot <syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000007dfbdb061fa35855@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <0000000000007dfbdb061fa35855@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz fix: f2fs: atomic: fix to forbid dio in atomic_file

On 2024/8/14 19:51, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9e6869691724 Add linux-next specific files for 20240812
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1431e405980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
> dashboard link: https://syzkaller.appspot.com/bug?extid=733300ca0a9baca7e245
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120ed77d980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130e0ef3980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/disk-9e686969.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinux-9e686969.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/bzImage-9e686969.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/08b48c782593/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 374a8881ce4ccf787f5381a39f825cb17a3f6b14
> Author: Chao Yu <chao@kernel.org>
> Date:   Tue Jun 25 03:13:51 2024 +0000
> 
>      f2fs: atomic: fix to forbid dio in atomic_file
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10741429980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12741429980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14741429980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com
> Fixes: 374a8881ce4c ("f2fs: atomic: fix to forbid dio in atomic_file")
> 
> F2FS-fs (loop0): Found nat_bits in checkpoint
> F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
> syz-executor312: attempt to access beyond end of device
> loop0: rw=10241, sector=45096, nr_sectors = 8 limit=40427
> ================================================
> WARNING: lock held when returning to user space!
> 6.11.0-rc3-next-20240812-syzkaller #0 Not tainted
> ------------------------------------------------
> syz-executor312/5227 is leaving the kernel with locks still held!
> 1 lock held by syz-executor312/5227:
>   #0: ffff8880695aa0e0 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2196 [inline]
>   #0: ffff8880695aa0e0 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_ioc_start_atomic_write+0x2ed/0xac0 fs/f2fs/file.c:2163
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


