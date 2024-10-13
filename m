Return-Path: <linux-kernel+bounces-362820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E127699B998
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C5C1F217F6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212231459E0;
	Sun, 13 Oct 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q46vtueO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A681428F3
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728826150; cv=none; b=NzBc4vLuCvWuRGGcys6mcpPX6cDrEKQGGcRgKhOZQh9wNs0YLbCHAbdMOwwDQfHgf1B0DymNjF2tX9XQAhKVVP/KhAG99sssWokBVUdjxGn+PYncMk2ZdV4CwWpedHoPF7Ns+b7UdZWLvkl19BSVJD5Lt9OHfIWMdzXkRJVr2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728826150; c=relaxed/simple;
	bh=vr05ydl+l3Q8vbbJWJVpp5PqMypHjJjrahJHwSqSpyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijor6RstnGm4yhPOZ3Tw3xvNcPDB6IESQm/2UpOfBNiz54j7osFd6nMrfhQsoGiR4nDqJRZYGiMNx+rUlGtmjhQI9WL/7/HrUIS68NkZMsgLfXnT5wh/8SxZt5AYPHR6kjfb8azW6pT6cUqCGXrHsHV0SBTmLSZfhUk9wqE+fDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q46vtueO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27E4C4CEC5;
	Sun, 13 Oct 2024 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728826149;
	bh=vr05ydl+l3Q8vbbJWJVpp5PqMypHjJjrahJHwSqSpyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q46vtueOfgWVmOtY2fTyxsJa+4ceOftJTy1keVb9sfDj+c6o3QAUPb6PVCPgxQ0np
	 5buN0XQJsfr+wEY8hFaUG6oMRB/JON3oYt/A0RIBobeyuxIyxuletHrTu3Bf6iO9HO
	 KPYAPTAImJPV8JaTkwnm4BFdXHy39F+uRS9cK7vamLbfJ3qVIBCI6IMN40fTdpiyHa
	 wB1yTUx+PeiU2SaaUQpbk/zztFjMp3d1wo0qjnz0UKm+r/Sr/npiYVlwny4vyIoDOM
	 Rfzt2Ikop8HhE6j7Z6xI142PfgYmBgHTJT9E3K6rPAI/qm1h2KPx6x0SU/aWvXSTvl
	 1+4TD8/gnP3Cw==
Date: Sun, 13 Oct 2024 09:29:08 -0400
From: Sasha Levin <sashal@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] INFO: task hung in exit_mmap
Message-ID: <ZwvLJKnyWuaKp8NL@sashalap>
References: <6707f080.050a0220.64b99.001c.GAE@google.com>
 <72188763-843c-4e83-a25a-90be2d0bf9c0@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <72188763-843c-4e83-a25a-90be2d0bf9c0@lucifer.local>

On Thu, Oct 10, 2024 at 04:28:18PM +0100, Lorenzo Stoakes wrote:
>On Thu, Oct 10, 2024 at 08:19:28AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    d3d1556696c1 Merge tag 'mm-hotfixes-stable-2024-10-09-15-4..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10416fd0580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
>> dashboard link: https://syzkaller.appspot.com/bug?extid=39bc767144c55c8db0ea
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/0600b551e610/disk-d3d15566.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/d59d43ed3976/vmlinux-d3d15566.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/e686a3e7e0d6/bzImage-d3d15566.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com
>>
>> INFO: task syz.3.917:7739 blocked for more than 146 seconds.
>>       Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:syz.3.917       state:D stack:23808 pid:7739  tgid:7739  ppid:5232   flags:0x00004000
>> Call Trace:
>>  <TASK>
>>  context_switch kernel/sched/core.c:5322 [inline]
>>  __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
>>  __schedule_loop kernel/sched/core.c:6759 [inline]
>>  schedule+0x14b/0x320 kernel/sched/core.c:6774
>>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
>>  rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
>>  __down_write_common kernel/locking/rwsem.c:1304 [inline]
>>  __down_write kernel/locking/rwsem.c:1313 [inline]
>>  down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
>>  mmap_write_lock include/linux/mmap_lock.h:106 [inline]
>>  exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
>
>Hmm, task freezing up or system becoming unstable/locked up is reminsecent
>of the maple tree bug I fixed in [0], which is still in the unstable hotfix
>branch.
>
>This is likely not going to repro as it's quite heisenbug-ish to trigger
>and the failures are like this - somewhat disconnected from the cause, so
>not sure if there is any case to speed this to Linus's tree.
>
>On the other hand it's a pretty serious problem for stability and likely to
>continue to manifest in nasty ways like this.
>
>Can't be 100% sure this is the cause, but seems likely.
>
>[0]:https://lore.kernel.org/linux-mm/48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com/

On my Debian build box, running a 6.1 kernel, I've started hitting a
similar issue:

Oct 12 17:24:01 debian kernel: INFO: task sed:3557356 blocked for more than 1208 seconds.
Oct 12 17:24:01 debian kernel:       Not tainted 6.1.0-26-amd64 #1 Debian 6.1.112-1
Oct 12 17:24:01 debian kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 12 17:24:01 debian kernel: task:sed             state:D stack:0     pid:3557356 ppid:1      flags:0x00000002
Oct 12 17:24:01 debian kernel: Call Trace:
Oct 12 17:24:01 debian kernel:  <TASK>
Oct 12 17:24:01 debian kernel:  __schedule+0x34d/0x9e0
Oct 12 17:24:01 debian kernel:  schedule+0x5a/0xd0
Oct 12 17:24:01 debian kernel:  rwsem_down_write_slowpath+0x311/0x6d0
Oct 12 17:24:01 debian kernel:  exit_mmap+0xf6/0x2f0
Oct 12 17:24:01 debian kernel:  __mmput+0x3e/0x130
Oct 12 17:24:01 debian kernel:  do_exit+0x2fc/0xaf0
Oct 12 17:24:01 debian kernel:  do_group_exit+0x2d/0x80
Oct 12 17:24:01 debian kernel:  __x64_sys_exit_group+0x14/0x20
Oct 12 17:24:01 debian kernel:  do_syscall_64+0x55/0xb0
Oct 12 17:24:01 debian kernel:  ? do_fault+0x1a4/0x410
Oct 12 17:24:01 debian kernel:  ? __handle_mm_fault+0x660/0xfa0
Oct 12 17:24:01 debian kernel:  ? exit_to_user_mode_prepare+0x40/0x1e0
Oct 12 17:24:01 debian kernel:  ? handle_mm_fault+0xdb/0x2d0
Oct 12 17:24:01 debian kernel:  ? do_user_addr_fault+0x1b0/0x550
Oct 12 17:24:01 debian kernel:  ? exit_to_user_mode_prepare+0x40/0x1e0
Oct 12 17:24:01 debian kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
Oct 12 17:24:01 debian kernel: RIP: 0033:0x7f797d75a349
Oct 12 17:24:01 debian kernel: RSP: 002b:00007fff37f0d3c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Oct 12 17:24:01 debian kernel: RAX: ffffffffffffffda RBX: 00007f797d8549e0 RCX: 00007f797d75a349
Oct 12 17:24:01 debian kernel: RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
Oct 12 17:24:01 debian kernel: RBP: 0000000000000000 R08: fffffffffffffe98 R09: 00007fff37f0d2df
Oct 12 17:24:01 debian kernel: R10: 00007fff37f0d240 R11: 0000000000000246 R12: 00007f797d8549e0
Oct 12 17:24:01 debian kernel: R13: 00007f797d85a2e0 R14: 0000000000000002 R15: 00007f797d85a2c8
Oct 12 17:24:01 debian kernel:  </TASK>

It reproduces fairly easily during a kernel build...

It doesn't sound like the same issue you're pointing out, right Lorenzo?

-- 
Thanks,
Sasha

