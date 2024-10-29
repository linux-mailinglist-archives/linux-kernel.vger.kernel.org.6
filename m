Return-Path: <linux-kernel+bounces-387318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B79B4F65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE40284380
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9DC199E84;
	Tue, 29 Oct 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li0Nwsw7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD481953BD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219645; cv=none; b=VRz8n3/WG3VzAq5api6UJ+3/DdBoX3LC0SE2ZKk1dMoW92eDtbZrHgSap1TJbOH43CHylhLg7nblMl4lkaf7YgJTmRKQVtAhnXsoOSEjdhGgCtZUyHinin84h4S6xBBi+/zWyfNEJ3KaskoJEh/wmByT16QnvvADkbpwKbeiF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219645; c=relaxed/simple;
	bh=OQrRX425YErf6WBAlS31+n1TMuwI9ESjLwYvILN6+ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjmRzGqQECswhRNiS8ZJNT+EWBhkon4jyQBmUW7KnwUZS/O3HTQp3oroBom71Cu+DxFxsArRMTPFw86VFef9ovz53MaseCeEYN2gC7WWYEEjXxVHmgMIGkfejF9zqxweSCW7F20rOQIHBkYLJu401pfTrZGkMUfFf8YjyUSbm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li0Nwsw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18ACC4CECD;
	Tue, 29 Oct 2024 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730219645;
	bh=OQrRX425YErf6WBAlS31+n1TMuwI9ESjLwYvILN6+ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Li0Nwsw7czzmjgKw+cyoJIe4YK+pXszWEXybTj9Sz96rkVV1wjXBq7lnqbbO03aQ3
	 C0nh8kg6vWo7mG8N8TCYyENTI2yn1fuy9fqkTrml/cZzMoKYVmRQ1WGt68yd6oF4wR
	 rnLMws8bzlSCvmQF1a9YaWmwU0Zs6fcTJyTVKBbreiG05mKAHHJmbPpBLBpKptgbpu
	 W899QYjAmKJ/YDEluDGxrHyvcEaDDKdmwX6elobz5kAg0EEWG7ePmi7voJkl8YQWEj
	 828c6B3VPfEVFuktFRfDP+/XBKbSUquJtFxb/YlpX4AsNe/JxLDQdzbePSFkdBTXsM
	 8YdKmewloc74w==
Date: Tue, 29 Oct 2024 17:34:02 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 16/26] signal: Replace resched_timer logic
Message-ID: <ZyEOeqkSYWR2XTp_@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.220867629@linutronix.de>
 <ZyEFyV28jcz85V1q@localhost.localdomain>
 <87ttcu281y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttcu281y.ffs@tglx>

Le Tue, Oct 29, 2024 at 05:22:17PM +0100, Thomas Gleixner a écrit :
> On Tue, Oct 29 2024 at 16:56, Frederic Weisbecker wrote:
> >> @@ -568,10 +568,10 @@ static void collect_signal(int sig, stru
> >>  		list_del_init(&first->list);
> >>  		copy_siginfo(info, &first->info);
> >>  
> >> -		*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
> >> -				 (info->si_code == SI_TIMER);
> >> -
> >> -		__sigqueue_free(first);
> >> +		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code == SI_TIMER)))
> >> +			*timer_sigq = first;
> >> +		else
> >> +			__sigqueue_free(first);
> >
> > So this isn't calling __sigqueue_free() unconditionally anymore. What if
> > the timer has been freed already, what is going to free the sigqueue?
> 
> __sigqueue_free() does not free timers marked with SIGQUEUE_PREALLOC.
> 
> sigqueue_free() takes care of that, which is invoked from
> posixtimer_free_timer(). It clears SIGQUEUE_PREALLOC and if it is queued
> it lets it pending and delivery will free it.

But the delivery freeing used to be done with the __sigqueue_free()
above, which doesn't happen anymore, right?

> 
> That's not any different from before this change.
> 
> Though thinking more about it. As we drop the signal in that case
> anyway, we could remove it from pending in sigqueue_free() directly. Let
> me look into that.

Ok.

Thanks.

> 
> Thanks,
> 
>         tglx

