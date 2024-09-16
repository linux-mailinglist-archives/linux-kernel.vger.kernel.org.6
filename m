Return-Path: <linux-kernel+bounces-330782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B297A42B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE5528DD3D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F4155359;
	Mon, 16 Sep 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BHbjGyh2"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C94146588;
	Mon, 16 Sep 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497098; cv=none; b=F9uBvyD938lU5xi6EfjlK26aHda8tATDqQ4nuLsfJFByc2Z6RfsEc0ZgtybuP4zC9n8RC3rpTC8eem9x2FkFK2T+uFj/CDS9wfv5q3Mt0UDI1ToOkkhsTYnkSW6SgVkY6Q4+bWQrb3HTWWb85Gabetp+CizNnxP5I5lMh8HzVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497098; c=relaxed/simple;
	bh=BkNqGrNJ3t46F7Xl1BYz61Tm9LXflIUC4aRap28qLVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9QVGORa2+b7RfMZuR/nihaunGnMkrT9UkCQFOwLJ3CkquX0pBg7aIdSXuyB6A2Frkq3UuFznkNJ9tAZkDekHkyo1DVEGrfV/U8K62kjUA7N6IVAy2GpLj5Evae30m4TM0Pzy6Vin3pl7RHJlmmPz8gkkxSGccYSgDgoUb4N7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BHbjGyh2; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8DBC20007;
	Mon, 16 Sep 2024 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726497092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QloBWWiiQvJ9odjtbk/ZDUQVWAaXV9wS+D1Lf/XH/qc=;
	b=BHbjGyh2V5W711FYpda4uynjp9Pj7IzPDyskiBG+W33xrLTe4hJGafNYQ2BkZUdzN7ftwR
	MKNQPQrkh7rvh1McVuzovwb5SGe3qZU55e/i+nq3VUJyaT2xRkcyf/w7QhgMTfxbrkXdtT
	D9CppqOIjE+yv2ITa1z4fLQCk/TALo7kZSJHF+bDv2pGIEH+XAU86aXLK9Ej1otx8IdIkV
	HJv/3VsiYZ3hkmcrS2jSB08bDnpHag2L9lVW6g2bN/C1NXCnZnoTMdhqzZtqTD0pYhxp1T
	y06RDUJYQNdUjPFF8EsNQkjPlLKkzkj41Z0J0YXmoiiFk7N3VrHoIi+MVVYp0g==
Date: Mon, 16 Sep 2024 16:31:30 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH v2 2/2] ASoC: atmel: atmel_ssc_dai: Drop S24_LE support
 due to single channel limitation
Message-ID: <20240916143130835e72b4@mail.local>
References: <20240916131910.22680-1-andrei.simion@microchip.com>
 <20240916131910.22680-3-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916131910.22680-3-andrei.simion@microchip.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 16/09/2024 16:19:10+0300, Andrei Simion wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> Drop S24_LE format because it is not supported if more than 2 channels
> (of TDM slots) are used. This limitation makes it impractical for use cases
> requiring more than 2 TDM slots, leading to potential issues in
> multi-channel configurations.
> 
> [andrei.simion@microchip.com: Reword the commit title and the commit
> message. Add code comment to explain the removed code.]
> 
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
> ---
> v1 -> v2:
> - add code comment to explain why S24_LE is dropped.
> ---
>  sound/soc/atmel/atmel_ssc_dai.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 7047f17fe7a8..89098f41679c 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -821,8 +821,9 @@ static int atmel_ssc_resume(struct snd_soc_component *component)
>  	return 0;
>  }
>  
> +/* S24_LE is not supported if more than 2 channels (of TDM slots) are used. */
>  #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
> -			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
> +			   SNDRV_PCM_FMTBIT_S32_LE)
>  
>  static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
>  	.startup	= atmel_ssc_startup,
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

