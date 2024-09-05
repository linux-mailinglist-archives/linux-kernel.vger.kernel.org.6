Return-Path: <linux-kernel+bounces-317915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E296E575
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F65B224C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37931198838;
	Thu,  5 Sep 2024 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyPfJR2j"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538F8F54;
	Thu,  5 Sep 2024 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573668; cv=none; b=py87a2wcqoDuYn2Co+Q3n7DYA3Mg2wy6Oh0u5QgcYPbzy7RoapCcaaxuiPfrIK5S2dHdqk97mMw/VDGJUKaYt60u9vSYeZur1YOBTtcGJQ33O2pIwijjsyv+xsTa2j8EJ0+TSNHiRqHsteoyOjcgBMsYMeOhSXRyJr5msTqd4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573668; c=relaxed/simple;
	bh=5DUKoWWZsoqa5ZtblM/R88RkHT6xFXhtGpUvygTRRZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKQRqhHCDkLyNfefoUCVTQJUn+FApMNIZnso0Y5ffPkoZk801l5S1zOIAiIazn/6c8hTYZFNdtnZLa6Hafaum73KDreEXQa8lCBIBX3hT9hwTsAsDSldkVP+pBdV4jJXHIRkQsT3jDNeP5I8k1Wp9NuDRkRfPyJLAYFnMLfFYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyPfJR2j; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so9833625e9.0;
        Thu, 05 Sep 2024 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725573665; x=1726178465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5HUUgDpFpg7CH7B/u64K6gdMfWIHArY9NWamcfsBl4o=;
        b=SyPfJR2ja2XGvkeqp+Og7yqE5ktNgea4qz4pvZfF3kyIVOVxgRvjv27iUxuRhXMmqs
         wJiTlrh/Dt6vYzOnvlhFA38NxfJixZEU2V2RA2yMhKZClIQfEPl5opjTLbrdUkb4fBAy
         qcwzycpDIqr/zh0yFiNbglQtvW6wWHKfN9c8gFW9Oj3+h9uU8NHitucY1UaP/NwjaNZh
         5PmeXwykp46m9NIp9oVCQi5kVdY5A807dXgiAR91TXCWzfy/uu7X0WxI9f8Yd6ND4bVd
         QveZ9q/QScRHT4c4H1liHopJY7/ifgQBpDruTza2mhS8rarUKmdW+oAiN8/5XyykIj1m
         XxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573665; x=1726178465;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HUUgDpFpg7CH7B/u64K6gdMfWIHArY9NWamcfsBl4o=;
        b=tfNxqTIr3yOqElaLR3I27r2dYjfSFMgbi4chwOGUK2cLB4hl46USNM6bn5LN9gjeDE
         ZMULhq6hlymgxM9oVXWC48iz1/pAde4HTsVwRtp3RiAqRn2AGrAEpqgPLzpzkIihLMVI
         hslDG/x8f79yBCvJndr5EEksTNg9wBEIqi2rie4Kk/w8U36eIPUSBxejJtLHgWnVB2yJ
         SCjPsTxMjt9YQXKmvsoOE41UbnmvVktH9Tuqw+FmygEy+i4MvK4r8GoktDKSDMNNU0We
         qm8Jdpkg/3l9iKavpGUyxJuQezdnWq4cKTYhw4OkewwjcFGq0m2Twv3KWEac+UiZxYmq
         8oug==
X-Forwarded-Encrypted: i=1; AJvYcCUQqv0OriCNswtmrklOpqCNuGwXpmnqpE8Me2F5i/UM8JajutO7ikMs1Lij7MHB4GVg3PBmzXpiZ1NQ@vger.kernel.org, AJvYcCVO1WQpHEUDb97KB+FAOMezhy9CCqfolRhNak8ResBT+RYpG4Mjkut9EWBVmWZhYIIlEudKC3P8rXk7heI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysDR+WLylp9Y5TlbaBSLkY7Tla8mUDdNGXQLs4GAl+28QSHEYq
	VuBMdxTJcUG1104CFAx5Ar9jRJnTmqcn3uJfozGTdD0Ra7qZRWXL
X-Google-Smtp-Source: AGHT+IElmqtoaM4ugIP0F84FqbTkzYo43tKuoYe27gwYhYG+/JbVKL3d4EHnf4sLbNRkLnSCI011IQ==
X-Received: by 2002:a5d:5388:0:b0:376:27b7:da81 with SMTP id ffacd0b85a97d-37627b7e3a3mr7200895f8f.22.1725573664211;
        Thu, 05 Sep 2024 15:01:04 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.7.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ca70fsm194115e9.16.2024.09.05.15.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 15:01:03 -0700 (PDT)
Message-ID: <72b3ddc2-1c56-402b-a58a-cfe7e9f4aaa7@gmail.com>
Date: Fri, 6 Sep 2024 00:01:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] arm64: defconfig: enable mt8365 sound
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org
References: <20240226-audio-i350-v8-0-e80a57d026ce@baylibre.com>
 <20240226-audio-i350-v8-3-e80a57d026ce@baylibre.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240226-audio-i350-v8-3-e80a57d026ce@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/09/2024 11:07, Alexandre Mergnat wrote:
> Enable the MediaTek MT8365-EVK sound support.
> 
> The audio feature is handled by the MT8365 SoC and
> the MT6357 PMIC codec audio.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Applied, thanks.

> ---
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d32fca64996..111ca3abd651 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -960,6 +960,8 @@ CONFIG_SND_SOC_MT8192=m
>   CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=m
>   CONFIG_SND_SOC_MT8195=m
>   CONFIG_SND_SOC_MT8195_MT6359=m
> +CONFIG_SND_SOC_MT8365=m
> +CONFIG_SND_SOC_MT8365_MT6357=m
>   CONFIG_SND_MESON_AXG_SOUND_CARD=m
>   CONFIG_SND_MESON_GX_SOUND_CARD=m
>   CONFIG_SND_SOC_QCOM=m
> 

