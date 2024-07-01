Return-Path: <linux-kernel+bounces-236118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FE591DDB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB4828175E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCD913C80C;
	Mon,  1 Jul 2024 11:18:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03A1F949
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832685; cv=none; b=BQpY5pAb1HCikcRVs/aLYvReP4pmjIoYl2odqC6f9JnUwsTS3LUdaVU9R0Ny20a/t5Dr3tx24ivsaFmQwo/weUyVGtcOM40qa9cWtLZjJOSjHUay0vgPD7l/Xx6MhuSWd9JIBiJsLIeoAafSe2pI/YxZhXy4MKQJBdhHcbEjWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832685; c=relaxed/simple;
	bh=sf0XJgNAuYyvLV29l49pAvpMJtSBdE9peCvHsigBqFg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oSQXXMeayqXIF9T+iGo06VUegOzBXrkZoa5vTCfREGBp5B6MHuFAS52Gx1wckNgliDM0OXseUux8Nyuv4JPt/8/wfyQoKsMzBCID58PbEf34jwvqfhfl8IzxoLcSXRmRLLns36pHUZG0qJQmX7VpOT92321OTNuIU6WsRclnj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so331615139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 04:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719832683; x=1720437483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wvpIdgxYSXGuAqzXpcLZKSmmqf2V+G35PjLuw0pwKA=;
        b=Fh2nxUtQcS1gyGgCXHNeyAacDypuxRIjXmvvZ0FlIiPnTWWiZS3BrWpAzU6xyZlLqX
         vK1781R/F1e7hDlFFwR7uIWuc4dL/mptdYSgc+gw5ElbZjf3EOUbcvPv6tPlePblrd44
         jofqCC9MKtTr1sbVWieQcvYup+/BRZZ9GweEobwRsG6IbQI7onTkza3U/u8LA4FH+8qW
         BX+uQkVuxIW6W62W8RAbafb8MVfnlq0Dl638UqsC4PwJau6LxEfkcrmRd7DAW8Vbvwtf
         2/d7ONUDwdAxS0V+qn3VTyiU2BCMBdZMZTpe+ayjMUm0ajUoMPb4VvxFvS3QyQFFB6iK
         +IvQ==
X-Gm-Message-State: AOJu0YxsEk9nZcmfldg6AJfVxPo8UrPDuxUGZmBWhYSVXk54KMhGoIpU
	o/uzeJRs10E3kF5nX/jElMDPX5z0nMcqsU0sgqb305TrOfgytzuI90knRl220ra9+Dyx0KlObpE
	g57fyynrt8yW6a6A2Rv811eq27hW4Nccsbxkx3Z4iHVafpF0WvElhBFk=
X-Google-Smtp-Source: AGHT+IFaZWMkyaaknsQ6RtImcN+M1HhNiiWYwm/e+pnCtxcVX6yHll9S0bUtofdkSzdRcQQ2zA8Z2gSPHQ26Odi6ytfh/mXu/X98
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8726:b0:4b9:6c10:36cc with SMTP id
 8926c6da1cb9f-4bbb6b7ad4emr458917173.1.1719832683203; Mon, 01 Jul 2024
 04:18:03 -0700 (PDT)
Date: Mon, 01 Jul 2024 04:18:03 -0700
In-Reply-To: <20240701083435.19182-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027e35a061c2dc035@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in __block_commit_write
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in __block_commit_write

Unable to handle kernel paging request at virtual address dfff800000000004
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000004] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 13196 Comm: syz-executor.2 Not tainted 6.10.0-rc5-syzkaller-00071-g8fcad59bb267 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __block_commit_write+0x64/0x2b0 fs/buffer.c:2190
lr : __block_commit_write+0x3c/0x2b0 fs/buffer.c:2183
sp : ffff800098a87600
x29: ffff800098a87610 x28: dfff800000000000 x27: ffff0000df462ab0
x26: 0000000000000000 x25: dfff800000000000 x24: dfff800000000000
x23: fffffdffc3a94620 x22: 0000000000000020 x21: 0000000000000020
x20: 0000000000000040 x19: fffffdffc3a94600 x18: ffff800098a06dc0
x17: 0000000000022b0f x16: ffff80008aefdd0c x15: 00000000200000c0
x14: 1fffe0001d4a3004 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000004 x7 : 0000000000000000 x6 : 0000000000000000
x5 : fffffdffc3a94600 x4 : 0000000000000020 x3 : 0000000000000020
x2 : 0000000000000040 x1 : 0000000000000020 x0 : fffffdffc3a94600
Call trace:
 __block_commit_write+0x64/0x2b0 fs/buffer.c:2190
 block_write_end+0xb4/0x104 fs/buffer.c:2276
 ext4_da_do_write_end fs/ext4/inode.c:2952 [inline]
 ext4_da_write_end+0x2bc/0xa34 fs/ext4/inode.c:3025
 generic_perform_write+0x394/0x588 mm/filemap.c:4026
 ext4_buffered_write_iter+0x2c0/0x4ec fs/ext4/file.c:299
 ext4_file_write_iter+0x188/0x1780
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x828/0xc78 fs/read_write.c:590
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 97f851e1 f94002da 91008356 d343fec8 (38796908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97f851e1 	bl	0xffffffffffe14784
   4:	f94002da 	ldr	x26, [x22]
   8:	91008356 	add	x22, x26, #0x20
   c:	d343fec8 	lsr	x8, x22, #3
* 10:	38796908 	ldrb	w8, [x8, x25] <-- trapping instruction


Tested on:

commit:         8fcad59b Merge remote-tracking branch 'tglx/devmsi-arm..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=157b91c6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d259bfe15c04340f
dashboard link: https://syzkaller.appspot.com/bug?extid=18df508cf00a0598d9a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.

