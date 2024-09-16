Return-Path: <linux-kernel+bounces-330668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38D97A27A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14F91F216E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176A155352;
	Mon, 16 Sep 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFbWfzuQ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80514B094
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490657; cv=none; b=iwug4/RoZ6hqYgV7hGo766C6xHQw5cszgbcczVAJmIW6zYF9Q0i1qEvY/xLcQzcyCiCNGtFls++iLzF5h6mBNtLFsRGU5gw5/vt4N3jvw2qNyzZ46kgDTLcq+3e61t9AmlzcnHTmNoEOmBLjN0HzCIzdUliHlyjBMbLHNgc4GzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490657; c=relaxed/simple;
	bh=FJuD79p18K+Orf9Dl8T0DPALm2iXl17Pe+PEv9wzuqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geOWlTtsLPBMwDVpTUmOt5SPXe4aMDe6NsVGVFwPzUTaCDcetZ3c8MEhWIhdPczyoDNz0K7mdx/S4tRXtxbR+FCYWAW/1tYmPlUVJa1y2g/MF4OHZgHMJyFwHwup4lqUblK2kG2JxeHgOKFxQiEdxn0rmAkxnAmu8lTuZWpzLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFbWfzuQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so47881881fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726490653; x=1727095453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wc7wWzG9rRTskY74N2A0JeuQQMchxksXv0Y2IDFBgw=;
        b=mFbWfzuQDUSNqpM/OSb+cGcC/LWtLqmAcv4NPu0QuZ+KzHnTEfS2tesONA41m0f3eW
         pyEkM1dUzdm1BjT7CVfU3GhfTEsn1BFthHITu64G4PsslMPTV9z2ZngFqFh92/CndpNb
         hE1gcaxOFOHTTpOCDDK7iNFYU+eAQWYiu+/hyc9Qi9SAee+NLDMCvH0daLNQuQgDRw2P
         CySot6mvzlaJMIC7cQGlNrIcDY8HcTKJH46qc9bQ9RkCgWyvEiL63YMOsgyArsI647AA
         Q3cd2Kbx2Ag5g/rDb16GjeItpuGq5XaQ2Zt2BVSIotyHunOlvk6VC1jECIhXxY9OX8ef
         YfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726490653; x=1727095453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Wc7wWzG9rRTskY74N2A0JeuQQMchxksXv0Y2IDFBgw=;
        b=QXlkHxY2jhJDHNigzJJY/uRjSz/NlfDQLWWR+0M/2dNRMfSX5kshZnJCdS3PzKFBMF
         dYoll6NFvllNDtGSjVcRsZ6uZQwizL1yFDLP3ch+HZrf+mAcbLpo8hCgI8h44jmTv4qr
         etV+UJbLEJluv8J6tE05e8g6IzJHeR2GkWhOmdGMtn585gtGbcn6gYwNjr/WdjG5CT2p
         CFk7WSPbxHzcVRNyWeHZQQWPUVaiUFKs+qno/IVcZV/7wgvp0r6wjBYdf4gl5zkWzOH0
         cYvmrU2uhgmHviKAFYBSDLoPOma9yMixeHParKMDNUK5GDnWgC1aT/I73Rujyq0C+Qqw
         ZKow==
X-Forwarded-Encrypted: i=1; AJvYcCXtU26rZUJDMd5uXmsumrZldCLSPaEXk7yy29bs68GrmvWh+mqQGh4K4YILDcJClvsTDlG3GgiPncNuI9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3F4vQOkaxd1PLDSge5csnyplNAcqLjaFWkmJ7XYYYvSHJWvtS
	7Kl6e+FRVaNglJroJ85MDgBLazjbzi+MVZSsqulPsb+U9suMH1y4AZLTxBC3Vsi0jjIJ+XVj82n
	xnNzf9viOjwA4hLBPXGWgocU9x2wb7N9gNkob
X-Google-Smtp-Source: AGHT+IHaPlFcpYY206Imvn+rh+fRRcwXQC9dHGfgoDcQFXnXsb7OydqM+9O9xBhHeB5lEWkKJQq6Q2kh6EfrewakrDc=
X-Received: by 2002:a2e:611:0:b0:2f7:8b28:dcd5 with SMTP id
 38308e7fff4ca-2f78b28dd66mr54702911fa.36.1726490652963; Mon, 16 Sep 2024
 05:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b409e205eaea8714@google.com> <234e8b7e-1646-3bd0-1c3b-0936ddcb93bf@redhat.com>
In-Reply-To: <234e8b7e-1646-3bd0-1c3b-0936ddcb93bf@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Sep 2024 14:44:01 +0200
Message-ID: <CACT4Y+ZFuwP1uvB434PoitEN1ORbgy8QaBF_=8Vgty9rcKJZ+Q@mail.gmail.com>
Subject: Re: [Cluster-devel] [syzbot] UBSAN: shift-out-of-bounds in gfs2_getbuf
To: Andrew Price <anprice@redhat.com>
Cc: syzbot <syzbot+87a187973530ac822e3c@syzkaller.appspotmail.com>, 
	agruenba@redhat.com, cluster-devel@redhat.com, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Oct 2022 at 15:53, Andrew Price <anprice@redhat.com> wrote:
>
> On 13/10/2022 14:31, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
>
> $ git describe --contains 493ffd6605b2
> next-20221011~172
>
> > git tree:       upstream
>
> It would be useful to know the precise git tree.

Filed https://github.com/google/syzkaller/issues/5316 for this feature request.

> > console output: https://syzkaller.appspot.com/x/log.txt?x=14620252880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> > dashboard link: https://syzkaller.appspot.com/bug?extid=87a187973530ac822e3c
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+87a187973530ac822e3c@syzkaller.appspotmail.com
> >
> > ================================================================================
> > UBSAN: shift-out-of-bounds in fs/gfs2/meta_io.c:128:16
>
>          shift = PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift;
>          index = blkno >> shift;             /* convert block to page */
>          bufnum = blkno - (index << shift);  /* block buf index within
> page */
>
> So likely fixed by commit 670f8ce56dd0632dc29a0322e188cc73ce3c6b92
> "gfs2: Check sb_bsize_shift after reading superblock" which has just
> been merged into mainline, but doesn't appear in next-20221011~172
>
> Andy
>
> > shift exponent 4294967293 is too large for 64-bit type 'u64' (aka 'unsigned long long')
> > CPU: 0 PID: 10195 Comm: syz-executor.3 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> > Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:88 [inline]
> >   dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
> >   ubsan_epilogue lib/ubsan.c:151 [inline]
> >   __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
> >   gfs2_getbuf+0x759/0x7d0 fs/gfs2/meta_io.c:128
> >   gfs2_meta_read+0x153/0x910 fs/gfs2/meta_io.c:265
> >   gfs2_meta_buffer+0x153/0x3a0 fs/gfs2/meta_io.c:491
> >   gfs2_meta_inode_buffer fs/gfs2/meta_io.h:72 [inline]
> >   gfs2_inode_refresh+0xab/0xe90 fs/gfs2/glops.c:472
> >   gfs2_instantiate+0x15e/0x220 fs/gfs2/glock.c:515
> >   gfs2_glock_holder_ready fs/gfs2/glock.c:1303 [inline]
> >   gfs2_glock_wait+0x1d9/0x2a0 fs/gfs2/glock.c:1323
> >   gfs2_glock_nq_init fs/gfs2/glock.h:263 [inline]
> >   gfs2_lookupi+0x40c/0x650 fs/gfs2/inode.c:306
> >   gfs2_lookup_simple+0xec/0x170 fs/gfs2/inode.c:258
> >   init_journal+0x19b/0x22c0 fs/gfs2/ops_fstype.c:739
> >   init_inodes+0xdc/0x340 fs/gfs2/ops_fstype.c:882
> >   gfs2_fill_super+0x1ad8/0x2610 fs/gfs2/ops_fstype.c:1240
> >   get_tree_bdev+0x400/0x620 fs/super.c:1323
> >   gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1323
> >   vfs_get_tree+0x88/0x270 fs/super.c:1530
> >   do_new_mount+0x289/0xad0 fs/namespace.c:3040
> >   do_mount fs/namespace.c:3383 [inline]
> >   __do_sys_mount fs/namespace.c:3591 [inline]
> >   __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f0eed68cada
> > Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f0eee73cf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> > RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0eed68cada
> > RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f0eee73cfe0
> > RBP: 00007f0eee73d020 R08: 00007f0eee73d020 R09: 0000000020000000
> > R10: 0000000000000008 R11: 0000000000000202 R12: 0000000020000000
> > R13: 0000000020000100 R14: 00007f0eee73cfe0 R15: 0000000020000080
> >   </TASK>
> > ================================================================================
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/234e8b7e-1646-3bd0-1c3b-0936ddcb93bf%40redhat.com.

