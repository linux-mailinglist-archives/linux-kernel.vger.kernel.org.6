Return-Path: <linux-kernel+bounces-340626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC5C9875FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33F91C24F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AD714AD2D;
	Thu, 26 Sep 2024 14:51:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93299146A7A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362286; cv=none; b=shIvAO44xsoCttxAWGEA7JhT9lNI/3+HG1/TyVWI5nbHGCGKBSikYHyUy+EKYdUJceWa2/sqfr2tWXpcdLAYqMIVNdxhNrnmnlPjoMzXCnYdaraoXsQgEeDIBRzPV48iukGT52Jw7MLHFxSSEzFFM7tvD9FnRPt87ZBF1Ot3R88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362286; c=relaxed/simple;
	bh=tfyLEcxwApaUw4J3qs9B/uHIRaFGr1MiOAr/a5jrMP4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R3orUPJuEIPmBtNb3gbhf5Fv7gLO68pgy3FQzXI3tvGRfSeWMwmpn1jNB9jhGdLHMhYwZev7b+61Tmewbi39ya0DiAdPFrdHG/MLaOF6avpnHe8OFeyGoSK+vSDhfDFndFWjMQJ9yy2ROh8ibMu0C85ALN/VvwkUIuGfyu+lQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aa499f938so168794039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362284; x=1727967084;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1HQ/Lfsohoktuql0HRG6JowL8qNEgFtC2kvN5vfDVU=;
        b=USTdgG2zT5lieplphz4AmyadzvmeUW6A2UBbyfZFYD8bKro4XapiPYxPDKJDYTTglq
         ksJ9P/a+QmO5YZ82okn44pN/b0MbyJANJyZ78c8xzZdADn5Yjp7dqPO+HjoIb4fdn9gu
         aiD6GIdUXCJDoUHnkGnJ1hQC+9UWLx05nbMLVn6eqMH7Ak5/SiLEQYiCCrF0niFX3Kv/
         sPcS4u3yUXDTdDf/+vV+y1dV9guQEEjJICr9ksM7rw9Esscahxzq1if5Ere7TWpqaiLc
         4qRvsyAdRytnwbWcQ4cbinYDLAoQLznjVnD9QUdB49BoASBCuysOUkgU7kRtGjRS1pNR
         YdGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvprPyo9chobCfazToNm5R3hOfdgbWPo9qYHq7gSYIT4szH1FvuHVEUllSE4kEHKJ64BivgEFMYsVFYL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8z5gDbrCevFJpfp0Z/RNUvhj5jOeexIAT9Z4x474U+JNCpzn
	SZnWe5hJOPVjWFqf3UoUNexOERoubd99Jvxv3UZeO0iwpwxOwd0l567QeF0kqUG1zho+JJZ2mJP
	5CsGcrztv2RZjuhjpGpPVFLHKX5Vaf28c6ON4P8n3ZKYtkfCYf9e7yHw=
X-Google-Smtp-Source: AGHT+IE5q8iTzvKiO24R57q2O7GmO1h/ZNs41BSE8SMYpnLA8b3W75tM6glYDROpVifs1zn3q78v+3IXimthoVSSuXThGBoF/eU+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d91:b0:3a1:f6ac:621e with SMTP id
 e9e14a558f8ab-3a344607de1mr646225ab.7.1727362283749; Thu, 26 Sep 2024
 07:51:23 -0700 (PDT)
Date: Thu, 26 Sep 2024 07:51:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f574eb.050a0220.211276.0076.GAE@google.com>
Subject: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference
 in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16084107980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba9c4620d9519d1f
dashboard link: https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11084107980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a0d880580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-88264981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e96d7b6835d2/vmlinux-88264981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e1e66778641/Image-88264981.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 52-bit VAs, pgdp=00000000462cce00
[0000000000000000] pgd=080000004468e003, p4d=08000000466cc003, pud=0800000046cd6003, pmd=0000000000000000
Internal error: Oops: 0000000086000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 3265 Comm: syz-executor218 Tainted: G    B              6.11.0-syzkaller-08481-g88264981f208 #0
Tainted: [B]=BAD_PAGE
Hardware name: linux,dummy-virt (DT)
pstate: 61400809 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=-c)
pc : 0x0
lr : filemap_read_folio+0x44/0xf4 mm/filemap.c:2363
sp : ffff800088e6bac0
x29: ffff800088e6bac0 x28: f1f000000474e000 x27: 0000000020ffd000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000002100cca
x23: f6f0000006cd5c00 x22: 0000000000000000 x21: f6f0000006cd5c00
x20: 0000000000000000 x19: ffffc1ffc02e3300 x18: ffff800088e6bc20
x17: ffff8000804fee60 x16: ffff80008052fe10 x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000003 x12: 00000000000706a3
x11: 0000000000000001 x10: ffff800081f19060 x9 : 0000000000000000
x8 : fff07ffffd1f0000 x7 : fff000007f8e9d60 x6 : 0000000000000002
x5 : ffffc1ffc02e3300 x4 : 0000000000000000 x3 : faf0000005491240
x2 : 0000000000000000 x1 : ffffc1ffc02e3300 x0 : f6f0000006cd5c00
Call trace:
 0x0
 do_read_cache_folio+0x18c/0x29c mm/filemap.c:3821
 read_cache_folio+0x14/0x20 mm/filemap.c:3853
 freader_get_folio+0x1a8/0x1f8 lib/buildid.c:72
 freader_fetch+0x44/0x164 lib/buildid.c:115
 __build_id_parse.isra.0+0x98/0x2a8 lib/buildid.c:300
 build_id_parse+0x18/0x24 lib/buildid.c:354
 do_procmap_query+0x670/0x7a0 fs/proc/task_mmu.c:534
 procfs_procmap_ioctl+0x2c/0x44 fs/proc/task_mmu.c:613
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: ???????? ???????? ???????? ???????? (????????) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

