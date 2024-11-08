Return-Path: <linux-kernel+bounces-402348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F219C26A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8631F2192D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F931D0E04;
	Fri,  8 Nov 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n13RfQyY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1C1C1F22
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098197; cv=none; b=RQHTsAgnn+QvPWdS5jQTRi/urz/AbLmD55pc1DAlWNx9FuUgTsa8A9Cc3yxg/LYWeJLCteyXzsywMLbNvzfDjiGkyaKkdc2ntc5cCd55jpoFYEawdEXNLQkeQ8JDQt/jWYUxof/jfNiPG4ZaLdlz8qjsXZP0TPq0vwUhZamXTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098197; c=relaxed/simple;
	bh=7ij5ymWC+U7rekFoYfd1SOQ4pW3pdVsIxhT4D89UZ9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isEbzl7bdhJyrEjhdF6Yc9gWpj7LAyoNU7dN7LLMvJidaA0smWvFVtAQvLE/wp4z0SJ5dPkuKYizoyP2g78im/odK56y2Hg4bsvAO6Gh4pifHQugvun4cfWNNWwLyMDPHUbDfqN+dOqsaGNW/h+cHaHqpEV0lsh0MNrza4bJ/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n13RfQyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552DFC4CECD;
	Fri,  8 Nov 2024 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731098197;
	bh=7ij5ymWC+U7rekFoYfd1SOQ4pW3pdVsIxhT4D89UZ9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n13RfQyY3Qe0rYJ/Lj7017ULcCGLBxxBQ4sMpzt+faEZp0CdVsM0WvrWIXldJANXk
	 bDNfmZKeAeNa4+MHE045wRbWKldP8bMn98IwaBwHipZmJYJjNo1kseSsjrQ0Kh7PDd
	 IEiD5AVylHLDIqVPMZH6OSxWyTePG3vWY2Pd70L+JRGOLD/KbX/To8Ik87GkQGGi4B
	 mSZnn7SwuUyLx//YHfqmeSSWULqvQe07gYmXpNWErBFHX8g3yzGuP+0PETIQ3BhM4/
	 Goj3+cDaTyt4GkUyQqZ80ZWHN+PY/3Vh4KcLXu4DXl919bDKPueRbxDZyoy4bqI3FJ
	 gqADNMZdNcM1A==
Date: Fri, 8 Nov 2024 10:36:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@meta.com, kernel-team@meta.com,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH sched_ext/for-6.12-fixes] sched_ext: Call
 __balance_callbacks() from __scx_task_iter_rq_unlock()
Message-ID: <Zy52VDrG48EgrbtS@slm.duckdns.org>
References: <ZyKoE9RUulWtYpEh@slm.duckdns.org>
 <20241031233634.GU14555@noisy.programming.kicks-ass.net>
 <20241101141218.GV33184@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101141218.GV33184@noisy.programming.kicks-ass.net>

Hello, Peter.

Sorry about the delay.

On Fri, Nov 01, 2024 at 03:12:18PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 01, 2024 at 12:36:34AM +0100, Peter Zijlstra wrote:
> > On Wed, Oct 30, 2024 at 11:41:39AM -1000, Tejun Heo wrote:
> > 
> > > --- a/kernel/sched/ext.c
> > > +++ b/kernel/sched/ext.c
> > > @@ -1315,6 +1315,8 @@ static void scx_task_iter_start(struct s
> > >  static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
> > >  {
> > >  	if (iter->locked) {
> > > +		/* ->switched_from() may have scheduled balance callbacks */
> > > +		__balance_callbacks(iter->rq);
> > >  		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
> > >  		iter->locked = NULL;
> > >  	}
> > 
> > I think you need to unpin/repin around it. The balance callbacks like to
> > drop rq->lock at times.
> 
> Maybe something like so.. I'm not sure it's an improvement.

I actually easily reproduce the problem by making tasks switch between DL
and SCX. e.g. If I run `stress-ng --schedmix 32` while running any SCX
sched:

  rq->balance_callback && rq->balance_callback != &balance_push_callback
  WARNING: CPU: 5 PID: 2784 at kernel/sched/sched.h:1729 do_sched_yield+0x10a/0x130
  ...
  Sched_ext: simple (enabling+all)
  RIP: 0010:do_sched_yield+0x10a/0x130
  Code: 84 66 e8 7e e8 07 a2 f0 00 48 83 c4 08 5b 41 5e 5d e9 0a 4f f1 00 cc c6 05 09 fb3
  RSP: 0018:ffffc900030c3ef0 EFLAGS: 00010082
  RAX: 0000000000000046 RBX: ffff8887fab70380 RCX: 0000000000000027
  RDX: 0000000000000000 RSI: ffffffff811def79 RDI: ffff8887fab5b448
  cb=0xffff8887fad5b040
  RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
  R10: ffffffff811dee91 R11: 0000000000000000 R12: 0000000000000000
  R13: 0000000000000000 R14: ffff8887fab40000 R15: 0000000000000018
  FS:  00007fc8772d8000(0000) GS:ffff8887fab40000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00005607f90c3078 CR3: 000000012aa1c000 CR4: 0000000000350eb0
  Call Trace:
   <TASK>
   __x64_sys_sched_yield+0xa/0x20
   do_syscall_64+0x7b/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7fc87a30ea8b
  Code: 73 01 c3 48 8b 0d 85 72 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 008
  RSP: 002b:00007ffde081a928 EFLAGS: 00000202 ORIG_RAX: 0000000000000018
  RAX: ffffffffffffffda RBX: 00007fc86ee1ab18 RCX: 00007fc87a30ea8b
  RDX: 0000000000000001 RSI: 000000000000001f RDI: 000000000000001b
  RBP: 00007ffde081ab90 R08: 000000000000001b R09: 00000000000003e8
  R10: 00007ffde081a8f0 R11: 0000000000000202 R12: 0000000000005b81
  R13: 00000000000061e8 R14: 0000000000000000 R15: 0000000000000003
   </TASK>

and your patch makes the issue go away. Please feel free to add:

 Tested-by: Tejun Heo <tj@kernel.org>

If you want me to turn it into a proper patch and apply it, plesae let me
know.

Thanks.

-- 
tejun

