Return-Path: <linux-kernel+bounces-200056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC4C8FA9E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1D41C24852
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EDD7C6D5;
	Tue,  4 Jun 2024 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qwGy6i7D"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEAE27735;
	Tue,  4 Jun 2024 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717478302; cv=none; b=sSGNZUUPBDAQdMDDxKwiXnPEmvhNXPHZWxBxtIpYojZs6RpeepMGd2eSUzss4s1LcasGfAh8pelgDq/r+EbNIQHmDFSMm3/gmhLeoYDjHZSAputKwnr6Fj/1kZx3EBFICuYHa37/Ag8rAGtpOXf9h8uvmupRckimAFOR4QHT8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717478302; c=relaxed/simple;
	bh=awkpkgJxzJisu4oVjgQB3mqJkaSX6NQoHxc4rMIMQvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU5Ym/L/5MgmwiDdpkvlesTIgk/Uqz38YUVS8tzjsFzXtIk8NxJxXDBkmItoBiI2TyE1DGzHkVg/+It67WYYFCX7xT5SIRA3wnSF6jVjmN2/fCjv7Bw2VyHQRV7/Hv9UsPIFCbN4Ql5tIi41l7p0GBDrc6KcWSDkHGtJvJbopmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qwGy6i7D; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4545IDes041860;
	Tue, 4 Jun 2024 00:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717478293;
	bh=cGPLa33dqssDxBaTz/i1bcB4UE7sLyY7nEd/MTkGCPM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qwGy6i7DBoRRr1jwZ/+kODAeFxxMj42zFJbko3IJCPdi2LBMiUNYcsjjlA9mF+NVi
	 dWs2ONzX2QiHNFmDrF8HnyBluIS9fUVlATYEIojFz2nXewW9V/szZe39ShUkdTwaUn
	 wWNj32ULZhdr5mXxVfozCSaSvZcqR5tblRYbE8vc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4545IDX1025242
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 00:18:13 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 00:18:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 00:18:13 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4545IC18114934;
	Tue, 4 Jun 2024 00:18:13 -0500
Date: Tue, 4 Jun 2024 10:48:11 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v4 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
 am62p-j722s-common-{}.dtsi
Message-ID: <b1691eef-d385-4f86-8ec0-9059d699c221@ti.com>
References: <20240601121554.2860403-1-s-vadapalli@ti.com>
 <20240601121554.2860403-2-s-vadapalli@ti.com>
 <086fa11e-10f8-463d-8966-1a33a52a3146@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <086fa11e-10f8-463d-8966-1a33a52a3146@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, Jun 03, 2024 at 09:09:39AM -0500, Andrew Davis wrote:
> On 6/1/24 7:15 AM, Siddharth Vadapalli wrote:
> > The AM62P and J722S SoCs share most of the peripherals. With the aim of
> > reusing the existing k3-am62p-{mcu,main,wakeup}.dtsi files for J722S SoC,
> > rename them to indicate that they are shared with J722S SoC.
> > 
> > The peripherals that are not shared will be moved in the upcoming patches
> > to the respective k3-{soc}-{mcu,main,wakeup}.dtsi files without "common" in
> > the filename, emphasizing that they are not shared.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > No changelog since this patch is introduced in this version of the
> > series.
> > 

[...]

> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> > similarity index 98%
> > rename from arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> > rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> > index b973b550eb9d..a5dbaf3ff41b 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> > @@ -1,6 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0-only OR MIT
> >   /*
> > - * Device Tree file for the AM62P MCU domain peripherals
> > + * Device Tree file for the mcu domain peripherals shared by AM62P and J722S
> 
> s/mcu/MCU
> 
> Same for the other domains (WAKEUP, MAIN, MCU), makes it more clear these are names,
> and not just adjectives for the domains.

I had changed the "MCU" to "mcu" to match the convention in other files.
Based on your feedback, I seem to have switched to the wrong convention.
I will fix this in the v5 series.

> 
> >    * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
> >    */
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> > similarity index 97%
> > rename from arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> > index c71d9624ea27..ca493f4e1acd 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> > @@ -1,6 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0-only OR MIT
> >   /*
> > - * Device Tree file for the AM62P wakeup domain peripherals
> > + * Device Tree file for the wakeup domain peripherals shared by AM62P and J722S
> 
> While we are here, might be good to add a newline here between the description
> and the copyright line to match the other SoCs DT files.
> 
> Otherwise,
> 
> Acked-by: Andrew Davis <afd@ti.com>

Sure, I will add the missing newline and collect your "Acked-by" tag for
this patch in the v5 series. Thank you for reviewing this patch.

[...]

Regards,
Siddharth.

