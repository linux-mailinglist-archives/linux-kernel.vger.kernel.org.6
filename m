Return-Path: <linux-kernel+bounces-207750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 334FB901B82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854CEB2137E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C41CD24;
	Mon, 10 Jun 2024 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bS3sQ+Zv"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75791C20;
	Mon, 10 Jun 2024 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002953; cv=none; b=ND8RQEAQYD5spfmAj7Kae2OC7zTL8dzDseFtwrDfgVWUhPsYvTx8gFZRYeucmAKlzTSiZuQPciFPZh1wRdX/ev74dD+trWWOz4D2XTnOeF6QzBn8nj9/WlrcnNL3BvGZoPonsXD75zBcZKmRwFNcxTWHpakCgcs4fYiNKA0QI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002953; c=relaxed/simple;
	bh=1FXoLwNeSNlkUZEriabXM2cP2tq7mAsCgeng7zlGrNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ad+xV1jo3LnFX0lHhTUZl3okquoT2OIT960afgQX/+gxHBOBP9TrbuGHwTjl3LQ6yKCYmZB2dKFhJZLpSB5h2eDaHQTeyzFckKMu6KqzUBf1kzNBISkAHSR8A4VJL3H74qkf41QZYQgmEyN+GTWAFQlfseHMvvuGTPeL7v1qykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bS3sQ+Zv; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45A72G2j051386;
	Mon, 10 Jun 2024 02:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718002936;
	bh=CBKcCAjTnjMYq/xriU0Yr0ZroUppy6C/UJrsoqsUTSs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bS3sQ+ZvqChcJ8L3BNj5RSog9CjMxCDoMDRyounmulfRBesy+8DMg1rBbEdZlpS9a
	 nYtf3v6JFmj7OTQ/m4PtaGcs/A+4J/EQehDatMaWLz9niBg3quuoLzZtZVv8SiZYVP
	 /J49RiughlKxL2LZTgHg+GTssQfdazeOzqNUcVeU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45A72G3u007601
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 02:02:16 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 02:02:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 02:02:15 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45A72CuN127867;
	Mon, 10 Jun 2024 02:02:13 -0500
Message-ID: <1b03ae72-b1c4-4165-b3cc-df85255b9dbf@ti.com>
Date: Mon, 10 Jun 2024 12:32:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: ti: k3-am62a7-sk: Enable ipc with
 remote proc nodes
To: Hari Nagalla <hnagalla@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20240605124859.3034-1-hnagalla@ti.com>
 <20240605124859.3034-5-hnagalla@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240605124859.3034-5-hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 05/06/24 18:18, Hari Nagalla wrote:
> From: Devarsh Thakkar <devarsht@ti.com>
> 
> Reserve memory for remote rpoc IPC and bind the mailbox assignments
> for each remote proc. Two memory regions are reserved for each
> remote processor. The first region of 1Mb of memory is used for Vring

s/1Mb/1MB?

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

0x01efffff -> are you sure this is correct? Just missing a byte to a
nice round number size. looks like typo of using range vs size?

> +			no-map;
> +		};
>  	};
>  
>  	vmain_pd: regulator-0 {
> @@ -721,3 +750,42 @@ dpi1_out: endpoint {
>  		};
>  	};
>  };
> +
> +&mailbox0_cluster0 {
> +	mbox_r5_0: mbox-r5-0 {
> +		ti,mbox-rx = <0 0 0>;
> +		ti,mbox-tx = <1 0 0>;
> +	};
> +};
> +
> +&mailbox0_cluster1 {
> +	mbox_c7x_0: mbox-c7x-0 {
> +		ti,mbox-rx = <0 0 0>;
> +		ti,mbox-tx = <1 0 0>;
> +	};
> +};
> +
> +&mailbox0_cluster2 {
> +	mbox_mcu_r5_0: mbox-mcu-r5-0 {
> +		ti,mbox-rx = <0 0 0>;
> +		ti,mbox-tx = <1 0 0>;
> +	};
> +};
> +
> +&c7x_0 {
> +	mboxes = <&mailbox0_cluster1>, <&mbox_c7x_0>;
> +	memory-region = <&c7x_0_dma_memory_region>,
> +			<&c7x_0_memory_region>;
> +};
> +
> +&wkup_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster0>, <&mbox_r5_0>;
> +	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> +		<&wkup_r5fss0_core0_memory_region>;
> +};
> +
> +&mcu_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster2>, <&mbox_mcu_r5_0>;
> +	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> +			<&mcu_r5fss0_core0_memory_region>;
> +};

-- 
Regards
Vignesh

