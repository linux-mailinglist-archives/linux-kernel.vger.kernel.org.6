Return-Path: <linux-kernel+bounces-259169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B769B93921D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9741C214E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6616E885;
	Mon, 22 Jul 2024 15:54:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27578134B6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663645; cv=none; b=IKO+wFnZLMHpC4kO6XYojKDbG8Z2Bu/SApx0Jq1zRByMZZCECjstXZ9idHD8A8tFCqQy0BpfNTMpID1+nqEclY0wm8qqSPWqkshwCd0z77AI5Gzp91EdUhpR2F5GLacsHrWro/AyjD6kwvhZZdCIz0If7pwNCwQmlbT+VOkrzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663645; c=relaxed/simple;
	bh=1Px4gjC/8bOhMEbBhzL+oW+Dl4MoXb9qgqaJ4e45IlM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FImVqERJZkExkJVj2JE3kIyn3qtbek4K7cwqk3d4dbbsHq74lm2JW+xLI+DqeUeYBGd5NrWdmhLx5ktNooTA4WJ3j42cXxi3lgAjSBZWI3aU479LJ9zhde1HJpdyZwUrnvozTEjDH2Aw4s2lSVKPdeoJancd5DD8fDkIBJoSL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-396fa3fe46cso71490995ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721663643; x=1722268443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZGMAHMpAnxpyz0+jnKpFKBbxR6t9WPRCB26ey0RKqc=;
        b=B1c14GWP2QlAKBq4ArpcLU8gK80/lNyEdzatfEJhiN5zgvTu/Lat7TQnqZct3yKIuf
         E05Bn66nnr7yBbqvG7fHFyVLjBk3VFJZVVJYvMRKAb+nRmHdZE/PZT/00lRTSEo+rYRK
         1b5M3Fav6IAfhJBs8Z7AYfKEJmnpDYVVfqdg/iGAL995E0JizpPrd42Ta4+DeokssUuj
         5cNUj7kQvGno1AI0wvlAHwJM4DWu5crCjHc6TFHGyi7j45oeSZeh30DQ8dscLWFS+d8E
         9qV3d89YahcLHtDC+YAUfnh4w9LTyuXT56PAZMgU3opJ0FKgVlvnAo9oJRq5/p0FHXwy
         BaZw==
X-Forwarded-Encrypted: i=1; AJvYcCX7ezqw6BIJ+/v1RAT6ZR8K0a2BZX8HJpEOMysFNGGG3ZGs3EiwT3DscrYHcveJtrjC8MWM4Hl4a/vOtjSdvsaOnUoQHUkz/CyHIQOe
X-Gm-Message-State: AOJu0Ywrw027VRwZCM3VH6olPuN/ptX/ujR7ibZA3nIU0wusVgpAfj6g
	DUjmZHE3HTng06zgaqF6lHqBhs5GLd59Vj0mpTHGdcSBX3dLBG1JWt7Tf4FuIJ029d6rFia7pHr
	NCIx5qDCCP9TmwwkQbauw3nXc/lViV12rEOCtLxJJ90ab8KXvHchoghc=
X-Google-Smtp-Source: AGHT+IH3/PbexAApnNl9PKh9gH84p56Nfv0QTvGaKIW4Eb8VDKWycHZ1RVRgtDgYmeafB07xGDUeKuazCAXJcS/XtZiHAkW2QiVT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:397:ca8e:d377 with SMTP id
 e9e14a558f8ab-398e1995b09mr3466575ab.0.1721663643348; Mon, 22 Jul 2024
 08:54:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 08:54:03 -0700
In-Reply-To: <20240722144935.2611-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e28242061dd80dc5@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
From: syzbot <syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in bpf_net_ctx_get_all_used_flush_lists

BUG: unable to handle page fault for address: ffffe630188daf02
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1503a067 P4D 1503a067 PUD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 7523 Comm: syz-executor288 Not tainted 6.10.0-syzkaller-11840-g933069701c1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:bpf_net_ctx_get_all_used_flush_lists+0x16b/0x390 include/linux/filter.h:846
Code: e6 08 31 ff e8 f6 c8 29 f8 4c 89 f8 48 83 e0 08 75 07 e8 08 c4 29 f8 eb 56 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 47 0f 91 f8 48 8b 03 48 39 d8 74 2a
RSP: 0000:ffffc90000007a28 EFLAGS: 00010a02
RAX: 1fffea30188daf02 RBX: ffff5180c46d7810 RCX: dffffc0000000000
RDX: 0000000080000100 RSI: 0000000000000008 RDI: 0000000000000000
RBP: ffffffff8ddf3a40 R08: ffffffff8969be0a R09: 1ffffffff1f5f50d
R10: dffffc0000000000 R11: fffffbfff1f5f50e R12: 1ffff92000000f5c
R13: ffffc9000b2d77c0 R14: ffffc90000007ae0 R15: 000000000165af0c
FS:  0000555589e57380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffe630188daf02 CR3: 000000007d0c8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x130/0x2f0 net/core/filter.c:4298
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5763
Code: 2b 00 74 08 4c 89 f7 e8 ba 1f 8b 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0000:ffffc9000b2d7620 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200165aed0 RCX: 697b9cec6cfc8500
RDX: dffffc0000000000 RSI: ffffffff8bcae720 RDI: ffffffff8c20a480
RBP: ffffc9000b2d7778 R08: ffffffff930028af R09: 1ffffffff2600515
R10: dffffc0000000000 R11: fffffbfff2600516 R12: 1ffff9200165aecc
R13: dffffc0000000000 R14: ffffc9000b2d7680 R15: 0000000000000246
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1675 [inline]
 sb_start_write+0x4d/0x1c0 include/linux/fs.h:1811
 mnt_want_write+0x3f/0x90 fs/namespace.c:515
 do_unlinkat+0x1fe/0x830 fs/namei.c:4469
 do_coredump+0x2247/0x2a30 fs/coredump.c:678
 get_signal+0x13fa/0x1740 kernel/signal.c:2902
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x79/0x280 kernel/entry/common.c:231
 exc_page_fault+0x590/0x8c0 arch/x86/mm/fault.c:1542
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fdae0dfb15e
Code: fd d7 c9 0f bc d1 c5 fe 7f 27 c5 fe 7f 6f 20 c5 fe 7f 77 40 c5 fe 7f 7f 60 49 83 c0 1f 49 29 d0 48 8d 7c 17 61 e9 d2 04 00 00 <c5> fe 6f 1e c5 fe 6f 56 20 c5 fd 74 cb c5 fd d7 d1 49 83 f8 21 0f
RSP: 002b:00007ffcbd96f8c8 EFLAGS: 00010287
RAX: 00007ffcbd96f8e0 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000000003ff RSI: 0000000000000000 RDI: 00007ffcbd96f8e0
RBP: 00007ffcbd96f8e0 R08: 00000000000003ff R09: 00007ffcbd96fe28
R10: 00007ffcbd96fe28 R11: 0000000000000246 R12: 6666666666666667
R13: 0000000000000000 R14: 00007ffcbd96fd30 R15: 00007ffcbd96fd20
 </TASK>
Modules linked in:
CR2: ffffe630188daf02
---[ end trace 0000000000000000 ]---
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:bpf_net_ctx_get_all_used_flush_lists+0x16b/0x390 include/linux/filter.h:846
Code: e6 08 31 ff e8 f6 c8 29 f8 4c 89 f8 48 83 e0 08 75 07 e8 08 c4 29 f8 eb 56 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 47 0f 91 f8 48 8b 03 48 39 d8 74 2a
RSP: 0000:ffffc90000007a28 EFLAGS: 00010a02
RAX: 1fffea30188daf02 RBX: ffff5180c46d7810 RCX: dffffc0000000000
RDX: 0000000080000100 RSI: 0000000000000008 RDI: 0000000000000000
RBP: ffffffff8ddf3a40 R08: ffffffff8969be0a R09: 1ffffffff1f5f50d
R10: dffffc0000000000 R11: fffffbfff1f5f50e R12: 1ffff92000000f5c
R13: ffffc9000b2d77c0 R14: ffffc90000007ae0 R15: 000000000165af0c
FS:  0000555589e57380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffe630188daf02 CR3: 000000007d0c8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e6 08                	out    %al,$0x8
   2:	31 ff                	xor    %edi,%edi
   4:	e8 f6 c8 29 f8       	call   0xf829c8ff
   9:	4c 89 f8             	mov    %r15,%rax
   c:	48 83 e0 08          	and    $0x8,%rax
  10:	75 07                	jne    0x19
  12:	e8 08 c4 29 f8       	call   0xf829c41f
  17:	eb 56                	jmp    0x6f
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 47 0f 91 f8       	call   0xf8910f7f
  38:	48 8b 03             	mov    (%rbx),%rax
  3b:	48 39 d8             	cmp    %rbx,%rax
  3e:	74 2a                	je     0x6a


Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124846ad980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d04f9888ed34da73
dashboard link: https://syzkaller.appspot.com/bug?extid=61a1cfc2b6632363d319
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12158b79980000


