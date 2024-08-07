Return-Path: <linux-kernel+bounces-277931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2C94A85D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900882855EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A481E7A48;
	Wed,  7 Aug 2024 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N29T/DaP"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB181E7A2D;
	Wed,  7 Aug 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036161; cv=none; b=tBb6hEDHD02kUkLMTLAcJBuk+vsJxENC+ZQYvcR0ekIQbwJanETfl1+/CLyImpmYSlamgsuQxJRAVTsMILQ668lk8uLmpnNBjzdWHcLP1YOtP21/nUzLPLAfMwb/OAEiTopa9i9gJKk4e1sGMGvFE7zBJj4NMpMIVt2kUJHxrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036161; c=relaxed/simple;
	bh=/Z7Z929pdRKPGRZnVGKMDMJkn2h7pHVUhr2rLs3fcYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB+S0UwuRFqLKnBwAphh/8/Q5I8/1HssQTcFmptC0UBkk70iGNf1R5kbS3SEUbYhKG0hHS7p5qSEPfnqhMXa8DBoEybGfMHU9kP69vD5aV1Ll4EwUSdqE4D95MmAnGqCCdGRzTxxiyzSxMztlkzlvBVaqfEBI7yQ50I4uW6GfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N29T/DaP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477D9DCJ064524;
	Wed, 7 Aug 2024 08:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723036153;
	bh=P2TsUhCJ8QvvtVrTNlhpeH2EsrFFc9cF/x4HWBr5yh4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=N29T/DaPkATmP7nKsLuqFFy1mgwUrSacM7RRg5/dnkO3+VyV/U2iz0ut8L7gkX1/W
	 ZswfOuyd3stNbZ7ftGA0pNCaXfJjhux69/IlFyRsD8hPTaCV/PrExOj39oSEWmhPXc
	 UDFKe5F7qYKnkqir3GIkMHx7K4VV/0iEMQ5+lG+I=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477D9C9r105861
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 08:09:13 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 08:09:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 08:09:12 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477D9CTi099462;
	Wed, 7 Aug 2024 08:09:12 -0500
Date: Wed, 7 Aug 2024 08:09:12 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: Re: [PATCH v3 4/9] arm64: dts: ti: Split
 k3-j784s4-j742s2-main-common.dtsi
Message-ID: <20240807130912.uc7feutzbiofjntr@certified>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
 <20240731-b4-upstream-j742s2-v3-4-da7fe3aa9e90@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240731-b4-upstream-j742s2-v3-4-da7fe3aa9e90@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 22:40-20240731, Manorit Chawdhry wrote:
> k3-j784s4-j742s2-main-common.dtsi will be included in k3-j742s2-main.dtsi at a
> later point so move j784s4 related stuff to k3-j784s4-main.dtsi

Reword as suggested for the evm.

> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
[...]
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> new file mode 100644
> index 000000000000..2ea470d1206d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Device Tree Source for J784S4 SoC Family Main Domain peripherals
> + *
> + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&cbass_main {
> +	c71_3: dsp@67800000 {
> +		compatible = "ti,j721s2-c71-dsp";
> +		reg = <0x00 0x67800000 0x00 0x00080000>,
> +		      <0x00 0x67e00000 0x00 0x0000c000>;
> +		reg-names = "l2sram", "l1dram";
> +		ti,sci = <&sms>;
> +		ti,sci-dev-id = <40>;
> +		ti,sci-proc-ids = <0x33 0xff>;
^^ vendor specific properties

> +		resets = <&k3_reset 40 1>;
> +		firmware-name = "j784s4-c71_3-fw";
^^ common properties
> +		status = "disabled";
> +	};
> +};

Since we are refactoring, we can use this opportunity to cleanup a bit
when the node is getting introduced.

> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
> index 16ade4fd9cbd..f5afa32157cb 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
> @@ -168,3 +168,5 @@ cpu7: cpu@103 {
>  		};
>  	};
>  };
> +
> +#include "k3-j784s4-main.dtsi"
> 
> -- 
> 2.45.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

