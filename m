Return-Path: <linux-kernel+bounces-287885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07127952DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84116B269FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769D51714D2;
	Thu, 15 Aug 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t+XoJRf3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17/VBa7g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2297DA6D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723722250; cv=none; b=CyTvM58AgQdNfqUWA7Xoe7dPvI/g2gs10GyPmwl1XhcgZ+sDCThZHCnWBPOQiGXgQK/vTFH1Sn5YoDCkmsYiI45zE0Z2bsTaOjqlwwYKcGW/anDEl0o0y7W7a8XRzDbo6BFgQaRMt47tA4ViY6Lf3l7CZDQVyUzio+kT9b30IfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723722250; c=relaxed/simple;
	bh=bgX4kKQorYaSME9RJteWf0rKwAWYx/F0c3jnKSj4HzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=biASQG3KV4zlQ9EYZzBSdvXJcXWT0Sw6hZbAlcH96WLGNLxVCDsYPt2GdygqTQtWFeYHSDqyM9gK2lsRYrLAQxXf7tQgXY7NSr+wDPvINmfLoGSeJq28HD+7dPI46b9/AVoN0eFFxQwAChESCLayVXSJzQWNDNoWIRtjY2r7w1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t+XoJRf3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=17/VBa7g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723722247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqUsbSq2R+8U72AfUd3SQ6tENIkj+ufWopC5V72X18k=;
	b=t+XoJRf3L9lVbi8e14cbrqRYKPnQlndmlZxwJStKwWpyEeOVHZ/IXPgN8AU6X6b60ty2cF
	c1nLatrNtjk+gcj+nr2zoLBEgxGyhkKUFeBaow9/YI5D3dgS57sFPai14ujNjOLePMBYER
	IJf4W97IkeLLesRT+3txmsL9zQCHPmwZzw4cJCekYUyL4AK0VBND0dgCewxci9N2wk4DoK
	/ZdDbADTvnKooJjw2t28lQMSK4gBhqNXouBijtfwxmVnangSJO1BoFddeus7PLkkGFuP1P
	q0VSQjDAbKQbVBq7qd1WTaXVUl8tgsVlQYObUTarCZf2uvvfM/ITqRdg+U2Yqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723722247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqUsbSq2R+8U72AfUd3SQ6tENIkj+ufWopC5V72X18k=;
	b=17/VBa7gEEyquNhFgRqvepRm1Y15NrPBQaltTU9nrKhdO4jrXKV204Z/bfEF3VimsvaaD3
	ikOoDu9+rxzSWjCQ==
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Anup Patel
 <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland
 <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx>
 <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
Date: Thu, 15 Aug 2024 13:44:07 +0200
Message-ID: <87ttfmm2ns.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 03:29, Emil Renner Berthing wrote:
> Thomas Gleixner wrote:
> Thanks for looking at this! Unfortunately the above patch isn't enough to fix
> the issue:
>
> https://termbin.com/7sgc
>
> It still hangs after the "[    0.176451] cpuidle: using governor teo" message
> until the watchdog reboots the systems.

So what's puzzling is that there is a timer installed early on:

[    0.000000] clocksource: riscv_clocksource: ....

That same init function installs the per cpu riscv clockevent, so there
should be a timer available.

The deffered probing of the PLIC driver delays obviously the probing of
the sun4i timer, but that should not matter when another timer is
available. So the sun4i driver might be a red herring.

Can you please add "ignore_loglevel initcall_debug" to the command line
and provide the output of a booting and a failing kernel?

And on the booting kernel please provide the output from:

# cat /sys/devices/system/clockevents/clockevent0/current_device
# cat /sys/devices/system/clockevents/broadcast/current_device
# cat /sys/devices/system/clocksource/clocksource0/current_clocksource

Thanks,

        tglx

