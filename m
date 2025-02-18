Return-Path: <linux-kernel+bounces-519601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE27A39E80
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A281727E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9DE269D03;
	Tue, 18 Feb 2025 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pPnRnlx5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZ8zjyHL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BF242919
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888173; cv=none; b=F0RvmiMJZsDf2yfHEJP5O+LtA/SdQPi8QcSvfpUgKYz4Y8yQ/YYT7iiZCChVYPPhV8tyzuSi3lnI4t5D8CIq9dAGug5PUnH1bceqo6XXUPacqkzW384UcpPAotE52/FjQiuBuGCkgy3GP0+oEDIFGq6CNcxtpjqlGdVyCzShJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888173; c=relaxed/simple;
	bh=rhaIXTwu4dNGqWS2BYHrULqE711doIom9SkTjNRwSF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YcIiMSOE8PdAq4LQFjaCyjVuJh8FnbTe3/BsjcykiUjRObCU8hYyk7WzZbr1Cx8tYKvcjdJ6x6JfizVEikTK7doGNKbecuSf612P0WKTgEavBTPqB+/ep5pkWyYwmqePUUq14PzzQUG97EZpUsOI51K23BT+VZSkzmcUlEiYzlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pPnRnlx5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rZ8zjyHL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739888169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=se6qGXj7AH9bepHz6V1+xi31b6bghMv56/WLOfDjDek=;
	b=pPnRnlx5w8GXL2338u/sIKlRx3Q2MTOmpAQZ2uhzAglIF2MZYqXMgdd4aS7CAYuLuajKE1
	HDLunAB5KJViHIVZAGfFFzVepv8OILBrMTeJf4cQTWH/6wK5Rj3m/0AFKsFVdmi+sFtJVz
	DPPu/lO059u52hsZeJQzDxyYCAfDtNKOXl3UeZXpnRfIQcsp2LTcXNaTkctT/OYPwjsLYF
	P46mBOW00gu1Y4EU1fVr2WiI/EEKfsSAPKlaJVVFoQ84v79YVff7PP18KFo+MgRj8CIsAy
	rAnKJyiUEE/PCnwLZbsLxLqRTowmrZHhF+96WgJs5duXhJmjvLv7ViiLl5NQRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739888169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=se6qGXj7AH9bepHz6V1+xi31b6bghMv56/WLOfDjDek=;
	b=rZ8zjyHL8af3JeZdBsL4PDzgRuMydzBsl2vqQ9G7wkpeOGaOFIb12CsefvcA0I4GfQnzMm
	D8IDZ+WGBCKxsjAg==
To: Eric Dumazet <edumazet@google.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall
 <bsegall@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] posix-timers: Use RCU in posix_timer_add()
In-Reply-To: <87o6z0jrx6.ffs@tglx>
References: <87o6z0jrx6.ffs@tglx>
Date: Tue, 18 Feb 2025 15:16:09 +0100
Message-ID: <87zfijibiu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 17 2025 at 20:24, Thomas Gleixner wrote:
> On Fri, Feb 14 2025 at 13:59, Eric Dumazet wrote:
>> @@ -112,7 +112,19 @@ static int posix_timer_add(struct k_itimer *timer)
>>  
>>  		head = &posix_timers_hashtable[hash(sig, id)];
>>  
>> +		rcu_read_lock();
>> +		if (__posix_timers_find(head, sig, id)) {
>> +			rcu_read_unlock();
>> +			cond_resched();
>> +			continue;
>> +		}
>> +		rcu_read_unlock();
>>  		spin_lock(&hash_lock);
>> +		/*
>> +		 * We must perform the lookup under hash_lock protection
>> +		 * because another thread could have used the same id.
>
> Hmm, that won't help and is broken already today as timer->id is set at
> the call site after releasing hash_lock.
>
>> +		 * This is very unlikely, but possible.
>
> Only if the process is able to install INT_MAX - 1 timers and the stupid
> search wraps around (INT_MAX loops) on the other thread and ends up at
> the same number again. But yes, theoretically it's possible. :)
>
> So the timer ID must be set _before_ adding it to the hash list, but
> that wants to be a seperate patch.

It's even worse. __posix_timers_find() checks for both timer->it_id and
timer->it_signal, but the latter is only set when the timer is about to
go live. I have an idea, but that might be a bad one :)

Thanks,

        tglx



