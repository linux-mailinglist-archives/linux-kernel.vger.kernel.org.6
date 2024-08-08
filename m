Return-Path: <linux-kernel+bounces-278894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16CA94B643
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300A31F21BF6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84F166315;
	Thu,  8 Aug 2024 05:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nm7TNx6e"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED201662F7;
	Thu,  8 Aug 2024 05:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094901; cv=none; b=N39wznzFGINP+sUb5TGDj6X9XqwawRQesICZ+CkZUiyZfoR9GKB2sWKBJe2WtIMVxwGmtj1Xj73+5vqPtduce7QS+wvtoWppUQS0iRptV4jdssCzNDeRpS8h+Scsi2Nbe/MNFmzHwokbSn2TI8o/z/QMOEhev2xb3EIJboiwLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094901; c=relaxed/simple;
	bh=50u/PJJE2y6hWxNz/1Sj/FFVUMcYTZPke6+4D1/JDbs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQqspuYzrvPpqhzvEOeUrhU77b4EWu0g6wHGHzJvbQmgj1iCG2fX5l88/coB+i+cJ8XoW+O5MLh4bC6IXxCcAKb2aACY06ad25muJ3VmsW4RCU/nvTLI/IdLAgzjb+mK9js5ebK05iZAnpBp4iGSpyPd24jsjAq2bw39+oVv0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nm7TNx6e; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4785SDHH044012;
	Thu, 8 Aug 2024 00:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723094893;
	bh=DlSg9rO9sZgKzoNV1/QwBFYweIf7uvIJ3TG1yIbVKS0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=nm7TNx6esO5AKiqmaRLPrOoMTqw0Pch7uFKycT20snwQiaxS2bBXkLUj2xWHcltSr
	 59kZrb9YfpnC8RWe5BydhDn/aGeoeMwu9HEb2B+iTBwBuNNlEOGzHoVL3BWD68WJBa
	 5b/XgpyzKJgzRB+jp4k827gKbExAcu6TBLd4xgZo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4785SDL8130379
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 00:28:13 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 00:28:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 00:28:12 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4785SB2t066507;
	Thu, 8 Aug 2024 00:28:12 -0500
Date: Thu, 8 Aug 2024 10:58:11 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Nishanth Menon <nm@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: Re: [PATCH v3 4/9] arm64: dts: ti: Split
 k3-j784s4-j742s2-main-common.dtsi
Message-ID: <8cf2f7aa-1c57-40bd-80cc-14e5bd5623a8@ti.com>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
 <20240731-b4-upstream-j742s2-v3-4-da7fe3aa9e90@ti.com>
 <20240807132054.jcz5fdokc5yk3mbo@entrust>
 <20240808045227.apxwcpi5b3w6n4xo@uda0497581>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240808045227.apxwcpi5b3w6n4xo@uda0497581>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Aug 08, 2024 at 10:22:27AM +0530, Manorit Chawdhry wrote:
> Hi Nishanth,
> 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > > new file mode 100644
> > > index 000000000000..2ea470d1206d
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > > @@ -0,0 +1,21 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> > > +/*
> > > + * Device Tree Source for J784S4 SoC Family Main Domain peripherals
> > > + *
> > > + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> > > + */
> > > +
> > > +&cbass_main {
> > > +	c71_3: dsp@67800000 {
> > > +		compatible = "ti,j721s2-c71-dsp";
> > > +		reg = <0x00 0x67800000 0x00 0x00080000>,
> > > +		      <0x00 0x67e00000 0x00 0x0000c000>;
> > > +		reg-names = "l2sram", "l1dram";
> > > +		ti,sci = <&sms>;
> > > +		ti,sci-dev-id = <40>;
> > > +		ti,sci-proc-ids = <0x33 0xff>;
> > > +		resets = <&k3_reset 40 1>;
> > > +		firmware-name = "j784s4-c71_3-fw";
> > > +		status = "disabled";
> > > +	};
> > > +};
> > 
> > I am looking at https://www.ti.com/lit/ug/spruje3/spruje3.pdf (page 26),
> > Device Comparison:
> > 
> > CPSW/Serdes, PCIE is also different? Was that missed?
> 
> I had talked to Siddharth in the past regarding that and he had
> mentioned that no change would be required with the previous patchsets
> that I had shared, adding him to the thread 

Manorit,

Since J784S4-EVM enables only PCIe0 and PCIe1 which matches the
instances enabled/supported on J742S2-EVM, I had informed you that for
the purpose of validation, no changes will be required w.r.t. PCIe, if
k3-j742s2-evm.dts is including k3-j784s4-evm.dts. However, considering
that the device-tree should describe the hardware, when upstreaming the
device-tree for J742S2, PCIe2 and PCIe3 should be deleted
(if k3-j784s4-evm.dts is included by k3-j742s2-evm.dts) OR dropped
(if there is a "common" file that is used to describe the peripherals
common to J742S2 and J784S4 as done in the current series).

Also, SERDES2 is not present on J742S2 SoC while J784S4 has SERDES0,
SERDES1, SERDES2 and SERDES4. There is no difference w.r.t. CPSW9G in
terms of the CPSW9G instance itself, but the difference is that CPSW9G
cannot use SERDES2. So CPSW9G can only be used with SERDES4 on J742S2
SoC, but J742S2-EVM has the SERDES4 lines connected to Display Ports,
due to which CPSW9G is essentially non-functional on J742S2-EVM.

Regards,
Siddharth.

