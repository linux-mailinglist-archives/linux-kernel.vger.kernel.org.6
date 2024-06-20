Return-Path: <linux-kernel+bounces-223074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F6A910D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B591C23853
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C901B1420;
	Thu, 20 Jun 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWCECa7L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CF1AD9D4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901356; cv=none; b=iNNvW76jkbO8P/Q7Z4tFXCa/yZFe2sCbX/7isvgEimpRXEUZbXEcXP5q3lynLSJri4dkte048pwBfr+MADPR4El9dCvScrVtE52STMEpwhFiwfxVNSQhLwfIkIqDLQZ4hyXbjOJP1r1C4Fvp/scmdPK0VWmhTUCkREpvu1AwS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901356; c=relaxed/simple;
	bh=g1r/M3PDus0n0QrZiBU2y1dU5NbNqrUVstFqXzZkBsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzthmCmMvZHR2d9Gm59YkTd4zpjbxPqsZZseRHEbwX7yzWuKZpo+BZoYL7ND7Ag83fda/2pLNazfBmV1A7TQY5NXvSKCWbjIdMmUT5Pz5fflLLPRi3vaKxEmhU6AkAd2EIfiM+nJ2oGSkD8EPaMxEXPMz+OpFX4z+MPgKarj0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWCECa7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1932C2BD10;
	Thu, 20 Jun 2024 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718901355;
	bh=g1r/M3PDus0n0QrZiBU2y1dU5NbNqrUVstFqXzZkBsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWCECa7LZXbopprNia7XsS39TFPc66EmKgjVAbFevBDgg0vQT/5YbPXJ8/YDY+3qU
	 pwr1IY66V37ooS9Lpgj2Ol6r+3SEOf/8LgYkAj6RAHmO9cUzdo4YOfKNA0KBRCl9Fp
	 rJuIjHWyWoL8MPnseMB/GlF1/vHgRSktzs16VJB5FyyK/zA0xGHcV2ZHK15nV892O2
	 5z5rqLt8WUx7XP+ZurUyCmwmTrbX15XToZjqJUegMC4uXOXAS2Ol6WXcRN2GcVa0Pz
	 BXIf8LKxm4noY0reh3nPkyMy/Mj8VQSlb2lI4q+pkIEtgCq37L+B/9XDScZ3y3zuef
	 5qW4aXgBoD+UQ==
Date: Thu, 20 Jun 2024 17:35:52 +0100
From: Lee Jones <lee@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 4/5] mfd: tqmx86: make IRQ setup errors non-fatal
Message-ID: <20240620163552.GQ3029315@google.com>
References: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
 <38a69a56697a80486067f7817d4d0ed3bdea4257.1718626665.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38a69a56697a80486067f7817d4d0ed3bdea4257.1718626665.git.matthias.schiffer@ew.tq-group.com>

On Mon, 17 Jun 2024, Matthias Schiffer wrote:

> GPIO IRQ setup can fail either because an invalid IRQ was passed as a
> parameter, or because the GPIO controller does not support interrupts.
> Neither is severe enough to stop the whole probe; simply disable IRQ
> support in the GPIO resource when setup fails.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: no changes (was patch 3/4)
> 
>  drivers/mfd/tqmx86.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> index 5aa51ead00a28..7f9ccd83278dd 100644
> --- a/drivers/mfd/tqmx86.c
> +++ b/drivers/mfd/tqmx86.c
> @@ -259,13 +259,14 @@ static int tqmx86_probe(struct platform_device *pdev)
>  		err = tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
>  				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
>  		if (err)
> -			return err;
> +			gpio_irq = 0;
> +	}
>  
> +	if (gpio_irq)

Stacking identical if()s one after another doesn't sound very efficient.

Why not put the contents of this one inside the one above?

>  		/* Assumes the IRQ resource is first. */
>  		tqmx_gpio_resources[0].start = gpio_irq;
> -	} else {
> +	else
>  		tqmx_gpio_resources[0].flags = 0;
> -	}
>  
>  	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
>  
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
> 

-- 
Lee Jones [李琼斯]

