Return-Path: <linux-kernel+bounces-391327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A69B853A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA97281F39
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF96C18593E;
	Thu, 31 Oct 2024 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Q7UE81Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ow2QXq/w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2FF15665E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409889; cv=none; b=Jg2EvUya3vZNP+18LDajCRcU5tia/WEpOq8QQIMMYaCp42n4J42S4gorhmUx0o8rCVpmR8O5+ZVwchsqKyvkP0jKP3R1Cq2NJDU8cbgva2as9KLerTv/s0tILiRaZkV0a4ovSPzWf5je2QHW3filUjxf+dup8E8qKAbsSCuY/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409889; c=relaxed/simple;
	bh=6BVDSbH2vS7SMF4QyozPGzlzCjuY1VkukLgTiWH9QDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MwkC1/7KdjoP9EJb6+JgrzpKzMPwHsyPPMdUDmxI4ZeDx655KJIERTm74hGci5R7nRBJcgRuWnrRgETqXfEY4SUpHnUbjeGJLZUTFGGTqvcaJjTcinUuWhJ0JVw47c0VWDC7ymYy7jzcxDjSQV9t4k6+4twfZ3ZCQNivSZy86yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Q7UE81Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ow2QXq/w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730409880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FxNDeRq5WlhIXX91HnXcotAtlmHYvT9yH2MLjCKZAKQ=;
	b=0Q7UE81ZkuTqy7syu4FwnI+Ux9T6nKG2K16kXFL7DtOa8sbmNbIaDnpq3juq3gR7l+wbB7
	k6mQuT0+kfUkjky3sGQVqFt/azbYbytupd6wZ6nR2UyU99z2ULP/m0Bsizxl5owyBjTVr7
	XB7g2PybWW4R1e1FE4L5Ql++bQyP8GNl2vHl6+mjP2DuoW5+1kHGA3ryZSE965Xja7ttUx
	yjq1WdrZONPp2P2lXk1Eh80Uu7TqUV+TDKhHeUJYPQvzACvU3j2YSLoNlN1tsUcGaLPb+/
	SjHziSsgGbWqU4cKRlQSyKWEpjxd4dzgtCt8NognDOtZEJsryjEVeJZiacI6bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730409880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FxNDeRq5WlhIXX91HnXcotAtlmHYvT9yH2MLjCKZAKQ=;
	b=ow2QXq/wSvgqtlKuukTqUoUgVM+Fz6mq9pFwbzwH75rkSlHNbJ+uWUjxhWOretwGb08jlC
	mBOAXzbP07/zQiCg==
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>, Fabrizio Castro
 <fabrizio.castro.jz@renesas.com>
Cc: linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 anupnewsmail@gmail.com, Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: Re: [PATCH-next] irqchip/renesas-rzv2h: Fix potentially mismatched
 datatype
In-Reply-To: <20241031193606.87970-1-advaitdhamorikar@gmail.com>
References: <20241031193606.87970-1-advaitdhamorikar@gmail.com>
Date: Thu, 31 Oct 2024 22:24:40 +0100
Message-ID: <87r07wufs7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 01 2024 at 01:06, Advait Dhamorikar wrote:
> This patch updates the type of hw_irq to unsigned long to 

Please do:

git grep 'This patch' Documentation/process/

and read through the matching documentation.

> match irq_hw_number_t.
>
> The variable hw_irq is defined as unsigned int at places,
> However when it is initialized using irqd_to_hwirq(), it returns 
> an irq_hw_number_t, which inturn is a typedef for unsigned long.

We know that, but what is the problem this patch is actually solving?

>  static void rzv2h_icu_eoi(struct irq_data *d)
>  {
>  	struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
> -	unsigned int hw_irq = irqd_to_hwirq(d);
> +	unsigned long hw_irq = irqd_to_hwirq(d);
>  	unsigned int tintirq_nr;

It moves the type mismatch and potential truncation a few lines further
down:

	tintirq_nr = hw_irq - ICU_TINT_START;

In fact there is no problem with the existing code because the hardware
interrupt number range for this interrupt chip is guaranteed to be
smaller than UINT_MAX. IOW, a truncation from unsigned long to unsigned
int (on a 64-bit system) does not matter at all.

I'm all for being type safe, but what you are doing is purely cosmetic.

If at all, then the proper change is either

 1) to make the related variables type irq_hw_number_t

    You cannot make assumptions about the type which is behind
    irq_hw_number_t today. The type can change tomorrow, no?

or

 2) Use a proper type cast which documents that the type conversion
    including the potential truncation is intentional and correct.

    This should not be an actual type cast, but a helper inline which
    has the cast and explicitely returns an unsigned int.

I leave it to you to decide which variant is the correct one, but I'm
happy to answer your questions.

Thanks,

        tglx

