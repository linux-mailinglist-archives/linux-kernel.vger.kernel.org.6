Return-Path: <linux-kernel+bounces-215308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721199090F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11214285E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC3C19E7E9;
	Fri, 14 Jun 2024 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wfazeYk4"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129EB19E7C9;
	Fri, 14 Jun 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384659; cv=none; b=BG9HUBU9p7FBpEw8MH7NTySwIIF95PXx72HZvgyiGk6cI/+ph+QNiITOQsMxclWhjkuusrZf2Mkv9wAnveHv68QHcA8RwuO1IVNAbEhg+PvA4lhjMwE9oU8WMOMSMqEdSc8UCReEYOnX1UMS885dqinqcANVTuJNH62PZBjPDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384659; c=relaxed/simple;
	bh=i3dW+XOUEduNdz79toCEAaPY/9cClVwXoiAgL+aKmUI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4V5nQRNInythQyiO8rJs7BrA1unbKvmUP3JUmVgJ8ZEV8Qh2oz1Iq4nXbkBtDp5LCT2wAQJp6ocqHZPJvfy5GFZaNRf/aM+PVRIICpu8taWFqzlB/llLU5RZDOikitpeIhYVk90+WKDKtidC//Cm1hxngzIert1LHEZjvIgrlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wfazeYk4; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EH49WD015961;
	Fri, 14 Jun 2024 12:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718384649;
	bh=eEPUkKY3qAW3GGWu9H1hXTPI1btWQRwTgAte3nVNCnA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wfazeYk43i1BVHKqoxqLYgFTiUBASlAd9S9uWphNiwlLdJYNRJOcWVuNnrQf4NGnc
	 o6OkbBQ4HaFycGgdRm/3DW89DyLuBTBFXeJy8UQbwDeM8xIldkeEE4PCzKIqhwAA+f
	 IHtgddRSPhXBVarNSW2y+jjEJRbvRLND37ep8e48=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EH49O6076663
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 12:04:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 12:04:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 12:04:09 -0500
Received: from localhost (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EH49ZW067095;
	Fri, 14 Jun 2024 12:04:09 -0500
Date: Fri, 14 Jun 2024 12:04:09 -0500
From: Brandon Brnich <b-brnich@ti.com>
To: Devarsh Thakkar <devarsht@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <praneeth@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of
 global CMA
Message-ID: <20240614170409.zu4vaatdac4o6w2o@udba0500997>
References: <20240613150902.2173582-1-devarsht@ti.com>
 <20240613150902.2173582-4-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240613150902.2173582-4-devarsht@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Devarsh, 


On 20:39-20240613, Devarsh Thakkar wrote:
> From: Brandon Brnich <b-brnich@ti.com>
> 
> AM62p has different multimedia components such as Camera, Display, H264
> Video Codec which uses CMA for buffer allocations. We require 576MiB for 12
> channel decode-to-encode 720x480@30FPS use case.
> 
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> index fb980d46e304..5ef74d9f8eea 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> @@ -48,6 +48,13 @@ reserved-memory {
>  		#size-cells = <2>;
>  		ranges;
>  
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x00 0x24000000>;
> +			linux,cma-default;
> +		};

Since AM62p has 8gb memory, this allocation can come from upper portion.
Doing so breaks Wave5 encoding/decoding as the driver can not yet handle
48 bit addressing. 48bit support is scheduled to be upstreamed, but unsure of
when this will actually make it in.  

Could we force this into lower 32bits using same
alloc-ranges as done in your AM62a patch[0]?


[0]: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240613150902.2173582-3-devarsht@ti.com/

Best,
Brandon

> +
>  		secure_tfa_ddr: tfa@9e780000 {
>  			reg = <0x00 0x9e780000 0x00 0x80000>;
>  			no-map;
> -- 
> 2.39.1
> 

