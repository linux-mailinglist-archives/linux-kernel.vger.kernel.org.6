Return-Path: <linux-kernel+bounces-304858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EEB9625E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065BA1F22E21
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D7016EB50;
	Wed, 28 Aug 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MQPKftsU"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C816D311;
	Wed, 28 Aug 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844100; cv=none; b=minB4LnoselJSLqyorcI0udteqHcBtsQb0B+pde0M8azN8am+y5YPUZ49ONvoxN1wpai+QBUQz75Kzm9yfANxyl+vJffdHeyFFwhP7VA97Z5YnTg1DahGpnWaf9l7Pb8VGTBBIJ1IMQqhSwL+e9SrqhuK2MDWBPhZSfmsW3JLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844100; c=relaxed/simple;
	bh=51tb8s0IoRJObVmawELtdlwFdT/v5aeDyFLfe5NyWVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AgNlrY3+tpZOIM5x+ovX5MUI0yWlyE7UiWGJO87x6VGBJ+dcODWiaIaN27I671ChntWOXlw5S5Vt+twdsSnY5Th5HQb0T2c0qVXTfEHLVWi2BcXSTErAc9BOnLKTL6ZW2e1nx68VNcB2Nr9WNcHA9KQqvmJ6qQGQgL1Hrfszw2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MQPKftsU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SBLURm062818;
	Wed, 28 Aug 2024 06:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724844090;
	bh=xzFWpXX3dL3DQntr9YWxkl8GFz7PXCpjFoJgnAfZVXU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MQPKftsU9t6HWD5rreAwsuetRBbRfeuoG05LSQZhRZ+yRLTZNaBGXBQUpNuckmULv
	 v7n6NDhy1P6YrWq0YI71kCFcpN6QMZaTqwgpPa+EaAVVVCHH7mURIcnuxKH0QDxpet
	 0XgrT8xOdwRRtdCPQhiuJQRcpjX4hldPTlu/JSn8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SBLU0i004569
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 06:21:30 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 06:21:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 06:21:30 -0500
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SBLQqX129508;
	Wed, 28 Aug 2024 06:21:27 -0500
Message-ID: <336c415f-eeff-4220-86e0-e7a8043d6530@ti.com>
Date: Wed, 28 Aug 2024 16:51:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-am65: Include entire FSS region in
 ranges
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Humphreys <j-humphreys@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240801174941.41002-1-afd@ti.com>
 <20240801174941.41002-2-afd@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20240801174941.41002-2-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi, Andrew,

Thanks for the series!

On 01/08/24 23:19, Andrew Davis wrote:
> Add FSS regions at 0x50000000, 0x400000000, and 0x600000000. Although
> not used currently by the Linux FSS driver, these regions belong to
> the FSS and should be included in the ranges mapping.
> 
> While here, a couple of these numbers had missing zeros which was
> hidden by odd alignments, fix both these issues.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi |  8 ++++----
>   arch/arm64/boot/dts/ti/k3-am65.dtsi     | 13 ++++++-------
>   2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 43c6118d2bf0f..5948ab3b50fc2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -292,13 +292,13 @@ fss: bus@47000000 {
>   		ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x100>, /* FSS Control */
>   			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
>   			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
> -			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* OSPI0 Memory */
> -			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
> +			 <0x0 0x50000000 0x0 0x50000000 0x0 0x10000000>, /* OSPI0/1 Memory 1 */
> +			 <0x4 0x00000000 0x4 0x00000000 0x4 0x00000000>; /* OSPI0/1 Memory 0/3 */
>   
>   		ospi0: spi@47040000 {
>   			compatible = "ti,am654-ospi", "cdns,qspi-nor";
>   			reg = <0x0 0x47040000 0x0 0x100>,
> -				<0x5 0x00000000 0x1 0x0000000>;
> +			      <0x5 0x00000000 0x1 0x00000000>;
>   			interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>;
>   			cdns,fifo-depth = <256>;
>   			cdns,fifo-width = <4>;
> @@ -316,7 +316,7 @@ ospi0: spi@47040000 {
>   		ospi1: spi@47050000 {
>   			compatible = "ti,am654-ospi", "cdns,qspi-nor";
>   			reg = <0x0 0x47050000 0x0 0x100>,
> -				<0x7 0x00000000 0x1 0x00000000>;
> +			      <0x7 0x00000000 0x1 0x00000000>;
>   			interrupts = <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
>   			cdns,fifo-depth = <256>;
>   			cdns,fifo-width = <4>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index c59baebc5a25b..5b8cbdd6942e7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -69,11 +69,11 @@ cbass_main: bus@100000 {
>   			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
>   			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
>   			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
> -			 <0x00 0x50000000 0x00 0x50000000 0x00 0x8000000>,
> +			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
>   			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A53 PERIPHBASE */
> -			 <0x00 0x70000000 0x00 0x70000000 0x00 0x200000>,
> -			 <0x05 0x00000000 0x05 0x00000000 0x01 0x0000000>,
> -			 <0x07 0x00000000 0x07 0x00000000 0x01 0x0000000>;
> +			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00200000>,
> +			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
> +			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;

The changes you made to merge the 'FSS Data Region' range in 'cbass_mcu' 
node is not reflected here. Can you please add those changes here, so 
that the ranges looks consistent throughout.

Apart from this, the series LGTM!

Reviewed-by: Santhosh Kumar K <s-k6@ti.com>

>   
>   		cbass_mcu: bus@28380000 {
>   			compatible = "simple-bus";
> @@ -89,9 +89,8 @@ cbass_mcu: bus@28380000 {
>   				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
>   				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
>   				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI space 1 */
> -				 <0x00 0x50000000 0x00 0x50000000 0x00 0x8000000>, /*  FSS OSPI0 data region 1 */
> -				 <0x05 0x00000000 0x05 0x00000000 0x01 0x0000000>, /* FSS OSPI0 data region 3*/
> -				 <0x07 0x00000000 0x07 0x00000000 0x01 0x0000000>; /* FSS OSPI1 data region 3*/
> +				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS Data Region 1 */
> +				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS Data Region 0/3 */
>   
>   			cbass_wakeup: bus@42040000 {
>   				compatible = "simple-bus";

