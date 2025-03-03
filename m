Return-Path: <linux-kernel+bounces-541778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5876A4C171
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CE6188DCDD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949A211A28;
	Mon,  3 Mar 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7rUk9Vq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66FF211A05;
	Mon,  3 Mar 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007665; cv=none; b=MxFi5tbNc6+Nqf0/3gzzGaKTQyFChLHenRZqZSNQIgpkYuYRySKv9eDzBurCJFNoehJTqzN79fNDnJDvSst0Asax0UnVumcAmsmV32/E7GywXuW49K2Iqe6bmIE8O5kun7VDDeMty7UGbG5WoN0asn5f88mrHzEjipbQzZYSQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007665; c=relaxed/simple;
	bh=TGTA1E6JEST7UBAQ+YC8/fElACd4pLq8wkDwFN71lKM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=oxxvdcoj//mgL5KxgDZwUchRcVcXaMsth/9ExAoSVoOMKm+Gb0KuTQ58Q8xO3PX1mPUP0AzH2jf/skdi0FIYIeOrJlpbe1ALPUVgImSHQcJ9TffyYTdYiE9rhG41lBrXsqaDJjPQRRcJP2EnhkvCIt7ejP0uRQ3nfXnRNNHY/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7rUk9Vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA0CC4CED6;
	Mon,  3 Mar 2025 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007664;
	bh=TGTA1E6JEST7UBAQ+YC8/fElACd4pLq8wkDwFN71lKM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=l7rUk9Vqb4qD1HM4/PUliRlzDZ/RglRb255OV3YvFjgAjHtG1ynRKc4hn9dAG0naP
	 sL/paPEL/PrO3WDsLYOz9YTbIf0WCUf3B5pSf7Wl6jeyy9fcpoutAPhik25/K6Mz9F
	 hWy1bndkV+srqMjL/OuwAgFQmPnSTzpysi3SbiNwgPqAiCtL92RpIj5tqglqZw17t3
	 QYzhZxTZZYN1VdqfKTW1Xpyusy2wJMxxWD5JttC0dkfqFefBf1HmmutGxPKBDnv5U4
	 IeintIVWIVPI3cyoe8hnmnK9rwsMnWu6lmJpaEtvtTiO/NfnYeeI32RbLJh662Qy7V
	 Is9cRXcfqv/JA==
Date: Mon, 03 Mar 2025 07:14:22 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Dragan Simic <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Ondrej Jirman <megi@xff.cz>, oren@taumoda.com
To: Olivier Benjamin <olivier.benjamin@bootlin.com>
In-Reply-To: <20250302-camera-v2-0-312b44b4a89c@bootlin.com>
References: <20250302-camera-v2-0-312b44b4a89c@bootlin.com>
Message-Id: <174100756342.1496432.13525001046589650436.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Describe the cameras in the PinePhone Pro dts


On Sun, 02 Mar 2025 16:41:01 +0100, Olivier Benjamin wrote:
> This series adds support for the Pine64 PinePhone Pro's rear and front
> cameras in Device Tree.
> This is based on some of Ondrej Jirman's patches hosted in his tree at
> https://codeberg.org/megi/linux, but I have also fully reviewed and
> re-written the code from the RK3399 datasheet, the PinePhone Pro
> schematic, and the IMX258-0AQH5 software reference manual.
> 
> I have tested these changes on my PinePhone Pro and am able to take
> photos from both cameras using libcamera's cam.
> 
> Signed-off-by: Olivier Benjamin <olivier.benjamin@bootlin.com>
> ---
> Changes in v2:
> - Rebase on mainline
> - Change patch subject to arm64: dts: rockchip
> - Rename new regulators to fit preferred form for fixed regulators
> - Link to v1: https://lore.kernel.org/r/20250228-camera-v1-0-c51869f94e97@bootlin.com
> 
> ---
> Olivier Benjamin (2):
>       arm64: dts: rockchip: describe I2c Bus 1 and IMX258 world camera on PinePhone Pro
>       arm64: dts: rockchip: describe the OV8858 user camera on PinePhone Pro
> 
>  .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 138 +++++++++++++++++++++
>  1 file changed, 138 insertions(+)
> ---
> --
> Olivier Benjamin <olivier.benjamin@bootlin.com>
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250302-camera-v2-0-312b44b4a89c@bootlin.com:

arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: camera@1a: port:endpoint: 'link-frequencies' is a required property
	from schema $id: http://devicetree.org/schemas/media/i2c/sony,imx258.yaml#
arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: camera@1a: 'clock-names', 'lens-focus', 'orientation', 'rotation' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/i2c/sony,imx258.yaml#
arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: camera@36: 'orientation', 'rotation' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov8858.yaml#






