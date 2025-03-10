Return-Path: <linux-kernel+bounces-555201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D42A5A6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C891739A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9799E1E3DDE;
	Mon, 10 Mar 2025 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQi5Npox"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673F382
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644968; cv=none; b=Pz1ifeePBcMlP7thEyza+as4qAWPzKGlUjSjqxJ4pIY2gM8FJ3DSm6axMSVcWIF23aLFK/mbQRYGVUn9iarMGNyoJsz5DFg81/aHpoqP9wOFuPyGqqKDNelg+7EsF+OwZJJlf3W479HWni3owbvLdSSzEecUaiwhuf5oeMW87+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644968; c=relaxed/simple;
	bh=2lznBsKOnCQhwBSX9JGDubxasXvqODxFZfIiQ63hg7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWv17CWrRH/TbpZhhCofBYNUUa/5zp4pNiHAaaAcudeXxOAVUhIGA1XgLQt+bnY3kb9qN7c1znsN1O8yfQfJk07e2KP6TPjZP0yyEj/VSrLE2ljh5MvmXd2z4HiXymWxGbWPx4VaZ9WO5GT4IxC6/Gl6MXJ0CKXLK3I2I6HEcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQi5Npox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0ACC4CEE5;
	Mon, 10 Mar 2025 22:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741644967;
	bh=2lznBsKOnCQhwBSX9JGDubxasXvqODxFZfIiQ63hg7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQi5NpoxEp6tPlVC9XHg7z+BNOpnF1S47+ZvBurBXrpBxdR27zSGU2Mqz7N0MZi5W
	 PyYfBTebUFimR3ORgJAXSVssrOy2r3b6+mVd92A115VxJdKFKTFKIDv/tXwqU9ufXY
	 ri5DUtapaqEPI33kNqONgNNHXibGDkOqPjeRlVloF0b4/f+ocOHlny5ergUS1WzhoA
	 0ag5h+jyHmnJ6G+MOgYKTONgG1/YsmrQ5Hq0tQQ3Axs7DhVdWgfwVBV6edlIRWNLIo
	 hAIXZXjUrtgNTyLP1+gxR4lorQOSnjmhGjr6rUytZz9BgOzgGrnSvRRoDEh6uS7Pm2
	 Js3U2fhqgFLPQ==
Date: Mon, 10 Mar 2025 23:16:04 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 10/18] posix-timers: Make lock_timer() use guard()
Message-ID: <Z89kpLzck5w7gVxi@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.087465658@linutronix.de>
 <Z87Tj5BryQd9Rya8@pavilion.home>
 <87o6y823fx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6y823fx.ffs@tglx>

Le Mon, Mar 10, 2025 at 06:36:18PM +0100, Thomas Gleixner a écrit :
> On Mon, Mar 10 2025 at 12:57, Frederic Weisbecker wrote:
> > Le Sat, Mar 08, 2025 at 05:48:34PM +0100, Thomas Gleixner a écrit :
> >> --- a/kernel/time/posix-timers.c
> >> +++ b/kernel/time/posix-timers.c
> >> @@ -63,9 +63,18 @@ static struct k_itimer *__lock_timer(tim
> >>  
> >>  static inline void unlock_timer(struct k_itimer *timr)
> >>  {
> >> -	spin_unlock_irq(&timr->it_lock);
> >> +	if (likely((timr)))
> >> +		spin_unlock_irq(&timr->it_lock);
> >>  }
> >>  
> >> +#define scoped_timer_get_or_fail(_id)					\
> >> +	scoped_cond_guard(lock_timer, return -EINVAL, _id)
> >
> > I'm not really fond of the fact this hides a return.
> 
> I could drop the macro and let the call sites all do:
> 
> 	scoped_cond_guard(lock_timer, return -EINVAL, $d)
> 
> But I'm not sure it's much better :)

Nah let's just keep it as is, until we ever find a better idea :-)

