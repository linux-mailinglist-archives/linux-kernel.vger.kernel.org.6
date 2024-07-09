Return-Path: <linux-kernel+bounces-245318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2F92B124
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1792820D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9013FD86;
	Tue,  9 Jul 2024 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L96GDT+l"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80727713;
	Tue,  9 Jul 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510391; cv=none; b=tNapvI8NSGkRRK1QqWG5MsUWp3IWbLIvJ3/p/kCg3BIGZpIRKt7zT6uuREgjb4sR6VzFs/bt7Tm61cXoOde7YxTvkw9O+0FgKF0kSLB+CewQuD8BLaM4+nod5GVXnaSBcakmjkRds2ByrcSp++QAJJoLVHnhU0PP6RtLMpk7S5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510391; c=relaxed/simple;
	bh=gSERHO7SPM3v1RtUEbwdPvkwOWI4iQMpuHomPnu55VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ONJDP58Zfwvs6uLVJSjc8GLWq8xMW7e+QNNOrrUrrY78iQlFA+MVyOvHQS6jJD+SglTtDd+0L5K/VJQKnoRelkBgiDMiWbvVvt963X4COkuL5sv/kok8OfXQWaM8T6SnZjG8pHwaxsBeVtT9UPN08cYl2ELy6HJdtyw2d3ZH9Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L96GDT+l; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4697X126007375;
	Tue, 9 Jul 2024 02:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720510381;
	bh=KaQtpDY7no19ULV5JoJHn2GC2yJhfNsVtj20pWHAYN8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=L96GDT+lvFcjfEoXLPI4IfUbjGh5DMMsrDLmeLvRUuN9r8HO5atlje9IRwMICHt+p
	 tzOmVQhhDoN7EmrV0x6fu5pMfxXlMeg9dO8uDDwTN/DenjRIz7lH1WEGte1ySJiVra
	 CdporAngontGrPPIhT7pLXfGQs6f6jD2tXAjgJ30=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4697X1Y8037824
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 02:33:01 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jul 2024 02:33:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jul 2024 02:33:01 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4697WvvK058766;
	Tue, 9 Jul 2024 02:32:57 -0500
Message-ID: <da36d283-73f0-4110-a9fa-3964eae19689@ti.com>
Date: Tue, 9 Jul 2024 13:02:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>
References: <20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com>
 <20240705-b4-upstream-bootph-all-v2-1-9007681ed7d8@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240705-b4-upstream-bootph-all-v2-1-9007681ed7d8@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 05/07/24 11:56, Manorit Chawdhry wrote:
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 8feb42c89e47..497e0dfa8011 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -17,20 +17,24 @@ sms: system-controller@44083000 {
>  
>  		reg-names = "debug_messages";
>  		reg = <0x00 0x44083000 0x00 0x1000>;
> +		bootph-all;

Since [0] in U-Boot, bootph-* is automatically propagated to supernodes.
Please fix throughout the series

>  
>  		k3_pds: power-controller {
>  			compatible = "ti,sci-pm-domain";
>  			#power-domain-cells = <2>;
> +			bootph-all;
>  		};
>  
>  		k3_clks: clock-controller {
>  			compatible = "ti,k2g-sci-clk";
>  			#clock-cells = <2>;
> +			bootph-all;
>  		};
>  
>  		k3_reset: reset-controller {
>  			compatible = "ti,sci-reset";
>  			#reset-cells = <2>;
> +			bootph-all;
>  		};
>  	};


[0]

-- 
Regards
Vignesh

