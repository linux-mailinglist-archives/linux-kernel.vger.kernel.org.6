Return-Path: <linux-kernel+bounces-317035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C514096D875
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A746EB22015
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917F199FDC;
	Thu,  5 Sep 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="aNE0hW3k"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5B19AA63
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539050; cv=none; b=EC7xi1hKCcrn7e1vwmriLXE++fVGyNPWDw7bwIKlxNpEYakGnNN8JGzqq/hIHuhhzmZIgigUxIdCKcin69HbzpjZW29CCDEfxXPKD2NOd6d7Jg5IynWalOUHa4tAkUm0BrE8CHjiW+/6wS6Y7DnPOlSeLYSj3ciO/FW02g6UFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539050; c=relaxed/simple;
	bh=9+Nt6H57ECZbQHUWfZsbqigwxtLfD2FqsO7BOUaWXfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g41yT8uy7GDbyxa5VNCROubr4Hq91K8YGUAdXg8krvNNW55B0/FAyGH0Ahcx26Spf7osjcrA64yJcUxMfQCsovYzvaRWTUYjxZh+h6U7dkniClEnlilDSHOaZq59EF1ZSNl7rtPkoiJDD+QWX1OLzKhwZgzeBpwcz3zJwVv5Gwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=aNE0hW3k; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725539046;
	bh=mUdYVDhcBbnbe8Qnsh0MBGJ/CuaR+SGTw9WGn1Sesjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aNE0hW3ktB5ARsICz/sDICJpPHa+7JLjwZbfyZgZ3pBirixCFOKOHsJlHJKueCT+4
	 oO/jlji0rW5pNKsVEZb9l1e+vrwuXvXHlzxe3cW/CD+/DxV2M5RhbL/mu/Pxk+02P9
	 qsipRyRV0PDMs0nXFL0649/B2oYRSZgVw2QMf74t1tyGqR0SZL1fjy6VA2WsTdDrJZ
	 nFFHe+UBoIVY4RgE3JcARKeeLqK1M/Ui2reF+e1tAZ92g0d32LXyubGymdFC3d3Fuc
	 iqGnn6qGk8pQ972Et1Be/4tzXT7uvXw6+nDOIi3J5F7PsxjXKcp9OpButWBGUjKxsh
	 Rbiu1u9E3GfiA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wzz795cY6z4x0H;
	Thu,  5 Sep 2024 22:24:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonathan
 Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Nathan Lynch <nathanl@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/15] powerpc/rtas: Use fsleep() to minimize additional
 sleep duration
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-13-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-13-e98760256370@linutronix.de>
Date: Thu, 05 Sep 2024 22:24:05 +1000
Message-ID: <87cyli5lwa.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:
> When commit 38f7b7067dae ("powerpc/rtas: rtas_busy_delay() improvements")
> was introduced, documentation about proper usage of sleep realted functions
> was outdated.
>
...
> Use fsleep() directly instead of using an own heuristic for the best
> sleeping mechanism to use..

Thanks for tidying this up. I only learnt about fsleep() in the last ~year.

Two minor nits ...

> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index f7e86e09c49f..0794ca28e51e 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -1390,21 +1390,14 @@ bool __ref rtas_busy_delay(int status)
>  		 */
>  		ms = clamp(ms, 1U, 1000U);
>  		/*
> -		 * The delay hint is an order-of-magnitude suggestion, not
> -		 * a minimum. It is fine, possibly even advantageous, for
> -		 * us to pause for less time than hinted. For small values,
> -		 * use usleep_range() to ensure we don't sleep much longer
> -		 * than actually needed.
> -		 *
> -		 * See Documentation/timers/timers-howto.rst for
> -		 * explanation of the threshold used here. In effect we use
> -		 * usleep_range() for 9900 and 9901, msleep() for
> -		 * 9902-9905.
> +		 * The delay hint is an order-of-magnitude suggestion, not a
> +		 * minimum. It is fine, possibly even advantageous, for us to
> +		 * pause for less time than hinted. To make sure pause time will
> +		 * not be a way longer than requested independent of HZ
 
"not be way longer" reads better I think?

> +		 * configuration, use fsleep(). See fsleep() for detailes of
                                                                 ^
                                                                 details
> +		 * used sleeping functions.
>  		 */
> -		if (ms <= 20)
> -			usleep_range(ms * 100, ms * 1000);
> -		else
> -			msleep(ms);
> +		fsleep(ms * 1000);
>  		break;
>  	case RTAS_BUSY:
>  		ret = true;

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


cheers

