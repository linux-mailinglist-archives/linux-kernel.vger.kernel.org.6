Return-Path: <linux-kernel+bounces-355037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF799464C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80D3B22AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5181D094B;
	Tue,  8 Oct 2024 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DeqEEctK"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91C16FF2A;
	Tue,  8 Oct 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385947; cv=none; b=qd6td5D197lBcI+pv7lG9x5/BAlpwUYQpNuQg92+4R/1RGGSVNLHL8iu1XKZYv9OYTA/uZotaLW+keogLfKFzzzqmcpA5Q6kx1a0GVbLKTpktFFo4GUrw0t0YPCOfP09NCfvqW0vdI9o656ksCUMAX7E26haTYrw5pbTFREW0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385947; c=relaxed/simple;
	bh=3T5gumFYtWt9UscSLgj+TkRypVkU2q5vWbwQZBEgr7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OI2ZJK5lamHPR0ith2/rpBAuVjnbRC7F2rtVnYyl7kq0UaIzXNHI3e0s9JTanFAhbhKkO7Xca9XboJUC7kpHd/oRZWfCeeJVy6SUZYKlgVz72U+bxT9ozJK2y4axOpw12cAhs5d8UrXR9V67XOQBRQp+JepB1tStRSlKXWr+Ka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DeqEEctK; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 498BC6FE108699;
	Tue, 8 Oct 2024 06:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728385926;
	bh=VDFWXMl2aCJutFVdh13RSnu4NjcswFFV8lBqiNDhU1o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DeqEEctKrZTGQOCWeCO4ZGnOUKJATRLG1shIW3oIH3h/OAZCX2jxo7izCj1Qzp3iO
	 EWdNeTccKKth/ElSsTtvYPmtGTCS4j5GsyfVkEqGoaZZngx7S2CUtC2NrIzlUH2afP
	 I/a8USFK85cSWKbSIWmWA+087xNURdhnTiB8NS5o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 498BC6UQ026906
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Oct 2024 06:12:06 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Oct 2024 06:12:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Oct 2024 06:12:05 -0500
Received: from [10.249.128.176] ([10.249.128.176])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 498BC2tE082826;
	Tue, 8 Oct 2024 06:12:03 -0500
Message-ID: <b8598c92-b511-4e83-ac21-717ffc915d31@ti.com>
Date: Tue, 8 Oct 2024 16:42:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Update otap/itap values
To: Judith Mendez <jm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth
 Menon <nm@ti.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240924195335.546900-1-jm@ti.com>
Content-Language: en-US
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20240924195335.546900-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Looks good to me !

On 25/09/24 01:23, Judith Mendez wrote:
> Update itap/itap values according to device datasheet [0].
>
> Now that we have fixed timing issues for am62x [1], lets
> change the otap/itap values back according to the device
> datasheet.
>
> [0] https://www.ti.com/lit/ds/symlink/am625.pdf
> [1] https://lore.kernel.org/linux-mmc/20240913185403.1339115-1-jm@ti.com/
>
> Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Bhavya Kapoor<b-kapoor@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 47 ++++++++++++------------
>   1 file changed, 23 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 5b92aef5b284..7194603fd3bc 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -561,10 +561,9 @@ sdhci0: mmc@fa10000 {
>   		ti,clkbuf-sel = <0x7>;
>   		ti,otap-del-sel-legacy = <0x0>;
>   		ti,otap-del-sel-mmc-hs = <0x0>;
> -		ti,otap-del-sel-ddr52 = <0x5>;
> -		ti,otap-del-sel-hs200 = <0x5>;
> -		ti,itap-del-sel-legacy = <0xa>;
> -		ti,itap-del-sel-mmc-hs = <0x1>;
> +		ti,otap-del-sel-hs200 = <0x6>;
> +		ti,itap-del-sel-legacy = <0x0>;
> +		ti,itap-del-sel-mmc-hs = <0x0>;
>   		status = "disabled";
>   	};
>   
> @@ -577,17 +576,17 @@ sdhci1: mmc@fa00000 {
>   		clock-names = "clk_ahb", "clk_xin";
>   		bus-width = <4>;
>   		ti,clkbuf-sel = <0x7>;
> -		ti,otap-del-sel-legacy = <0x8>;
> +		ti,otap-del-sel-legacy = <0x0>;
>   		ti,otap-del-sel-sd-hs = <0x0>;
> -		ti,otap-del-sel-sdr12 = <0x0>;
> -		ti,otap-del-sel-sdr25 = <0x0>;
> -		ti,otap-del-sel-sdr50 = <0x8>;
> -		ti,otap-del-sel-sdr104 = <0x7>;
> -		ti,otap-del-sel-ddr50 = <0x4>;
> -		ti,itap-del-sel-legacy = <0xa>;
> -		ti,itap-del-sel-sd-hs = <0x1>;
> -		ti,itap-del-sel-sdr12 = <0xa>;
> -		ti,itap-del-sel-sdr25 = <0x1>;
> +		ti,otap-del-sel-sdr12 = <0xf>;
> +		ti,otap-del-sel-sdr25 = <0xf>;
> +		ti,otap-del-sel-sdr50 = <0xc>;
> +		ti,otap-del-sel-sdr104 = <0x6>;
> +		ti,otap-del-sel-ddr50 = <0x9>;
> +		ti,itap-del-sel-legacy = <0x0>;
> +		ti,itap-del-sel-sd-hs = <0x0>;
> +		ti,itap-del-sel-sdr12 = <0x0>;
> +		ti,itap-del-sel-sdr25 = <0x0>;
>   		status = "disabled";
>   	};
>   
> @@ -600,17 +599,17 @@ sdhci2: mmc@fa20000 {
>   		clock-names = "clk_ahb", "clk_xin";
>   		bus-width = <4>;
>   		ti,clkbuf-sel = <0x7>;
> -		ti,otap-del-sel-legacy = <0x8>;
> +		ti,otap-del-sel-legacy = <0x0>;
>   		ti,otap-del-sel-sd-hs = <0x0>;
> -		ti,otap-del-sel-sdr12 = <0x0>;
> -		ti,otap-del-sel-sdr25 = <0x0>;
> -		ti,otap-del-sel-sdr50 = <0x8>;
> -		ti,otap-del-sel-sdr104 = <0x7>;
> -		ti,otap-del-sel-ddr50 = <0x8>;
> -		ti,itap-del-sel-legacy = <0xa>;
> -		ti,itap-del-sel-sd-hs = <0xa>;
> -		ti,itap-del-sel-sdr12 = <0xa>;
> -		ti,itap-del-sel-sdr25 = <0x1>;
> +		ti,otap-del-sel-sdr12 = <0xf>;
> +		ti,otap-del-sel-sdr25 = <0xf>;
> +		ti,otap-del-sel-sdr50 = <0xc>;
> +		ti,otap-del-sel-sdr104 = <0x6>;
> +		ti,otap-del-sel-ddr50 = <0x9>;
> +		ti,itap-del-sel-legacy = <0x0>;
> +		ti,itap-del-sel-sd-hs = <0x0>;
> +		ti,itap-del-sel-sdr12 = <0x0>;
> +		ti,itap-del-sel-sdr25 = <0x0>;
>   		status = "disabled";
>   	};
>   

