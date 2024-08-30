Return-Path: <linux-kernel+bounces-309492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE457966B52
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876DB1F235C7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4F176AB6;
	Fri, 30 Aug 2024 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PUIc+SDy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D8115C153;
	Fri, 30 Aug 2024 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053657; cv=none; b=BqUOwztjOKxeLT/twePkOchAp6+NyIS2Bs57ORPMn83oImxkhLfpGlCOca3KmV3pyLM2b5CtOEYekC6xDQEZnIa2DEi6fDUYiMklFYAYbbJERBlGI2m8rtvoUo8fhRZUjwbw7LaXOwTU6BIGaQCFVH9fOCbyQJH+6ZB3FaMM6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053657; c=relaxed/simple;
	bh=6JkLzJUtUYqH168S14hpBrlJnWK/5jDaKFH7dIaPYv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yud4c6jDOclR8dFlqrMG5zIn1LY0RPTemrrSLnZoABGkfnNoDwzjWcNWSkgdjfIP5w7x20bSoUxWAXpv0v1Byq6W7m/PhAPAnsyLUmgVayW7sfNxbY3lZUbkPzbxK474h3P7vVwe4nYAZErLS1ptLpynXUNpiGupakvAtUSCDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PUIc+SDy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725053653;
	bh=6JkLzJUtUYqH168S14hpBrlJnWK/5jDaKFH7dIaPYv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUIc+SDyLrk3dIz0InmtjLeET5JiIGzd/rJ1IRjfH1V9O+k8e/UmMFIylwYkQX49A
	 u+/CYAWO5xaf2XXpgf4pX6Xbm3D42p2n66k+irK+7HjYGi1C483T2GXW+sBksym46t
	 AEbqDjrjZBg6qcPbRey6TF0HOFpJeMITR3cK4NLdjJGyDeOVK4romujn4EXCwHzC4b
	 4HZ3wTNmSCx9eFNSwgs4R20d3m9O5Tvo6MsD2BcqTfoBreQh82rNus9//yuIxjETbg
	 6XlEAKSMqjnQGLuX6Tax/4PoNkltGy9+ZSDNjMenk31IxygQGyABWxW2bMDriRSIGJ
	 OuvY1sRgQBftQ==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8E4B717E14D5;
	Fri, 30 Aug 2024 23:34:12 +0200 (CEST)
Date: Fri, 30 Aug 2024 17:34:10 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Pin-yen Lin <treapking@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Fabien Parent <fparent@baylibre.com>
Subject: Re: [RESEND PATCH v2 2/2] arm64: dts: mediatek: mt8183-pumpkin: add
 HDMI support
Message-ID: <c0597ae3-8849-4311-bab6-1c01575ec5e0@notapiano>
References: <20240819120735.1508789-1-treapking@chromium.org>
 <20240819120735.1508789-2-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819120735.1508789-2-treapking@chromium.org>

On Mon, Aug 19, 2024 at 08:05:56PM +0800, Pin-yen Lin wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> The MT8183 Pumpkin board has a micro-HDMI connector. HDMI support is
> provided by an IT66121 DPI <-> HDMI bridge.
> 
> This commit enables DPI and add the node for the IT66121 bridge.

Make it imperative [1]:

Enable the DPI and add the node for the IT66121 bridge.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

You should also add a Co-developed-by tag for yourself since you made (or will
make) changes to this commit.

> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> ---
> 
> (no changes since v1)
> 
>  .../boot/dts/mediatek/mt8183-pumpkin.dts      | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> index 1aa668c3ccf9..ecc237355b56 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
[..]
> @@ -120,6 +132,41 @@ &i2c6 {
>  	pinctrl-0 = <&i2c6_pins>;
>  	status = "okay";
>  	clock-frequency = <100000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	it66121hdmitx: hdmitx@4c {
> +		compatible = "ite,it66121";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ite_pins>;
> +		vcn33-supply = <&mt6358_vcn33_wifi_reg>;

As pointed out by lkp this label doesn't exist:
https://lore.kernel.org/all/202408200703.MYO1s3Ne-lkp@intel.com/

See 9a8014b1d4d2 ("arm64: dts: mediatek: mt6358: Merge ldo_vcn33_* regulators").

> +		vcn18-supply = <&mt6358_vcn18_reg>;
> +		vrf12-supply = <&mt6358_vrf12_reg>;
> +		reset-gpios = <&pio 160 GPIO_ACTIVE_LOW>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> +		reg = <0x4c>;

Please take a look at https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
for among other things, suggested ordering of properties in nodes. reg is
commonly the second property.

> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;

Add a blank line here.

> +				it66121_in: endpoint {
> +					bus-width = <12>;
> +					remote-endpoint = <&dpi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;

Ditto.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

