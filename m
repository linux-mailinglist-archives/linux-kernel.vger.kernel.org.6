Return-Path: <linux-kernel+bounces-356670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434909964F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A6D1C235D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2858D18CC1E;
	Wed,  9 Oct 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNdH8B9h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ZB4/bY6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973B817
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465573; cv=none; b=kBsBqKFfGUPTJuxnZ78IskWRQ1wZfuqAE4gHs36uLCqBQ/fOCkZ0BQtJ5F/rUM87XsD4fpamdZDnvDabojIPq4Gmo9ce3fCSsa4X0owy8nvlS0tU3fmpeE9+vF92JJeNgs6zwH0TjgLq/n4zfOdOTgbLOyti3O3df6f63F6tPoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465573; c=relaxed/simple;
	bh=C1yoYKXaVxXZu8ig7avIFcNwt1kNgi32fLiJ30t85Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp3iW7PMDJFof/PN8iF/h6DsqeZigiQYY1BhR4kd/8sa9bKcFzxHubIqulsnk38ISHasVgZnW8L7F2YGnLTYgHAGlR+hV8trdtJbp6cN2n3x4rp3jDBVE0YOEd262ETPejtQ9Gk6wNfPCNmtUgju/YnK7xDGA7m4zg8j7qOhlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNdH8B9h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/ZB4/bY6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Oct 2024 11:19:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728465570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Byc2ppfVNYDp2ulBVW7TdY9TJzy2DgNU7Q992XBLl94=;
	b=BNdH8B9h6CRVM03Q6GP+THFmrKWc4z15PNc8eBQod0XgjWWocm/njAc6yBE9N3WkXd2lUk
	Hw/XEZmAYBXGubPnmSn9/NjVAM9eXCiufDK9ZCsCytjgwQLm7j4RPXoet3jT87XRPZLk/B
	B7mlxY9M6e6/SAaVKBwmmcxho4++7YsnlMnPp+gHZVdrBPcyIXV7VR62nLXgKlEG6eBYAf
	AQcwfAJrEVEeQieiwDapgwo1yop61vP5+Fscqj2LVY/RDbiilIPwVWWXaLdfKNQ48U3Wag
	zts8si/72PiqUyPRFJNVVWpOXwvEK+yny+TNQB52SkWnIASugGX7cfHLmoXRig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728465570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Byc2ppfVNYDp2ulBVW7TdY9TJzy2DgNU7Q992XBLl94=;
	b=/ZB4/bY6okyssHg4dGZRg4A4GGjmPgHCwbb+Ebpd+VZGjS+5RcqP+xRrk3j0jfS3oZoVZG
	T+dc/IiIW3Ud9CBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 2/5] sched: Add Lazy preemption model
Message-ID: <20241009091929.pB3mjZZd@linutronix.de>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.331243614@infradead.org>
 <20241009085021.cw9147B8@linutronix.de>
 <20241009091401.GL17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241009091401.GL17263@noisy.programming.kicks-ass.net>

On 2024-10-09 11:14:01 [+0200], Peter Zijlstra wrote:
> On Wed, Oct 09, 2024 at 10:50:21AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2024-10-07 09:46:11 [+0200], Peter Zijlstra wrote:
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1103,6 +1106,32 @@ void resched_curr(struct rq *rq)
> > =E2=80=A6
> > > +static __always_inline int tif_need_resched_lazy(void)
> >=20
> > The naming is a bit confusing here because tif_need_resched() checks if
> > the TIF_NEED_RESCHED is set while this returns the proper TIF bit
> > instead.
>=20
> Right you are; naming things be hard. How about: get_lazy_tif_bit() ?
> There's only the single user anyway.

perfect.

> > > +{
> > > +	if (dynamic_preempt_lazy())
> > > +		return TIF_NEED_RESCHED_LAZY;
> > > +
> > > +	return TIF_NEED_RESCHED;
> > > +}

Sebastian

