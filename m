Return-Path: <linux-kernel+bounces-271914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A215F9454E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D10B230E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2014D6F6;
	Thu,  1 Aug 2024 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T+NLpDKQ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F014D2B3;
	Thu,  1 Aug 2024 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722554850; cv=none; b=ORYNiRpVaQnVaxoxQsfPFyZQmBFF/G1/srD8hpPqTYSBt/j2Gjz3IUXYuF3O/PF9qG0Lncs2EedYprsXf3z04rUIAmxlIKr9jaF3/VwHjFjqpi4F8xgXZOKWvNsJQROgsorP3Vtce8aFR+55UCvmcg/GVnY71KSyVPNIsTOj4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722554850; c=relaxed/simple;
	bh=bkPW/1gXJe+Xsr5hlP61agbzCFPqOX+jWstC0cB0OI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=McueIacsdjW93yemv2D2tepGZSHJkBhZrQVkmCXrFw/cPjIHKDkfB3duKxFMU08zJeGv8WhGqiPF8+a03BLcCDFm7O/VYk7m4tWdif0SGkMgRAUtV80GqqyBh4rJk/+pkoL7dGaKmoCp8TZZoYHmRJh4bjrfM1aJ0jmcP37ocNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T+NLpDKQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471NRKmq002509;
	Thu, 1 Aug 2024 18:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722554840;
	bh=R6i0cSNVEoxvCpXKMzbHjAZ6xl7SAJ9St5o6/d/I1dQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=T+NLpDKQi9roSXGei/ajf2CAiXqL+PTYT1SIHqn/cUN4YxQ3WQGx4SKFCzYVbpIdK
	 k9cZCkHKV6NMuIB4Z1FdZtgwYLeGrO0OcAEyNyGGhOyfARuPLpiKSVEYxo8oRwivbW
	 dCA6L0mPmOxvf/0dCYxCF0lsx9fQYCOqcD5Sj7LI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471NRK3i049537
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 18:27:20 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 18:27:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 18:27:20 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471NRJva039543;
	Thu, 1 Aug 2024 18:27:19 -0500
Message-ID: <69db3dff-1a69-4308-be0d-6aaa5ab708bc@ti.com>
Date: Thu, 1 Aug 2024 18:27:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j7200-som-p0: Update
 mux-controller node name
To: Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>
References: <20240729063411.1570930-1-b-kapoor@ti.com>
 <20240729063411.1570930-3-b-kapoor@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240729063411.1570930-3-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 7/29/24 1:34 AM, Bhavya Kapoor wrote:
> There are 2 mux-controller nodes in J7200 which are responsible for
> transferring can signals to the can phy but same node names for both
> the mux-controllers led to errors while setting up both mux-controllers
> for can phys simultaneously.
> Thus, update node names for these mux-controller.
> 
> Fixes: da23e8d1124b ("arm64: dts: ti: k3-j7200-som-p0: Add support for CAN instance 0 in main domain")
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>

Reviewed-by: Judith Mendez <jm@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index 21fe194a5766..89b68325e4e2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -84,13 +84,13 @@ rtos_ipc_memory_region: ipc-memories@a4000000 {
>   		};
>   	};
>   
> -	mux0: mux-controller {
> +	mux0: mux-controller-0 {
>   		compatible = "gpio-mux";
>   		#mux-state-cells = <1>;
>   		mux-gpios = <&exp_som 1 GPIO_ACTIVE_HIGH>;
>   	};
>   
> -	mux1: mux-controller {
> +	mux1: mux-controller-1 {
>   		compatible = "gpio-mux";
>   		#mux-state-cells = <1>;
>   		mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;


