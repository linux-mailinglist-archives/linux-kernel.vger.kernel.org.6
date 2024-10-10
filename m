Return-Path: <linux-kernel+bounces-358825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD3499844B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B685284D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D51898ED;
	Thu, 10 Oct 2024 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="intOHK0N"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D277A1BD50A;
	Thu, 10 Oct 2024 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558020; cv=none; b=TctDAZFRe0m+zLmWRFrVFlgG3cXxTLnk2zDjU/aSXRJmx4JAllcAyw+wyHFxxD0pTphxHAD+75ztK9OKp3/PAZ3PrHT3zI/NFOSNgMn5AnP4Fhnp1KDAIIJojKUa2xw+oz6pwZtdbU6uXS6mAiWP07xH6GjVPzi6ChZFRfAvh2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558020; c=relaxed/simple;
	bh=8i2d581H7RAIv0CvvcVmjq+Yi+GzmbcnlzsXCTnZ+5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0qM/eiHG37H2uedUiexhXWErtPO1eut20nj7h9NmSwORzogYYLWbgFefTVf9aXBePdJh0dDEirL/K3NkEeuhhJtLAJwz4A4EjKAHfcQ5/D0AhIVnuk+PfoHwSXQ5OLPiLFF4hZU1NVvMrUwSzwccp2OhU96Cte3vkFmvK9b3xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=intOHK0N; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99388e3009so114202566b.3;
        Thu, 10 Oct 2024 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728558017; x=1729162817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wm6MZYXLSHo1dcmzMTR+ZzKs3r2Jrq8C9K6nZwy4g50=;
        b=intOHK0NDc4IIHfcn5Y8kt/adCusUM14jWlsIy02nWRz2IYOAgL/mn4daKX+ZZGHnv
         KHeS3eyxhOms877PxCQV5kbD97GDPTRv9QzFGDm6hYLOLEz0WB5rQ91I12yBtcnoFAHT
         tpWhZV7PM/XWaxyIWlRpQvO20uC13SSM4+AHwCknM3vVAQrfiPBWNsu/cNXeAKlVyJ5h
         l0iszNRCJzuNqo3WHeoud/tCEr/guTnMmfxWCm5PPeqF5Lu5DadHPg9BOdhAFTM72TLK
         KWp4gJ1i/KUjZuPHtXF+yN63l0xVnwgTqDhKPKxmIpw/lP0fG74mgYPl0l6+/WF9cc6N
         tHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728558017; x=1729162817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wm6MZYXLSHo1dcmzMTR+ZzKs3r2Jrq8C9K6nZwy4g50=;
        b=lyTFNNPn/8fMiKLrJM59j9dCPdpiaJxzlEIyymg6cpISYIA9mF+UDsnx4kHd9J7XHF
         M8HifZeMbnzO0G7EwU3Mf5YubnOsVt0gfcr/06nOoicO0WT6PFs442Nx+nzxPJ7Ed0+8
         7skxpPB6fe+JEqBLHUtDzVm8fsHG9T5xOzGyOT+uPCEODM942GUPXpe+MbQD2OSpHMo0
         EnljeBA1LRQ/QpEVhoGRyyIQp3PC1hcgOL12jUw+sOyf0N8SJX+bKmqz1zIuHFCrLMn1
         EIc8/k9BGvXzN+I5Z5MNdeLfyPgpqCOrqTjMv/0Q9yfbvV0LTiHVEmOeOBYo7zznB8sF
         RxwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOZF+J48fT+UpVQFlKxzoFGMVhyqVyRBpfes3gOhd9ym3+E89XvjTBqtZySifB68Gb85Dc2za3BYUfSmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eetTcPlRl1vU5MA04nuuaR98Q/dkijqiG7hymsf9EwR3ubT1
	b8F77KSd9G8YiRKlIYVuqAAV9cknv+GHrEMzZ9yF6coHlYRPCWkWnuZwIXGW
X-Google-Smtp-Source: AGHT+IF4Du3Ih2aP9a4aeYx5V5KpMHpUyahtsSe3e+80RgRQFzvJY7pAi69j/1zbBr1MglyJEAAoNQ==
X-Received: by 2002:a17:907:1c1a:b0:a86:a4b1:d2b8 with SMTP id a640c23a62f3a-a998d11892dmr528404366b.4.1728558016851;
        Thu, 10 Oct 2024 04:00:16 -0700 (PDT)
Received: from [192.168.42.132] ([81.95.8.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80bfc5esm73268166b.142.2024.10.10.04.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 04:00:15 -0700 (PDT)
Message-ID: <fccf8cbd-82ec-4d97-a5aa-faf57ac78874@gmail.com>
Date: Thu, 10 Oct 2024 13:00:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8188: Remove unnecessary variable
 assignments
To: Tang Bin <tangbin@cmss.chinamobile.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 angelogioacchino.delregno@collabora.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241010073547.3720-1-tangbin@cmss.chinamobile.com>
Content-Language: en-US
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20241010073547.3720-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 09:35, Tang Bin wrote:
> In the function mtk_dai_hdmitx_dptx_hw_params, the variable
> 'ret' is redundant, thus remove it.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   sound/soc/mediatek/mt8188/mt8188-dai-etdm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
> index 2a48f5fd6..69a091dad 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
> @@ -2422,7 +2422,6 @@ static int mtk_dai_hdmitx_dptx_hw_params(struct snd_pcm_substream *substream,
>   	unsigned int channels = params_channels(params);
>   	snd_pcm_format_t format = params_format(params);
>   	int width = snd_pcm_format_physical_width(format);
> -	int ret;
>   
>   	if (!is_valid_etdm_dai(dai->id))
>   		return -EINVAL;
> @@ -2450,9 +2449,7 @@ static int mtk_dai_hdmitx_dptx_hw_params(struct snd_pcm_substream *substream,
>   		etdm_data->data_mode = MTK_DAI_ETDM_DATA_MULTI_PIN;
>   	}
>   
> -	ret = mtk_dai_etdm_configure(afe, rate, channels, width, dai->id);
> -
> -	return ret;
> +	return mtk_dai_etdm_configure(afe, rate, channels, width, dai->id);
>   }
>   
>   static int mtk_dai_hdmitx_dptx_set_sysclk(struct snd_soc_dai *dai,


