Return-Path: <linux-kernel+bounces-277483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F44994A201
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA711C230C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210881C8220;
	Wed,  7 Aug 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BqKmT5RW"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33919A28F;
	Wed,  7 Aug 2024 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017053; cv=none; b=Uf0hSvuaccZMzsbKh9izYuCm/OEwAsf8hdE73G3VSfvUHhr3z+JV1KEydoM5YnpymHPDzdQj8GTdCcPofYTHOyDFuzRyK1qb3Y5KpsdgTW2Uj3wShmrQ64GYQoCSZRY+NN74NY8JBUPWOkIyZl0oS5zabOCsJNKCgoZMdTFrF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017053; c=relaxed/simple;
	bh=lgLKZc0GBq3W7pR0815eFTru0022sCuHCIqC3oVPyTM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYjsQ0wYTwwzLwbAWjZm3Nkbd5YWE6DkKws4q+SJrqjKSrEtccDfETZXXKPeopDPdKhuXgtXKM9yJW4/TgrK62C+TD+NdvKmnH8I57gGg5SF19beN++Rkl1yXceMbmgXReeJas4R2IqTxbeIBl5QokLlkYgwef/b+LvpKf40y3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BqKmT5RW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4777ofjj019788;
	Wed, 7 Aug 2024 02:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723017041;
	bh=hGB25P44iUebr0eKJQ+nwleNjhJmNmEeQsDF97OMdjc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BqKmT5RWMpAYvRGkZdj165R8ftp9iabXenNuxPW/cd+9iFHH5Y68XnvNFLhs4j+5I
	 lw42MgELkgK0sFhIL6/IjDpbnGYD5Hn8q+x6b+6ipwq7slupa1sgmrG+CjcANWWst2
	 39EhOCf14hwsXvZbE5Vx/UAjtp+J/TZayTPjRZxw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4777ofMi049546
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 02:50:41 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 02:50:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 02:50:40 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4777oexN107391;
	Wed, 7 Aug 2024 02:50:40 -0500
Date: Wed, 7 Aug 2024 13:20:39 +0530
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
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: k3-j7200*: Add bootph-* properties
Message-ID: <20240807075039.w56deberpo4rfhjc@uda0497581>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-5-9bc2eccb6952@ti.com>
 <f80996c2-c3ee-430a-9ae6-2a9c524b5d60@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f80996c2-c3ee-430a-9ae6-2a9c524b5d60@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit,

On 12:58-20240807, Kumar, Udit wrote:
> 
> On 7/30/2024 3:23 PM, Manorit Chawdhry wrote:
> > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > utilise them.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   .../arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 20 ++++++++++++++++++++
> >   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi            |  2 ++
> >   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 10 ++++++++++
> >   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi          |  7 +++++++
> >   4 files changed, 39 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> > index 6593c5da82c0..ec522595fc83 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> > [..]
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> > index 9386bf3ef9f6..b95656942412 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> > @@ -136,6 +136,7 @@ secure_proxy_main: mailbox@32c00000 {
> >   			      <0x00 0x32800000 0x00 0x100000>;
> >   			interrupt-names = "rx_011";
> >   			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> > +			bootph-all;
> >   		};
> >   		hwspinlock: spinlock@30e00000 {
> > @@ -1528,5 +1529,6 @@ main_esm: esm@700000 {
> >   		compatible = "ti,j721e-esm";
> >   		reg = <0x0 0x700000 0x0 0x1000>;
> >   		ti,esm-pins = <656>, <657>;
> > +		bootph-all;
> 
> Should be bootph-pre-ram
> 
> if you think otherwise then please update mcu_esm

Will update to bootph-pre-ram;

> 
[..]
> > @@ -45,6 +48,7 @@ mcu_timer0: timer@40400000 {
> >   		assigned-clock-parents = <&k3_clks 35 2>;
> >   		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
> >   		ti,timer-pwm;
> > +		bootph-pre-ram;
> 
> I see this node is marked as reserved
> 
> Do we plan to use in bootloader ?

mcu_timer0 is used in R5 stage [0].

[0]: https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/k3-j7200-r5-common-proc-board.dts#L56

> 
> >   	};
[..]
> >   		hbmc: hyperbus@47034000 {
> 
> I think you should consider to mark hbmc node for boot phase as well
> 

It's already marked in k3-j7200-som-p0.dtsi file with bootph-all inside
the flash node that describe it, is that okay?

> 
> > @@ -652,6 +661,7 @@ wkup_vtm0: temperature-sensor@42040000 {
> >   		      <0x00 0x42050000 0x00 0x350>;
> >   		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
> >   		#thermal-sensor-cells = <1>;
> > +		bootph-pre-ram;
> >   	};
> >   	mcu_esm: esm@40800000 {
> > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> > index 21fe194a5766..d78f86889bf9 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> > @@ -121,6 +121,7 @@ J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (B8) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
> >   			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (A8) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
> >   			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
> >   		>;
> > [..]
> >   			bucka2: buck2 {
> > @@ -464,6 +470,7 @@ flash@0 {
> >   		cdns,tchsh-ns = <60>;
> >   		cdns,tslch-ns = <60>;
> >   		cdns,read-delay = <4>;
> > +		bootph-all;
> >   		partitions {
> >   			compatible = "fixed-partitions";
> 
> 
> Please consider, adding bootph in ospi0 node as well around
> "ospi.phypattern"
> 

Okay sure, will move the bootph-all from flash@0 node to under
ospi.phypattern node as putting it in the child node should propagate
it.

Thanks for reviewing Udit!

Regards,
Manorit
> 
> > 

