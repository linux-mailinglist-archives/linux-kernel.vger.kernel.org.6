Return-Path: <linux-kernel+bounces-330463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD6B979ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD501F23B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D3B14BFA3;
	Mon, 16 Sep 2024 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CLlx0Gqp"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0A149005;
	Mon, 16 Sep 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480799; cv=none; b=HTodIMEZ1fF8BnoAhjiPxD9ka2cDjBwVp0JneuMN9tnT3QMdKsLGhG6v12FzHETHP23WXG8zLgCpmTBu1EyQcpdrcLrMy2UQgKZpldYp8UFsmKRhuuBlu0PIo/X51e+XU/0UL0h9yYjNHiYIA63O1NnCpBWNF1Gjpa0GdDycCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480799; c=relaxed/simple;
	bh=LDr+l0/sdiG7ICkrF18qyErx3fYlYj8AjwcSGwUpmHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I582Z7HyHmwAY9GtlgrIbe9m2Yg3HIOshGJGsNVyTLTTZlZHsYu7LiGBEMHCg+PFN9dA8lK8/p9YiSl08qhFYW/lonqJow/f0O3aTvQ9LzUnEWEC+OKt7/PpDfKiTWVNskCi+eTZYXi+eb5/MUjuod7dXguf0XrvHpdrl6FDIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CLlx0Gqp; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAB121C0002;
	Mon, 16 Sep 2024 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726480788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/GA9yRiwtcFQ7dDPsBs3vafpeHgegXdK3i5eFOjlrE=;
	b=CLlx0GqpFLOoKOsTbqczn9UjiUC6hFcUmGm3nmVJDV771RcVNJIocsC0521z8vtTrypv2w
	aAoq9AeAc7RZgcByh7Blu/jp/7pvG5FsYB9EIAC1ydODZReuSKuXu9ufsnfmL6BHDzZ/pk
	Am6ec45fockeSiloFkGig26k0HF912tDPlQNZ0QwwMQDxooB8c1lFnbijsx6S/OsOJoRKM
	Vd+RhsnQGGQGRgXUJxquG2+NQaOj85qSs6HLUmgibD2l9dcsRCundb6V5uuwXizD+nLvD9
	l3SCOXvYnLa2kvcwcz17u6CjmztORgoub61SVAvtQo8cRgswcx+73cn37m5AQA==
Date: Mon, 16 Sep 2024 11:59:47 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH 2/2] ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due
 to single channel limitation
Message-ID: <202409160959473da37eea@mail.local>
References: <20240916085214.11083-1-andrei.simion@microchip.com>
 <20240916085214.11083-3-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916085214.11083-3-andrei.simion@microchip.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 16/09/2024 11:52:15+0300, Andrei Simion wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> Drop S24_LE format because it is not supported if more than 2 channels
> (of TDM slots) are used. This limitation makes it impractical for use cases
> requiring more than 2 TDM slots, leading to potential issues in
> multi-channel configurations.
> 
> [andrei.simion@microchip.com: Reword the commit title and the commit
> message.]
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 7047f17fe7a8..475e7579c64c 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -822,7 +822,7 @@ static int atmel_ssc_resume(struct snd_soc_component *component)
>  }
>  
>  #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
> -			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
> +			   SNDRV_PCM_FMTBIT_S32_LE)

I believe this requires a comment. Else someone may add it back later
on.

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

