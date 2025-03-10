Return-Path: <linux-kernel+bounces-554116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C9A59330
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211083A7980
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E48224258;
	Mon, 10 Mar 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5umSw3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563F922257E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607827; cv=none; b=c0gI3wY/Crnp/vQ5GHyPNlwn7iK+5cxfWx9s9iCuw9XhHIOeYINh/r541DAVIvnFuqznAnzWO79HWXs6FWjXryIyA2ndqMvQmqAdCaDxf4gpmvPLT2MgLe7QGhDh8u2qI6fov1kBNOKIXQt74ThQhgT3R7Qatm3bTVIPKtJYCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607827; c=relaxed/simple;
	bh=15GcULUpOb7hGhUv5GIYCsVvVe8mVuOVz/m4IO0mXys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6xbfnGNCwiMtHT4BjRLPudsw8yzPDHJ6nvxIhmf4XBuMfufi9L+0/8+l97ATI0SP1GRCzvXQofvxvDAiwUWDajOmPPuGajZSRyKxx+KUWbe+bw7JfChNmdPihTF51iyD+2WigMoxgT+q00dyQmtPnMnj+X/OmHY9Ch4J65Fzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5umSw3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D03AC4CEE5;
	Mon, 10 Mar 2025 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741607826;
	bh=15GcULUpOb7hGhUv5GIYCsVvVe8mVuOVz/m4IO0mXys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5umSw3cV8FWmC7/zPIcsqhwUnhkM11yjeAX6MZmIp+QrqdTJCb4TiLeLk076gr4W
	 mFamXsx8OlNcad9G5bCetzG1x3qTAFm2P7dzkuVc8lyU/7NeN0RijvkgIAckmzK2b4
	 gdQQiifce9aS/E3wbR93BcebctKXyeCbJy1uUSOBJ2xzkXiCRfhvdtW/OnNzvzo/d6
	 cYVh7uLOvTBLa2M/Is7rhgF5CEXHWGjp/5WOSpDrXdbwmSoSfG3nb8bVryTXC3o1E5
	 Skb7WUR+3imFvkemUbJQFvUo+fKnsz9UK8VmQz/IlQGSQ5SC7jKfjzZQ5CI2pEpNti
	 V09FI4Zfy+ALw==
Date: Mon, 10 Mar 2025 12:57:03 +0100
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
Message-ID: <Z87Tj5BryQd9Rya8@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.087465658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308155624.087465658@linutronix.de>

Le Sat, Mar 08, 2025 at 05:48:34PM +0100, Thomas Gleixner a écrit :
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -63,9 +63,18 @@ static struct k_itimer *__lock_timer(tim
>  
>  static inline void unlock_timer(struct k_itimer *timr)
>  {
> -	spin_unlock_irq(&timr->it_lock);
> +	if (likely((timr)))
> +		spin_unlock_irq(&timr->it_lock);
>  }
>  
> +#define scoped_timer_get_or_fail(_id)					\
> +	scoped_cond_guard(lock_timer, return -EINVAL, _id)

I'm not really fond of the fact this hides a return.

But anyway:

Acked-by: Frederic Weisbecker <frederic@kernel.org>

