Return-Path: <linux-kernel+bounces-365993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B399EF33
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07A51C223B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91091DD0CC;
	Tue, 15 Oct 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP1MDclP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92E1D517D;
	Tue, 15 Oct 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001869; cv=none; b=tCjTeYgMv8v/BeLkPcMHQNrhmjy0GGgjjGVEeESieQ50Z5V6EWgqW/8BKHQ7GOalQmSn0D+CjLTg4ikausUATkhN3c3GXYZXZQz8tH1wxjyBikC37Hm6HahSKKAA6cJGHG3PHmHHldlak/8KMEpwSR98eg+J3UGFnemVHf0ZQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001869; c=relaxed/simple;
	bh=iZqNn7g9OXXe6WGfli4O7RtbH/+szUKN4vMHdvXmN+g=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=R7xXjWPcMCjR7eOOBOWpv38ZRKdAcZc/2qn+IPTbbbfVoc9NyJ4HbA+LXCwNhjDn4pzRUBPXXxugpnldB6emypoWw/HWD98C1P0j3foOOUtAEr9Elzt7z9A6QuA10Ab9H0JxCNYDShuLc7XnbyTvAzuTymWuGjOzWWjILN+BB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP1MDclP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4C0C4CEC6;
	Tue, 15 Oct 2024 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729001868;
	bh=iZqNn7g9OXXe6WGfli4O7RtbH/+szUKN4vMHdvXmN+g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kP1MDclPUrNREYEAwxiyR80xbeOTPqkTkG/X952td+u/RHZ7rHSNdXzC3EFOeEeph
	 fYvaVdAxWxBofYTsqm3KQ3hBZfY4PozFgds6U89KcImxmX6E9wVASRJARLOPAKQnQp
	 n5cjs26QM5B+49JeTL/ksTRb0ZWg2xCpoVPu6cinHhX6/UbjdY9QVf0JYwZVB1aayc
	 G+U4DDbzzy1aLlaYljoe4fezguILi+m90W/vw8HNDD/fIXFgcY0GWV7U2mtzLQ/lK1
	 JK27TqLOnX1csuMRwVzINFCLfPeKTh25J+fKcSCfQ0V/8sXeVGhiDpD79+AVuaAXec
	 LnUNJDDqL+MyQ==
Date: Tue, 15 Oct 2024 09:17:46 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-mediatek@lists.infradead.org, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, devicetree@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
 ChiYuan Huang <cy_huang@richtek.com>, Bear Wang <bear.wang@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Pablo Sun <pablo.sun@mediatek.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>
In-Reply-To: <20241015103337.20479-1-macpaul.lin@mediatek.com>
References: <20241015103337.20479-1-macpaul.lin@mediatek.com>
Message-Id: <172900161055.732877.16548202853893861395.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: mediatek,mt6360-tcpc: add ports
 properties


On Tue, 15 Oct 2024 18:33:36 +0800, Macpaul Lin wrote:
> Add 'ports' and sub node 'port' properties to specify connectors on the
> High-Speed/Super-Speed data bus, or Sideband Use (SBU) AUX lines
> endpoints of the USB controller.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/usb/mediatek,mt6360-tcpc.yaml    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8395-genio-1200-evk.dtb' for 20241015103337.20479-1-macpaul.lin@mediatek.com:

arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dtb: usb@11201000: 'mediatek,usb3-drd' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtu3.yaml#






