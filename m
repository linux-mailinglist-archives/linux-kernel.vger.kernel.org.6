Return-Path: <linux-kernel+bounces-177522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A68C401D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3FEB24309
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016D914D2B4;
	Mon, 13 May 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bj2ePlh+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EBC14EC74;
	Mon, 13 May 2024 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600968; cv=none; b=YOEdY6kg/3IHGscDxlr3yIVclXZYhFCBsRtTIU4kBUXYLlMaUMB2n99e51g8psXlJvXX+NNPGIvYZkDCW94lclXuAK/Ihf5Y8dg0qnPxpzuJZ55J7NUnBAd3LZ5xYAnfiTQ9WOD6kCoVP5WhoBFcqeB5ofaYcDJ7RQd5yOe96Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600968; c=relaxed/simple;
	bh=Q8SRBiPVnD0RtsPawn3pWdml/P6ZAB5CutaNw1zmoJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gp4qpmACszh97SPRORRS1ruV/OS7015otyN1uc5ImUhRpqkXCknPou9cnH629ZpZn8J03gCh14Ou0e9IxaQcYO7NE004zBb5SUKW/1XLg1jAS4hjhnWyVuP4U/3n9At9fIDY/U9nbWd5TlQhzChZcZ1Ag/mhvHq0gRZ55MeCkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bj2ePlh+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44DBnLM8000872;
	Mon, 13 May 2024 06:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715600961;
	bh=j5+SPj/im+qkgkiZreOqeuGMoxAMv/SmMapvWxtjZ8U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Bj2ePlh+AGKrUGNIt2C0oMwJgy5VZMx+CrCSMQ/F9J6SP8OUQvhws/aooIXgqcNxV
	 nl6/A4oqE79ITiTd1R+KxmxRd/RXbA1XjgXVjmJCzR/8GsW6Qov1ltgmkC9PNvRCy3
	 tqpwgiSQGLFDm6piyggs9up1dlsgQ6K7uZlWp9JI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44DBnLHH046034
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 May 2024 06:49:21 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 May 2024 06:49:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 May 2024 06:49:21 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44DBnGPS099101;
	Mon, 13 May 2024 06:49:17 -0500
Message-ID: <f29f4d5f-b23e-5729-ea51-b8995171347f@ti.com>
Date: Mon, 13 May 2024 17:19:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] arm64: dts: ti: k3-j722s-main: Add support for
 SERDES0
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <robh@kernel.org>,
        <rogerq@kernel.org>
CC: <kristo@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ravi
 Gunasekaran <r-gunasekaran@ti.com>
References: <20240513114443.16350-1-r-gunasekaran@ti.com>
 <20240513114443.16350-2-r-gunasekaran@ti.com>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240513114443.16350-2-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Roger,

On 5/13/24 5:14 PM, Ravi Gunasekaran wrote:
> AM62P's DT source files are reused for J722S inorder to
> avoid duplication of nodes. But J722S has additional
> peripherals that are not present in AM62P.
> 
> Introduce a -main.dtsi to define such additional main
> domain peripherals and define the SERDES0 node.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
> Changes since v1:
> ----------------
> * Newly introduced k3-j722s-main.dtsi to add main domain
>   peripherals that are additionally present in J722S
> 
> * Used generic node names - renamed "clock-cmnrefclk" to "clk-0",
>   "wiz@f000000" to "phy@f000000"
> 

[...]

> +
> +&cbass_main {
> +	serdes_wiz0: phy@f000000 {
> +		compatible = "ti,am64-wiz-10g";
> +		ranges = <0x0f000000 0x0 0x0f000000 0x00010000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 279 0>, <&k3_clks 279 1>, <&serdes_refclk>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> +		num-lanes = <1>;
> +		#reset-cells = <1>;
> +		#clock-cells = <1>;
> +
> +		assigned-clocks = <&k3_clks 279 1>;
> +		assigned-clock-parents = <&k3_clks 279 5>;
> +
> +		serdes0: serdes@f000000 {

[1] expects the node name to be "serdes". So I could not rename this node to "phy"
as discussed in the v1 series.

[1] - https://elixir.bootlin.com/linux/latest/source/drivers/phy/ti/phy-j721e-wiz.c#L1474

> +			compatible = "ti,j721e-serdes-10g";


[...]

-- 
Regards,
Ravi

