Return-Path: <linux-kernel+bounces-365491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC58399E31E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF921C20B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A4818B488;
	Tue, 15 Oct 2024 09:51:59 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E90189F56
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985918; cv=none; b=nQ9PUeDPG6Ui7B7+uNXT2ipcJbN5odnMLrl7RKm2NSn/PoiDKQKyb91c0zsj+FHnrXU3gkny+kJcSYGdNvBntMw3N+bsAkGTeWrnon/LImEwN1tcdI1TZ4zTd3/SLdCp6yHW+A8R8sltBbaudMPcjwbmhFE5dDj7Hvm1Jv/1YZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985918; c=relaxed/simple;
	bh=8j4VIooJSFQlsLyJcWmOx1rrMUx+TFhzyorZTnbp5Jo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=lHoLIIhzRuZ4pSswkAcinbfHdRpRaTL7FsWLx9rE3v+mEP7aItc3Jrqzr0FmEl47FVN0JCLHRVzlmAAHzSLpUry5VBR9yBciZEwAhogQpdIt/eZ7v2Fh7Qh601oYNqOafpD0xwemgVEp79f8GdTizOejgIeqhdu4Y8p29VIYZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso24627555ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985916; x=1729590716;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5P8uQa24zOt0GgqE3kZzSCatklpuy5iTrRt7AcpSmis=;
        b=pnNBF0Ye4mCicHse8P2iv5vaZ8jEtJLCF57ego1luvTopihBWKAFmvLEe1/Uv37mvJ
         9JpRoEHOvDAu/eXIwCdrGRQB2rWfV+EQOfOKSFEM08xwU9TnmxEC9LYxvngtH85zik6h
         4F+0RzXZHS7vrcjVe1hvAz/FNZCr6fS+LSP2qQNYsXf8olmNLCFkg9HcsJ89alHG46dT
         ATbLkpwlZlcJxJgVd3JaAMrFHYBEK7hGHRq5Co+urDqNK5Czo/D+7lENdf5rtDgWed0q
         2S1w+LdyBbge7crAQbTIeeJIzkWMtOR34zliMHTd6IIk01vEJTSyuSP4Tr4QEV+PU80j
         +nhA==
X-Forwarded-Encrypted: i=1; AJvYcCXol+f/6chlL9Sa9msdMxpetK/ak3gxlZFn3zMaJwJ1TWN6ob8UbTi0h192JdmwUH1zrBic8+VzXOTQkVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJqVDj4g71P33NWPDvN8AflFkKqCnJYlg+8ovu9Y70qeYKNEE1
	VFtglYZYietJ3PD23ooNHVkU/s/E54t9OsFHiincldiZwD6JUPRpW3By2hKHEhpJsEdLKHjwt0X
	m1N/N9pzhG+4nHZf6YGFrpwq3g5neEPl8hePh53eqUakR3xNqI9izSMk=
X-Google-Smtp-Source: AGHT+IHVz1lGdLDzqNcEBCm2KwsOfXWv4YlJ7NxIl0tE2nYueZflDqTAhtW0feSPfawuKl9F/21L3M8XGE2PGtt8ICRRC5qLRI4d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3a3:983a:872f with SMTP id
 e9e14a558f8ab-3a3b5fce83bmr121966165ab.24.1728985916146; Tue, 15 Oct 2024
 02:51:56 -0700 (PDT)
Date: Tue, 15 Oct 2024 02:51:56 -0700
In-Reply-To: <e0861721-f32b-4d55-b653-0e60e7a4fc3a@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e3b3c.050a0220.f16b.000a.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in folio_walk_start
From: syzbot <syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On 14.10.24 17:01, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    36c254515dc6 Merge tag 'powerpc-6.12-4' of git://git.kerne..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14edfb27980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=667b897270c8ae6
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7d917f67c05066cec295
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/62cbb10fcb60/disk-36c25451.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/d63f77e475bd/vmlinux-36c25451.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/113b44f45a57/bzImage-36c25451.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com
>> 
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 7022 at mm/pagewalk.c:815 folio_walk_start+0xef6/0x1160 mm/pagewalk.c:815
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 7022 Comm: syz.3.435 Not tainted 6.12.0-rc2-syzkaller-00307-g36c254515dc6 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>> RIP: 0010:folio_walk_start+0xef6/0x1160 mm/pagewalk.c:815
>> Code: 90 0f 0b 90 49 81 ee 00 f0 ff 3f e9 1d f4 ff ff e8 8f b8 b1 ff 48 8b 7c 24 18 e8 85 9c 3a 09 e9 be f3 ff ff e8 7b b8 b1 ff 90 <0f> 0b 90 e9 22 f5 ff ff e8 6d b8 b1 ff 31 ff 89 ee e8 a4 ba b1 ff
>> RSP: 0018:ffffc900096bfc80 EFLAGS: 00010287
>> RAX: 0000000000004c5c RBX: ffff88807bc61c98 RCX: ffffc9000a2ba000
>> RDX: 0000000000040000 RSI: ffffffff81db0095 RDI: 0000000000000007
>> RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
>> R10: 0000000000000080 R11: 0000000000000000 R12: fff00000001fffff
>> R13: ffffc900096bfe28 R14: 0000000000000080 R15: ffff88802f484000
>> FS:  00007f53545676c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000110c321de8 CR3: 0000000047274000 CR4: 00000000003526f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   add_folio_for_migration mm/migrate.c:2244 [inline]
>>   do_pages_move mm/migrate.c:2346 [inline]
>>   kernel_move_pages+0x619/0x15a0 mm/migrate.c:2553
>>   __do_sys_move_pages mm/migrate.c:2567 [inline]
>>   __se_sys_move_pages mm/migrate.c:2562 [inline]
>>   __x64_sys_move_pages+0xe0/0x1c0 mm/migrate.c:2562
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f535377dff9
>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f5354567038 EFLAGS: 00000246 ORIG_RAX: 0000000000000117
>> RAX: ffffffffffffffda RBX: 00007f5353936058 RCX: 00007f535377dff9
>> RDX: 0000000020001100 RSI: 00000000000000d0 RDI: 0000000000000000
>> RBP: 00007f53537f0296 R08: 0000000000000000 R09: 0000000000000002
>> R10: 0000000020001140 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000000000 R14: 00007f5353936058 R15: 00007ffec6628d18
>>   </TASK>
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> 
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>> 
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>> 
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>> 
>> If you want to undo deduplication, reply with:
>> #syz undup
>> 
>
> I suspect this won't work as there is no reproducer:
>
> #syz test git@github.com:davidhildenbrand/linux.git foliowalk_leaf

This crash does not have a reproducer. I cannot test it.

>
> -- 
> Cheers,
>
> David / dhildenb
>

