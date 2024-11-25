Return-Path: <linux-kernel+bounces-421089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B759D867F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE951169FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A61AC448;
	Mon, 25 Nov 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qAOSYsOK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jVoJGPmm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qAOSYsOK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jVoJGPmm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB631547CA;
	Mon, 25 Nov 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541691; cv=none; b=uJZxyaNVg7ChJMYQ4vMpISstWEXawYiuCZsCVsYnDB1Q+P6ZFf//8jT8q2W3VKrb2w/NSr1K2a5Vuy0cEVWAnZwdrFR9oki7Qq/bEoBNjMweuId4NlWWyWspwTznkasOOj1Lf91Ta3pZCMBLaPJHLo83S4I0izzVQl5VxoryLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541691; c=relaxed/simple;
	bh=/xaG1ZFDI+q6Oj9TQkwJ8JSRaGZPxCGK3MPEvK+yClI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhcrMPHQZPx4madawRNBRw7pGdkbn3jRhroHvCTc2T5czKsBfIQ97eXjha5xPN/aZqvU9oz2qk0tP/H5nKQphJBdcH8/SCxOskdIcFUY8gFjabH7uxUZGOpBFaPMSkkUP1ROQG9/sNbHKAUM/TdGhiwPMjiiCetfUAToJGw1z1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qAOSYsOK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jVoJGPmm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qAOSYsOK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jVoJGPmm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8424D210F2;
	Mon, 25 Nov 2024 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732541687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ynUC4e8pv54Dt8R2o49iWftvVJzhOwkf/lqyI3kufE=;
	b=qAOSYsOK427LkbXE/IqXyrZbIqkjNbiuElcqDlpLh+Tg2Dytz5A4k3+5IbCDtNMG3jaUVk
	UNIuALCtM+QkQI3coh4FVkJ4L9P1HbC1khyHas2TKBclk0F0+/BcPpb3NUv1Qze/cxEHM8
	8zHG3/lLAVsTG4ewpCvU0SqmgYSO0Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732541687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ynUC4e8pv54Dt8R2o49iWftvVJzhOwkf/lqyI3kufE=;
	b=jVoJGPmmVQywMzGRH2Qnvb6DOI8mWZRflmw/4x/PcWptOZZMV+jB9NUGWRfC6BJ0/AGdQh
	3sth9mLlDbpc3bAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732541687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ynUC4e8pv54Dt8R2o49iWftvVJzhOwkf/lqyI3kufE=;
	b=qAOSYsOK427LkbXE/IqXyrZbIqkjNbiuElcqDlpLh+Tg2Dytz5A4k3+5IbCDtNMG3jaUVk
	UNIuALCtM+QkQI3coh4FVkJ4L9P1HbC1khyHas2TKBclk0F0+/BcPpb3NUv1Qze/cxEHM8
	8zHG3/lLAVsTG4ewpCvU0SqmgYSO0Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732541687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ynUC4e8pv54Dt8R2o49iWftvVJzhOwkf/lqyI3kufE=;
	b=jVoJGPmmVQywMzGRH2Qnvb6DOI8mWZRflmw/4x/PcWptOZZMV+jB9NUGWRfC6BJ0/AGdQh
	3sth9mLlDbpc3bAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E7B213890;
	Mon, 25 Nov 2024 13:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T10FEvd8RGchNgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 25 Nov 2024 13:34:47 +0000
Date: Mon, 25 Nov 2024 14:34:46 +0100
Message-ID: <874j3vzbbd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: syzbot <syzbot+351f8764833934c68836@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] BUG: sleeping function called from invalid context in vfree
In-Reply-To: <a8cdee9d-3673-48fa-890e-beed46c029c7@gmail.com>
References: <6744737b.050a0220.1cc393.007e.GAE@google.com>
	<a8cdee9d-3673-48fa-890e-beed46c029c7@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=47cc5fc1922531f];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[351f8764833934c68836];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email,suse.de:mid,suse.de:email,storage.googleapis.com:url];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 25 Nov 2024 13:58:09 +0100,
Eric Dumazet wrote:
> 
> 
> On 11/25/24 1:54 PM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=154bc778580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=47cc5fc1922531f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=351f8764833934c68836
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > userspace arch: i386
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/dddd5525a287/vmlinux-9f16d5e6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/7c9e082ba50b/bzImage-9f16d5e6.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+351f8764833934c68836@syzkaller.appspotmail.com
> > 
> > BUG: sleeping function called from invalid context at mm/vmalloc.c:3359
> > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6938, name: syz.1.230
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz.1.230/6938:
> >   #0: ffff88804a2d2968 (&rmidi->open_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:201 [inline]
> >   #0: ffff88804a2d2968 (&rmidi->open_mutex){+.+.}-{4:4}, at: snd_rawmidi_output_params+0x51/0x1c0 sound/core/rawmidi.c:748
> >   #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
> >   #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: class_spinlock_irq_constructor include/linux/spinlock.h:565 [inline]
> >   #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: resize_runtime_buffer+0x243/0x530 sound/core/rawmidi.c:727
> > irq event stamp: 1218
> > hardirqs last  enabled at (1217): [<ffffffff8b189e32>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> > hardirqs last  enabled at (1217): [<ffffffff8b189e32>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
> > hardirqs last disabled at (1218): [<ffffffff8b189ad5>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
> > hardirqs last disabled at (1218): [<ffffffff8b189ad5>] _raw_spin_lock_irq+0x45/0x50 kernel/locking/spinlock.c:170
> > softirqs last  enabled at (0): [<ffffffff814e57ac>] copy_process+0x1e9c/0x6f20 kernel/fork.c:2321
> > softirqs last disabled at (0): [<0000000000000000>] 0x0
> > Preemption disabled at:
> > [<0000000000000000>] 0x0
> > CPU: 1 UID: 0 PID: 6938 Comm: syz.1.230 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:94 [inline]
> >   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> >   __might_resched+0x3c0/0x5e0 kernel/sched/core.c:8758
> >   vfree+0x75/0x890 mm/vmalloc.c:3359
> >   kvfree+0x33/0x50 mm/util.c:699
> >   resize_runtime_buffer+0x3a7/0x530 sound/core/rawmidi.c:736
> >   snd_rawmidi_output_params+0xeb/0x1c0 sound/core/rawmidi.c:751
> >   snd_rawmidi_ioctl_params_compat sound/core/rawmidi_compat.c:37 [inline]
> >   snd_rawmidi_ioctl_compat+0x3ac/0x3e0 sound/core/rawmidi_compat.c:120
> >   __do_compat_sys_ioctl+0x1cb/0x2c0 fs/ioctl.c:1004
> >   do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
> >   __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
> >   do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
> >   entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> > RIP: 0023:0xf7f01579
> > Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> > RSP: 002b:00000000f506555c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> > RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00000000c0205710
> > RDX: 0000000020000100 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >   </TASK>
> > ----------------
> > Code disassembly (best guess), 2 bytes skipped:
> >     0:	10 06                	adc    %al,(%rsi)
> >     2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
> >     6:	10 07                	adc    %al,(%rdi)
> >     8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
> >     c:	10 08                	adc    %cl,(%rax)
> >     e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> >    1e:	00 51 52             	add    %dl,0x52(%rcx)
> >    21:	55                   	push   %rbp
> >    22:	89 e5                	mov    %esp,%ebp
> >    24:	0f 34                	sysenter
> >    26:	cd 80                	int    $0x80
> > * 28:	5d                   	pop    %rbp <-- trapping instruction
> >    29:	5a                   	pop    %rdx
> >    2a:	59                   	pop    %rcx
> >    2b:	c3                   	ret
> >    2c:	90                   	nop
> >    2d:	90                   	nop
> >    2e:	90                   	nop
> >    2f:	90                   	nop
> >    30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> >    37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
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
> 
> Bug added in
> 
> commit 84bb065b316e8367e14a8824a8f4d21056b10c53
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Tue Feb 27 09:52:51 2024 +0100
> 
>   ALSA: rawmidi: Use guard() for locking
> 
>   We can simplify the code gracefully with new guard() macro and co for
>   automatic cleanup of locks.
> 
>   There are a few remaining explicit mutex and spinlock calls, and those
>   are the places where the temporary unlock/relocking happens -- which
>   guard() doens't cover well yet.
> 
>   Only the code refactoring, and no functional changes.
> 
>   Signed-off-by: Takashi Iwai <tiwai@suse.de>
>   Link:https://lore.kernel.org/r/20240227085306.9764-10-tiwai@suse.de
> <https://lore.kernel.org/r/20240227085306.9764-10-tiwai@suse.de>

Hmm, through a quick glance, I don't see anything breaking there.

Could you tell me which code path introduced the spinlock held during
kvzalloc() call in resize_runtime_buffer() in sound/core/rawmidi.c by
this commit...?


thanks,

Takashi

