Return-Path: <linux-kernel+bounces-335327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0063297E425
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831EA1F2149C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8629978C7D;
	Sun, 22 Sep 2024 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Xo95JDKo"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A29433D6
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727046925; cv=none; b=Ge70V4kbwzxiTd+6dpdwOhuGxEHjHWxWvHqDQEtB5LoWcneZB6muE/bDjFDMadrn9MFKQdjcAmpjcc9XymYW5zSyrFUtbrpm+HJwfdqRPGRtu0Idncehzd1pG4YCVJeALR757bVkRuygbUAQnE/qEKzEor3u7dBVC0ruVkef51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727046925; c=relaxed/simple;
	bh=IOKFUjrmEw81LaaNRTH/ux2RuIwuKk4fePPJpmJ/xQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsxgUJZnDCp4azjZAAZLqQd7nDpNOJ0gXqkwmDiLtLIwhhB6WHpyP9Va01LXct9djfdZjPWaYwg0TGAC8mdC4JX9FFEf4ANXprWY71/nyyPtfPoXrLKtZxY9fXI01MecJ2AoeVOSE42pDaXzMyYpr1mS3xJNtrHkbNy1bcYE4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Xo95JDKo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so2654215b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 16:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727046923; x=1727651723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlsXTJCziqLDA1kEeYpppJidhLEUsbWQlazGKgEoouE=;
        b=Xo95JDKo5sA84jZJM63vo79qX7S8Rk0oOR2Kp7ITmtxDERy4+PqDyEl/hsPN+o2pvD
         2/RLK26ypWwNLId99pjzQ7/AN6W19NPpEA+ZC8WCnxaf2FnuOKpliByR4nL7zG6onaW0
         /08k7Oam45liXPawKT2ZwcSSWLye+uj7Q2zijLWm0TFGI6tpOIiFAo96siCVu9rt1wI3
         CQ5a7SbkcvMI3FjsjsCBfMHU7XLgNwO4Vox7gI87LPWYPK9H3tfP/KEtFHJpCPQpraZm
         UT8t7gZWwcIE7OHw33C4qahxqgCLAOo7sLVK8dR5xET9r4f3zGqFenxNvIjIygvWzxAN
         cZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727046923; x=1727651723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlsXTJCziqLDA1kEeYpppJidhLEUsbWQlazGKgEoouE=;
        b=AGp4CCJ6empLVTfdSYlJy2TX6dPMVpGRmhd1UAtrQXiDpX6io0D6jl6aOC1EZ0Hv2K
         snfeVvRPr8BSwf3oAV66pjNMNIxc0y3BJMGYiFg40nJn5susAknrgec5t4ZxW9Y2cgcZ
         kr5E2kBtGiV4jU/kdmRsgnq2qyhCyTkKrOgq5DmkV32IaagX1L07ON/FCAviWTb8xWIh
         u17moeISsmYiKFXz3of50j7aCZYSMut0BBNGrT/5dIR0RW3CxI0tVBWioc7KMTjtvLJH
         PANL5+E5eUQbi/O3YzTAngjez8wlKs9Hpcwfp2ckDezOe9SYX8P270SRPzPbF+4cC3du
         Oxpg==
X-Forwarded-Encrypted: i=1; AJvYcCXdObO2kYEapnO211BD88GxCvNeiuUizSxnmi6ralxlJZ2R8kAauprkeV3gnlkFYAMiE6ZZupoZoHNSvOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQyL8dadNS2DIl3ZfGqXFdvoDArNIL0CdPffypN33wrM3WQKs
	i1+P1nu1LotjFVvoCpZjHzXH3qvNYmPil9fpGgOnD/1bqt1/LopFUdvA5aWTfvsPzGU5DSexCv9
	M
X-Google-Smtp-Source: AGHT+IFLGsoYS4nkygjOYQ6T6MjfnuxG4sxP2bIE6luDvx3JVi00ybPnZU93vr6k1Rs5zWvJ3g1fxw==
X-Received: by 2002:a05:6a21:398a:b0:1d2:e807:7854 with SMTP id adf61e73a8af0-1d30ca2035emr11435044637.22.1727046922936;
        Sun, 22 Sep 2024 16:15:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b127sm12782575b3a.125.2024.09.22.16.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 16:15:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ssVnT-008k5e-0I;
	Mon, 23 Sep 2024 09:15:19 +1000
Date: Mon, 23 Sep 2024 09:15:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+bf0143df12877cb1a21b@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_ail_push_all_sync
Message-ID: <ZvClBwxeuRQKnM8S@dread.disaster.area>
References: <66eebc5f.050a0220.3195df.0053.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66eebc5f.050a0220.3195df.0053.GAE@google.com>

On Sat, Sep 21, 2024 at 05:30:23AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15569d00580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d9ab5893ec5191eb
> dashboard link: https://syzkaller.appspot.com/bug?extid=bf0143df12877cb1a21b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e6a77980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f8549392ace4/disk-a430d95c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9b866ef0c06c/vmlinux-a430d95c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9d6691641029/bzImage-a430d95c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/dd50a033ca89/mount_2.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bf0143df12877cb1a21b@syzkaller.appspotmail.com
> 
> INFO: task syz.0.75:6468 blocked for more than 143 seconds.
>       Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.75        state:D stack:24864 pid:6468  tgid:6446  ppid:6378   flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  xfs_ail_push_all_sync+0x236/0x310 fs/xfs/xfs_trans_ail.c:726
>  xfs_log_quiesce+0xdf/0x5b0 fs/xfs/xfs_log.c:1018
>  xfs_fs_freeze+0x8d/0x1a0 fs/xfs/xfs_super.c:936
>  freeze_super+0x81b/0xee0 fs/super.c:2107
>  fs_bdev_freeze+0x1ac/0x320 fs/super.c:1484
>  bdev_freeze+0xd6/0x220 block/bdev.c:257
>  xfs_fs_goingdown+0xa9/0x160 fs/xfs/xfs_fsops.c:446
>  xfs_file_ioctl+0x12d4/0x19e0 fs/xfs/xfs_ioctl.c:1473
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc862d7def9
> RSP: 002b:00007fc863b4a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fc862f36058 RCX: 00007fc862d7def9
> RDX: 0000000020000080 RSI: 000000008004587d RDI: 0000000000000006
> RBP: 00007fc862df0b76 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fc862f36058 R15: 00007ffd1aceae18
>  </TASK>

Not a bug.

The reproducer is mounting the filesystem, then some other thread
is immediately resizing the block device underneath the filesystem
to zero length.

In the cases where the test "passes", this happens:

[  215.851387][ T6299] XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
[  215.895695][ T6299] XFS (loop0): Ending clean mount
[  215.953257][ T6299] loop0: detected capacity change from 32768 to 0
[  215.963786][ T6299] syz.0.70: attempt to access beyond end of device
[  215.963786][ T6299] loop0: rw=432129, sector=768, nr_sectors = 128 limit=0
[  215.978206][   T45] XFS (loop0): log I/O error -5
[  215.984613][   T45] XFS (loop0): Filesystem has been shut down due to log error (0x2).
[  215.992720][   T45] XFS (loop0): Please unmount the filesystem and rectify the problem(s).
[  216.011609][ T6230] XFS (loop0): Unmounting Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791o

The loop device change of size happens about 600ms after the mount
finishes, and the next IO that is issued is a log IO. That gets
errored out and the filesystem shuts itseld down.

In the case where it has hung:

231.577098][ T6447] loop0: detected capacity change from 0 to 32768
[  231.590389][ T6447] XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
[  231.642021][ T6447] XFS (loop0): Ending clean mount
[  231.713195][ T6447] loop0: detected capacity change from 32768 to 0
[  231.727969][ T6467] xfsaild/loop0: attempt to access beyond end of device
[  231.727969][ T6467] loop0: rw=4097, sector=2, nr_sectors = 1 limit=0
[  231.742236][ T6467] xfsaild/loop0: attempt to access beyond end of device
[  231.742236][ T6467] loop0: rw=4097, sector=12, nr_sectors = 4 limit=0
....

The loop dev changes size about 700ms afte the mount, and the log IO
has already completed. Hence the next IOs are from the user driven
shutdown (not sure where that is coming from - nothing in syzbot
logs, and no C reproducer was provided) freezing the device before
shutting down the filesystem. These error out, but don't cause a
shutdown because the default XFS config for async metadata writeback
failures is "retry forever":

.....
[  231.849797][   T52] kworker/1:1: attempt to access beyond end of device
[  231.849797][   T52] loop0: rw=4097, sector=18560, nr_sectors = 64 limit=0
[  231.933061][ T6467] XFS (loop0): Failing async write on buffer block 0x2. Retrying async write.
[  231.942187][ T6467] XFS (loop0): Failing async write on buffer block 0x10. Retrying async write.
[  231.951196][ T6467] XFS (loop0): Failing async write on buffer block 0xc. Retrying async write.
[  231.960108][ T6467] xfsaild/loop0: attempt to access beyond end of device
[  231.960108][ T6467] loop0: rw=4097, sector=2, nr_sectors = 1 limit=0
[  231.973536][ T6467] xfsaild/loop0: attempt to access beyond end of device
[  231.973536][ T6467] loop0: rw=4097, sector=12, nr_sectors = 4 limit=0
[  232.053094][ T6467] XFS (loop0): Failing async write on buffer block 0x2. Retrying async write.
[  232.061978][ T6467] XFS (loop0): Failing async write on buffer block 0x10. Retrying async write.
[  232.070960][ T6467] XFS (loop0): Failing async write on buffer block 0xc. Retrying async write.
[  232.143152][ T6467] XFS (loop0): Failing async write on buffer block 0x2. Retrying async write.
[  232.152027][ T6467] XFS (loop0): Failing async write on buffer block 0x10. Retrying async write.
.....

And so the user driven shutdown hangs at this point waiting for
metadata to flush.

This is expected behaviour. If the user wants metadata writes to
fail immediately in this situation, then they need to do:

# echo 1 > /sys/fs/xfs/<dev>/error/metadata/EIO/max_retries

So on IO error the writeback code will only retry once before
failing and shutting down the filesystem immediately.

So, no bug here, just syzbot not understanding how metadata IO
errors are handled by different filesystems. Hence:

#syz invalid

-Dave.
-- 
Dave Chinner
david@fromorbit.com

