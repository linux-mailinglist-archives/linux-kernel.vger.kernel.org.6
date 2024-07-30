Return-Path: <linux-kernel+bounces-267743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EC89414FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1341C22E37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B731A2553;
	Tue, 30 Jul 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TLAlR3Nr"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAB2A1C7;
	Tue, 30 Jul 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351614; cv=none; b=R7MEAuA7PgDgHx8FB7DfquLqIDG0PJZFyONc4Ur4gIPabNfYMe+7QJW1wNxjN4hb5bbyQn2TXv/dknxjOyYQAs5Hs0TzJRdGIrAGxajEBwR5+plCZCRynOwfduJUAukMQw2s0GRfv1+7SnXnt2CPWM4P8GgnsWGWfNYzUIInyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351614; c=relaxed/simple;
	bh=/enkpj9O+dBztsb4mwD2ol6JSUHYTrMr7pu0zOXi1us=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpru13GZQQysGjk9TkBZBhV0EWlII2uiiDjOGNiEp5u+5ixsSUFFkubUWcuaBaZIfYnnO5ji+ulOLBsq24PC+yeGC0WaqhzpfehEUORUgOIbyx7yCdizA50mYqbuWmjxkzpzemywuk5DAThoBxoKEDn/6RcS98ZSC5qPC4pMi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TLAlR3Nr; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UExu6u072132;
	Tue, 30 Jul 2024 09:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722351596;
	bh=F0r+M6XIh5C0j0WCIA+BEDAjLC+mgSZtp+xtv/V0OT4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=TLAlR3NrHJ5/HmvkiUkfxW71YCp6DwV/n25Uvtz0yj+zmkA13lQg/dJPK+b61abpx
	 8f/kJWJBHidReUXdn2eeWx1PeV4xNOygNFjMSjLIphYEJ+Xd3ArDUEOmb2zm+L4UyH
	 /5JtuCi4/7jy4kX1ymRMcJbWwlhDKCm9JM8EnmWc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UExu2r016856
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 09:59:56 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 09:59:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 09:59:56 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UExuCo082521;
	Tue, 30 Jul 2024 09:59:56 -0500
Date: Tue, 30 Jul 2024 09:59:56 -0500
From: Nishanth Menon <nm@ti.com>
To: Jared McArthur <j-mcarthur@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62p: Add gpio-ranges for
 mcu_gpio0
Message-ID: <20240730145956.n7brt337sc5vjpg5@violet>
References: <20240730143324.114146-1-j-mcarthur@ti.com>
 <20240730143324.114146-2-j-mcarthur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240730143324.114146-2-j-mcarthur@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09:33-20240730, Jared McArthur wrote:
> Commit d72d73a44c3c ("arm64: dts: ti: k3-am62p: Add gpio-ranges
> properties") introduced pinmux range definition for gpio-ranges,
> however missed introducing the range description for the mcu_gpio0
> node. As a result, automatic mapping of GPIO to pin control for mcu
> gpios is broken. Fix this by introducing the proper ranges.
> 
> Fixes: d72d73a44c3c ("arm64: dts: ti: k3-am62p: Add gpio-ranges properties")
> Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> index e65db6ce02bf..c0bdbd00dc23 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> @@ -146,6 +146,9 @@ mcu_gpio0: gpio@4201000 {
>  		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 79 0>;
>  		clock-names = "gpio";
> +		gpio-ranges = <&mcu_pmx0 0 0 21>, <&mcu_pmx0 21 23 1>,
> +			      <&mcu_pmx0 22 32 2>;
> +		ti,ngpio = <24>;

we already have ti,ngpio - please drop

>  	};
>  
>  	mcu_rti0: watchdog@4880000 {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

