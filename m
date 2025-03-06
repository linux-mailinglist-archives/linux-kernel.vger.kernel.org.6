Return-Path: <linux-kernel+bounces-548468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF5A54540
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F08216CFD2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2961A2C04;
	Thu,  6 Mar 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjCmsqOy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9752E3369
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250833; cv=none; b=gAKt36vGHSnMygubvKfDtSNnK5MQISl0qh47/ElDB2IucIFPgSpOyETuijlV4yynUOMKcqjADpvWSEERvdxgh/p8Y39LQl0ltA0Vuvk/RSxBihw2JZI8onAvWV6YqmdDevZ7hbTkh3AffSKD1JixBKtoDgnSkwA3lzg0SBnMNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250833; c=relaxed/simple;
	bh=ekHnDyY/WSnR0840A0KvueB+ZkTH7DG7cso/RGbl9kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbWr+tVJIeOkP+V0PMG2Yagqw43NKbjr5Jij3VPlhNawkwy6KB+g4ekoYRN8F/87xmnB6ba/9bcoPQHu2u57/eNd6QN3R6jC9JkoumnND0YCKxJXcHWA21In64o9ozFDrBr4rb0TZ6LkBkJvHGMQFioK28/2eKKbYutDj0p1Juo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjCmsqOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA43C4CEE0;
	Thu,  6 Mar 2025 08:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741250832;
	bh=ekHnDyY/WSnR0840A0KvueB+ZkTH7DG7cso/RGbl9kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjCmsqOy4fTD4R8iAMNrhc5m6BszBZzPK3ibv2+1GbmqOhxNTRX3F/BmuKkpItcR2
	 Qge1fMJRSLURZ2q3PzCSncooBZumFNxUCZmu7Ha7hRTaveA+GpX/T2kZ+j9X0PxrsL
	 JvN6zxIpwb43hO/fOpTtbxdEp0DzoN1pF/3U1QIWe10IMk14UOHQ5JL7IqUm6rZA4Z
	 zZgceKmoAyU8wkphAbTc9iaqWBCI5xiq0gX1qNabQ2ukMqWwJfoL1SsPex4DmxEtjn
	 reytGUNVP0DjnBS2xd7v/J7dT0sYWagtC6c8vPXfc8EGWckdmtYnCe6aXkztp7n9u1
	 r5aCWJcuUgRng==
Date: Thu, 6 Mar 2025 09:47:10 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 01/17] posix-timers: Initialise timer before adding it
 to the hash table
Message-ID: <Z8lhDhfmjcla+Dzq@lothringen>
References: <20250302185753.311903554@linutronix.de>
 <20250302193626.974094734@linutronix.de>
 <Z8iJBXFQLUkcndsI@localhost.localdomain>
 <875xkm60m6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xkm60m6.ffs@tglx>

On Thu, Mar 06, 2025 at 09:10:09AM +0100, Thomas Gleixner wrote:
> On Wed, Mar 05 2025 at 18:25, Frederic Weisbecker wrote:
> > Le Sun, Mar 02, 2025 at 08:36:44PM +0100, Thomas Gleixner a écrit :
> > Looking at this more or less lockless whole thing again, is the
> > ordering between creation and subsequent operations sufficiently guaranteed?
> >
> >     T0                                                T1
> > ---------                                             -----------
> > do_timer_create()
> >     posix_timer_add()
> >         spin_lock(hash_lock)
> >         // A
> >         timer->it_id = ...
> >         spin_unlock(hash_lock)
> >     // Initialize timer fields
> >     // B
> >     new_timer->.... = ....
> >     common_timer_create()
> >         // C
> >         hrtimer_init()
> >     spin_lock(current->sighand)
> >     // D
> >     WRITE_ONCE(new_timer->it_signal, current->signal)
> >     spin_unlock(current->sighand)
> >                                                       do_timer_settime()
> >                                                           lock_timer()
> >                                                               // observes A && D
> >                                                               posix_timer_by_id()
> >                                                               spin_lock_irqsave(&timr->it_lock)
> >                                                               // recheck ok
> >                                                               if (timr->it_signal == current->signal)
> >                                                                   return timr
> >                                                               common_timer_get()
> >                                                                   // fiddle with timer fields
> >                                                                   // but doesn't observe B
> >                                                                   // for example doesn't observe SIGEV_NONE
> >                                                                   sig_none = timr->it_sigev_notify == SIGEV_NONE;
> >                                                                   ...
> >                                                                   // doesn't observe C
> >                                                                   // hrtimer_init() isn't visible yet
> >                                                                   // It might mess up after the hrtimer_start()
> >                                                                   hrtimer_start()
> 
> Pretty far fetched and I did not think it fully through whether it can
> really happen. But that's trivial enough to solve without this
> hlist_hashed() indirection:
> 
> +      spin_lock(new_timer->lock);
>        spin_lock(current->sighand);
>        WRITE_ONCE(new_timer->it_signal, current->signal);
>        spin_unlock(current->sighand);
> +      spin_unlock(new_timer->lock);
> 
> Simply because the release of timer::lock guarantees that the memory
> operations before the release have been completed before the release
> completes.
> 
> Consequently the other CPU must observe a consistent set A - D after it
> acquired the lock.
> 
> No?

Right that's why I added that in my proposed fix and it's the really important
part.

As for the rest, it's just a matter of taste. Checking
timer::it_signal && timer::list instead of flipping a bit in a pointer and
rely on magic comparison seemed to me clearer and easier to follow but that's
just a proposal, I won't mind either way.

Thanks.

> 
> Thanks,
> 
>         tglx

