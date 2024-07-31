Return-Path: <linux-kernel+bounces-268495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4D942552
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A1A1F24531
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28B81B978;
	Wed, 31 Jul 2024 04:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YZDWNjdK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD31946B;
	Wed, 31 Jul 2024 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399573; cv=none; b=i0ermHzSJ2OYA8TybscpyGJzTGM+i0G1ejufdLwc1bDwqqHfC3Ztn1aTbFzP/ItNRqdx7Ha29hgDqM0qHOba7MHUc+z5y30eLgoGBk2C9FXX1E09O9C12FpksItf6zBvfRlB/yFYsJmiB6ot38kA6x+nSfoZ2bY/EjZeKsJ2YEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399573; c=relaxed/simple;
	bh=kcnjy5i6cO6yrVWbwoFm9x0bXbL65298JLCAh5v7YIA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZQv1l1p3qvN0En9hq6TLVDc1R9KABMmtkYZRdJaydxrhgZQLYEXWfXA76FDohFVnt+IBvsxuY35hlBZVCTNupXlAJumQ5HGP5vlFHrjIGwu7lIq4EpPqOSzWx5voRustAW6EMSvcX+FGchvnPSL/ehfO7FTN58Hqpk4rD8AF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YZDWNjdK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46V4JIct040415;
	Tue, 30 Jul 2024 23:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722399558;
	bh=vQe4fF41AGeNLxLgnXwroJucdLZVFvdpjUifD+n7Kps=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YZDWNjdKPRR34T3+hTFsRRkscVyENtleSG5RIk2s/w0Ngy13lfQm55FjROuZdwes0
	 vwAp+0JR24fsrDf2JLrIev0eofwjr0ydBlfYnF9wX2woN/wXsot7oNzGJdSo8jfw7o
	 r6c9VW5dLauNu9PUKJLuKh3i7r203TY3x0Pjwsj8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46V4JIqG060103
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 23:19:18 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 23:19:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 23:19:17 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46V4JH0k077287;
	Tue, 30 Jul 2024 23:19:17 -0500
Date: Wed, 31 Jul 2024 09:49:16 +0530
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
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: Introduce J742S2 SoC family
Message-ID: <20240731041916.stcbvkr6ovd7t5vk@uda0497581>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
 <20240730-b4-upstream-j742s2-v2-2-6aedf892156c@ti.com>
 <20240730123343.mqafgpj4zcnd5vs4@plaything>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240730123343.mqafgpj4zcnd5vs4@plaything>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 07:33-20240730, Nishanth Menon wrote:
> On 12:43-20240730, Manorit Chawdhry wrote:
> > This device is a subset of J784S4 and shares the same memory map and
> > thus the nodes are being reused from J784S4 to avoid duplication.
> > 
> > Here are some of the salient features of the J742S2 automotive grade
> > application processor:
> > 
> > The J742S2 SoC belongs to the K3 Multicore SoC architecture platform,
> > providing advanced system integration in automotive, ADAS and industrial
> > applications requiring AI at the network edge. This SoC extends the K3
> > Jacinto 7 family of SoCs with focus on raising performance and
> > integration while providing interfaces, memory architecture and compute
> > performance for multi-sensor, high concurrency applications.
> > 
> > Some changes that this devices has from J784S4 are:
> > * 4x Cortex-A72 vs 8x Cortex-A72
> > * 3x C7x DSP vs 4x C7x DSP
> > * 4 port ethernet switch vs 8 port ethernet switch
> > 
> > ( Refer Table 2-1 for Device comparison with J7AHP )
> > Link: https://www.ti.com/lit/pdf/spruje3 (TRM)
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi | 44 ++++++++++++++++++++++++++++++
> >  arch/arm64/boot/dts/ti/k3-j742s2.dtsi      | 26 ++++++++++++++++++
> >  2 files changed, 70 insertions(+)
> > 
[...]
> > + */
> > +
> > +#include "k3-j784s4.dtsi"
> > +
> > +/ {
> > +	model = "Texas Instruments K3 J742S2 SoC";
> > +	compatible = "ti,j742s2";
> > +
> > +	cpus {
> > +		cpu-map {
> > +			/delete-node/ cluster1;
> > +		};
> > +	};
> > +
> > +	/delete-node/ cpu4;
> > +	/delete-node/ cpu5;
> > +	/delete-node/ cpu6;
> > +	/delete-node/ cpu7;
> 
> I suggest refactoring by renaming the dtsi files as common and split out
> j784s4 similar to j722s/am62p rather than using /delete-node/
> 

I don't mind the suggestion Nishanth if there is a reason behind it.
Could you tell why we should not be using /delete-node/? 

Regards,
Manorit

> 
> > +};
> > +
> > +#include "k3-j742s2-main.dtsi"
> > 
> > -- 
> > 2.45.1
> > 
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

