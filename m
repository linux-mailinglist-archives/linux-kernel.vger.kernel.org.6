Return-Path: <linux-kernel+bounces-276434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F54949396
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3161F250CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E3A1E675B;
	Tue,  6 Aug 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hX6L01r7"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E31D618A;
	Tue,  6 Aug 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955675; cv=none; b=k0ow91lUp23nbOX5Q5WM5egLKPksHzq5jB9QaTxhvWXuu5MvCXqqLZqxUtQRWoW1HxPamDZjIF1Docpx17QVaC13TRlTFxCndVcHU2t8uLaFTNlIgxyzUoX+DJHk6UCdnQ5du1zXvKJGi2rgEnWNF7h/VgjkLWd+rWnjCDCifYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955675; c=relaxed/simple;
	bh=OOjXLBz8njaKfaJdQh4e02mCjySkiFDF4HMnCVRrzl0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9n9qFSONCZ6nhtks+8libcSpzBl99CeaMcEZBVpvh/mSM4L6gKB3ek7pzBOWNssQ5kukn3RyGXl5HurPRv2OM0yZaVJkFdzKOUSZB5YxHlfOISVhmCMgYzqloO0mReApn2rkBrh9h+cm9SjyADjBQTfX+/aIKILVZxwJLxDbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hX6L01r7; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476EljDk016151;
	Tue, 6 Aug 2024 09:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722955665;
	bh=F6xJ1vugvPMi1ZliOEmRpFNCkLfVTJ4H7brEsMVHfaU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hX6L01r756YEV2FoXC+rW6q/8dDs/c7EQT+6NVor4kRtiHcijuTM2SQqf8dq5arAr
	 56CLeGWFT4VgRBcVUaeV2ZLD3jSSOH/h8Bwbl6UHJknlAwlQZW+QWAh7mVxmvN00w9
	 7GUP8pG9G6EndXVrBDpxosWFgwwR4iNUpPcLIqHc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476Eljfk023857
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 09:47:45 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 09:47:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 09:47:45 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476EljAL070726;
	Tue, 6 Aug 2024 09:47:45 -0500
Date: Tue, 6 Aug 2024 09:47:45 -0500
From: Nishanth Menon <nm@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d.schultz@phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: am642-phyboard-electra: Add PRU-ICSSG
 nodes
Message-ID: <20240806144745.s3ga45pkgfuovjg6@henna>
References: <20240709101205.891587-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240709101205.891587-1-w.egorov@phytec.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:12-20240709, Wadim Egorov wrote:
> The phyBOARD-Electra implements two Ethernet ports utilizing PRUs.
> Add configuration for both mac ports & PHYs.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> index 6df331ccb970..364a7582cf99 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> @@ -28,6 +28,8 @@ / {
>  	model = "PHYTEC phyBOARD-Electra-AM64x RDK";
>  
>  	aliases {
> +		ethernet1 = &icssg0_emac0;
> +		ethernet2 = &icssg0_emac1;
>  		mmc1 = &sdhci1;
>  		serial2 = &main_uart0;
>  		serial3 = &main_uart1;
> @@ -55,6 +57,73 @@ can_tc2: can-phy1 {
>  		standby-gpios = <&main_gpio0 35 GPIO_ACTIVE_HIGH>;
>  	};
>  
> +	/* Dual Ethernet application node on PRU-ICSSG0 */
> +	ethernet {
> +		compatible = "ti,am642-icssg-prueth";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&icssg0_rgmii1_pins_default &icssg0_rgmii2_pins_default>;

&icssg0_rgmii1_pins_default>, <&icssg0_rgmii2_pins_default>

> +
> +		sram = <&oc_sram>;
> +		ti,prus = <&pru0_0>, <&rtu0_0>, <&tx_pru0_0>, <&pru0_1>, <&rtu0_1>, <&tx_pru0_1>;

here and elsewhere, follow
	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

	[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

