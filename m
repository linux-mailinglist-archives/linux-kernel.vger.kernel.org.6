Return-Path: <linux-kernel+bounces-350245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F799020A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9C1B20AD7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EF3157481;
	Fri,  4 Oct 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eSBFWzBd"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D0137903;
	Fri,  4 Oct 2024 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041208; cv=none; b=KfJbHQ+Bd6pHnh6eFK5xcDXjJgfSbRlC/qZK91UOfVGALRYgqihRzVXzOXroKu3kfnw3GGuV93ZMOI+YPt0Z0pJqccgrG+4SgO9abqBfHqKl4W7qFHr4g+iUle4yHqIDcaGmoYMfBeWtwV5YQAqkdv3pJoH2/HVNFjkQ3ISWmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041208; c=relaxed/simple;
	bh=/ixClVEw6P8y4JUgO/HEYdgh8vFcnmAPQaFNMxoXLJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK/+WtSK9RaTpYiShp+ikg2dpDgnfbBguejxH87Pfh3AaSJoAW5GF+TYr4GrOB+QspkOTFeXVF+LNXazjGTt0Jo9eqXjqxxK0dtzIeGKJx2YhieOwDm7NI3Q+iI0VGPUBtwFA9Z4Mi+WK5j49iQztk2MJmqE5x1fhxCDDBFhF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eSBFWzBd; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 494BQbJl081014;
	Fri, 4 Oct 2024 06:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728041197;
	bh=KPdjKo7hFMxWG9jf55ps3sg0vmoM9vRjCReXoVQKtGE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=eSBFWzBdgqjFuyy657N7/kJjseTGVRvUu6AnJMaSBVjWME6VyxIwmo/blrtKGyyvW
	 /4ATWPvP6X90rJijdvDYsPLe72FbCP4TZ66qWD2295sH7z+nzAUWEbQNTCitp6a70/
	 8px0fXL5QJAkXyZLVD2WUfwEeAJiTaBluSlpIVYo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 494BQbpu026567
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Oct 2024 06:26:37 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 06:26:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 06:26:37 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 494BQb37065159;
	Fri, 4 Oct 2024 06:26:37 -0500
Date: Fri, 4 Oct 2024 06:26:37 -0500
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 2/5] arm64: dts: ti: k3-am625-sk: Add M4F remoteproc
 node
Message-ID: <20241004112637.nc2qcquiuwdhdrye@thirteen>
References: <20241003170118.24932-1-afd@ti.com>
 <20241003170118.24932-3-afd@ti.com>
 <20241003210606.2k7wyssklwfziod4@bryanbrattlof.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241003210606.2k7wyssklwfziod4@bryanbrattlof.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:06-20241003, Bryan Brattlof wrote:
> Hi Andrew!
> 
> On October  3, 2024 thus sayeth Andrew Davis:
> > From: Hari Nagalla <hnagalla@ti.com>
> > 
> > The AM62x SoCs of the TI K3 family have a Cortex M4F core in the MCU
> > domain. This core can be used by non safety applications as a remote
> > processor. When used as a remote processor with virtio/rpmessage IPC,
> > two carveout reserved memory nodes are needed. The first region is used
> > as a DMA pool for the rproc device, and the second region will furnish
> > the static carveout regions for the firmware memory.
> > 
> > The current carveout addresses and sizes are defined statically for
> > each rproc device. The M4F processor does not have an MMU, and as such
> > requires the exact memory used by the firmware to be set-aside.
> > 
> > Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> > index 44ff67b6bf1e4..6957b3e44c82f 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> > @@ -56,6 +56,18 @@ linux,cma {
> >  			linux,cma-default;
> >  		};
> >  
> > +		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x00 0x9cb00000 0x00 0x100000>;
> > +			no-map;
> > +		};
> > +
> > +		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x00 0x9cc00000 0x00 0xe00000>;
> > +			no-map;
> > +		};
> > +
> 
> The only issue I have here is this takes away memory from people who do 
> not use these firmware or causes them to work around this patch if they 
> choose to have different carveouts.

They can define their own overlays.

> 
> Would an overlay be appropriate for this?

Why is this any different from existing boards? Are you suggesting a
change for all existing boards as well?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

