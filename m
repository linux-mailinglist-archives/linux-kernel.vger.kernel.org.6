Return-Path: <linux-kernel+bounces-353498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB31992E94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0171C23451
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4021D54DC;
	Mon,  7 Oct 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjahuzzT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D91D45FE
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310499; cv=none; b=RpXD4CVXbDMHK1ur6ZpXTA/kXb3brFhUKLFKoA2sro4QIvLXq/eVI/Gz7cuBObqmOa9irN5VhQGttZe/0iXKa5L0HtQgppVmJ8MyxKdh5HN8+jD7KauJ3mfZymM1PmI6UBC4ZyBd8qhQQlbjD41p024bYe+c7gNGv3iTqSEdgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310499; c=relaxed/simple;
	bh=r2ifSG/kqUsvpIDjKytJGBVzY/5Fo40YZqD6xIbDuNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqU70zLYzVYBGb+q5nfOl1pGiBvzqIdAj+bHitIv/vaNj24ZOlsnc7kHh0G5cf4LVG9OXhXLhJ0duhb7gPMpaSkf0hi4b/623grOxTWZCUUUsPErW5ykQb9twCPpKssH0T1kdAi/noxu7xXnuvK5KupgBNm5e0iiBx+jBSKsRAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjahuzzT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so35302685e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310496; x=1728915296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8LIZjaEwodqIJq0l8LBqKpbQBEU9Mr/e7w5bfiFaSX0=;
        b=jjahuzzTzZ6kqKpEg4JZ9EISaBYf1Uk1Li8/nNdE6kQZtErhhiGhHxaIzn65UxxMp2
         kphC1yv2Ju51XcCaHuAL2T1g3CUwxo58HzPxZphZ9YwfaKxXMILO4dcK40xMB5UQ6K3w
         C2AaKWnmSLDj9wAZXDcPN7T2mtOePZWhgOZMwTwr+uhQ6HmlvGnHPHBtEJe5PlP931u5
         DOQ0Lim9UMqXDuG2fi/32AjqlPGmIjF9N8MtPeljEfymWxxWIurYVzl/Ddv+E+83D11w
         RXGaWkXX9DGPiBO1X9meimNN2fddH/WAjfFR3Hr9PD06OxQ77MVLk4JZAxw8UGvFKFgV
         +NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310496; x=1728915296;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LIZjaEwodqIJq0l8LBqKpbQBEU9Mr/e7w5bfiFaSX0=;
        b=KLM5EehbeiN+yYiHwkElehOpT42Fg5Kjd+7LjeTouj6UCqau/yiM+s6muWYGYSGX8Y
         y+osL48TMRVstBtQGt1pLiAq0hCe2g+MjpTCGovnPH5GO2NneN3ApO5AThfS6XtxNWHz
         RvshbeOUD9F3GWP0oOURjBKVE+Gf4lKi3FbaO+njFkaakeHfLkQnkdUaOlsrmTZ5gUJM
         xOqrmdaFYxJe9qiIorXZ8oExIqMnMOAl5bu4T+z9ZvPeyy0y/+fT6LIucwa6DIrs/KWk
         AiH1ArAw/Ae4dPoZiK1636B4ogSVXHKSA4A3elanZm5OXQM+5OEr36OmhXFsckc6EMJR
         9Dzw==
X-Forwarded-Encrypted: i=1; AJvYcCV9CS38o+rKMzmt2QXB5Vs9RJMsWqrePIww6WLoVfFsk4HHo/vOsfcPaTHxhCgzTGzA3oaE98ZXwtCAA2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynxl6dw94L6CurpijMLjmx0KHDGH7IOlu2+i1wlZj+XuRbt7lD
	46b9+nFYczOMyhCHUfolNSzQhuLsLc5A/iCx1L89QGYZccWDld3n
X-Google-Smtp-Source: AGHT+IETO4zpiWUfFlHnISokgbSnrh2br9+H8ASqeXyhox/80lWPf/74JSOE5oSoBhDLCsnARIMyQg==
X-Received: by 2002:a5d:5e0b:0:b0:37c:d244:bdb1 with SMTP id ffacd0b85a97d-37d11311be4mr5800210f8f.26.1728310495620;
        Mon, 07 Oct 2024 07:14:55 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972da6sm5823950f8f.98.2024.10.07.07.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:14:54 -0700 (PDT)
Message-ID: <53ce06d3-7154-4819-b978-8e3c834afc34@gmail.com>
Date: Mon, 7 Oct 2024 16:14:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: pwrap: add pwrap driver for MT8188 SoC
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20241007024350.7878-1-macpaul.lin@mediatek.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20241007024350.7878-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/10/2024 04:43, Macpaul Lin wrote:
> MT8188 are highly integrated SoC and use PMIC_MT6359 for
> power management. This patch adds pwrap master driver to
> access PMIC_MT6359.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 33 ++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 9fdc0ef79202..5d3c90e32067 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1087,6 +1087,23 @@ static const int mt8183_regs[] = {
>   	[PWRAP_WACS2_VLDCLR] =			0xC28,
>   };
>   
> +static int mt8188_regs[] = {
> +	[PWRAP_INIT_DONE2] =            0x0,
> +	[PWRAP_STAUPD_CTRL] =           0x4C,
> +	[PWRAP_TIMER_EN] =              0x3E4,
> +	[PWRAP_INT_EN] =                0x420,
> +	[PWRAP_INT_FLG] =               0x428,
> +	[PWRAP_INT_CLR] =               0x42C,
> +	[PWRAP_INT1_EN] =               0x450,
> +	[PWRAP_INT1_FLG] =              0x458,
> +	[PWRAP_INT1_CLR] =              0x45C,
> +	[PWRAP_WACS2_CMD] =             0x880,
> +	[PWRAP_SWINF_2_WDATA_31_0] =    0x884,
> +	[PWRAP_SWINF_2_RDATA_31_0] =    0x894,
> +	[PWRAP_WACS2_VLDCLR] =          0x8A4,
> +	[PWRAP_WACS2_RDATA] =           0x8A8,
> +};
> +
>   static const int mt8195_regs[] = {
>   	[PWRAP_INIT_DONE2] =		0x0,
>   	[PWRAP_STAUPD_CTRL] =		0x4C,
> @@ -1324,6 +1341,7 @@ enum pwrap_type {
>   	PWRAP_MT8173,
>   	PWRAP_MT8183,
>   	PWRAP_MT8186,
> +	PWRAP_MT8188,
>   	PWRAP_MT8195,
>   	PWRAP_MT8365,
>   	PWRAP_MT8516,
> @@ -1845,6 +1863,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>   	case PWRAP_MT6797:
>   	case PWRAP_MT8173:
>   	case PWRAP_MT8186:
> +	case PWRAP_MT8188:
>   	case PWRAP_MT8365:
>   	case PWRAP_MT8516:
>   		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
> @@ -2393,6 +2412,19 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
>   	.init_soc_specific = pwrap_mt8183_init_soc_specific,
>   };
>   
> +static struct pmic_wrapper_type pwrap_mt8188 = {
> +	.regs = mt8188_regs,
> +	.type = PWRAP_MT8188,
> +	.arb_en_all = 0x777f,
> +	.int_en_all = 0x180000,
> +	.int1_en_all = 0,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_ARB,
> +	.init_reg_clock = pwrap_common_init_reg_clock,
> +	.init_soc_specific = NULL,
> +};
> +
>   static const struct pmic_wrapper_type pwrap_mt8195 = {
>   	.regs = mt8195_regs,
>   	.type = PWRAP_MT8195,
> @@ -2456,6 +2488,7 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
>   	{ .compatible = "mediatek,mt8173-pwrap", .data = &pwrap_mt8173 },
>   	{ .compatible = "mediatek,mt8183-pwrap", .data = &pwrap_mt8183 },
>   	{ .compatible = "mediatek,mt8186-pwrap", .data = &pwrap_mt8186 },
> +	{ .compatible = "mediatek,mt8188-pwrap", .data = &pwrap_mt8188 },
>   	{ .compatible = "mediatek,mt8195-pwrap", .data = &pwrap_mt8195 },
>   	{ .compatible = "mediatek,mt8365-pwrap", .data = &pwrap_mt8365 },
>   	{ .compatible = "mediatek,mt8516-pwrap", .data = &pwrap_mt8516 },

