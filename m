Return-Path: <linux-kernel+bounces-424560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED79DB5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9546BB21358
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7848C18BC3F;
	Thu, 28 Nov 2024 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyPZAtWA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xo4AX0OZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A311428E7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790355; cv=none; b=L2uFto7arbntgd+jXB/sLdp6EgZH5PPhFHvALtEDcKb9+hOMJp1j0zmxTMb7XEiGsTJONaJqnw1utgdaKK/iA8w6vOYaptWgjIr+omo/0Afsm5dcrqxFpo6NvMqufWBPcitLDYpiYs2CDJkULsavaGo4JlX0VPULlZEJ0Cthwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790355; c=relaxed/simple;
	bh=CoHjXnpUh7EO9kYD5jG5L5l4/UeBxiz/gjwnRsjvJdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KtfelzVEDiqzDG7M6fCsA+KpLx3UCpO1TZQMra56dGGbbX2LpB1FUKC5afQJ1fPrOW0TBv4n8kcAFqZ2gatgVG822AKH8STELtu9haYdoRG6KAbV9q2NvoxSHxWWg73X2L92iqT35cfmnoHiaYjveUhjdla3cwAJp5/HnSU658s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cyPZAtWA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xo4AX0OZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732790351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dYmxpAymuaS1BHhRzDYCr8r7Tzu8mgJe4gNvGTzASXA=;
	b=cyPZAtWAGKbtlFWs9cEMvxPPbhEBsBnTgasmylViURLKCrFJZq4KUFb2hoQpVM+0Z9ZI1Z
	HO62GdcPQtLBS0emt0zgsqqt8D/KJgT9r+iriajxxywIfQ6InBLGnR/p2k6Co013cESbNE
	ZvqJB7jykaIt+TTjCTah9MpBi+fFiSzt5O6vnOLUxNefLPuZF0690cl1N4NcAIj9j3P05B
	i8Z31ZLczDPUPOurcPUxWuYufOzQVlkWXNONCH5XfzBTyT4KInz3+mkpb8kW0bPUR15U5W
	jeOXwEKawd/Jj0uU8epeY5AZbW0xLvajafN4AKc+/Cj7jduIIf0H8gha7FcrAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732790351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dYmxpAymuaS1BHhRzDYCr8r7Tzu8mgJe4gNvGTzASXA=;
	b=xo4AX0OZ4yOQ7vQ7VDws86dLP7aK72d31WgBVqTxbaNaz3x+dO9DcPO/XU471u3j9BZxhr
	jOpHg1fBovstYFCw==
To: Eliav Farber <farbere@amazon.com>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, akpm@linux-foundation.org, bhe@redhat.com,
 farbere@amazon.com, hbathini@linux.ibm.com, adityag@linux.ibm.com,
 songshuaishuai@tinylab.org, takakura@valinux.co.jp,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Cc: jonnyc@amazon.com
Subject: Re: [PATCH v2] arm64: kexec: Check if IRQ is already masked before
 masking
In-Reply-To: <20241127152236.26122-1-farbere@amazon.com>
References: <20241127152236.26122-1-farbere@amazon.com>
Date: Thu, 28 Nov 2024 11:39:11 +0100
Message-ID: <87o71zy75c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 27 2024 at 15:22, Eliav Farber wrote:
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 80ceb5bd2680..54d0bd1bd449 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -142,11 +142,8 @@ static void machine_kexec_mask_interrupts(void)
>  		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
>  			chip->irq_eoi(&desc->irq_data);
>  
> -		if (chip->irq_mask)
> -			chip->irq_mask(&desc->irq_data);
> -
> -		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
> -			chip->irq_disable(&desc->irq_data);
> +		irq_set_status_flags(i, IRQ_DISABLE_UNLAZY);
> +		irq_disable(desc);

This is just wrong. If the interrupt was torn down, then its state is
deactivated and it was masked already. So the EOI handling and the
mask/disable dance are neither required nor make sense.

So this whole thing should be:

		chip = irq_desc_get_chip(desc);
-		if (!chip)
+		if (!chip || !irqd_is_started(&desc->irq_data))
                	continue;

But what's worse is that we have 4 almost identical variants of the same
code.

So instead of exposing core functionality and "fixing" up four variants,
can we please have a consolidated version of this function in the core
code:
                struct irq_chip *chip;
                int check_eoi = 1;

		chip = irq_desc_get_chip(desc);
		if (!chip || !irqd_is_started(&desc->irq_data))
                	continue;

                if (IS_ENABLED(CONFIG_.....)) {
                        /*
                         * Add a sensible comment which explains this.
                         */
                	check_eoi = irq_set_irqchip_state(....);
                }

		if (check_eoi && ....)
                	chip->irq_eoi(&desc->irq_data);

		irq_shutdown(desc);

No?

Thanks,

        tglx

