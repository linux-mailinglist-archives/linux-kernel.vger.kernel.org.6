Return-Path: <linux-kernel+bounces-307829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A9965371
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8ADB1F24140
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B718F2D2;
	Thu, 29 Aug 2024 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="mVpYjunF";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="avsyoLbL"
Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241318EFFB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974205; cv=none; b=aDIlBXzbwyYArSTZ7nGbqmsJJJxROrmJYBTaVFvR8EPW4Fn038LNuFIVSkqVLDJUSvNrmEOkXsDIcbrJmeDiPtdaaEj/1YoIAb126lLCAf2KgCTmQ1f1WFfdB6ZcnXbjn3mWf1xOczKDjVFX/GZjRlXMj44ZMFlcNF/uzc3vC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974205; c=relaxed/simple;
	bh=T+j7RRKzuWmA1q1ZqCVTtLsVcebKArnx6jNOTkQeqxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqyJ7pk4PFuunDFFEokMOIvsNDF3TpqJiY78GTOzrBRA7dB0uWLwhIDkp4XtEJuIH6w1/dB8zjGQ1fH2IqCqee+kHa+KHaIUk7skIGGrMhnAVboIi6cKQZbbtXM2GKJyp+jz8OsT+XGsSgqnjtOavRd1pRjwU2U7gpKJQtlifl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=mVpYjunF; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=avsyoLbL; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724974204; x=1756510204;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=T+j7RRKzuWmA1q1ZqCVTtLsVcebKArnx6jNOTkQeqxQ=;
  b=mVpYjunFl1DgNsYXUC6JgLFfJ+hZUtBrIMom4xH97oywWI2zD0EVdtAa
   EJ94UUw0dkxqYe0P8z4ja+0gkgbhrW1jT5O1Gj3M9IatmVNAyIUc36RVK
   7hirbl23kl0NCpGTvPhXOHfkhnuaeXmcya19rTubnLv1hVBUATfsIYTCQ
   n3F6lxFPYnMzWssYe8Xj85pYPVDHNnlBfBPSR76kYAdA4lej1J2VWNMyI
   vWZa4+P4flKVuDKNZSB0wGCKLC82A1rXnJMPCEl8Sv3MCtLTV1tM4Awv5
   oxkNRcGVXa+M1S1XScfD2k38c6w7htPocHYYm6zbHYf4XmeMp8hNoCLc+
   Q==;
X-CSE-ConnectionGUID: DOo42BpjRWWa+/IX5EFzDA==
X-CSE-MsgGUID: NwXCKNx7S5ib2WAkOnNO0g==
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Aug 2024 16:30:03 -0700
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d441cdb503so1327345a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724974202; x=1725579002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG6xO0A35GPbOYxBbex6zJAAI0IdJmPbZ/QkQuyWeEI=;
        b=avsyoLbLukH8WLwAXUnYSJuF80whLx2PNYSvGo+G/qcXYLSAab9te1LC4pWlkVnQz8
         riHzNsnLuYn31GkdHFznsMxrVl1tMrC51DdZZZa2dogJSPPvy3HaT3wtF8eq8+8Yi5p4
         1EbcXzj0yQzdl5vrjVft0oqb69ijhyXqm8zYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724974202; x=1725579002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dG6xO0A35GPbOYxBbex6zJAAI0IdJmPbZ/QkQuyWeEI=;
        b=lz9QL9DvyuGsQAEH5gkuhR8/j1BTS/dE0YqiLccB/TVtrGb4WgrfjPxksBYC6gHIX7
         DsnqcCRPgTEtx9b5OrN0iNtxLDJNyhBx2xVqFoRQEdj35S3x6Y5HJmWpY57C52+WEotN
         dS7xYZHQzhL9pEJs02KR+C99fckaQ2FZV+aCrlvXF+MDvpiym52gPRHn2fXlKLrGZaYc
         cZJgwj2MzI7JS73QSCZZ/+q6gqdRuYqa6/N8NCBE0jv5XIV7sXtEaQkSrIxvBKP1VEWA
         JmEfi91OCFJMpHbOY68qB41jNNG8TtycM/A4DlU4UnTu8qbPfry1DjtPCfVBcovAlawn
         WBFw==
X-Forwarded-Encrypted: i=1; AJvYcCXKssIDwj1AF5NBqk6n43aRmKttJK+8a25U5bsRYW+o4dfWPPxm0dnuoCr7ZfKA5ZJFY49bGmHgeQK2xog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/g1CHZyImInfXcpv4HiDxyDj0IXuvicPc2rP0UE/SixwVdZF
	eWh9Uq8bUI9O9tVxuRJ4A8ptzOFLCKIBRCC8A/+OhIujGLYlh2EjmRJzD6DRpJeGqgvOHHv1t46
	bHqsG1YnkQtusYT4Uv4KjxPq8BYFwabUbRavAa/owvs9jCrGu4N2ask6KlkQINhhwl9FD1E5Jc8
	vqWAOvpEGzr5J5ZBUaHXj/48BV4YhlrST04o1cvXjU7qFnrSdRlhQ=
X-Received: by 2002:a17:90a:b009:b0:2d3:d7b9:2c7e with SMTP id 98e67ed59e1d1-2d8561e2311mr5153836a91.24.1724974202151;
        Thu, 29 Aug 2024 16:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf4IbX8pjDuJ17LiI0JESNcEAoJRqhux2YvDF/r066A854/JgY5hubPEp2jNebzjXmKDOTnfmPI6BBhhT4kJo=
X-Received: by 2002:a17:90a:b009:b0:2d3:d7b9:2c7e with SMTP id
 98e67ed59e1d1-2d8561e2311mr5153811a91.24.1724974201770; Thu, 29 Aug 2024
 16:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>
 <ZtAunXBPC4WElcez@pc636>
In-Reply-To: <ZtAunXBPC4WElcez@pc636>
From: Xingyu Li <xli399@ucr.edu>
Date: Thu, 29 Aug 2024 16:29:50 -0700
Message-ID: <CALAgD-4kr9MLE6jSF7pXFX9msd-NWFL8mrscvJAOecNWAYL4RQ@mail.gmail.com>
Subject: Re: BUG: WARNING in kvfree_rcu_bulk
To: Uladzislau Rezki <urezki@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is the config file:
https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd

On Thu, Aug 29, 2024 at 1:17=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> Hello!
>
> > Hi,
> >
> > We found a bug in Linux 6.10 using syzkaller. It is possibly a  task hu=
ng bug.
> > The reprodcuer is
> > https://gist.github.com/freexxxyyy/67172235de920ccf2f282f9e1179354d
> >
> > The bug report is:
> >
> > ------------[ cut here ]------------
> > ODEBUG: active_state not available (active state 0) object:
> > ffff88802526c180 object type: rcu_head hint: 0x0
> > WARNING: CPU: 0 PID: 4497 at lib/debugobjects.c:517 debug_print_object
> > lib/debugobjects.c:514 [inline]
> > WARNING: CPU: 0 PID: 4497 at lib/debugobjects.c:517
> > debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
> > Modules linked in:
> > CPU: 0 PID: 4497 Comm: kworker/0:3 Not tainted 6.10.0 #13
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: events kfree_rcu_work
> > RIP: 0010:debug_print_object lib/debugobjects.c:514 [inline]
> > RIP: 0010:debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
> > Code: d7 95 fd 4d 8b 0c 24 48 c7 c7 a0 61 a9 8b 48 c7 c6 60 5e a9 8b
> > 48 89 ea 8b 4c 24 04 49 89 d8 41 57 e8 24 1b f7 fc 48 83 c4 08 <0f> 0b
> > ff 05 88 0c c6 0a 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d
> > RSP: 0018:ffffc90002cc7a10 EFLAGS: 00010292
> > RAX: f9c69a923cadb800 RBX: ffff88802526c180 RCX: ffff88801e3cbc00
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffffffff8ba96360 R08: ffffffff8155a25a R09: 1ffff1100c74519a
> > R10: dffffc0000000000 R11: ffffed100c74519b R12: ffffffff8b4de5c0
> > R13: 0000000000000005 R14: dffffc0000000000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa7a316ef78 CR3: 000000000d932000 CR4: 0000000000350ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  debug_rcu_head_unqueue kernel/rcu/rcu.h:236 [inline]
> >  debug_rcu_bhead_unqueue kernel/rcu/tree.c:3287 [inline]
> >  kvfree_rcu_bulk+0xc5/0x4d0 kernel/rcu/tree.c:3364
> >  kfree_rcu_work+0x443/0x500 kernel/rcu/tree.c:3450
> >  process_one_work kernel/workqueue.c:3248 [inline]
> >  process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
> >  worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
> >  kthread+0x2eb/0x380 kernel/kthread.c:389
> >  ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
> >  </TASK>
> >
> Is your kernel configuration special? I mean should i have something
> truly enabled in the .config to reproduce it?
>
> Thank you for the report!
>
> --
> Uladzislau Rezki



--=20
Yours sincerely,
Xingyu

