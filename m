Return-Path: <linux-kernel+bounces-321179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0A397158C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BE4283E9A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B21B4C46;
	Mon,  9 Sep 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CikMF0rm"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78842AAB;
	Mon,  9 Sep 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878548; cv=none; b=snXWRjhWOo+jsC7iD/4oOE7oP8tPnfkPZA9OCLzOhV80tG80njUA/gHKRPGSUbhB395oy/7Oop95upAYDOmC1UW7r5V7N+aYBt3H6lILXqwhvYjDdPlrPfEgQXPMlAcF1bRR5L2rL2yW8eUYXOAW8Hln6Mt73kpALonr86l9hNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878548; c=relaxed/simple;
	bh=HD+6g/13SAMgPMcBOrZ6RquRXFg0ROfm6OPAoBeIBhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgeEyvFM2WQHj46fkCDnE7SIMpbcWG/Bk9xgdZ2OzfKGRff6itEv3McRaPOSvwwvDm3Mcy5wp5VnT2Nbi/jxzwsWvYz4TM3e6/Mr6tr6T6KTmTLvrcpP3Xt+DC5g6FxrRl/TntwSDfo0ZtoYnxfyW8pcYYJ5YCpa5/QjXRkvjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CikMF0rm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d56155f51so88695966b.2;
        Mon, 09 Sep 2024 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725878544; x=1726483344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b6Oto6FkOxcH9sTVmFt9+mb30064xkb5Yt2EjFQ4XWE=;
        b=CikMF0rm8VIFwra0dzbWFXYYKf3yL2NmnB4zExOka42DnFIqHR5GtSq44FfzPo+ys3
         Jeq9oom+pGiMMk95qgUv2/MjNoFYEH0zykmV0nRLnvkNlWCRt7fXWXaju+Sh2Ufm3aFl
         rA9H7RDgA1P5+3iTMiYvO8w+GKXjUmlKMTp6ciiEUFgHxnbi0P9Ak7hVpH571SxitG6g
         q5cPy+5k98ifVmHqM84SvwBi1n1ZmkT/vnApMWGLf6wkNXjcP/I9iu/Q+nPrcugnc7LQ
         N11W3jRPVPXa5Gz4AyeYmvNKQyzs5L2i6vAZB/Hr+sxb6ouXnD4tHdRUudgE2E/Ivd0d
         SQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725878544; x=1726483344;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6Oto6FkOxcH9sTVmFt9+mb30064xkb5Yt2EjFQ4XWE=;
        b=KwnNPmdU/gkzldFErAPzpUAPcGwsl5PFV/eMDuf17QKqgjsOTpYtLkxZr5wp7hoSQn
         1BpJUTeygXNLAHuf3vaW0zcKv2OL9ze/YM2UvDHUTvjWGT0DjeOqtT8yTkBi+9NkQ2Y/
         ghSYfEgMsFds0ZtuLq5FBsDJJ1jVAHTwjWFt4Z1PgJHDmH8FZ2Apc+Uk93yPkR1FsD4V
         Q1pOOJQNCgS0nD6W4ui1EwV6hk33n8KELhqlWyOM8R+j5F/wUZC6bDy7AKau0ZkeEHo0
         zM+vwBiMwwGPnNUI7nZeO8sbIARTMZu2TNutXCUc3Jjjw5ociJRl7HNwuarZircwxQpf
         L5+A==
X-Forwarded-Encrypted: i=1; AJvYcCUvbrV66e2cWokD7/R+z9kNa8JtqFSBZ5Er+oCT8cghI4E/WJeg5nYZBW0RnZ9xMEUS0FGKR2YmbdGteWg=@vger.kernel.org, AJvYcCWRirpaLLwpOKZtnGo6sdlHgWsFhQIBksOC15DdI2+Q2gqfqB6VMkVkTdq+MHhYBeFl+ld5c25+/VKeJBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ysfXcaxfB2eYPIK+2zxfGJfbhoDChFZQF7TL3VJvAcAraCoW
	14MRKLe2QliioKc+WUnjWxLu4VdZRpRyYerX/kN6w/UYRpkw4ToG
X-Google-Smtp-Source: AGHT+IH0iXsw3xij6cQqnu+SGrGqFa+YmSdDyrUlCs5KPYn1WYIWamsfl8DEWZSqZLwW5qUnaY8noQ==
X-Received: by 2002:a17:907:2d2a:b0:a8d:60e2:396b with SMTP id a640c23a62f3a-a8d60e23b34mr113737166b.65.1725878543657;
        Mon, 09 Sep 2024 03:42:23 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.7.156])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d259528ecsm323452266b.67.2024.09.09.03.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 03:42:22 -0700 (PDT)
Message-ID: <d39fe852-23f9-4202-8785-70cc977f22d7@gmail.com>
Date: Mon, 9 Sep 2024 12:42:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8365: remove unused mt8365_i2s_hd_str
To: Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240907200053.3027553-1-arnd@kernel.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240907200053.3027553-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/09/2024 22:00, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The mt8365_i2s_enum and mt8365_i2s_hd_str variables are not
> used anywhere, but cause a warning when building with C=1
> or when enabling -Wunused-const-variable:
> 
> sound/soc/mediatek/mt8365/mt8365-dai-i2s.c:781:27: error: 'mt8365_i2s_hd_str' defined but not used [-Werror=unused-const-variable=]
>    781 | static const char * const mt8365_i2s_hd_str[] = {
>        |                           ^~~~~~~~~~~~~~~~~
> 
> Remove these for the moment, they can be added back if a
> user comes up.
> 
> Fixes: 402bbb13a195 ("ASoC: mediatek: mt8365: Add I2S DAI support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   sound/soc/mediatek/mt8365/mt8365-dai-i2s.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
> index 6b4d8b7e24ca..3482d8f8b4e7 100644
> --- a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
> +++ b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
> @@ -777,13 +777,6 @@ static struct snd_soc_dai_driver mtk_dai_i2s_driver[] = {
>   	}
>   };
>   
> -/* low jitter control */
> -static const char * const mt8365_i2s_hd_str[] = {
> -	"Normal", "Low_Jitter"
> -};
> -
> -static SOC_ENUM_SINGLE_EXT_DECL(mt8365_i2s_enum, mt8365_i2s_hd_str);
> -
>   static const char * const fmi2sin_text[] = {
>   	"OPEN", "FM_2ND_I2S_IN"
>   };

