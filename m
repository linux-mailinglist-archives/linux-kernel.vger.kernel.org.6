Return-Path: <linux-kernel+bounces-341880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D4F9887AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3071C2335B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C01C172C;
	Fri, 27 Sep 2024 14:57:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA11C0DED
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449046; cv=none; b=EjkSz4getzhT4mQOFM/JYdLzRg6z3LsKW0ouoOHPPtPynk5X3Bqu6OOmdScl+w1jp8GxMgHFrs681NWX4rlBpLH+IOPu4e5IZoehsRAVIH2Hh1/nPyFegfoDGgy7atrSuZNxgppxkIQmSo4/Xyzj4lU3rD9YvjPN23pllfwyToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449046; c=relaxed/simple;
	bh=aACLd1HVm5A3MbjVTv1ksxXh1Ym9nluxq3Z6+2dQyGU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TVeojXJgxxwtARjho1l54RVVVyvPpr4DP0sRtrFDI52RIAagHtA9VoEGs9dz0rx/JNRc/6+xCDvvf5NcT5kWnQqkj+TrwvdfrGm+5peByPP1Q7OYOc/cDfclNH6jvYRemP18nE9n27IqO8IwpHPjDl8svzjxxOUzoaBPrcR3ajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a342e872a7so18092895ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449044; x=1728053844;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xkgwMbQgM4PLhYy/OePrJC+8JN5fe1sloTLNJAWIP4=;
        b=VGrX3rRgqSiOnppnk1SjeuCY+mCx0XB92q763uXXslOxfl0mL0cD3sOLrFcXUTQB+5
         BMm90w9HPGTk+MsDMnT9wO8cXF9yDTVd6ag38m81KA4U8fsxVnLxMOtUGPdCoXrItwoE
         1I00UobATMPqu44hbM/vfJPhOkLI789kq6bEs2mwjRblZ2Y3sMMn626TQlGYgiZpx0nR
         jXk1DMoIzLZtdI/bByOBLY986csZrlsaBXC4SzU+UCFijHXaCFv4Fjs04deyrP0jK8g+
         EFflG4D/chezvkG/lxTRs6tLdiqm5OSVJ3PvH3TNlMgVaer5UMkxx8zYPm1i9bhLGZDu
         p+fg==
X-Forwarded-Encrypted: i=1; AJvYcCUfNZLBvrYNB6mpEPvGisOLwLlgcbOTr9plO67VwH7dD+rIn5tfBelWSS1w840BoW4WE34ZEmETzUQxAaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOoPFhu5lZCJ7h8k5MmlAEV8oCrMP4F2YA98LlK3S0UXpXlgF
	gEz8CvqzRrjho1ECrggRbaod1VCCd+inShoGsAM3SRo5bC6MysZ4P7V69lHanBGu3aG2lXlrKRR
	xh3ICjabnwidnZjgKgsnXsilqovkG+lwv9ZPkdKR+TZrKIZZjiJ+oAqc=
X-Google-Smtp-Source: AGHT+IEsT3GDTB54UWYXuubiasjTBrWxV41Ptm6OmBtZuzyDYm7HU+Djxnl5+1vvZTa2ZMIj5o2aBz4Cfaw0fQkRnFALKHWDUWJu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0a:b0:39f:36f3:1957 with SMTP id
 e9e14a558f8ab-3a345148113mr34247145ab.3.1727449044070; Fri, 27 Sep 2024
 07:57:24 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:57:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com>
Subject: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
From: syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>
To: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f07a80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86254f9e0a8f2c98
dashboard link: https://syzkaller.appspot.com/bug?extid=0ec1e96c2cdf5c0e512a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1be80941df60/disk-075dbe9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/494a9ac89c09/vmlinux-075dbe9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/919788d8c731/bzImage-075dbe9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com

audit: type=1400 audit(6022412112.141:243086): avc:  denied  { read } for  pid=2950 comm="syslogd" name="log" dev="sda1" ino=1915 scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:var_t tclass=lnk_file permissive=0
audit: type=1400 audit(6022412112.181:243087): avc:  denied  { read } for  pid=2950 comm="syslogd" name="log" dev="sda1" ino=1915 scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:var_t tclass=lnk_file permissive=0
==================================================================
BUG: KCSAN: assert: race in __block_task kernel/sched/sched.h:2770 [inline]
BUG: KCSAN: assert: race in dequeue_entities+0x6df/0x760 kernel/sched/fair.c:7177

race at unknown origin, with assert no writes to 0xffff888101764268 of 4 bytes by task 29 on cpu 1:
 __block_task kernel/sched/sched.h:2770 [inline]
 dequeue_entities+0x6df/0x760 kernel/sched/fair.c:7177
 pick_next_entity kernel/sched/fair.c:5627 [inline]
 pick_task_fair kernel/sched/fair.c:8856 [inline]
 pick_next_task_fair+0x7d/0x410 kernel/sched/fair.c:8876
 __pick_next_task kernel/sched/core.c:5955 [inline]
 pick_next_task kernel/sched/core.c:6477 [inline]
 __schedule+0x284/0x940 kernel/sched/core.c:6629
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x55/0xc0 kernel/sched/core.c:6767
 kauditd_thread+0x56b/0x650 kernel/audit.c:911
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 29 Comm: kauditd Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

