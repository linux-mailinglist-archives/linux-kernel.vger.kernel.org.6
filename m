Return-Path: <linux-kernel+bounces-321394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A729719F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED2EB23ACF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C31B9B45;
	Mon,  9 Sep 2024 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vNBYQkup"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAA1B81AE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886275; cv=none; b=RyMB0ott01f7jb33NHi15vdrYZCFbsqsv7q+csJ16fZE+JToFg6f1XmhnO//zbm+XFt2lXUCuf6PSZeclg7DqyKXToCngLiAd6f1sSI+27eGqCfXvOMTEQR8vgGXB8Ugu5W6Xj2RhXB9IecWoBzS/uhKiIlx76z1rLv0hUqGs2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886275; c=relaxed/simple;
	bh=lcPgoVo3a2tHQWwBFLfuyr6TwNwy7++H7R/IbpHaKBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9CKNvOlXoJcbpcmMz77Gkb+dB5YpCtXPp+7AGlDLrpEEF7Y4V1pADCMzJ5Sz8UmDKUH/LgB4JgV4Da+70nrXvCPScQDbTKGGGslJLQ8GTA2Hz6dUhavSYbYnQ5ClgzcRYxdg3ZPL3HzwU/xqzMi+v1loxSuN5K6k8lFsXTRIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vNBYQkup; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c7d14191so2942905f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725886272; x=1726491072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yj5yLv/ZZH1FRnKgAiHYKIRr56LuHNVkVtzMQnax5UE=;
        b=vNBYQkupGnFATCi9U/AJjAiLosV/dc5kdqJrylDpiQ6kSZGAscICKMkaSaeSNOl/ba
         c7CWXfe+Mul7p0LKqf58xmqxi2ZwS5PsJCfQ1J4GZBW96+Aode/Mq2R5PhQh60gzcAHw
         2CbXF38CAV8sbffQ6HVlxQH6vo2/OziItJLeznNeojukx31sZT6F7tnkqq/RbDhuZXE1
         lK21XkPoqCpZcBVgwd7OSj02qrN5IN9VX8rbWUZCyeLCP4lD133QYzZaDxQWUVGPELaN
         U9S6tARNfFx12aNUDJS1qSpaITFsJtRf0vW1XiG397PKM4nUP1xYW8/ySCtCokFqsiUE
         yTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886272; x=1726491072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj5yLv/ZZH1FRnKgAiHYKIRr56LuHNVkVtzMQnax5UE=;
        b=oRZMRanRz4IbdmX6AbVOwTxbR3Pkaziu2nE/qdZ7EP59FZDXb+5xCMny8L4/r4YZ7F
         EdqgDzFede7wZJyte4Ynn9TmHc2NPwoEY5TQBAmnRAJ27sPlDMr9zYc7LcJg3Jx4lfHs
         gzhVZeFytUU28uS6QhqbsPY7PHBHOx2LmhqpF3nzj+ubcqC0j7YoCWxDoQBi8rd6dHcB
         6SHMNW7SQei0oiM7dcNPfNwhA4uP3viEARUG0dKATq9ax4LqAOGbJI+xDX2f2R+/PeAK
         QpfGdwBC4uFMM9ZNL1rQhLMrbInnb3ZSUrRTuzRHIprSJgLrtIU15+kx29hwLDtOz3hn
         Z9YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW65BkztwDDW1Dmvl2l3sUmoVYrtiCBSlHB3f6Ug8KUGKXATE65Y4sw6zqogOcD6SwghRwVfEdSAHALa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTUOOqVrPr7LEEkppXM35kZJX+Vq2jShGBcfFoRFVIE5ty85i
	HKTPfayi5gCCgJCSQjOCaZCDGWp1YkwMIrJCzNyCTOHZ1mtNUNrw55EKkBHPpek=
X-Google-Smtp-Source: AGHT+IF7+n0ukNJJ1C8zj6VSJDueCV3USNDHumSPWy7hUUSWu75cFlU2nX0q/4jHTWZ6HrRjePiq5w==
X-Received: by 2002:a05:6000:2c5:b0:374:badf:3017 with SMTP id ffacd0b85a97d-37888b34ca8mr8233636f8f.33.1725886271596;
        Mon, 09 Sep 2024 05:51:11 -0700 (PDT)
Received: from [192.168.0.172] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d2ec2sm5998400f8f.75.2024.09.09.05.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 05:51:11 -0700 (PDT)
Message-ID: <5db7058c-79d8-4fc8-8f37-89cdde68984a@baylibre.com>
Date: Mon, 9 Sep 2024 14:51:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ASoC: mt8365: Remove spurious unsigned long casts
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
 <20240907-asoc-fix-mt8365-build-v1-2-7ad0bac20161@kernel.org>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-2-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 07/09/2024 02:53, Mark Brown wrote:
> The regmap APIs take unsigned ints not unsigned longs so casting their
> arguments to unsigned longs is not a good choice, the constants being
> cast here are all unsigned ints anyway.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   sound/soc/mediatek/mt8365/mt8365-dai-i2s.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
> index 5003fe5e5ccf..6b4d8b7e24ca 100644
> --- a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
> +++ b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
> @@ -385,7 +385,7 @@ static int mt8365_afe_set_2nd_i2s_asrc(struct mtk_base_afe *afe,
>   		/* disable IIR coeff SRAM access */
>   		regmap_update_bits(afe->regmap, AFE_ASRC_2CH_CON0,
>   				   COEFF_SRAM_CTRL,
> -				   (unsigned long)~COEFF_SRAM_CTRL);
> +				   ~COEFF_SRAM_CTRL);
>   		regmap_update_bits(afe->regmap, AFE_ASRC_2CH_CON2,
>   				   CLR_IIR_HISTORY | IIR_EN | IIR_STAGE_MASK,
>   				   CLR_IIR_HISTORY | IIR_EN |
> @@ -393,7 +393,7 @@ static int mt8365_afe_set_2nd_i2s_asrc(struct mtk_base_afe *afe,
>   	} else {
>   		/* disable IIR */
>   		regmap_update_bits(afe->regmap, AFE_ASRC_2CH_CON2,
> -				   IIR_EN, (unsigned long)~IIR_EN);
> +				   IIR_EN, ~IIR_EN);
>   	}
>   
>   	/* CON3 setting (RX OFS) */
> @@ -456,7 +456,7 @@ static int mt8365_afe_set_2nd_i2s_asrc_enable(struct mtk_base_afe *afe,
>   				   ASM_ON, ASM_ON);
>   	else
>   		regmap_update_bits(afe->regmap, AFE_ASRC_2CH_CON0,
> -				   ASM_ON, (unsigned long)~ASM_ON);
> +				   ASM_ON, ~ASM_ON);
>   	return 0;
>   }
>   
> 

-- 
Regards,
Alexandre

