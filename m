Return-Path: <linux-kernel+bounces-311380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BC96885A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5A21F23581
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C4EBE;
	Mon,  2 Sep 2024 13:04:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2E19E960
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282244; cv=none; b=PIx7nfHqCi3EmYQIeRbfZSNrxRmWs72pSSrj6LNP0g1ZVZZXm+4jkB+97sMUCNb/LMGJFnuWrmXB/VS8+a47oG1+qGLUu0LLQodB41suDHymNvKuYVNkbufIF3+SBAR3fCdUWQzw2L9hmCDsgGPklUuDMLtPxL3wJ4lb7Q5yTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282244; c=relaxed/simple;
	bh=SQHdW4Wmnhx1Pkddm5eHI2aC3VYYpLuuBnH/uWmZX+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bWeOmE2Whl9wvedE4aUwt96N9ng+c2JRUCXCIdGTvdKE35aTjra4zU2M+Y0+/RQ/36Tup9H2k/T7QNuOv1mOB5R9Aqa7NZTVWHLJHxUldYwAvK6NtjjE1rJ9v02O2635swTBq4y1d4gkN5M9zKp8huQLvr7xRhQpW6oZ/cnQ7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a55adf8dcso55122439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282242; x=1725887042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bue8A52Rb1Spld87wBKNiH8+EwvcjhnIQjqag2yX21w=;
        b=Xrg1iBJP7AIQoe+1b8t+6aBANgIbpTdYvG8/ZGhYst0ZNKbQugSBJzbYRaEYO+IIJj
         Iap5rTVIaRqC9i9Y6N23IKHisvIK5gDFBd8X4L+kc8t60XjatSH1v2/2Tv4TlSxNo/06
         NSy3dHxeuB4zuuAXPUEkek7D84Haq7bLlRM45csKCa8q7GFEMOPLKeRRx4KVBmDhC+d5
         W4jYScAtP6iD22NRigGFBAd/TNQ2A0BtZsiPXEXYmyiDtcWHClRgEyZlsiHWbpLGkwHh
         gHmfNPmvRyRm7wZjaI471YMHFqdY05eOLLYiUeS6Oh7qHL4As6QAXew3yBakN1/t+Sp5
         1/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMdMgwn7uY7BlgajSXxDsSNrVAhH76xN6kKoYql5sSEDkwqsyRqVxiChsqCwdpL753FJfrZql9CuNJNzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxM7cNnxbH5fNiPjkN4VwD6rU0FVom4/N9jhp3uOrYqKyXxMab
	QisfQnxD7MJZLs5O+xF126uBTwftdyhU0FumrK/K5M9VhF4EMiVix4rOD6jkzYfzfaqgDZ3g/Rv
	7SZAN/RaIUt/+KqD4M91qbIJzuohj/9UKCCfBm846GwexZG0DYTOXGGY=
X-Google-Smtp-Source: AGHT+IECDZWD8U1H+rUh1L1muXCg3i7xfH1F5z60wSt2byjp4j0y/GTv37ZT94Nufi1xhOLt2YIlyClJUAMiZX6u7UTouFsZfFQZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:39b:2133:8ee5 with SMTP id
 e9e14a558f8ab-39f40ed447cmr5686515ab.1.1725282242406; Mon, 02 Sep 2024
 06:04:02 -0700 (PDT)
Date: Mon, 02 Sep 2024 06:04:02 -0700
In-Reply-To: <20240902124358.6201-1-almaz.alexandrovich@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000323e8d06212293a7@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in vprintk_emit
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: stack is corrupted in vprintk_emit

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (1024) and media sector size (512).
ntfs3: loop0: Failed to load $UpCase (-22).
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: vprintk_emit+0x764/0x770
CPU: 0 UID: 0 PID: 6409 Comm: syz.0.233 Not tainted 6.11.0-rc1-syzkaller-00016-g7529036a025a-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 panic+0x349/0x860 kernel/panic.c:348
 __stack_chk_fail+0x15/0x20 kernel/panic.c:821
 vprintk_emit+0x764/0x770
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 ntfs_printk+0x3ad/0x420 fs/ntfs3/super.c:93
 ntfs_fill_super+0x2eb8/0x4730
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcc9577b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcc96519e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fcc96519ef0 RCX: 00007fcc9577b0ba
RDX: 000000002001f800 RSI: 000000002001f840 RDI: 00007fcc96519eb0
RBP: 000000002001f800 R08: 00007fcc96519ef0 R09: 0000000000000801
R10: 0000000000000801 R11: 0000000000000246 R12: 000000002001f840
R13: 00007fcc96519eb0 R14: 000000000001f829 R15: 0000000020000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11819b0b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0cca2f3880513d
dashboard link: https://syzkaller.appspot.com/bug?extid=4d2aaeff9eb5a2cfec70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a2ce0b980000


