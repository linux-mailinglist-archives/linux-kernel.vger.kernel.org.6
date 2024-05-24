Return-Path: <linux-kernel+bounces-188343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A6B8CE0CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FBE282DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A8127E1C;
	Fri, 24 May 2024 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RGKYB0rB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679979C2;
	Fri, 24 May 2024 05:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530108; cv=none; b=CH9ly2rHMGdqUmGxIkLmLcAy6yigPSIUTXNfmmUSsd57+d6YHOMlLNvjrd2hd+ulZEMhHOmg0qyIb9Zw6oENJGXpJo0Q2h9zIOc1opUwzcU9WrgIx0CMBOkByUVMgBfAfk4aXbQXwca1HY3uW0U57+hyRCmRU0cb81S4AzXV6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530108; c=relaxed/simple;
	bh=nOjv0RsyBAiqO/7lUSqmFWeAydPEKUkSr5ta3qyru6s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGmozexMq/tr3UE1sGpdJn+hYzIDYT247CsqXmYWFhPzNuxN323FdjPqJHzrqNYrtZRxS73Ymu0N95hs4vZoVKaViiZw4fRVFtVvWHaQa79k1wOU5c08y+zgOHhKtFZYy0Uypfg8X/fZoYTIUqNxNTyBEef8v51S/lebm2MT7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RGKYB0rB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O5sw3K106505;
	Fri, 24 May 2024 00:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716530098;
	bh=nJwFVKVRvEeV0qgpK3HQpef65Lf7UTr73Q7joXlHsqY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=RGKYB0rBdqKAUuL5yTnhNizOGTeMwKcqc2i3dwVXlBHI/QkrfFMsYjPDL4t6ac0yG
	 KG3J30eKCWd3WMrEL9eOjkZDZApIifcpUPdPjcPI5vJzE28cU6uKfL8wCi0TPfp/6g
	 xoDCdOdvhmiXAj0PBY6/1uuppXnxsMa+ESLlpFi8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O5sw9b040414
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 00:54:58 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 00:54:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 00:54:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O5sw1i101495;
	Fri, 24 May 2024 00:54:58 -0500
Date: Fri, 24 May 2024 00:54:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: ti: k3-am62p: Add partial-io wakeup
 sources
Message-ID: <20240524055458.bc7hwwifcurwt7oe@catty>
References: <20240523080225.1288617-1-msp@baylibre.com>
 <20240523080225.1288617-7-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523080225.1288617-7-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:02-20240523, Markus Schneider-Pargmann wrote:
> From: Vibhore Vardhan <vibhore@ti.com>
> 
> In Partial-IO mode there are a number of possible wakeup sources. Add
> the list of phandles to these wakeup sources. Based on the patch for
> AM62a.
> 
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62p.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> index 94babc412575..4d43cc972056 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> @@ -123,3 +123,7 @@ cbass_wakeup: bus@b00000 {
>  #include "k3-am62p-main.dtsi"
>  #include "k3-am62p-mcu.dtsi"
>  #include "k3-am62p-wakeup.dtsi"
> +
> +&dmsc {
> +	ti,partial-io-wakeup-sources = <&mcu_mcan0>, <&mcu_mcan1>, <&mcu_uart0>, <&wkup_uart0>;
> +};

NOTE: https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#supported-low-power-modes
table of SoCs supported do not provide J722s or AM62p in
the list. I suspect it is an oversight, but seems to be a mismatch atm.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

