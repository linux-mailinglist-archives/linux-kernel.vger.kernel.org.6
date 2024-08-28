Return-Path: <linux-kernel+bounces-304294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E52961D62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA761F2455B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A09A1411DE;
	Wed, 28 Aug 2024 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="E9bewWZ5";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Ta8emPNE"
Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668AA3398E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818212; cv=none; b=lyAoRoLR7yU155Dl8sbFWc+9qG8siBbrcpAf++wp/+RQnmsVYoGa+IC6XIpY1e6NWmKGSTI/myriHjYU8CWaxnppMDdJqY38MBss3KzkJsY5XkAr+9+OduVQzPt2T4EMd2nDVH5yEcL0RS7HyB+6g2NQr1gVHIMTm7L/Wd0gawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818212; c=relaxed/simple;
	bh=G3i8bCaW+cddC5ppOrKajoMJxbKRbPYuNk9rxbo6NK4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TpSkQFfSr0YrKqps2QUhPtXTtb+t9nBjgIyFp4FBNtxI/BvKcFd4eT0NG0ZvxF4yKAI69VUdvexXSHorEiHj/nfI39KzelHCv6sEjyztHBrtmqfoFgrqksDB0lou5XXVYXQ0ZRT+BF8lOQAtWdBsvaMGSP+yCGkhBTIpDyEYWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=E9bewWZ5; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Ta8emPNE; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724818210; x=1756354210;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=G3i8bCaW+cddC5ppOrKajoMJxbKRbPYuNk9rxbo6NK4=;
  b=E9bewWZ5tRuG/T/oZRGx0u4W2zvu8fwJmTheU5qnmEoITZZDhTtvvDxh
   iEhTkneUl0KYjrBKERHpBMqenQk4RvH0cAYmfKuZs8vyChZ1ZSNFptC0f
   xNQgrkQoGaCl0AjvaS41auKs4j9IAZ20pot0C7aH3BsMLy1/6sczMtDix
   pyrCDy5o9+Lkszirokqa+nc6R/j/r81M/SjBRjemTte/BVk7v/Zoh/GcM
   SXUXVijDPwRRDtSP3yU4M1vJPXnjbm38j6Q3Ww1xOopXWS/2m7aGv7rD7
   VUHooIcXEWqwR3Ngx1qn6f5OOVWS1QE49yav46Ot06hQ+jl2WnRPnQbfz
   w==;
X-CSE-ConnectionGUID: x6X2086gRxCZ3etvrxwMVQ==
X-CSE-MsgGUID: lqwUfA4MTg6KXEeDnfsc1w==
Received: from mail-io1-f71.google.com ([209.85.166.71])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Aug 2024 21:10:02 -0700
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8223aed779aso696801639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724818202; x=1725423002; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1s+4oGmpvML5BMrqC4kA6kcjCN1sS4vyUSg4UWobQjs=;
        b=Ta8emPNEEkoTLBPOMoKf2DCt3pxsIOua8IuGBOxkfDmXHN7LDZtcOSHfAtvrE37/Bs
         bZbaQPdL9J2y/gEe0+wSCMfU5w2cix2SkNY051lopCVuGPZdu5+ErroxjGjPtYqjcbka
         KXIPXOBbwGjI6KWSbI05kOL+wdplP4KPJ+blU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724818202; x=1725423002;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1s+4oGmpvML5BMrqC4kA6kcjCN1sS4vyUSg4UWobQjs=;
        b=iubyEYTzAWNar2nZvaCW3Hw7rwJFwY0nHkWOZHGqLoBCtdiKkVkyptyj9DvOOAH++5
         QQx5RwY3jFhMUVQCyLK/HgVIFJhEOKvNleAnAwrfN7/zT8oBNAZyNEoazjM3PoErkooM
         1RDSM0e2ABodobNH9B9MIgfpCqj8FDT3TYvTa+ThpP/y9KWPrl3DZBjPT5EzNCANFMGx
         Y4r1e84mSpG7PjQhCEdj/WEyVSVP+ZNWgrREHlWhhoOXFzWhAwWWh//+TPsRNyvZKbKN
         lCbLmJx55Bg4TA0mMio7AUbpb9CkrI1HENHiZZlk0XstQr9tPVHgJmn2NlSRyycMrywt
         Lkxw==
X-Forwarded-Encrypted: i=1; AJvYcCWU3LA1NxEmwMKW6ljvhW/GbdOcOdZZ39hXGFSw3ynWpKYefo08HxfscJpI2EZ6cVT6sT2u9xLJD2j89qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHijwLJplBBuaexzT07hG1IWSnpS6F1nqxZstnLjYOhf0aQiF
	qowno1Rn6hECGvmi1zcArNRFvRUkNFJ/8taMg1Ul7utXX4HVjH8MoHlB8zvZ+O/OdY6skICZSBA
	rwv0aCa3hj/l1xvxY+FaUmaGqps+55WxTPK/w9+GJlP/8UWuikpjlnHMHWMJJiaJalcdX5UHIKY
	2BTSuI9REtYZHDGEPm51y/LO6ouKvXhgERK9kK9w==
X-Received: by 2002:a05:6602:4187:b0:824:da64:6503 with SMTP id ca18e2360f4ac-82a0417f3a7mr76935539f.15.1724818201825;
        Tue, 27 Aug 2024 21:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZhe/MJPGIWdIhiG/dex8FM0RBamgByt69IwC6p7j+TFmoowQHx7lLRSjDpLXS3v8xTVy3CuPtFBYxwRRLXpE=
X-Received: by 2002:a05:6602:4187:b0:824:da64:6503 with SMTP id
 ca18e2360f4ac-82a0417f3a7mr76933939f.15.1724818201423; Tue, 27 Aug 2024
 21:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Tue, 27 Aug 2024 21:09:49 -0700
Message-ID: <CANikGpeQuBKj89rTkaAs5ADrz0+YLQ54g-0CshYzE3h06G0U5g@mail.gmail.com>
Subject: BUG: null pointer dereference in
To: kees@kernel.org, luto@amacapital.net, wad@chromium.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following null-pointer-dereference issue using syzkaller
on Linux v6.10.
Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 PID: 4493 Comm: systemd-journal Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__bpf_prog_run include/linux/filter.h:691 [inline]
RIP: 0010:bpf_prog_run include/linux/filter.h:698 [inline]
RIP: 0010:bpf_prog_run_pin_on_cpu include/linux/filter.h:715 [inline]
RIP: 0010:seccomp_run_filters+0x17a/0x3f0 kernel/seccomp.c:426
Code: 00 00 e8 99 36 d2 ff 0f 1f 44 00 00 e8 cf 58 ff ff 48 8d 5d 48
48 83 c5 30 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c
08 00 74 08 48 89 ef e8 c8 63 62 00 4c 8b 5d 00 48 8b 3c 24
RSP: 0018:ffffc90002cb7be0 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000048 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 00000000000002a4 RDI: ffffffff8b517360
RBP: 0000000000000030 R08: ffffffff8191f8eb R09: 1ffff11004039e86
R10: dffffc0000000000 R11: ffffffffa00016d0 R12: 000000007fff0000
R13: ffff88801f84a800 R14: ffffc90002cb7df0 R15: 000000007fff0000
FS:  00007f897e849900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f897d771b08 CR3: 00000000195fe000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __seccomp_filter+0x46f/0x1c70 kernel/seccomp.c:1222
 syscall_trace_enter+0xa4/0x140 kernel/entry/common.c:52
 syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [inline]
 syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
 do_syscall_64+0x5d/0x150 arch/x86/entry/common.c:79
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f897ed171e4
Code: 84 00 00 00 00 00 44 89 54 24 0c e8 36 58 f9 ff 44 8b 54 24 0c
44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 68 58 f9 ff 8b 44
RSP: 002b:00007ffd4ae74a60 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00005627cd785ed0 RCX: 00007f897ed171e4
RDX: 0000000000290000 RSI: 00007f897f010d0a RDI: 00000000ffffff9c
RBP: 00007f897f010d0a R08: 0000000000000000 R09: 0034353132303865
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000290000
R13: 00007ffd4ae74d20 R14: 0000000000000000 R15: 00007ffd4ae74e28
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bpf_prog_run include/linux/filter.h:691 [inline]
RIP: 0010:bpf_prog_run include/linux/filter.h:698 [inline]
RIP: 0010:bpf_prog_run_pin_on_cpu include/linux/filter.h:715 [inline]
RIP: 0010:seccomp_run_filters+0x17a/0x3f0 kernel/seccomp.c:426
Code: 00 00 e8 99 36 d2 ff 0f 1f 44 00 00 e8 cf 58 ff ff 48 8d 5d 48
48 83 c5 30 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c
08 00 74 08 48 89 ef e8 c8 63 62 00 4c 8b 5d 00 48 8b 3c 24
RSP: 0018:ffffc90002cb7be0 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000048 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 00000000000002a4 RDI: ffffffff8b517360
RBP: 0000000000000030 R08: ffffffff8191f8eb R09: 1ffff11004039e86
R10: dffffc0000000000 R11: ffffffffa00016d0 R12: 000000007fff0000
R13: ffff88801f84a800 R14: ffffc90002cb7df0 R15: 000000007fff0000
FS:  00007f897e849900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f521f8ca000 CR3: 00000000195fe000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 00 00                 add    %al,(%rax)
   2: e8 99 36 d2 ff       call   0xffd236a0
   7: 0f 1f 44 00 00       nopl   0x0(%rax,%rax,1)
   c: e8 cf 58 ff ff       call   0xffff58e0
  11: 48 8d 5d 48           lea    0x48(%rbp),%rbx
  15: 48 83 c5 30           add    $0x30,%rbp
  19: 48 89 e8             mov    %rbp,%rax
  1c: 48 c1 e8 03           shr    $0x3,%rax
  20: 48 b9 00 00 00 00 00 movabs $0xdffffc0000000000,%rcx
  27: fc ff df
* 2a: 80 3c 08 00           cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e: 74 08                 je     0x38
  30: 48 89 ef             mov    %rbp,%rdi
  33: e8 c8 63 62 00       call   0x626400
  38: 4c 8b 5d 00           mov    0x0(%rbp),%r11
  3c: 48 8b 3c 24           mov    (%rsp),%rdi

