Return-Path: <linux-kernel+bounces-302860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA834960459
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1D1B23C30
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C661946B0;
	Tue, 27 Aug 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OK/6f/7B"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4054656;
	Tue, 27 Aug 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747095; cv=none; b=d0rCjLlEoZf7VPCnTar8NoosFEMQhXlSq3yBcLPMYf3F5FwJ8bhDD51AFzpMHNDPt2xGKoSiALsQJMoZaHQVw9JrFwfoEeJsFd6eRJFid1/r8w/Fgsd/9Z42hLPaAoLF4h/d+iDE4XAaTFQFDs6nTcIKehv2NbN/uj8Ei086nXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747095; c=relaxed/simple;
	bh=fDb05/GlohdbMvFzyB5TlcQZfIXMoMpO5WntEoRVcIA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMRVno1cOzZLL6XoK3HlwGwJ/P065WOkjGUdeuTJEEwXmm/mh9YEnYH23UBiXcIYNNZ7wgf85K8Z+HGJSgasAYsqDpC7Dk9xzK1RJuriJV0kT5mi5+KhoffO5sIobej3C16RdmMNPOjAd77Uum9fUnHI7bt8kXDmZuxuGt9nnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OK/6f/7B; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47R8Ok2M123517;
	Tue, 27 Aug 2024 03:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724747086;
	bh=aZYwLxzvdmoVR2ZZdmcun/ctee6z6fnD5RXCnZoCHMI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=OK/6f/7B50ophM6Ftu9Zu1iUrukugGEID8u6MlHoDqI1sRVSs3S+Crl7b7ODPhTqn
	 RGXq+l/muZX2q1P7k8uvjh0pX709H2azlsvFDnIbC++90a8N7cMYqQYorOO8PAcSPF
	 xPt1bYGCYkU3yhp4SKKOwAYmm6+gXtTkVc04cHCc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47R8OkDs040433
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 03:24:46 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 03:24:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 03:24:46 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47R8OjrI012813;
	Tue, 27 Aug 2024 03:24:46 -0500
Date: Tue, 27 Aug 2024 13:54:45 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>
Subject: Re: [PATCH v4 1/5] arm64: dts: ti: Refactor J784s4 SoC files to a
 common file
Message-ID: <20240827082445.bfx2r7z4iry4fdax@uda0497581>
References: <20240819-b4-upstream-j742s2-v4-0-f2284f6f771d@ti.com>
 <20240819-b4-upstream-j742s2-v4-1-f2284f6f771d@ti.com>
 <78410d3c-0426-42e3-a0fa-480f845542da@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <78410d3c-0426-42e3-a0fa-480f845542da@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Siddharth,

On 13:36-20240827, Siddharth Vadapalli wrote:
> On Mon, Aug 19, 2024 at 03:09:35PM +0530, Manorit Chawdhry wrote:
> > Refactor J784s4 SoC files to a common file which uses the
> > superset device to allow reuse in j742s2-evm which uses the subset part.
> > 
> > Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  149 +
> >  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2667 ++++++++++++++++++
> >  ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
> >  ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
> >  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2847 +-------------------
> >  arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  135 +-
> >  6 files changed, 2913 insertions(+), 2887 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
> > new file mode 100644
> > index 000000000000..958054ab1018
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
> > @@ -0,0 +1,149 @@
> > +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> > +/*
> > + * Device Tree Source for J784S4 SoC Family
> 
> Since the file is already named "...-j784s4-j742s2-...", wouldn't it be
> better to add J742S2 and the link to its TRM here itself rather than
> adding it in patch 4/5?

I would align this, thanks!

> 
> > + *
> > + * TRM (SPRUJ43 JULY 2022): https://www.ti.com/lit/zip/spruj52
> > + *
> > + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> 
> Since this is a new file and not a moved file, should it simply be "2024"?

The content of this file is copyright since 2022 so it seemed
counter-intuitive to me to remove that copyright, if the flow is to
remove older copyright whenever file is moved then I can do it but need
to know what is followed here.

> 
> > + *
> > + */
> 
> [...]
> 
> > +
> > +
> > +	cbass_main: bus@100000 {
> > +		bootph-all;
> > +		compatible = "simple-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
> > +			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
> > +			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
> > +			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
> 
> Since SERDES2 lies in the above range, to be techincally correct, the
> above range should be split up to move SERDES2 out of the common file.

It's a maintainance overhead as whatever support is being added to
j784s4 would have to be explicitely ported to j742s2 by adding ranges, I
know it's technically correct to add j742s2 ranges in a separate file
but it's not worth the maintainance that future development on both the
devices would be bringing so I think keeping it the same would be the
way to go.

> 
> > +			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
> > +			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
> > +			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIe0 Core*/
> > +			 <0x00 0x0d800000 0x00 0x0d800000 0x00 0x00800000>, /* PCIe1 Core*/
> > +			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x00800000>, /* PCIe2 Core*/
> > +			 <0x00 0x0e800000 0x00 0x0e800000 0x00 0x00800000>, /* PCIe3 Core*/
> 
> PCIe2 and PCIe3 should be dropped from the common file.
> 
> > +			 <0x00 0x10000000 0x00 0x10000000 0x00 0x08000000>, /* PCIe0 DAT0 */
> > +			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
> > +			 <0x00 0x64800000 0x00 0x64800000 0x00 0x0070c000>, /* C71_1 */
> > +			 <0x00 0x65800000 0x00 0x65800000 0x00 0x0070c000>, /* C71_2 */
> > +			 <0x00 0x66800000 0x00 0x66800000 0x00 0x0070c000>, /* C71_3 */
> > +			 <0x00 0x67800000 0x00 0x67800000 0x00 0x0070c000>, /* C71_4 */
> > +			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
> > +			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00400000>, /* MSMC RAM */
> > +			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
> > +			 <0x40 0x00000000 0x40 0x00000000 0x01 0x00000000>, /* PCIe0 DAT1 */
> > +			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
> > +			 <0x42 0x00000000 0x42 0x00000000 0x01 0x00000000>, /* PCIe2 DAT1 */
> > +			 <0x43 0x00000000 0x43 0x00000000 0x01 0x00000000>, /* PCIe3 DAT1 */
> > +			 <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* PCIe2 DAT0 */
> > +			 <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* PCIe3 DAT0 */
> 
> PCIe2 and PCIe3 should be dropped from the common file.
> 
> > +			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
> > +
> > +			 /* MCUSS_WKUP Range */
> > +			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
> > +			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>,
> > +			 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>,
> > +			 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
> 
> [...]
> 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > new file mode 100644
> > index 000000000000..04d77c42442d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > @@ -0,0 +1,2667 @@
> > +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> > +/*
> > + * Device Tree Source for J784S4 and J742S2 SoC Family Main Domain peripherals
> 
> Here, you have mentioned J742S2 as well, so to keep it consistent,
> J742S2 should be mentioned in the "k3-j784s4-j742s2-common.dtsi" file as
> well as I have indicated above.
> 
> > + *
> > + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> 
> Since this is a new file and not a renamed file, shouldn't it be "2024"?
> 
> > + */
> > +
> > +#include <dt-bindings/mux/mux.h>
> > +#include <dt-bindings/phy/phy.h>
> > +#include <dt-bindings/phy/phy-ti.h>
> > +
> 
> [...]
> 
> Regards,
> Siddharth.

Regards,
Manorit

