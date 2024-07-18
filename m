Return-Path: <linux-kernel+bounces-256300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3B934C37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4907F1C21020
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE812EBCA;
	Thu, 18 Jul 2024 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mEYFvZg7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15428823C8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300949; cv=none; b=XUjwkSaWe4uLLSJY1L62WWQ2T040KSeuiPgAnzMKeeUNOrbfe4PJpDh0deLB7NEw2stQ+L1rTONfT/U4sdMe7kKkNbBIAi5wWZflLA70s790VD7OkgIyLgN/seqkeQW+CC0cdPStTpfhuu2CqCH+My1b86mQRbgPZENCRXu12ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300949; c=relaxed/simple;
	bh=Hi6+PXjlyeovTHQCMrMLw0CwZB4LvaETQJ3QzsgUfO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRlXtvE3CFzwbvNOEC4JI3zfzykKvlN++2oyeafELdbtSxqjEwCBGcHhUpy/Q4fKB77cGJLANKNaoQYu1EoSFuZwNLgKnsotusexGfvO0SGQ5/7db/mr9xayGSMoPWXP20SRPYG/87fpS35BZu/BBio0/XOZrWobtqQ74Y5i1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mEYFvZg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0691CC4AF09;
	Thu, 18 Jul 2024 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721300948;
	bh=Hi6+PXjlyeovTHQCMrMLw0CwZB4LvaETQJ3QzsgUfO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEYFvZg7kvRmLB/LOXJn1qqSA4nL8dLMVSOAco0ZhQdjCaDlGP4P53gW8yXa1m7TD
	 qTQ8qt8e6RyfQu52erOphvgADnHQpgF4bsFbjyb4yE8ByKWRdOZnzaspku1cyqczfv
	 qa/RV4LHRMRA1LgH7F1/q7H3lBlHVo5dqgNKCpjc=
Date: Thu, 18 Jul 2024 13:09:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+0ac8e4da6d5cfcc7743e@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in kobject_put /
 kobject_uevent_env (2)
Message-ID: <2024071845-breach-dripping-a1e5@gregkh>
References: <000000000000381fbb061d81bd85@google.com>
 <CANpmjNPzw1=_VDfMDskrKWiabLV1aZVC1VeThLZTDn=qWMUsZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPzw1=_VDfMDskrKWiabLV1aZVC1VeThLZTDn=qWMUsZQ@mail.gmail.com>

On Thu, Jul 18, 2024 at 12:38:05PM +0200, Marco Elver wrote:
> On Thu, 18 Jul 2024 at 10:55, syzbot
> <syzbot+0ac8e4da6d5cfcc7743e@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d67978318827 Merge tag 'x86_cpu_for_v6.11_rc1' of git://gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11af145e980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ca8f4e92a17047ec
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0ac8e4da6d5cfcc7743e
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/1f219d0a9994/disk-d6797831.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/91aed26b830f/vmlinux-d6797831.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c7e753e56950/bzImage-d6797831.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0ac8e4da6d5cfcc7743e@syzkaller.appspotmail.com
> >
> > llcp: llcp_sock_recvmsg: Recv datagram failed state 3 -6 0
> > ==================================================================
> > BUG: KCSAN: data-race in kobject_put / kobject_uevent_env
> >
> > read-write to 0xffff888139ddec54 of 1 bytes by task 22621 on cpu 0:
> >  kobject_uevent_env+0x4e/0x550 lib/kobject_uevent.c:476
> >  kobject_uevent+0x1c/0x30 lib/kobject_uevent.c:641
> >  device_del+0x6fa/0x780 drivers/base/core.c:3886
> >  nfc_unregister_device+0x114/0x130 net/nfc/core.c:1183
> >  nci_unregister_device+0x14c/0x160 net/nfc/nci/core.c:1312
> >  virtual_ncidev_close+0x30/0x50 drivers/nfc/virtual_ncidev.c:172
> >  __fput+0x192/0x6f0 fs/file_table.c:422
> >  ____fput+0x15/0x20 fs/file_table.c:450
> >  task_work_run+0x13a/0x1a0 kernel/task_work.c:180
> >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> >  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
> >  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff888139ddec54 of 1 bytes by task 22615 on cpu 1:
> >  kobject_put+0x25/0x180 lib/kobject.c:733
> >  put_device+0x1f/0x30 drivers/base/core.c:3787
> >  nfc_put_device net/nfc/nfc.h:103 [inline]
> >  nfc_llcp_local_put+0x87/0xb0 net/nfc/llcp_core.c:196
> >  nfc_llcp_sock_free net/nfc/llcp_sock.c:1021 [inline]
> >  llcp_sock_destruct+0x14d/0x1a0 net/nfc/llcp_sock.c:966
> >  __sk_destruct+0x3d/0x440 net/core/sock.c:2175
> >  sk_destruct net/core/sock.c:2223 [inline]
> >  __sk_free+0x284/0x2d0 net/core/sock.c:2234
> >  sk_free+0x39/0x70 net/core/sock.c:2245
> >  sock_put include/net/sock.h:1879 [inline]
> >  llcp_sock_release+0x38f/0x3d0 net/nfc/llcp_sock.c:646
> >  __sock_release net/socket.c:659 [inline]
> >  sock_close+0x68/0x150 net/socket.c:1421
> >  __fput+0x192/0x6f0 fs/file_table.c:422
> >  ____fput+0x15/0x20 fs/file_table.c:450
> >  task_work_run+0x13a/0x1a0 kernel/task_work.c:180
> >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> >  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
> >  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > value changed: 0x07 -> 0x0d
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 22615 Comm: syz.0.6322 Tainted: G        W          6.10.0-syzkaller-01155-gd67978318827 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> > ==================================================================
> 
> The two racing accesses here (on bitfield variables
> kobj->state_remove_uevent_sent, kobj->state_initialized) are in the
> same bitfield. There's no guarantee (by the compiler) that while the
> bitfield is being updated the bit at kobj->state_initialized will
> remain non-zero, and therefore the WARN in kobject_put() could be
> triggered. This appears benign, unless of course someone set
> panic_on_warn.
> 
> More generally, if the bitfield is updated concurrently, it's very
> likely that one of the updates would be lost.
> 
> Just my initial observation.

Thanks for the review, I'll try to carve out some time next week to
knock up a patch for this...

greg k-h

