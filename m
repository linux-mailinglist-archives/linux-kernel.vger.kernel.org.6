Return-Path: <linux-kernel+bounces-282083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D0E94DF88
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187D11C20A89
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7497C156;
	Sun, 11 Aug 2024 02:16:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B4F8F48
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723342583; cv=none; b=Gkg2vLvaOjDM+I70a1R77Ee90pMEFvT/uy7/Z3aJ7e7ATmEjckgBlme9vWn+AIy2h0yvQSXrPqUX+RTCyMy98m1IbeL3I/Pyo47tAU+uSPfoxUxFrzE/y3FiAGGubBjemNSiMlUdcKz/6+z1vwCGUH7UVQjHjEulo1CBNiskOwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723342583; c=relaxed/simple;
	bh=jLHclSGFHdYmaYVg1qTSRRtdACzAngEvV0TI+fQS98U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sA09mN5smt7VDssh3nFQVTVKlVZgv4BY5sFJRD1KwZrBREQOudxxlStyjcI/v/3C+MFIeCoaOFh3YTP7gzUHX0ddiiwWGh5seLkF1pdlKB0aFfsYtuVxkOb4sFJ10B0ss5adkB+l3K5a/iYga6w5/lP3pL09Wi5JqeH1TlIbWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81faf98703eso434927139f.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 19:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723342581; x=1723947381;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsKAC2w8OIj8E2V22o2IjRuSBUakLf2Sx3QWeN5iaxE=;
        b=hHtjxM0htksVlExvz57V3t65KvAmgflWX/j1KPtJW/zNkyE6eY3rGl7scog6tzTapQ
         tbEgdk1tLw7BPtZOcn29QJSA7rpkVypyZzKUfGhGZB5H0bcrl2llZ5Cp9LGljZoL2wo0
         wNfiW6hu0N22qo0h9NESKVwYxxIbP3ol4pg67OJpfMmV1RtG4omNFhq1pDBtmwJwjFja
         nV+5UjoZiL8LskoWOar83i7b7T6YugXwu0YF8Hl9tqboLlBv5Mx25866XN1pPsfMsSMX
         umG+sGMaCpi8QMBZn+llCA+L0t9k6pnozzlURAODyyx2a63LPc5Jr0k4zrdAEgqfxnUV
         9v1g==
X-Forwarded-Encrypted: i=1; AJvYcCVXS8EzmJDYzmEc+pU/vEfCehr8L703LMd7csj5WsMlLyikxOBU9C/Yz6KKDwMrSh2hRZWTL0Wtwlap2TJ4orE8rnYZ6GVKIP5VSWWy
X-Gm-Message-State: AOJu0YyzB7+ffiWmG+tLjUHgCNryMt1oagLiR0qOFbFe+hHvmT0hfPaC
	bZKRLv3pJrgMIEnAgMCRJQ+XEchhRUqdCiX7SHZwbMC9xqEECksBVRM7NamoGfGsy3zcc8hYC94
	3SDrnHg+Qq9sondNef7sa/GNTHblvxgBwBPJN7UEego1cAeRwMIbDylE=
X-Google-Smtp-Source: AGHT+IGpR5OwATLInzqEwF5W5qNe9mvZBRGoTkNxRNNJqDDfxDORIbmTqQL2eKomEF4w7lml2Wa3LrJmR+KLE35arAnW0IfHzjUD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:398:d1fe:9868 with SMTP id
 e9e14a558f8ab-39b7a75252dmr4874335ab.4.1723342580929; Sat, 10 Aug 2024
 19:16:20 -0700 (PDT)
Date: Sat, 10 Aug 2024 19:16:20 -0700
In-Reply-To: <0000000000006fc563061cbc7f9c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005cea8e061f5ef6da@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindBits
From: syzbot <syzbot+e38d703eeb410b17b473@syzkaller.appspotmail.com>
To: andrew.kanner@gmail.com, ghandatmanas@gmail.com, 
	jfs-discussion@lists.sourceforge.net, juntong.deng@outlook.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	osmtendev@gmail.com, rbrasga@uci.edu, shaggy@kernel.org, 
	skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    34ac1e82e5a7 Merge tag '6.11-rc2-smb3-client-fixes' of git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15f035d9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=e38d703eeb410b17b473
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161cc96d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f899d9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c13802fbda4/disk-34ac1e82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74423353023b/vmlinux-34ac1e82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61da8b25f42a/bzImage-34ac1e82.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/4d2d380a51d6/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/53f5a740bbef/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e38d703eeb410b17b473@syzkaller.appspotmail.com

ERROR: (device loop0): remounting filesystem as read-only
jfs_rename: dtInsert returned -EIO
ERROR: (device loop0): dbAllocBits: leaf page corrupt
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:3025:47
shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 0 UID: 0 PID: 5213 Comm: syz-executor267 Not tainted 6.11.0-rc2-syzkaller-00239-g34ac1e82e5a7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 dbFindBits+0x11a/0x1d0 fs/jfs/jfs_dmap.c:3025
 dbAllocDmapLev+0x1e9/0x4a0 fs/jfs/jfs_dmap.c:1985
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1825
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1364
 dbDiscardAG+0x352/0xa20 fs/jfs/jfs_dmap.c:1613
 jfs_ioc_trim+0x433/0x670 fs/jfs/jfs_discard.c:100
 jfs_ioctl+0x2d0/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbb2632d059
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe933950b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbb26376095 RCX: 00007fbb2632d059
RDX: 0000000020000080 RSI: 00000000c0185879 RDI: 0000000000000006
RBP: 00007fbb263a85f0 R08: 000055555ee264c0 R09: 000055555ee264c0
R10: 000055555ee264c0 R11: 0000000000000246 R12: 00007ffe933950e0
R13: 00007ffe93395308 R14: 431bde82d7b634db R15: 00007fbb2637603b
 </TASK>
---[ end trace ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

