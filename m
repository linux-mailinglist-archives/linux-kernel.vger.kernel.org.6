Return-Path: <linux-kernel+bounces-336320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A7983926
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4B81C21755
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94283A09;
	Mon, 23 Sep 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISh2J9Hs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D917BCC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727127460; cv=none; b=GddRxEjFkgj0+DZJ7FWFUwe0DgXUioY2P00Z1Q8DVW+6VMQpbl/rR7N6WSCkhzYFBEyaPwz0JT4I/EyQKHlCwtYYnJenfotSaipC595Q9+hyPY6lzZTy34BPxJ4XOoD5t/A0MDUqgwHQRwuYJMI+WfNPQv1xYrUYjGT56b73VGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727127460; c=relaxed/simple;
	bh=yHFb3Z07mSyK22BXAql0EyMV20OO2A7v9cHCIFaxpgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA+3cVDm2oPQpmeYsll2uithIr87CvymlSr+vDsuPDZF9/7q4Rr82UhsTMnmPzw+n9qU7G9UBkRXore+3EYkp5wUi/1SA+X4emc/w35GX6ZTB4s1EVA45p4J3FDr4a2ZkEn7mAH36RrpprPDh8YNXNB6w+34y4eojMRpTdfpVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISh2J9Hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C51C4CEC4;
	Mon, 23 Sep 2024 21:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727127460;
	bh=yHFb3Z07mSyK22BXAql0EyMV20OO2A7v9cHCIFaxpgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISh2J9HsjWMnu9hKY2eJPxJqypfJs09BlQFcr6nhMu1s0gfnd00Ups/MZWyUUn0GP
	 +05OMMdEgasewZQRE+7xGOdzFPNEYXL+FE3sm6Bk47OkQHwaQrCQl8T8hUmz3AfvQ4
	 TSTPSJ89apobAJezkGSetRIvJSTecGsNV5E2DiSFsfI8tacAl0JVrdEtIqMBrk/sjJ
	 8b63SGO3ewAK1cXLeFTC3AL2zHZhVjO4phEXlao4dnAlbSoQTJddc6BoYSLaJ9cUtE
	 CQJQCD2bNcScGYtIzVm+rO++CF2jJcoKacp8CTQkb4kNnoYunD5QtJD/9cJMZdyWUw
	 lVXeDOvFkZkyQ==
Date: Mon, 23 Sep 2024 23:37:37 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Steven Davis <goldside000@outlook.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	tglx@linutronix.de
Subject: Re: [PATCH] irq_work: Replace wait loop with rcuwait_wait_event
Message-ID: <ZvHfoXAfGXIZPaeG@pavilion.home>
References: <87ikurhvf1.fsf@oracle.com>
 <LV3P223MB1042D6E8F26C131780375218F76C2@LV3P223MB1042.NAMP223.PROD.OUTLOOK.COM>
 <87a5fyj2sg.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5fyj2sg.fsf@oracle.com>

Le Sun, Sep 22, 2024 at 11:35:11PM -0700, Ankur Arora a écrit :
> 
> Steven Davis <goldside000@outlook.com> writes:
> 
> > On Thu, 19 Sep 2024 at 20:10:42 -0700, Ankur Arora wrote:
> >> Frederic Weisbecker <frederic@kernel.org> writes:
> >>
> >>> Le Thu, Sep 19, 2024 at 11:43:26AM -0400, Steven Davis a écrit :
> >>>> The previous implementation of irq_work_sync used a busy-wait
> >>>> loop with cpu_relax() to check the status of IRQ work. This
> >>>> approach, while functional, could lead to inefficiencies in
> >>>> CPU usage.
> >>>>
> >>>> This commit replaces the busy-wait loop with the rcuwait_wait_event
> >>>> mechanism. This change leverages the RCU wait mechanism to handle
> >>>> waiting for IRQ work completion more efficiently, improving CPU
> >>>> responsiveness and reducing unnecessary CPU usage.
> >>>>
> >>>> Signed-off-by: Steven Davis <goldside000@outlook.com>
> >>>> ---
> >>>>  kernel/irq_work.c | 3 +--
> >>>>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> >>>> index 2f4fb336dda1..2b092a1d07a9 100644
> >>>> --- a/kernel/irq_work.c
> >>>> +++ b/kernel/irq_work.c
> >>>> @@ -295,8 +295,7 @@ void irq_work_sync(struct irq_work *work)
> >>>>  		return;
> >>>>  	}
> >>>>
> >>>> -	while (irq_work_is_busy(work))
> >>>> -		cpu_relax();
> >>>> +	rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work), TASK_UNINTERRUPTIBLE);
> >>>
> >>> Dan Carpenter brought to my attention this a few weeks ago for another problem.:
> >>>
> >>> perf_remove_from_context() <- disables preempt
> >>> __perf_event_exit_context() <- disables preempt
> >>> -> __perf_remove_from_context()
> >>>    -> perf_group_detach()
> >>>       -> perf_put_aux_event()
> >>>          -> put_event()
> >>>             -> _free_event()
> >>>                -> irq_work_sync()
> >>
> >> irq_work_sync() is also annotated with might_sleep() (probably how Dan
> >> saw it) so in principle the rcuwait_wait_event() isn't wrong there.
> >
> > The might_sleep() annotation does seem to indicate a preempt context.
> 
> Yeah, and that is one of the problems with might_sleep(), cond_resched()
> etc. They can get out of sync with the surrounding code or code paths.
> 
> In this case, this could might mean that maybe the annotation is wrong
> and should be removed. So, it might be worth looking at the calling
> paths a bit closer to see if calling schedule() is really safe in all
> of these contexts.
> 
> And, if all the other contexts are safe, then it would be a good idea
> to fix the perf_remove_from_context() since with this patch, we might
> end up scheduling in spinlock context.

After a second look, I think this path is fine. If an aux event is
being unlinked, this means that it hasn't been removed from the context
yet. So it can't be the last reference to it causing a call to _free_event().

So it _looks_ good after all.

Thanks.

