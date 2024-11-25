Return-Path: <linux-kernel+bounces-421146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E674A9D8872
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7EDB2CCE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A11AF0A4;
	Mon, 25 Nov 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8nylvdt"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246C27468;
	Mon, 25 Nov 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543682; cv=none; b=V0HXOoPdeu9D8Rn4ZkNLihkLOdwDPclf/6xej1boBn9vQQ3553kTJ5toHCmNb0mJGRZi6B1TdTjmqpu1vxhqQe84rbbtoZgQ8yRvB126vqEaUs6N4/AvQj1P1Udit5cyvYWPeg0fjan+evdBAQSpytyAdgiMfByxomeyMUl/Bg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543682; c=relaxed/simple;
	bh=ybfFEp8xvh7icdJMNXNeOa1SSUzzdMbw5qvvysU6cZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYxMzivflTHRrk5vqKB38iJ5PWtNVuayNaqfuF+fXd2CL4MPxSmvSzpBQCiAhm2WgpBAS1+B9s3T+l7GsXkCfmyNkmp/pt0T+J/7JHfNuVMcGqA/yTKiQfIyGx4S8ZLH3uxPJX0vyaOrZfFF/rU9mPRG9/AsnFXM9C/A8ADUQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8nylvdt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3823f1ed492so3034117f8f.1;
        Mon, 25 Nov 2024 06:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732543678; x=1733148478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APzAcZCLce9CpKG0vnp79Rw+Bx2cdgE/hfmt/0Hm9lI=;
        b=Z8nylvdt5He44etVL4PLY1WDgGvdBoeSc7nV9jP0pAZIRE9ZveMAb3Qw99Tq/YdKp8
         B6z+8DXnp3jvf8ZF9cF0fgOg41v2d0Ldp99c1Br9VIeNw5Xn57oYZQleNNQtGMKvd5VP
         S//AeIiTnZ18v9xCa4Fk7IbYbsUTyTL/U/wwhkNYsRyWUWXBlEgBhpVkkTLhgYj4uqPv
         wsTWWOMNP57BOPsi+8eRnSpaNnGrhMELfDiE+4YC9HDB+do3g5Uspzm6QDiFXptU1f2s
         a4yRpiO8MOV+SiABAD2aXCT41BYzrgFVrUHrRe8Qp3BnkSR2nOEY+nDLnciotggk+lIU
         T/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732543678; x=1733148478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APzAcZCLce9CpKG0vnp79Rw+Bx2cdgE/hfmt/0Hm9lI=;
        b=JqfWonN46m8MhVcSxMvscZahws79cvkl5DRO+rrrMd9De/ol9WVqhSB+TZoX7QlV2p
         Pi8QvD1X7/1WjVLn5ymXAqAR35S8OZSabuBRb2T9gLPrOqOVF12LwAYpZ4/STbvS4Lsa
         QxLR1a2A7FYs7PHrCge6eIkP0nHs2uMAVxTxGUnLutwswHfCXa+aPWYd1LfgJHqK/LtM
         XBtviaynskU1t5kzryl7/NdshIFHzQxveztfq9a9/P8MsNnj68zau8Dox41YoLFqrqrC
         InPExrPE0OmPiZMt2M8G6pI905d2P7Ia7es/HUz3qkFOAGxsNTO43t6VLWSqE147vFKT
         yDww==
X-Forwarded-Encrypted: i=1; AJvYcCUb5BruP3tsdwrXeJQKjrWF08lob2VDoZ90YRt4rnyqaMXhvZOYWCt6p11N0HnZjt8028SrQuXl2hsDgU0=@vger.kernel.org, AJvYcCXACIWeJqYAIJtKuc7GLOGVZ8g3mF7tloce4/bKqnEnLgzLacpHwGOUwQzKECnVKilF632f2Sjng5k4KG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rERboupEhkfYpDrL7oGgqjMr8YI901xVFLuSmH8zXu8AME+u
	cStQsKmXLZj0HY/NwbW+JD7SrDHaXgdJ334bKTBWSAQl3z3Bb+4f
X-Gm-Gg: ASbGncuYOaivXB2OmKUkBtUY/LKKvlOSjNhK/yUt6uG0lQ77HZ5JU0D1wGXc23mlYfS
	wU9iqPBg0msHhO/nqlmh295z99TCUuPzoozACBauBIAhvr4/kYbSaSZzKgrrnRHc2bSDwukSXAU
	/56e80a3Egr36HtAG/TaNIuWWWED//ZQbjrpxE7NZDDfoS5nuaHIisyGQm2+rQf6ojAjUO/KviH
	HTwAABBsygST8z7vM6Bd6TsMATjr/M/lWYQPib1eDr8EbtfNbQ=
X-Google-Smtp-Source: AGHT+IFSD/C5Pgzh5HQjBRV7G7teMVdSdBbpcyANtZnO+FmwOuKajZ8dqcPU7mk3yIKKfNiQ/5sQQg==
X-Received: by 2002:a5d:6d8e:0:b0:37d:443b:7ca4 with SMTP id ffacd0b85a97d-38259ccb54fmr13944785f8f.14.1732543672512;
        Mon, 25 Nov 2024 06:07:52 -0800 (PST)
Received: from [10.0.0.4] ([37.174.249.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb2760asm10452456f8f.52.2024.11.25.06.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:07:52 -0800 (PST)
Message-ID: <f143792b-c107-4048-8c78-7fa06643ce40@gmail.com>
Date: Mon, 25 Nov 2024 15:07:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [sound?] BUG: sleeping function called from invalid
 context in vfree
To: Takashi Iwai <tiwai@suse.de>
Cc: syzbot <syzbot+351f8764833934c68836@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz,
 syzkaller-bugs@googlegroups.com, tiwai@suse.com
References: <6744737b.050a0220.1cc393.007e.GAE@google.com>
 <a8cdee9d-3673-48fa-890e-beed46c029c7@gmail.com>
 <874j3vzbbd.wl-tiwai@suse.de>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <874j3vzbbd.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/25/24 2:34 PM, Takashi Iwai wrote:
> On Mon, 25 Nov 2024 13:58:09 +0100,
> Eric Dumazet wrote:
>>
>> On 11/25/24 1:54 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=154bc778580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=47cc5fc1922531f
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=351f8764833934c68836
>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>> userspace arch: i386
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/dddd5525a287/vmlinux-9f16d5e6.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/7c9e082ba50b/bzImage-9f16d5e6.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+351f8764833934c68836@syzkaller.appspotmail.com
>>>
>>> BUG: sleeping function called from invalid context at mm/vmalloc.c:3359
>>> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6938, name: syz.1.230
>>> preempt_count: 1, expected: 0
>>> RCU nest depth: 0, expected: 0
>>> 2 locks held by syz.1.230/6938:
>>>    #0: ffff88804a2d2968 (&rmidi->open_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:201 [inline]
>>>    #0: ffff88804a2d2968 (&rmidi->open_mutex){+.+.}-{4:4}, at: snd_rawmidi_output_params+0x51/0x1c0 sound/core/rawmidi.c:748
>>>    #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
>>>    #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: class_spinlock_irq_constructor include/linux/spinlock.h:565 [inline]
>>>    #1: ffff888045e5ed48 (&substream->lock){....}-{3:3}, at: resize_runtime_buffer+0x243/0x530 sound/core/rawmidi.c:727
>>> irq event stamp: 1218
>>> hardirqs last  enabled at (1217): [<ffffffff8b189e32>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
>>> hardirqs last  enabled at (1217): [<ffffffff8b189e32>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
>>> hardirqs last disabled at (1218): [<ffffffff8b189ad5>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
>>> hardirqs last disabled at (1218): [<ffffffff8b189ad5>] _raw_spin_lock_irq+0x45/0x50 kernel/locking/spinlock.c:170
>>> softirqs last  enabled at (0): [<ffffffff814e57ac>] copy_process+0x1e9c/0x6f20 kernel/fork.c:2321
>>> softirqs last disabled at (0): [<0000000000000000>] 0x0
>>> Preemption disabled at:
>>> [<0000000000000000>] 0x0
>>> CPU: 1 UID: 0 PID: 6938 Comm: syz.1.230 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>>> Call Trace:
>>>    <TASK>
>>>    __dump_stack lib/dump_stack.c:94 [inline]
>>>    dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>>>    __might_resched+0x3c0/0x5e0 kernel/sched/core.c:8758
>>>    vfree+0x75/0x890 mm/vmalloc.c:3359
>>>    kvfree+0x33/0x50 mm/util.c:699
>>>    resize_runtime_buffer+0x3a7/0x530 sound/core/rawmidi.c:736
>>>    snd_rawmidi_output_params+0xeb/0x1c0 sound/core/rawmidi.c:751
>>>    snd_rawmidi_ioctl_params_compat sound/core/rawmidi_compat.c:37 [inline]
>>>    snd_rawmidi_ioctl_compat+0x3ac/0x3e0 sound/core/rawmidi_compat.c:120
>>>    __do_compat_sys_ioctl+0x1cb/0x2c0 fs/ioctl.c:1004
>>>    do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>>>    __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>>>    do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>>>    entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>>> RIP: 0023:0xf7f01579
>>> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
>>> RSP: 002b:00000000f506555c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
>>> RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00000000c0205710
>>> RDX: 0000000020000100 RSI: 0000000000000000 RDI: 0000000000000000
>>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
>>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>>    </TASK>
>>> ----------------
>>> Code disassembly (best guess), 2 bytes skipped:
>>>      0:	10 06                	adc    %al,(%rsi)
>>>      2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>>>      6:	10 07                	adc    %al,(%rdi)
>>>      8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>>>      c:	10 08                	adc    %cl,(%rax)
>>>      e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
>>>     1e:	00 51 52             	add    %dl,0x52(%rcx)
>>>     21:	55                   	push   %rbp
>>>     22:	89 e5                	mov    %esp,%ebp
>>>     24:	0f 34                	sysenter
>>>     26:	cd 80                	int    $0x80
>>> * 28:	5d                   	pop    %rbp <-- trapping instruction
>>>     29:	5a                   	pop    %rdx
>>>     2a:	59                   	pop    %rcx
>>>     2b:	c3                   	ret
>>>     2c:	90                   	nop
>>>     2d:	90                   	nop
>>>     2e:	90                   	nop
>>>     2f:	90                   	nop
>>>     30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>>>     37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>>>
>>>
>>> ---
>>> This report is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this issue. See:
>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>
>>> If the report is already addressed, let syzbot know by replying with:
>>> #syz fix: exact-commit-title
>>>
>>> If you want to overwrite report's subsystems, reply with:
>>> #syz set subsystems: new-subsystem
>>> (See the list of subsystem names on the web dashboard)
>>>
>>> If the report is a duplicate of another one, reply with:
>>> #syz dup: exact-subject-of-another-report
>>>
>>> If you want to undo deduplication, reply with:
>>> #syz undup
>>
>> Bug added in
>>
>> commit 84bb065b316e8367e14a8824a8f4d21056b10c53
>> Author: Takashi Iwai <tiwai@suse.de>
>> Date:   Tue Feb 27 09:52:51 2024 +0100
>>
>>    ALSA: rawmidi: Use guard() for locking
>>
>>    We can simplify the code gracefully with new guard() macro and co for
>>    automatic cleanup of locks.
>>
>>    There are a few remaining explicit mutex and spinlock calls, and those
>>    are the places where the temporary unlock/relocking happens -- which
>>    guard() doens't cover well yet.
>>
>>    Only the code refactoring, and no functional changes.
>>
>>    Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>    Link:https://lore.kernel.org/r/20240227085306.9764-10-tiwai@suse.de
>> <https://lore.kernel.org/r/20240227085306.9764-10-tiwai@suse.de>
> Hmm, through a quick glance, I don't see anything breaking there.
>
> Could you tell me which code path introduced the spinlock held during
> kvzalloc() call in resize_runtime_buffer() in sound/core/rawmidi.c by
> this commit...?


@@ -744,9 +724,8 @@ static int resize_runtime_buffer(struct 
snd_rawmidi_substream *substream,
          newbuf = kvzalloc(params->buffer_size, GFP_KERNEL);
          if (!newbuf)
              return -ENOMEM;
-        spin_lock_irq(&substream->lock);
+        guard(spinlock_irq)(&substream->lock);
          if (runtime->buffer_ref) {
-            spin_unlock_irq(&substream->lock);
              kvfree(newbuf);
              return -EBUSY;
          }
@@ -754,7 +733,6 @@ static int resize_runtime_buffer(struct 
snd_rawmidi_substream *substream,
          runtime->buffer = newbuf;
          runtime->buffer_size = params->buffer_size;
          __reset_runtime_ptrs(runtime, is_input);
-        spin_unlock_irq(&substream->lock);
          kvfree(oldbuf);
      }
      runtime->avail_min = params->avail_min;


You can see that after your patch, kvfree() is called while

guard(spinlock_irq)(&substream->lock); is still holding the lock.



