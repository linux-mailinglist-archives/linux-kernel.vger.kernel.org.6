Return-Path: <linux-kernel+bounces-523156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BBEA3D2D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9191D1751CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998EE1E9B35;
	Thu, 20 Feb 2025 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rlJGFKqK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fU1qmEQl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488B1E9B2A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039147; cv=none; b=UhSFBOgyA0lyI1jBGzCccYdW8sKOPa46euJc0W5vIBBbYLLEyt8jvBdeWgk6p0k9lNq09uYIi65B/EF0t7R21DPTw4JxNoZl0X0CI+qjpZExHN4YqeqFvByXCYW6yvSJt7Xcxbd2DlHHm2ZZNMuYzoZ9WAHgk4sIsB1TRmmKRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039147; c=relaxed/simple;
	bh=H3tFC200g8yvVKGoWYBP6BDYu/3DGTGmDR2JGI04DSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B1jIFDKkDeMruOiolHjUbojNWkwl5uc4OJKBnH3HAf0FbJq+NglLrO0EPtOGjvV95GxjEjFXA7pMgngr38c5kCsBgUlq5DlQOZt5490q4VNqnCukBgRWPGdX7z5Rr9KRCA9XvwE/Bd+7R59yYVa7c4Zbr6ALC1BYluPeg4N5OwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rlJGFKqK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fU1qmEQl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740039143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NY4yXpe1ZjPgFcfvLmakZ3jQqRumnHseJKr7+agy5OM=;
	b=rlJGFKqKRgeuzM9kRnnEnMIQGT8VB19SaK7Kc+hrBH6M44X91NAwsknUCbVLVI/UMTE9tE
	10OhqxT4NtjTqX+Y8cqWY4tePgwr0IMOJnAyjCu+mkjM7+k4Unc3GbTs1g9yna6KwEYXfn
	S8ytNMgeoqxhicWUFCNOGqtoRMMumoIvXQqCcRHMm5H6aIyyJMXJ7j1apWFmMmcUdo2qk9
	X3RIrc5Fq/G7As1nSh8FdY4o5/J6rIIJXJyQgEhK26l46nO9IItnnE1mvahVC+lHHX/IiR
	TXnx2Mfu4YwR8shQA16aYllSdupjId5zIrPLu7L64zvkC3uOHUJI4WP+1YUa3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740039143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NY4yXpe1ZjPgFcfvLmakZ3jQqRumnHseJKr7+agy5OM=;
	b=fU1qmEQlLkv+RsYnJujB47z1j+7Z9zea/C2RH/hspKCQyafnya8AkYA+JuFWqm2hg1OyKA
	D882TlkcEZ5/uSDA==
To: Eric Dumazet <edumazet@google.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall
 <bsegall@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH V2 2/4] posix-timers: Initialise timer->it_id in
 posix_timer_add()
In-Reply-To: <20250219125522.2535263-3-edumazet@google.com>
References: <20250219125522.2535263-1-edumazet@google.com>
 <20250219125522.2535263-3-edumazet@google.com>
Date: Thu, 20 Feb 2025 09:12:22 +0100
Message-ID: <87tt8phw61.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 19 2025 at 12:55, Eric Dumazet wrote:
> A timer is visible only when both timer->signal and timer->i_id
> are set to their final values.
>
> We can initialize timer->it_id sooner.

This changelog tells nothing. What is this fixing, why is it required to
initialize this sooner?

We can... We also can not ... Aside of that please write changelogs in
imperative mood as Documentation asks for.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  kernel/time/posix-timers.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 204a351a2fd3..1f73ea955756 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -114,6 +114,7 @@ static int posix_timer_add(struct k_itimer *timer)
>  
>  		spin_lock(&hash_lock);
>  		if (!__posix_timers_find(head, sig, id)) {
> +			timer->it_id = (timer_t)id;
>  			hlist_add_head_rcu(&timer->t_hash, head);
>  			spin_unlock(&hash_lock);
>  			return id;
> @@ -407,8 +408,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
>  
>  	/*
>  	 * Add the timer to the hash table. The timer is not yet valid
> -	 * because new_timer::it_signal is still NULL. The timer id is also
> -	 * not yet visible to user space.

Even with this change the timer ID is not yet visible to user space
because it has not yet been copied back ....

Thanks,

        tglx

