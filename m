Return-Path: <linux-kernel+bounces-312938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8810C969DFB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC611F2299A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387BC1D094E;
	Tue,  3 Sep 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FRBkIOhD"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A459E1C986E;
	Tue,  3 Sep 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367400; cv=none; b=t8LTq1+QBrL+ExafD5UVzPvY9maQ28PqA50+mX27vjZ97EXcV38tLdjPNAvEidnoGv1fDz4Ry0oAjI4lwfoZWTufG+9c/wb98M6yTcxqS2rmJKelQ5EjsamQzuaoYXZnb8694A8GGw3XmapWjrONaZPCi8tIfnxG4KjdSOO91yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367400; c=relaxed/simple;
	bh=yTF/fGN4RR3VpT0hzYIJTXgEPXt7knOdnRhpip1sUmA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m06jGsVTWgICirBGurEIkGCtt6zozzgd5j1Dpy7esaYMbqy1ghJ8Fwz2xyGZmMQ2HG2hPFda0VI5/NYaLd0ZMvUSZ266iGodj01N5OEjc0OPnqVCZFofCnoIxW1/50GBCRuR1ngxVhc1a+X5vTu3SqN0YAGaTB+bKntomjjOL/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FRBkIOhD; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 483Cgufj049953;
	Tue, 3 Sep 2024 07:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725367376;
	bh=kxd09p87eyIpKEs742hX/lKSrt7kw7ToaYqhb3glXVw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FRBkIOhD6e2QzcAQrI9xnzPedjQmZgKaBx+Y+YYCvvTPeOlENOiFOiYkMEPSLQR25
	 c386Kvvd1dzT059YU0ZBI4OHZ1dqqwfd6SL+KHaGom6tLT9p24rymuukkHbiq53S4V
	 7WMQ+3/V55UqyvD9cCgWayVexND8omaAcS7D9Rhw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 483CguFU084459
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 07:42:56 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 07:42:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 07:42:56 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483Cgu0k010869;
	Tue, 3 Sep 2024 07:42:56 -0500
Date: Tue, 3 Sep 2024 07:42:56 -0500
From: Nishanth Menon <nm@ti.com>
To: Josua Mayer <josua@solid-run.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am642-sr-som: mux ethernet phy
 reset signals input
Message-ID: <20240903124256.kmlkjcihl6zyzgiu@commuting>
References: <20240903-am64-phy-lockup-v2-1-8cf6bd138ebd@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903-am64-phy-lockup-v2-1-8cf6bd138ebd@solid-run.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:52-20240903, Josua Mayer wrote:
> Specifically on AM64 SoM design, the DP83869 phys have a chance to lock
> up if reset gpio changes state. Update the pinmux to input-only,
> strongly enforcing that these signals are left floating at all times.
> 
> This avoids sporadic phy initialisation errors mostly encountered during
> power-on and reset. In this state the phys respond to all mdio messages
> with a constant response, recovering only after power-cycle.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v2:
> - update commit message with additional details
> - rebased on v6.11-rc1
> - Link to v1: https://lore.kernel.org/r/20240704-am64-phy-lockup-v1-1-4a38ded44f9d@solid-run.com
> ---
>  arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> index c19d0b8bbf0f..b1f06071df4c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> @@ -320,7 +320,7 @@ AM64X_IOPAD(0x0278, PIN_INPUT, 7) /* EXTINTn.GPIO1_70 */
>  	ethernet_phy0_default_pins: ethernet-phy0-default-pins {
>  		pinctrl-single,pins = <
>  			/* reset */
> -			AM64X_IOPAD(0x0154, PIN_OUTPUT, 7) /* PRG1_PRU1_GPO19.GPIO0_84 */
> +			AM64X_IOPAD(0x0154, PIN_INPUT, 7) /* PRG1_PRU1_GPO19.GPIO0_84 */
>  			/* reference clock */
>  			AM64X_IOPAD(0x0274, PIN_OUTPUT, 5) /* EXT_REFCLK1.CLKOUT0 */
>  		>;
> @@ -329,7 +329,7 @@ AM64X_IOPAD(0x0274, PIN_OUTPUT, 5) /* EXT_REFCLK1.CLKOUT0 */
>  	ethernet_phy1_default_pins: ethernet-phy1-default-pins {
>  		pinctrl-single,pins = <
>  			/* reset */
> -			AM64X_IOPAD(0x0150, PIN_OUTPUT, 7) /* PRG1_PRU1_GPO18.GPIO0_20 */
> +			AM64X_IOPAD(0x0150, PIN_INPUT, 7) /* PRG1_PRU1_GPO18.GPIO0_20 */
>  			/* led0, external pull-down on SoM */
>  			AM64X_IOPAD(0x0128, PIN_INPUT, 7) /* PRG1_PRU1_GPO8.GPIO0_73 */
>  			/* led1/rxer */
> @@ -340,7 +340,7 @@ AM64X_IOPAD(0x011c, PIN_INPUT, 7) /* PRG1_PRU1_GPO5.GPIO0_70 */
>  	ethernet_phy2_default_pins: ethernet-phy2-default-pins {
>  		pinctrl-single,pins = <
>  			/* reset */
> -			AM64X_IOPAD(0x00d4, PIN_OUTPUT, 7) /* PRG1_PRU0_GPO7.GPIO0_52 */
> +			AM64X_IOPAD(0x00d4, PIN_INPUT, 7) /* PRG1_PRU0_GPO7.GPIO0_52 */

PIN_INPUT is bi-directional despite what the name states. Either way, it
is a bit late for me to pick things up.

>  			/* led0, external pull-down on SoM */
>  			AM64X_IOPAD(0x00d8, PIN_INPUT, 7) /* PRG1_PRU0_GPO8.GPIO0_53 */
>  			/* led1/rxer */
> 
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240704-am64-phy-lockup-107ea5ffa228
> 
> Best regards,
> -- 
> Josua Mayer <josua@solid-run.com>
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

