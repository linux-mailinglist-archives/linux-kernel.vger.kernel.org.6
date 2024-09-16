Return-Path: <linux-kernel+bounces-330655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA1197A257
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28CE1C24B27
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D11146A79;
	Mon, 16 Sep 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pzyO8VcD"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F141862;
	Mon, 16 Sep 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489857; cv=none; b=lXDkdOF+3RLNpx478vREgL2H9Kj/FW1rB41zrW520CwRiiMCQiPIpYNdC2snSpNIjaqNYaerhilQtB5qnSWEDtbIzuiLBmU/H+e/SkhGxpDrbKdz9xidnRQV8NZsC40b6wc3ifpZmGM+edE9Ihhp42IdXMYkeXpULb+MMs+eN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489857; c=relaxed/simple;
	bh=XlofpYMtyVQKy2CQEZ9vtgpMy0tI2NYSeC/qF+i14OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtUmzF0iYQ56NTR0OPutnJb7D6e0hNPrbVfrfM0WRjFugPfyoTz9KB1YhFafZxQI9kQ+B4CcBwYAXWO1iykJVMN4fEYb3r6P4tZm2zyc3hbhonMawi2/53vA7qUFj2vOKFv3eQksKnauD9HAThuJVPCyNbG64j9N5V5p/eGBxsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pzyO8VcD; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 649CCE0002;
	Mon, 16 Sep 2024 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726489847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFf33Dr3Av9cjGRxcivDJ7jSpxWV5p1tiUMWvEOn8Fs=;
	b=pzyO8VcD5eOWNbaF6y5cYWnDO6KCPDjbQFX46CYw8eVowhXH+FOzUJRqgXamOzGtfCk8o+
	l9agNcz7sCkPqj9f/VpFUBciP8le0nMok+7c6gWmjxRoAVSTt5kS+pGT4DyJAm4nq1qzvU
	YPXxSOLi6bDJIb75NFS3QBdz7qsJ/4ghANlb+/daht7GxJIbeEL8eFZKQrqeJeXqlGRd1r
	acaUGZhe1/4tJf2C16Y3y06gDaX1e6g14hbOhuwFAOxW4BsuzFBRK6GeLMsulNNu15tItF
	f6DnNB9CfFndwYLdF8aeREWLYE9slv6onfb91NryaQQJpTZi2/SnDrgLwzEEBg==
Date: Mon, 16 Sep 2024 14:30:45 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
	claudiu.beznea@tuxon.dev, codrin.ciubotariu@microchip.com,
	lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	nicolas.ferre@microchip.com, perex@perex.cz, tiwai@suse.com
Subject: Re: [PATCH 2/2] ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due
 to single channel limitation
Message-ID: <2024091612304529f5ebe1@mail.local>
References: <20240916100006f2db7b06@mail.local>
 <20240916113203.17871-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916113203.17871-1-andrei.simion@microchip.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 16/09/2024 14:32:05+0300, Andrei Simion wrote:
> On 16.09.2024 12:59, Alexandre Belloni wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 16/09/2024 11:52:15+0300, Andrei Simion wrote:
> >> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> >>
> >> Drop S24_LE format because it is not supported if more than 2 channels
> >> (of TDM slots) are used. This limitation makes it impractical for use cases
> >> requiring more than 2 TDM slots, leading to potential issues in
> >> multi-channel configurations.
> >>
> >> [andrei.simion@microchip.com: Reword the commit title and the commit
> >> message.]
> >>
> >> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> >> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
> >> ---
> >>  sound/soc/atmel/atmel_ssc_dai.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> >> index 7047f17fe7a8..475e7579c64c 100644
> >> --- a/sound/soc/atmel/atmel_ssc_dai.c
> >> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> >> @@ -822,7 +822,7 @@ static int atmel_ssc_resume(struct snd_soc_component *component)
> >>  }
> >>
> >>  #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
> >> -                       SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
> >> +                        SNDRV_PCM_FMTBIT_S32_LE)
> >
> > I believe this requires a comment. Else someone may add it back later
> > on.
> >
> 
> It is unclear to me. Would it be good to send v2 with this update?
> 

Yes, please send a new version. My point is that it is explained in the
commit log. This is fine when you are adding something because then
people will easily use git blame and find the commit and log. However,
because you are removing code, it is not obvious there is a reason why
it isn't there;

> >>
> >>  static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
> >>       .startup        = atmel_ssc_startup,
> >> --
> >> 2.34.1
> >>
> >
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 
> Best regards,
> Andrei Simion

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

