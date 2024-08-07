Return-Path: <linux-kernel+bounces-277834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CB194A727
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3991F23FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC091E485D;
	Wed,  7 Aug 2024 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pn/4TUsY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E70171E69;
	Wed,  7 Aug 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031174; cv=none; b=C832fk36tjl9KOFDXOgPxbSg/wME6NRPdRhC2Z8pgHCQ/9BUeWTyvjp6iqO4pvsdOUdIaMi/oc52S/1HppYYqxwxjiPjggQ/eephRgwPnjZlkEOUpPps9UvEWs4NScuD7rrLJaBe+bKkAtwd8kwILdB0a4/MXiYdHt2f7VdX35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031174; c=relaxed/simple;
	bh=3mPx0pdI2/rcphvTFsO1iAa/GzbtYMC71ti7NhuXJWs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is0I7WUhd3Fpba34sI94psMj28sndHPg6Ph3VrqIXU43pBRuyy3DC85JKH15Hbj/bOSBrO28BHuTwNug0f+gPuZZZEVlGkqt5FDrUpChNi24TRzoHkAtOtJD7zZ2QRC0qI2HtwNyObvebz7TVHvHJiEj6vj+e5n8emWxNzhWaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pn/4TUsY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477Bk5hK044236;
	Wed, 7 Aug 2024 06:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723031165;
	bh=qQewSBNyRf6kKTNXE1loWB+KeDCvvrtyjbeeH+G6vDg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=pn/4TUsYBmlUS9pL5NxVKihItMli74X7KyeSlw5kvu/886l78AJ6S87qby990JREK
	 ZUIO0yxmeeDdSXqiGrJczkUaaoq8lke+vknTDdTGC7kf4H5oa8GWSRiF0MeDphvoxy
	 XNfEOkilwRTVTXwn2YDzxqg7wQbYixvY/jdahz3s=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477Bk5YQ023594
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 06:46:05 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 06:46:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 06:46:05 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477Bk5Hh094054;
	Wed, 7 Aug 2024 06:46:05 -0500
Date: Wed, 7 Aug 2024 06:46:05 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Santhosh Kumar
	<s-k6@ti.com>,
        Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH 3/5] arm64: dts: ti: k3-am62p: Remove 'reserved' status
Message-ID: <20240807114605.ggieur532eh4usus@diagram>
References: <20240806214605.3379881-1-jm@ti.com>
 <20240806214605.3379881-4-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240806214605.3379881-4-jm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16:46-20240806, Judith Mendez wrote:
> From: Santhosh Kumar K <s-k6@ti.com>
> 
> Remove 'reserved' status for MCU ESM node in AM62P device tree.

Why?
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> index e65db6ce02bf6..d913e6319bad8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> @@ -27,7 +27,6 @@ mcu_esm: esm@4100000 {
>  		compatible = "ti,j721e-esm";
>  		reg = <0x00 0x4100000 0x00 0x1000>;
>  		ti,esm-pins = <0>, <1>, <2>, <85>;
> -		status = "reserved";
>  		bootph-pre-ram;
>  	};
>  
> -- 
> 2.45.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

