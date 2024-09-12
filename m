Return-Path: <linux-kernel+bounces-326876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FEC976DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCDF284132
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D741B9B46;
	Thu, 12 Sep 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGD0ozUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859744C8F;
	Thu, 12 Sep 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155601; cv=none; b=T2DN3m/6whFaHzohgUgcaDPu+5gROUqod51pbDdLDy2YO7zGGCYQ1IJXd8qCs9ly+g2SkJn7Zo3mCnVuSe5AgVzIna0/kz/+dxOD/cyH4OmTUvohzeBpaUCK2DmKThOFmlWGq8LEWe1lIV6rFZ2svnOQSZ1wj2JoqgjsI7QGoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155601; c=relaxed/simple;
	bh=mZFVRlNHijivCkrfmW31od9zGNtDa8jo6+f4COQFw5U=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UbHP2NBEiSrjCXLV3icw1X+ktonCcPxkUwPohKfRKXA+KCC7Huxpr0JOTJQE0KfjEs5S3J1g9ekx3FYL5LsjTuI/AcQ7knLcix8DNJTN+kjVmJJte/NNdJZE05JB3Gtzlu46Lpkydh4YhJZt8kXtS6fwvBWJTqKyWZ0ZKMP6D4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGD0ozUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFADC4CEC3;
	Thu, 12 Sep 2024 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726155600;
	bh=mZFVRlNHijivCkrfmW31od9zGNtDa8jo6+f4COQFw5U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=aGD0ozUWzEEsplId8Ux8ykTBbfqxSNyvAzg9nACU84pClQ4t1ooD5SR2ku5L5hX2J
	 2LAdN/mI28mz5Hc5X9mRv6g/tk2WwSGaxjNSpuQD7sh1lBrKc8ZQaD2eaLVIRA1Qoc
	 Ohd4ftCgwTpcp1LyWvWZGYQ62b4Ib/rPbyTc4JeX3BoK2s4iJtMpFHoXRYIKdRam0R
	 5+PJeTSCCA4FUimA+TgE1niC2n0y1HmOShHwbczg1MUmta6mMhVvLkFk0oJfSH11V6
	 OlaTHG717OnOuLzHI8IDFGreF9d+TZpEJopjsMxUHc0SXzY2uyo8IRNYa6cBuVIpjt
	 csC02+WsQC7MA==
Date: Thu, 12 Sep 2024 10:39:59 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pablo Sun <pablo.sun@mediatek.com>
Cc: linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240912070624.25540-1-pablo.sun@mediatek.com>
References: <20240912070624.25540-1-pablo.sun@mediatek.com>
Message-Id: <172615543357.3778398.2957632897168854309.robh@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable
 GPU


On Thu, 12 Sep 2024 15:06:24 +0800, Pablo Sun wrote:
> Enable the Mali Valhall GPU on Genio 1200 EVK by providing regulator
> supply settingsi to gpu and mfg1, and enable the GPU node.
> 
> In addition, set the GPU related regulator voltage range:
> 
> 1. Set the recommended input voltage range of DVDD_GPU to (0.546V-0.787V),
>    based on Table 5-3 of MT8395 Application Processor Datasheet.
>    The regulator mt6315_7_vbuck1("Vgpu") connects to the DVDD_GPU input.
>    Note that the minimum voltage in SoC eFuse data, which is read by
>    MTK-SVS to adjust the regulator voltage, does not go below
>    the recommended operating voltage in the datasheet.
> 
> 2. Set the input voltage of DVDD_SRAM_GPU, supplied by
>    mt6359_vsram_others_ldo_reg, to 0.75V, the recommended typical
>    operating voltage in MT8395 Application Processor Datasheet.
> 
> This patch is tested by enabling CONFIG_DRM_PANFROST and
> on Genio 1200 EVK it probed with following dmesg:
> 
> ```
> panfrost 13000000.gpu: clock rate = 700000092
> panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0 minor 0x1 status 0x0
> panfrost 13000000.gpu: features: 00000000,000019f7,
> 					   issues: 00000001,80000400
> panfrost 13000000.gpu: Features: L2:0x07120206 Shader:0x00000000
> 					   Tiler:0x00000809 Mem:0x301
> 					   MMU:0x00002830 AS:0xff JS:0x7
> panfrost 13000000.gpu: shader_present=0x50045 l2_present=0x1
> [drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0
> ```
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> ---
>  .../dts/mediatek/mt8395-genio-1200-evk.dts    | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y mediatek/mt8395-genio-1200-evk.dtb' for 20240912070624.25540-1-pablo.sun@mediatek.com:

arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dtb: display@14f06000: clocks: [[32, 14], [32, 43], [32, 44]] is too long
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,split.yaml#
arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dtb: dp-intf@1c113000: power-domains: False schema does not allow [[45, 18]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#






