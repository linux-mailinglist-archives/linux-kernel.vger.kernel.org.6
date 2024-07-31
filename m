Return-Path: <linux-kernel+bounces-269321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2EE943185
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761F01F2192C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453131B3721;
	Wed, 31 Jul 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FnwYLqbK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95B1B29D7;
	Wed, 31 Jul 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434250; cv=none; b=mpjChbeNGPzqGm69/5n6zOcaYTYVBz0ITR004/S7qHs1Vn8wU5zYSwtgeuGICAlBmAG4lUZLpbMe25Oe4KSLKygqscsgfy4g8B2N+Z3zCF1TNom/4zR1zfQ4s8PceUG2H5BDhsGwhK6Nd9bhOQl7Qed5dxQkhvnwHo5tD8Y4E58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434250; c=relaxed/simple;
	bh=9kOxdCDSdQk5A56AMDfofruVBT5zD1cmr6dCHKgDVow=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AymYixrOD8Ou1hjO87Gy3vTWEkcwynUHFJcOBktqB7ygGRRyD2BbBiWbku6NeBJtQNXNrO88nWHLA0NktKh+kg+Cgcqy9RwnT4LQ3L8IBlAEUwsuYo/q8h4Y8N6+ESCwoGhpiZQyJzQEOJA/MvGN7b2a4q61yiIWHENPsWYPSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FnwYLqbK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VDvF75057039;
	Wed, 31 Jul 2024 08:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722434235;
	bh=44487YsGoX2qvKzFKV1sdxytTn0eJGty5OtHEbEqBH8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FnwYLqbKfz5co9kABPEeiPsUPG+SEMhbyvOKWEPGc/Jp04AulNBNEUedznTDFGoMj
	 xOWHOM6QFM4UUOKGuu1zuO//tomVzketmuhFYppakZQX9dFBPtigKIy0oWZ6DNmRLk
	 +4rXtVWj5envGvYiQOSDKlEPeJcKAeMfoleEL0FI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VDvFfR128280
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 08:57:15 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 08:57:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 08:57:15 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VDvESW128706;
	Wed, 31 Jul 2024 08:57:14 -0500
Date: Wed, 31 Jul 2024 19:27:14 +0530
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
Message-ID: <20240731135714.p53lki7mihzxcyk2@uda0497581>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
 <20240730-b4-upstream-j742s2-v2-2-6aedf892156c@ti.com>
 <20240730123343.mqafgpj4zcnd5vs4@plaything>
 <20240731041916.stcbvkr6ovd7t5vk@uda0497581>
 <20240731110607.7fb42mgcsf2apodv@unshaven>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240731110607.7fb42mgcsf2apodv@unshaven>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 06:06-20240731, Nishanth Menon wrote:
> On 09:49-20240731, Manorit Chawdhry wrote:
> > > > + */
> > > > +
> > > > +#include "k3-j784s4.dtsi"
> > > > +
> > > > +/ {
> > > > +	model = "Texas Instruments K3 J742S2 SoC";
> > > > +	compatible = "ti,j742s2";
> > > > +
> > > > +	cpus {
> > > > +		cpu-map {
> > > > +			/delete-node/ cluster1;
> > > > +		};
> > > > +	};
> > > > +
> > > > +	/delete-node/ cpu4;
> > > > +	/delete-node/ cpu5;
> > > > +	/delete-node/ cpu6;
> > > > +	/delete-node/ cpu7;
> > > 
> > > I suggest refactoring by renaming the dtsi files as common and split out
> > > j784s4 similar to j722s/am62p rather than using /delete-node/
> > > 
> > 
> > I don't mind the suggestion Nishanth if there is a reason behind it.
> > Could you tell why we should not be using /delete-node/? 
> > 
> 
> Maintenance, readability and sustenance are the reasons. This is a
> optimized die. It will end up having it's own changes in property
> and integration details. While reuse is necessary, modifying the
> properties with overrides and /delete-nodes/ creates maintenance
> challenges down the road. We already went down this road with am62p
> reuse with j722s, and eventually determined split and reuse is the
> best option. See [1] for additional guidance.
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n189

Thank you for giving some reasoning, would do the needful!

Regards,
Manorit

> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

