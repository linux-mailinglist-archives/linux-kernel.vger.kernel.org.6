Return-Path: <linux-kernel+bounces-313857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A8E96AAE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52FCCB20DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0DC188917;
	Tue,  3 Sep 2024 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf9znXkh"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02C20E3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400921; cv=none; b=pUHZ4vnBeJjVloYyiwiTANI3weIBqM1EO8L90GNJL0GQsQjdhueH45Z40WecLleHUSl2K8ZLMJhdt5A1We9EtjPmwd+CnZ3Y4ViC4ZgcZQvOOZ8XM+Co2+Qf8jGSH6Wivm+eiA1gHFN3saoPQUul412NRyhtbsw+ZyDZLth5B1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400921; c=relaxed/simple;
	bh=lyuGcpHDWA1T9gj+VPLdp2WF+VkZjVd1IQWF5lBgoGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNIpdk+yHDycTjbnZiiSpCiJqzUZe3yCciBdgZm4Lt4FG1EFy7ywUa1q8MIq1bZUCr8o6/2tRAD17n5s1pFwpJPFIvz8QB4gjKQphJaMJa/fp5l/zNCO5ztg68aJ7r5DSD2bbAWGWy7YSZU981FrXBixEyx0nOydq9d+2bzz32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf9znXkh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7176645e440so69801b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725400919; x=1726005719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMCLmLrQu+oIh3rfWB/Cmsdb+Iwa1VOQcj7t2pkin70=;
        b=Yf9znXkh8uD5n2U/iZ43vGMwwkGkMn3oPXDjJy9CnVD4U1VaaQQ9okQ8X0GJ52EKMm
         rCe+b/7odsb/g15k+u9fAAM0VwjYedHMmeReZFEmAHyQ4yUj3SbFStez4l4CGLhRMyO9
         oiUATwwb0DeK+Lyc4XSUuvkcdXoBXW8Wau7AAUcNBZ/fL+TQ8Mziz6e5YJx/oTfEUMGU
         Ek4IPfmpJPT57orI+WdZtvHuGnG3/Ix0N3hzdIGbBZL6cN25bqwVhU15dtkXwoZt8yVl
         HBaJoiNkiBR8Lab27eHJqihQCeOS9gY6j0pWaPlObiJmbbhOzzFLQZqEDtmvZ+QWQNts
         IS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725400919; x=1726005719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMCLmLrQu+oIh3rfWB/Cmsdb+Iwa1VOQcj7t2pkin70=;
        b=YmCfpJe4nWTD7TYaz7xAqttYeAOLl4Q65wKla5Hz5sxbOc7FxuxaGg8kVjHw/ePRfk
         PcJRQ6AclK2LJBrXdatCEbgHwPGL6l2qlG6UQyMEUU3cWNJRc9KnVxWhTlk4yQJLroY4
         zcvs73t5LCyh5cK5uPrPBgb+Y5HYx+9+Kd0RbhTaquJUlU9zd7Q2Am6dE79iF4slrvVO
         M45CBK3yn9YHCc4AP/pMItgPmcgk4CE/vUUYDUfaEK5Y+MlC+50zyGIfbthkU7qqtHRt
         jyJumcQ6kedkhb5aQ0luaIJsT0sOc6cB6lLuidyS4FPoi/Nj8TjRzAYWb3pBvBob60Cs
         1XsA==
X-Forwarded-Encrypted: i=1; AJvYcCUOFr+9osk3GduoFsuWN9qench0FxGWDK20eMYbiIp5e+kVZQLm//j9UhQlIbrY6r2qHOIOib7ILTCZCLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbPoJ6YDOyBFIig2rVhKVPnDsNh2p1DKpd4tFjgir1XOjfebxL
	7iah0N6IaOD2m2BdIArC17868xUft/I9x6Iz40w+0SSH2jvjDWv4
X-Google-Smtp-Source: AGHT+IGw0RfmVmNzWwIZDqXsQ9ELLRe53PCjLTeT9HQb56i+TkS85O5v6orW6Da60BV3EnuIlHTXOg==
X-Received: by 2002:a05:6a00:1895:b0:710:9d5e:1154 with SMTP id d2e1a72fcca58-7177a91f845mr8137b3a.2.1725400918666;
        Tue, 03 Sep 2024 15:01:58 -0700 (PDT)
Received: from snowbird ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8da44sm367524a12.33.2024.09.03.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:01:58 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:01:53 -0700
From: Dennis Zhou <dennisszhou@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+6d392a44667baa45bb5a@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	x86@kernel.org, linux-mm@kvack.org
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in pcpu_alloc_noprof /
 pcpu_balance_workfn (2)
Message-ID: <ZteHUcnIjOO57dzm@snowbird>
References: <000000000000d47d440620d54f15@google.com>
 <87le0a797h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le0a797h.ffs@tglx>

On Mon, Sep 02, 2024 at 10:26:10AM +0200, Thomas Gleixner wrote:
> On Thu, Aug 29 2024 at 09:53, syzbot wrote:
> 
> Cc-: x86 folks. Just because something happens on x86 does not mean it's
>      an x86 problem
> 
> Cc+: mm folks. It's entirely clear where this belongs to:
> 
> > read-write to 0xffffffff88bb27ac of 4 bytes by task 3354 on cpu 0:
> >  pcpu_update_empty_pages mm/percpu.c:602 [inline]
> 
> No?
> 

Yeah.. We discussed this a month ago [1], I just haven't had time. I'll
send out the fix for this tonight/tmrw morning.


Thanks,
Dennis

[1] https://lore.kernel.org/lkml/ZqCo7H2gcA1dvIr4@xsang-OptiPlex-9020/

> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d5d547aa7b51 Merge tag 'random-6.11-rc6-for-linus' of git:..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=164c067b980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6fafac02e339cc84
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6d392a44667baa45bb5a
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/e636aa58c364/disk-d5d547aa.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/f5ecd0d96afa/vmlinux-d5d547aa.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/fe7d474f148f/bzImage-d5d547aa.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+6d392a44667baa45bb5a@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in pcpu_alloc_noprof / pcpu_balance_workfn
> >
> > read-write to 0xffffffff88bb27ac of 4 bytes by task 3354 on cpu 0:
> >  pcpu_update_empty_pages mm/percpu.c:602 [inline]
> >  pcpu_chunk_populated mm/percpu.c:1531 [inline]
> >  pcpu_balance_populated mm/percpu.c:2062 [inline]
> >  pcpu_balance_workfn+0x94e/0xa60 mm/percpu.c:2212
> >  process_one_work kernel/workqueue.c:3231 [inline]
> >  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3312
> >  worker_thread+0x526/0x6e0 kernel/workqueue.c:3389
> >  kthread+0x1d1/0x210 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > read to 0xffffffff88bb27ac of 4 bytes by task 6821 on cpu 1:
> >  pcpu_alloc_noprof+0x9a7/0x10c0 mm/percpu.c:1894
> >  bpf_map_alloc_percpu+0xad/0x210 kernel/bpf/syscall.c:466
> >  prealloc_init+0x19f/0x470 kernel/bpf/hashtab.c:341
> >  htab_map_alloc+0x630/0x8e0 kernel/bpf/hashtab.c:576
> >  map_create+0x83c/0xb90 kernel/bpf/syscall.c:1333
> >  __sys_bpf+0x667/0x7a0 kernel/bpf/syscall.c:5692
> >  __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
> >  __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5815
> >  x64_sys_call+0x2625/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:322
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > value changed: 0x00000001 -> 0x00000004
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 UID: 0 PID: 6821 Comm: syz.4.1651 Not tainted 6.11.0-rc5-syzkaller-00081-gd5d547aa7b51 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> 

