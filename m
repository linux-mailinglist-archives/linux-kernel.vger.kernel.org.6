Return-Path: <linux-kernel+bounces-310803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934896816A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D7E282917
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23012183CAA;
	Mon,  2 Sep 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ADgtYXnH"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E69717F4EC;
	Mon,  2 Sep 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264697; cv=none; b=nQCw5Ls+M069+VU26wGemznOYBIM7xKhBcmEVPTaZs+Qs98xGO7qLBkZzg6k6bG6Z/KdU4Q8JQeVsZCxCGYyTulhRdEn7D4kVw4AWYYZFyn2BcwdLl4UTHKLIVk7lig5gPD6UVhYFppYucxK9JXCYXOeVLOSKZSRAw+xF7Bfv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264697; c=relaxed/simple;
	bh=Hy/p2S+XsCNkvbN3oj3Azd3tICZv+++Zge4afnbauz8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAtGQPUFpB9GopK2OBHI6OqbkU+qVq9kwCDMouxw15lAdLhFRRG50lkp+hU2endfCBxYyXNna7uWHN6u7qzFp7WxDa3igVcpXX0huyDG53Fffe/+7TNCmlcb08kub+3PWPyjXBvE9k663Q9aRxDOmk7KIEeNL8zbofXTUAiIGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ADgtYXnH; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4828BRJO126670;
	Mon, 2 Sep 2024 03:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725264687;
	bh=sBsE1Q+E+NOzFYwa6tYGVaWt64Eys64dy0TSfuFYUVg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ADgtYXnHmkCvX1529Wpy4Bza8eN+PLPa+a2FJLf3RU+5YpqplzuXKr5QCOY3HriO1
	 NoAucdtRB61GVvkv6sIrLsdLyya664vaD2WFqF9ELIqaKa5GyB2ZgzuBaZtBJkXjqB
	 wUmQ2Q2pj57OT15VX5jVZLkkClf4g7yw59juZvug=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4828BRih015122
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 03:11:27 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 03:11:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 03:11:27 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4828BQOD013182;
	Mon, 2 Sep 2024 03:11:26 -0500
Date: Mon, 2 Sep 2024 13:41:25 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>
Subject: Re: [PATCH v5 1/5] arm64: dts: ti: Refactor J784s4 SoC files to a
 common file
Message-ID: <20240902081125.luplg4esldhw6ycp@uda0497581>
References: <20240828-b4-upstream-j742s2-v5-0-9aaa02a0faee@ti.com>
 <20240828-b4-upstream-j742s2-v5-1-9aaa02a0faee@ti.com>
 <c2568770-c80c-44d6-b3d5-a1a18f213d42@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c2568770-c80c-44d6-b3d5-a1a18f213d42@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit,

On 19:00-20240830, Kumar, Udit wrote:
> Hi Manorit
> 
> Overall series looks ok but few comments below
> 
> On 8/28/2024 4:44 PM, Manorit Chawdhry wrote:
> > Refactor J784s4 SoC files to a common file which uses the
> > superset device to allow reuse in j742s2-evm which uses the subset part.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
> > ---
> >   .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  150 ++
> >   .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2667 ++++++++++++++++++
> >   ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
> >   ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
> >   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2847 +-------------------
> >   arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  135 +-
> >   6 files changed, 2914 insertions(+), 2887 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
> > new file mode 100644
> > index 000000000000..43fee57f0926
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
> > @@ -0,0 +1,150 @@
> > +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> > +/*
> > + * Device Tree Source for J784S4 and J742S2 SoC Family
> > + *
> > + * TRM (j784s4) (SPRUJ43 JULY 2022): https://www.ti.com/lit/zip/spruj52
> > + * TRM (j742s2): https://www.ti.com/lit/pdf/spruje3
> > + *
> > [..]		 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
> > +			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
> > +			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
> > +			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIe0 Core*/
> > +			 <0x00 0x0d800000 0x00 0x0d800000 0x00 0x00800000>, /* PCIe1 Core*/
> > +			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x00800000>, /* PCIe2 Core*/
> > +			 <0x00 0x0e800000 0x00 0x0e800000 0x00 0x00800000>, /* PCIe3 Core*/
> 
> 
> PCie2 and PCIe3 ranges are not common across these devices,
> 
> Do you want to move this into J784s4 specific file
> 
> Same comment for PCIe region DAT below

This was already discussed in the previous revision and my stance is not
to change it due to maintainance reasons [0].

> 
> > [..]
> 
> > 			 <0x42 0x00000000 0x42 0x00000000 0x01 0x00000000>, /* PCIe2 DAT1 */
> > +			 <0x43 0x00000000 0x43 0x00000000 0x01 0x00000000>, /* PCIe3 DAT1 */
> 
> [..]
> 
> +#include "k3-j784s4-j742s2-main-common.dtsi"
> > +#include "k3-j784s4-j742s2-mcu-wakeup-common.dtsi"
> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > [...]
> > +
> > +&cbass_main {
> > +	msmc_ram: sram@70000000 {
> > +		compatible = "mmio-sram";
> > +		reg = <0x00 0x70000000 0x00 0x800000>;
> 
> Table 2-1 of J742S2 TRM says msmc RAM is 4MB and on J784S4 this is 8MB
> 
> Please see, if you can address that
> 

I think this was thought through before. So from my understanding, this
memory map is just a dummy node that the bootloaders is supposed to be
fixing up based on it's usecase [1]. Though ig it's not very intuitive
looking at the DT, let me add a comment in the corresponding node to
clarify this.

"MSMC is configured by bootloaders and a runtime fixup is done in the DT
for this node"

Would you be okay with the following comment in the DT node for MSMC but
keeping the following node in common file only?

Regards,
Manorit

[0]: https://lore.kernel.org/linux-arm-kernel/20240827082445.bfx2r7z4iry4fdax@uda0497581/
[1]: https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html?highlight=query#tisci-msg-query-msmc
> 
> > [...]
> > 

