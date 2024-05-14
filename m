Return-Path: <linux-kernel+bounces-178674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F958C563D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3561FB21C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5866D1A0;
	Tue, 14 May 2024 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVC/xxHh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B2847F5D;
	Tue, 14 May 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691210; cv=none; b=G4T72LqqQvSxDao8v3mG1zu5u92iQb3rVSmUTqfiFPlJJfQ86BzjCsTMvmkjVpBJucPcaYoZPgD/pHqQNDOUKiR27lbFEXfmIXvMiEMmZaQD/Rx8mzaN1HEaq21UytY+rEy3NhT0lpwMOUSvv3NFO8iZao1ebFBIKcuFlmx/jGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691210; c=relaxed/simple;
	bh=d9o8QKhs7sNJnOQmrIGPwEGHrsAQnYKzrQ5PywCwwOc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=cLGfrWezo4r8GT6mps2JpSq42BueVzQ0L5yYKEXYAVWkkvi2RJgwyxqT7wJJ94WQls8Rp8LdFe4uZHACPHcjv1PFkLTh9b/Btc1R73QH7GbYshCmbBBjH2/6FRTsSEpoXIckvV6CIP2Tt3a0R00mfuwwG9wY0FzEbSnZ5p2Ak7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVC/xxHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C8BC2BD10;
	Tue, 14 May 2024 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715691210;
	bh=d9o8QKhs7sNJnOQmrIGPwEGHrsAQnYKzrQ5PywCwwOc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZVC/xxHhErj3khngq36QkWcuoZeQdbZ854YOGaYdI/ww0Lmu01b79S7yBLe2j0Mkt
	 mRcIJSHVXgb43BFJMwyVMRp567Qft5A0NJKBqzy9JeCxlOWFFlqeAwpz38vkhoiMet
	 sG/8MsnUiSYYEKg5Ox49AMxBICjZctdE4tGqlOVuUmnZBNcZ3qbnkgImZgwLPWJHqg
	 FShjoGiX+Qxld3q7Uw+4RlEkfilmWsMdwDOIdePqe1/5Gq2zXOBO6EZxhzk8vgbARf
	 pSYTcAlFCSKJCg/+MNteb7BSqTMuOp2wfcR6QzK42654+1Q5nSXgWVgmOLepTSZdSF
	 hC5AGA3OBzoLQ==
Date: Tue, 14 May 2024 07:53:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawnguo@kernel.org>, kernel@dh-electronics.com, 
 linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240514010706.245874-1-marex@denx.de>
References: <20240514010706.245874-1-marex@denx.de>
Message-Id: <171569116690.1193972.14506684066492342240.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2
 and PDK3


On Tue, 14 May 2024 03:06:42 +0200, Marek Vasut wrote:
> Enable HDMI output on i.MX8MP DHCOM PDK2 and PDK3. The I2C5 on PDK2 and
> I2C mux port 1 on PDK3 respectively are used in regular I2C mode instead
> of HDMI DDC mode to permit connection of other I2C devices on those buses.
> The pinctrl_hdmi node is part of the SoM DTSI already.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: kernel@dh-electronics.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../boot/dts/freescale/imx8mp-dhcom-pdk2.dts  | 39 +++++++++++++++++++
>  .../boot/dts/freescale/imx8mp-dhcom-pdk3.dts  | 39 +++++++++++++++++++
>  2 files changed, 78 insertions(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-dhcom-pdk2.dtb freescale/imx8mp-dhcom-pdk3.dtb' for 20240514010706.245874-1-marex@denx.de:

arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb: hdmi@32fd8000: Unevaluated properties are not allowed ('ddc-i2c-bus' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/bridge/fsl,imx8mp-hdmi-tx.yaml#
arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dtb: hdmi@32fd8000: Unevaluated properties are not allowed ('ddc-i2c-bus' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/bridge/fsl,imx8mp-hdmi-tx.yaml#






