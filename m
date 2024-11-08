Return-Path: <linux-kernel+bounces-401483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3599C1B06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4516D1F21ECC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD51E2603;
	Fri,  8 Nov 2024 10:48:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99F47F69
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062887; cv=none; b=cb4b6E5Bkz6P8Qpg2atRyJlnRpCb8ZEdovV+Ev1X9DX6JH6kc/+j8TC+KY4VqfYwy6ie/JqAJhe+BfF2BGTSvCknBgJVfYL2qvBXGEVeFT25NmGHGVcWXQf7fCPvtzK+CyNdjhfGMYTfJ5bT8RjAh94ejkidQdm5/oKZcL5Sf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062887; c=relaxed/simple;
	bh=b9DNpMLoIz65YlHgSdusIQdcst1TS2eXU1PlRaG4HbQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OVbWmPeZVCawf5WK5xLgiPj3h6lTK4bS/r8Sc+nEiktxbBZVqCQubBPJ2GBGlvOCmuvGG78cBGm/NaBNefjF7S3dji3QpS1rEjKlVLUJgl/N6DkSsgub1JJTbCyZptugNJJrcFnxZKuaK114ev/4Xpr6KSIK9swTJKcDlxHs790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4e80ccd1bso20558975ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731062885; x=1731667685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1c8xbpEKzka0cWX5c+6XXXwgTM1LTTJqq/fbhUvsoKA=;
        b=gY+sc0nKYZxhX3GCT7unQY7lGMrIhysDzEDqjwzvimRd3TFepA1ELexlkl9RdGd2S7
         gt/+Bc2m6Dfac08aaoAIchaWgl6gIqiJrkS9srQ+9l8n2gV6jRtug+JBG3O4ZlFbHfyv
         EF2rWI9Q6zvhMcjpi3QVO70HiOOBkMH4zTK9L8lW7lPDKKazUAVvYuTdtHuVxIunLH9E
         wFBUtSSrc8y9istWF9cXci8OFunfbjKOe6bYh2X9vAqoazm5/d8XAG2Q3GNSfBbEhcsH
         1mNa8EArK/tVFB/FbX6Ve9hvavnT+c4+idOU+DM5gZGR6V/x0j30NZupMd8QQA2mZ4Om
         vZaA==
X-Forwarded-Encrypted: i=1; AJvYcCVxR7hqu7T9MORwcptbO7xYc6Gcoq2Dy/wxSsMJDs3BLj5OszC6RrX7DVeiC2vH/TulO5xmSNxQT6rVisQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qYq0g7gYCd32sYqtxAeWSKpac8ZcLIbz+cDjbn/Anes9V/8a
	5jsQ4d7RNc6//FHUVu76mJMABjYIepyZxAawjaBVml+AsTfb7FqFY6guaCNCzN/+EdrxneuLTJ6
	4IZryc//eTBla+elc+ynPzSu9zcKbQk7e5nRrLYAkjqWnMxYIidEzChI=
X-Google-Smtp-Source: AGHT+IE3+lQvIgmfzp1J8l4+JwHocd+AsqOm+3eY9Xnv/lb/SGsr2zm47QCJyZmYHx9E6A76+CYIwuoaZUdoIFCDWEWT6jK230su
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0f:b0:3a6:aa59:fffa with SMTP id
 e9e14a558f8ab-3a6f19cad30mr27471655ab.11.1731062884828; Fri, 08 Nov 2024
 02:48:04 -0800 (PST)
Date: Fri, 08 Nov 2024 02:48:04 -0800
In-Reply-To: <173106166139.2299330.8314210328501109966@GCRAZCDL0021.westus2.cloudapp.azure.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672dec64.050a0220.69fce.000f.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data_end (2)
From: syzbot <syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com>
To: crashfixer001@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ext4_write_inline_data_end

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:235!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5696 Comm: syz-executor.5 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:ext4_write_inline_data fs/ext4/inline.c:235 [inline]
RIP: 0010:ext4_write_inline_data_end+0xea2/0x1020 fs/ext4/inline.c:774
Code: 31 ff e8 e1 b8 37 ff 48 89 d8 48 25 ff 0f 00 00 74 70 e8 f1 b3 37 ff e9 12 f8 ff ff e8 e7 b3 37 ff 90 0f 0b e8 df b3 37 ff 90 <0f> 0b 48 8b 5c 24 18 48 89 df be 08 00 00 00 e8 ca 81 a1 ff 48 c1
RSP: 0018:ffffc90002fc7860 EFLAGS: 00010293
RAX: ffffffff825cffc1 RBX: 000000000000003c RCX: ffff88802841bc00
RDX: 0000000000000000 RSI: 000000000000003c RDI: 000000000000084c
RBP: ffffc90002fc7988 R08: ffffffff825cf51a R09: 1ffff1100aec7470
R10: dffffc0000000000 R11: ffffed100aec7471 R12: ffff888068c3885a
R13: 000000000000000c R14: 000000000000084c R15: 0000000000000ff4
FS:  00007f085c26f6c0(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020425000 CR3: 0000000054da0000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 generic_perform_write+0x4dd/0x6d0 mm/filemap.c:4069
 ext4_buffered_write_iter+0xc5/0x350 fs/ext4/file.c:299
 ext4_file_write_iter+0x1dd/0x1a20
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaed/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f085b47dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f085c26f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f085b5ac050 RCX: 00007f085b47dda9
RDX: 000000000208e24b RSI: 00000000200007c0 RDI: 0000000000000005
RBP: 00007f085b4ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f085b5ac050 R15: 00007ffd03c46858
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data fs/ext4/inline.c:235 [inline]
RIP: 0010:ext4_write_inline_data_end+0xea2/0x1020 fs/ext4/inline.c:774
Code: 31 ff e8 e1 b8 37 ff 48 89 d8 48 25 ff 0f 00 00 74 70 e8 f1 b3 37 ff e9 12 f8 ff ff e8 e7 b3 37 ff 90 0f 0b e8 df b3 37 ff 90 <0f> 0b 48 8b 5c 24 18 48 89 df be 08 00 00 00 e8 ca 81 a1 ff 48 c1
RSP: 0018:ffffc90002fc7860 EFLAGS: 00010293

RAX: ffffffff825cffc1 RBX: 000000000000003c RCX: ffff88802841bc00
RDX: 0000000000000000 RSI: 000000000000003c RDI: 000000000000084c
RBP: ffffc90002fc7988 R08: ffffffff825cf51a R09: 1ffff1100aec7470
R10: dffffc0000000000 R11: ffffed100aec7471 R12: ffff888068c3885a
R13: 000000000000000c R14: 000000000000084c R15: 0000000000000ff4
FS:  00007f085c26f6c0(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd3d57ab78 CR3: 0000000054da0000 CR4: 0000000000350ef0


Tested on:

commit:         906bd684 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176eee30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef3e3033284fe956
dashboard link: https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

