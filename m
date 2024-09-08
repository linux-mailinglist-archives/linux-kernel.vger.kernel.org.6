Return-Path: <linux-kernel+bounces-320076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C652B9705E1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804EE282829
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D68130E27;
	Sun,  8 Sep 2024 08:52:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951FD4204E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725785524; cv=none; b=WzR1UhWIuTbQr1M+6qokhD5cwNofKZltCEsVYflMBPPMpL9A4UaC9V8q9lanOF066ehDVeqS890YXGuwgSjmTBQC+GcQOY3WnRJifRD68uJWVAZBw0a1L7S5SydxTSDrTZopk2ptMGeXU95IdODm+/wd02xTvP6XWISj0KGOQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725785524; c=relaxed/simple;
	bh=iNsomBAtPoQ2CE1aQYFZLUkPVc55iwv21qD1pB2CNic=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=El9ndbtZ+IVJnJOhKXtLRG1naMbR+Ov8l9aEiwW1HViH1Hl6/6JlaXxSaoOcLV3TIT8PmPGvxZ9dAYDb4QmLBT9wrL75OGMyB+8YZK32cLG/1z1JI+e9x8+IrzKyPiJCMoOmL45cRLh35Yrb0ACo+O+CXFZ4TrotCAFpWDwanXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04eef8ed2so36218365ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 01:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725785522; x=1726390322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDbOddmKpKC9TBwYDpqg6lQLfuqHsGkeE0Rn3FG9cRQ=;
        b=VwmQwt7XfkOODH8EhxSbsbL6sPAe44hZvR3K91mBVoj9PZEwSZioZJc7Jmqb5Fo7Yu
         X2CJj1CH401cIO/uViZREXaiVQH74QSQ0ui7DyPF2LZYsfcRqnz3GYx1kLah8Ielgo4Q
         22fV40W3PCbNjgoQVy5ij6E5gjVBVM4s/ZJE87PEw349rIhxpVShWScKbhO8LNvq/fag
         V/acezYwCftcDxJov/Ezx4UUkKFlfPWVKh9mLnR7+YcMGWwPGpFG2F+6+6KJTjMdP+cj
         uNsmx8RTmTVDfVLgORzmGXkv8cUodgihTYMErt0hfnkhwGjUXATjcIQooWC3C2HJRgPS
         0E1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5DAUY5d0kew/NG9kvu8iwGj/4hQAo354L5/DHlE4Nii/65oeE9oHkS3XVMibRGYvR2FrqaEtOq57Cmjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw52JUb+PNF1m0HmLWfSmOoyiHL51u1HOnbfs1NiduMVebecVG
	P0NKuytGkLxFQFkO2E9iafbFqw4SdJo8g8NOGIoWJB1GACMgEbzlVJBjRA2q81D99DHhxiFbi0T
	qN3e4GmbbkoFVvqtbTuNNgMt8GOdu+vsfNffq1n4QhfJanOuYLSwPJu0=
X-Google-Smtp-Source: AGHT+IE8z9ufBCPCMGsCQAfM0P4u6ZLa03mk5SBCcpuLE33vn/ZdXcEwNvPmUL6M+a/Z2o0bVVlMsg9wVtOT2zNk7ZKrnBhVyJQ+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2c:b0:398:36c0:7968 with SMTP id
 e9e14a558f8ab-3a04f0758camr94040205ab.6.1725785521695; Sun, 08 Sep 2024
 01:52:01 -0700 (PDT)
Date: Sun, 08 Sep 2024 01:52:01 -0700
In-Reply-To: <20240908083246.2329-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fac115062197c099@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in hci_send_acl

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 UID: 0 PID: 7269 Comm: kworker/u9:8 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci2 hci_rx_work
RIP: 0010:hci_send_acl+0x35/0xd30 net/bluetooth/hci_core.c:3230
Code: 41 55 41 54 55 49 8d 6f 18 53 48 89 f3 48 83 ec 70 89 14 24 e8 1c 18 83 f7 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 bc 0b 00 00 49 8b 47 18 48 8d b8 e0 0f 00 00 48
RSP: 0018:ffffc9000ae676e0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888030adc500 RCX: ffffffff8a1303d4
RDX: 0000000000000003 RSI: ffffffff8a08b834 RDI: 0000000000000000
RBP: 0000000000000018 R08: 0000000000000001 R09: 0000000000000080
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888011da0000
R13: 0000000000000002 R14: ffffc9000ae67880 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 00000000781ba000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 l2cap_send_cmd+0x6e5/0x920 net/bluetooth/l2cap_core.c:973
 l2cap_connect.constprop.0+0x6f7/0x1270 net/bluetooth/l2cap_core.c:4038
 l2cap_connect_req net/bluetooth/l2cap_core.c:4084 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4776 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5547 [inline]
 l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6829
 l2cap_recv_acldata+0xd58/0xfd0 net/bluetooth/l2cap_core.c:7528
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hci_send_acl+0x35/0xd30 net/bluetooth/hci_core.c:3230
Code: 41 55 41 54 55 49 8d 6f 18 53 48 89 f3 48 83 ec 70 89 14 24 e8 1c 18 83 f7 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 bc 0b 00 00 49 8b 47 18 48 8d b8 e0 0f 00 00 48
RSP: 0018:ffffc9000ae676e0 EFLAGS: 00010206

RAX: dffffc0000000000 RBX: ffff888030adc500 RCX: ffffffff8a1303d4
RDX: 0000000000000003 RSI: ffffffff8a08b834 RDI: 0000000000000000
RBP: 0000000000000018 R08: 0000000000000001 R09: 0000000000000080
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888011da0000
R13: 0000000000000002 R14: ffffc9000ae67880 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 00000000781ba000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	41 55                	push   %r13
   2:	41 54                	push   %r12
   4:	55                   	push   %rbp
   5:	49 8d 6f 18          	lea    0x18(%r15),%rbp
   9:	53                   	push   %rbx
   a:	48 89 f3             	mov    %rsi,%rbx
   d:	48 83 ec 70          	sub    $0x70,%rsp
  11:	89 14 24             	mov    %edx,(%rsp)
  14:	e8 1c 18 83 f7       	call   0xf7831835
  19:	48 89 ea             	mov    %rbp,%rdx
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 bc 0b 00 00    	jne    0xbf0
  34:	49 8b 47 18          	mov    0x18(%r15),%rax
  38:	48 8d b8 e0 0f 00 00 	lea    0xfe0(%rax),%rdi
  3f:	48                   	rex.W


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f51ffb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11651ffb980000


