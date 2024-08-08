Return-Path: <linux-kernel+bounces-279316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E43194BBB8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062651F21CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11F18A950;
	Thu,  8 Aug 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vs1DHuz6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6218B462;
	Thu,  8 Aug 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114465; cv=none; b=YeI4wca2k7CisXjtdjNKL0e986nMqgz/6CCsh8HdIsHxokVi+qxncWjk6+XazMxQqP+Z1Q39RqH9jkk/8GhaflTOlsfDu/CSvNUJak244g35ukcxpWOZeWOXLlUq+W77PS7xp/FbM9Y5rCwxJLFjFCkYh1jm2aGMCtvjYhKGDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114465; c=relaxed/simple;
	bh=8HgPvyoY6wCFiNfdtRkudqzw/3dvpaQ/tVEDtAaOtKI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic8KXnyhz94+99qQ5pUDkmjJwNEsk4rYnwruY195BsMGvRnRkZihbfzHr3C7oGYcbC5HjCbWuqLX1JF1tn1gBXMrFRVaBeqQZH98CJQUUt53nWNN1fa7MRmi7w3/5p2Wr8ibByYUn/fWxE1rLdzveiuqg8qyWkMevk4h97ICZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vs1DHuz6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478AsHer044625;
	Thu, 8 Aug 2024 05:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723114457;
	bh=XQVOyYw+ALCdemwS1tkNko11Pdu0J+2HzF7/ISYYGNM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Vs1DHuz6BXhZoJgc1I+bXG1fMfvt4aawi/li5G2H2bYniupJfTLGAl7iTHoIb2n3M
	 v9oyvW9/u0SVZYu65kB7Ge1tzaN9/YZpA5gKJTHf58AGbijlrEg3u7ebb1BDdLMILf
	 rmEQvJ5d+LuZmODWK+rGs3FAnYNQfm5FJswUe0xI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478AsHmf009556
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 05:54:17 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 05:54:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 05:54:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478AsHGc065005;
	Thu, 8 Aug 2024 05:54:17 -0500
Date: Thu, 8 Aug 2024 05:54:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: Re: [PATCH v3 4/9] arm64: dts: ti: Split
 k3-j784s4-j742s2-main-common.dtsi
Message-ID: <20240808105417.e37xggi3xr3hoptx@polar>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
 <20240731-b4-upstream-j742s2-v3-4-da7fe3aa9e90@ti.com>
 <20240807132054.jcz5fdokc5yk3mbo@entrust>
 <20240808045227.apxwcpi5b3w6n4xo@uda0497581>
 <8cf2f7aa-1c57-40bd-80cc-14e5bd5623a8@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8cf2f7aa-1c57-40bd-80cc-14e5bd5623a8@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:58-20240808, Siddharth Vadapalli wrote:
> On Thu, Aug 08, 2024 at 10:22:27AM +0530, Manorit Chawdhry wrote:
> > Hi Nishanth,
> > 
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > > > new file mode 100644
> > > > index 000000000000..2ea470d1206d
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > > > @@ -0,0 +1,21 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> > > > +/*
> > > > + * Device Tree Source for J784S4 SoC Family Main Domain peripherals
> > > > + *
> > > > + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> > > > + */
> > > > +
> > > > +&cbass_main {
> > > > +	c71_3: dsp@67800000 {
> > > > +		compatible = "ti,j721s2-c71-dsp";
> > > > +		reg = <0x00 0x67800000 0x00 0x00080000>,
> > > > +		      <0x00 0x67e00000 0x00 0x0000c000>;
> > > > +		reg-names = "l2sram", "l1dram";
> > > > +		ti,sci = <&sms>;
> > > > +		ti,sci-dev-id = <40>;
> > > > +		ti,sci-proc-ids = <0x33 0xff>;
> > > > +		resets = <&k3_reset 40 1>;
> > > > +		firmware-name = "j784s4-c71_3-fw";
> > > > +		status = "disabled";
> > > > +	};
> > > > +};
> > > 
> > > I am looking at https://www.ti.com/lit/ug/spruje3/spruje3.pdf (page 26),
> > > Device Comparison:
> > > 
> > > CPSW/Serdes, PCIE is also different? Was that missed?
> > 
> > I had talked to Siddharth in the past regarding that and he had
> > mentioned that no change would be required with the previous patchsets
> > that I had shared, adding him to the thread 
> 
> Manorit,
> 
> Since J784S4-EVM enables only PCIe0 and PCIe1 which matches the
> instances enabled/supported on J742S2-EVM, I had informed you that for
> the purpose of validation, no changes will be required w.r.t. PCIe, if
> k3-j742s2-evm.dts is including k3-j784s4-evm.dts. However, considering
> that the device-tree should describe the hardware, when upstreaming the
> device-tree for J742S2, PCIe2 and PCIe3 should be deleted
> (if k3-j784s4-evm.dts is included by k3-j742s2-evm.dts) OR dropped
> (if there is a "common" file that is used to describe the peripherals
> common to J742S2 and J784S4 as done in the current series).
> 
> Also, SERDES2 is not present on J742S2 SoC while J784S4 has SERDES0,
> SERDES1, SERDES2 and SERDES4. There is no difference w.r.t. CPSW9G in
> terms of the CPSW9G instance itself, but the difference is that CPSW9G
> cannot use SERDES2. So CPSW9G can only be used with SERDES4 on J742S2
> SoC, but J742S2-EVM has the SERDES4 lines connected to Display Ports,
> due to which CPSW9G is essentially non-functional on J742S2-EVM.


Thanks Siddharth. Manorit: Please address the above in the next rev.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

