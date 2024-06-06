Return-Path: <linux-kernel+bounces-204782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4178FF387
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC861F23021
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E5D1990CF;
	Thu,  6 Jun 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R2tUJOrB"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D71990B0;
	Thu,  6 Jun 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694194; cv=none; b=JY80+r3QcuSfh0+TccdMfqZQu7haGVOQF00edXyyGUgVoD6fKNOmALG9I78k6EM7bllBsA2QlrhY+U/RjBVXjFux/Q3gA5nWWB1TH0jYvF70+2RV+CzusnfyPszFCxbbagX8q4yCIwj+fGC4oj3UA+quoxS4tZKTJ7fXa9sUPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694194; c=relaxed/simple;
	bh=muBv10i8ecicrZGE49nuywATHlvqW4KnwPU1HSZZ+6I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEh6WPFsvZCG/CNr071RXi3I4Kc+U7MjHASbE5GedgFhSjXaSltP4YVsgj/ceBqhVLvPHl5nMpoEZaJbDHfL1N2stMmxe8bdIGTArEASA+Mpv4yI1fuEhM2j/WsfAlCgri6zC1DSyG6fOZClbrCzVRn9wt8jG25Jz4BgGxsZTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R2tUJOrB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 456HGL1b057811;
	Thu, 6 Jun 2024 12:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717694181;
	bh=N1ETKhvxHGJPhT9+BW3ZazSypo/8ZHe7cRf0MVAFvO0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=R2tUJOrBNtpn4WAWUE9vj5sazjgQw8mUZZwhmPt5w0sBNp+lKcXZEd7JXYcUU7lhq
	 l+lfEdly1KnW6co01ZoyL8KBhOOakcCGdTx58DgZLhDZ4qW0ryqo8ugpBaLRJ6YIVn
	 /sqJ7Neubv1aRTs0IrDJlfc77wpRFYetLuntlX9s=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 456HGKPQ031589
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 12:16:20 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 12:16:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 12:16:20 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 456HGKMs100617;
	Thu, 6 Jun 2024 12:16:20 -0500
Date: Thu, 6 Jun 2024 12:16:20 -0500
From: Bryan Brattlof <bb@ti.com>
To: Hari Nagalla <hnagalla@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: ti: k3-am62a7-sk: Enable ipc with
 remote proc nodes
Message-ID: <20240606171620.h3twptxb5mrxbqxh@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240605124859.3034-1-hnagalla@ti.com>
 <20240605124859.3034-5-hnagalla@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240605124859.3034-5-hnagalla@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Hari,

On June  5, 2024 thus sayeth Hari Nagalla:
> From: Devarsh Thakkar <devarsht@ti.com>
> 
> Reserve memory for remote rpoc IPC and bind the mailbox assignments
> for each remote proc. Two memory regions are reserved for each
> remote processor. The first region of 1Mb of memory is used for Vring
> shared buffers and the second region is used as external memory to the
> remote processor, resource table and as tracebuffer.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 68 +++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index fa43cd0b631e..09bb8af53b1e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -52,11 +52,40 @@ secure_ddr: optee@9e800000 {
>  			no-map;
>  		};
>  
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9c800000 0x00 0x100000>;
> +			no-map;
> +		};
> +
>  		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
>  			compatible = "shared-dma-pool";
>  			reg = <0x00 0x9c900000 0x00 0x01e00000>;
>  			no-map;
>  		};
> +		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@9b800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9b800000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_r5fss0_core0_memory_region: r5f-dma-memory@9b900000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9b900000 0x00 0x0f00000>;
> +			no-map;
> +		};
> +
> +		c7x_0_dma_memory_region: c7x-dma-memory@99800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x99800000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		c7x_0_memory_region: c7x-memory@99900000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x99900000 0x00 0x01efffff>;
> +			no-map;
> +		};
>  	};

This seems highly specific to the demos we're currently running for our 
reference boards. If someone wants to develop their own app say with 
Zypher they would instantly need to change this. 

If these absolutely need to be in here could they go in a TI-demo overly?

~Bryan

