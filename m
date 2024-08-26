Return-Path: <linux-kernel+bounces-301579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E532595F2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528ACB20D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9545185943;
	Mon, 26 Aug 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TdV4VBs1"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066F2C95;
	Mon, 26 Aug 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678604; cv=none; b=h4lQ0dIVzykSuT+FtXD3OOLrfxDOohX9rOyZcL8icMUsr5rdFa/4Witr6kouytY0sUWNKz15EQlmSf8+J20rZrwVhhigP+09KrY8FLxkgA5iQq4fppBBQlOL26ZTz11jt5qliXRhED4zKC/O9pxMRHABQO5x8AdnPBtgPrJnDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678604; c=relaxed/simple;
	bh=GbV+WAfO3JB6oghcXvIU5S0StFkQzn46kXQWFa4f63Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBrdx/QPFt8SWV3V4B7Rh76iIuVOGYOoDPkoM/SJd6Xwz78yp6EpnPyzfP6S0U5HwGksJQWfu5CR8RBPuI2InRqRHIPHTfCIu/SPD45wM1J9HGben9llz6zWBQYJZ35ATbOA5MTzG498Z5qw+Zu2j6+Eq97I8OsxMmn9YlreMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TdV4VBs1; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QDNDDZ011649;
	Mon, 26 Aug 2024 08:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724678593;
	bh=aOnuZ4gIbxyKADOVNuvc7Mf4s0W7nDrMfwLmmTs1qtc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=TdV4VBs1D9gViXRIdiehBbAZ92dC4so7Jo0tI4xL1J8JbFt9znRnk6d/Gev0GzgZm
	 yCWGAcRAj+a1Qt3Bqu0rDw83GHshdF9HfmIeW3YrzYAhHp4e8K3xNRDJFD+wIOcLzQ
	 qaZAOTu/alrK2LB+oZoBiR4wGPZbp0TawQwZmC2o=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QDNDZ2124974
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 08:23:13 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 08:23:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 08:23:12 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QDNCLP106421;
	Mon, 26 Aug 2024 08:23:12 -0500
Date: Mon, 26 Aug 2024 18:53:11 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: ti: k3-am62p: add opp frequencies
Message-ID: <20240826132311.igliqicrydtifp2s@lcpd911>
References: <20240823-opp-v2-0-e2f67b37c299@ti.com>
 <20240823-opp-v2-3-e2f67b37c299@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240823-opp-v2-3-e2f67b37c299@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bryan,

On Aug 23, 2024 at 16:54:30 -0500, Bryan Brattlof wrote:
> ONe power management technique available to the Cortex-A53s is their

s/ONe/One

> ability to dynamically scale their frequency across the device's
> Operating Performance Points (OPP)
> 
> The OPPs available for the Cortex-A53s on the AM62Px can vary based on
> the silicon variant used. The SoC variant is encoded into the
> WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register which is used to limit
> the OPP entries the SoC supports. A table of all these variants can be
> found in its data sheet[0] for the AM62Px processor family.

Error 404! Not found [0] ;)

> 
> Add the OPP table into the SoC's ftdi file along with the syscon node to

What is ftdi?

> describe the WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register to detect
> the SoC variant.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 +++
>  arch/arm64/boot/dts/ti/k3-am62p5.dtsi              | 47 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> index 315d0092e7366..6f32135f00a55 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> @@ -20,6 +20,11 @@ chipid: chipid@14 {
>  			bootph-all;
>  		};
>  
> +		opp_efuse_table: syscon@18 {
> +			compatible = "ti,am62-opp-efuse-table", "syscon";

Huh, curious why I don't see this particular compatible in am62 itself..
Also, I am still not clear where this discussion got left off: (If it's
related)
https://lore.kernel.org/all/5chxjwybmsxq73pagtlw4zr2asbtxov7ezrpn5j37cr77bmepa@fejdlxomfgae/

In AM625, I see
k3-am625.dtsi:111: col 14: syscon = <&wkup_conf>;

But the approach you've used here seems different. Is there a
justification given on which one should be used/why somewhere that I can
refer?

> +			reg = <0x18 0x4>;
> +		};
> +
>  		cpsw_mac_syscon: ethernet-mac-syscon@200 {
>  			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
>  			reg = <0x200 0x8>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> index 41f479dca4555..140587d02e88e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> @@ -47,6 +47,7 @@ cpu0: cpu@0 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&l2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
>  			clocks = <&k3_clks 135 0>;
>  		};
>  
> @@ -62,6 +63,7 @@ cpu1: cpu@1 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&l2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
>  			clocks = <&k3_clks 136 0>;
>  		};
>  
> @@ -77,6 +79,7 @@ cpu2: cpu@2 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&l2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
>  			clocks = <&k3_clks 137 0>;
>  		};
>  
> @@ -92,10 +95,54 @@ cpu3: cpu@3 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&l2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
>  			clocks = <&k3_clks 138 0>;
>  		};
>  	};
>  
> +	a53_opp_table: opp-table {
> +		compatible = "operating-points-v2-ti-cpu";
> +		opp-shared;
> +		syscon = <&opp_efuse_table>;
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-supported-hw = <0x01 0x0006>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-1250000000 {
> +			opp-hz = /bits/ 64 <1250000000>;
> +			opp-supported-hw = <0x01 0x0004>;
> +			clock-latency-ns = <6000000>;
> +			opp-suspend;
> +		};
> +	};
> +

-- 
Best regards,
Dhruva

