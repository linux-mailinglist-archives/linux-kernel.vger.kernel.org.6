Return-Path: <linux-kernel+bounces-288396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EF79539AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AEF1B21BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B8481A3;
	Thu, 15 Aug 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YJGog9Na";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pz9qjuQU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B815CB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745429; cv=none; b=aYQR62vCqdWd8cphzIYMx2Lco0by5VGdFM1zOkyJBiGzOJkiZ3HSmWoKhXFpginOvmR8OXMkL4mxe5hraFrHRHnpVvzhB68IKNK93EDThLe824PIwa+Hx/PbTR1TzXyk+zi2LOeFCHGhmWbbPwk4sMR2R8Yodffe3H7v3uwaDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745429; c=relaxed/simple;
	bh=Ln08iy0xj4KLwN0u16OE6nU1+VzGo+CUqWdXxb2EaOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=liWedHGXUH2at6k00ShqpBKrt5xsyFy/T/55WsIOa2J/1olz71p2BpDOY/oOkZ8DvlwH/UZ7XuVRGm/PUhcMBaM9H8n9U6ZPfw97/ZZp2qAEcZiIlWsUvngKPF+zqWvUJgJ9sRRUm0pNtn3m7LoNs7ppBDRlSblVf4vLw8EQzis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YJGog9Na; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pz9qjuQU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723745426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIcN+dIpsXv32UGdjkrhLz6191NfIjPhsUje1gE84Ek=;
	b=YJGog9NahT5FBJYT42XzusFUmigYmnDfd+JLK0/zYmUsEGcqIJW+41DEd4KzKkCmff4+rO
	5vVQ1dELVh4U/zx3KO2t8XEuUI67pTEg9DCfaEODuKkSo/vpjrX3nbpfFeFS1sVR+gVC46
	3M/wd89TS2e9kVk4j/qZOUi9Mf8RdhSYbdre6evbVFfj2+69PBAk0w3Y6PmiszOgQI1r6r
	yisI8NXFi1v9PSSpgOfG0rYUgbC0sg6jDlnjcYeyO26cUUaIfC9pqAr180iHr46d+GCogZ
	PVspcb4B5A2GWMaHHgC92UBBi1fYOtkGt8HPXXXJ25FaFWntURDc9MP7KLd4wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723745426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIcN+dIpsXv32UGdjkrhLz6191NfIjPhsUje1gE84Ek=;
	b=Pz9qjuQUyR8OhF/TBmmZiUXsC7RCoLOjJO846L4GaTFJPylLrqwjnO/HyVujGQl/laZYwe
	L6dRlDcMQbQ8sUBg==
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 apatel@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
 samuel.holland@sifive.com, aou@eecs.berkeley.edu,
 daniel.lezcano@linaro.org
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <mhng-5403a4a9-4cdf-447f-9c7e-ea655a2f86fc@palmer-ri-x1c9>
References: <mhng-5403a4a9-4cdf-447f-9c7e-ea655a2f86fc@palmer-ri-x1c9>
Date: Thu, 15 Aug 2024 20:10:25 +0200
Message-ID: <8734n5mzce.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 10:51, Palmer Dabbelt wrote:
> On Wed, 14 Aug 2024 10:30:48 PDT (-0700), tglx@linutronix.de wrote:
>> I'm very much inclined to take the reverts right now, send them to Linus
>> for -rc5 tagged with cc: stable and ignore/nak any irqchip related riscv
>> patches until the next merge window is over.
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> if you want to take the revert.

I'm happy to wait a week and see whether someone gets that CLINT hack
working or as I suggested the D1 PLIC early probe quirk.

> IIUC the patch above doesn't actually fix it, that's what led to just 
> sending the reverts -- at least reverts are better than breaking users.  
> I'll post over there too...

Right. We figured that out by now :)

> And it's no big deal if we're in the doghouse for a bit.  Regressions 
> should get fixed faster than this, so we deserve it.

For a week I consider you probationers :)

> Probably also another sign we're way too focused on getting new features 
> merged, as that's coming at the expense of making existing platforms 
> work.  IMO we've been way too focused on getting support for specs that 
> don't even have implementations, and not enough on building real working 
> systems.

RISCV is not alone with that. This whole industry is nuts about features
and forgets the stuff what matters.

Thanks,

        tglx

