Return-Path: <linux-kernel+bounces-552816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B146A57EAE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0A83AC0CA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6E21EB5D2;
	Sat,  8 Mar 2025 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5VtJR21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79A1DB951
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741469968; cv=none; b=ZQGRxHl5NcoLJpvzswwn5V472EEW+o5PqP5bJ0ulpLRr6HrSujX8E2b1t69mG7o5ySUokoeB76iiQS4y6LvLs9GhjrpVjNyxNfLZzQRQdnbMHXeX3Q476RAxSD0iNb7eKjfmuN96nbRiS9PXch3G9LLjKMKJ2eZa0/lhsDS3MK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741469968; c=relaxed/simple;
	bh=qyMvSJi8nw2uVrZVqGhTKLs3852gaNv8AVVCN/VNN24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYc7WDsnJHN4dTVt13VTRI7gtS2kMit9JXt554SmW7KXVI8WwLMw0D/wbYh62mLANpaD5+/zOOrCPcl64JQxqFwJy9tN57AEvATKCfM+Uj2gY3e2BMe0SFBt79fsc1r+PzYRx6atXr6K/x+67y5GDoTaq1ouUWHaPe7BzcWohrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5VtJR21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6E5C4CEE0;
	Sat,  8 Mar 2025 21:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741469968;
	bh=qyMvSJi8nw2uVrZVqGhTKLs3852gaNv8AVVCN/VNN24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5VtJR21IYWanrYE3Vwxgjmx18P+uwf6DEgEo4P4uwRDnbrxNzwt6JmLhi7ig9Ez3
	 5Uv+ChGj5T76Oxw7cvtYAffAfT1WIDa8xx/+p0TNY68fWaBInXAKJxeq60Tv3kISwk
	 txOQ4EJoF823QUMklzo0S1jbXNsAd5NajQApNPvWuvLS8nl8F9lxQeHiS89Pp8KaWK
	 LDzLWMlmXPpkkTzkYV84JBzfKrvHIH2t3f6HieoSJA4BeJt7K1ol7dTw8HLnUn+rqi
	 3nWf+yGcQO53MCPWWTxH306ohe1X9hVbPt5M9RyoMtB03rh2AbvTY+dqKKOG2z+x4h
	 KMf/0SNfkpscw==
Date: Sat, 8 Mar 2025 22:39:25 +0100
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
Subject: Re: [patch V3 01/18] posix-timers: Ensure that timer initialization
 is fully visible
Message-ID: <Z8y5DSKIsjL6QsJe@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155623.507944489@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308155623.507944489@linutronix.de>

Le Sat, Mar 08, 2025 at 05:48:10PM +0100, Thomas Gleixner a écrit :
> Frederic pointed out that the memory operations to initialize the timer are
> not guaranteed to be visible, when __lock_timer() observes timer::it_signal
> valid under timer::it_lock:
> 
>   T0                                      T1
>   ---------                               -----------
>   do_timer_create()
>       // A
>       new_timer->.... = ....
>       spin_lock(current->sighand)
>       // B
>       WRITE_ONCE(new_timer->it_signal, current->signal)
>       spin_unlock(current->sighand)
> 					sys_timer_*()
> 					   t =  __lock_timer()
> 						  spin_lock(&timr->it_lock)
> 						  // observes B
> 						  if (timr->it_signal == current->signal)
> 						    return timr;
> 			                   if (!t)
> 					       return;
> 					// Is not guaranteed to observe A
> 
> Protect the write of timer::it_signal, which makes the timer valid, with
> timer::it_lock as well. This guarantees that T1 must observe the
> initialization A completely, when it observes the valid signal pointer
> under timer::it_lock. sighand::siglock must still be taken to protect the
> signal::posix_timers list.
> 
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

