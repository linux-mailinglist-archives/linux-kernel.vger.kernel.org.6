Return-Path: <linux-kernel+bounces-273899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2FB946F5B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B452B1C20D34
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75306A8CF;
	Sun,  4 Aug 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="R4AuMlJc"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D2E57323;
	Sun,  4 Aug 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722782786; cv=none; b=FCyUvfJ4HVyStL5RM9NxrxHsw/mqrrzOo+hWl8haV+FsSdXXFON1YavmCBnmywCCS+BJrJnmPogND9U7IywTMwKF+gyCKlzlfDYJ5vLsAXWXtD/f04x0i2JKYpq2+bYh/MNy6Jhdm5M8HsZ2Dc2/Nl17nZB26YPJRb9i4sUptA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722782786; c=relaxed/simple;
	bh=tr2hvW/r5N6TVdAKZ17CUyY3aWxwTcu2aswf6pSub4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHphtNEgGCZ0m3/vzFVnw0FOuG4sTZo/tKPEI/euMW9cGuoyYmOH4hxKfQ+oZs7ySPLPE1TK4sQUCjZ6QlaD05vd3IbS9Z7EcGGBDc7c6acTZ24D8AhwePnUUl0o4DaC3ybVe2mbOMv1FqGEQvihzSO8tCz1WLknMDGdfBp33e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=R4AuMlJc; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=2Q94fzLl3lSmFdIfJpIE1h4MlKx0ywkHDPte+ksg2FI=;
	b=R4AuMlJcBZ8UfBtIXyM2Bw2P0p6SKG9SiSYXTbCUoAx4Uznm/YB7hXx/T54ncj
	kPeOmH53nbbkTVc2XStCCqnT40Ba0qEr0p8NOeTIhknnLGj4w6n08yXI/DULNBgy
	PEiVC+3Izg70MuT4/Raqr6jpQHlb0UiBjyv5uUvjfdW1k=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCXnyCvkK9mrxa9AQ--.57464S3;
	Sun, 04 Aug 2024 22:31:13 +0800 (CST)
Date: Sun, 4 Aug 2024 22:31:11 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	Philip-Dylan <philip-dylan.gleonec@savoirfairelinux.com>
Subject: Re: [PATCH v6 6/7] arm64: dts: imx8m: update spdif sound card node
 properties
Message-ID: <Zq+QrxKFb3U1IEv/@dragon>
References: <20240627083104.123357-1-elinor.montmasson@savoirfairelinux.com>
 <20240627083104.123357-7-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627083104.123357-7-elinor.montmasson@savoirfairelinux.com>
X-CM-TRANSID:Mc8vCgCXnyCvkK9mrxa9AQ--.57464S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryfAryfAFW7Wr45XFW8WFg_yoW7JF47pa
	1vkFZ7Zr1xG3WIy345XF40v3s3Aa4rGFs09r17try8trs8Zry8twn7Krn5ur4UZr1Sqw4S
	gF1DZFy8Wrn0qaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbrcfUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQoxZWavY9tYNAAAsS

On Thu, Jun 27, 2024 at 10:31:03AM +0200, Elinor Montmasson wrote:
> The merge of imx-spdif driver into fsl-asoc-card brought
> new DT properties that can be used with the "fsl,imx-audio-spdif"
> compatible:
> * The "spdif-controller" property from imx-spdif is named "audio-cpu"
>   in fsl-asoc-card.
> * fsl-asoc-card uses codecs explicitly declared in DT
>   with "audio-codec".
>   With an S/PDIF, codec drivers spdif_transmitter and
>   spdif_receiver should be used.
>   Driver imx-spdif used instead the dummy codec and a pair of
>   boolean properties, "spdif-in" and "spdif-out".
> 
> While backward compatibility is kept to support properties
> "spdif-controller", "spdif-in" and "spdif-out", using new properties has
> several benefits:
> * "audio-cpu" and "audio-codec" are more generic names reflecting
>   that the fsl-asoc-card driver supports multiple hardware.
>   They are properties already used by devices using the
>   fsl-asoc-card driver.
>   They are also similar to properties of simple-card: "cpu" and "codec".
> * "spdif-in" and "spdif-out" imply the use of the dummy codec in the
>   driver. However, there are already two codec drivers for the S/PDIF,
>   spdif_transmitter and spdif_receiver.
>   It is better to declare S/PDIF Tx and Rx devices in a DT, and then
>   reference them with "audio-codec" than using the dummy codec.
> 
> For those reasons, this commit updates in-tree DTs to use the new
> properties:
> * Rename "spdif-controller" property to "audio-cpu".
> * Declare S/PDIF transmitter and/or receiver devices, and use them with
>   the "audio-codec" property instead of "spdif-out" and/or "spdif-in".
> 
> These modifications were tested only on an imx8mn-evk board.
> 
> Note that out-of-tree and old DTs are still supported.
> 
> Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 15 +++++++++---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 15 +++++++++---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 24 +++++++++++++++----
>  3 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index 90d1901df2b1..348855a41852 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -180,12 +180,21 @@ cpu {
>  		};
>  	};
>  
> +	spdif_out: spdif-out {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";

It's recommended that the property list begins with 'compatible'.  Could
you flip them?

Shawn

> +	};
> +
> +	spdif_in: spdif-in {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dir";
> +	};
> +
>  	sound-spdif {
>  		compatible = "fsl,imx-audio-spdif";
>  		model = "imx-spdif";
> -		spdif-controller = <&spdif1>;
> -		spdif-out;
> -		spdif-in;
> +		audio-cpu = <&spdif1>;
> +		audio-codec = <&spdif_out>, <&spdif_in>;
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index 9e0259ddf4bc..6a47e09703a7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> @@ -124,12 +124,21 @@ sound-wm8524 {
>  			"Line Out Jack", "LINEVOUTR";
>  	};
>  
> +	spdif_out: spdif-out {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";
> +	};
> +
> +	spdif_in: spdif-in {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dir";
> +	};
> +
>  	sound-spdif {
>  		compatible = "fsl,imx-audio-spdif";
>  		model = "imx-spdif";
> -		spdif-controller = <&spdif1>;
> -		spdif-out;
> -		spdif-in;
> +		audio-cpu = <&spdif1>;
> +		audio-codec = <&spdif_out>, <&spdif_in>;
>  	};
>  
>  	sound-micfil {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 7507548cdb16..b953865f0b46 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -125,19 +125,33 @@ link_codec: simple-audio-card,codec {
>  		};
>  	};
>  
> +	spdif_out: spdif-out {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";
> +	};
> +
> +	spdif_in: spdif-in {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dir";
> +	};
> +
>  	sound-spdif {
>  		compatible = "fsl,imx-audio-spdif";
>  		model = "imx-spdif";
> -		spdif-controller = <&spdif1>;
> -		spdif-out;
> -		spdif-in;
> +		audio-cpu = <&spdif1>;
> +		audio-codec = <&spdif_out>, <&spdif_in>;
> +	};
> +
> +	hdmi_arc_in: hdmi-arc-in {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dir";
>  	};
>  
>  	sound-hdmi-arc {
>  		compatible = "fsl,imx-audio-spdif";
>  		model = "imx-hdmi-arc";
> -		spdif-controller = <&spdif2>;
> -		spdif-in;
> +		audio-cpu = <&spdif2>;
> +		audio-codec = <&hdmi_arc_in>;
>  	};
>  };
>  
> -- 
> 2.34.1
> 


