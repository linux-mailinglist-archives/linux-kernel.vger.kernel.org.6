Return-Path: <linux-kernel+bounces-556215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB92A5C28B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BB7188EF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542A1B87EE;
	Tue, 11 Mar 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC67s6y9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B474BED
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699517; cv=none; b=oy1ZRd+GW0XaGN4rpg2fkWNFUmeOU7dXyxM7y5jdYUkVB6wVC5b6h0usQjIovFAiZv1BznH3zL717SfGRECtkYcwLPkOy/JBitzmgchAbWePaqwnaQSe/aXKvgunoxp1My868AmKGXzRojjM5nmfi1l2OEkC10WVkC0wNtvZJ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699517; c=relaxed/simple;
	bh=r8dAyKr09d9sgVGtfDd2r8dutIVr92zadXXa1IRD+EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgEac9cfw9RD0K2CrRQ/vLsVJ4IVPH/RdLqwGV2nGwGjmsdXna5zt0+rgxRelDogj3OLsmVTQqFKjRvIsw89D1LE1DFKQevSNU1ggOtKq+gHaiaj7NM1y/Cu0HGOXf6HCy5qnHzC5hu5WDcRhyAZVA/FB6tPJiU7o8tCLQ4rskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC67s6y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A0DC4CEE9;
	Tue, 11 Mar 2025 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741699516;
	bh=r8dAyKr09d9sgVGtfDd2r8dutIVr92zadXXa1IRD+EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kC67s6y9TS5wa4Sr6AjLTs2nLSXNIuL7cR+fLhXTakZAkI11qNQvUMIhP8PpIPvfn
	 6fsJY2xFe5/n9gH6nuTfHy8sDUOnMbv+/xKCStGFlPhiW7kLMauKY6e+4FZGtyyDDI
	 9vZwGWGaRSQRK3e8eWW4MMfNB49Eclac+qrR9tbWIwfAK7t501KW5bgA2n1i7rfgDm
	 dT55/m4xm5zbrYwER8i1cK0cEZvkDNCrwBEXF8VFhC5KL24aG6kFIXkUkNwTaahNJy
	 90NE+uu0MU75FkCguvZwSHTYr2V3JmVQB+7JnnBJR72Oww/bv0P9LjPJTlqa3FRw9I
	 /nJ0akDojHPIA==
Date: Tue, 11 Mar 2025 14:25:14 +0100
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
Subject: Re: [patch V3 02/18] posix-timers: Initialise timer before adding it
 to the hash table
Message-ID: <Z9A5uixC_Tjk308w@localhost.localdomain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155623.572035178@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308155623.572035178@linutronix.de>

Le Sat, Mar 08, 2025 at 05:48:14PM +0100, Thomas Gleixner a écrit :
>  kernel/time/posix-timers.c |   56 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -72,13 +72,13 @@ static int hash(struct signal_struct *si
>  	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
>  }
>  
> -static struct k_itimer *__posix_timers_find(struct hlist_head *head,
> -					    struct signal_struct *sig,
> -					    timer_t id)
> +static struct k_itimer *posix_timer_by_id(timer_t id)
>  {
> +	struct signal_struct *sig = current->signal;
> +	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
>  	struct k_itimer *timer;
>  
> -	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
> +	hlist_for_each_entry_rcu(timer, head, t_hash) {
>  		/* timer->it_signal can be set concurrently */
>  		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
>  			return timer;
> @@ -86,12 +86,26 @@ static struct k_itimer *__posix_timers_f
>  	return NULL;
>  }
>  
> -static struct k_itimer *posix_timer_by_id(timer_t id)
> +static inline struct signal_struct *posix_sig_owner(const struct k_itimer *timer)
>  {
> -	struct signal_struct *sig = current->signal;
> -	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
> +	unsigned long val = (unsigned long)timer->it_signal;

When used from posix_timer_add() -> posix_timer_hashed(), it can race
with another do_timer_create() that clears the BIT 0. It's fine but
KCSAN is going to warn sooner or later.

It looks like a good candidate for data_race() ? Well, READ_ONCE() is
fine too.

Thanks.

