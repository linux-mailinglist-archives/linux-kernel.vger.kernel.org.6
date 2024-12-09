Return-Path: <linux-kernel+bounces-437402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A619F9E92C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5740A2820B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3722069F;
	Mon,  9 Dec 2024 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YjxQyi4N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xSfDX9qn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0298216E29
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745123; cv=none; b=Vzev7orFneMuf66boNbxrgRBcehaXpo2GsH+vKMchy/OPRlz0lNMZbmRi+vOct6I8lcO356fIxO+3oIUHu6P6Juh7xzIkaJCNR7+P0gJ/uVw4wdfieRmDO1kumzSxlEEOFlPgC6fLQdBSp2dHJMVwILC5HiPNZ+nZWdIDAQLHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745123; c=relaxed/simple;
	bh=7mVhwlnpKFqC4DNuvOtJXJrxk9SpY0InSHTwQS9GsGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gjY3djqekZZ2aXLQeKLRmdWg+kKH7w+NmnPma1gGeuNwfXgozG4o8txDWJpQ3tQ45yxIVysetmNzRNewMpRkJWCMw4nLLNcTnzksgkT9zeiB+ky+UrPS0Ye8/LY1hCbxLO/36iOKnotmES7gscLSV51zycyF1U2HQ5uLRxABODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YjxQyi4N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xSfDX9qn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733745119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ge+NkW7aVVfZxXLxsfJM8vinnugWJuvI25cnwnw3qqA=;
	b=YjxQyi4NMDEwE6Jb3tJmApR8vEuagaS0DzGLbBoHka4LRHuyyrVZ9wf44LNW9+wwx9BNwA
	dcZseDXDoFRWLxCgVHrELnsKbbL6hwL81pMYW0/lT72vb4Fd07T7+msY885Jpf6pb3DAkX
	IuA5e15lh/rAweQTYjaWTDJXKC3khp6i+6pHHnpQ3AxatE1oVel1YvusRj1Krcz/iiQ8mY
	U+DaKZHzakjOKFY1Zpwi3mtaZzS8qNXLfwiRaFvU9LeAhpGHV1FrJZEMrhYo5tipZAirca
	wNBKWQHAVqfX2AEHBdLMeM8mQWwbu1LmP7wEIlBG/WjaAP4g+wdeDKT9QI3TvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733745119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ge+NkW7aVVfZxXLxsfJM8vinnugWJuvI25cnwnw3qqA=;
	b=xSfDX9qnYbK2Un6TahsoJRlZL/wjv0FDskpvkn/hVIJcGLrSnRrk2KyBjAgfIa9qdL+jwl
	loTd8dG1dU7Iw5CQ==
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH] cpu/hotplug: ensure the starting section runs fully
 regardless of target
In-Reply-To: <z7nvvzu5lpdnul2m35lrsa7wo6plx7zsunhowtog3nqydmpene@tzvb2hofjeal>
References: <20241207144721.2828390-1-koichiro.den@canonical.com>
 <87zfl5q5gi.ffs@tglx>
 <j2k25hhxv42zuakbqc2miptypxee6j3vwkb5a4yz4vutj6swhv@c6ejjddjn6oq>
 <z7nvvzu5lpdnul2m35lrsa7wo6plx7zsunhowtog3nqydmpene@tzvb2hofjeal>
Date: Mon, 09 Dec 2024 12:51:59 +0100
Message-ID: <87wmg9oyzk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 09 2024 at 13:19, Koichiro Den wrote:
> Now I'm wondering whether we should go further..
> Because in PREPARE section, things are not fully symmetric, so
> there is a problem like an example below:
>
>     E.g.
>
>     (1) writing <some state in between> into 'target' and then (2) bringing
>     the the cpu fully online again by writing a large value leaves
>     hrtimer_cpu_base's 'online' field at 0 because hrtimers:prepare does not
>     re-run.
>
>            - hrtimers:prepare (CPUHP_HRTIMERS_PREPARE)
>            - ...
>     ------ - <some state in between>
>      ^  :  - ...
>      :  :  - hrtimers:dying (CPUHP_AP_HRTIMERS_DYING)
>     (1)(2)
>      :  :
>      :  v

That got broken by me with commit:

  5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")

and want's to be fixed.

> While I understand this is still a debug option, it seems to me that there are
> several approaches to consider here. I'm inclined toward (a).
>
> (a). prohibit writing all halfway states in PREPARE+STARTING sections, i.e.
>
>      --- a/kernel/cpu.c
>      +++ b/kernel/cpu.c
>      @@ -2759,7 +2759,8 @@ static ssize_t target_store(struct device *dev,
>                      return ret;
>      
>       #ifdef CONFIG_CPU_HOTPLUG_STATE_CONTROL
>      -       if (target < CPUHP_OFFLINE || target > CPUHP_ONLINE)
>      +       if (target != CPUHP_OFFLINE || target > CPUHP_ONLINE ||
>      +           target < CPUHP_AP_OFFLINE_IDLE)
>                      return -EINVAL;
>       #else
>              if (target != CPUHP_OFFLINE && target != CPUHP_ONLINE)

That's lame.

> (b). make all fully symmetric. (I'm not sure whether it could be possible)

There is no requirement to make everything symmetric as there are
prepare steps which just allocate memory and do some basic
initialization. So I rather go through the steps and keep the ability to
invoke them fine granular in all directions (except for the atomic AP
states which started this discussion.

> (c). add all safety catch at sysfs interface. (For the above example, once
>      it goes down to <some state in between>, disallow to go up without
>      once going down to a state earlier than hrtimers:prepare beforehand.
>      I guess this would mess up source code unnecessarily though.)

That's unmaintainable.

Thanks,

        tglx

