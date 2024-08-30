Return-Path: <linux-kernel+bounces-308644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F15965FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697581C22981
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9382519259F;
	Fri, 30 Aug 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kcnm/uL6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B87173C;
	Fri, 30 Aug 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015628; cv=none; b=fIGpw+GXtzv6WEGd3mFf9UyL9vbsKSBzl1de09dGUt/GJvKEraKEAWU5fKlaBvFkZcmALamVY8umpoyW2wf1Hcc2jmacd4r7hvIJh1ZbKAMcb+mMXbQgiumvrtrB+EOwUiVfEeCAsdhmt39RXdU0XDTtBAWnwawvkHbYvhQzvzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015628; c=relaxed/simple;
	bh=3FOKTEeg0512kcdkWSBnWWhRJDALh7A+US0Aj396lvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HRoOoNiylt69hrHAyG8Ffprmn0rcCrMtoY8Yx4S1xwyUyVyTPHlI6pYvhw0wI/5oPJf8o61n7AIJymEBeEgxuVogP68jOWS86gYAcYhKGaPbfJBuHToYqomBNwvQz8W0Biq3GYOS+5JuMHW3vArb9KlkjYK5NfEko5hEHEbINO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kcnm/uL6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UB0CGE104110;
	Fri, 30 Aug 2024 06:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725015612;
	bh=CwdsOLB1r/WHgT4vLJLWYMr77VY6J1vobJDBuWvIC6g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Kcnm/uL6WE5hM1vyM+48d2g6TstrmVf71p3bKfEfkk1381I4BgKQQDZYUFnpMtr1/
	 Duu7IXH+IVIaIGW5HHkLxuaYbPB/drfoTdiN5JoSlKvLlfQbIMO4vxJ1MFq97CxmPY
	 V8uHCdNqTKr6I6FGcDKwMCLH7pNAxr1sk02reNPk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UB0COI099276
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 06:00:12 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 06:00:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 06:00:11 -0500
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UB08XC016683;
	Fri, 30 Aug 2024 06:00:09 -0500
Message-ID: <da3410c9-232a-4044-9ba1-087e8fef7549@ti.com>
Date: Fri, 30 Aug 2024 16:30:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am65: Include entire FSS region
 in ranges
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240828172956.26630-1-afd@ti.com>
 <20240828172956.26630-2-afd@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20240828172956.26630-2-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi, Andrew,

On 28/08/24 22:59, Andrew Davis wrote:
> Add FSS regions at 0x50000000, 0x400000000, and 0x600000000. Although
> not used currently by the Linux FSS driver, these regions belong to
> the FSS and should be included in the ranges mapping.
> 
> While here, a couple of these numbers had missing zeros which was
> hidden by odd alignments, fix both these issues.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi |  8 ++++----
>   arch/arm64/boot/dts/ti/k3-am65.dtsi     | 12 +++++-------
>   2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 43c6118d2bf0f..1a251d13f80ab 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -292,13 +292,13 @@ fss: bus@47000000 {
>   		ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x100>, /* FSS Control */
>   			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
>   			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
> -			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* OSPI0 Memory */
> -			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
> +			 <0x0 0x50000000 0x0 0x50000000 0x0 0x10000000>, /* FSS data region 1 */
> +			 <0x4 0x00000000 0x4 0x00000000 0x4 0x00000000>; /* FSS data region 0/3 */
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
> index c59baebc5a25b..c74a0a25832cb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -69,11 +69,10 @@ cbass_main: bus@100000 {
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
> +			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>;

Suggested changes have been added, thanks!

Acked-by: Santhosh Kumar K <s-k6@ti.com>

>   
>   		cbass_mcu: bus@28380000 {
>   			compatible = "simple-bus";
> @@ -89,9 +88,8 @@ cbass_mcu: bus@28380000 {
>   				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
>   				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
>   				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI space 1 */
> -				 <0x00 0x50000000 0x00 0x50000000 0x00 0x8000000>, /*  FSS OSPI0 data region 1 */
> -				 <0x05 0x00000000 0x05 0x00000000 0x01 0x0000000>, /* FSS OSPI0 data region 3*/
> -				 <0x07 0x00000000 0x07 0x00000000 0x01 0x0000000>; /* FSS OSPI1 data region 3*/
> +				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS data region 1 */
> +				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS data region 0/3 */
>   
>   			cbass_wakeup: bus@42040000 {
>   				compatible = "simple-bus";

