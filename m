Return-Path: <linux-kernel+bounces-195977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA388D5596
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426881C227CE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E261802B1;
	Thu, 30 May 2024 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5XTY/qk"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD021A0D
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108903; cv=none; b=NTgfLfDjjjY2YLy1B4p+xSeBrhj3nFFkY2k9PyO9LaY//4NVeC8A30gwS+FYi2aoMb0IbMew1hIGHYhviQhZZHmEwCODAthpjFxhN5NzlMwfPDTHHVoCtNgJZWjcNHzWkF8y+1BmGOreLApA8YHTN1lH0Z6kxtM6ESx69Y60/gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108903; c=relaxed/simple;
	bh=WiAN7mCP4BbmrvdS0pfRUWdmu5TIdZ3o1Bx36Asu42Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REH+kjfpi+ss0OhsjLA+daOXzVVsQrr+hYkFddZW04AstFIu9xb546MjojfD3s5n4zUzIg29nvICQ4cW5I/NI+1d9qL13RX62Yc44vsFUGWwY7ltviltIAhgZeJkdqglNx6fKkufyVgZKpRmObCZOGxLfxugUI14UshMFpwFFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5XTY/qk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e719bab882so15167901fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717108900; x=1717713700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hL5ealaynSKA2/99rePZ0VezSpsbAVXh2kWFZiS3nMs=;
        b=a5XTY/qkxsdzJDSr4Uaw9SHRb2Nh3qM+1TJO4qceSXG6iReCHhzttvrh7FRQPbPvj/
         Wd53jzOFBRiq9aANftjNQ+D/t5TSkN6lnXevcJpAQjgn2YdoA05Am++w9+nS+AZXsHro
         XV4JKXTRdWC+yLv/qptvEIXnZXuN+reJ9MSgbj0GDdmHsrBYAfWqXPd6KeeO7nbGxaFx
         vFvORTDHcguw8yc8lXYPPYXd5qk4GYflo5cevy8/n6BVbdisLuieCbtjRoTWrXJgDn4T
         +oR7idn6cc9aom2U1T5FQ3Z4qKO3DXWwElu3oTUkWh5N3D6pDcMIkvAyrJZB0+rdvk85
         jJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717108900; x=1717713700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL5ealaynSKA2/99rePZ0VezSpsbAVXh2kWFZiS3nMs=;
        b=RtAhvs2dHuElFtvJi4AgVQ1BydPvYW2ivSmXyBPJPaDDdiLk56jwqkxEbYsGyYvoeN
         w5nB/6f4X+33sAMU/4WeTm4bnaiICF1vtlwaKw+VXrgl2543sJ009xARLkwUaGuBqa7l
         gOyH+hKge5xlN0pQxd2yyR9Ptv+KZ13bQ/c7aL400RIH01FM+HGDmlXPFRu5HaADuo8M
         0mZddZRozG0mya8dd3vr6U2JDVQpnNO3Qz+/J+WJLKZ2pivxzrdBNfQoJAi7PNt90kRl
         o6vCTR3q8mN7QANIXSLrbZ4M3HmVSzMyVvTDV+cF71OPUehVHxUzOtN6Ek8JydV4/ufG
         ATWA==
X-Forwarded-Encrypted: i=1; AJvYcCWGT1qC4l2zffcReHnc/KO3WKZA/o+UZWyKnNkLHj2Qbv4Auyu35pnGTUjnBezfgO28Nim8Bmb6RmqYXEwk3X0B48mTHIHfD7YapaQh
X-Gm-Message-State: AOJu0YzkJ6CT0Awu8L0RWV1cNksE1lz27mqyvg30AVtip8n7T5jB4BfO
	awU7JO2lF62oIGxmA7AkRoD/TODuoz6i8vDAFpd7VGv2qNhpuZdVj7WMNg5pmlE=
X-Google-Smtp-Source: AGHT+IFAau1nLv8qEemckp5VXI+lrBnMSwFK5i3H8fBmTARbV2eR4XpDxjdCszW6UdLAhDfhZSC6/w==
X-Received: by 2002:a05:651c:1a12:b0:2e5:67bc:739 with SMTP id 38308e7fff4ca-2ea950b55b0mr1791951fa.2.1717108900247;
        Thu, 30 May 2024 15:41:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cc6401sm1041591fa.96.2024.05.30.15.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 15:41:39 -0700 (PDT)
Date: Fri, 31 May 2024 01:41:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: qcom: sc8280xp: add Display port Jack
Message-ID: <ZlkAotVPuGH_H9jg@eriador.lumag.spb.ru>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <20240422134354.89291-4-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422134354.89291-4-srinivas.kandagatla@linaro.org>

On Mon, Apr 22, 2024 at 02:43:53PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add support to Display Port Jack events, by making use of common helper
> function.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/sc8280xp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 878bd50ad4a7..38f97f19add9 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -19,6 +19,7 @@ struct sc8280xp_snd_data {
>  	struct snd_soc_card *card;
>  	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
>  	struct snd_soc_jack jack;
> +	struct snd_soc_jack hdmi_jack[8];
>  	bool jack_setup;
>  };
>  
> @@ -27,6 +28,8 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>  	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
>  	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>  	struct snd_soc_card *card = rtd->card;
> +	struct snd_soc_jack *hdmi_jack  = NULL;
> +	int hdmi_pcm_id = 0;

Using hdmi_ prefix for DP jacks is counterintuitive at best.

>  
>  	switch (cpu_dai->id) {
>  	case WSA_CODEC_DMA_RX_0:
> @@ -41,10 +44,21 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>  		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 17);
>  		snd_soc_limit_volume(card, "SpkrRight PA Volume", 17);
>  		break;

I'd suggest either using DISPLAY_PORT_RX here or adding a comment to
point out that DP RX ids are not sequential.

> +	case DISPLAY_PORT_RX_0:
> +		hdmi_pcm_id = 0;
> +		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
> +		break;
> +	case DISPLAY_PORT_RX_1 ... DISPLAY_PORT_RX_7:
> +		hdmi_pcm_id = cpu_dai->id - DISPLAY_PORT_RX_1 + 1;
> +		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
> +		break;
>  	default:
>  		break;
>  	}
>  
> +	if (hdmi_jack)
> +		return qcom_snd_dp_jack_setup(rtd, hdmi_jack, hdmi_pcm_id);
> +
>  	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
>  }
>  
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

