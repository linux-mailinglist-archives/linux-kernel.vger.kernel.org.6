Return-Path: <linux-kernel+bounces-286985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B319095212E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17334B26DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41B01BD4ED;
	Wed, 14 Aug 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MSaMv5EL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="51gIiEmb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF631BB6AC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656653; cv=none; b=FyhWxGMfISrr5JcuV5RFB9MUWtJsu4HSs+hcamaTkgCY8chHWWqea5HQGN+xMG9I+nKbI6ki/1FiVzz3vaP4XcZwpXyZhNZZZgXH9C66by04M8GTX2Vl+qSR510/adSMJGb0Q6/vQuY37I6z9mQhZrQCdP/Rd19su9B3JU6Twg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656653; c=relaxed/simple;
	bh=uzNc/de5qdgF4oVG69+XvqZ5FYosov1VYIe9b2g6+no=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ciqlSdAd0jNLQQ6XQ1B1pNt+U0rC6bTJVuFzJNZ5cxYgMX6gdAJB6OWF0SHRsbdIs1XoMwiICYYUn8V/iEwRbEo7zRArILL80HrI1wylIN7XgW56jug4d6/LUli8mGpWkBqMpInnN0mF4to94NSbO9b7jBPTGhmhfzf4w6BK4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MSaMv5EL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=51gIiEmb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723656649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqn57+hZpi2Jjt0F8Cxl8qD8kTNfwnws6c4Z/aS4j3A=;
	b=MSaMv5ELjf6YU252iBOFfNt7fZA7h5IrmObPt8a1Zoju6cViiv8y2MyO0IIcAUMGapaB30
	Zmz4y8qrg27IHBaqcIdTufbm2ch2wq156Z094fRKIBG2dxJBV9uCr58B6QaWfEFCtTTUog
	mcBWt+j/d/D5Pa7OA7DIlKNlRwhrooz4IpT9UK5Q7YBHDDh7DiXq6UWl8AoMGWcIGU/2vT
	CGaPdzcs01jlctdM9zL2LdQ2oxPJAP60WIi6kMuXQ6EZeEGwJbIEZGh/9nDzh6SuwlsejT
	aWNZJAWjPNfUKsqxUMCA/ibJMYlb4jtJi60+LM2NpQ4KG+kBOB/Cgx4Q26jB/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723656649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqn57+hZpi2Jjt0F8Cxl8qD8kTNfwnws6c4Z/aS4j3A=;
	b=51gIiEmbB93sjEkL/jOUNOL0gex8kw7ZOz+bjn6YvcXCXga0bjPN3vhL3n6FT88T4lM0wb
	1JffiTmJXDiaj4AQ==
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Anup Patel
 <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland
 <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
Date: Wed, 14 Aug 2024 19:30:48 +0200
Message-ID: <87jzgjnh9z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14 2024 at 16:56, Emil Renner Berthing wrote:
> As described in the thread below[1] I haven't been able to boot my
> boards based on the Allwinner D1 SoC since 6.9 where you converted the
> SiFive PLIC driver to a platform driver.
>
> This is clearly a regression and there haven't really been much progress
> on fixing the issue since then, so here is the revert that fixes it.
>
> If no other fix is found before 6.11 I suggest we apply this.

So this mess has been ignored for two month now?

From the pastebin in the initial report:

[    0.000000] irq: no irq domain found for interrupt-controller@10000000 !
[    0.000000] Failed to map interrupt for /soc/timer@2050000
[    0.000000] Failed to initialize '/soc/timer@2050000': -22

This comes back with -EINVAL. So the timer cannot find an interrupt,
which makes it pretty obvious why the system stops to boot, unless there
is some other timer available.

This is obviously related to the SUN4I_TIMER because that message went
away when it was disabled according to the next pastebin.

Obviously that can't work because the SUN4I timer driver is using
timer_of_init() which cannot handle deferred probing.

Daniel: There was a partial fix for the sun4i driver, which you said you
applied:

  https://lore.kernel.org/all/20240312192519.1602493-1-samuel.holland@sifive.com

But that thing never materialized in a pull request.

And of course everyone involved ignored the problem since March 13th
2024, i.e. almost half a year.

Seriously?

Can you RISCV folks get your act together and ensure to fix things you
broke on the way? Especially when Emil reported this nobody pointed him
to this patch and nobody noticed that it's still not merged?

It took me less than 15 minutes to find that patch and the correlation,
but this is absolutely not my job.

I'm seriously grumpy about that. This is not how it works. If you break
stuff, then you take care to fix it before you shove more changes into
the tree and waste my time.

I'm very much inclined to take the reverts right now, send them to Linus
for -rc5 tagged with cc: stable and ignore/nak any irqchip related riscv
patches until the next merge window is over.

Emil, can you give that sun4i fix a test ride please?

Thanks,

        tglx




