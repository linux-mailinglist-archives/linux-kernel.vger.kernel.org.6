Return-Path: <linux-kernel+bounces-198762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE7B8D7D18
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04335B20DC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13657333;
	Mon,  3 Jun 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PW0vZG3l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAptKNFn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95EC487BF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402491; cv=none; b=sQdQAOF0r6QSFPQPGXK/fzR/Ur4BsmgneoZj4+VfsRmHvzrM1acnlswTQjhpjpnaSJPHH3KMNskXu339ZbYkTU6d/fIRiy+zoRJ7cb0tvKAV4muwy0glyhGWk9IccETG8NTSUw4RVtj4X7Sz3Gj3HoT2y/1Mc0EaMu1ZydJaCIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402491; c=relaxed/simple;
	bh=lYCWB40QEFcFcjHUBJCzIlFs9DPHH5OHRa5rhdNjrck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipEzccLgp6QXrf9aWTl02qYazBh0WYdeH94bV2+r15LeGrqjOOTpgYUiEI+yKTM5+x0URAUbUV+bzhBPLWkRdfCE6C4qSQjd5w4rxEdkUuU9Gg8sAnS3rOzi6NI3H8lvIgo6KkGlUpZr2pp9vS6cr3ZV9bI0TL+4X3b9yjapcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PW0vZG3l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hAptKNFn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717402481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w1jsjob6JOgoEKksTIk7OReiRSSnVDB4hkBuPdbwUOw=;
	b=PW0vZG3lkQUYjDefCBBGr4ZP1iXvH7TcDTOCbIHu9Qu735a+LDNnFZakJGL2+Liah+jwQD
	CLpVgeY2DAUJ6rHQHU7RML4XsJ+Tb2Px4ChcAnxUuJKdewVpAUUyUPxnNd26yAa7kJrJF+
	v+1qPtUCVohltqB3C32d25eObqu+qwa+z6/Zzl5L4HCEl9Alv88S58QbXdx+5I76lEzLIx
	fbg5iXDdHPOIPDc70PuqpSqIwL6n13X++8E9vVxliBhrhv29uXO/QAu6EdUTT422QTAiiY
	nW2HqM3Dx/aI3v3hNF4VGmypT5qQNDyd+z9+37hOVnfltowCGWybcED51/XCFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717402481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w1jsjob6JOgoEKksTIk7OReiRSSnVDB4hkBuPdbwUOw=;
	b=hAptKNFnggbiil8RC3Zh/DZrePMF9wRmBBAgCFH0g68XKlgxGraAy1HXHzAbQt+u/FX9SB
	Al+fggy1bBa9OhAA==
To: Oleg Nesterov <oleg@redhat.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick: shift tick_nohz_switch_to_nohz() from
 tick_check_oneshot_change() to hrtimer_run_queues()
In-Reply-To: <20240602102007.GA27454@redhat.com>
References: <20240530124203.GA26990@redhat.com>
 <20240602102007.GA27454@redhat.com>
Date: Mon, 03 Jun 2024 10:14:40 +0200
Message-ID: <87jzj6789b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 02 2024 at 12:20, Oleg Nesterov wrote:
> @@ -1891,8 +1891,11 @@ void hrtimer_run_queues(void)
>  	 * there only sets the check bit in the tick_oneshot code,
>  	 * otherwise we might deadlock vs. xtime_lock.
>  	 */
> -	if (tick_check_oneshot_change(!hrtimer_is_hres_enabled())) {
> -		hrtimer_switch_to_hres();
> +	if (tick_check_oneshot_change()) {
> +		if (hrtimer_is_hres_enabled())
> +			hrtimer_switch_to_hres();
> +		else
> +			tick_nohz_switch_to_nohz();

hrtimers have no business with tick_nohz_switch_to_nohz(),
really. That's a strict tick/nohz specific thing. hrtimers do not care
about NOHZ much. They care about whether they can switch to high
resolution mode.

Thanks,

        tglx

