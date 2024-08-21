Return-Path: <linux-kernel+bounces-295386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B34959A58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A0A1C20D92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0036A1B7910;
	Wed, 21 Aug 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jTn8Fevd"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F01B1D61;
	Wed, 21 Aug 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238636; cv=none; b=JHxS6EUK9W/m7iSd9ki9lqPu4FGYUJxnG8cfnoPnKWq7mlF91lxnxtOVpKqeuiESNaiebN5i7aueyYZXlgwunp4Goo7nhOPww2Y/ULgOo/IG2RH6Wqz2IKNi3GiBrqTylXLjrYoKubxLVPFkQetWCTU2fWg0azSosZ05UOkJMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238636; c=relaxed/simple;
	bh=wtyVza7pPG7HwH8Ffygep8fUL40eT3JGcHBxzpvlNwk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqxC2Osr+A1og4jv5CuCOKmEiL3duuAgRH5He6kEaFKvhgVem0KVVz5MAslehQegAxDVEFlGCeBpBFYW0+W+bOo8YK0+gXWZ80TglI5c6a7Atc1N12/kORkaWpg+/oEpH+fkZhnd6Zz25TER1C2kEOHzHXtZi2w5R2a5YJk2NXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jTn8Fevd; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LBASoh097212;
	Wed, 21 Aug 2024 06:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724238628;
	bh=T3FjfbTMeOH7tN5HUO7GXQ7+Mttu5fF++DxNH+J9BRc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jTn8FevdHtDr+cEBXFR/Q0jWd3HbF6ZYQv3tAj8MX9cU9oPD1PJrJZ1Fb7/4TlP/p
	 /dLpH/b+LhpoZAvPI+UxNYEgYtB0965s2jCPNJJgmYpEjPaPNMzhm1xy7yiFss1m7S
	 b3wdxD7SktGoHrvscjlGRRrFqonVUkOpE7FLDDYQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LBASMw081609
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 06:10:28 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 06:10:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 06:10:27 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LBARSL001818;
	Wed, 21 Aug 2024 06:10:27 -0500
Date: Wed, 21 Aug 2024 06:10:27 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <bb@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] arm64: dts: k3-am62a-wakeup: Add R5F device node
Message-ID: <20240821111027.6kx57jftp67ksx52@boxcar>
References: <20240820104034.15607-1-hnagalla@ti.com>
 <20240820104034.15607-4-hnagalla@ti.com>
 <b6b341a7-5ee2-4a89-82c6-e863a9556654@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b6b341a7-5ee2-4a89-82c6-e863a9556654@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:13-20240820, Andrew Davis wrote:
> On 8/20/24 5:40 AM, Hari Nagalla wrote:
> > From: Devarsh Thakkar <devarsht@ti.com>
> > 
> > AM62A SoCs have a single R5F core in waekup domain. This core is also
> > used as a device manager for the SoC.
> > 
> > Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> > Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 23 +++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> > index f5ac101a04df..c4319986e660 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> > @@ -76,6 +76,29 @@ wkup_rti0: watchdog@2b000000 {
> >   		status = "reserved";
> >   	};
> > +	wkup_r5fss0: r5fss@78000000 {
> > +		compatible = "ti,am62-r5fss";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x78000000 0x00 0x78000000 0x8000>,
> > +			 <0x78100000 0x00 0x78100000 0x8000>;
> > +		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
> 
> Need newline here.
> 
> > +		wkup_r5fss0_core0: r5f@78000000 {
> > +			compatible = "ti,am62-r5f";
> > +			reg = <0x78000000 0x00008000>,
> > +				<0x78100000 0x00008000>;
> > +			reg-names = "atcm", "btcm";
> > +			ti,sci = <&dmsc>;
> > +			ti,sci-dev-id = <121>;
> > +			ti,sci-proc-ids = <0x01 0xff>;
> > +			resets = <&k3_reset 121 1>;
> > +			firmware-name = "am62-wkup-r5f0_0-fw";
> 
> resets and firmware-name should go before vendor specific properties.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

> 
> > +			ti,atcm-enable = <1>;
> > +			ti,btcm-enable = <1>;
> > +			ti,loczrama = <1>;
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

