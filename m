Return-Path: <linux-kernel+bounces-431208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E513C9E3AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86AC2B32F88
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5225D1CD1E4;
	Wed,  4 Dec 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="UHSjzjLF"
Received: from smtpcmd13146.aruba.it (smtpcmd13146.aruba.it [62.149.156.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5781B87DB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316801; cv=none; b=rqoh69DlpIy8z86xd9NSiO69yRpo1z1bkSu6dLwQ0m4sLCtWEQbe8YTM93LniJ7Y/8MDZyMF55bnEU/IHNPBgXk5vbTe6/s+rzUyzonrw77B0CxdJCgY0JP1Dt0Un08tNpS/g49Y5dnP97tyjItCqpXPl3LqEsj8mX+7UDOu+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316801; c=relaxed/simple;
	bh=IysS3rHs/JHf6XhJEvL72br8M81d5wo4QOkAooc0WO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIoJ02Ncr9oyO4OuLy+65fSArmDtTqVGj5rdRXeBShQqR6ChpmH6BaEESSLsNkN60tHqljCCC6yTYNos6NxY6lxjO7owPvehGdr1JVYoWjoL/vIc0DQuxr+U695d4KsKqNDmh1voopPCIJLI33/F8+hFOaYCICflRWdN9Opo/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=UHSjzjLF; arc=none smtp.client-ip=62.149.156.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [172.18.100.99] ([109.238.20.116])
	by Aruba Outgoing Smtp  with ESMTPSA
	id IosStLZCN15fBIosStPw9E; Wed, 04 Dec 2024 13:53:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1733316793; bh=IysS3rHs/JHf6XhJEvL72br8M81d5wo4QOkAooc0WO4=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=UHSjzjLFhRsp/WHJQrsDFHilGmMiLiV3zxnz9clVAt08cFxDDOIK7ZFFgDjk7R1d3
	 xY5xU+kjAM1deTezJDSUB5r4MsvXK+R3ogf+cgq9wwPY5jIU5fsrtJq56dpaOWthpe
	 P5KLhVhjplBThM4XDK7w+lVP5pj45o3rJKNVGftcfxPFWDFAwh1fui3N8NguoT4qmm
	 Ip6g14yYEWdR8FARfMJ9vksxuikdJ6vnkj4NVY61GtF9Qe0y31ahqRRnnc94GqUDqF
	 9QwBNvyOGz/r8MMOeU9RfQVh4hX3fDxkZpQ40eCH5m00KmsH6W/Tba16k/Nl8YzYCT
	 ayv27EXpmeloQ==
Message-ID: <9b62866a-8e8d-490d-9e45-4a6afa1c3559@enneenne.com>
Date: Wed, 4 Dec 2024 13:53:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 1/1] pps: clients: gpio: Bypass edge's direction
 check when not needed
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20241204122700.1203310-1-bastien.curutchet@bootlin.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20241204122700.1203310-1-bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLvVP6hgPjqdkBrrTyxWL7Co+gOBufeAQky+DET27cTgHgDiKUbYPrRJAgoupa/JLkYcX9oGqvvGeCsl3zsPwLR1xFmi+XX1HszPpJMiMheUj9lEC5OH
 Z4vYA/IMiUBolHprmUAz/R2SpqBilpoOB4Su/hU/cKGoJXWeJfizjxuORuYkKdlsSsjH9g5zH4aCJWQ0PK2DNI/fGeY6RA59z6NHyVuBejaha8je/CYC2ro3
 CyD4ER2mF9jOxExFVOgBgRweudYUuLV7gIJkusZm0i76pDYftoaveV3O1Ow2wrvQVICtHVKIYe4aTUpLkoIG6Ib0DRjq1P/rAg9Q3PjRxSrVFlXPL+6WHnzk
 mFbIIVH3wK7nJJa1VnuUevAOLZ7etpps7EWDSlWDKYmPoS3ThYGdEgxU+4Biu2jmXuE+VMxTivYGjTHiNi1y9KmXjk2f8N67NqxqyQEty+tteJdJ25c=

Greg, Andrew, this patch is ready for the inclusion.

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

On 04/12/24 13:27, Bastien Curutchet wrote:
> In the IRQ handler, the GPIO's state is read to verify the direction of
> the edge that triggered the interruption before generating the PPS event.
> If a pulse is too short, the GPIO line can reach back its original state
> before this verification and the PPS event is lost.
> 
> This check is needed when info->capture_clear is set because it needs
> interruptions on both rising and falling edges. When info->capture_clear
> is not set, interruption is triggered by one edge only so this check can
> be omitted.
> 
> Add a warning if irq_handler is left without triggering any PPS event.
> Bypass the edge's direction verification when info->capture_clear is not
> set.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
> Changes in v3:
>   - Add a warning in irq_handler
> Changes in v2:
>   - Modifiy the way the bypass is done to avoid code duplication
> 
> v1: https://lore.kernel.org/all/20240410113502.73038-1-bastien.curutchet@bootlin.com/
> v2: https://lore.kernel.org/all/20240411061329.7262-1-bastien.curutchet@bootlin.com/
> 
>   drivers/pps/clients/pps-gpio.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 2f4b11b4dfcd..af62d944d051 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -52,7 +52,9 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
>   
>   	info = data;
>   
> -	rising_edge = gpiod_get_value(info->gpio_pin);
> +	/* Small trick to bypass the check on edge's direction when capture_clear is unset */
> +	rising_edge = info->capture_clear ?
> +		      gpiod_get_value(info->gpio_pin) : !info->assert_falling_edge;
>   	if ((rising_edge && !info->assert_falling_edge) ||
>   			(!rising_edge && info->assert_falling_edge))
>   		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
> @@ -60,6 +62,8 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
>   			((rising_edge && info->assert_falling_edge) ||
>   			(!rising_edge && !info->assert_falling_edge)))
>   		pps_event(info->pps, &ts, PPS_CAPTURECLEAR, data);
> +	else
> +		dev_warn_ratelimited(info->pps->dev, "IRQ did not trigger any PPS event\n");
>   
>   	return IRQ_HANDLED;
>   }

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


