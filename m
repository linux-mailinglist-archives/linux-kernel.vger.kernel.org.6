Return-Path: <linux-kernel+bounces-373036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E979A50E7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 22:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EDD1F22818
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 20:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4E5192597;
	Sat, 19 Oct 2024 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qDJK7Zra";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tX4Y/3gf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9021922DB
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729371554; cv=none; b=a5aVealePZmmTrOlemFt3b+yIQgVD6b4ZaWOpbsHa/ewddjxIuwM3omjQ+uZTfyiLKaxPsUIbgv99fJ6tvo9frAuWQDC/ghvDUX7MUbLxJ6GelMTaRFoBWhqz0/BmLqJmclX9194YxQLqJuIEvnCRIuG6+f8A+AoDHLqrFUFB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729371554; c=relaxed/simple;
	bh=k5AOlP+4PgJchz1xqN3g7XBg6cyP5ZCYr+ZxQm6ViqY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aWbs8vDajrmjcNiBzEqKPQ3K9NWi5GZZEu3GtmhN8jWCepbgHraz9dQEO9prL4gj7+aTS0r79i4xXyKzW0csUR/47TBQSQvhTr1sHOsnIyJrxL5tNCmN4QQi3FDGrlU9mYNaHfQvQiHFw0kcvidfwRNV8bDO7tq8jfVdsNv/EOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qDJK7Zra; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tX4Y/3gf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729371545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTBfdMLclCQfOmDMfmViywpNHyJWiZCoZ6jUybIc8Rk=;
	b=qDJK7ZraYdGVk5hx27zVAhva3vSL2lN5a03fFtyDSEASHzZwNSHeVxZflPKYFjr0VQe4jl
	akIH5uExAJSfa8+OJcwsXhg8Bqo9+hrcASiKSO/tt1ZonRDwH80PkRonSJwKyEiRoztHEa
	xWphYPbu5Kyft1Snfr5wlVAQ3ki5c/6jIkGdXeyVOnJDLpY9M/Oqq2VCQQg7wuom7jlFpl
	5h+LuwjG+tlRh+PGbieitjYkO6Oa7s4KV7cuH8EYdr6+Antbjuj028aovn1RsXmm8QCNvg
	I7711ytr3XDDpAcTAdgSc3w0+TMoLR0AVoSCA3Pw1UtLO6aIkubQIJx9nFlxdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729371545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTBfdMLclCQfOmDMfmViywpNHyJWiZCoZ6jUybIc8Rk=;
	b=tX4Y/3gfNO3b6y+5Le/tC4MCiFDkLTtziW5QBJhpzYrrVJ16HF2VrIcwk/SUccpuVj7xFo
	0VgwNJW/vy3pU6Dw==
To: Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] posix-cpu-timers: clear TICK_DEP_BIT_POSIX_TIMER on
 clone
In-Reply-To: <xm26ttd9ay34.fsf@google.com>
References: <xm26ttd9ay34.fsf@google.com>
Date: Sat, 19 Oct 2024 22:59:04 +0200
Message-ID: <8734kr95d3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 18 2024 at 14:41, Benjamin Segall wrote:
> When we clone a new thread, we do not inherit its posix_cputimers, and

We? We neither clone something nor can we inherit anything from the
kernel. Please do not impersonate code and use passive voice.

> clear them with posix_cputimers_init. However, this does not clear the

Please denote functions with brackets, i.e. fun() so its obvious.

> tick dependency it creates in tsk->tick_dep_mask, and the handler does
> not reach the code to clear the dependency if there were no timers to
> begin with.
>
> Thus if a thread has a cputimer running before cloneing/forking, that
> hierarchy will prevent nohz_full unless they create a cputimer of their
> own.
>
> Process-wide timers do not have this problem because fork does not copy
> signal_struct as a baseline, it creates one from scratch.

And the solution to this is described where in the change log?

Thanks,

        tglx

