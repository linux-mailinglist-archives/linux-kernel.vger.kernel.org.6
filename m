Return-Path: <linux-kernel+bounces-277953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12494A89A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1318E1F22B50
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971991EA0A4;
	Wed,  7 Aug 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x/7PjWS8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F31E7A53;
	Wed,  7 Aug 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037335; cv=none; b=B62ubno+q05+n0FiFCxI6I8mzsNEc7apBWTlMxxwuw6C9axbEjqMKSw/YqxhZdJS7RMnFYMfryRqTebrpUj70ZqYInwQLJQlKoDO7mw0vgFGBCm26YZJ9rureuSuvvEwCICqkmT4p144b6cVBOlT25zdIu5zLalqhNB4KdcmBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037335; c=relaxed/simple;
	bh=yih2ooSQ90/is/H3Qh5VPfIz9YLQdaGqrpyUlzRNuxA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so9dgjdNOIhG5uhiFGzCnSKTmKBNsD/CSZC+T8EWIKlSlF3xExfG6vWwN+OtE13XURccJAlM7OzGo0Des6UWADzMZE0aXc5T83Th+7NrHWmB3WrY8X2GiWyUwwMmCGVa2CWuHgDqnnQ8J4NbEyXnqFd8nLAW6aii+muoEpL0XyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=x/7PjWS8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477DSmGf068680;
	Wed, 7 Aug 2024 08:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723037328;
	bh=NkkpVq0CuwgQWw4OlBnq3OtVXQR2J5cQP4ilZttmd6E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=x/7PjWS8KUDGqBNUpDGNEvJjiU1jFlGx5EqzH+Za2ejS3VfI8F8E7mNsW8f5dGcDY
	 1j2i8U97EPagovPZDx5CYRX8eFdrLYUEcoLZx+6IFy0lVnweVD1AI+PsWNmkZBuF9P
	 Tepg3u4boxk7JfFvmKucL3kBWeMBdgRRvKZdduag=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477DSm9F010900
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 08:28:48 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 08:28:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 08:28:48 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477DSlWF014879;
	Wed, 7 Aug 2024 08:28:47 -0500
Date: Wed, 7 Aug 2024 08:28:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Use 4 lanes for PCIe0 on
 EVM
Message-ID: <20240807132847.3qca5ijdwsasdf4y@legroom>
References: <20240720110455.3043327-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240720110455.3043327-1-s-vadapalli@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16:34-20240720, Siddharth Vadapalli wrote:
> The PCIe0 instance of the PCIe controller on J784S4 SoC supports up to 4
> lanes. Additionally, all 4 lanes of PCIe0 can be utilized on J784S4-EVM
> via SERDES1. Since SERDES1 is not being used by any peripheral apart
> from PCIe0, use all 4 lanes of SERDES1 for PCIe0.
> 
> Fixes: 27ce26fe52d4 ("arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20240715.
> Patch has been tested on J784S4-EVM. Logs:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/2b9b1196ff6b9eac895a7986e5ff4456
> NOTE: Patch applies cleanly on Mainline Linux's latest commit
> 3c3ff7be9729 Merge tag 'powerpc-6.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> 
> Regards,
> Siddharth.
> 
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index ffa38f41679d..ea27519d7b89 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -1407,10 +1407,11 @@ &serdes1 {
>  
>  	serdes1_pcie0_link: phy@0 {
>  		reg = <0>;
> -		cdns,num-lanes = <2>;
> +		cdns,num-lanes = <4>;
>  		#phy-cells = <0>;
>  		cdns,phy-type = <PHY_TYPE_PCIE>;
> -		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>;
> +		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>,
> +			 <&serdes_wiz1 3>, <&serdes_wiz1 4>;
>  	};

OK - I see the reason why
https://lore.kernel.org/all/20240807132054.jcz5fdokc5yk3mbo@entrust/
was missed.

Please sync with Manorit to make sure we sequence these correctly -
looks to me that this fixup needs to get in first? have you also checked
up on AM69-SK ?

>  };
>  
> -- 
> 2.40.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

