Return-Path: <linux-kernel+bounces-305927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A148F963681
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B63E1F22D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF4F1AD401;
	Wed, 28 Aug 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="K6pDFoXy";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="m0s0p071"
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE821165F14
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889340; cv=none; b=pY/hYyfztb0WNxUu/OBM/Q1JFwjnu15SW8/VJmGFNGxelZafI/y4d94zVwo6WIKjnnthtw6PEDZp6RuPC6mj9OVpzsnKWnGRTFWUxtXjQqJthd9sa93lIsik+8a2azqsKUd5RerR4K0Dh3o9MBcXLKQ4EDAadMknbfDqqAYM/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889340; c=relaxed/simple;
	bh=UN4Qx6bxXEa1mxT7lWlnOOLWGyS6uLKelzQ3MQZLVac=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bKUTKOAvnBvPLtA60zMNlH9U3+HOvK2eS4CVtW1wHyM3dwKU3xllhnQggnDsurVjPNZ1waGW6aHos3N+jsF/8FFM5ZpTiDP2ghnmLy0TsU9roK4Q9k37HogjF7lBIKZsOqRwuPAnb7HhIEhKgwQNlroCVxs9mRYCX+K0DmBF4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=K6pDFoXy; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=m0s0p071; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724889339; x=1756425339;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=UN4Qx6bxXEa1mxT7lWlnOOLWGyS6uLKelzQ3MQZLVac=;
  b=K6pDFoXymbA+DM4vCTvT0SDNiz1O9E+3jfMThFjRrOkSW8vF41Uz16NQ
   VgNmtSxw3X9idOieCnUrNf+aQPGUeq4lIy4HtqwRF8N5RgZInuXDAvwyG
   mmH4U+c2Dd+HGZhPaokshGsiqI8ZdW53q28BY4Og+UcGQgb9jxowH/WZV
   69KbHcf6PfMFMS24XNZrquen0K0xHLIdEiudg21UD0DZss5lLcfOZiTSz
   OpORuD0eywJLz07RJLNaa+YWmnickI20AoobnLL8ekaeLRFedRLGSCm1o
   F2fcde8peITz0FesnKeQ3Df2NI9GgoIY4Xovevk0kL5n63VqgHDJuzZxJ
   w==;
X-CSE-ConnectionGUID: +HJWoo6vR1+1ix8CUMFYWQ==
X-CSE-MsgGUID: rbsBhDxqSWWKjt5Gh9uygg==
Received: from mail-il1-f200.google.com ([209.85.166.200])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:55:38 -0700
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2ceca837so93115ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724889337; x=1725494137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oTpy7Rkm6RTtGoFPUAb+dcZxlUVlvvaat+wa/fxzNaY=;
        b=m0s0p071QArHm1enTQpZLKdu4uVjjMF0xsJPbkFG517kBHPRgDQO+lYmvfk5UKgsmj
         cRwEpje1omfS7m4IzbCxhD5pp00CFfFYckuJOwcF7+pqpIjkat1qkKKak1rRB3FsL9k9
         5aMs2/vNNZi1GSn8Kg2+30Nq7NkLOZUXp9VlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724889337; x=1725494137;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTpy7Rkm6RTtGoFPUAb+dcZxlUVlvvaat+wa/fxzNaY=;
        b=InXPfgTOUWrQhtrHBq9G2fw7LccX0JXsRd8x5oTQGSkaDAD5KESwksqLa41ptYpV94
         N9JPqBOR2svCDG7U1Mx+gAD4q9iL6kFXkf2q3+PnLZ4YK8d0GbhuHS0whMliKQkdqBko
         0n+FQHwX/4P6UN305jsszV60IMLrz3m0S+SjaZFTw7omW3bF5CzBVGiYdxo8sKRPw7VV
         7EepM8tvAlQxCew6RmhwCOWWcOBnwisn2tvROaFMTrcVtpcgaLd8vETzrq35dKHNY8IL
         5spRTPvU6Y8AhLpCRqaS5znskoAbbVefK5Jp6Se3wVjjh6oi7+8v+VjAkpYCSb21294t
         Akmg==
X-Forwarded-Encrypted: i=1; AJvYcCXdtNh6h03XzoVZ4vIFvkoghPoeiWoTy88IKOTmGn0qgy1V9rGBHoU2ZgV/DhkkC5gnKEEiNr8WyMiwH3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5OJE6e/Yt3vAopEoudJJy4iUqe05CB2gylcIpSf+kNTy151sn
	VmJkta9898CW3Swc53EyuHZ9tYPQIU1yjUV4qXNhdZR5+dwlqc15+dMC+GRYiNunopjDCrm9Jcm
	W5gKliQpWrlYd7PeX0jgiCjhCzUOJyqrWCH+BgOUeF2FfjEROIpLnnpPWMRr+7YdRRVqsQD48d9
	eA3ZTdyLtJKscWkadwAm0eiipHgkTU8O45WsoSzQ==
X-Received: by 2002:a92:cd88:0:b0:39b:3894:9298 with SMTP id e9e14a558f8ab-39f37712626mr18463515ab.0.1724889337157;
        Wed, 28 Aug 2024 16:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGChgmIn4sdx36CE10rCA9pVfgqTZ5UmTTlFxDnqtCcfNNgVfHSBolho2o+2PAPX/IVlPE76trnVyzaK2YQGsA=
X-Received: by 2002:a92:cd88:0:b0:39b:3894:9298 with SMTP id
 e9e14a558f8ab-39f37712626mr18463265ab.0.1724889336767; Wed, 28 Aug 2024
 16:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:55:26 -0700
Message-ID: <CALAgD-5Vx9-9VSqO1YVg9CS=uWzpYoSpV5zWaV+LZUWtqnw5Wg@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in rht_lock
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com, 
	shaozhengchao@huawei.com, juntong.deng@outlook.com, ryasuoka@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a page fault  bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
BUG: unable to handle page fault for address: ffffed1056223056
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 13ffee067 P4D 13ffee067 PUD 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 89058 Comm: kworker/u4:20 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x81/0x2a0 mm/kasan/generic.c:189
Code: 00 00 fc ff df 4d 8d 34 19 4c 89 f5 4c 29 dd 48 83 fd 10 7f 2c
48 85 ed 0f 84 58 01 00 00 49 01 de 4c 89 dd 4c 29 f5 48 01 dd <41> 80
3b 00 0f 85 dd 01 00 00 49 ff c3 48 ff c5 75 ee e9 35 01 00
RSP: 0018:ffffc9000a4bf830 EFLAGS: 00010086
RAX: 1ffff11007734201 RBX: dffffc0000000001 RCX: ffffffff89131dcd
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8882b11182b0
RBP: ffffffffffffffff R08: ffff8882b11182b7 R09: 1ffff11056223056
R10: dffffc0000000000 R11: ffffed1056223056 R12: 1ffff11056223056
R13: 0000000000000246 R14: dfffe91056223058 R15: ffff8882b11182b0
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1056223056 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 test_and_set_bit_lock
include/asm-generic/bitops/instrumented-lock.h:57 [inline]
 bit_spin_lock include/linux/bit_spinlock.h:27 [inline]
 rht_lock+0xfd/0x230 include/linux/rhashtable.h:332
 __rhashtable_remove_fast_one include/linux/rhashtable.h:1012 [inline]
 __rhashtable_remove_fast include/linux/rhashtable.h:1093 [inline]
 rhashtable_remove_fast include/linux/rhashtable.h:1122 [inline]
 netlink_remove net/netlink/af_netlink.c:616 [inline]
 netlink_release+0x400/0x1b00 net/netlink/af_netlink.c:755
 __sock_release net/socket.c:659 [inline]
 sock_release+0x80/0x140 net/socket.c:687
 crypto_netlink_exit+0x3c/0x60 crypto/crypto_user.c:498
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x810/0xcd0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: ffffed1056223056
---[ end trace 0000000000000000 ]---
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x81/0x2a0 mm/kasan/generic.c:189
Code: 00 00 fc ff df 4d 8d 34 19 4c 89 f5 4c 29 dd 48 83 fd 10 7f 2c
48 85 ed 0f 84 58 01 00 00 49 01 de 4c 89 dd 4c 29 f5 48 01 dd <41> 80
3b 00 0f 85 dd 01 00 00 49 ff c3 48 ff c5 75 ee e9 35 01 00
RSP: 0018:ffffc9000a4bf830 EFLAGS: 00010086
RAX: 1ffff11007734201 RBX: dffffc0000000001 RCX: ffffffff89131dcd
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8882b11182b0
RBP: ffffffffffffffff R08: ffff8882b11182b7 R09: 1ffff11056223056
R10: dffffc0000000000 R11: ffffed1056223056 R12: 1ffff11056223056
R13: 0000000000000246 R14: dfffe91056223058 R15: ffff8882b11182b0
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1056223056 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0: df 4d 8d             fisttps -0x73(%rbp)
   3: 34 19                 xor    $0x19,%al
   5: 4c 89 f5             mov    %r14,%rbp
   8: 4c 29 dd             sub    %r11,%rbp
   b: 48 83 fd 10           cmp    $0x10,%rbp
   f: 7f 2c                 jg     0x3d
  11: 48 85 ed             test   %rbp,%rbp
  14: 0f 84 58 01 00 00     je     0x172
  1a: 49 01 de             add    %rbx,%r14
  1d: 4c 89 dd             mov    %r11,%rbp
  20: 4c 29 f5             sub    %r14,%rbp
  23: 48 01 dd             add    %rbx,%rbp
* 26: 41 80 3b 00           cmpb   $0x0,(%r11) <-- trapping instruction
  2a: 0f 85 dd 01 00 00     jne    0x20d
  30: 49 ff c3             inc    %r11
  33: 48 ff c5             inc    %rbp
  36: 75 ee                 jne    0x26
  38: e9                   .byte 0xe9
  39: 35                   .byte 0x35
  3a: 01 00                 add    %eax,(%rax)


-- 
Yours sincerely,
Xingyu

