Return-Path: <linux-kernel+bounces-349575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFBA98F891
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5884D1C217AA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0B1C2DB0;
	Thu,  3 Oct 2024 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mDTbh51H"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F301AAE39;
	Thu,  3 Oct 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989577; cv=none; b=fk8lNieuBScGSMbO+fSUH1W2Hq8jyEUNs5ptam3XfymNTh5+xVZjjNqGgltkH9LjJXucyWdLnhTOTkW03fKiiJB1RyZ+FKY/NrkKuutqu8AELWQVydq/nyhKxjYuBlPRKcDTZmYZ3trmvb74aaIxQ3VPURy3+geuTWaHNuZX08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989577; c=relaxed/simple;
	bh=cHnd85X78e6FFbfVRrKy1KRgRQi8Bj/svD0Sbxmorn0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TABGI46d5DO76BpNEaS6+IjJd1bZB8HINTRV7UU0/bBLTnCexZhJUouhUp6ANCKtT/YuyoxemitfsBaEuMtM0/12KHlamNbqrKPm94vCYgYLzDW0JrhI1hUDsZPXjWaVpEiX8L+YSdLxrzKsjhf/Qy5TMOz1Mk0Eg3f6c6HSFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mDTbh51H; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 493L66C5073927;
	Thu, 3 Oct 2024 16:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727989566;
	bh=GXeSSrlQk/Y25qv8eRZnz896qL1ska8ltJANRgkvAqI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=mDTbh51HH5tQfVO9jPxQ5xhj+oAmmxooOAh45i/IhL8QjjwTe31oC7mNL70rz7S4a
	 yPa1acFBqkh4RKLjOBx5/DvQDNOfBLkrm7WlQZ97w/QyWhK5JhufauzTjpppQNqk+A
	 I3l925ZDLHtj65tKB441B+ojz58A9oGqrlQN6X6w=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 493L666d086560;
	Thu, 3 Oct 2024 16:06:06 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Oct 2024 16:06:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Oct 2024 16:06:06 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 493L66Rr030034;
	Thu, 3 Oct 2024 16:06:06 -0500
Date: Thu, 3 Oct 2024 16:06:06 -0500
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
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
Message-ID: <20241003210606.2k7wyssklwfziod4@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241003170118.24932-1-afd@ti.com>
 <20241003170118.24932-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241003170118.24932-3-afd@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew!

On October  3, 2024 thus sayeth Andrew Davis:
> From: Hari Nagalla <hnagalla@ti.com>
> 
> The AM62x SoCs of the TI K3 family have a Cortex M4F core in the MCU
> domain. This core can be used by non safety applications as a remote
> processor. When used as a remote processor with virtio/rpmessage IPC,
> two carveout reserved memory nodes are needed. The first region is used
> as a DMA pool for the rproc device, and the second region will furnish
> the static carveout regions for the firmware memory.
> 
> The current carveout addresses and sizes are defined statically for
> each rproc device. The M4F processor does not have an MMU, and as such
> requires the exact memory used by the firmware to be set-aside.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 44ff67b6bf1e4..6957b3e44c82f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -56,6 +56,18 @@ linux,cma {
>  			linux,cma-default;
>  		};
>  
> +		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9cb00000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9cc00000 0x00 0xe00000>;
> +			no-map;
> +		};
> +

The only issue I have here is this takes away memory from people who do 
not use these firmware or causes them to work around this patch if they 
choose to have different carveouts.

Would an overlay be appropriate for this?

~Bryan

