Return-Path: <linux-kernel+bounces-278883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CD294B608
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766FB1F236C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E0512FB37;
	Thu,  8 Aug 2024 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B7hcekMw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14867635;
	Thu,  8 Aug 2024 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723092986; cv=none; b=sno/57YcP8DpukAwmShVDbUxTMwN2a3ZTaSLfinS2ozMwELkVySHXy8A+Sqgq7EXR0KRQpAPI5VDvppOjDZ1neQ7s7egpU8hOpqI+gcnshTR6lHMMVTh69Ja5O/lx3iyDDLdOB0vtERtaJY5DCLSW/Cl4JSSWAq6K71XLCBUqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723092986; c=relaxed/simple;
	bh=sEvfivmQ5fZOOSTKJxCsqHx32NVM4zjmf+rnIXMcTYI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mnf/+INITKBdK0E0DkkpRFIE/qFuifCSiuhCVQl2G4JVjAnRiIGKZGtGowGdfJemuTgx1U9y3BCPoauk1MpH86fSRi7K1tlPCNQjLuaWQyRveGkmqkCqSL9TQ5uYikadsHsE5rDrYGYWMsP4OvZLRGR5eOJbQ0zVu6NM5ZIidIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B7hcekMw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4784uHgw075970;
	Wed, 7 Aug 2024 23:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723092977;
	bh=VAdtftoSs5eScm7ugQhNKeowSuhKher/yWMg/2LqW2U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=B7hcekMwkUR4q8L4pINhBMI7m0JEYoA3TOhhyDUO5jCISRLDXgPgilgoKp+oN7Y6p
	 5Ud86NohsFkOm9lkc/ECk6ysZPwroga3EFxYwEFHdgMS1COLJAfh1wzGDfnhreI6v1
	 X3AN225b0TfcdtzKU6ychMCY+jEkUn6UZRBvDOu8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4784uH8h004438
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 23:56:17 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 23:56:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 23:56:17 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4784uGhQ029600;
	Wed, 7 Aug 2024 23:56:17 -0500
Date: Thu, 8 Aug 2024 10:26:16 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
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
Message-ID: <20240808045616.xpgs6ayzpzcpevdp@uda0497581>
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

On 08:20-20240807, Nishanth Menon wrote:
> On 22:40-20240731, Manorit Chawdhry wrote:
> > k3-j784s4-j742s2-main-common.dtsi will be included in k3-j742s2-main.dtsi at a
> > later point so move j784s4 related stuff to k3-j784s4-main.dtsi
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi   | 13 -------------
> >  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi          | 21 +++++++++++++++++++++
> >  arch/arm64/boot/dts/ti/k3-j784s4.dtsi               |  2 ++
> >  3 files changed, 23 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > index 17abd0f1560a..91352b1f63d2 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > @@ -2405,19 +2405,6 @@ c71_2: dsp@66800000 {
> >  		status = "disabled";
> >  	};
> >  
> > -	c71_3: dsp@67800000 {
> > -		compatible = "ti,j721s2-c71-dsp";
> > -		reg = <0x00 0x67800000 0x00 0x00080000>,
> > -		      <0x00 0x67e00000 0x00 0x0000c000>;
> > -		reg-names = "l2sram", "l1dram";
> > -		ti,sci = <&sms>;
> > -		ti,sci-dev-id = <40>;
> > -		ti,sci-proc-ids = <0x33 0xff>;
> > -		resets = <&k3_reset 40 1>;
> > -		firmware-name = "j784s4-c71_3-fw";
> > -		status = "disabled";
> > -	};
> > -
> 
> This patch can be squashed in.
> 

The idea was that we can see what changes are happening and where are
things getting moved and hence had kept the patch like this, would be
easier to review I believe, do you want it squashed right now or should
I be doing it later once you are fine with all the changes and all the
reviews are done?

Regards,
Manorit

