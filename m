Return-Path: <linux-kernel+bounces-366791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACDF99FA76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC921F213C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063521E3BD;
	Tue, 15 Oct 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bs4WK+3i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4GA+ftBD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746821E3B2;
	Tue, 15 Oct 2024 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028546; cv=none; b=sdY35HdSzZv0dBbYc0nBT1rUlOARW2QM6vIV/tuDnNSS6NRubes2fUd9Axl+vSSgp+f0hBGo8tY4L/k2TH4+OQt/nCzWgf8wtT/H5XxyQgWl+tN/Z+nG2De5uU6RlyueyZ5DgJBYHiaU4v3FPmCv3tnMTJ63sV4UhrpFhUHlXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028546; c=relaxed/simple;
	bh=ADjjbzXz95P9cj8Qiy/Kdepn7OHwPWnDZ3anvu7xMrk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u16wvkFGfhGryppYl4i7X8MsOdjpYkjUyooHb8buuc77OMggAPAZfFvjQopXR7PiYk6OSsG+hdyvTt2gh0PmgktIT0DZX1SHGtBE0zeEnOeCZnzcFJ9gkbvJupPzmxCTtdrqvFsTU/Z//Jco0VmzL5JXmSmXL9HqYcRvzctsyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bs4WK+3i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4GA+ftBD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729028543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hALBkgP+0vHQHFOLfJVhzpCvZiu7iqZATK+f8xljF6o=;
	b=Bs4WK+3isP7DKVNVaTNUaI/cX7y8ywrDgKgH/p2ecpxNUxJJo0bfpcpQ8SK4BcXOY2CYJQ
	koe/V5rgwmYPy4OWcSKmFZbCAnO4X1fTHuAcVGFm61OmX+gLgw0WYIvAimHF/WjW3WvyzH
	SCWMpw4lmBbQGc18oHIUM1HiDR7eaiJnFh3+YDMdDoTYHCvxulNioczbrzxxErJ5PRSj+P
	D93sv4JPFkjAYRaW9BAAMV+Cv4RpA0dmVS+s5qKqYs0Vh8Rat09h+FJ59ePaDnNdymW+ce
	nbD6AcfZIse28KHvl5QHb6eJQY84fpgt+5/ZGIpET97fj9/LBur6aj45bZQMjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729028543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hALBkgP+0vHQHFOLfJVhzpCvZiu7iqZATK+f8xljF6o=;
	b=4GA+ftBDLrodNSL6IIhR1BlPC9NDD73LIkk4yNdYSvee3SIv688WmN65Kfer6AZf+2rNDY
	GP+ZpDSLkttq53Dw==
To: Markus Elfring <Markus.Elfring@web.de>, Kevin Chen
 <kevin_chen@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
Date: Tue, 15 Oct 2024 23:42:22 +0200
Message-ID: <874j5ddow1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 09 2024 at 14:32, Markus Elfring wrote:
>> +
>> +	chained_irq_enter(chip, desc);
>
> Would you become interested to collaborate with another scoped guard
> for this programming interface?

Collaborate in which way? What are you collaborating on?

You are merely asking people to do work which you think is useful. You
can do that, but that does not make it useful.

Making a guard variant of chained_irq_enter/exit needs some thought and
a general plan for cleaning the whole chained irq usage up. It's on the
cleanup list already with quite some other items.

We are not adhoc adding a guard variant because guards are hip right
now. And no this does not need a scoped variant ever.

guards are not the panacea for everything.

> https://elixir.bootlin.com/linux/v6.12-rc2/source/include/linux/irqchip/chained_irq.h#L13

Please refrain from these silly links. People know to find the functions
on their own.

Kevin, please update the change log, add your SOB and move the local
variables (unsigned long bit, status;) into the scoped_guard() zone.

Leave chained_irq_enter/exit() alone and resubmit.

Thanks,

        tglx

