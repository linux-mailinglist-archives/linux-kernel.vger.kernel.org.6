Return-Path: <linux-kernel+bounces-208389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E8490247E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0D5B29402
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB0136671;
	Mon, 10 Jun 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4peIbzu"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF0E12F5BE;
	Mon, 10 Jun 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030643; cv=none; b=ljLSn6eZpEXE7rfOf81yIp7JkRR7MGg6gmViO6sx66SQTuXpgl40ju+3z51b9fUO/SB6mZ7eMH/VoUcWb7a1XID5oiqForUrZT07UuB9FDPDrI6j3xaT3PV+uB6jJRMw1CRU08Gvfg/Lai62wnxtp+7E3fEqrj86RlXAjRHYd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030643; c=relaxed/simple;
	bh=l/Grbzei5fBRjJCWKEoGR/gpM9K22wBlsaDZreuU82w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PM1kA3zCc8VoJ6y09ARq6m6QugWpNke6tTJdImsvDZxvNKuDxJhY9ouDiY1MdHz2SpI4veQJRDbp0uUiC4FzuGHUjlycbUyn57CCC8flP+aGdotpQ6CBOsrGasu+HKWIDrLuIE5Y+Ep3A3PHvofTOD19zK7TT9EGDJ++1V6c8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4peIbzu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebd421a931so23096861fa.1;
        Mon, 10 Jun 2024 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718030640; x=1718635440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+X8rAX9jRAKaOSNNc0p/ItKQWY3t87U4LU5WMC+wGlk=;
        b=W4peIbzuwo6EIiAvjds+RRCII15TYDBiV36aD8yoga0M1ZwnBBxXzeTbn7E5eV8Zy8
         5i86TuxrpFbTLB+5qsfCXDR52J+r9Ybk2e8SPtcUMpDBwXGqqLdf0CICVXonzN7zkX1p
         TglQSnd+mggjpJVfzs+nsO2oETRIy/spJYsn2XW8eb2wKu39EQc12Qel34ml4qON3H4f
         F6ZppYTx+2HEfBCeT+kK0BUzk2+sWHMzz1F34d8E3qPlk/hRGb4Lx3Vv5sHCT1w3eE7M
         gPmDu494XEU7aN0tvoxq46WpjbkNCgE2O4kkZamYyhQcXL1gAQkcPPucvvfh25L96lrl
         ccmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718030640; x=1718635440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+X8rAX9jRAKaOSNNc0p/ItKQWY3t87U4LU5WMC+wGlk=;
        b=oBYqhQFjTp1DzdWqo+6taMQteLmq8HR1J0C0ntydL/iWMMaqvDeNDRqBrG6KIXPV+Z
         XZX0pu+bXuo7ixMKSrsjg35WISQMchzQ/xgYlnjUKXvVklE+JC86zSCXL2nSBoS4Bvl6
         rerpbSPA1rjPDBlpVZycd+fJyrieZTvMcl0HJJfJUWSPI80YATTo9wl62IvVeO1qTU3Y
         ctZ+CtK9YhKvMM6wxqbEdkTDKCz6qi0ZGu2PZ/BqgdWGV/81MH/e9AxaY0WNHNLkFKjZ
         eqeBJroZyjSnlojkB6tKnlSGzq3pPUK5k26/+wNtM7OcTnZkOwRNHZ1iA+92wl7fMVZb
         jURA==
X-Forwarded-Encrypted: i=1; AJvYcCXGdiFty3e1ReP2aiMGPghFemB5fjS4N+fO6fry2gJNt5/8OUg1pFXucEpQGe0/8zJq18ZEN7nPpv5fUhYZC2qsLL7zF6OswBHe5iX6
X-Gm-Message-State: AOJu0YyD2tXfdd45JwkATBh8RQFNm4r5bRUm81l7XOGBCSXkOi6h6frm
	YCVvXDMa+AQQDGMuvQGM1qtGoept66Xbfmo5qC3FqdCg3ee5XKlL
X-Google-Smtp-Source: AGHT+IEqPiXMp7uVz35JdOOGzlUzWqUmfOqh8p/wjktqliXLyYoDdm4rNv+eqVWsaDjHEEKy7jCsbg==
X-Received: by 2002:a2e:6e16:0:b0:2eb:da38:971f with SMTP id 38308e7fff4ca-2ebda38989cmr30649031fa.44.1718030638594;
        Mon, 10 Jun 2024 07:43:58 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eaec3ba8d7sm13372621fa.1.2024.06.10.07.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 07:43:58 -0700 (PDT)
Message-ID: <ce260655-df6e-442f-8d2f-2eff7b4d6a5a@gmail.com>
Date: Mon, 10 Jun 2024 17:47:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: ti: davinci-mcasp: Set min period size using
 FIFO config
To: Jai Luthra <j-luthra@ti.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, Devarsh Thakkar <devarsht@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
References: <20240610-asoc_next-v2-0-b52aaf5d67c4@ti.com>
 <20240610-asoc_next-v2-2-b52aaf5d67c4@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240610-asoc_next-v2-2-b52aaf5d67c4@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/10/24 1:56 PM, Jai Luthra wrote:
> The minimum period size was enforced to 64 as older devices integrating
> McASP with EDMA used an internal FIFO of 64 samples.
> 
> With UDMA based platforms this internal McASP FIFO is optional, as the
> DMA engine internally does some buffering which is already accounted for
> when registering the platform. So we should read the actual FIFO
> configuration (txnumevt/rxnumevt) instead of hardcoding frames.min to
> 64.

Thank you the patch and the fix,
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index 1e760c315521..2b1ed91a736c 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -1472,10 +1472,11 @@ static int davinci_mcasp_hw_rule_min_periodsize(
>  {
>  	struct snd_interval *period_size = hw_param_interval(params,
>  						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
> +	u8 numevt = *((u8 *)rule->private);
>  	struct snd_interval frames;
>  
>  	snd_interval_any(&frames);
> -	frames.min = 64;
> +	frames.min = numevt;
>  	frames.integer = 1;
>  
>  	return snd_interval_refine(period_size, &frames);
> @@ -1490,6 +1491,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
>  	u32 max_channels = 0;
>  	int i, dir, ret;
>  	int tdm_slots = mcasp->tdm_slots;
> +	u8 *numevt;
>  
>  	/* Do not allow more then one stream per direction */
>  	if (mcasp->substreams[substream->stream])
> @@ -1589,9 +1591,12 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
>  			return ret;
>  	}
>  
> +	numevt = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
> +			 &mcasp->txnumevt :
> +			 &mcasp->rxnumevt;
>  	snd_pcm_hw_rule_add(substream->runtime, 0,
>  			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> -			    davinci_mcasp_hw_rule_min_periodsize, NULL,
> +			    davinci_mcasp_hw_rule_min_periodsize, numevt,
>  			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
>  
>  	return 0;
> 

-- 
Péter

