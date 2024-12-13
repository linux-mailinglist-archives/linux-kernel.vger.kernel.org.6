Return-Path: <linux-kernel+bounces-444077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3F19F0050
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A341682F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E641DED73;
	Thu, 12 Dec 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="EkVDzfsV"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153DC1DED40
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046900; cv=none; b=mmrfnKqF9YWFsT2f7Q2NghmMq7a1QJENur80ctZFpa3ATLbi9eETyUJDrk55yg/Unu/oKAxUn8C6/JfvQmy7HSCjLuaph0tHKeFuxnd8zhbXHeL+YcRSiSkb3DqfISo8iVoQUjTfILKp/Otwif5zqj4q2niYf/E4mvImU+kWICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046900; c=relaxed/simple;
	bh=My9CADm/GRFqOhg1x2jgXNn+Fzanqgm3kbZK8mNmkiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njNgxL8T2MQ2plmBfai8jW7vD0XzomxHQJijDTV8XV4DIkuVxDpqqs2/PVoQl2YcFiRQGNyuqNEpfLu88bMS8Xj/fIC6lIdcskkvodQLnDMr7RDLAmxW8B2qn3WyehFPj9smT7SMrcVqgwPyPaY5sVGmYX7uR5l1gIJz+5Az8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=EkVDzfsV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd17f231a7so722426a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1734046897; x=1734651697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yT+c2FUjSstL6HPJ9R0DaZw+kOX9JXOb4Qt8nKQGBGI=;
        b=EkVDzfsV6WDWE4hKb66hxgHmcAar4i8jCBHfjaaPC/0664my/a3eva1OgjfMDqirZ9
         ZqRCzMyg0+UBFAcO9lqV9jFi6yld1fTmikCpZVfqd299Ro44gusEr+r6N+6NHKdlK6Xl
         EuWGvAOxcAtqxgq1MIChmgStw+egEFZBOvybLWKsr7/vpXM4Kf9ZrvgBD18GVAerTVTh
         3nfge8c9m68fgQvpYT/+RgjKLbRE2Vd+Qq+0c7hpt0nWbAsETrprqM1Jp0sS7wfYNmdg
         2MNKpHoFByjSpI1VmBQ/uVe6gGCfUkfAYO2wnEFFwd5exEOjA5bwtsMPaNZt96gofK3u
         V/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046897; x=1734651697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT+c2FUjSstL6HPJ9R0DaZw+kOX9JXOb4Qt8nKQGBGI=;
        b=QG57AkEttTHIKbRLMrtcTVi1/kG5A69RiK0EHWu83KdzYmGfLSXpLSZRVc7THteeta
         ANhMYD22bZ3hL7Zu48+HUmxKoImZzVIgofgC3puZygXGDQV18d4HqVZhg0fSbTS8VN7x
         rZyG0Rn0bLyoxq+WeLL4dlFUYcanrYn6ozkqzcI9aWbb8Cy/U2cUt5t1un/95M9NzB5K
         eLuEgXc8lPjoef9JgaTSYK1DjVo3nIfcDV+x4q/BPMXnIBSLVGTNYFIJaMnxOza7GXlI
         Q02fp8yiVFloVMqLpYD5jjiGq+D3g/2bU+tkoX3XQYbMNd1dK6Mew2IFFA1mcCY2Ojq3
         Q24A==
X-Forwarded-Encrypted: i=1; AJvYcCWNrvQrnuXmFVzehSYlgMfnvXPiMZ4R9ov91cZCPbYxzakY9GIe5/BhCVWzT9bw74XofiQPW+8jtvHnvoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRBYqbPpWVy3qiBbl2ozJWnSrxqcTqcHzKRkQ5WzFlTKc+OVV
	wuh7NJpWN+f+bGuvqq7b/DASj1y3suzBAZXRe8GkkwPFt63CGKehB7ptPmcOHoQ=
X-Gm-Gg: ASbGncvRiEW+10uPWBxEGng7LjaG/zV5mnukJj3T4gHxVEG/o4F7fT+oyIGRCToBY1j
	Jqt+kOuLVJMJxqI0paB6A8v6cLb7+ojnh6vOOeT+wuX+oRXWdoHbMfaRpLP6RRcpqgpGn8LaspN
	+uVL7JrDZiyqmZ4KUAW1PNcEUW3P8JL0whrRgino+fpMKMJsSTcmPuY+fr2tN/glfNF3Dcyl52m
	hCgqlCl6TGnbswBlS49lLouMMZ70woRbwC9EHKWAfDrYZvJbvmyT6bP0oYoj6YS+HUEpSIHW5qH
	5NfAAI8ZPjIsSeTTy4I=
X-Google-Smtp-Source: AGHT+IF9Z2LJLhoOcWIAJGMctXGeDrWfWUaDk67FmLka9EWDGXix81A80hZegIuwoMxRaPPEC19tNA==
X-Received: by 2002:a17:90b:4b0f:b0:2ee:bbd8:2b7e with SMTP id 98e67ed59e1d1-2f28fb6aba4mr1160867a91.12.1734046897253;
        Thu, 12 Dec 2024 15:41:37 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc309dsm1869811a91.48.2024.12.12.15.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:41:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLsoI-00000009ztE-1Uw4;
	Fri, 13 Dec 2024 10:41:34 +1100
Date: Fri, 13 Dec 2024 10:41:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+c39928fd177c28b5fa1f@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_map_blocks (2)
Message-ID: <Z1t0rg5VG88QOplp@dread.disaster.area>
References: <674f31ec.050a0220.48a03.003e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674f31ec.050a0220.48a03.003e.GAE@google.com>

On Tue, Dec 03, 2024 at 08:29:32AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0e287d31b62b Merge tag 'rtc-6.13' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=179f05e8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7903df3280dd39ea
> dashboard link: https://syzkaller.appspot.com/bug?extid=c39928fd177c28b5fa1f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/555649be4570/disk-0e287d31.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/612b3b44653e/vmlinux-0e287d31.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9cdc015d8348/bzImage-0e287d31.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c39928fd177c28b5fa1f@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-syzkaller-11930-g0e287d31b62b #0 Not tainted
> ------------------------------------------------------
> kworker/0:4/5894 is trying to acquire lock:
> ffff888048f4dbb0 (&ei->i_data_sem){++++}-{4:4}, at: ext4_map_blocks+0x3be/0x1990 fs/ext4/inode.c:665
> 
> but task is already holding lock:
> ffff888048f4dec0 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
> ffff888048f4dec0 (mapping.invalidate_lock){++++}-{4:4}, at: page_cache_ra_unbounded+0x143/0x8c0 mm/readahead.c:226
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #6 (mapping.invalidate_lock){++++}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
>        filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
>        filemap_fault+0x6e8/0x1950 mm/filemap.c:3332
>        __do_fault+0x137/0x460 mm/memory.c:4907
>        do_read_fault mm/memory.c:5322 [inline]
>        do_fault mm/memory.c:5456 [inline]
>        do_pte_missing mm/memory.c:3979 [inline]
>        handle_pte_fault+0x335a/0x68a0 mm/memory.c:5801
>        __handle_mm_fault mm/memory.c:5944 [inline]
>        handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
>        faultin_page mm/gup.c:1187 [inline]
>        __get_user_pages+0x1c82/0x49e0 mm/gup.c:1485
>        populate_vma_page_range+0x264/0x330 mm/gup.c:1923
>        __mm_populate+0x27a/0x460 mm/gup.c:2026
>        mm_populate include/linux/mm.h:3386 [inline]
>        __do_sys_mlockall mm/mlock.c:769 [inline]
>        __se_sys_mlockall+0x3e3/0x4d0 mm/mlock.c:745
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #5 (&mm->mmap_lock){++++}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        __might_fault+0xc6/0x120 mm/memory.c:6751
>        _inline_copy_from_user include/linux/uaccess.h:162 [inline]
>        _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
>        copy_from_user include/linux/uaccess.h:212 [inline]
>        __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
>        blk_trace_setup+0xd2/0x1e0 kernel/trace/blktrace.c:648
>        sg_ioctl_common drivers/scsi/sg.c:1114 [inline]
>        sg_ioctl+0xa46/0x2e80 drivers/scsi/sg.c:1156
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:906 [inline]
>        __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f

#syz dup: possible deadlock in xfs_vn_update_time


-- 
Dave Chinner
david@fromorbit.com

