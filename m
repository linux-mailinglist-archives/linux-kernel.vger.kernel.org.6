Return-Path: <linux-kernel+bounces-559321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE96A5F24D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3947019C1D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8CD266191;
	Thu, 13 Mar 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMvFMIiE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xjbcLESa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B99266189
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865192; cv=none; b=Fhg2zRjTi+I4w3HHa2I0nyEOWkTooeTNzNOU+WU0hMt9gyxJVdeCnZpUGUyG/U7hu0YjTaOMhVjRvzs5y2d4IY1MOVJT0ypYRO7o8WKzlrl9VazY4wNEvHN69G7UUMWSLc+n+sJ3mLCnXHhlCul3HERZuVmYyy8zdmnBu95Ankk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865192; c=relaxed/simple;
	bh=uiWpnxmrLH4Xz05zxj1K6/lilycsHVoIRZHDM86z5oc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uH/4J6ec5uUQ8FvPJnXdOS+KJLvfdbCuzVTEodfgonj1M4utvZeIUB1NSO0JNoximCYUNLJdV4P+UZ1ObiNUJ9PB1Sfi1c0XwDoQqm0rJN4XVlbYd5CLeHbeh+sJGcfCT0X8YyCdgtqo3IRKOXCXf1TH2fBal0tvhx3sD5Oh4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMvFMIiE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xjbcLESa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RP5PpF7s/MPIIGMoHbUo9cvWo25yqbhMEZdAulcr27Y=;
	b=DMvFMIiEXs5UH+I2pwOFN3lf1wDc0fJN9t4D3DCFAO9SqPEK7hWxA8X6Z6muX+sTFfp+vi
	Q7/6hhRXuHHQNV7vlfQOTsf2YbrxAlq5lKdLPzIwhXmtgXsoKpn+O5S80c6vo/ih/6Ak+z
	NR5CT5sy61I3IZqyAtXyXjW4awoASAkZ12hE5gGkxDy/Q9pTBaJdzouc07Wj8GV4wqYpB3
	3aTDrnO/eeHQiQzB7bPbcQS73/kR9UVCDE8SVvMwUmrGpb9aw4EIEZOu+C+M5J67c7kWw8
	ZW9JB4ZZu3hWwCtgZNG4r+RlWNdLj8cG6zGd3oENYIuqpPcNX0Rct3Bk8Wr8Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RP5PpF7s/MPIIGMoHbUo9cvWo25yqbhMEZdAulcr27Y=;
	b=xjbcLESaMmPj5V3Ay1jSLYJGmtO9Kdbqb/VSXCOZ0gtd0LjYTreEo9R2F1f2XeEXCD5IRz
	ma5iZolCkHjJ7yCw==
To: ye.xingchen@zte.com.cn
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] genirq: Fix parameter type in declaration and
 definition
In-Reply-To: <202503131530063539XBMkqa4y8t8Gbdie-DRn@zte.com.cn>
References: <202503131530063539XBMkqa4y8t8Gbdie-DRn@zte.com.cn>
Date: Thu, 13 Mar 2025 12:26:28 +0100
Message-ID: <87plilcgt7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 13 2025 at 15:30, ye xingchen wrote:
> From: YeXingchen <ye.xingchen@zte.com.cn>
>
> The declaration of irq_set_irqchip_state in the header file uses
> bool state as the parameter type, while the definition uses bool val.

What's the problem?

> This patch aligns the parameter name in the definition with the

git grep 'This patch' Documentation/process/

> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -2860,7 +2860,7 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
>   *	interrupt controller has per-cpu registers.
>   */
>  int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
> -			  bool val)
> +			  bool state)
>  {
>  	struct irq_desc *desc;
>  	struct irq_data *data;

This does not even compile....

So that clearly ensures consistency...

