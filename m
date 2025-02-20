Return-Path: <linux-kernel+bounces-524745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA979A3E693
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609D319C47A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A4265616;
	Thu, 20 Feb 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAdeGOVR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85724213248;
	Thu, 20 Feb 2025 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086959; cv=none; b=Zqs3gD3wLOy0Au7ig/IYXeOrDT9TqlEqO2COiLsTUk8A5Q086A93bUEwdmVGwkDHVoK/57opPX6EhAv8FOis6e2taonlmOa7apbSWVD7k+fKRtimdS9kD+YTf5IHGv80UxhI+wRbkqXSuzgaE/pH2a1KXNNAzFVXGXcWit0/zCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086959; c=relaxed/simple;
	bh=A3IOtWBEjqYwd1Ik7NqJ+fHSDWC0dHLIvijucwx1oG4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=uOyTeK92tUuxzpyvKkD1YNIhhvNIU5sZ49nbgVBayjCgfG2c4SBpb7Ts/C9nbD0hUviTEHLDnYEPDlzp6Sbz3wbJpNOIup+XgsmG7/LsJYXnA7axhwS7I5IUvSChTvlswR2uKPY8mqlQ2o7pPIx9rWm99HhPNREG4r+Dr7rGlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAdeGOVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138D3C4CED1;
	Thu, 20 Feb 2025 21:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740086959;
	bh=A3IOtWBEjqYwd1Ik7NqJ+fHSDWC0dHLIvijucwx1oG4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=OAdeGOVRdx64WfB9k0yHqlocXOVN6rl8Couf0rvfJWUkSFENgG/epeD4VMtf8Y/TN
	 S54pP7Rqw8RXnJpTQtUKBywhk28n1frg2sCAJChNSP2t+bZkeSdNG5KumADWfxdgpO
	 96AneZ4SZs9CmxFBxTv9kDfJ2UmO6eoGTpbNNCfDiky8aTgvcxsrYoSYKNFW1+0Erg
	 hUB9zjSfAX40mUz0cXjxBXtgjg63NJuFRUepMpIqdCQK1X2+wptS94V2ctXVlgcb9N
	 JMmrHvOhTAcFehJCuyEhBBRRtmNbkhUMuTDiTkjt+ZooDE96zY2oIFWmgkXsCEALF6
	 CEIokj5qEjZag==
Date: Thu, 20 Feb 2025 15:29:17 -0600
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
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Yow-Shin Liou <yow-shin.liou@mediatek.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Simon Sun <simon.sun@yunjingtech.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, linux-usb@vger.kernel.org, 
 Fabien Parent <fparent@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Bear Wang <bear.wang@mediatek.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20250220143354.2532448-1-macpaul.lin@mediatek.com>
References: <20250220143354.2532448-1-macpaul.lin@mediatek.com>
Message-Id: <174008661763.4046766.2334410087090847223.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk:
 add support for TCPC port


On Thu, 20 Feb 2025 22:33:53 +0800, Macpaul Lin wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
> configuration for TCPC Port, USB-C connector, and related settings.
> 
> Configure dual role switch capability, set up PD (Power Delivery) profiles,
> and establish endpoints for SS (SuperSpeed) and HS (HighSpeed) USB.
> 
> Update pinctrl configurations for U3 P0 VBus default pins and set dr_mode
> to "otg" for OTG (On-The-Go) mode operation.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Yow-Shin Liou <yow-shin.liou@mediatek.com>
> Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../dts/mediatek/mt8395-genio-1200-evk.dts    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> Changes for v2:
>  - Drop the no need '1/2' DT Schema update patch in the 1st version.
>  - Fix indent for 'ports' node, it should under the 'connector' node.
>  - Correct the index for 'port@0' and 'port@1' node.
> 
> Changes for v3:
>  - Correct the order between new added nodes.
> 
> Changes for v4:
>  - Reorder for property 'op-sink-microwatt'.
>  - Fix indentation for 'source-pdos' and 'sink-pdos' nodes.
>  - Correct node 'pin-cmd-dat' with 'pins-vbus'.
>  - Add both Highspeed and Superspeed ports to ssusb0 port.
>  - Set 'role-switch-default-mode' = "peripheral" for ssusb0 port.
>  - Rename endpoint of USB data port to 'mtu3_hs0_role_sw' and
>    'mtu3_ss0_role_sw'.
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250220143354.2532448-1-macpaul.lin@mediatek.com:

arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dtb: usb@11201000: 'ports' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtu3.yaml#






