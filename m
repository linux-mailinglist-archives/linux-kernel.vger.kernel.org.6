Return-Path: <linux-kernel+bounces-305030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB3A962862
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4551C21544
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783542AB3;
	Wed, 28 Aug 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FEG8DemB"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74A187879;
	Wed, 28 Aug 2024 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850975; cv=none; b=NN3GvYyECu9VNnLNGplI8gp4a5LHZruPJRO10+ZzLvO3sN1smN8PdInnA1/ceUcEE1wPkSyq8DmRMB/wZqeDhtMkcyu9CdPCWMNioBYaTb9DCH5g/0s95nsChqGz0NF6iHAfAgfxWLkNQe224YetEflLv/PFqQI/3RXNWjoaHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850975; c=relaxed/simple;
	bh=CWMRrg0fpXSHKvZd6iQ8hN4f+VD4Vq1DmXea/9FSv28=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTwAhwrLqEd4ZnqIu0SiXs/0X68l75PVNOFOp+1sv54/rbcZN0Uycb3+0/V3yXvook87B3gg0Ttelg5S0pC8+kIKSBfau+08seQccSqkZSIAflx3GIkMI1RoJ3vXo0GKNZwzgv5r7ahPWqsNpyF+uzYquRK96+iHp6mEnuYR9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FEG8DemB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SDG15g012939;
	Wed, 28 Aug 2024 08:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724850961;
	bh=Hlxr3I00Om3Pz366GTjoP2TIgKieVNsjhGzKw3SeBuM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FEG8DemBzjHLo4dKVJ8U3LZn8eJgh83F6N4v9h6L3EYajos+k0eqCcizxNOtBCu3/
	 sJPpBPr79asrwPYQpybv5i5fypBs3W8nmEhLqBuXScadB+nHJhHDt1Kl94XaWYLbp4
	 BcRraFMHmkLuKOLX3w5VTbnxPVAnyhZalTIOvQww=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SDG1tj128781
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 08:16:01 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 08:16:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 08:16:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SDG1a2002345;
	Wed, 28 Aug 2024 08:16:01 -0500
Date: Wed, 28 Aug 2024 08:16:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] arm64: dts: ti: k3-am62a: add opp frequencies
Message-ID: <20240828131601.6sxvnwpcsb36tz4m@eloquent>
References: <20240826-opp-v3-0-0934f8309e13@ti.com>
 <20240826-opp-v3-1-0934f8309e13@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240826-opp-v3-1-0934f8309e13@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:22-20240826, Bryan Brattlof wrote:
> One power management technique available to the Cortex-A53s is their
> ability to dynamically scale their frequency across the device's
> Operating Performance Points (OPP)
> 
> The OPPs available for the Cortex-A53s on the AM62Ax can vary based on
> the silicon variant used. The SoC variant is encoded into the
> WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register which is used to limit
> to only OPP entries the variant supports. A table of all these variants
> can be found in it's data sheet[0] for the AM62Ax family.
> 
> Add the OPP table into the SoC's fdti file along with the syscon node to
> describe the WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register to detect
> the SoC variant.
> 
> [0] https://www.ti.com/lit/ds/symlink/am62a3.pdf
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi |  5 +++
>  arch/arm64/boot/dts/ti/k3-am62a7.dtsi       | 51 +++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> index f5ac101a04dfa..0b1dd5390cd3f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> @@ -17,6 +17,11 @@ chipid: chipid@14 {
>  			reg = <0x14 0x4>;
>  		};
>  
> +		opp_efuse_table: syscon@18 {
> +			compatible = "ti,am62-opp-efuse-table", "syscon";
> +			reg = <0x18 0x4>;

Does this really work??

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/ti-cpufreq.c#n309
	efuse_offset is 0x0 -> OK.. BUT,
	.rev_offset = 0x0014 from a syscon which is one register wide???

Seems like you have been sidetracked by:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/ti-cpufreq.c#n384
bug to read some omap register offset?

This is probably not getting exposed due to the syscon bug that I just
fixed: https://lore.kernel.org/r/20240828121008.3066002-1-nm@ti.com

I just have to NAK this series while you folks figure out how to do this
properly.

> +		};
> +
>  		cpsw_mac_syscon: ethernet-mac-syscon@200 {
>  			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
>  			reg = <0x200 0x8>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
> index f86a23404e6dd..6c99221beb6bd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
> @@ -48,6 +48,8 @@ cpu0: cpu@0 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
> +			clocks = <&k3_clks 135 0>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -62,6 +64,8 @@ cpu1: cpu@1 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
> +			clocks = <&k3_clks 136 0>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -76,6 +80,8 @@ cpu2: cpu@2 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
> +			clocks = <&k3_clks 137 0>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -90,6 +96,51 @@ cpu3: cpu@3 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
> +			clocks = <&k3_clks 138 0>;
> +		};
> +	};
> +
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
>  		};
>  	};
>  
> 
> -- 
> 2.46.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

