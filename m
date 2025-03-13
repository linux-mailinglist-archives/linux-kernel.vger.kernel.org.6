Return-Path: <linux-kernel+bounces-559739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3387AA5F8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0912A3B17E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D818268690;
	Thu, 13 Mar 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VC2KQ+qm"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A9267F7D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877307; cv=none; b=IZh/7fZOSRdsEAKfubStlAC3Y7+TuIHxQiTOtEaj0NUK84Clqwr9izwaWCzQ3/KcfHDgyG/D8hbLo5v9MxJNyozwrJPpD5P6UuCjz5g3WrvtvpI+hpKF4jX7kcWrHbINzoa2AwGR6sZ8/KNDwSrT73x4iEhX/D6FubT7TIp5l7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877307; c=relaxed/simple;
	bh=74q1QugtPVhiVAF1IrlosmnlxVF5HcoC1FvEOwi7tH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlYuttloe7pBZmVt0fcnIwNQX/SIbVVGQ5ZrGCneOSwE83JwJ83BChUai27gIvcEEgfGOrwR20Bu/6ozuUfNUdTCl39wbsW05UwpMre8tz9c7GHdCDWd6x5U1/E5M6g8CMZFuhUE0ve6C6p4f7TuGuSvLuQ0ZaKygLmK7a5hVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VC2KQ+qm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u/++hCF7QJgCGMIGXB1yxG4YNrbxMmRRLIRePkjIo3E=; b=VC2KQ+qmz6W3rJ7GNbTCsztko8
	LDqufW9YKHjgungru41toALL08cFiu4blUfxnm9oSPJW+He035ev16/Qqu/EVCt12ZSBHTXBl982R
	XmPd4pfzuuh9+px5dGoOoaMPU2YgkaXg4zyqQtwG//7thbf1JBw93dCS6rPBiWHnhrs4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsjrA-0051Fm-OX; Thu, 13 Mar 2025 15:48:20 +0100
Date: Thu, 13 Mar 2025 15:48:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Talel Shenhar <talel@amazon.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Guo Ren <guoren@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [patch 3/7] soc: dove: Convert generic irqchip locking to guard()
Message-ID: <3860ac63-3181-4d00-8824-6d122e195176@lunn.ch>
References: <20250313142404.896902416@linutronix.de>
 <20250313142524.137040686@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313142524.137040686@linutronix.de>

On Thu, Mar 13, 2025 at 03:31:21PM +0100, Thomas Gleixner wrote:
> Conversion was done with Coccinelle. No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> ---
>  drivers/soc/dove/pmu.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/drivers/soc/dove/pmu.c
> +++ b/drivers/soc/dove/pmu.c
> @@ -257,10 +257,9 @@ static void pmu_irq_handler(struct irq_d
>  	 * So, let's structure the code so that the window is as small as
>  	 * possible.
>  	 */
> -	irq_gc_lock(gc);
> +	guard(raw_spinlock)(&gc->lock);
>  	done &= readl_relaxed(base + PMC_IRQ_CAUSE);
>  	writel_relaxed(done, base + PMC_IRQ_CAUSE);
> -	irq_gc_unlock(gc);
>  }

My personal preference would be a scoped_guard() rather than this
magical guard() construct which looks nothing like C. But whatever.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

