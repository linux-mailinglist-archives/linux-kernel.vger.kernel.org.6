Return-Path: <linux-kernel+bounces-376830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07789AB66D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773FE1F2436D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945161CB304;
	Tue, 22 Oct 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VATH7HN+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A112F5B3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624144; cv=none; b=BvKpjLjyo+VMEEKp9Gb6xn6huux1kfE3KknMzCIrRNNa5maxUw7/FgQOBp+bJTOrdlJHQB+NmxAui8/7mE7QsvGDN9+6ga9uMt4TxduDXDH5h+df2r27iW9lYUpZTtwc9eq+dZgghmLVoqS062qV3rbX4AqrU07Uncq/+HTd8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624144; c=relaxed/simple;
	bh=Yr6qFGLIflKq8F2evrxkvRbHa7eFxw9BBwytrFb5BdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/vMyMneTtYNoXg5Bh2JGLccDUO1EjE/m2+azFO78IV2bguf+336MCVxhofmLR9E+uCcRNFlZmuqVh/1Fj50S1mUYfdvvLcbFKBcDiicXUjT7wTd2gj7WOLaaK3RQaqG/zEtKn0M9dhqfnzc8kQ1HkCIWExDr+Iid5y3/x0Ifd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VATH7HN+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=M0PCrMbZo0p6XlDWb3SmLjbUR5gzWjACLcUDnZuTrfI=; b=VATH7HN+gXmaKpVnTH+0iMZMwy
	68SbcDdKwfKaLnDN1YmPwy6nIZerSw42wYWtXBOqzr2HN+utT0V2fTBrLJj2qayL7p403cDXSQIXf
	dE1Q1unONKSLVy/a7bBrPkjCL+Julj8xeN7o2Y8Jt1GW3Q8+J9y8fd990Y+iVNfHq0ZLQoSN3QFjF
	LwxcaKB2X7ocP96oR8tiwaY0NHzAMy9jQQZqSEji9WVfz7ulY1AoT8bxhJW8wbjSuFRVt/yQjntE4
	zEeEax+cl1wCID8fUpAFIzLL9zZdJCKGFcy3u37gU6dgqAfjDDylpWALCuvsNOkRrCeZG0CQj5jwC
	F8OaOvMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3KFU-00000001vly-0TMN;
	Tue, 22 Oct 2024 19:08:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 926DB30073F; Tue, 22 Oct 2024 21:08:55 +0200 (CEST)
Date: Tue, 22 Oct 2024 21:08:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: syzbot <syzbot+4abde9163a953b8a0fd0@syzkaller.appspotmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
	mingo@kernel.org, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de, longman@redhat.com
Subject: Re: [syzbot] [kernel?] WARNING in task_work_add
Message-ID: <20241022190855.GA9657@noisy.programming.kicks-ass.net>
References: <6717300e.050a0220.1e4b4d.006e.GAE@google.com>
 <Zxexd7nd3k8CM51w@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zxexd7nd3k8CM51w@localhost.localdomain>

On Tue, Oct 22, 2024 at 04:06:47PM +0200, Frederic Weisbecker wrote:
> Adding scheduler people in Cc.
> 
> Thanks.
> 
> Le Mon, Oct 21, 2024 at 09:54:38PM -0700, syzbot a écrit :
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    9ec59cb3edc7 KVM: arm64: Shave a few bytes from the EL2 id..
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17061430580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c154e2d4db830898
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4abde9163a953b8a0fd0
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > userspace arch: arm64
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/fc9a7d36d46a/disk-9ec59cb3.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/30547ddd681e/vmlinux-9ec59cb3.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/5c4e02d0f97a/Image-9ec59cb3.gz.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4abde9163a953b8a0fd0@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next_frame_record_meta arch/arm64/kernel/stacktrace.c:216 [inline]
> > WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline]
> > WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline]
> > WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline]
> > WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline]
> > WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 arch_stack_walk+0x458/0x48c arch/arm64/kernel/stacktrace.c:404
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 1 Comm: init Not tainted 6.12.0-rc3-syzkaller-g9ec59cb3edc7 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : kunwind_next_frame_record_meta arch/arm64/kernel/stacktrace.c:216 [inline]
> > pc : kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline]
> > pc : kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline]
> > pc : do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline]
> > pc : kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline]
> > pc : arch_stack_walk+0x458/0x48c arch/arm64/kernel/stacktrace.c:404
> > lr : 0x0
> > sp : ffff8000800176a0
> > x29: ffff800080017750 x28: 1ffff00010002f58 x27: 00000000ffff8d68
> > x26: dfff800000000000 x25: ffff0000c2c588c0 x24: dfff800000000000
> > x23: ffff700010002ef0 x22: ffff800080017850 x21: ffff8000800176b8
> > x20: ffff800080462114 x19: ffff8000800177a0 x18: dfff800000000000
> > x17: ffff800123f21000 x16: ffff80008b490b1c x15: 0000000000000001
> > x14: 1fffe000366c806a x13: ffff800097807ff0 x12: ffff800097808000
> > x11: 0000000000000000 x10: ffff0000c1978000 x9 : ffff800097807e9f
> > x8 : ffff800097807fd8 x7 : 0000000000000000 x6 : 000000000000003f
> > x5 : 0000000000000040 x4 : fffffffffffffff0 x3 : 0000000000000000
> > x2 : ffff0000c1978000 x1 : ffff800080029c40 x0 : 0000000000000001
> > Call trace:
> >  kunwind_next_frame_record_meta arch/arm64/kernel/stacktrace.c:216 [inline] (P)
> >  kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline] (P)
> >  kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline] (P)
> >  do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline] (P)
> >  kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline] (P)
> >  arch_stack_walk+0x458/0x48c arch/arm64/kernel/stacktrace.c:404 (P)
> >  0x0 (L)
> >  stack_trace_save+0xfc/0x1a0 kernel/stacktrace.c:122
> >  kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
> >  __kasan_record_aux_stack+0xd0/0xec mm/kasan/generic.c:541
> >  kasan_record_aux_stack+0x14/0x20 mm/kasan/generic.c:546
> >  task_work_add+0xb8/0x464 kernel/task_work.c:66
> >  task_tick_mm_cid kernel/sched/core.c:10468 [inline]
> >  sched_tick+0x2a8/0x404 kernel/sched/core.c:5605

I'm guessing this is very close to what 73ab05aa46b0 ("sched/core:
Disable page allocation in task_tick_mm_cid()") does. Initial version of
that patch was more aggressive and killed off the whole KASAN thing
instead of just the page-alloc.

Is that what is needed here? I'm very glad to shoot that stuff in the
head.

