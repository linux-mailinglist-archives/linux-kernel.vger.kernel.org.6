Return-Path: <linux-kernel+bounces-278885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADC594B60F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A561F238B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01EA13213A;
	Thu,  8 Aug 2024 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sVl/MG5P"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D112F50;
	Thu,  8 Aug 2024 05:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723093379; cv=none; b=d0HhcVh1XAejDdlOVFZztksHqLSmoe5jGUpjQX3R35cmNIcLTqgpOj1gDdkvvRUthn6qP4ZqXfyseB3cSwG3N2nV6/eLIuHN1DLKhcoAh30sC8kfBxFzt7XMghgCjMD8+HxACjZprLcjZfTDtSNoXdFgzNOpc/aE3dRSsGeKiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723093379; c=relaxed/simple;
	bh=VRwjAOZy2F8q3/AVTa/BT6iXSzulicAkubiO/GNKrKA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlEHEtqLl06KXGL7Ug0R9lCmNValrOzBvCfPboHwn42wlyac3IjSLFvlfAtt4sbe9e5co3xrUgrnLuJUIGu/twOcdx3Rlkm9OlxUlPucOxTOatXuKvuA3OqNVntnAW88BUg9V4lZcvMtYKv7xfDAuqzttb6jau1AY9YWhMW00OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sVl/MG5P; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47852maX011078;
	Thu, 8 Aug 2024 00:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723093368;
	bh=zEomHmpR9gxi8kjhdkOQJXfsQe2MvwI9u3nUs24Eb98=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=sVl/MG5PVv1mChj9mnFix0T+UYm4j3Qu5e6QrRGwmQsz4OCew7AJuge+bMcM102eM
	 4g/au3lqY1ngI9EbQK3Xlb5H86adTh8aYqBjhm3LKPn2CM0JKtZdDGzqoKc6ZEZURQ
	 MnBXsPBWMwOyKkTnWlaBC8Bjbsc/D0y70DrfLtRc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47852mRN009075
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 00:02:48 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 00:02:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 00:02:48 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47852lfS042333;
	Thu, 8 Aug 2024 00:02:47 -0500
Date: Thu, 8 Aug 2024 10:32:46 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Use 4 lanes for PCIe0 on
 EVM
Message-ID: <b1fc3349-ea1c-47ff-880c-044689b9b8e8@ti.com>
References: <20240720110455.3043327-1-s-vadapalli@ti.com>
 <20240807132847.3qca5ijdwsasdf4y@legroom>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240807132847.3qca5ijdwsasdf4y@legroom>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Aug 07, 2024 at 08:28:47AM -0500, Nishanth Menon wrote:
> On 16:34-20240720, Siddharth Vadapalli wrote:
> > The PCIe0 instance of the PCIe controller on J784S4 SoC supports up to 4
> > lanes. Additionally, all 4 lanes of PCIe0 can be utilized on J784S4-EVM
> > via SERDES1. Since SERDES1 is not being used by any peripheral apart
> > from PCIe0, use all 4 lanes of SERDES1 for PCIe0.
> > 
> > Fixes: 27ce26fe52d4 ("arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode")
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

[...]

> >  	serdes1_pcie0_link: phy@0 {
> >  		reg = <0>;
> > -		cdns,num-lanes = <2>;
> > +		cdns,num-lanes = <4>;
> >  		#phy-cells = <0>;
> >  		cdns,phy-type = <PHY_TYPE_PCIE>;
> > -		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>;
> > +		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>,
> > +			 <&serdes_wiz1 3>, <&serdes_wiz1 4>;
> >  	};
> 
> OK - I see the reason why
> https://lore.kernel.org/all/20240807132054.jcz5fdokc5yk3mbo@entrust/
> was missed.
> 
> Please sync with Manorit to make sure we sequence these correctly -
> looks to me that this fixup needs to get in first? have you also checked
> up on AM69-SK ?

J784S4 SoC has 4 instances of PCIe -> PCIe0, PCIe1, PCIe2 and PCIe3.
All 4 instances have been described in k3-j784s4-main.dtsi.
Of the 4 instances PCIe0 and PCIe1 are brought out on J784S4-EVM.
Therefore, k3-j784s4-evm.dts enables only PCIe0 and PCIe1.

This patch allocates all 4 lanes of SERDES1 to PCIe0 on J784S4-EVM since
no other peripheral is sharing SERDES1 with PCIe0.

On AM69-SK, all 4 lanes of SERDES1 have correctly been assigned to
PCIe0, due to which no fix is required.

J742S2 SoC has 2 instances of PCIe -> PCIe0 and PCIe1. They have the
same connections w.r.t. SERDES as J784S4 SoC i.e.
PCIe0 -> 4 Lanes of SERDES1
PCIe1 -> 2 Lanes of SERDES0

So PCIe2 and PCIe3 have to be removed from
k3-j784s4-j742s2-main-common.dtsi
in the patch by Manorit at:
https://lore.kernel.org/r/20240731-b4-upstream-j742s2-v3-4-da7fe3aa9e90@ti.com/
and added in k3-j784s4-main.dtsi similar to the "c71_3: dsp@67800000" node.

The changes made by this patch (assigning all 4 lanes of SERDES1 to PCIe0)
will be applicable to J742S2-EVM as well.

Regards,
Siddharth.

