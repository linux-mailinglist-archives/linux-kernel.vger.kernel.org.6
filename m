Return-Path: <linux-kernel+bounces-344054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BACB898A38A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3414FB24DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8C18E751;
	Mon, 30 Sep 2024 12:52:56 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB778126C07
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700775; cv=none; b=K5ezaesZOYbfBBkRIoTOycrQuHmdGo1vPi/YgfDKfRm1TefTNfAIxMeLxFVyeQ7uN1us15j5xsq033bbQpYq3nIkKFRFr1oOhelbdHcg75SfBLRkVshexp+OUaf7I0/4Z/HPSNd3AIFzdHoMQa+7YoH49YlK89OaN1YY58HELZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700775; c=relaxed/simple;
	bh=/V56lk7ZegXlAfXt0mXZYXzDpMI1H5yOFejQXAJJ+vA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cz8PGtFBGv3e48VAXN42eJeA0PhGkNt+1sAziWW6OMlqLONanVopgqI7DglncJs5swrtS6zyXINniiiW2g3Ab4UakeWdB85zVJUuahSnrWAr00OFDZe4gdyBMYJ1oJyjyUbMk454YEh3hlvLaNuRKDlYVi7DShGNVn/9vz3ZClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a83562f9be9so493745466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727700772; x=1728305572;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1TlKW/417T6V+OHhC40MAa3QR7g+i27iZseLpNTNxY=;
        b=xNP2TEloGIHJttBAkOojMFEJZVy3a5aPLCvvPtqt0CUnFX5cos6iRdjDxXbtNoIIhS
         0gfQkQg/zyxnh2eUU+bYKY31lPff9FIK6EKwuyxURi0OjmsyR/22seTQHgrkd0yf87xP
         1TQRvECn6gXExN/R6Pml4OHFPR7QZHiV3rUVPX/nO8CWUsTwJeKIIoEB8kXGiRidgxlm
         yRULA63CMWLCanZYMGPPjCwdQEv+GHWhLC9DRYmzHouaPiFM8WVvsw4oQqCedx/k6TOh
         ps3QzaTjIvWGJO8MhkgJ+Ecx2mPugJVi0P5bZNyAex3V7HbOWMMViBrkLZTULotv6FkR
         Y91g==
X-Gm-Message-State: AOJu0YxTBJMbfCB0yewdTIvOLt3ep6HZq+oGslVfpycEfqC2whEBpkEn
	x0WWaEbwUxSL0aYi3bGbjRZOgyHFjx51ibQYVyzhSaAdQv1mvBdN
X-Google-Smtp-Source: AGHT+IE2+mUmus2a/8fNq1KMpKrMx3DnOMdP0TGlcz2hatdK9qGznAauya3pnsh7TW27wUKm5kP+iQ==
X-Received: by 2002:a17:907:9341:b0:a8d:4e26:c9b9 with SMTP id a640c23a62f3a-a93c49218abmr1271171666b.17.1727700771635;
        Mon, 30 Sep 2024 05:52:51 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2776df8sm526504666b.26.2024.09.30.05.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:52:51 -0700 (PDT)
Date: Mon, 30 Sep 2024 05:52:49 -0700
From: Breno Leitao <leitao@debian.org>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: 6.12-rc1: general protection fault at pick_task_fair()
Message-ID: <20240930-mysterious-meek-goldfish-2f851f@leitao>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've been testing v6.12-rc1 and I got some crashes that I would like to
share, since I haven't seen anything in the mailing list yet.

This kernel was compiled with some debug options, against 11a299a7933e
("Merge tag 'for-6.12/block-20240925' of git://git.kernel.dk/linux").


   [146800.130180] Oops: general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
   [146800.156067] KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
   [146800.200109] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [E]=UNSIGNED_MODULE, [L]=SOFTLOCKUP, [N]=TEST
   [146800.218119] Hardware name: Quanta Delta Lake MP 29F0EMA00E0/Delta Lake-Class1, BIOS F0E_3A19 04/27/2023
   [146800.237177] Workqueue:  0x0 (events)
   [146800.244615] RIP: 0010:pick_task_fair (kernel/sched/fair.c:5626 kernel/sched/fair.c:8856) 
   [146800.253955] Code: 74 08 48 89 df e8 3d 78 01 00 e9 29 01 00 00 0f 1f 44 00 00 48 89 df e8 5b ef 01 00 49 89 c6 48 8d 68 51 48 89 eb 48 c1 eb 03 <42> 0f b6 04 3b 84 c0 0f 85 98 00 00 00 80 7d 00 00 0f 84 3a 03 00
   All code
   ========
      0:	74 08                	je     0xa
      2:	48 89 df             	mov    %rbx,%rdi
      5:	e8 3d 78 01 00       	call   0x17847
      a:	e9 29 01 00 00       	jmp    0x138
      f:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     14:	48 89 df             	mov    %rbx,%rdi
     17:	e8 5b ef 01 00       	call   0x1ef77
     1c:	49 89 c6             	mov    %rax,%r14
     1f:	48 8d 68 51          	lea    0x51(%rax),%rbp
     23:	48 89 eb             	mov    %rbp,%rbx
     26:	48 c1 eb 03          	shr    $0x3,%rbx
     2a:*	42 0f b6 04 3b       	movzbl (%rbx,%r15,1),%eax		<-- trapping instruction
     2f:	84 c0                	test   %al,%al
     31:	0f 85 98 00 00 00    	jne    0xcf
     37:	80 7d 00 00          	cmpb   $0x0,0x0(%rbp)
     3b:	0f                   	.byte 0xf
     3c:	84 3a                	test   %bh,(%rdx)
     3e:	03 00                	add    (%rax),%eax
   
   Code starting with the faulting instruction
   ===========================================
      0:	42 0f b6 04 3b       	movzbl (%rbx,%r15,1),%eax
      5:	84 c0                	test   %al,%al
      7:	0f 85 98 00 00 00    	jne    0xa5
      d:	80 7d 00 00          	cmpb   $0x0,0x0(%rbp)
     11:	0f                   	.byte 0xf
     12:	84 3a                	test   %bh,(%rdx)
     14:	03 00                	add    (%rax),%eax
   [146800.291790] RSP: 0018:ffff8889ae3dfbc0 EFLAGS: 00010006
   [146800.302506] RAX: 0000000000000000 RBX: 000000000000000a RCX: dffffc0000000000
   [146800.317040] RDX: ffff8889ae3dfd30 RSI: ffff8889af5bca00 RDI: ffff888e38546380
   [146800.331573] RBP: 0000000000000051 R08: ffffffff86ddef37 R09: 1ffffffff0dbbde6
   [146800.346109] R10: dffffc0000000000 R11: fffffbfff0dbbde7 R12: 1ffff111c70a8c6a
   [146800.360642] R13: 1ffff111c70a8c71 R14: 0000000000000000 R15: dffffc0000000000
   [146800.375175] FS:  0000000000000000(0000) GS:ffff888e38500000(0000) knlGS:0000000000000000
   [146800.391619] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   [146800.403369] CR2: 0000559372540094 CR3: 0000000017c8c001 CR4: 00000000007706f0
   [146800.417906] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   [146800.432437] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   [146800.446969] PKRU: 55555554
   [146800.452638] Call Trace:
   [146800.457784]  <TASK>
   [146800.462238] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
   [146800.469479] ? die_addr (arch/x86/kernel/dumpstack.c:?) 
   [146800.476373] ? exc_general_protection (arch/x86/kernel/traps.c:? arch/x86/kernel/traps.c:693) 
   [146800.486078] ? asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:617) 
   [146800.496111] ? pick_task_fair (kernel/sched/fair.c:5626 kernel/sched/fair.c:8856) 
   [146800.504219] ? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c:737) 
   [146800.512321] ? util_est_update (./include/trace/events/sched.h:814 kernel/sched/fair.c:5054) 
   [146800.520777] pick_next_task_fair (kernel/sched/fair.c:8877) 
   [146800.529408] __schedule (kernel/sched/core.c:5956 kernel/sched/core.c:6477 kernel/sched/core.c:6629) 
   [146800.536841] ? sched_submit_work (kernel/sched/core.c:6708) 
   [146800.545472] schedule (kernel/sched/core.c:6753 kernel/sched/core.c:6767) 
   [146800.552189] worker_thread (kernel/workqueue.c:3344) 
   [146800.559983] kthread (kernel/kthread.c:390) 
   [146800.566696] ? pr_cont_work (kernel/workqueue.c:3337) 
   [146800.574623] ? kthread_blkcg (kernel/kthread.c:342) 
   [146800.582379] ret_from_fork (arch/x86/kernel/process.c:153) 
   [146800.589784] ? kthread_blkcg (kernel/kthread.c:342) 
   [146800.597537] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
   [146800.605664]  </TASK>

Important to say that I am also seeing the following warning before the
crash:

 workqueue: drain_vmap_area_work hogged CPU for >20000us 4 times, consider switching to WQ_UNBOUND
 ------------[ cut here ]------------
           !se->on_rq
           WARNING: CPU: 24 PID: 17 at kernel/sched/fair.c:704 dequeue_entity+0xd21/0x17c0

Is this helpful?

Thanks
--breno

