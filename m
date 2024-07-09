Return-Path: <linux-kernel+bounces-245444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AD692B290
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7EB1F22CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF594153585;
	Tue,  9 Jul 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pyxsdBDn"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BD6138;
	Tue,  9 Jul 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514956; cv=none; b=tI02aDV01RTuUnUvApCwYpnGVDHLnUd9h8tTKDGm699HqpRr/gauTRxnD2Nu6DpWNXRD6+ytawlv0sxyYN7GZRk7Z1iAoKc4PhmGOCn2qrLntcCLQz/fXgaVcxYLxtDy5GH8yRxTxK1FFx0aA0DNvZCHwdiugNiK3OFP1SyXIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514956; c=relaxed/simple;
	bh=cP47i/7cJ4lkFges4Nl7itt3YRqAnpRsXN1/clKfjGY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2CF0bBL1f3Vs5auA07+iwhqj/xlmNcOSbH/gyi39zXXTlOyH1EPhJWXS3FcHXL53X9Zw8ojWf1QdZvIEhlWl+oYZwndo6SJohW5ChyeYfHl0CWdZIBnRGR7gOTA5Jt2TIKSf60MJuMHJ2XQtvjY49YmmnyU2P9XftyD+yrVdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pyxsdBDn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4698mwu3070460;
	Tue, 9 Jul 2024 03:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720514938;
	bh=5WZkfsvmLamemn97uUc60YsRqdAwy+JB+ny9+g16q3I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=pyxsdBDn1uvDNX9Z5rxqHK4FNIggT2azEx6j3TeV77Gdrsuv4jzOytz5vL8aRaVDR
	 u0Gw47zSO7/SleQwSJLWgzC3pcKLHBCTu6dLMhiTwDAlYfCiF0ZLT0SGg/beJf1CsF
	 DjvH86un1lsJTkBdbd/WAH+VDb/7T/xrXA5SVU+A=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4698mwts024085
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 03:48:58 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jul 2024 03:48:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jul 2024 03:48:58 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4698mvpw110540;
	Tue, 9 Jul 2024 03:48:58 -0500
Date: Tue, 9 Jul 2024 14:18:57 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Beleswar Padhi <b-padhi@ti.com>
Subject: Re: [PATCH v2 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
Message-ID: <20240709084857.nf7c57mi6miajeau@uda0497581>
References: <20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com>
 <20240705-b4-upstream-bootph-all-v2-1-9007681ed7d8@ti.com>
 <da36d283-73f0-4110-a9fa-3964eae19689@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <da36d283-73f0-4110-a9fa-3964eae19689@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vignesh,

On 13:02-20240709, Vignesh Raghavendra wrote:
> 
> 
> On 05/07/24 11:56, Manorit Chawdhry wrote:
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> > index 8feb42c89e47..497e0dfa8011 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> > @@ -17,20 +17,24 @@ sms: system-controller@44083000 {
> >  
> >  		reg-names = "debug_messages";
> >  		reg = <0x00 0x44083000 0x00 0x1000>;
> > +		bootph-all;
> 
> Since [0] in U-Boot, bootph-* is automatically propagated to supernodes.
> Please fix throughout the series

In v1, Aniket posted a review comment and that corresponded to all the
devices hence added that [0]. As you mentioned offline, this node might
be getting called in U-boot proper prior to re-location and somehow the
property is not getting passed on at that stage. Might need some furthur
debugging as to why it's failing. Will see what can be done about it.
Thanks.

[0]: https://lore.kernel.org/all/3e478ecc-33b8-4aa6-b984-67877864e900@ti.com/

Regards,
Manorit

> 
> >  
> >  		k3_pds: power-controller {
> >  			compatible = "ti,sci-pm-domain";
> >  			#power-domain-cells = <2>;
> > +			bootph-all;
> >  		};
> >  
> >  		k3_clks: clock-controller {
> >  			compatible = "ti,k2g-sci-clk";
> >  			#clock-cells = <2>;
> > +			bootph-all;
> >  		};
> >  
> >  		k3_reset: reset-controller {
> >  			compatible = "ti,sci-reset";
> >  			#reset-cells = <2>;
> > +			bootph-all;
> >  		};
> >  	};
> 
> 
> [0]
> 
> -- 
> Regards
> Vignesh

