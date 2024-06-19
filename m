Return-Path: <linux-kernel+bounces-221290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E59A90F168
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231581F21387
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402244502E;
	Wed, 19 Jun 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YevCTLL6"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B225569;
	Wed, 19 Jun 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808988; cv=none; b=Cy17fpB5Y95WpCeOXCIic9hETa8gH7x95cW7UNnWf603P31nd3gKGVqbaLa1TWCPlTVDXl8L4iN6wPiXBuywcHbX7Nk8J7ZoL2B6xDCNtINVkk0gQS62e/WZ6mlh6NDYL0a2Jjo1v7ZNimMQD/giKtfVaa30xuPRQSexZIjyYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808988; c=relaxed/simple;
	bh=y/UdKFKcgLnAIRi0wBJ3ETmdbPUHMwGLr7VarrPAZ5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtILishGmLeyZcZSWAw01yaGiqQYb4cXnhGDXQzVWEnJBlYeZ3b2k4d60ztR0h7NiU38o0Pn3qMdimZ9D3QitYzB6J8IqjyyUZL6J0x4mm9g3B7ZzNGTIdpJCmSb8zHxvLFAeXH7/tECXKRcRek6tYrMuKAj9et7Ps0HAJjdxxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YevCTLL6; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20EE21BF20F;
	Wed, 19 Jun 2024 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718808983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4r2NhB2aVVss31PwXJ4X94RcPSjCC+jeEtPQDmEoOo=;
	b=YevCTLL6/e6zQUGcdIUyodbofzSVTQzJKfiUYLDgqO6jJj2XXNxL4uXWfmFw3Bv2P9Ftsp
	6kNhYCeaI3iDdEWEmXBFxw38/213Br61ySK5M80hcR09JWxuA6Q9JKcxQbb0tNIbeyIzTQ
	G2JT+m90V9SA2e/21+koiBaS8oJB1omYYfXfYTccDnlzEU/qPBR0SptCpOpEs2I7JPX2LU
	ednKoigNF0aDr0HQvvIW8cGmZ6CV9xLQtjSa8Bh2cXrWHJ8wAfEVa1x4Q5py/AEcUKJjTn
	ffFTvP4JQF76j6niwxQ2/FOIAnLduavSsxAVV4NCeJAuv3IwbTEEK5JAJoqq7w==
Date: Wed, 19 Jun 2024 16:56:21 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Kuninori
 Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij
 <linus.walleij@linaro.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] ASoC: simple-card-utils: Fix error
 handling in simple_util_init_jack()
Message-ID: <20240619165621.47f2b3b2@bootlin.com>
In-Reply-To: <20240619142432.573338-1-Igor.A.Artemiev@mcst.ru>
References: <20240619142432.573338-1-Igor.A.Artemiev@mcst.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Igor,

On Wed, 19 Jun 2024 17:24:32 +0300
Igor Artemiev <Igor.A.Artemiev@mcst.ru> wrote:

> Currently, if snd_soc_card_jack_new_pins() or snd_soc_jack_add_gpios()
> fails, the function continues execution without handling the error.
> This can lead to unexpected behavior and potential crashes.
> 
> This patch fixes the problem by checking the return value 
> of these functions.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
> ---
>  sound/soc/generic/simple-card-utils.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> index 81077d16d22f..5da0c13858ad 100644
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -784,10 +784,14 @@ int simple_util_init_jack(struct snd_soc_card *card,
>  		sjack->gpio.desc	= desc;
>  		sjack->gpio.debounce_time = 150;
>  
> -		snd_soc_card_jack_new_pins(card, pin_name, mask, &sjack->jack,
> +		error = snd_soc_card_jack_new_pins(card, pin_name, mask, &sjack->jack,
>  					   &sjack->pin, 1);
> +		if (error)
> +			return error;
>  
> -		snd_soc_jack_add_gpios(&sjack->jack, 1, &sjack->gpio);
> +		error = snd_soc_jack_add_gpios(&sjack->jack, 1, &sjack->gpio);
> +		if (error)
> +			return error;
>  	}
>  
>  	return 0;

Looks correct for me.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

