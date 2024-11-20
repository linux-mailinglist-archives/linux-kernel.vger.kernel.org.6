Return-Path: <linux-kernel+bounces-415918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC39D3E01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55F91F218F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661D1CB323;
	Wed, 20 Nov 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FSaSWUlq"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511B1C9EDC;
	Wed, 20 Nov 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114055; cv=none; b=ZhRbBw3IK2z6WvX0r9H0emfQqa5P0/L0/p7ZvgwB3Bv729vbEEHtc+dLamcmz1LIfP3DN4DGhU5VSIZ2lTFUp+6mgynYyxFa4akpyG1Uy/Um4hf7gMJz6tpq4R6tUIfw4ysqba/p5Pq83GlbgdBtEqAnksNjbUofG80vrebCOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114055; c=relaxed/simple;
	bh=l4yWmKaDnzPRnoTIgOu9YNL5J2WtQTIDNXvo3j15U5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgLToYHZ/+KCAsNK9O6fkh0wwfRpmnfUBXs5Ux5z/NvuA5rcNpS4LxWA1X+0Z4xyVMUscJNgu4TuEgNlNssvq35wMTijX2YPm0J9SVdpj1jFhYTOWmBmh86+tSM0LsLOpnjQYVFyHa7MgBAWspkbBRTOIFTRGsloOvHjHA6LhNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FSaSWUlq; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AKElCpV069884;
	Wed, 20 Nov 2024 08:47:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732114032;
	bh=cynzEoYvDf0pcd1GzvErfNECaSezgc6N8fmmyfqTK1s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FSaSWUlqFgfSmcTU+UBy1yOBuvsIh4VFGFZ9INaWSePiOJDaEKGhPoJa9X7AnSz2o
	 Pyfa9f9owuIsIHZkFKqhdknafVhkx/XW70itrOThTElRv5x+3obxkJIlGsXrqcNlAk
	 qjsO3UU97ea/HhygFhmAA9zyjELBEVh0aJZZdrvc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AKElCPq020368
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Nov 2024 08:47:12 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Nov 2024 08:47:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Nov 2024 08:47:12 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AKElCLp004675;
	Wed, 20 Nov 2024 08:47:12 -0600
Date: Wed, 20 Nov 2024 08:47:12 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am62l: add initial reference
 board file
Message-ID: <20241120144712.dxiu34ocv7xdv5rm@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241117-am62lx-v1-0-4e71e42d781d@ti.com>
 <20241117-am62lx-v1-2-4e71e42d781d@ti.com>
 <c8834352-75a7-446e-95eb-809aaa5cb18b@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <c8834352-75a7-446e-95eb-809aaa5cb18b@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On November 18, 2024 thus sayeth Andrew Davis:
> On 11/17/24 11:34 PM, Bryan Brattlof wrote:
> > From: Vignesh Raghavendra <vigneshr@ti.com>
> > 
> > Add the initial board file for the AM62L3's Evaluation Module.
> > 
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-am62l3-evm.dts | 54 ++++++++++++++++++++++++++++++++
> >   1 file changed, 54 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts b/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts
> > new file mode 100644
> > index 0000000000000..2d59389765cab
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0-only or MIT
> > +/*
> > + * Device Tree file for the AM62L3 Evaluation Module
> > + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> > + *
> > + * Technical Reference Manual: https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "k3-am62l3.dtsi"
> > +
> > +/ {
> > +	compatible = "ti,am62l3-evm", "ti,am62l3";
> > +	model = "Texas Instruments AM62L3 Evaluation Module";
> > +
> > +	aliases {
> > +		serial2 = &main_uart0;
> 
> We usually have WKUP and MCU UARTs as serial0 and serial1, we don't
> have that many, so we would never have serial1, only 0 and 2. Might
> be time we drop this odd numbering convention, at least for AM62L
> class parts..
> 

Good point. I'll see what I can come up with

> > +	};
> > +
> > +	chosen {
> > +		stdout-path = &main_uart0;
> > +	};
> > +
> > +	memory@80000000 {
> > +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> > +		device_type = "memory";
> > +		bootph-all;
> > +	};
> > +
> > +	reserved-memory {
> 
> Not needed until you have something to reserve.
> 

Ah I agree. I'll drop this next time.

> > +		ranges;
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +	};
> > +};
> > +
> > +&pmx0 {
> > +	main_uart0_pins_default: main_uart0-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62LX_IOPAD(0x01d4, PIN_INPUT, 1)	  /* (D7)  UART0_RXD */
> > +			AM62LX_IOPAD(0x01d8, PIN_OUTPUT, 1)	  /* (A6)  UART0_TXD */
> > +		>;
> > +		bootph-all;
> > +	};
> > +};
> > +
> > +&main_uart0 {
> > +	current-speed = <115200>;
> 
> current-speed is only for UARTs that can't detect their current speed,
> our UART and driver can, so this line isn't needed.
> 

Nice! I'll drop this property as well

~Bryan

