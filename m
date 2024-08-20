Return-Path: <linux-kernel+bounces-294224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E9E958AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96128281EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4001922EF;
	Tue, 20 Aug 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BK4ZBdPs"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299E28FA;
	Tue, 20 Aug 2024 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166949; cv=none; b=NanRKvxkQQ+HplIaDb602MrGDAY4zNSdVXuzEIP9/t+VMmZZEyNrQfBEJ8YslgJo2qyBRwAND97EgQ0LDaDRMYe8KLqP9iyit5XrRFrBgdMvCQ3CnQqF+91cdZcOxgeNe7wcwa29GgCaczT1KW/RAKh/AQtLZG5C6jvJbeuyTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166949; c=relaxed/simple;
	bh=Czkch0QZhrBqNyJDK3eZz7h/cbxIvAw7XyBBjXxkk5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c8JS8IRJYBwhviN+sgl1BVqKyj4dtTjS2cnpd95lP/L8Fvu2Hfalg8S1GWv5w2kxwCy0a+UTHp1Fla82ASmuatZ9u/VPPhYlomi0OHoqRteskpzHPMdEn8Ai6LDD7CXTCgElPuKzCMTlQ7aVinEDfJWl+XM2bpDLqGV7x5aOaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BK4ZBdPs; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KFFedL012733;
	Tue, 20 Aug 2024 10:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724166940;
	bh=CxhzBf5ybGwVcXuCz/a38jlcbZPaO/ysMzhyekGIWLc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BK4ZBdPsHeMLIYURstzM5Z3RfWTKff+TLfvD445wm/ACLyeBzWtGy2uz0PmdeDlkU
	 NYmvEa6+G+Y0Lcq7LhdZVy5bPj9KuV1v2fAbs8Q3AAnkBYWfa1x5YLeB/o5Q8I5mb+
	 4tJ+2V4WGGRkeMT+s6QTjtQCyFVN6FTYNpUJIX9g=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KFFeWb016067
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 10:15:40 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 10:15:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 10:15:40 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KFFdll050707;
	Tue, 20 Aug 2024 10:15:39 -0500
Message-ID: <1809eef3-7308-4ec5-9a31-6ae8ca1c8a57@ti.com>
Date: Tue, 20 Aug 2024 10:15:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: ti: k3-am62a7-sk: Enable ipc with
 remote proc nodes
To: Hari Nagalla <hnagalla@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nm@ti.com>, <bb@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20240820104034.15607-1-hnagalla@ti.com>
 <20240820104034.15607-5-hnagalla@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240820104034.15607-5-hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/20/24 5:40 AM, Hari Nagalla wrote:
> From: Devarsh Thakkar <devarsht@ti.com>
> 
> Reserve memory for remote rpoc IPC and bind the mailbox assignments

s/remote rpoc/Remoteproc

> for each remote proc. Two memory regions are reserved for each
> remote processor. The first region of 1MB of memory is used for Vring
> shared buffers and the second region is used as external memory to the
> remote processor, resource table and as tracebuffer.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 68 +++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index 67faf46d7a35..fb350b578899 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -61,11 +61,40 @@ secure_ddr: optee@9e800000 {
>   			no-map;
>   		};
>   
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9c800000 0x00 0x100000>;
> +			no-map;
> +		};
> +
>   		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0x00 0x9c900000 0x00 0x01e00000>;
>   			no-map;
>   		};

newline

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
> +			reg = <0x00 0x99900000 0x00 0x01f00000>;
> +			no-map;
> +		};
>   	};
>   
>   	vmain_pd: regulator-0 {
> @@ -728,3 +757,42 @@ dpi1_out: endpoint {
>   		};
>   	};
>   };
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

These nodes are incomplete before this point and should have
been disabled when you added them in the dtsi, set their status
to "okay" here.

> +	mboxes = <&mailbox0_cluster1>, <&mbox_c7x_0>;

Should be one item:

mboxes = <&mailbox0_cluster1 &mbox_c7x_0>;

Andrew

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

