Return-Path: <linux-kernel+bounces-421023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4E9D86C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504B2B3927C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8843F1A76A4;
	Mon, 25 Nov 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPmr3grn"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8C31474DA;
	Mon, 25 Nov 2024 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539496; cv=none; b=HtflZPFqUG8Q4jsLNihoIawbQkkqX7J1J8Lp2OBozUer5nHrpVKSpGFZJEF3bN3TcQWbtt9nIeKv7Hndb8X0a75d4GlQ8RlLr+lhCSeccJh6i6yEXEI9GgJQI9+ZUkPoOQYUfufcGZqnSx99gzkT+hoIzV6/gDjTlG4cs0gOckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539496; c=relaxed/simple;
	bh=s4R6OqHUdyO6ocIUrP5v4LoNg9KKAGrBVo4UrX8jrvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gFBI/PI9zQapHlqbaZZlJFy2q38OXZYKiyYjqW7uLfnrs0Ca0Ubyr/VEhVCtaF/ESM6/hajp+P/AZTd39ha62RDN7CMI6WG8vjStGXtUPmSjF35bK1ajDMXLckxQvX7xqmSu5aYGKY+7I0yhJ1TVijtBGFT27r9Ol5qhiledAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPmr3grn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431616c23b5so24680245e9.0;
        Mon, 25 Nov 2024 04:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732539493; x=1733144293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKduaXepfJJv52K0+QTD8OBByPhRd/wToXHhwuw+IXg=;
        b=GPmr3grn1ryNod6kPcGzupb1UtkF+2l0ZSI/FdLGqhNv9m11lojzPGVNh0QCCm9205
         7YbleFl8z6pmpIluSsTrsWstZdtDzk15pErBDRSniqyAcm/RCtY6NwXpuxLH/ZNryV0r
         Q0ubbYHat//IwWh4rxzFAZT3qCEQQng8/BznOa6Hl+iPciq5dbQZKVDn8UpGB9sCrjuh
         O4+mJ5oznSiEZaN64mefpDtEbDy3tBxE9ih/YPoKehjTbqGCH2bX28ZUoGMO90Xj0Dba
         j8OzMnQAUF4pMFwfzkOQS4BAqUMX5SNLdsccF13Rqpzrd7Ks4GW3C3MvEIk3rl9kK3GT
         eMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539493; x=1733144293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKduaXepfJJv52K0+QTD8OBByPhRd/wToXHhwuw+IXg=;
        b=Y5+gm1r2005ig9kJgfSfAPWy6Gqo/yHY4OP2fk/r9wRhcfCr67DqCDNf7C+VaHVDjB
         O1Q3fefStohNCssc/UZ9qrYfTKZNEgHtjnyKkb9i2curB8/Z/mKC91/zKtoyBVEtjkLE
         u5gtVPdXmm1chGUBsIEFVBBIhQTF4HgNIF6vVelihhnLbfbEX+sArwQx00H5IWiwRjTl
         OhoHlZitKmWCn5pWLaRUn/s5/hStEvFRsyJrEEuyHC+Kozn8rfyyXRh1r4xnINqGRhm1
         10HHUMyA8BkS/1DkY3J6MHsEL+Ee6LxkP/uIaKFkhNfKX6hFO3zuYCinUXpOxAJ+Cl3u
         MRnA==
X-Forwarded-Encrypted: i=1; AJvYcCU3pQ1TeqUMVWRK1SCh+GaaQl8afGi8W4V4s0AiKzhKuCz+McwS0d7tvik5p2rjgUhPUGVpKq78rsf/nSI=@vger.kernel.org, AJvYcCXzVIBFv93/dkE++kTXKc8xyir0jMsk/X9TuyIyPU4Z049Is2m8RcuDiWRLimJ/7bTnz87UsF072sV9Mx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8PeokH/xtzYCbbXwT4wZHcFJR13EBiwZgl/sJI4dc7rtjAAX
	cGa8Ez7E0DuDU3MoEh7UpSqnhpjFs3Icvw+fU/EqUlhQRfETxmLo9zJzlg==
X-Gm-Gg: ASbGncslmii5fHyW5sC+N+nnOn/wtSX1PbqRBpVw+x/bMzo67a0wEJAKTzO+s99Kfk8
	Q1UuxzDWdNsXSENy5e1HXyEhtjeUCe1FBtEL1FXolfF7NV00Ewhg+O6EasoV5P0QO3TdZiyb6uN
	AlWgz91Cy7QH8xfth2YupTR0HZkI6py143Ro4VCLZ0uaZL4hNb/icPDx7K/maf9irjtrVph0Ukm
	0aa+GGFdxrW82njRM8rokmeibA2r6iKMlaRsSSEF2/2/hIJBH8=
X-Google-Smtp-Source: AGHT+IFp4ChqQelq8MkmiSwlO9RlXRMjqxQ3mg7/ppOkbVBfcla3pB5G6Y+uiakHmn95zCqPpgwzQg==
X-Received: by 2002:a05:600c:480f:b0:434:9fca:d6c3 with SMTP id 5b1f17b1804b1-4349fcad705mr23814755e9.9.1732539491559;
        Mon, 25 Nov 2024 04:58:11 -0800 (PST)
Received: from [10.0.0.4] ([37.174.249.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45bdbabsm190521845e9.18.2024.11.25.04.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:58:10 -0800 (PST)
Message-ID: <a8cdee9d-3673-48fa-890e-beed46c029c7@gmail.com>
Date: Mon, 25 Nov 2024 13:58:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [sound?] BUG: sleeping function called from invalid
 context in vfree
To: syzbot <syzbot+351f8764833934c68836@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz,
 syzkaller-bugs@googlegroups.com, tiwai@suse.com
References: <6744737b.050a0220.1cc393.007e.GAE@google.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <6744737b.050a0220.1cc393.007e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/25/24 1:54 PM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=154bc778580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=47cc5fc1922531f
> dashboard link: https://syzkaller.appspot.com/bug?extid=351f8764833934c68836
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dddd5525a287/vmlinux-9f16d5e6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7c9e082ba50b/bzImage-9f16d5e6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+351f8764833934c68836@syzkaller.appspotmail.com
>
> BUG: sleeping function called from invalid context at mm/vmalloc.c:3359
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6938, name: syz.1.230
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz.1.230/6938:
>   #0: ffff88804a2d2968 (&rmidi->open_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:201 [inline]
>   #0: ffff88804a2d2968 (&rmidi->open_mutex){+.+.}-{4:4}, at: snd_rawmidi_output_params+0x51/0x1c0 sound/core/rawmidi.c:748
>   #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
>   #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: class_spinlock_irq_constructor include/linux/spinlock.h:565 [inline]
>   #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: resize_runtime_buffer+0x243/0x530 sound/core/rawmidi.c:727
> irq event stamp: 1218
> hardirqs last  enabled at (1217): [<ffffffff8b189e32>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> hardirqs last  enabled at (1217): [<ffffffff8b189e32>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
> hardirqs last disabled at (1218): [<ffffffff8b189ad5>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
> hardirqs last disabled at (1218): [<ffffffff8b189ad5>] _raw_spin_lock_irq+0x45/0x50 kernel/locking/spinlock.c:170
> softirqs last  enabled at (0): [<ffffffff814e57ac>] copy_process+0x1e9c/0x6f20 kernel/fork.c:2321
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 1 UID: 0 PID: 6938 Comm: syz.1.230 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>   __might_resched+0x3c0/0x5e0 kernel/sched/core.c:8758
>   vfree+0x75/0x890 mm/vmalloc.c:3359
>   kvfree+0x33/0x50 mm/util.c:699
>   resize_runtime_buffer+0x3a7/0x530 sound/core/rawmidi.c:736
>   snd_rawmidi_output_params+0xeb/0x1c0 sound/core/rawmidi.c:751
>   snd_rawmidi_ioctl_params_compat sound/core/rawmidi_compat.c:37 [inline]
>   snd_rawmidi_ioctl_compat+0x3ac/0x3e0 sound/core/rawmidi_compat.c:120
>   __do_compat_sys_ioctl+0x1cb/0x2c0 fs/ioctl.c:1004
>   do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>   __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>   do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>   entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf7f01579
> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f506555c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00000000c0205710
> RDX: 0000000020000100 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> ----------------
> Code disassembly (best guess), 2 bytes skipped:
>     0:	10 06                	adc    %al,(%rsi)
>     2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>     6:	10 07                	adc    %al,(%rdi)
>     8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>     c:	10 08                	adc    %cl,(%rax)
>     e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
>    1e:	00 51 52             	add    %dl,0x52(%rcx)
>    21:	55                   	push   %rbp
>    22:	89 e5                	mov    %esp,%ebp
>    24:	0f 34                	sysenter
>    26:	cd 80                	int    $0x80
> * 28:	5d                   	pop    %rbp <-- trapping instruction
>    29:	5a                   	pop    %rdx
>    2a:	59                   	pop    %rcx
>    2b:	c3                   	ret
>    2c:	90                   	nop
>    2d:	90                   	nop
>    2e:	90                   	nop
>    2f:	90                   	nop
>    30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>    37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
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


Bug added in

commit 84bb065b316e8367e14a8824a8f4d21056b10c53
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue Feb 27 09:52:51 2024 +0100

   ALSA: rawmidi: Use guard() for locking

   We can simplify the code gracefully with new guard() macro and co for
   automatic cleanup of locks.

   There are a few remaining explicit mutex and spinlock calls, and those
   are the places where the temporary unlock/relocking happens -- which
   guard() doens't cover well yet.

   Only the code refactoring, and no functional changes.

   Signed-off-by: Takashi Iwai <tiwai@suse.de>
   Link:https://lore.kernel.org/r/20240227085306.9764-10-tiwai@suse.de 
<https://lore.kernel.org/r/20240227085306.9764-10-tiwai@suse.de>


