Return-Path: <linux-kernel+bounces-529250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85645A4222F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6DB1885A25
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBBD24EF61;
	Mon, 24 Feb 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBekRFC0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08892136327;
	Mon, 24 Feb 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405424; cv=none; b=BWNneHT6sRaAKiAzf7iwaioqjK+T9LEny/8Y8viJNK1UUJjRLAlMDkELfCLAMBBr602ZYA+76ggb3swtavPpD3LeXx0jKCHLPD2DipTXNj5vTJZyIwOgpthgp8zQVNBgh/uSolBDI/PYJy5hNuGRXk0YbSvbf3qBwF9S6OlBAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405424; c=relaxed/simple;
	bh=OQ7YbuLAqtoQmHB21uw+7T4OIQyqMIGl/9dHS8SMf3I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=N7AU7AoYiosiceNS8eicOntOf59K8vx4RE5pHPL1CkpMaonjOU9kDxvfTn2Huz9/0BxVv+DY6P5yEeO4DYRV7pxQ8sJmOyF5lYXJqlFfsCpu+73taydVEXd0yfN7QwnKU8PojfGPENKSbzlhyQuswITEd9h5Dl+xDpNbHHR9SGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBekRFC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C8DC4CEE6;
	Mon, 24 Feb 2025 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405423;
	bh=OQ7YbuLAqtoQmHB21uw+7T4OIQyqMIGl/9dHS8SMf3I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=IBekRFC0f6gWwCSFDsRNzMkpGSB2uuxZWf8eLw1JIuQCbgnybT8Nr9dWdAq6C7sis
	 +UhxPIog8lJhYq50ZvxT4ZQ8NTT1ltpdZcoKdSf1iVYg7itMrVXxF4evLvHMo0f8F4
	 20aj9DfOAFix0I2zhLERV2oEPOyuYXlhPMgr92riUWrfPD54dcZZEYTlGHtao8N75W
	 6T/XtUBmY64ed3q7yWX6vVFP4g7XwXNBRrVgAuHcNk42BwG91wLRJc+KqvDgknPm/a
	 /8BBroJCopj4QsMIfGtEgKfLq+RmA+Q3EugyZ4Mv4AaSY03IBqYxn/pwkIYSBvjJ0O
	 V+SGYdotM9nvQ==
Date: Mon, 24 Feb 2025 07:57:01 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
 Yow-Shin Liou <yow-shin.liou@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Simon Sun <simon.sun@yunjingtech.com>, linux-usb@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Macpaul Lin <macpaul@gmail.com>, 
 Fabien Parent <fparent@baylibre.com>, ChiYuan Huang <cy_huang@richtek.com>, 
 Bear Wang <bear.wang@mediatek.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Pablo Sun <pablo.sun@mediatek.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20250224114934.3583191-1-macpaul.lin@mediatek.com>
References: <20250224114934.3583191-1-macpaul.lin@mediatek.com>
Message-Id: <174040535775.2710776.691558658609135796.robh@kernel.org>
Subject: Re: [PATCH v6] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port


On Mon, 24 Feb 2025 19:49:34 +0800, Macpaul Lin wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
> configuration for TCPC Port, USB-C connector, MUX IT5205 and related
> settings.
> 
> Configure dual role switch capability, set up PD (Power Delivery) profiles,
> and establish endpoints for SS (SuperSpeed) and HS (HighSpeed) USB.
> 
> Update pinctrl configurations for U3 P0 VBus default pins and set dr_mode
> to "otg" for OTG (On-The-Go) mode operation.
> 
> Add ITE IT5205 (TYPEC MUX) under I2C2 bus and configure its properties;
> also add references and configurations to 'typec-mux' node.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Yow-Shin Liou <yow-shin.liou@mediatek.com>
> Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../dts/mediatek/mt8395-genio-1200-evk.dts    | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
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
>  - Drop it5205fn phandle for node typec-mux@48.
>  - Reorder properties of typec-mux@48
>  - Add "Reviewed-by:" tag. Thanks!
> 
> Changes for v5:
>  - Squash two patches into one patch and refine commit messages:
>    suggested by reviewer.
>  - Drop 'role-switch-default-mode'
>  - Add altmodes settings
>  - Drop 'Reviewed-by:' tag since the two sub patches has been combined
>    into a new patch.
> 
> Changes for v6:
>  - Add 'pd-revision' property to 'connector', thanks ChiYuan Huang's help!.
>  - Add 'Reviewed-by' tag. Thanks!
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250224114934.3583191-1-macpaul.lin@mediatek.com:

arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dtb: usb@11201000: 'ports' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtu3.yaml#






