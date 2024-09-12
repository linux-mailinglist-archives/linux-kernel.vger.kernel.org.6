Return-Path: <linux-kernel+bounces-326102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C39976294
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B5028295E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B7218C906;
	Thu, 12 Sep 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XEAFqXHh"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397F18BC0F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125797; cv=none; b=NyRWofiq6Y2u0yzchIUXZq861fxHpdnqmNH5gcgdtKy2LW63RuJ3K+65K1pAk8OLMWamFInv3+OvwgN/rWURqHQ+XklPRDjvLsf2Ba2E/OfwB5hHQOkrA41xaPpV/eI2Q0d1j0BkJvx9suvtSSEiUl6o3LHE4j7xzyVbTb6Bc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125797; c=relaxed/simple;
	bh=pxFrIVn6pEQLb15VlFTabxWCTw1Qt4vVS/QG6Wt+CK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZK31aMyVd0F0czCmV0it45Em/1cK3G6+6gx+fOvLIwXEXUJ1juizVu6dzkYWqghxdixBNHHxfvjI7jZnYVohqrrPLNCI17ahyKhcneHXraW6roTdteUw1DsJWgDOmAHnPDTEOEIR9YHqkGQvhDqKLxxzWR601f006dAF1mRBYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XEAFqXHh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so4667885e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1726125793; x=1726730593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Se+s5UNgvZ5UX0EkE1alXu3A7oUHaSh+LEe2hUZbns0=;
        b=XEAFqXHhmpSFY13bzg01prBvz0Pyp9TkwSAv1CEAdqEWpnp21z1ol7aJFAd8HNkJ7V
         4SxP4jZng1rbqfGNsLKG+iD2AwimLFM0254VMRQ8PNXEBFsw0v5jbc86rS//XpG1gldL
         +Cke8pNYpVhJGqKNFOAJJJZkU7ylewiMGZ6r8+aQlkoQtuxTri24T0VKuYSEi8RmtefL
         aHGB1nW075nl8K6Z8g3nHPHnbq/PY8rjaJcQS2kPMAeEOYG5u485xUUMZ3pQFC/QTaRT
         YL0dLiTCyVfXGhrYHEI6IjrHy/OEuS3884t9YSfrxa8tc0ulWlbLPFL0krgeNp8yzNNM
         N3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726125793; x=1726730593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se+s5UNgvZ5UX0EkE1alXu3A7oUHaSh+LEe2hUZbns0=;
        b=Xn9OV8EmmpzmvtlN/fvn2MJWzr0+WNNw2wxmAwjWN7U40VVj89TzHbElOXdry46NEw
         wL+2Xc+yimWOtEXrpZQVoYP4sazcnE5CljBza6IUpzOUb3lRAp6TJcCQQtCv5csqV4KF
         DdlV4OEcMU0EolFYW55e1I7aZCE46v1DYarl7dPq8ySP/Z+sAewCWPeRlUbb3cM7ALSg
         xxwN70d+NnMJ4gfsCqFmplpF3yG+hJ5AkeErVEaT+ZYClSGaN5G69dWasI4Z1+sV5ftx
         ZW1/CgAMOwrf2Xs+285FFZekYg5aQ9g+ae8umfUJGRutFr9HCrFaeGn6bWq1FsBrIubM
         Wtcw==
X-Forwarded-Encrypted: i=1; AJvYcCWYrmTbsoH2vnvJks6qTq+Za5CuyF31j5I+9eKV8DkkycamnrkTIUkR4peIEtKDaoi/9mXKO8Aq1WZiJfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1T1ya+M3bHXMC5da3hyPDisYHoLWiBJTZ/ZMliKo1nd2xNXf
	8mA6owWLf4coWc+Bv/lK2NSThF2dfY5l8aKcp4f5FERYTjWU2JZtB1Hm5UlmKwA=
X-Google-Smtp-Source: AGHT+IGKdPI8P07xXRLl8xvGf5pgqCsGWmiLe8zHaAA0yZvG0if7fXsZBJ4s6WuRDHxgRoX4h1wjew==
X-Received: by 2002:a05:600c:314e:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-42cdb50a8aemr11563415e9.6.1726125792589;
        Thu, 12 Sep 2024 00:23:12 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956761c6sm13557444f8f.61.2024.09.12.00.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 00:23:12 -0700 (PDT)
Message-ID: <ae7a3386-5e11-4d9b-84a5-8e6a79c91c52@tuxon.dev>
Date: Thu, 12 Sep 2024 10:23:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ASoC: atmel: mchp-pdmc: Retain Non-Runtime Controls
Content-Language: en-US
To: Andrei Simion <andrei.simion@microchip.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
References: <20240911122909.133399-1-andrei.simion@microchip.com>
 <20240911122909.133399-4-andrei.simion@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240911122909.133399-4-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Andrei,

On 11.09.2024 15:29, Andrei Simion wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> Avoid removing these controls, as doing so can cause issues if the stream
> is initiated from another control. Ensure these controls remain intact when
> the stream is started or finished. Instead of removing them, return an
> -EBUSY error code to indicate that the controller is busy, especially when
> the audio filter and the SINC filter are in use.
> 
> [andrei.simion@microchip.com: Reword the commit title and the commit
> message. Adapt the code from kernel v6.1 -> v6.6 -> latest kernel version.]
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
> ---
>  sound/soc/atmel/mchp-pdmc.c | 78 ++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 44 deletions(-)
> 
> diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
> index d97d153ee375..758b3c550b97 100644
> --- a/sound/soc/atmel/mchp-pdmc.c
> +++ b/sound/soc/atmel/mchp-pdmc.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/spinlock.h>
>  
>  #include <sound/core.h>
>  #include <sound/dmaengine_pcm.h>
> @@ -113,6 +114,7 @@ struct mchp_pdmc_chmap {
>  
>  struct mchp_pdmc {
>  	struct mic_map channel_mic_map[MCHP_PDMC_MAX_CHANNELS];
> +	spinlock_t busy_lock;		/* lock protecting busy */
>  	struct device *dev;
>  	struct snd_dmaengine_dai_dma_data addr;
>  	struct regmap *regmap;
> @@ -124,6 +126,7 @@ struct mchp_pdmc {
>  	int mic_no;
>  	int sinc_order;
>  	bool audio_filter_en;
> +	u8 busy:1;

Can the spinlock and busy flag be replaced by an atomic variable?

>  };
>  
>  static const char *const mchp_pdmc_sinc_filter_order_text[] = {
> @@ -167,10 +170,19 @@ static int mchp_pdmc_sinc_order_put(struct snd_kcontrol *kcontrol,
>  		return -EINVAL;
>  
>  	val = snd_soc_enum_item_to_val(e, item[0]) << e->shift_l;
> -	if (val == dd->sinc_order)
> +
> +	spin_lock(&dd->busy_lock);
> +	if (dd->busy) {
> +		spin_unlock((&dd->busy_lock));

You can remove () around (&dd->busy_lock). Valid for the rest of occurrences.

> +		return -EBUSY;
> +	}
> +	if (val == dd->sinc_order) {
> +		spin_unlock((&dd->busy_lock));
>  		return 0;
> +	}
>  
>  	dd->sinc_order = val;
> +	spin_unlock((&dd->busy_lock));
>  
>  	return 1;
>  }
> @@ -193,10 +205,18 @@ static int mchp_pdmc_af_put(struct snd_kcontrol *kcontrol,
>  	struct mchp_pdmc *dd = snd_soc_component_get_drvdata(component);
>  	bool af = uvalue->value.integer.value[0] ? true : false;
>  
> -	if (dd->audio_filter_en == af)
> +	spin_lock(&dd->busy_lock);
> +	if (dd->busy) {
> +		spin_unlock((&dd->busy_lock));
> +		return -EBUSY;
> +	}
> +	if (dd->audio_filter_en == af) {
> +		spin_unlock((&dd->busy_lock));
>  		return 0;
> +	}
>  
>  	dd->audio_filter_en = af;
> +	spin_unlock((&dd->busy_lock));
>  
>  	return 1;
>  }
> @@ -379,52 +399,10 @@ static const struct snd_kcontrol_new mchp_pdmc_snd_controls[] = {
>  	},
>  };
>  
> -static int mchp_pdmc_close(struct snd_soc_component *component,
> -			   struct snd_pcm_substream *substream)
> -{
> -	return snd_soc_add_component_controls(component, mchp_pdmc_snd_controls,
> -					      ARRAY_SIZE(mchp_pdmc_snd_controls));
> -}
> -
> -static int mchp_pdmc_open(struct snd_soc_component *component,
> -			  struct snd_pcm_substream *substream)
> -{
> -	int i;
> -
> -	/* remove controls that can't be changed at runtime */
> -	for (i = 0; i < ARRAY_SIZE(mchp_pdmc_snd_controls); i++) {
> -		const struct snd_kcontrol_new *control = &mchp_pdmc_snd_controls[i];
> -		struct snd_ctl_elem_id id;
> -		int err;
> -
> -		if (component->name_prefix)
> -			snprintf(id.name, sizeof(id.name), "%s %s", component->name_prefix,
> -				 control->name);
> -		else
> -			strscpy(id.name, control->name, sizeof(id.name));
> -
> -		id.numid = 0;
> -		id.iface = control->iface;
> -		id.device = control->device;
> -		id.subdevice = control->subdevice;
> -		id.index = control->index;
> -		err = snd_ctl_remove_id(component->card->snd_card, &id);
> -		if (err < 0)
> -			dev_err(component->dev, "%d: Failed to remove %s\n", err,
> -				control->name);
> -	}
> -
> -	return 0;
> -}
> -
>  static const struct snd_soc_component_driver mchp_pdmc_dai_component = {
>  	.name = "mchp-pdmc",
>  	.controls = mchp_pdmc_snd_controls,
>  	.num_controls = ARRAY_SIZE(mchp_pdmc_snd_controls),
> -	.open = &mchp_pdmc_open,
> -	.close = &mchp_pdmc_close,
> -	.legacy_dai_naming = 1,
> -	.trigger_start = SND_SOC_TRIGGER_ORDER_LDC,
>  };
>  
>  static const unsigned int mchp_pdmc_1mic[] = {1};
> @@ -587,6 +565,13 @@ static int mchp_pdmc_hw_params(struct snd_pcm_substream *substream,
>  			cfgr_val |= MCHP_PDMC_CFGR_BSSEL(i);
>  	}
>  
> +	/*
> +	 * from these point forward, we consider the controller busy, so the
> +	 * audio filter and SINC order can't be changed
> +	 */
> +	spin_lock(&dd->busy_lock);
> +	dd->busy = 1;
> +	spin_unlock((&dd->busy_lock));
>  	for (osr_start = dd->audio_filter_en ? 64 : 8;
>  	     osr_start <= 256 && best_diff_rate; osr_start *= 2) {
>  		long round_rate;
> @@ -1099,6 +1084,7 @@ static int mchp_pdmc_probe(struct platform_device *pdev)
>  	 */
>  	dd->audio_filter_en = true;
>  	dd->sinc_order = 3;
> +	spin_lock_init(&dd->busy_lock);
>  
>  	dd->addr.addr = (dma_addr_t)res->start + MCHP_PDMC_RHR;
>  	platform_set_drvdata(pdev, dd);
> @@ -1143,6 +1129,10 @@ static void mchp_pdmc_remove(struct platform_device *pdev)
>  {
>  	struct mchp_pdmc *dd = platform_get_drvdata(pdev);
>  
> +	spin_lock(&dd->busy_lock);
> +	dd->busy = 0;
> +	spin_unlock((&dd->busy_lock));
> +
>  	if (!pm_runtime_status_suspended(dd->dev))
>  		mchp_pdmc_runtime_suspend(dd->dev);
>  

