Return-Path: <linux-kernel+bounces-366657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4035299F854
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BB7282ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F101FAEF2;
	Tue, 15 Oct 2024 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE+V9sNL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6471F80DD;
	Tue, 15 Oct 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025799; cv=none; b=SUaevF5Y4qggH9myAQKKTHiS82IO/5LnSTeTqhjWvNSrIAZl3DwmoQkdPne0gDX8O5vNuhyDoyQsfyfmz/X2CpSXvH2EbdBoorSZj0UTqjxP19apm9j+SjWaBJ2iADCQHD4dEnEH+lyU8hxbcWa4Q5+I1a1UUvH+I96pAz93Muo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025799; c=relaxed/simple;
	bh=COqA3y5JKsekq6nOGaTnmPFsD3u1LocTUoESaQBM8sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4foG6lhWATO2dFFSqchIOli/lUe+LKB+y+Wc6mdsYWMBLj1tS2ypiQGPNCSZ2WYam8su8yv7OshNDdbmKKkVp9UJCGRWtfyo8vU4yGQyysYsQV+4JlL5LsqFEMbR6fhOmyYivlDq2aephDaw8vooLrkUmvTYLFaRAKzyYyiTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE+V9sNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABD2C4CEC6;
	Tue, 15 Oct 2024 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729025799;
	bh=COqA3y5JKsekq6nOGaTnmPFsD3u1LocTUoESaQBM8sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GE+V9sNL2uXDEmkps1B1aP3XL4XRdAvgkdl6+dVVrgBTD86ZOcCDbnCVeap08q/YQ
	 k4DC6jXcdJNPVf1hcovW8aCrrMVcZ9tHRanzyFOyir49CnmDdTSkU59z9FzAzDqL6l
	 5bcsIoBWxv5cz/m4GxRcA6sOYLUm1fpVIiYj4m8kdH9+q3b01Mk++qKHPopHrqHzDa
	 SjN3JMCP6IyIba7mKmhNig2Ld0kQaCszIcoZYggjHtIfMB77ZKosr3vgpogLO/Lrwm
	 pzX85fYZb3Rp+lrZJgE7DYngOmlSCf9qxFtpPLbUo5/6qkhPZOeNoYGyFGMaJ8ytPy
	 KPQ/Z9FLG7wCw==
Date: Tue, 15 Oct 2024 15:56:37 -0500
From: Rob Herring <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	ChiYuan Huang <cy_huang@richtek.com>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	Fabien Parent <fparent@baylibre.com>,
	Simon Sun <simon.sun@yunjingtech.com>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
Message-ID: <20241015205637.GB1934266-robh@kernel.org>
References: <20241015103337.20479-1-macpaul.lin@mediatek.com>
 <20241015103337.20479-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015103337.20479-2-macpaul.lin@mediatek.com>

On Tue, Oct 15, 2024 at 06:33:37PM +0800, Macpaul Lin wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
> configuration for TCPC Port, USB-C connector, and related settings.
> 
> Configure dual role switch capability, set up PD (Power Delivery) profiles,
> and establish endpoints for SSUSB (SuperSpeed USB).
> 
> Update pinctrl configurations for U3 P0 VBus default pins and set dr_mode
> to "otg" for OTG (On-The-Go) mode operation.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../dts/mediatek/mt8395-genio-1200-evk.dts    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> index 5f16fb820580..b91a46f4a702 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> @@ -249,6 +249,39 @@ mt6360: pmic@34 {
>  		#interrupt-cells = <1>;
>  		pinctrl-0 = <&mt6360_pins>;
>  
> +		tcpc {
> +			compatible = "mediatek,mt6360-tcpc";
> +			interrupts-extended = <&pio 17 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names = "PD_IRQB";
> +
> +			connector {
> +				compatible = "usb-c-connector";
> +				label = "USB-C";
> +				data-role = "dual";
> +				power-role = "dual";
> +				try-power-role = "sink";
> +				source-pdos = <PDO_FIXED(5000, 1000, \
> +					       PDO_FIXED_DUAL_ROLE | \
> +					       PDO_FIXED_DATA_SWAP)>;
> +				sink-pdos = <PDO_FIXED(5000, 2000, \
> +					     PDO_FIXED_DUAL_ROLE | \
> +					     PDO_FIXED_DATA_SWAP)>;
> +				op-sink-microwatt = <10000000>;
> +			};
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					mt6360_ssusb_ep: endpoint {
> +						remote-endpoint = <&ssusb_ep>;

No, this is wrong. This should go to 'port@1' in the connector node. 
That is the SS connection.

Rob

