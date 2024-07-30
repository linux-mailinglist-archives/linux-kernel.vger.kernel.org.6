Return-Path: <linux-kernel+bounces-267485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE54941203
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE8B1C20F73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDD019EEC6;
	Tue, 30 Jul 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nGBNlDAh"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5DB757FC;
	Tue, 30 Jul 2024 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343062; cv=none; b=a2BQ7HZj1QPOjQhnyz0R5DTFj1j/fachuuQRgYGTfvGegZ2nCM8rqVnHH+T6dTunOjowOiVxwPhVyN5C/gJBENCGTrpa0x30F2Nith57sTZ4hBB1PoTN1GrVnGBqj2NUIf885JnphzmFsg9pAYeh7c5j5oTLEJjU+S7s1N0NU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343062; c=relaxed/simple;
	bh=iuAu9jY+pC7f3nPxGBgxIDsUszJoAS16B40y8fwdvuA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4dODrTLC9+09t9KttNZJQqsKIzsF8RSWYBAATF7KymXq+AqW5YgT8Ai28PlUSfo8vuIvq9N/siCkJRvNdR+lzTwC6tfMtYmevlPS7LxL/qo2uw8oAdPM47iCqL62tOaTkjFKVSKgEMZiiu4/avoDNXAazYXaaeL35D6t6r9ulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nGBNlDAh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UCbX7j040587;
	Tue, 30 Jul 2024 07:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722343053;
	bh=b6ILqBtYjVjw2s/bvY8SmANAH61kLCK+kEiFCSGqKAk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=nGBNlDAhD8BT/TmwV+4+F8jfWo8N3GkI1iTB7iMggCEC5EAmHgnnBZ7dfIzONVeuv
	 HL24Oi8qLV9t+rZrkEr4MGMDnR17ice73H6v1jMhZQwtrJX3pGHZaPBhe500XVlqy7
	 6mPyasyDEkJi5LII0Rmfk69kSMf8sKEjBTafClAY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UCbXhC043586
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 07:37:33 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 07:37:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 07:37:32 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UCbW0f123951;
	Tue, 30 Jul 2024 07:37:32 -0500
Date: Tue, 30 Jul 2024 07:37:32 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva
 Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
Message-ID: <20240730123732.up3etyqvb44qql5g@groin>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-4-msp@baylibre.com>
 <20240730120958.inq73rx6dfmwh6vz@hemstitch>
 <f53iiczunc4b4wjzsvh7ccm7cc322vsaqhng6khqj74j6anhor@umm73mbbth2w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f53iiczunc4b4wjzsvh7ccm7cc322vsaqhng6khqj74j6anhor@umm73mbbth2w>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:32-20240730, Markus Schneider-Pargmann wrote:
> Hi Nishanth,
> 
> On Tue, Jul 30, 2024 at 07:09:58AM GMT, Nishanth Menon wrote:
> > On 10:00-20240729, Markus Schneider-Pargmann wrote:
> > > WKUP_EN is a flag to enable pin wakeup. Any activity will wakeup the SoC
> > > in that case.
> > > 
> > > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > > ---
> > >  arch/arm64/boot/dts/ti/k3-pinctrl.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> > > index 22b8d73cfd32..dd4d53e8420a 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> > > +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> > > @@ -12,6 +12,7 @@
> > >  #define PULLTYPESEL_SHIFT	(17)
> > >  #define RXACTIVE_SHIFT		(18)
> > >  #define DEBOUNCE_SHIFT		(11)
> > > +#define WKUP_EN_SHIFT		(29)
> > >  
> > >  #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
> > >  #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
> > > @@ -38,6 +39,8 @@
> > >  #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
> > >  #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
> > >  
> > > +#define WKUP_EN			(1 << WKUP_EN_SHIFT)
> > > +
> > 
> > Are we using this?
> 
> Yes, this needs to be used in pinctrl for the relevant pins. The users
> are not part of this series, as it will probably be in devicetree
> overlays or maybe future board files.
> 
> This is an example configuration for mcu_mcan0 that is required to
> enable support for wakeup from Partial-IO:
> 
>   &mcu_pmx0 {
>     mcu_mcan0_tx_pins_default: mcu-mcan0-tx-pins-default {
>       pinctrl-single,pins = <
>         AM62X_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
>       >;
>     };
> 
>     mcu_mcan0_rx_pins_default: mcu-mcan0-rx-pins-default {
>       pinctrl-single,pins = <
>         AM62X_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
>       >;
>     };
> 
>     mcu_mcan0_rx_pins_wakeup: mcu-mcan0-rx-pins-wakeup {
>       pinctrl-single,pins = <
>         AM62X_IOPAD(0x038, PIN_INPUT | WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
>       >;
>     };
>   };
> 
>   &mcu_mcan0 {
>     pinctrl-names = "default", "wakeup";
>     pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
>     pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
>     status = "okay";
>   };


Please introduce at least 1 user in the series? or if there are
dependencies, then we can hold back this patch till the right users are
available.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

