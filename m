Return-Path: <linux-kernel+bounces-353480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B7992E68
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8475E1F24722
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1471D47C8;
	Mon,  7 Oct 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1bUVINr"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7B1D47D2;
	Mon,  7 Oct 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310135; cv=none; b=de+Dbu6UCnMxzzFQPRvfy5LOXuU33bkJb1XqcRfnKqfrdcjZjMmLvVSpP/Nxmx29BzD/arfc/y62WdlMuUBrWzzawpcEgJaPVaH6X0ZduH+FQ6ROL/ZDGeJJ6+A2li1Nyxy4XWsY6/zr4Oc81hN92L9AryKCDyV8WYi90/7TP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310135; c=relaxed/simple;
	bh=iyEzktarnEVzM9L/cb1zUL3YqxpPP5Ks9GXLDzEY/xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hota2MXoTo+ZAp5XLSuwtN4UENVWWG8RiebqlreqWGuqUqPYTj87BeCGpA73oHG4Tbl8piFDr4oeI4133rlRRY1Py61U4WdEWmoo0McRHj8G30/jTeJq1BH3CQRzqcMVw/56M4+Rja8AffhE14PJ/cTG2A0bDP2Vt26/q+7x+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1bUVINr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539885dd4bcso5474996e87.0;
        Mon, 07 Oct 2024 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310132; x=1728914932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zb7wAIefetmyULqsThbIXGhjEAFrVWLHkT3y0uI9AEM=;
        b=Y1bUVINrbm4z34j+2HqWcm3HI1hq1IIJ1HbG7NgkcEEIZDtWFcR7/RJyDE7l13zXBc
         rb9UTo7XosfVjNSDXSRF+OuVwMJlvtfKOeNySbBe7CP5WmIaffVG9WRnEhcLN7pGNSnh
         SUHDvAYU8PoWyESwYUGDwyAaXwsrcHeaxdzZovBdZTYZdEO7Up2oekWI9Tg51SriTWwz
         XTWyWjc0phC36ElTEf00dnt6s0sIlCoVCs/iySbCgoXa7Ee3FRWX0yuy7uMdjngfXUzG
         B9LEFeyIRZSZVVRBngBLzxEq2GQ74dQPP8PzCXZ112l9v2Yl7KIXNxlo+zPVawl07k2P
         HmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310132; x=1728914932;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb7wAIefetmyULqsThbIXGhjEAFrVWLHkT3y0uI9AEM=;
        b=YDvH2QOE9aId60vaiWC8R+K/XDqhdlycMG3xTGtsJ7Z/jug3gE2oOFVChAmAosaiLa
         IUGwyO7SVU+UffA8HwQ4fglgxJkyZuC1XR6IxNuSdwOOsysxA1diTEoBCoKf/hx/2Yg3
         6Ow+y63zpDUCJmkIF79+sLftRxwdUDWsvBcDGYQjRjAs30PgSQBsUpv8T8ryqoA3CxhG
         LA0oyjcTDxekvyaLudbPtL8EDp09XY0meNrJtP+ebIThyrUDeyLQFsjJER8PVJsexgr6
         P1HDcVBfKLImAvxS6QNzhQIH4aPq10GlDcZXhA7Riy44a81rEidY6bhcXCfZVFpZn7c2
         Q1/w==
X-Forwarded-Encrypted: i=1; AJvYcCU4bpY6Bj1d1h+fSeYHUh/XEn5rJI/PDpS6ry/NxMUB4tDHGMOdxA5V4FjPRw51Sum7v7Pln8a51teJNMy9@vger.kernel.org, AJvYcCVpR6GXkZD1OEbrWD7Kgty6TbbTbNTOmN0wsi+GteKFap0cPjPSX/z0l3+k6JcSw2ux1O0gpnnzT2P0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7uL6ygKkFmLPZ4kDBA+tfAPGp4jUikySuxWqBodz7TFVDLif
	8Sz5wzCvtr9rnEtd7q5ke4+iEI9lOeE2saCovgd5cNQ3ORTf5pNf
X-Google-Smtp-Source: AGHT+IHaCEe4z3YIDSbWblPPM6gMGIDCD//Oy46/0gPja7JeJVxRCUO3xT6psfC7QbYmDi2s6H5LYw==
X-Received: by 2002:ac2:4c49:0:b0:539:947e:18a9 with SMTP id 2adb3069b0e04-539ab9e175bmr5803485e87.43.1728310131924;
        Mon, 07 Oct 2024 07:08:51 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1696f921sm5825596f8f.91.2024.10.07.07.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:08:50 -0700 (PDT)
Message-ID: <27719ca0-7794-44db-b8dd-9a31c726ee6d@gmail.com>
Date: Mon, 7 Oct 2024 16:08:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8390-genio-700-evk: enable pcie
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Jieyy Yang <jieyy.yang@mediatek.com>, Jian Yang <jian.yang@mediatek.com>,
 Jianguo Zhang <jianguo.zhang@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20241007100749.6657-1-macpaul.lin@mediatek.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20241007100749.6657-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/10/2024 12:07, Macpaul Lin wrote:
> Enable PCIE, PCIEPHY and related Pinctrls for mt8390-genio-700-evk
> board.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../dts/mediatek/mt8390-genio-700-evk.dts     | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> Changes for v1:
>   - This patch depends on the pcie patch of mt8188.dtsi
>     [1] https://lore.kernel.org/all/20241004081218.55962-3-fshao@chromium.org/
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> index 3e77f59f2c74..bb68665f0b2d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> @@ -393,6 +393,16 @@ &mt6359codec {
>   	mediatek,mic-type-1 = <3>; /* DCC */
>   };
>   
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_pins_default>;
> +	status = "okay";
> +};
> +
> +&pciephy {
> +	status = "okay";
> +};
> +
>   &pio {
>   	audio_default_pins: audio-default-pins {
>   		pins-cmd-dat {
> @@ -758,6 +768,15 @@ pins-rst {
>   		};
>   	};
>   
> +	pcie_pins_default: pcie-default {
> +		mux {
> +			pinmux = <PINMUX_GPIO47__FUNC_I1_WAKEN>,
> +				 <PINMUX_GPIO48__FUNC_O_PERSTN>,
> +				 <PINMUX_GPIO49__FUNC_B1_CLKREQN>;
> +			bias-pull-up;
> +		};
> +	};
> +
>   	rt1715_int_pins: rt1715-int-pins {
>   		pins_cmd0_dat {
>   			pinmux = <PINMUX_GPIO12__FUNC_B_GPIO12>;

