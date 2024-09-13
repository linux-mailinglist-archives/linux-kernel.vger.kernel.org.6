Return-Path: <linux-kernel+bounces-328707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C782D978797
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40741C225F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCA012EBE7;
	Fri, 13 Sep 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fuq1zFRb"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6C12D1EA;
	Fri, 13 Sep 2024 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251012; cv=none; b=nUw7SLtxWtPXZyQn0I7YgcrDVlVQdRa7mAMIXrCByRGVxLCXDB67IZrw825r8POkzTbnU1CZZlEeSnkN6N8rDPnWOvrND5iBKoQssA1zMkH17jQi8ZErcQwrg2XQG1DbcCnk6VsKt0lC9pBCfaFmT8C/df/irIBI9r3sI4k/0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251012; c=relaxed/simple;
	bh=2AKIDsY30kROqtXd1iPFPguYH7NkJ4wNs36fl8HheaE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e79EPTBLMR0kaTg0Y5bd3T0gquWzDI4lfGT4D5H27prz0f+vzgwgHg04/8Dzy7GQeU24AemW2aqAdDP0eOJwewuYcEZfSXTwLZ1MedsnDGG0KKbKwQbYsYOcYNBMNabplbuVQoYCvc82eHwWzzQFC24LWg17i0EP12ZoECk8NCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fuq1zFRb; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48DI9oaa006173;
	Fri, 13 Sep 2024 13:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726250990;
	bh=4mwqEo4CJeHKszOoMmSuayFcDjMFSpj7YGqp6pepgK8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Fuq1zFRbpcfUlaQOqRUG+nF3IHG3kZGFynaIdHB7xK1F9bjpiwQCbc4er9g3ItKfx
	 qc5VJjixmFVv9UdJmS2st1LF3CUHzjOD8NK0lPTRceS1DeF2uBebSz+A3VOBKDBxmq
	 1VLQt0P8AZsERdvdrhDYWWBaZTIHlmihcZ0/N2mQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48DI9okY038102
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Sep 2024 13:09:50 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Sep 2024 13:09:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Sep 2024 13:09:49 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48DI9naV087654;
	Fri, 13 Sep 2024 13:09:49 -0500
Date: Fri, 13 Sep 2024 13:09:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Garrett Giordano <ggiordano@phytec.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <w.egorov@phytec.de>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] arm64: dts: ti: am62-phycore-som: Increase cpu
 frequency to 1.4 GHz
Message-ID: <20240913180949.dlw3k6epqmzlpuu5@studied>
References: <20240913175625.3190757-1-ggiordano@phytec.com>
 <20240913175625.3190757-2-ggiordano@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240913175625.3190757-2-ggiordano@phytec.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:56-20240913, Garrett Giordano wrote:
> The am625 is capable of running at 1.4 GHz when VDD_CORE is increased
> from 0.75V to 0.85V. Here we add a 1.4 GHz node to the a53_opp_table and
> increase the VDD_CORE voltage accordingly.

The entire argument in introducing the 1.4Ghz overlay seems to have been
to let users have the choice. What has changed since then?

Ref: commit 7a5775a3da906dab059b8de60a2b88f6016cb4b8

btw, instead of putting a patch to delete the dtso, you should
probably consider a revert patch instead.

> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> index ac8959f3d953..8acbd4facf37 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> @@ -205,6 +205,13 @@ AM62X_IOPAD(0x01f4, PIN_INPUT, 0) /* (D16) EXTINTn */
>  	};
>  };
>  
> +&a53_opp_table {
> +	opp-1400000000 {
> +		opp-hz = /bits/ 64 <1400000000>;
> +		opp-supported-hw = <0x01 0x0004>;
> +	};
> +};
> +
>  &mcu_m4fss {
>  	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
>  	memory-region = <&mcu_m4fss_dma_memory_region>,
> @@ -265,8 +272,8 @@ pmic@30 {
>  		regulators {
>  			vdd_core: buck1 {
>  				regulator-name = "VDD_CORE";
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  			};
> -- 
> 2.25.1
> 


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

