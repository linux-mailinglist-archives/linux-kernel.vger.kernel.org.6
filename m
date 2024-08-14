Return-Path: <linux-kernel+bounces-286562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF518951C89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5227C28335D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE4E1B29CE;
	Wed, 14 Aug 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tPNw2PjX"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DE1AE874;
	Wed, 14 Aug 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644344; cv=none; b=rxhJb4S0X1x3jPBOh5l2yP9GBjl4IGMTvBrUhubt4YN09EM0WZoPQOpV/U4oDbB9A5CICyo7l5Ejs+4y+cy5GWnB7+CkSIhyNLfwygrOgu8DRWQOd54/luYQ/DJS00uHPHMf6LAWY0rGGS5jKigjqzcToqDpfsvnjSOcOVnYwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644344; c=relaxed/simple;
	bh=xWrDdBoR9KIKIK3gmLexA45on25zaUxo6g4vt14pnRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SCe3DZy5ma//drTcgR9Lri9hdSIPLgJb8sihFhOuhxbxdTH1eIMJsEx4bWOJsXwy8lL47KhYx1gH7EJ88QpeqE4w5W1LTFdGSCp3QuyVAtYQub/rxYW2XE8FEtVXuCTnr9QlWhLhUtLru2QEHmeNva268HveJl90Qzd8Zryzw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tPNw2PjX; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EE5ZiI118767;
	Wed, 14 Aug 2024 09:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723644335;
	bh=Pho+5c3aL6FYMaSK7tRT6r/pIvncBOkqz9wPCmBdfIQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tPNw2PjX2+dQwinivA8JRySocCBkbL0ZmxWTpye1JfM+xbK7bNWEeCjV7/hag6ysK
	 fSnx0JBB87Gq+fQujdBuyONH1pN7xKfLMSOphJw6IV/Em4TKnXh072Fc4ChcasuCGs
	 Jvcdl1I5Av+wki64gcTpAr50x3IzcLjBTgZmcMR8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EE5Z4g032313
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 09:05:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 09:05:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 09:05:34 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EE5Yj7117471;
	Wed, 14 Aug 2024 09:05:34 -0500
Message-ID: <c5c378e1-e503-43e6-a5ce-1fd53da19375@ti.com>
Date: Wed, 14 Aug 2024 09:05:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: ti: k3-am65: Add ESM nodes
To: Nishanth Menon <nm@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>,
        <devicetree@vger.kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20240813230312.3289428-1-jm@ti.com>
 <20240813230312.3289428-7-jm@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240813230312.3289428-7-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi all,

On 8/13/24 6:03 PM, Judith Mendez wrote:
> Add Error Signaling Module (ESM) instances in MCU and MAIN
> domains, set ESM interrupt sources for rti as per TRM [0] 9.4
> Interrupt Sources.
> 
> Add comments to describe what interrupt sources are routed to
> ESM modules.
> 
> [0] https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changes since v1:
> - Add patch 6/6 for am65x
> ---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++++++
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 8 ++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 1af3dedde1f67..07c9f043dac0b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -54,6 +54,14 @@ gic_its: msi-controller@1820000 {
>   		};
>   	};
>   
> +	main_esm: esm@700000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x700000 0x00 0x1000>;
> +		/* Interrupt sources: rti0, rti1, rti2, rti3 */
> +		ti,esm-pins = <224>, <225>, <226>, <227>;

I am not sure if someone knows the answer to this question, but..

I noticed that for rti, the interrupt source id's are different
for SR1 vs SR2, so which should be used here in k3-am65-main?

Here, I assumed SR2.

~ Judith


> +		bootph-pre-ram;
> +	};
> +
>   	serdes0: serdes@900000 {
>   		compatible = "ti,phy-am654-serdes";
>   		reg = <0x0 0x900000 0x0 0x2000>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 43c6118d2bf0f..e10cb9f483698 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -440,6 +440,14 @@ mcu_r5fss0_core1: r5f@41400000 {
>   		};
>   	};
>   
> +	mcu_esm: esm@40800000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x40800000 0x00 0x1000>;
> +		/* Interrupt sources: mrti0, mrti1 */
> +		ti,esm-pins = <104>, <105>;
> +		bootph-pre-ram;
> +	};
> +
>   	mcu_rti1: watchdog@40610000 {
>   		compatible = "ti,j7-rti-wdt";
>   		reg = <0x0 0x40610000 0x0 0x100>;


