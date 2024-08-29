Return-Path: <linux-kernel+bounces-305937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BE9636A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32764B22360
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00E523BF;
	Thu, 29 Aug 2024 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="MYRRRAR/";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="nhhN+z/8"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9BFDDA6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889972; cv=none; b=e5nShrK8k+UcwEiGQT3gi7ySSC2hm9Q7T7cj2rHp5cN4UzfgAPJYz5VzQNe7rdFVW75TOJxNBbx9lRtbq0dlXffxXDsA+G22CvgonZ0+U6E8pBlUSrkQO+1INxlPLsF6p3Lr+S2EZvVFR6SW1IsZKB5/ACNpvFX2A9wgtmlF3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889972; c=relaxed/simple;
	bh=CApostZhCsoZR0Fr0XE3zPOiHWENzXckzTzTmkKcWWs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mo9V0BjkwRjhr5y+cqXPnrMKPZI9qWQe9tyKDzD4njzydn5XVKiT0jAeUehcinSTKJt6k+XshR2BUxV+mlPFQ6KnLN5xAg0YCVH1y/rnDFpI1GKudcTjPw98rHc0LVC8FnvJAaH0ENp7yZODdpQgx/kfjWBOgOBkx31nH643lMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=MYRRRAR/; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=nhhN+z/8; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724889972; x=1756425972;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=CApostZhCsoZR0Fr0XE3zPOiHWENzXckzTzTmkKcWWs=;
  b=MYRRRAR/OmH8eym+6inpg6zB2t3XVZPkvLQ0FKgJWGSeROld92UOS7pr
   qBhzDlmhge9Pa9Y8i2pQTE60mQst6O0+GX3sd1ueg+c4SQMx8LMGQwlB0
   0uBQC/BXyFTA2rb3U2tKogUCq1Wp/zyCTMPp9iHypal49x8Fse/TjzB4F
   OUbs5WNjmyXEuKwVhoVk6OhofRyndS1QkqDcWeYMEvUgeI37UHTtf5ms8
   eT+olliGCUc+HkMFZR9YsTmrvnuBLP6S9ut/falgGr51GlQyVQt+G5ZF8
   K26yydJfeV87fwxkP8xtMXKPj2ZIifWN1WWO7e5SsZ40E7cFAAYTXxTwn
   A==;
X-CSE-ConnectionGUID: rY/THIaSQsCTNQk6hLdCdA==
X-CSE-MsgGUID: 8PMWraZoR76iP11CoWz7yw==
Received: from mail-il1-f197.google.com ([209.85.166.197])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 17:06:11 -0700
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d2c44422eso223345ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724889970; x=1725494770; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/KDv218JfwSE4KqWN4TRL607w+LWwO+Z8K6rGXnXQtU=;
        b=nhhN+z/89Alvq31qQAkQq1fl+fzoOMxAFahPqhmwPZus49PZdLp9Y14pRt9cQfRrI0
         qSvtUabWx57/JeQGg9uUHE75mrjfpYGn3BcM922nBTn9NiZN5KXvKt1VnnW5ZCN23MU6
         VeRpQcD+OnALyRgga4T06s7oeAGapWKj7Wq0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724889970; x=1725494770;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KDv218JfwSE4KqWN4TRL607w+LWwO+Z8K6rGXnXQtU=;
        b=ofH9dIFYsM+XOnL0a94P1llLy9VSiz1FzmvQ189VzPs1R/mFMMNwS58AD5K5XSRWez
         mwY5Rd5GSZTGcVENgLSZTXZNrRXw5RXtaJdYqVRiBX/EGEOWLdxGhG4lOssberq9LbCU
         ur7XDyaxt07eOMHsySFFpinZF+aHAg4BQnuCljoFapHP8LH6r3fRgXQFlG71gA21BUa0
         KyGSPF6yImyle7Wr1Vtmtj7OZdYfC7GqZOq2F4JUuuMqMATkHuPUfKZBbCHfDowm/q8K
         JtZaB8cluOAEUm/UqqRY5w04ocfwfSZkM8CtoTjYUfSZgZulj8CYdBX/ZxgLF0+nYGUF
         Gj6w==
X-Forwarded-Encrypted: i=1; AJvYcCV0tDiigu9H+ORSFnyqwreZPRsr9KRqpKuMDkQ6O+pmVcCvZvPVn7VxmmVn9tdGW6hlV1WrsGJ0uqBOE5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfo4gZQ0VWhUjdIPVkPj8wg+e2q+pvs20cwCbZpKi/rkZAkXHQ
	jOTjxWl4iL7qEIX5lSzLM1ojj3rqZzti8DsG4Sy8CHALivu/lwPFeDDJ7nD4+WQ7fXYmgFGfO0o
	99sncSQ7KL/t/+fcl/fFl2s2BbfiFAOwyb2Nz5uIGkZKbYWHpjBboxkWaV/eP+YEorU/HGdxw+v
	mp7uyWqaR7skDSbN2RQ2tkfsYDqD4soaWENa8Q3g==
X-Received: by 2002:a92:c26b:0:b0:39d:229d:864e with SMTP id e9e14a558f8ab-39f377ce3c4mr15964555ab.2.1724889969717;
        Wed, 28 Aug 2024 17:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz6gerXn1kQFR1BZkmsB31mYFIsCe2sPcO3gbuzzyjgIIq06yxkEjv7JnQCAkKmMtLlGctOksNQbwklOkTR34=
X-Received: by 2002:a92:c26b:0:b0:39d:229d:864e with SMTP id
 e9e14a558f8ab-39f377ce3c4mr15964315ab.2.1724889969330; Wed, 28 Aug 2024
 17:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 17:05:58 -0700
Message-ID: <CALAgD-5dHowM8+UPOWiSHk-YgKmJBp7KuQBSsPZEqx987zP5yg@mail.gmail.com>
Subject: BUG: general protection fault in mtree_range_walk
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a null
pointer dereference  bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 4493 Comm: systemd-journal Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:mtree_range_walk+0x2e4/0x890 lib/maple_tree.c:2774
Code: 48 83 f8 01 0f 84 ba 00 00 00 e8 c7 0f a4 f6 49 83 c4 08 49 ff
c6 48 8b 6c 24 10 eb a7 e8 b4 0f a4 f6 45 31 f6 e9 e5 00 00 00 <41> 80
3c 24 00 74 07 31 ff e8 be 1a 07 f7 4c 8b 2c 25 00 00 00 00
RSP: 0000:ffffc90002cc7c38 EFLAGS: 00010297
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff8f0c3620 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff8aed3fbd
R10: 0000000000000003 R11: ffff8880202fbc00 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc90002cc7da8 R15: 0000000000000001
FS:  00007f9017010900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9015c26c20 CR3: 00000000201f4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mas_state_walk lib/maple_tree.c:3678 [inline]
 mas_walk+0x7e/0x270 lib/maple_tree.c:4909
 lock_vma_under_rcu+0x22b/0x6d0 mm/memory.c:5841
 do_user_addr_fault+0x2ef/0x1190 arch/x86/mm/fault.c:1329
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x7a/0x120 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f90177c60be
Code: 40 38 00 00 00 00 4c 89 e8 48 f7 f1 48 8b 85 d8 00 00 00 48 c1
e2 04 48 01 d0 49 89 d5 48 8b 50 08 48 85 d2 0f 85 32 03 00 00 <4c> 89
00 48 8b 85 d8 00 00 00 4e 89 44 28 08 48 8b 85 d0 00 00 00
RSP: 002b:00007fffb2ac0810 EFLAGS: 00010246
RAX: 00007f9015c26c20 RBX: 00007fffb2ac0cf0 RCX: 000000000000acf8
RDX: 0000000000000000 RSI: 3833393d4449505f RDI: 00007f9015f76860
RBP: 000055d12aec0690 R08: 0000000000376820 R09: 0000000000376820
R10: 0000000000000002 R11: 7fffffffffffffff R12: 0000000000000009
R13: 0000000000025630 R14: 0000000000000000 R15: 00007fffb2ac0830
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mtree_range_walk+0x2e4/0x890 lib/maple_tree.c:2774
Code: 48 83 f8 01 0f 84 ba 00 00 00 e8 c7 0f a4 f6 49 83 c4 08 49 ff
c6 48 8b 6c 24 10 eb a7 e8 b4 0f a4 f6 45 31 f6 e9 e5 00 00 00 <41> 80
3c 24 00 74 07 31 ff e8 be 1a 07 f7 4c 8b 2c 25 00 00 00 00
RSP: 0000:ffffc90002cc7c38 EFLAGS: 00010297
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff8f0c3620 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff8aed3fbd
R10: 0000000000000003 R11: ffff8880202fbc00 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc90002cc7da8 R15: 0000000000000001
FS:  00007f9017010900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563c4dcd61e0 CR3: 00000000201f4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 48 83 f8 01           cmp    $0x1,%rax
   4: 0f 84 ba 00 00 00     je     0xc4
   a: e8 c7 0f a4 f6       call   0xf6a40fd6
   f: 49 83 c4 08           add    $0x8,%r12
  13: 49 ff c6             inc    %r14
  16: 48 8b 6c 24 10       mov    0x10(%rsp),%rbp
  1b: eb a7                 jmp    0xffffffc4
  1d: e8 b4 0f a4 f6       call   0xf6a40fd6
  22: 45 31 f6             xor    %r14d,%r14d
  25: e9 e5 00 00 00       jmp    0x10f
* 2a: 41 80 3c 24 00       cmpb   $0x0,(%r12) <-- trapping instruction
  2f: 74 07                 je     0x38
  31: 31 ff                 xor    %edi,%edi
  33: e8 be 1a 07 f7       call   0xf7071af6
  38: 4c 8b 2c 25 00 00 00 mov    0x0,%r13
  3f: 00


-- 
Yours sincerely,
Xingyu

