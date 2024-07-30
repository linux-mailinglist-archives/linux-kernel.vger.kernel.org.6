Return-Path: <linux-kernel+bounces-267323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE25994102F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76B11C22B90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692E4198E88;
	Tue, 30 Jul 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vk8bSf0j"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF31940A9;
	Tue, 30 Jul 2024 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337497; cv=none; b=AKEtUIb1uvRK6VZhbx1pl8/X1ywUZGOdUm+kVlf2EgR/4bJQF6nhyreHGjQ6VBEmKmQb9Jx62HKDu713mtnKX3dLq12EfBl6zRVWRZmpPcXPprYXUS3D2iheZonX01JSg0ValEmjj+d4EsWYS797Jrnn8JpGj9zOJGwu+f6pHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337497; c=relaxed/simple;
	bh=8kJJJ23S1s4bXzAQ/1eR6qdIPpi7ytxGMPy9sCqOAeI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHGOd2Cd6V8M54OIvGLjveVRF2Otr7kSy7FO6vVdxBgllLCqJpgIrHtlx5iAIipqLrJgCHx8ALWl98k+rD5qXZdCdY5eg+NO4WB4ZFRmkVzcGIhXb8VicySS6UFO2LEVz19Gi8BfpF9w1ZR9lQ4NjH43zpQW7ZNEi1WkXOd2ip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vk8bSf0j; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UB4j1h047417;
	Tue, 30 Jul 2024 06:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722337485;
	bh=AqxvLlNQJfziT+W4FGrpgn+jPAZl3IrY/Yqpreg0QOQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vk8bSf0jefk7GmGtYZqWklz5DKyqCqXXJiOKI57uCj9JF4cii9Kx9hTYQmNhEXhro
	 vg415UYWsu82JZ6EZF2ZNc+4Ys7QRzZ35x3WxGi6ziEZ7GMP2A/DELnYlsZKK3Vxz7
	 E3ve/XdwGfuHFHIEqYDwVfkj2rTs9zL7wMMa6KxQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UB4joh032215
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 06:04:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 06:04:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 06:04:44 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UB4iJk117516;
	Tue, 30 Jul 2024 06:04:45 -0500
Date: Tue, 30 Jul 2024 06:04:44 -0500
From: Nishanth Menon <nm@ti.com>
To: Parth Pancholi <parth.pancholi@toradex.com>
CC: "vigneshr@ti.com" <vigneshr@ti.com>,
        "parth105105@gmail.com"
	<parth105105@gmail.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "j-choudhary@ti.com" <j-choudhary@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs
Message-ID: <20240730110444.fctc2lje62ewg4ob@safari>
References: <20240730093754.1659782-1-parth105105@gmail.com>
 <94a0be3616425c7aef7bb0507d60ee11d4776545.camel@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <94a0be3616425c7aef7bb0507d60ee11d4776545.camel@toradex.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:50-20240730, Parth Pancholi wrote:
> On Tue, 2024-07-30 at 11:37 +0200, Parth Pancholi wrote:
> This message originated from outside your organization
> 
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> Correct the McASP nodes - mcasp3 and mcasp4 with the right
> DMAs thread IDs as per TISCI documentation [1] for J784s4.
> This fixes the related McASPs probe failure due to incorrect
> DMA IDs.
> 
> Link: http://downloads.ti.com/tisci/esd/latest/5_soc_doc/j784s4/psil_cfg.html#psi-l-source-and-destination-thread-ids/<http://downloads.ti.com/tisci/esd/latest/5_soc_doc/j784s4/psil_cfg.html#psi-l-source-and-destination-thread-ids> [1]
> Fixes: 5095ec4aa1ea ("arm64: dts: ti: k3-j784s4-main: Add McASP nodes")
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> ---
> arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index f170f80f00c1..d4ac1c9872a5 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -2755,7 +2755,7 @@ mcasp3: mcasp@2b30000 {
> interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
> interrupt-names = "tx", "rx";
> - dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
> + dmas = <&main_udmap 0xc403>, <&main_udmap 0x4403>;
> dma-names = "tx", "rx";
> clocks = <&k3_clks 268 0>;
> clock-names = "fck";
> @@ -2773,7 +2773,7 @@ mcasp4: mcasp@2b40000 {
> interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
> interrupt-names = "tx", "rx";
> - dmas = <&main_udmap 0xc501>, <&main_udmap 0x4501>;
> + dmas = <&main_udmap 0xc404>, <&main_udmap 0x4404>;
> dma-names = "tx", "rx";
> clocks = <&k3_clks 269 0>;
> clock-names = "fck";
> 
I think your patch got corrupted. Could you use git send-email or a
proper client?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

