Return-Path: <linux-kernel+bounces-528989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2711A41EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80267A6978
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7292571BD;
	Mon, 24 Feb 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f4kNN1gG"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16682571A9;
	Mon, 24 Feb 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399081; cv=none; b=WTpnCPp5SCqlSF/4WDBRFG38cZBOAxE8grqZg08B75Etr702x1LouU1OGZSglmR3/t31m6gac0As2anQOvhun+cviU7JOexwEZ36CoCuaoEZr4FoW35Q2szlXf/WBsVkLKG/8iDa1gLzyzOa21dByZ7ndqt/JbiCfVjLKU6rD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399081; c=relaxed/simple;
	bh=ODQGT2jxBVYFc2B4tHTCMsKCmhMyMr8umsD4pQ/YKwA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbCcqwaEmLLG+Nu3LwM5TmKP6SaYrDyf2VOYteQVreLtVw3gnWTPt2ySl5k3XuDQTa70gLAcUHTjTnkJkVMS7ultgNNfyb4PmsNMPGaZ+npe/NhnYRwA+9EkT877Iuddp5+TG4ruJqgaXqRnmHHK1k5C1fTcElQ22MopuUHqLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f4kNN1gG; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51OCBCod910846
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 06:11:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740399072;
	bh=gp1YmZDLlctdJ2qAsgxJlardnafNa0a8HtmhPHKallg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=f4kNN1gGAr0m0N8FzVKQbvTwswQoGRbZW4+Mc9RPbqyTyPphJXJUMhnOwKkltfOdt
	 0+bY9mM2ut/had/lHM2mV1dzTfqWjE/ue8ggfpPuPQ+Bs+4k1WIQ5siTMqNNTcbejo
	 0Zp/OArPggxqwaPsgagYxVtGyA4r0agFa4S6imV8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51OCBCD2014532
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Feb 2025 06:11:12 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Feb 2025 06:11:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Feb 2025 06:11:11 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51OCBAPi119936;
	Mon, 24 Feb 2025 06:11:11 -0600
Date: Mon, 24 Feb 2025 17:41:10 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j784s4-j742s2-evm: Add overlay
 for PCIe NTB
Message-ID: <20250224121110.w3mu55otlgplcw6j@uda0492258>
References: <20250202093636.2699064-1-s-vadapalli@ti.com>
 <20250202093636.2699064-3-s-vadapalli@ti.com>
 <d6440feb-ea23-49f8-9886-82d0e2145f12@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d6440feb-ea23-49f8-9886-82d0e2145f12@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Feb 24, 2025 at 05:35:47PM +0530, Vignesh Raghavendra wrote:

Hello Vignesh,

> 
> 
> On 02/02/25 15:06, Siddharth Vadapalli wrote:
> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-pcie-ntb.dtso b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-pcie-ntb.dtso
> > new file mode 100644
> > index 000000000000..e44173f670fa
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-pcie-ntb.dtso
> > @@ -0,0 +1,92 @@
> > +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> > +/**
> > + * DT Overlay for enabling NTB functionality using PCIE0 and PCIE1 instances of
> > + * PCIe on the J784S4 EVM and the J742S2 EVM.
> > + *
> > + * J784S4 EVM Product Link: https://www.ti.com/tool/J784S4XEVM
> > + * J742S2 EVM Product Link: https://www.ti.com/tool/J742S2XH01EVM
> > + *
> > + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/soc/ti,sci_pm_domain.h>
> > +
> > +#include "k3-pinctrl.h"
> > +
> > +&{/} {
> > +	epf_bus {
> 
> 
> no underscore in node name please

Thank you for pointing this out. I will fix it in this as well as the
previous patch in this series and post the v2 series.

Regards,
Siddharth.

