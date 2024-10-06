Return-Path: <linux-kernel+bounces-352296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDD991D21
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C055B21E3E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 08:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED2E170A00;
	Sun,  6 Oct 2024 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9jotDpO"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614FE170854
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728202461; cv=none; b=N6LcdENHEbwmC5UVPHc5/xW76IXRzGpF8PKQZr2cvi33CMt4pmad16sjIyoWU+HRMzV31vOuxg9B4iPeDl11o/3TAbOJZtmaACW0l3Lch+DFli82kHxL9aFlMrKPhJptQoUlAKndtiWcriJk8v4QDEPaNFyUnysHKKJXWGpkT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728202461; c=relaxed/simple;
	bh=kehccJpcmMm0IKtaBq3m9As0F9gje5n/o4CPhHDf8OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHgP+DqvO/05VjsonMzNCA61vAaqhBWEG7CrOemwZEEaNq9yiz97b3RU9ZCAVIYkIO40SWduZQRlXcncP6jxCckxPjUrMX2L+Kseeurb8Zr0ncygI5jpaiEfw6a2aaYFlbscQypboOel23RLfPZug9UYQPyssujd7xuvdT6Zmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9jotDpO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c89bdb9019so4159326a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728202458; x=1728807258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z3T5Hjfmtymv+/wWpF42wQYfRxK2aZeO3+nu4Wywvmc=;
        b=Y9jotDpOSDhnmGFE/qiiPOghOv2rWvWoXcpfJLQIvrdIy9iFE/VSAOQJtC70kypev2
         +z7RMih/u3qevV4W1bH31wmMY52gTKFRDXmQWGAc6g+qMhRqw7cjAfTJvdebFV3R+et2
         WhapQKvE5utHyTqfvZzBFpziIN+F09d8ZEWCGl3r5utNUjLV/s1Yxhk3n51WTYP6Gr5m
         E1Xi0H99VHgjTXs0FtEystDpomBPQnNWubgZ2vAXKtV+wuo5hqxHEIgVkixKq7PWJ5H4
         op1jiEQmXU+CUcxeyzkStzf85SnMa3pGVwSBUZwXvXebM2wEJmstucoKj/V9a14X6QPI
         LRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728202458; x=1728807258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3T5Hjfmtymv+/wWpF42wQYfRxK2aZeO3+nu4Wywvmc=;
        b=gkWBHXSGTFPPR63UHJJczp1cnXhBxTkqzj3PMRfnQkIswmaOkDep93lzm1Vj9DGZ/8
         FgqKNfik+lhIePK68rOPrh2foDepD/yqiERU5PoPJIaHgC1/f4MvmsO+gfS9IrH9mdwS
         Dxk+iuMpahSYiUsdUH7kqdI0c9+zRLyEPK9muZ8ULen+b2GU9UXS4kuA2MVqrrdAYWXX
         vvwbqQKiDLfDNcbDAlFKUadzfRxzzsqkAKsJTYEqpeWFqlacJz8Kal5XDVNskAruCkKI
         qzwkffGMTKrXu4zBvTcBHfEHmCuWshe+FBAaV6yqa2ttMTM+nEBqbmSiDWDevSrOeYHG
         21bA==
X-Forwarded-Encrypted: i=1; AJvYcCVTcBB3QXYk0mwrGf7GpuD2w0mZwdAnkoI7HnYllLY4BbPNUQmp5/LoZZ5G6KVHPdriBip/g2kX+kA9/40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy652iiIcmBgMxqFMlxG9AkJMmldYfrTVqDUF05rLqKtqOV8DlI
	mGi9zQuxp5MKDlGius/werQVVPxt1RMr94Sojdr46k/6N4cTuD70SVYNkvic
X-Google-Smtp-Source: AGHT+IHG1K1x0pP5Pn8L1WV8joKe+lZYAKwFgKNtSe3mpghD65+PEFtH7oYtHcRa9CsMIs3wXr0lwg==
X-Received: by 2002:a17:906:fe4d:b0:a90:1300:e613 with SMTP id a640c23a62f3a-a991c077ddbmr851592366b.55.1728202457375;
        Sun, 06 Oct 2024 01:14:17 -0700 (PDT)
Received: from [10.32.3.23] ([95.183.227.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994a1464a1sm80746066b.106.2024.10.06.01.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 01:14:15 -0700 (PDT)
Message-ID: <61891c81-3172-4bca-a660-88518e051f9c@gmail.com>
Date: Sun, 6 Oct 2024 11:14:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: Fix XRGB format breakage for blend_modes
 unsupported SoCs
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Adam Thiede <me@adamthiede.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Singo Chang
 <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Yassine Oudjana <y.oudjana@protonmail.com>
References: <20241005095234.12925-1-jason-jh.lin@mediatek.com>
Content-Language: en-US
From: Yassine Oudjana <yassine.oudjana@gmail.com>
In-Reply-To: <20241005095234.12925-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

On 05/10/2024 12:52 pm, Jason-JH.Lin wrote:
> If the constant alpha always set, the SoCs that is not supported the
> ignore alpha bit will still use constant alpha. That will break the
> original constant alpha setting of XRGB foramt for blend_modes
> unsupported SoCs, such as MT8173.
> 
> Make the constatnt alpha only set when setting has_alpha or supported
> blend_modes SoC to fix the downgrade issue.
> 
> Fixes: bc46eb5d5d77 ("drm/mediatek: Support DRM plane alpha in OVL")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 28 +++++++++++++++----------
>   1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 703cd3f6c6d3..de3addd89442 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -494,19 +494,25 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
>   
>   	con = mtk_ovl_fmt_convert(ovl, state);
>   	if (state->base.fb) {
> -		con |= OVL_CON_AEN;
> -		con |= state->base.alpha & OVL_CON_ALPHA;
> +		/*
> +		 * For blend_modes supported SoCs, always set constant alpha.
> +		 * For blend_modes unsupported SoCs, set constant alpha when has_alpha is set.
> +		 */
> +		if (ovl->data->blend_modes || state->base.fb->format->has_alpha) {
> +			con |= OVL_CON_AEN;
> +			con |= state->base.alpha & OVL_CON_ALPHA;
> +		}
> +
> +		/*
> +		 * Although the alpha channel can be ignored, CONST_BLD must be enabled
> +		 * for XRGB format, otherwise OVL will still read the value from memory.
> +		 * For RGB888 related formats, whether CONST_BLD is enabled or not won't
> +		 * affect the result. Therefore we use !has_alpha as the condition.
> +		 */
> +		if (blend_mode == DRM_MODE_BLEND_PIXEL_NONE || !state->base.fb->format->has_alpha)
> +			ignore_pixel_alpha = OVL_CONST_BLEND;
>   	}
>   
> -	/* CONST_BLD must be enabled for XRGB formats although the alpha channel
> -	 * can be ignored, or OVL will still read the value from memory.
> -	 * For RGB888 related formats, whether CONST_BLD is enabled or not won't
> -	 * affect the result. Therefore we use !has_alpha as the condition.
> -	 */
> -	if ((state->base.fb && !state->base.fb->format->has_alpha) ||
> -	    blend_mode == DRM_MODE_BLEND_PIXEL_NONE)
> -		ignore_pixel_alpha = OVL_CONST_BLEND;
> -
>   	if (pending->rotation & DRM_MODE_REFLECT_Y) {
>   		con |= OVL_CON_VIRT_FLIP;
>   		addr += (pending->height - 1) * pending->pitch;


