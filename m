Return-Path: <linux-kernel+bounces-279307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF494BB9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06571C2190C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC63C18A95B;
	Thu,  8 Aug 2024 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y/esBD0z"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A81119A;
	Thu,  8 Aug 2024 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114116; cv=none; b=BWYvk1mAXotAdY/i5nGQth7cf4FSGQUSYGBcilRSKfAZhAixRvoO0/8w6+yHBXfEJGfUGO7//YXmwLsgsenh92xMPslTmw8EJvkyJggR0vZGlraqY0zSCf7NUY2hDINTcvn++vYEn6bOInCW7BuKHxzHunRhdL9MG1/UW8jhsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114116; c=relaxed/simple;
	bh=rT4GoBskL5bnanqSJ3JyerWyQmnvyOyVDfnADfOSjgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX650W7+qyzh05VXdZpIQGT9BUFgNAqozGJY93gK4eO7degujkZ4uoWGh2wFzOss4zDj5ZIUUk51sQMP64Ajwxj4qo6Q+ZaTOr40//E+xFhP2qHkZ0NiwZl3M+jA2HQPrjF5/djAUrATDQlU/svijebkMwzXUWjj2w3Q9Oce2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y/esBD0z; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478AmTh9124093;
	Thu, 8 Aug 2024 05:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723114109;
	bh=NcE50/a1GJ2r8dKBhg2uwwyaUpU4LVH533Cgj3IbqSI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Y/esBD0zLaz6ZWG3AfPtzssSbpVKiYnV/MXf5k6qPu+NprXkIRREcqoejumZIVTAZ
	 VsEIYmZaFmx4jac4F4/6dnsCBtJtwsOTd0RSL24HxRzZRe3Ifl7AXFu7FaB9ROa5Uc
	 HceW7d5pEX6/sh7uqPr2FwQBCyQd0QGnNnqBc4Tk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478AmTo0053727
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 05:48:29 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 05:48:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 05:48:28 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478AmSUs041031;
	Thu, 8 Aug 2024 05:48:28 -0500
Date: Thu, 8 Aug 2024 05:48:28 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
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
Message-ID: <20240808104828.hm2dgrb6tnkdu3se@renewed>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
 <20240731-b4-upstream-j742s2-v3-4-da7fe3aa9e90@ti.com>
 <20240807132054.jcz5fdokc5yk3mbo@entrust>
 <20240808045616.xpgs6ayzpzcpevdp@uda0497581>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240808045616.xpgs6ayzpzcpevdp@uda0497581>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:26-20240808, Manorit Chawdhry wrote:
> Hi Nishanth,
> 
> On 08:20-20240807, Nishanth Menon wrote:
> > On 22:40-20240731, Manorit Chawdhry wrote:
> > > k3-j784s4-j742s2-main-common.dtsi will be included in k3-j742s2-main.dtsi at a
> > > later point so move j784s4 related stuff to k3-j784s4-main.dtsi
> > > 
> > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > ---
> > >  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi   | 13 -------------
> > >  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi          | 21 +++++++++++++++++++++
> > >  arch/arm64/boot/dts/ti/k3-j784s4.dtsi               |  2 ++
> > >  3 files changed, 23 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > > index 17abd0f1560a..91352b1f63d2 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > > @@ -2405,19 +2405,6 @@ c71_2: dsp@66800000 {
> > >  		status = "disabled";
> > >  	};
> > >  
> > > -	c71_3: dsp@67800000 {
> > > -		compatible = "ti,j721s2-c71-dsp";
> > > -		reg = <0x00 0x67800000 0x00 0x00080000>,
> > > -		      <0x00 0x67e00000 0x00 0x0000c000>;
> > > -		reg-names = "l2sram", "l1dram";
> > > -		ti,sci = <&sms>;
> > > -		ti,sci-dev-id = <40>;
> > > -		ti,sci-proc-ids = <0x33 0xff>;
> > > -		resets = <&k3_reset 40 1>;
> > > -		firmware-name = "j784s4-c71_3-fw";
> > > -		status = "disabled";
> > > -	};
> > > -
> > 
> > This patch can be squashed in.
> > 
> 
> The idea was that we can see what changes are happening and where are
> things getting moved and hence had kept the patch like this, would be
> easier to review I believe, do you want it squashed right now or should
> I be doing it later once you are fine with all the changes and all the
> reviews are done?
> 

No. Please squash as suggested in my response to your cover-letter for
the next iteration - please use git format-patch -C -M to generate
patches (I understand you have some limitations with using b4) to
make reviews easier to do.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

