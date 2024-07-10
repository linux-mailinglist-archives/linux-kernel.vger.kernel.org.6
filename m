Return-Path: <linux-kernel+bounces-247025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E19E692CA10
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9101F24164
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D72F4597B;
	Wed, 10 Jul 2024 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jl3YCnKU"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437A4A07;
	Wed, 10 Jul 2024 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720587618; cv=none; b=ZhX8oEEzbQ+/gFqoK9D6UtnIdt82E2rz2C+RmS7oOJJYP4I0zBMxrfkG3aXw53NF1MVR8M//oLZsIO9LnA+wAiQGcFlo75PmKWD9dM7Onu7PRtji8dBMLVgdfLZpVxh17W5mR84BPri1omyrRFMNBr5zMQt95sB9pDhd7BMD3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720587618; c=relaxed/simple;
	bh=pI4XSLU0+3UNmL28LII8gHITrzyjHueWVVed6laXvBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdR8Z6jpTJtgn9yxKI4kRybv+IeahxRBisT0gZ7wRmRCHxHMV+6uSWjRhBj94fjmyaVQV3DYpJEYfjuNGD0/kD9Zz0bVZbY+TEWGy4VNDEIg4m3XDlX0E3vOIIkHDguEXfuaQqjpyr2Puf76IJcQYZLkrAu4mZvP0jzLSW2B6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jl3YCnKU; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46A4xmnm059734;
	Tue, 9 Jul 2024 23:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720587588;
	bh=Q7P3aIhdZOB3zwAz4JcRP+9F7wT1ukLiFU2YAebXE40=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jl3YCnKUhCTLPH9YUlnX3ba18w7/Fvjq6iIFb8SKFqsUw5+DiZ+RGy7aIdFFT2me1
	 vr08Zqwbuu7DWkuNS/8By319/QlPJKWO+C2vjogYj9fyi3rw0sy0rn4s/cDzH1aY5I
	 2OtXWQengPw2XrrR9wl6Xm7VSCHVLCPgyR4yO/JA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46A4xmnU010468
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 23:59:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jul 2024 23:59:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jul 2024 23:59:48 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46A4xk3E064380;
	Tue, 9 Jul 2024 23:59:47 -0500
Date: Wed, 10 Jul 2024 10:29:46 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Halaney <ahalaney@redhat.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <thomas.richard@bootlin.com>, <theo.lebrun@bootlin.com>,
        <make24@iscas.ac.cn>, <linux-phy@lists.infradead.org>,
        <s-vadapalli@ti.com>, <mranostay@ti.com>
Subject: Re: [BUG] k3-j784s4-evm/phy-cadence-torrent: Shared reset using
 exclusive API
Message-ID: <46e635e6-b6bf-404c-87a2-57fe25b4855a@ti.com>
References: <yhtb4clns57t7qo5yxil3oofisdlzfubyiwrvjo2ufw2ngv67m@g6p7ktxfgfv3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yhtb4clns57t7qo5yxil3oofisdlzfubyiwrvjo2ufw2ngv67m@g6p7ktxfgfv3>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Jul 09, 2024 at 04:57:09PM -0500, Andrew Halaney wrote:
> Hi,
> 

[...]

> 
> this is because the devicetree has two[0][1] consumers of the same reset:
> 
> 	&serdes0 {
> 		status = "okay";
> 
> 		serdes0_pcie1_link: phy@0 {
> 			reg = <0>;
> 			cdns,num-lanes = <4>;
> 			#phy-cells = <0>;
> 			cdns,phy-type = <PHY_TYPE_PCIE>;
> 			resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>,
> 				 <&serdes_wiz0 3>, <&serdes_wiz0 4>;
> 		};
> 	};
> 	...
> 	&serdes0 {
> 		status = "okay";
> 
> 		serdes0_usb_link: phy@3 {
> 			reg = <3>;
> 			cdns,num-lanes = <1>;
> 			#phy-cells = <0>;
> 			cdns,phy-type = <PHY_TYPE_USB3>;
> 			resets = <&serdes_wiz0 4>;
> 		};
> 	};
> 
> phy-cadence-torrent (the serdes0 consumer here) uses the exclusive consumer API[2],
> so this blows up.
> 
> Is the problem here that one of the above devicetree nodes is using the wrong
> reset, or does the driver need to look into using the shared API? I'm
> not sure where to find the reset definitions for the IP here unfortunately,
> so I'm hoping someone can help confirm if those are correct or not.

No, the resets are correct. Both PCIe1 and USB0 use the same instances
of SERDES which is SERDES0. I had posted the series for PCIe at:
https://lore.kernel.org/r/20240529082259.1619695-1-s-vadapalli@ti.com/
with all 4 Lanes of SERDES0 given to PCIe1. Similarly, Ravi had posted
the series for USB at:
https://lore.kernel.org/r/20240507095545.8210-1-r-gunasekaran@ti.com/
with lane 3 of SERDES0 given to USB0.

Since both of the series got merged on the same day (14 Jun 2024):
PCIe series:
https://lore.kernel.org/r/171826022277.240984.16790260886500529482.b4-ty@ti.com/
USB series:
https://lore.kernel.org/r/171826022274.240984.5150753966671933401.b4-ty@ti.com/
the dependency was unknown when the individual series were posted as
neither of them was a part of linux-next/ti-k3-dts-next when the other
one was posted.

> 
> Total aside, I think we should put the above dts snippet into one &serdes0 reference
> for readability sake. I'd post the patch but I'm hoping to get the above answered
> first in order to clean that up before shuffling things around for readability sake.

Yes, I agree that both sub-nodes should go into the same referenced
serdes0 node in k3-j784s4-evm.dts. The reason it didn't happen that way
to begin with is due to the fact that both series got merged on the same
day as I pointed out above.

The fix in this case will be to assign lanes 0 and 1 of SERDES0 to PCIe1
and lane 3 to USB0 with lane 2 left unused since PCIe doesn't have the
concept of a x3 link. In such a configuration, the device-tree nodes
will look like:

&serdes0 {
	status = "okay";

	serdes0_pcie1_link: phy@0 {
		reg = <0>;
		cdns,num-lanes = <2>;
		#phy-cells = <0>;
		cdns,phy-type = <PHY_TYPE_PCIE>;
		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
	};

	serdes0_usb_link: phy@3 {
		reg = <3>;
		cdns,num-lanes = <1>;
		#phy-cells = <0>;
		cdns,phy-type = <PHY_TYPE_USB3>;
		resets = <&serdes_wiz0 4>;
	};
};

Thank you for pointing out this issue. Please let me know if you plan to
post the patch with the above fix or you want me to post the patch for it.

Regards,
Siddharth.

