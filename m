Return-Path: <linux-kernel+bounces-324521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D6F974DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B691C22001
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D009115B155;
	Wed, 11 Sep 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GKZiL4Ky";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="KqlpHbP/"
Received: from a7-45.smtp-out.eu-west-1.amazonses.com (a7-45.smtp-out.eu-west-1.amazonses.com [54.240.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E81552F6;
	Wed, 11 Sep 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045049; cv=none; b=Iw9+2CxEvAUG7c52aogwIqiAuyg3qDy2uaEE5F6x4ysF4v6JoBj8dAtPXcCwpsRl2eYdN8EifQH+wExWeyNwJgmin4lr4srfessgdAiNhyAiChcwa17IDb9arbNZUB8hHhS9O1qwmQYsavYQ2jn0/ODpRzwjVA6UAO0hD3xwQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045049; c=relaxed/simple;
	bh=vUvKnbq/uwwFGfQegRdJ5dmxcL0H9quwOS+8xA7iEFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhPMMP/P/2avCM/w3Zl2QszXSr+K8BxKRue+77Czr81x7epVai1A7OwuvxmJg8zpSvhwTT6DAxyfp74C9c9BoiZv/X11rftLCaKu1PYC3h0wRbQzrb/J/AaDhVgN0MGkeQZ4N2lP8rOdq5zlbqGx0OqfOtgWdLrKVPZzZrq/Eis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GKZiL4Ky; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=KqlpHbP/; arc=none smtp.client-ip=54.240.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726045045;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vUvKnbq/uwwFGfQegRdJ5dmxcL0H9quwOS+8xA7iEFY=;
	b=GKZiL4KyR58cJt4OY+aZDZOLi65aOmKRZvOAG3xMT3ATB5DEDXIWmUy+1g3+Ksdf
	98DT5E0Of/U2ImWQvw6iY9kBCtyVl3vdXgvaFG8yqo4rTpVUFIP7nmbch6JKaYhKoMj
	XEl5blNzzjzGV/fnH1LQgf+Wl2/sbwrUyj2AQlYgKFIRmw5MUSEWc6h8+AbW69Gb1DP
	yq3utQvp9NmrcWVAOfq7hynkAjPhsLXG8gXDOjzsQYdFydRSV+r0M+5Jp64gKng7Trz
	O1CE7dpBJTu5hBoLPbx/DJsGxGTbWUvIrSMF7otdVOOrqW/3ZLwO7/FEenBlYabNVq0
	nWdE51ULGQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726045045;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=vUvKnbq/uwwFGfQegRdJ5dmxcL0H9quwOS+8xA7iEFY=;
	b=KqlpHbP/rdRsMMbXy8JfQzgiNCwzQ1fOPsccG3WEIOos+ICBS8IKxeC2DT8kvgir
	6n/jghADEdbJNp4neaLu+f16flvIMRehDAa/ps+yjgEEviCLA0ZJqanL4pipewwIlKD
	Haf7MlcWKpG8C5R17b5cm/TtxqLwSZsTdVbWhj38=
Message-ID: <01020191e04d4237-204596e1-6cc1-491c-a60f-de3917af7d42-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 08:57:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable GPU
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240910143245.5282-1-pablo.sun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240910143245.5282-1-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.45

Il 10/09/24 16:32, Pablo Sun ha scritto:
> Enable the Mali Valhall GPU on Genio 1200 EVK by providing regulator
> supply settings and enable the GPU node.
> 
> In addition, set the GPU related regulator voltage range:
> 
> 1. Set the recommended input voltage range of DVDD_GPU to (0.546V-0.787V),
>     based on Table 5-3 of MT8395 Application Processor Datasheet.
>     The regulator mt6315_7_vbuck1("Vgpu") connects to the DVDD_GPU input.
> 2. Set the input voltage of DVDD_SRAM_GPU, supplied by
>     mt6359_vsram_others_ldo_reg, to 0.75V and set it always on for GPU SRAM.
> 
> This patch is tested by enabling CONFIG_DRM_PANFROST and
> on Genio 1200 EVK it probed with following dmesg:
> 
> ```
> panfrost 13000000.gpu: clock rate = 700000092
> panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0 minor 0x1 status 0x0
> panfrost 13000000.gpu: features: 00000000,000019f7,
> 	               issues: 00000001,80000400
> panfrost 13000000.gpu: Features: L2:0x07120206 Shader:0x00000000
>                         Tiler:0x00000809 Mem:0x301
> 		       MMU:0x00002830 AS:0xff JS:0x7
> panfrost 13000000.gpu: shader_present=0x50045 l2_present=0x1
> [drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0
> ```
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> ---
>   .../boot/dts/mediatek/mt8395-genio-1200-evk.dts  | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> index a06610fff8ad..9b7850b0b9b4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> @@ -194,6 +194,11 @@ eth_phy0: eth-phy0@1 {
>   	};
>   };
>   
> +&gpu {
> +	mali-supply = <&mt6315_7_vbuck1>;
> +	status = "okay";
> +};
> +
>   &i2c0 {
>   	clock-frequency = <400000>;
>   	pinctrl-0 = <&i2c0_pins>;
> @@ -407,6 +412,13 @@ &mt6359_vrf12_ldo_reg {
>   	regulator-always-on;
>   };
>   
> +/* for GPU SRAM */
> +&mt6359_vsram_others_ldo_reg {
> +	regulator-always-on;

No, that's not good. Like that, the GPU VSRAM will be subject to current leakage.

Remove the regulator-always-on property.
The right way of doing that is to add the vgpu to the mfg0's domain supply and
vsram to mfg1; that way all of the GPU regulators will be off at PM suspend time.

> +	regulator-min-microvolt = <750000>;
> +	regulator-max-microvolt = <750000>;
> +};
> +
>   &mt6359codec {
>   	mediatek,mic-type-0 = <1>; /* ACC */
>   	mediatek,mic-type-1 = <3>; /* DCC */
> @@ -839,8 +851,8 @@ regulators {
>   			mt6315_7_vbuck1: vbuck1 {
>   				regulator-compatible = "vbuck1";
>   				regulator-name = "Vgpu";
> -				regulator-min-microvolt = <300000>;
> -				regulator-max-microvolt = <1193750>;
> +				regulator-min-microvolt = <546000>;

I'm okay with this constraint but are you sure that MTK-SVS won't go any lower
than 0.546V?

Cheers,
Angelo

> +				regulator-max-microvolt = <787000>;
>   				regulator-enable-ramp-delay = <256>;
>   				regulator-allowed-modes = <0 1 2>;
>   			};



