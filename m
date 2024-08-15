Return-Path: <linux-kernel+bounces-288390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7BB95399B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1D61C22187
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1774402;
	Thu, 15 Aug 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jHiTJjKS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RytdbaJ/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8B73451
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745054; cv=none; b=nK8mwgtDE2Wn1e1MF0HXUgBuQFWXHroKokxBUYl92XlHUpkdOacI+9peQgi0SLa/M+sRduTz29L1PaoY5OgcVTr5u5ou4PD7g5gI3XAWMvsUqE/arynyHgJ94XTjbksS3YPwJggOOEsJN/YXc6BxOveeWGv8H37xhrJURsDlIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745054; c=relaxed/simple;
	bh=eUWcktx89PC/aCAxjOLj/7f/2X7g0qeztQthiR1iuWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=plPHzgHU58GeyN7HApwiJbwcKWkP+pqirER6FfVX40h/jaFLcN5rGmkq3BnHCyV8pAFmG6LO6PUMThiNvD4wDyVxM2B5UM/a/Lcct3c7SfvBbZ2tTl/Vv2Z3nYkFJM3YFPCZFA86g4rtQ9IzQ5JCqm9jCZg2DO/bEj0utt6onAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jHiTJjKS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RytdbaJ/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723745050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cjy/zRvsVofN6wE4iw4bXjX1k7f4+3khBASQg6Qxl+E=;
	b=jHiTJjKS8jvRv8Mjg5E2vOulrZ1G7uliNrXR4n3QzO8v/yw9bmpxCIIhaOlw5qunrLjqWS
	Vif20eBiOfdoW16+Cqsgg6+7+szbU1JCbUXNujE4DWc1TJAxc2Nm0Tw1/6tBrDIJUtFgFD
	J5iZNVfp05PceXfmZc2J+DaiHxwt9mwO2iK3VGQnyJI4pCkgjsEQASbwZbxmopW9y69FvV
	F282XHbsC0pXoyAiWrUZBoGpUWEdTrY2jmpbOrcJv+dTXoUvGFZUMu4E7244Vue/rWQ4WH
	Rrgwc38vEw48IJSeKVI0Ghsrz7MNjT8VKL+OFZe33qz7sq1PYsmOBUhXgCFv6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723745050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cjy/zRvsVofN6wE4iw4bXjX1k7f4+3khBASQg6Qxl+E=;
	b=RytdbaJ/0781LRnmvGSLZxhRaolVZLmk7/TCaOtZlto6LocFO/vs/jcTXIkyEynFupLSaY
	aF8Kg07KrKPnQIAA==
To: Palmer Dabbelt <palmer@dabbelt.com>, samuel.holland@sifive.com
Cc: Renner Berthing <emil.renner.berthing@canonical.com>,
 apatel@ventanamicro.com, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
 aou@eecs.berkeley.edu, daniel.lezcano@linaro.org
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <mhng-91e79885-7652-42a4-aad0-f4713e7ac70d@palmer-ri-x1c9>
References: <mhng-91e79885-7652-42a4-aad0-f4713e7ac70d@palmer-ri-x1c9>
Date: Thu, 15 Aug 2024 20:04:10 +0200
Message-ID: <875xs1mzmt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 10:51, Palmer Dabbelt wrote:
> On Thu, 15 Aug 2024 08:59:37 PDT (-0700), samuel.holland@sifive.com wrote:
>>>>>> Sigh. Does RISCV really have to repeat all mistakes which have been made
>>>>>> by x86, ARM and others before? It's known for decades that the kernel
>>>>>> relies on a working timer...
>
> It's even worse than that: RISC-V doesn't even mandate any working 
> _instructions_, much less anything in the platform/firmware.

So it's definitely taking the award for architectural disaster and will
probably keep it for a while.

> So I think if the revert is the best fix then we should revert it.
>
> That said: If the CLINT works, could we just add a probing quirk to make 
> it appear on these systems even when it's not in the DT?  I'm thinking 
> something like adding a compatibly string to the CLINT driver for the 
> SOC (or core or whatever, just something that's already there).  We'd 
> probably need a bit of special-case probing code, but shouldn't be so 
> bad.  We've got some other compatibility-oriented DT quirks floating 
> around.

Alternatively, you can have a quirk in the PLIC driver for that
Allwinner D1 chip which probes it via IRQCHIP_DECLARE() as before with a
special probe function and denies the later platform probe.

Thanks,

        tglx

