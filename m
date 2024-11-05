Return-Path: <linux-kernel+bounces-396819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6189BD2A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA060B237C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC2B1D9A7F;
	Tue,  5 Nov 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="l1fuiiUg"
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD11D935D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824805; cv=none; b=MXGIuDDrxGPe9K+EYUWgUEferiX2Knu6nW5a4snHV8iiHJVH9fHofHHGjEEqz6Vhh0rKajnl3zPGxKawt/d5neXfRGNKMmtUkGWgoSdZunTblmRZv8AjrKDzqLXYDlt7XEyegM+mPNKvXkyFmCEeZyNjTWWcQhaNb/h027qegpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824805; c=relaxed/simple;
	bh=jYK+4obkioSArbIr14R8ZfnXOA3M2j5bCr+EfxGIOBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1F3M4p6UpD6O+D/1H8FNlsIvOoXJHWo9JtjaVOjFYny19c5vGql/NR+P9Kh3yuFEmVo07o86CrMswiGy++CfySQRYt0GmMY+WIyVz/eplUarDu7Ub7pabjLK9EU/TqIxM2cnCgd4UKz9M1NdzLdTLHa5c+hzXtgoQiiRigoujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=l1fuiiUg; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so34455696d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 08:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1730824801; x=1731429601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRBcew+0JiL3+UmM8Y8pVven1H5td1/bh4NGZK/Ka30=;
        b=l1fuiiUgEK+gB4xejJAfySZ1PM2J+KcSO4/vPHAgrFGveXrOdsqMIJnQNf+Qcv6vtn
         1L+/g4UbxuUdsvYq7a8csgcldvWJkNd/PEXMEmT19654nV9++oBUwws9eW4ZyFSQf+OI
         8WknGJOkrMiUafLyjaNoMExsgzue8IfFkV4S35lP2SXkjPUGpmE67bp4NVZeGnaKon+s
         R1Fju8TKDy8ZtLO9AYvu+ESvo+xp9fqGCOtJWI5r6icynm8UOpFJdK298iL673ZyVHzI
         nKtnPLIoZIun2lLGfBzkBsY6p4QMNjI0iwnV65dPVSY8bowZc67fAhpezUzqJIbBqmPZ
         3Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730824801; x=1731429601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRBcew+0JiL3+UmM8Y8pVven1H5td1/bh4NGZK/Ka30=;
        b=iaIPzxey3VMTRmZFKSVP+wvZ3REj+nfBvU7WxOdJ0R12DclZg9p2fO8SY8rkFUd1fB
         KsAUaap7q3wO5w37hIZFXvsAyBvmvNkdkM5gagwyJLOPSLZ+dcc/SektD6AFdl6rocee
         gE+oIvCOUrNy0pH5D34uqgLDCM+x8w4dbHHj/+KSEAT+ZMMZZCPXKQG2QfP8DLUvm6QA
         dprcEY6dmrdF1wJaRVZ6/cPqGz04q+4axuUomMZ6s+LhzNqVcwPA8L3UKGqsScamV4Ow
         FAV+tUJi04j5YmgZ7TBrsnlBCy0I5E/zVJeJdpOJQ6wZ5Q8fhp8l/OmmTWcW6NFl+YOH
         qaQA==
X-Forwarded-Encrypted: i=1; AJvYcCVLBnmGzntKGW0Y3cRzMkczVD3SvI19FEe9RMZPlyPzJELJxLcdJvbaHET3ROXXohWmueEDESRejUwB4QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfbpu6QI4JemLJEPtSJwVjn50hBxjbu/WDat7Gqi5AGb5kU/hl
	zEnNcFlGPxxrvlk3j2pSgVUxvs9JGPIZZIMGkH0QDLdEpVocVcA1wryIUIeqNg==
X-Google-Smtp-Source: AGHT+IF1lrJ55ZLaqsMQmCJc+nZLoIrd0pBKX6PyZTE2jGiWvlQkkwXauxY0gK7p2TEXIq7R5lQScQ==
X-Received: by 2002:a05:6214:46a0:b0:6cc:255:202f with SMTP id 6a1803df08f44-6d18586b5e2mr624317936d6.51.1730824801484;
        Tue, 05 Nov 2024 08:40:01 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.12.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3541775a5sm62122436d6.110.2024.11.05.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:40:00 -0800 (PST)
Date: Tue, 5 Nov 2024 11:39:59 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com,
	linux-usb@vger.kernel.org
Subject: Re: [syzbot] [mm?] kernel BUG in __page_table_check_zero (2)
Message-ID: <f94f3351-be53-4d61-a31a-2bb07925c5ad@rowland.harvard.edu>
References: <67230d7e.050a0220.529b6.0005.GAE@google.com>
 <20241104200007.dc8d0f018cc536a4957a1cd0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104200007.dc8d0f018cc536a4957a1cd0@linux-foundation.org>

On Mon, Nov 04, 2024 at 08:00:07PM -0800, Andrew Morton wrote:
> On Wed, 30 Oct 2024 21:54:22 -0700 syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> 
> Thanks.  I'm suspecting some USB issue - fault injection was used to
> trigger a memory allocation failure and dec_usb_memory_use_count() ended
> up freeing an in-use page.  Could USB folks please have a look?

Andrew, I'm not sure what to look for.  Can you read through 
usbdev_mmap() in drivers/usb/core/devio.c, along with the four short 
routines preceding it, and let us know if anything seems obviously 
wrong?

Alan Stern

> > HEAD commit:    850925a8133c Merge tag '9p-for-6.12-rc5' of https://github..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1346c940580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ccc0e1cfdb72b664f0d8
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158ab65f980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120e6a87980000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/da8019730dec/disk-850925a8.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/b1ee80babbbc/vmlinux-850925a8.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/462580e2ad54/bzImage-850925a8.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com
> > 
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffede422258 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> > RAX: ffffffffffffffda RBX: 00007ffede422280 RCX: 00007f69e1b3c569
> > RDX: 0000000002000005 RSI: 0000000000003000 RDI: 000000002001a000
> > RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000080000000
> > R10: 0000000000011012 R11: 0000000000000246 R12: 00007ffede42227c
> > R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
> >  </TASK>
> > ------------[ cut here ]------------
> > kernel BUG at mm/page_table_check.c:157!
> > Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > CPU: 1 UID: 0 PID: 5850 Comm: syz-executor279 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > RIP: 0010:__page_table_check_zero+0x274/0x350 mm/page_table_check.c:157
> > Code: c1 0f 8c 39 fe ff ff 48 89 df e8 87 28 f3 ff e9 2c fe ff ff e8 dd 6a 89 ff 90 0f 0b e8 d5 6a 89 ff 90 0f 0b e8 cd 6a 89 ff 90 <0f> 0b f3 0f 1e fa 4c 89 f6 48 81 e6 ff 0f 00 00 31 ff e8 95 6f 89
> > RSP: 0018:ffffc900046bf6d8 EFLAGS: 00010293
> > RAX: ffffffff820b7fa3 RBX: dffffc0000000000 RCX: ffff88802fc13c00
> > RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88801e97380c
> > RBP: ffff88801e97380c R08: ffff88801e97380f R09: 1ffff11003d2e701
> > R10: dffffc0000000000 R11: ffffed1003d2e702 R12: ffff88801e9737c0
> > R13: 1ffffffff34887b4 R14: 0000000000000002 R15: 0000000000000000
> > FS:  0000555570714380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f69e1b92385 CR3: 0000000073ae6000 CR4: 0000000000350ef0
> > Call Trace:
> >  <TASK>
> >  page_table_check_free include/linux/page_table_check.h:41 [inline]
> >  free_pages_prepare mm/page_alloc.c:1109 [inline]
> >  free_unref_page+0xd0f/0xf20 mm/page_alloc.c:2638
> >  dec_usb_memory_use_count+0x259/0x350 drivers/usb/core/devio.c:198
> >  mmap_region+0x2180/0x2a30 mm/mmap.c:1574
> >  do_mmap+0x8f0/0x1000 mm/mmap.c:496
> >  vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
> >  ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f

