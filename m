Return-Path: <linux-kernel+bounces-437753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B5C9E980C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BF82829F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C291ACEBC;
	Mon,  9 Dec 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XP/5xzYl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E64233148
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752879; cv=none; b=hdu9ZdUxEd3+Kzix2gZPze26K428x+f9WvNzC+N9s40nkhK/mB3vtmalWbl8r9prJl2lr0sX6ITfPNHOX/rWxU9RvZ5mXPYxipg4WPo+KcsIVDorJHrdXay0Zpv03uHFX5HwS9F5vgRhOksl4nO90+HJaH/MuBAYp1GYnrO4tD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752879; c=relaxed/simple;
	bh=14YlV9NrsLPm7TVQWgaoOmLZkY7F6T3Zb8KkHetbe+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpCIdSjXwtqoc8H03wclDEIAh1m5X8p29VyhXTn2yTPib9rXmerlufzGTchC7VWjIRbr1xBh2qEWnwk94DYPROGNrXTmAK2aB+LiV70crVwn5FF2LSyhqLI0VRN4jSLMNG0Ek7hxOnb2PkCwqogSnlkPs9FuwPJSb8sTsgNS710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XP/5xzYl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GQ1Np9bGKBUwwVJUtt6tML1S1juKCMRuYzs/LBonOuk=; b=XP/5xzYljQT1zd12YqRvmVNiFW
	3tKo6TGyVvW+q0y3JAUJ/zn9OeCo/wMFWtK3hQeSlOe+1VJAoBs9B55LbaXlIbO0NaLeKPpSFeuhW
	e4TtBmc5/Iq5ohkuIPQb79wiX/M1ekYokwOruodo3hIC0oGZyb/wBKekpCpwuRAYbH7oCsSH9L485
	XjV7S2pqz1ICtj+BtVfHNW9KrogLyXHoCc/cH8pSCT/fyLrq6IM36GLoutD6RWJCnTICaP+qhxhmY
	MCFsGX5Q/+8zhL1Y8CNjhlMY5P5sw78uB67LAyaJCODxiB3bElqvvSpejOyp5aSx061G0F01/HPeM
	J2InQe2w==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKeJx-00000002TdJ-3Tnu;
	Mon, 09 Dec 2024 14:01:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F1F2F3003FF; Mon,  9 Dec 2024 15:01:08 +0100 (CET)
Date: Mon, 9 Dec 2024 15:01:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com,
	shraash@google.com, marcel.ziswiler@codethink.co.uk
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
Message-ID: <20241209140108.GL8562@noisy.programming.kicks-ass.net>
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
 <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net>
 <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
 <20241209125601.GQ35539@noisy.programming.kicks-ass.net>
 <CAO7JXPj6_VF+T1ykwQsCmBjVhHQdpX0wJssPPRYOazJcciCCyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO7JXPj6_VF+T1ykwQsCmBjVhHQdpX0wJssPPRYOazJcciCCyA@mail.gmail.com>

On Mon, Dec 09, 2024 at 08:56:43AM -0500, Vineeth Remanan Pillai wrote:

> > So the scenario I had in mind was that we were doing something like:
> >
> >         current->state = TASK_INTERRUPTIBLE();
> >         schedule();
> >           deactivate_task()
> >             dl_stop_server();
> >           pick_next_task()
> >             pick_next_task_fair()
> >               sched_balance_newidle()
> >                 rq_unlock(this_rq)
> >
> > at which point another CPU can take our RQ-lock and do:
> >
> >         try_to_wake_up()
> >           ttwu_queue()
> >             rq_lock()
> >             ...
> >             activate_task()
> >               dl_server_start()
> >             wakeup_preempt() := check_preempt_wakeup_fair()
> >               update_curr()
> >                 update_curr_task()
> >                   if (current->dl_server)
> >                     dl_server_update()
> >                       enqueue_dl_entity()
> >
> >
> > Which then also goes *bang*. The above can't happen if we clear
> > current->dl_server in dl_stop_server().
> >
> I also thought this could be a possibility but the previous deactivate
> for this task would have cleared the dl_server no? 

That gets cleared in put_prev_set_next_task(), which gets called *after*
pick_next_task() completes. So until that time, current will have
dl_server set.

> Soon after this in
> update_curr() we again call dl_server_update if p_.dl_server !=
> rq->fair_server and this is also another possibility of a double
> enqueue.

Right, there's few possible paths there, I've not fully mapped them. But
I think clearing ->dl_server in dl_server_stop() is the cleanest option
for this.


> This should work as well. I was planning to send a second patch with
> the dl_server active flag as it was not strictly the root cause of
> this. But the active flag serves the purpose here and this change
> looks good to me :-). I will test this on my end and let you know. It
> takes more than 12 hours to reproduce in my test case ;-)

Urgh... Thanks!

