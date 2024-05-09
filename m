Return-Path: <linux-kernel+bounces-174339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52BE8C0D5D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBB6281CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699B9126F09;
	Thu,  9 May 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrn6OczZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686B14A600
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246246; cv=none; b=l6k+CyfKezCVB4so60sUeHEp3QRPiplNHNTGG+ZFGLrfbGhpt8u6E4SVMlloSKCBbRKK4Y25EYxKt0LYyIN/DqbesNTcYiA2YPsu7RPspdbF8IM0a79GM6ab9RHVVtgKRxcEM6tOn4sCrnM+q7uEyHPO10Pv20t0HqKEJXg9GEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246246; c=relaxed/simple;
	bh=MTiRf6y9CwK5s4EGi1w9HicVt5K4p9IXFySP3nBcgY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNnoN3O8gTPCh4VI0LfxlYFAHlu+IYkSVhTWP9KhbT6s4k98s5noZl2W3RiJLRESKmmvnkOsnV0fuwGLZ4MIveKuRKMUsqrr6S9RRt1SWIKqEaE6MFVxVPewVqVy9XXIWB1ncRpA3AJDRiNybR+NHPNQHMh4IZ1r+sAKRPWMWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrn6OczZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b79451128so5179835e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 02:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715246243; x=1715851043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bO70t2wwFBE6k9WTC5h87uZcklzatJMH5IRVgedzqQ=;
        b=rrn6OczZQHlDuww1pPk0Qk5rZ8RBIpjzG8Geumj50a10SrGhOpSmnt1b5qVNgzxpNz
         l1yapl6vNiOrBxspbUeOfTql8mGh+PP4MEYpC2fcmaQzT4Yrb89xAFppmSvhQR9xk2fW
         Az9/dWysSDaIOy+KlQAyFYi2YyI4cyMvxm1o1CkU1nh5LWVz9Q/dMw/hxsTdiFtqibhi
         NyoMEElfPSWSkbe7LSZ8iem1WtkcDgJ7EhoaerBqqwK3KlHdl2cirxtziq90p0+xjNTu
         RrLgP6ebEccnY4Imq+3jgR5xZt5znTMWi/mSQ6H8l8nQcFD3f0kaWyGjieHy4jjXdUlj
         pW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715246243; x=1715851043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bO70t2wwFBE6k9WTC5h87uZcklzatJMH5IRVgedzqQ=;
        b=ZnmPlPwaaijc9J1BQqsIINr1ry3X0Z7eHMrjhax+lzKLfmp/LPcV+Y7iO5FHB3ANhb
         a3h6lXluasRTyMyNuOrRVON0XOoGLXC+OPSxWmsfDAlmKsQvgtMxiPpGudB5SuwXjJAa
         haefo6kGY6+JdpJrK/IqbO7ej9MMhfeD+F2zYB1FySpu7Mr8wLnuemqLiW8E/XLhiHfN
         ujHLxU/6PA7aTnagqfRgKpZr1c0HLnOzIWHhkwXk5iqsYDcYbpPYjMIotwJpP1vjKoY3
         2jbzFqJpkN3Kj5o4U2Ar2sjuFrnX+IVYk4PzIuRkdrIXGzy5K6ATbslOTs6rqsPz15fM
         zenQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA1wXgDYBhwkeYXPrP5tc7xCWwtOfvuy6o/saJRayHRGUwjvv8RqviyamsKCNsPQaup26+n/iQoxYPPadf70g7vVaN1T+5yEMvAh1B
X-Gm-Message-State: AOJu0YyjsqWXkN8ESiyYihG+gqrqjRnsFYRvL7ypPZHCo3trSjK22RjS
	glslp9Z6fl8nZLqsFSy1ipX4jzHfbIor6iW9GLyqn6xAD3J5TQVuJHDwxQS2W/E=
X-Google-Smtp-Source: AGHT+IGCauFH2yLFsnMMUE8CDtmkKT6iBzwdkH3n4+XpqeBKPgbCvrAfI3+5i8uo1Z4Oxn8hR675dg==
X-Received: by 2002:a05:600c:1c12:b0:41b:f359:2b53 with SMTP id 5b1f17b1804b1-41f723a2496mr43405305e9.37.1715246242638;
        Thu, 09 May 2024 02:17:22 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87c24f8fsm53550235e9.15.2024.05.09.02.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 02:17:22 -0700 (PDT)
Message-ID: <d3c78e43-44a9-4ef2-8e64-00f39b32172c@linaro.org>
Date: Thu, 9 May 2024 10:17:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ASoC: qcom: qdsp6: Set channel mapping instead of
 fixed defaults
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Banajit Goswami <bgoswami@quicinc.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240509-asoc-x1e80100-4-channel-mapping-v3-0-6f874552d7b2@linaro.org>
 <20240509-asoc-x1e80100-4-channel-mapping-v3-3-6f874552d7b2@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240509-asoc-x1e80100-4-channel-mapping-v3-3-6f874552d7b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Krzysztof for the patch.


On 09/05/2024 07:51, Krzysztof Kozlowski wrote:
> When constructing packets to DSP, the Audioreach code uses 'struct
> audioreach_module_config' to configure parameters like number of
> channels, bitrate, sample rate etc, but uses defaults for the channel
> mapping.
> 
> Rework this code to copy the channel mapping from 'struct
> audioreach_module_config', instead of using the default.  This requires
> all callers to fill that structure: add missing initialization of
> channel mapping.
Adding this new function call is logically fine but its going to 
introducing some sequencing issues.

set_channel_map might be overwritten by this if not done correctly.

One such instance is in this patch..

> 
> Entire patch makes code more logical and easier to follow:
> 1. q6apm-dai and q6apm-lpass-dais code which allocates 'struct
>     audioreach_module_config' initializes it fully, so fills both
>     the number of channels and the channel mapping.
> 2. Audioreach code, which uses 'struct audioreach_module_config' when
>     constructing packets, copies entire contents of passed config, not
>     only pieces of it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Extend commit msg, rationale.
> 2. Rework to new approach, but most of the code stays.
> 3. Export audioreach_set_channel_mapping() (needed by Q6APM DAIS and
>     LPASS DAIS)
> 4. Correct channel mapping also in audioreach_mfc_set_media_format(),
>     because MFC DAI is now part of backend.
> 5. Do not adjust dynamic DAIs (drop audioreach_dai_load()).
> ---
>   sound/soc/qcom/qdsp6/audioreach.c       | 30 +++++++-----------------------
>   sound/soc/qcom/qdsp6/audioreach.h       |  1 +
>   sound/soc/qcom/qdsp6/q6apm-dai.c        |  2 ++
>   sound/soc/qcom/qdsp6/q6apm-lpass-dais.c |  5 ++++-
>   4 files changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index 5291deac0a0b..750b8ba64211 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.c
> +++ b/sound/soc/qcom/qdsp6/audioreach.c
> @@ -267,7 +267,7 @@ void *audioreach_alloc_apm_cmd_pkt(int pkt_size, uint32_t opcode, uint32_t token
>   }
>   EXPORT_SYMBOL_GPL(audioreach_alloc_apm_cmd_pkt);
>   
> -static void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
> +void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
>   {
>   	if (num_channels == 1) {
>   		ch_map[0] =  PCM_CHANNEL_FL;
> @@ -281,6 +281,7 @@ static void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
>   		ch_map[3] =  PCM_CHANNEL_RS;
>   	}
>   }
> +EXPORT_SYMBOL_GPL(audioreach_set_channel_mapping);
>   
>   static void apm_populate_container_config(struct apm_container_obj *cfg,
>   					  struct audioreach_container *cont)
> @@ -819,7 +820,7 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
>   	uint32_t num_channels = cfg->num_channels;
>   	int payload_size;
>   	struct gpr_pkt *pkt;
> -	int rc;
> +	int rc, i;
>   	void *p;
>   
>   	payload_size = APM_MFC_CFG_PSIZE(media_format, num_channels) +
> @@ -842,18 +843,8 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
>   	media_format->sample_rate = cfg->sample_rate;
>   	media_format->bit_width = cfg->bit_width;
>   	media_format->num_channels = cfg->num_channels;
> -
> -	if (num_channels == 1) {
> -		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
> -	} else if (num_channels == 2) {
> -		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
> -		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
> -	} else if (num_channels == 4) {
> -		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
> -		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
> -		media_format->channel_mapping[2] = PCM_CHANNEL_LS;
> -		media_format->channel_mapping[3] = PCM_CHANNEL_RS;
> -	}
> +	for (i = 0; i < num_channels; i++)
> +		media_format->channel_mapping[i] = cfg->channel_map[i];
>   
>   	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
>   
> @@ -883,9 +874,6 @@ static int audioreach_set_compr_media_format(struct media_format *media_fmt_hdr,
>   		mp3_cfg->q_factor = mcfg->bit_width - 1;
>   		mp3_cfg->endianness = PCM_LITTLE_ENDIAN;
>   		mp3_cfg->num_channels = mcfg->num_channels;
> -
> -		audioreach_set_channel_mapping(mp3_cfg->channel_mapping,
> -					       mcfg->num_channels);
>   		break;
>   	case SND_AUDIOCODEC_AAC:
>   		media_fmt_hdr->data_format = DATA_FORMAT_RAW_COMPRESSED;
> @@ -1104,9 +1092,7 @@ static int audioreach_pcm_set_media_format(struct q6apm_graph *graph,
>   	media_cfg->num_channels = mcfg->num_channels;
>   	media_cfg->q_factor = mcfg->bit_width - 1;
>   	media_cfg->bits_per_sample = mcfg->bit_width;
> -
> -	audioreach_set_channel_mapping(media_cfg->channel_mapping,
> -				       num_channels);
> +	memcpy(media_cfg->channel_mapping, mcfg->channel_map, mcfg->num_channels);
>   
>   	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
>   
> @@ -1163,9 +1149,7 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
>   		cfg->q_factor = mcfg->bit_width - 1;
>   		cfg->endianness = PCM_LITTLE_ENDIAN;
>   		cfg->num_channels = mcfg->num_channels;
> -
> -		audioreach_set_channel_mapping(cfg->channel_mapping,
> -					       num_channels);
> +		memcpy(cfg->channel_mapping, mcfg->channel_map, mcfg->num_channels);
>   	} else {
>   		rc = audioreach_set_compr_media_format(header, p, mcfg);
>   		if (rc) {
> diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
> index eb9306280988..208b74e50445 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.h
> +++ b/sound/soc/qcom/qdsp6/audioreach.h
> @@ -766,6 +766,7 @@ struct audioreach_module_config {
>   /* Packet Allocation routines */
>   void *audioreach_alloc_apm_cmd_pkt(int pkt_size, uint32_t opcode, uint32_t
>   				    token);
> +void audioreach_set_channel_mapping(u8 *ch_map, int num_channels);
>   void *audioreach_alloc_cmd_pkt(int payload_size, uint32_t opcode,
>   			       uint32_t token, uint32_t src_port,
>   			       uint32_t dest_port);
> diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
> index 00bbd291be5c..8ab55869e8a2 100644
> --- a/sound/soc/qcom/qdsp6/q6apm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
> @@ -243,6 +243,7 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
>   	cfg.num_channels = runtime->channels;
>   	cfg.bit_width = prtd->bits_per_sample;
>   	cfg.fmt = SND_AUDIOCODEC_PCM;
> +	audioreach_set_channel_mapping(cfg.channel_map, runtime->channels);
>   

Prepare can be called multiple times.. so we have channels overwritten here.

--srini
>   	if (prtd->state) {
>   		/* clear the previous setup if any  */
> @@ -669,6 +670,7 @@ static int q6apm_dai_compr_set_params(struct snd_soc_component *component,
>   		cfg.num_channels = 2;
>   		cfg.bit_width = prtd->bits_per_sample;
>   		cfg.fmt = codec->id;
> +		audioreach_set_channel_mapping(cfg.channel_map, cfg.num_channels);
>   		memcpy(&cfg.codec, codec, sizeof(*codec));
>   
>   		ret = q6apm_graph_media_format_shmem(prtd->graph, &cfg);
> diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
> index a4ad1d0e6abd..8340e4fb78f4 100644
> --- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
> +++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
> @@ -106,6 +106,7 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
>   	cfg->bit_width = params_width(params);
>   	cfg->sample_rate = params_rate(params);
>   	cfg->num_channels = channels;
> +	audioreach_set_channel_mapping(cfg->channel_map, channels);
>   
>   	switch (dai->id) {
>   	case DISPLAY_PORT_RX_0:
> @@ -130,10 +131,12 @@ static int q6dma_hw_params(struct snd_pcm_substream *substream,
>   {
>   	struct q6apm_lpass_dai_data *dai_data = dev_get_drvdata(dai->dev);
>   	struct audioreach_module_config *cfg = &dai_data->module_config[dai->id];
> +	int channels = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max;
>   
>   	cfg->bit_width = params_width(params);
>   	cfg->sample_rate = params_rate(params);
> -	cfg->num_channels = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max;
> +	cfg->num_channels = channels;
> +	audioreach_set_channel_mapping(cfg->channel_map, channels);
>   
>   	return 0;
>   }
> 

