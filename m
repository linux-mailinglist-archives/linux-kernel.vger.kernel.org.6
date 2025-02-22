Return-Path: <linux-kernel+bounces-526874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573FAA404B4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2653BF979
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24AF1D88B4;
	Sat, 22 Feb 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8srSeKj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E52A1CF;
	Sat, 22 Feb 2025 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740187781; cv=none; b=qJNXAazj5WY3Btp/UFAitNe3IN+sHnDdC/Z69JLzJ07OL+xZu79qN1Wqb9pRFeZAGcio19Q4rhRr4hx9w08G7YDdFMAj5phOYpTKR7fEjQ7cD0RO8+L1hfvXfkG4Lt5GdZHklXbH2lP/iL45BvWx6obMykrlUDyi0clfDLNiy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740187781; c=relaxed/simple;
	bh=M/8afILG/fiSMw6cLfHMqMulnTBlFbWMNBSND4QBAuE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=omUenoWoRlwZPNNds3ND+wFwpO75f5YTWpRLVF0zwzjv6T2AdyR7QfyqG2uIbl+guds+nQnSEmLDd+VSymIWPdKYnPvmF1Y68ewvA7aZ+EIV+9IKsJgtugVd0HUt1u+0GqD2C1zhTXt4jLNbiYXt3ZfMZzvHtnJkTGWFsJj6ykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8srSeKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E390C4CED6;
	Sat, 22 Feb 2025 01:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740187780;
	bh=M/8afILG/fiSMw6cLfHMqMulnTBlFbWMNBSND4QBAuE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=V8srSeKjQCkRGONBXy9ePBQV4CUVrRdTUDJwg7i/A7oOmgCMNQLWkvMcQ+i/5+i/m
	 CmOUI/22IW+5nH1nHgxGH0LUJ+SlCtCxMw0OfKEv3N/VS5KXymn2qGzyZzuQr7B/h+
	 nwBrColLbfUC+1L+d12ux/VnAX533oZobVDJS2vBmJUTvYrMqY9bXDWnVgG6OwfU0F
	 P29wqoT74KE3Eq4cAOTsOcJ5mL9unybZFJgf6I3msDUHQLlgjRenOKNjbg5PNSstuD
	 TXU7WnWsCa8XkABpBVycl8MVGYCBomwVkMIHMRiTzgD+OCY6zTqYPig95sNFHudgKs
	 o+K7owCl1VxAQ==
Date: Fri, 21 Feb 2025 19:29:38 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Shawn Guo <shawnguo@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor.dooley@microchip.com>, devicetree@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev
To: Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
References: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
Message-Id: <174018774174.599965.6492650307461479037.robh@kernel.org>
Subject: Re: [PATCH v4 0/4] arm64: dts: add imx95_15x15_evk boards support


On Fri, 21 Feb 2025 16:15:56 -0500, Frank Li wrote:
> Add related binding doc.
> 
> Add imx95_15x15_evk boards, which have big difference with imx95_19x19_evk
> boards.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v4:
> - Add usb typce part
> - Link to v3: https://lore.kernel.org/r/20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com
> 
> Changes in v3:
> - Add Rob and Conor's ack tags
> - Remove undocument property (need doube check why dtb-check have not
> report warning).
> 
> - Link to v2: https://lore.kernel.org/r/20250114-imx95_15x15-v2-0-2457483bc99d@nxp.com
> 
> Changes in v2:
> - fixed typo 'inctrl-names'.
> - Link to v1: https://lore.kernel.org/r/20250113-imx95_15x15-v1-0-8c20cbaab9ed@nxp.com
> 
> ---
> Frank Li (4):
>       dt-bindings: arm: fsl: add i.MX95 15x15 EVK board
>       arm64: dts: imx95: Add #io-channel-cells = <1> for adc node
>       arm64: dts: imx95: Add i3c1 and i3c2
>       arm64: dts: imx95: Add imx95-15x15-evk support
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml    |    1 +
>  arch/arm64/boot/dts/freescale/Makefile            |    1 +
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1130 +++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx95.dtsi          |   27 +
>  4 files changed, 1159 insertions(+)
> ---
> base-commit: 3d34d52fb62b250297279c3d95b2562180a44569
> change-id: 20250110-imx95_15x15-6a64db8c0187
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com:

arch/arm64/boot/dts/freescale/imx95-15x15-evk.dtb: pcie@4c300000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml#
arch/arm64/boot/dts/freescale/imx95-15x15-evk.dtb: pcie@4c380000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml#






