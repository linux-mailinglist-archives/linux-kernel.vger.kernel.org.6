Return-Path: <linux-kernel+bounces-278881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306D94B602
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FA81C21D77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D52B132132;
	Thu,  8 Aug 2024 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K6SUYA0X"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2B43152;
	Thu,  8 Aug 2024 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723092759; cv=none; b=r0mG+Er/J+Soey30/ord9IrOcQMN9SogrPcHvIIm8UfoFlQhOWdsTzcuqWDT146KU7SuR3sXHAxZteGlydfRCJ4BkCNJE2J/T7oCBr4e9Rs8o9xDSz13n/cvQMKtpzZfuxin1nIDAsRCtO0xmvx7Wu2EHHQQkKmUuRWMYQWDwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723092759; c=relaxed/simple;
	bh=W+bPGJjAKPxVPN0keA7T/Zakm/6Kt6tYu69zeJwiEnY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfnQPeGipgGbl//emtWtx/wRO8isffstBzHWTSCCdPQf8wWhNOPrGUXw19jZFfk0CWke+AdVRE4Qf1O9nZZJ3CxX9kPrr5ryMTsntMxGI/91FRtWVPaFiwaKK/JE58A4QcvzBklk7qx1OM/f3zzicK9I4fsy9SHrQLsyUgPGdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K6SUYA0X; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4784qTfP084353;
	Wed, 7 Aug 2024 23:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723092749;
	bh=GpoFVbvgf9n1I26bMtC5jBl2LFO9UwiJs5Uvq/Xceu8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=K6SUYA0XMfpeOfLspa0jGpgy409BbnYuHhPrRWXAdPTA5j9IcpJwNAbn++t193UDd
	 /rAMFVwZJw98OVd715dUCWH9lsKO63hgzT7tIXPmgFTOkmzrwwucCW+I9eQgNJpuLE
	 4xgK3WKVv0cWVqPabVI/l/BuHvOHEZa+O1lFcQ20=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4784qTrr108405
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 23:52:29 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 23:52:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 23:52:28 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4784qSGS025365;
	Wed, 7 Aug 2024 23:52:28 -0500
Date: Thu, 8 Aug 2024 10:22:27 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: Re: [PATCH v3 4/9] arm64: dts: ti: Split
 k3-j784s4-j742s2-main-common.dtsi
Message-ID: <20240808045227.apxwcpi5b3w6n4xo@uda0497581>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
 <20240731-b4-upstream-j742s2-v3-4-da7fe3aa9e90@ti.com>
 <20240807132054.jcz5fdokc5yk3mbo@entrust>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240807132054.jcz5fdokc5yk3mbo@entrust>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > new file mode 100644
> > index 000000000000..2ea470d1206d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> > +/*
> > + * Device Tree Source for J784S4 SoC Family Main Domain peripherals
> > + *
> > + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> > + */
> > +
> > +&cbass_main {
> > +	c71_3: dsp@67800000 {
> > +		compatible = "ti,j721s2-c71-dsp";
> > +		reg = <0x00 0x67800000 0x00 0x00080000>,
> > +		      <0x00 0x67e00000 0x00 0x0000c000>;
> > +		reg-names = "l2sram", "l1dram";
> > +		ti,sci = <&sms>;
> > +		ti,sci-dev-id = <40>;
> > +		ti,sci-proc-ids = <0x33 0xff>;
> > +		resets = <&k3_reset 40 1>;
> > +		firmware-name = "j784s4-c71_3-fw";
> > +		status = "disabled";
> > +	};
> > +};
> 
> I am looking at https://www.ti.com/lit/ug/spruje3/spruje3.pdf (page 26),
> Device Comparison:
> 
> CPSW/Serdes, PCIE is also different? Was that missed?

I had talked to Siddharth in the past regarding that and he had
mentioned that no change would be required with the previous patchsets
that I had shared, adding him to the thread 

Regards,
Manorit

