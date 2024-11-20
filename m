Return-Path: <linux-kernel+bounces-416058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00539D3FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748E61F21AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1F415AD9C;
	Wed, 20 Nov 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pell6VCd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F113B7BE;
	Wed, 20 Nov 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118572; cv=none; b=CjwQPx4UTZYihz1rkeIQyLjO+9Q8B0rSz5+t3zCBpgCvIBCgA9HPwX3gjVpe/Igj14CEPlIooPJEdLCpxkZAqG8eB9FxLPXQemFuOVp/Oqpp5uBZbBT8w6czniBGN1ei99NSjVvEXAYvJf00L7/f/KKASYiBJj1k28aT6tSQMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118572; c=relaxed/simple;
	bh=dbCtaGhVDNU6himXRK3WCjgYx8s5bxzWGTwYnWP6vB4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=uXYjXRTMQNQ5a+L2e3GS11F1MHwEHvDl0iGtUFCBTcyaFM3CUwBNESWq/gdZhYko9AW6U+/DnUD6WfAvGYx/3thMZT+w42NhBYbE4AA4k2uiW6bPkf0hFeRxkjP50bwaIMFlk+E4zAni6OsHhCd13v9aP8jXumVfhj/VlyH0/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pell6VCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D178CC4CECD;
	Wed, 20 Nov 2024 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732118572;
	bh=dbCtaGhVDNU6himXRK3WCjgYx8s5bxzWGTwYnWP6vB4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pell6VCd6UZc+0BIha68xjZq69MtKDESlQTygDNEgZFG3kjM5XmepJsshwtFU9eRc
	 ODAjIm2DLVBqGGkVOF7jjtSPKYAv5XojQhmVlxi4loGmozf7eiRt8uVL2z6jnbYWxk
	 HOo/79lrtnXMd9z5O10kXp8rJyuX4QmZXbfesmLTRfUVfZzp6HWUfk8v23ZSZdXuYG
	 OKqhZT6Xirujv2xkzzGoSi5zDtu4mze2A6mNO8HgaksVTQPH6V2m6FKuToBGEPAKxB
	 BDsW6UDFteVnEUmzpauxDQDP14ZeYo3R1lxMJCIBsVWVuTbQs2FymmRAU5P2B2ZNmI
	 ndvjK7duAuBnQ==
Date: Wed, 20 Nov 2024 10:02:50 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: iuliana.prodan@nxp.com, kernel@pengutronix.de, daniel.baluta@gmail.com, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, frank.li@nxp.com, 
 laurentiu.mihalcea@nxp.com, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 shawnguo@kernel.org, shengjiu.wang@nxp.com, s.hauer@pengutronix.de, 
 aisheng.dong@nxp.com, krzk+dt@kernel.org, festevam@gmail.com
To: Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20241120135859.3133984-1-daniel.baluta@nxp.com>
References: <20241120135859.3133984-1-daniel.baluta@nxp.com>
Message-Id: <173211841141.1124481.13198183587928963879.robh@kernel.org>
Subject: Re: [PATCH 0/5] Configure imx8mp dsp node for rproc usage


On Wed, 20 Nov 2024 15:58:53 +0200, Daniel Baluta wrote:
> DSP found in i.MX8MP SOC can be used by multiple frameworks in order to
> enable various applications:
> 	- rproc/rpmsg framework, used to load for example Zephyr samples
> 	- Sound Open Firmware, used to enable various audio processing
> 	  pipelines.
> 
> Current dsp node was configured with SOF in mind but it doesn't work
> well with imx8mp-evk dts. SOF controls audio IPs from firmware side
> while imx8mp-evk preffers to control audio IPs from Linux side.
> 
> So, configure 'dsp' node to be used with rproc scenario and later will
> add a separate dts or an overlay to configure the node for SOF.
> 
> This patch series configures and enables dsp node to be used with rproc.
> 
> Daniel Baluta (5):
>   arm64: dts: imx8mp: Add mu2 root clock
>   arm64: dts: imx8mp: Configure dsp node for rproc usage
>   arm64: dts: imx8mp: Add DSP clocks
>   arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
>   arm64: dts: Add dsp rproc related mem regions
> 
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts |  6 +++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 23 ++++++++++++--------
>  2 files changed, 20 insertions(+), 9 deletions(-)
> 
> --
> 2.43.0
> 
> 
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-evk.dtb' for 20241120135859.3133984-1-daniel.baluta@nxp.com:

arch/arm64/boot/dts/freescale/imx8mp-evk.dtb: clock-controller@30e20000: compatible: ['fsl,imx8mp-audio-blk-ctrl', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/clock/imx8mp-audiomix.yaml#






