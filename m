Return-Path: <linux-kernel+bounces-294214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E60D958AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D55BB24CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951D01917F6;
	Tue, 20 Aug 2024 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YEnweZCy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JUf+c80M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798AC8F48
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166300; cv=none; b=RCCtu16USHxaqZVDIsd4xYjxrPhsyG1lijHC6v/+rrIDcz6dL+/CSY1YvH65JaRopynKe6NbvOw6G8Nx/+I83UmWn/il3LimeBgk0ZP6PwVE8F03FopGfl9R0c+tFB9xp4SbqNXY9xdaGKs2AsjfXSPtG9wtHUtn1IqK31Qae6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166300; c=relaxed/simple;
	bh=O4BaPPrZUpvcdK+hpJ9KSg5DTZwKesZwnXnfpDtsWSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FFWUxzpyqHUxECiuDkBS2YM1dAQwBHpWeRpp85hn1mw+/myOa66sbjRV7p22NnipY1Ht9fJd3+9sr2FHmZZb1ZZonTlv0K6I0elMn85f24q+QotWokRyAn3iUAaUENy5d6sqAxr5j4AAFh9zcY2k6Hbdhsmt81RLZ2ZnBJn+5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YEnweZCy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JUf+c80M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724166297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jutzbFVtDjLzUKkFixrW19VfHuctnJnFjP5315a6ero=;
	b=YEnweZCywClB4gSYEOeGlGXu1CGiltn5GSfYAscPYiCx1FnE5z3fNxSagh8dZ1VjfxaFdh
	0LCsEJC/anJQr3dzUbUttv4HBpW4ZvXkg0JcqL0VFdlkGjDkGnv1hIG2juSBMNF/46ghae
	cC553NC3YuCmrZ/zgnROW0WBlW48VfEZrNnaDcoWbcOCF0kB3L5+AQo7nwWEHPy+UwaNfb
	MYC0JUj7e+Q47b899JvB1/gN6GD2us10l/8/vogH1eJ0ZGr6EC1/l+gYDR0/LUOdLQREuU
	SmDvS4JPKYuBm9TpU1ygLzmTr0QqNmfXUhnoD/hX6CNcEbR9N8MFyyitfqEKYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724166297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jutzbFVtDjLzUKkFixrW19VfHuctnJnFjP5315a6ero=;
	b=JUf+c80MEZI2v9bgRxljapByyu9192D3hdQVIXhAUDQ6AdGmpdm3m3eRCjHbY8ovGpQ7jB
	SpKEPokWvf80MnDA==
To: Jinjie Ruan <ruanjinjie@huawei.com>, paul.walmsley@sifive.com,
 samuel.holland@sifive.com, apatel@ventanamicro.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH -next] irqchip/sifive-plic: Fix IS_ERR() vs NULL bug in
 plic_probe()
In-Reply-To: <20240820094542.1576537-1-ruanjinjie@huawei.com>
References: <20240820094542.1576537-1-ruanjinjie@huawei.com>
Date: Tue, 20 Aug 2024 17:04:57 +0200
Message-ID: <87plq3jkva.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 20 2024 at 17:45, Jinjie Ruan wrote:
> The devm_platform_ioremap_resource() function returns error pointers.
> It never returns NULL. Update the check accordingly.
>
> Fixes: b68d0ff529a9 ("irqchip/sifive-plic: Use devm_xyz() for managed allocation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 9e22f7e378f5..cea8dca89c50 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -511,8 +511,8 @@ static int plic_probe(struct platform_device *pdev)
>  	priv->nr_irqs = nr_irqs;
>  
>  	priv->regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (WARN_ON(!priv->regs))
> -		return -EIO;
> +	if (WARN_ON(IS_ERR(priv->regs)))
> +		return PTR_ERR(priv->regs);

This is obsolete by now:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=irq/urgent&id=4d936f10ff80274841537a26d1fbfe9984de0ef9

Thanks,

        tglx

