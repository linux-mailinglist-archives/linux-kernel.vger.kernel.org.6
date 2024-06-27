Return-Path: <linux-kernel+bounces-232327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9557191A6DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00254B26C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADBA178CC5;
	Thu, 27 Jun 2024 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oZTQEG9G"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DDD1779A5;
	Thu, 27 Jun 2024 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492516; cv=none; b=Z++QNLp1ANmdcsPIsTkJTUqb/WwqoErL+MN8RRGLtrjZENUk9stji4lZai2OI0YuFU84QHHbxZptUM8EccD1rFch0B9NYB/keLnuXaQF9qZKhQW/IMefsTcjuKrQ/a+sikSgrvxMr8Fh6QuZgsSitJxeeQrYr+kpCCZIGbg83YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492516; c=relaxed/simple;
	bh=JETtaRuEUowWC6vgDm2t3scWyjq6v8RDHmiY2XWoeg0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQBXbhjYp24KY7NNDwFfrR8Y4gTtnM7WKYT5NgvcdN59O8yzULxnPtq8rbpwKSr8nYSsoWtXV31ClKMM8GN3LYHtrG0dcsTY/6LRGOWdTN0Za/ZHKu8VLBm5O+LSgJVxhWmVmuJZAdrzWH88RJLm/EdskHFFcwC6UL5lM6QFVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oZTQEG9G; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RCmOJ8110647;
	Thu, 27 Jun 2024 07:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719492504;
	bh=pcej8nfKdz22O9Y3h8uowdORdYOjVRWnOowYKkgq97k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=oZTQEG9G6Mmhwsc9lvQ5ZBxGhrMnRFH0JI1uWo7HHbm/2vMfiK6Xdl7dKNTxXsngL
	 BzoPq+otDaBvTCyTcTs9PuixaZz/E853A3JmcN4Hte1Z6kYJxgJWftZFVu6RoEf/FM
	 eH7IXoMRILKBkePbT3W5pg/mCHJUlbPqcI5zS4gc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RCmOed104575
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 07:48:24 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 07:48:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 07:48:24 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RCmO50033516;
	Thu, 27 Jun 2024 07:48:24 -0500
Date: Thu, 27 Jun 2024 07:48:24 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <srk@ti.com>, <praneeth@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: dts: k3-am642-evm-nand: Add bootph-all to NAND
 related nodes
Message-ID: <20240627124824.u3pxw5upk72uwvak@murmuring>
References: <20240623-am642-evm-nand-bootph-v1-1-dc3af37a3322@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240623-am642-evm-nand-bootph-v1-1-dc3af37a3322@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:24-20240623, Roger Quadros wrote:
> NAND boot would require these nodes to be present at early stage.
> Ensure that by adding "bootph-all" to relevant nodes.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
> index dc70b6fbc3d7..babd681666f4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
> @@ -13,6 +13,7 @@
>  
>  &main_pmx0 {
>  	gpmc0_pins_default: gpmc0-pins-default {
> +		bootph-all;
>  		pinctrl-single,pins = <
>  			AM64X_IOPAD(0x0094, PIN_INPUT, 7) /* (T19) GPMC0_BE1n.GPIO0_36 */
>  			AM64X_IOPAD(0x003c, PIN_INPUT, 0) /* (T20) GPMC0_AD0 */
> @@ -49,7 +50,9 @@ AM64X_IOPAD(0x00a4, PIN_OUTPUT, 0) /* (N17) GPMC0_DIR */
>  };
>  
>  &main_gpio0 {
> +	bootph-all;
>  	gpio0-36 {
> +		bootph-all;
>  		gpio-hog;
>  		gpios = <36 0>;
>  		input;
> @@ -58,10 +61,12 @@ gpio0-36 {
>  };
>  
>  &elm0 {
> +	bootph-all;
>  	status = "okay";
>  };
>  
>  &gpmc0 {
> +	bootph-all;

NAK. please add bootph property ONLY to leaf nodes.

>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&gpmc0_pins_default>;
> @@ -69,6 +74,7 @@ &gpmc0 {
>  	#size-cells = <1>;
>  
>  	nand@0,0 {
> +		bootph-all;
>  		compatible = "ti,am64-nand";
>  		reg = <0 0 64>;		/* device IO registers */
>  		interrupt-parent = <&gpmc0>;
> 
> ---
> base-commit: 4031a2866a9f0f5c585cfee65b3fb5ab17c95276
> change-id: 20240623-am642-evm-nand-bootph-03b68b4c9d9e
> 
> Best regards,
> -- 
> Roger Quadros <rogerq@kernel.org>
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

