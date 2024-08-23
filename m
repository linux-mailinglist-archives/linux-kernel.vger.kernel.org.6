Return-Path: <linux-kernel+bounces-298588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 503CF95C91E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00201F22DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2AD14A0AD;
	Fri, 23 Aug 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11mE0MhP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+D3i2fTS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946F013B5A1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404881; cv=none; b=d+0EhWZ0fzMkbbIsnRfgJdrp+mAWXSWkWvlKWaReDIL/+ZX5IcCnA3UWeUKyAmImzaiatLVUmtXpQ+MZA6ck/azET1tmGECCtbN/OSSkhBd/cTMQ3nRxNPBYY++5T3ZBUZqjoEQ9wRbVv8Uu809XgHnIifYnm58AUsFsO3ADY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404881; c=relaxed/simple;
	bh=dKDTKt/74Jcxhd189sNcU6hs6cx4W/v9Q0Ihvk+HMAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kqEBzzd9EKASEjPe4Eh7qekPusn5G3wLtq5hR0yFCsAu5EXUyXyLqzv/NnljXI5S4ZHe7JwUjpBPsa/dj89bryaaDxugYohb7Ox/Czej4zjiaL+ORXoXSVuIwRcV6GnIB/LgK6S9dogRkVyDaKINQYAT+WmnsTO5doAyZUmDVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11mE0MhP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+D3i2fTS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724404877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24J3LwGj3ucClo1k4z1zRF9+mX66KCx2iT9UBQPzfFI=;
	b=11mE0MhPyS73Qtfr7TTCrS7Z4g0p0eNOdqFzX3QmOuYLSPD5mlqWonzIfy+eRv6f579jAu
	YDzv3NJOAP4OTHKrUzP5wrqm5hZZusZS5+Bpl7yTWdNo1SHOFNIDZYtgBEcCJ9KAkyJcgA
	dJqJk6viK8AKaQoyzhOsbUvAr3Jc+QnWuYg0YFs9BbkdKDSqHHVgoEpnygLyLxTZV9zp4f
	dujvYKuyJx8gNecofodB94RZUvObJ0lGEfuY7n1mCmhafst0eC8UVXlCxi/pmVF9mJOoRu
	64ijTBYPtJa18jvgvSjYPB+psHAMFNpVuJS20c0gQdZT2E6u425asmluCBLS2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724404877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24J3LwGj3ucClo1k4z1zRF9+mX66KCx2iT9UBQPzfFI=;
	b=+D3i2fTSLgVUDx/Mf1mqkmLWNz+gbMnh0UakGoqO2q7OrLn16gGLKcLJF5mnlxsE0FZDdk
	FhErrsAxlRbACkAA==
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King
 <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Regression on Macchiatobin from the irqchip driver
In-Reply-To: <20240821165034.1af97bad@fedora-3.home>
References: <20240821165034.1af97bad@fedora-3.home>
Date: Fri, 23 Aug 2024 11:21:16 +0200
Message-ID: <87frqvh9wz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 21 2024 at 16:50, Maxime Chevallier wrote:
> By looking at the msi_lib_irq_domain_select() implementation however, I
> notice that it appears to be expected that these ops can be NULL by
> looking at the check in the return line :
>
> 	return ops && !!(ops->bus_select_mask & busmask);
>
> However, the line above dereferences the ops pointer without prior
> check :
>
> 	/* Handle pure domain searches */
> 	if (bus_token == ops->bus_select_token)
> 		return 1;

Oops.

> As I said, this area of the kernel isn't very familiar to me, but I got
> my board to boot with the following patch :
>
> --- a/drivers/irqchip/irq-msi-lib.c
> +++ b/drivers/irqchip/irq-msi-lib.c
> @@ -128,6 +128,9 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
>         const struct msi_parent_ops *ops = d->msi_parent_ops;
>         u32 busmask = BIT(bus_token);
>  
> +       if (!ops)
> +               return 0;
> +
>         if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
>                 return 0;
>  
> @@ -135,6 +138,6 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
>         if (bus_token == ops->bus_select_token)
>                 return 1;
>  
> -       return ops && !!(ops->bus_select_mask & busmask);
> +       return !!(ops->bus_select_mask & busmask);
>
> ----------------------------
>
> I have zero confidence that this is the correct solution to the issue
> so feel free to ditch that solution :) I'll gladly test any
> patch for that on the MCBIN.

It obviously is the proper solution check after use is pretty pointless
as you demonstrated. Care to send a proper patch?

Thanks,

        tglx

