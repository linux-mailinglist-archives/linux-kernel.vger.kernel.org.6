Return-Path: <linux-kernel+bounces-277923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26A94A82E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10466281D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49B1E672C;
	Wed,  7 Aug 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WoyJbLvH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k3od5DN7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2C1E4F1E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035745; cv=none; b=UPn0GEPC+sXkijv33YIMAvEpoyej8rWhSBLf0YlZGcXm4nY5tslM4uE0jzanR55HKzIZvafCXLTLUSScu+zU7pBfP9l0TcXv09aa3q6R2IyANM/Runp0Dd2TAe3uXHPYTAN1aIkx3T4O0t/WyYmQft3Oxkq8bjGs/oU0Wq40KJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035745; c=relaxed/simple;
	bh=VMKs0W3aFXqQvo+s0guW8ju+FJho/m/3IDY1dr+XnDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DssKuurv4SylIvNLFFxB2aN1pislGrFAwh5Ee9S08AxlBoo36ljqohf24dN1vNrvF2r6VDSEyp/KJKc0UBg1pg+47p5vkyDWInNVaboAvxUOEclO0K3E+/xcXTc/iJjaj8XvFr1f0av5kjzoP5A08XOp1tohCXaKvrCPiWe2af8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WoyJbLvH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k3od5DN7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723035742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOeP0Rpu30sOw/qKZXcDCvvmHYo6FbnwjZSzgR87wwc=;
	b=WoyJbLvHTV1VM2HWuL7LGZnJH5824ao8C8tLfHFvG98LXd01LQ3Q+Wea8l8xDACH2gDpho
	2xvnk9nUM1e38D/AV8+ov4VDSQUcihg6lOW5gt4jkc0JAt9Sr3oCZuPBhidCWMHn1i3/2f
	e2C1qoJzf8mI+3JO1s+iWqWDPrNKIY06LEKydrzmErE6Hqyn1EbVA/Lc0ZntMWp8vLSMeq
	fgs87OTHejN76kWI33OdVnk43wIy4fipmrHfiNRilwA6F0nsfamiXW4FzZRjOJFhGumwVM
	o3qkL8gy88nwlNbrkjv66yiJMk/aTcKF/LK8uEM/8ycW6ZVLpWvHcBRVjU+ZTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723035742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOeP0Rpu30sOw/qKZXcDCvvmHYo6FbnwjZSzgR87wwc=;
	b=k3od5DN7tSMSrmDU0Sx4sgpRrI673/hBMhWSx2oDtWQjz1Rb3WVwZPs/XT7wLeMAlSdBo3
	qGSfupaBe3U4E5BA==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regmap: Allow setting IRQ domain name suffix
In-Reply-To: <2eb39a8f-cc58-4774-836c-e6293300a4d9@gmail.com>
References: <cover.1719830185.git.mazziesaccount@gmail.com>
 <fd13fcc9dd785d69b8450c8e9c26d860fcab7da8.1719830185.git.mazziesaccount@gmail.com>
 <87plrpvzmg.ffs@tglx> <12228ec5-cf2f-47b2-842d-ce336d921260@gmail.com>
 <87jzhpscql.ffs@tglx> <2eb39a8f-cc58-4774-836c-e6293300a4d9@gmail.com>
Date: Wed, 07 Aug 2024 15:02:21 +0200
Message-ID: <87a5ho4hb6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matti!

On Tue, Aug 06 2024 at 14:51, Matti Vaittinen wrote:
> On 7/13/24 15:22, Thomas Gleixner wrote:
>> Something like the untested below should work. That would make your
>> info:
>> 
>> 	struct irq_domain_info info = {
>> 		.fwnode		= fwnode,
>> 		.size		= chip->num_irqs,
>
> Based on my code reading, the .size is used for allocating the "revmap". 
> Looking at the info struct for existing implementation of the 
> irq_domain_create_legacy(), the .size is set as:
>
> .size		= first_hwirq + size,
>
>> 		.hwirq_max	= chip->num_irqs,
>
> Also, the irq_domain_create_legacy() sets hwirq_max as:
>
> .hwirq_max	= first_hwirq + size.
>
> see:
>
>  > @@ -476,18 +486,14 @@ struct irq_domain *irq_domain_create_leg
>  >   		.fwnode		= fwnode,
>  >   		.size		= first_hwirq + size,
>  >   		.hwirq_max	= first_hwirq + size,
>  > +		.hwirq_base	= first_hwirq,
>  > +		.virq_base	= first_irq,
>  >   		.ops		= ops,
>  >   		.host_data	= host_data,
>  >   	};
>  > -	struct irq_domain *domain;
>  > +	struct irq_domain *domain = irq_domain_instantiate(&info);
>  >
>  > -	domain = irq_domain_instantiate(&info);
>  > -	if (IS_ERR(domain))
>  > -		return NULL;
>  > -
>  > -	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
>
> Lookin at this, the existing code calls irq_domain_associate_many() with 
> the given size parameter (without the + first_hwirq which is assigned to 
> .size).

Indeed.

> I think this is not aligned with what the patch below results (and yes, 
> I know Thomas told it's untested).

:)

> I'd better admit I am not 100% sure how the legacy domains work and that 
> I don't (any more) fully trust on my ability to flawlessly interpret the 
> code ;)

You definitely did better than me :)

> Hence I'd rather learn from a small explanation (what is the 
> expected .size) than by fixing this after I see regression reports from 
> real users of the irq_domain_create_legacy() :)

So the size of the domain is sum of the parameters @size and
@first_hwirq. That's so that the hardware interrupt is zero indexed for
an array based lookup.

The association obviously wants only the @size parameter because that's
what the caller wants interrupts for as it obviously can't provide
interrupts below @first_hwirq.

> So, any guidance as to what the revmap allocation size should be (the 
> info->size), and what should be the size for the 
> irq_domain_associate_many()?

So that associate should be:

   irq_domain_associate_many(domain, info->virq_base, info->hwirq_base,
   			     info->size - info->hwirq_base);

Thanks,

        tglx

