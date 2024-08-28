Return-Path: <linux-kernel+bounces-305756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2E9633DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185851C21B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1591AD3F5;
	Wed, 28 Aug 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="bE5k5MHW";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="N5vENj3z"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223115B137
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880627; cv=none; b=qifTt4fYJ1Lzs6xYcex7y9kC25fwkM/iD4t/SaW3QdBX/E6NKih9qEOqKTLBhGhXCqNGjJsULiFT8FKzOPjo4krmGvt+0YlU20MJqSNaKI+BaQGpv3ZCGawdoBj8ceqecjZ2sND34Oxwa/2TgdcRwVDw/9QSYX/Vmh4BUShgVVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880627; c=relaxed/simple;
	bh=W5t+TsHDdqtEqlQVwzAKb8FXLK5wwvdp8VqTqGXN3yE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KzJk40fSyz0IA3zoCA2br+gm7jlhOhnG5MGB0ob25nTFmFw8X7OqBxVwTwTGnV3EkhA2nok5ym1lqwVT0fN1iPDgvUrq5UXaGI2tBC3TkZ+IWP4gi39BYsq4xKq9PhgxlfniqtEkqcaHeYKMSADCMiYNswgU4EOR5dPrMLK0omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=bE5k5MHW; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=N5vENj3z; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724880626; x=1756416626;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=W5t+TsHDdqtEqlQVwzAKb8FXLK5wwvdp8VqTqGXN3yE=;
  b=bE5k5MHWK3cCvSAKgjkyHxK2BhZAMYFflyjb9QVtIQ5cISFvgnXimU/6
   c2wvenyJ7i7wVxIr9mKc7v7lii4i0JuDnKZhdYWas+EOrz10BHbLNtJrM
   dxfKTFXpWfQx28//4s0YBLhltN2bcuVnIMNor8UdMiOgZB42XUhH7ogtk
   A6ntyJkf3O0yu6X4ty2XkBqbFw6nSvICbUwwugWvMtTPFXQnJ09Dr4ELf
   6jwo0JeNAUheRlFPi1czeVIgojTNmH6AIaYV80tHKVz70h/w8fPkiwxhh
   22IO/f9oZnEOMmCg006v1pz/GwKgpjaPmSHDYZrI41g2J04KpHajv3wuh
   g==;
X-CSE-ConnectionGUID: qlrmuTfTS4qZV16DSkx0hg==
X-CSE-MsgGUID: lVVBBKzCQymxrW1z7Kn/Rw==
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 14:30:23 -0700
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3bd8a0bd4so8124665a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724880623; x=1725485423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p7w2fRhYaEno5pjgH9P7KAMSDvs8lR65sZW4tF1Hqts=;
        b=N5vENj3zT/++vzucKJ/iGmK0aubkRo6+cAII5VAcfOeCZgY18M36djk9ghK4fUvixc
         JyqkxAVzAVQPHV05P5NXJdrRMdrXTSnoFu6ARCszWrjQpGWl60FlDCMnYmTzjBobgy+J
         aKcSLf6EurYF3TEM8Lc+4y2AY85BuDAJwa9rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880623; x=1725485423;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7w2fRhYaEno5pjgH9P7KAMSDvs8lR65sZW4tF1Hqts=;
        b=TmMZ16kQB4d7dzZLaqpNuusgUC9/f1ksFampEIJ5wwDIH/AKv/TnzHkidmu9eij871
         eXc+unmTmfVFuObGGCBtqrjoAPFC3cr1wDaPDvtn7Y5ySStJwXUpi3M6BYIJj+WSPX9R
         zhk1tOqZdYtMdngB/k27ZdyutpiiEf9jGD1NQtl+6ZQsFsWn13Fr/9umkQDzfX5XNEkl
         1hPGLSALHRfO0ogtKPEpnvsbnofNDUvrGj0Eb+gsEVtxIew0n256xLHCv43A0RtdwfgG
         0sJ+qqAiGU6VCaiZRv2bcLMJK/hE/OrqKVUxhiEzPp9A+bQL6p1H1y6f6DBF1nc7wj08
         Vhsw==
X-Forwarded-Encrypted: i=1; AJvYcCVf0nAz16SB6fcWxacLbdcL2h7GcWoBPq5KKrujQ8mfOqusp4gHV07/X7o6+g8buAJAICiCrNo50U2Qr+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmifx1G2LMmbJLxbW43Ark3B0GwwbKOo6rbbwLqaXF3+QtohWa
	fbZ7BwkV2yQTeOFTF07QT5dGXkdmGkoC/vxizIOEKPwhnJMlthBajL8Ef/Ud4T7AnAuA9Eeg2Kr
	45mTE/hyyuQmrLpF2GhOJyuvsB0+hXy+nP/4G+FxDUZuyZbQhXb9qEHPJCnrDnNoggbTXdE9jCp
	zm+ja/9g/wPqzioH/a9O+J7+sVJv4Qqg8zUO40jg==
X-Received: by 2002:a17:90b:4b07:b0:2d3:b8eb:9c3c with SMTP id 98e67ed59e1d1-2d85618a1e0mr605256a91.2.1724880622404;
        Wed, 28 Aug 2024 14:30:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGV5H75RSLzKNcOXv8IbEQGpVirzOsDloof6cRBzWiFNyeyDgl3TGz7xoZhUQf2+V5Eb4kH90EKD9vAAH4mbk=
X-Received: by 2002:a17:90b:4b07:b0:2d3:b8eb:9c3c with SMTP id
 98e67ed59e1d1-2d85618a1e0mr605234a91.2.1724880622051; Wed, 28 Aug 2024
 14:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 14:30:11 -0700
Message-ID: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>
Subject: BUG: WARNING in kvfree_rcu_bulk
To: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com, 
	urezki@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a  task hung bug.
The reprodcuer is
https://gist.github.com/freexxxyyy/67172235de920ccf2f282f9e1179354d

The bug report is:

------------[ cut here ]------------
ODEBUG: active_state not available (active state 0) object:
ffff88802526c180 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 4497 at lib/debugobjects.c:517 debug_print_object
lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 4497 at lib/debugobjects.c:517
debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
Modules linked in:
CPU: 0 PID: 4497 Comm: kworker/0:3 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events kfree_rcu_work
RIP: 0010:debug_print_object lib/debugobjects.c:514 [inline]
RIP: 0010:debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
Code: d7 95 fd 4d 8b 0c 24 48 c7 c7 a0 61 a9 8b 48 c7 c6 60 5e a9 8b
48 89 ea 8b 4c 24 04 49 89 d8 41 57 e8 24 1b f7 fc 48 83 c4 08 <0f> 0b
ff 05 88 0c c6 0a 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d
RSP: 0018:ffffc90002cc7a10 EFLAGS: 00010292
RAX: f9c69a923cadb800 RBX: ffff88802526c180 RCX: ffff88801e3cbc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8ba96360 R08: ffffffff8155a25a R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: ffffffff8b4de5c0
R13: 0000000000000005 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa7a316ef78 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_rcu_head_unqueue kernel/rcu/rcu.h:236 [inline]
 debug_rcu_bhead_unqueue kernel/rcu/tree.c:3287 [inline]
 kvfree_rcu_bulk+0xc5/0x4d0 kernel/rcu/tree.c:3364
 kfree_rcu_work+0x443/0x500 kernel/rcu/tree.c:3450
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>

-- 
Yours sincerely,
Xingyu

