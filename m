Return-Path: <linux-kernel+bounces-378367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17469ACEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CF01F22211
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECC1CB31C;
	Wed, 23 Oct 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TrIQgpRn"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8C3A1DA;
	Wed, 23 Oct 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697950; cv=none; b=uMtybDm0w1On1uH+oQuV3/m84yv20mBohVHxCCU+coohYn+3zMRn7Menc0JVHiDlWRfw+dtQl3X95tGpsa0jtAXRbijjvCe+Jp+n9Q92ZMoyuGmIA5k64GiC9EgItNqn0/T/UJNcbaVXio+zH3o5HghjFE487orD5sogBtI1MGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697950; c=relaxed/simple;
	bh=NBxhE82kCl2yKOP+vUIKC/W8t8kh6uIpI0gB+20aSEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bM69c69KfqO4OuvMTqv8cxdwGlHAK2scriU5LfGojSZzy56o0/H3y1uTevwuf0CJ/Vg6NnBN03dHluVgu+v3wK0yYS7Pd8ggCZ0cMLIVt2waKV8ryxfXi5bZn8bz47riu7qt7hs2QDNqbYHEgHF7E8E8NOYqE8sfCg4+U1EKHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TrIQgpRn; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NFd1Ws067669;
	Wed, 23 Oct 2024 10:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729697941;
	bh=OuQA09gyI4WukFo0h7kDvUI5cJRKjUfhIF1isfAvFEI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TrIQgpRnEwdf6ZBsIBTODFe9PxqDiNNJY0S9AlzfrSO4P8275hP5PYfPN0HvhMWQ1
	 coPSMaLVX6E5y1g1C7WDpSSiXydS1XB2RqwpkmymtNe4OONGL5tjGzPo+DpaORlAdJ
	 vzrBDpcyBN8CvGsi1n5kikUXj0qtd337uuISH+K4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49NFd1Ke129217
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 10:39:01 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 10:39:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 10:39:00 -0500
Received: from [172.24.227.91] (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NFcuS4104759;
	Wed, 23 Oct 2024 10:38:57 -0500
Message-ID: <47441421-23d4-42a9-b080-21f7c9314fa6@ti.com>
Date: Wed, 23 Oct 2024 21:08:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup:
 Remove parent nodes bootph-*
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Udit
 Kumar <u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>
References: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
 <20241023-b4-upstream-bootph-all-v5-2-a974d06370ab@ti.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-2-a974d06370ab@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 23/10/24 12:27, Manorit Chawdhry wrote:
> Adding bootph properties on leaf nodes imply that they are applicable to
> the parent nodes as well. Bootloaders can derive the parent nodes when
> bootph is available in the leaf nodes.
> 
> Remove the bootph-* properties from parent nodes as they are redundant.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

> ---
> 
> Notes:
>      It wasn't existing previously in U-boot but the following patch fixes it [0]
>      
>      [0]: https://lore.kernel.org/u-boot/20231217163627.2339802-10-sjg@chromium.org/
> 
>   arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
> index 9899da73a905..46bc2a3e4aea 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
> @@ -7,7 +7,6 @@
>   
>   &cbass_mcu_wakeup {
>   	sms: system-controller@44083000 {
> -		bootph-all;
>   		compatible = "ti,k2g-sci";
>   		ti,host-id = <12>;
>   
> @@ -39,7 +38,6 @@ k3_reset: reset-controller {
>   	};
>   
>   	wkup_conf: bus@43000000 {
> -		bootph-all;
>   		compatible = "simple-bus";
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> @@ -458,7 +456,6 @@ mcu_spi2: spi@40320000 {
>   	};
>   
>   	mcu_navss: bus@28380000 {
> -		bootph-all;
>   		compatible = "simple-bus";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> 

