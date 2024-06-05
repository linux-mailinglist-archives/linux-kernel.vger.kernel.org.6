Return-Path: <linux-kernel+bounces-202177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5A88FC8BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6EBB22AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34451419B3;
	Wed,  5 Jun 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pxVqLWi/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RWOe6OyL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944719006E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582510; cv=none; b=EIxDVbTjPcVdnLT1kVdTEEGPeW/cZJdBH5CB/+5RvLuz21YPIfbFjqKeCabtpeAiSaFsQV9vHr2DeFJeS6QOPaGpQmBe+olOXOkCITsmy93HeL0YRyLqVINeywAmTGO/wJeFGtKijLz4PDywzdvLgSrN+9619KOdBAwq+cOfVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582510; c=relaxed/simple;
	bh=5FYlycc80OiaHBAK250WvdCEOOgG9oY85Bi0+i+GUhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SxlzqzFNaSy0LkVfkZwUzpIftxZfcgn/Bm6ZRvjLX2C0EGWOqBllVH9IQ/U9noobwh8Bx0qOjCNSlpPmWVIAKwVL9lKnfvsTHOmrkzHrVwzjcLyhhFMOrZyHW5uSc0iO3V4lpCDyFlFfa0Y6z6RgPUJfq4HDf6dIihjTKoDHRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pxVqLWi/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RWOe6OyL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717582500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AGW4NPcPgZ+kllaz1iPcGGi2RTc/mz6X+/BfY/cPz0=;
	b=pxVqLWi/Yb7a/LrLOJggqlpcYlf6UrMtTLNLpDVqZg0QlLi+CTc0XfTb+/poAi/GcXDmkX
	qvlJ3Yl5BQKDGI32Nd8o+YhOMGQ/XndHUKh+d2DYC5Pu2GwfbzVmYGTZ1WH3hyB7QB0iAY
	S8nsQLC/dLKtYjn8fM5RsbSdkNV+bi+j53TIy4pom4FcmR5s+KU8rTKPzZRMijtjWMDru1
	NmrFibIHB/mHOx/FWvEn/5kt43i0ysP+D3XfrkHsOfVA1thz/y5Ev/ksq+FgO+SeFb3gXa
	cSSbbAxDmekJ2wvP/X8M96gzV828929XUtrHOrSKMh+1krLdObJGggLC+m5Vog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717582500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AGW4NPcPgZ+kllaz1iPcGGi2RTc/mz6X+/BfY/cPz0=;
	b=RWOe6OyLnPQkqmEDbUsgM6r2SGakTwisP2BQzYobq5K7UJMFKqbw24F9h3+s5zRwnAWpvp
	b/FKYIujy4Of3oAA==
To: Phil Chang <phil.chang@mediatek.com>, phil.chang@mediatek.com
Cc: frederic@kernel.org, tglx@linutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jy.ho@mediatek.com,
 alix.wu@mediatk.com
Subject: Re: [PATCH] hrtimer: check hrtimer with a NULL function
In-Reply-To: <20240605084149.6420-1-phil.chang@mediatek.com>
References: <20240605084149.6420-1-phil.chang@mediatek.com>
Date: Wed, 05 Jun 2024 12:15:00 +0200
Message-ID: <87plsvvgpn.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Phil Chang <phil.chang@mediatek.com> writes:

> simillar with timers, check for timer->function == NULL.
> If the pointer is NULL, discard the request silently.

Can you please explain, why this change is required?

The statement "similar to timers" is not a valid explaination as timer
list timers and hrtimers are two different things. The function pointer
for timer list timers is explicitly set to NULL in shutdown path to
prevent unwanted rearming of the timer. For hrtimers there is no
shutdown function implemented and function is never set to NULL by
hrtimer code.

> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
>  kernel/time/hrtimer.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 492c14aac642..72d6e7bc9cd9 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1297,9 +1297,13 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  
>  	base = lock_hrtimer_base(timer, &flags);
>  
> +	if (!timer->function)
> +		goto out;

When this happens, user of hrtimers do not follow the semantics of
hrtimers which means this is a bug.

> +
>  	if (__hrtimer_start_range_ns(timer, tim, delta_ns, mode, base))
>  		hrtimer_reprogram(timer, true);
>  
> +out:
>  	unlock_hrtimer_base(timer, &flags);
>  }
>  EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
> @@ -1667,6 +1671,11 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
>  	__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);
>  	fn = timer->function;
>  
> +	if (WARN_ON_ONCE(!fn)) {
> +		/* Should never happen. */

...same as above...

> +		goto out;
> +	}
> +
>  	/*
>  	 * Clear the 'is relative' flag for the TIME_LOW_RES case. If the
>  	 * timer is restarted with a period then it becomes an absolute
> @@ -1710,6 +1719,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
>  	 * hrtimer_active() cannot observe base->running.timer == NULL &&
>  	 * timer->state == INACTIVE.
>  	 */
> +out:
>  	raw_write_seqcount_barrier(&base->seq);
>  
>  	WARN_ON_ONCE(base->running != timer);


Thanks,

	Anna-Maria

