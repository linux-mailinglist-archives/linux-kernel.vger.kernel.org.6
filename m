Return-Path: <linux-kernel+bounces-294210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B1958AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFA31C22A34
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF03193071;
	Tue, 20 Aug 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="afxMd8+w"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577F1917E3;
	Tue, 20 Aug 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166162; cv=none; b=LGMDu926/Xn8Ke+q4XcI7OqxNv+oOuOzH2Lu23xJ7iw9VGtyx5EFdhuAbTW0zIK/bzFkS8fWWgZXyrNcRT4w6lB0yrpmpTUGTUmnPPd4Ofv76I7i56opeXZLEmlLEjP4kowGR5c+j3LKTZNvwhv0ugsb/jPDGHMHgYJZDejCthI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166162; c=relaxed/simple;
	bh=8dEYB5HfPydA6/v/WOHRd3YOWXi2J8wwcSC1dx66SmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OSFpDgK0/5twaspq+Pdhb/xn3SSvit3vMTOC2I9ndEwlV9GsmHR3iBivq4fPvijXi16lFkRRy5UaRh6qWO+zxkx6bS8ufldb1d/1C/8L0XbVJlTlsF+nqL+k5UCYFebKZ25lKEAlBTInQ/vyzUNi0fWOUh9Lx6TIAkZvkOhv4cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=afxMd8+w; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KF2WC2009433;
	Tue, 20 Aug 2024 10:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724166152;
	bh=nwrUwUhK4mB5TX05uAd+w+1d62N97DyJG/CwLmMVxWA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=afxMd8+w/BG/CBFIXP6lw9kjJyE/UBpTR6iBftoD5CyxpKav6kzpKTAQAn6p3TeQr
	 JHAnoBzE2YUJ0GNqCRWsxfV/EIY2HcG58AHRE6l+oDU2WbEjn7XZmcbRt/qPAYWFuX
	 vVnYTYKQnbivZlmEMiQoHritMupjX+8eOheUeDFo=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KF2WJc027682
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 10:02:32 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 10:02:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 10:02:32 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KF2WD0008473;
	Tue, 20 Aug 2024 10:02:32 -0500
Message-ID: <f4fba140-347d-443d-bb18-9080535b0913@ti.com>
Date: Tue, 20 Aug 2024 10:02:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] arm64: dts: k3-am62a-main: Add C7xv device node
To: Hari Nagalla <hnagalla@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nm@ti.com>, <bb@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20240820104034.15607-1-hnagalla@ti.com>
 <20240820104034.15607-2-hnagalla@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240820104034.15607-2-hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/20/24 5:40 AM, Hari Nagalla wrote:
> From: Jai Luthra <j-luthra@ti.com>
> 
> AM62A SoCs have a C7xv DSP subsystem with Analytics engine capability.
> This subsystem is intended for deep learning purposes. Define the
> device node for C7xv DSP.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index 916fcf3cc57d..818005b8954d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -1088,4 +1088,15 @@ vpu: video-codec@30210000 {
>   		clocks = <&k3_clks 204 2>;
>   		power-domains = <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
>   	};
> +
> +	c7x_0: dsp@7e000000 {
> +		compatible = "ti,am62a-c7xv-dsp";
> +		reg = <0x00 0x7e000000 0x00 0x00100000>;
> +		reg-names = "l2sram";
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <208>;
> +		ti,sci-proc-ids = <0x04 0xff>;
> +		resets = <&k3_reset 208 1>;
> +		firmware-name = "am62a-c71_0-fw";
> +	};
>   };

