Return-Path: <linux-kernel+bounces-228652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459891648A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52B728628B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F4E14A090;
	Tue, 25 Jun 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dyihsoCC"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67871465A8;
	Tue, 25 Jun 2024 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309507; cv=none; b=aEdhx490gdUbR24KdkjPwNqlsoA07v/dy5kTYCH+M428sxS2N0tfVYku4Eoo8gLbLk0AvJonS1SPxfFQkPp0mCgDI0iNMDqMpcb37H7mSuICPG1dZh73Nx/D9sPN3MXxBlMQwhSc8BbxKLR5E3zFxrOsfQ4wt+cE95wa4Y9tYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309507; c=relaxed/simple;
	bh=mCh1S/zv9T0LxQ/VIDcjCSxK47VDHa4Fq1mKhnurmw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ep3otG1+B3AOmCYHaX74kzKqR1/QYU0pCpVWVu9zCrIVkD/blsYlCsRtBANZv9IAm66aD5Llbyh5lGg0TltTbgIqTOxk19fTejeUIIthn1g3E0BjcUGUM6waMpnIoP2HDePVEYsprKWexnZ4smNpS+cgN+3xHUivP+754Jp+QP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dyihsoCC; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45P9w5eh120857;
	Tue, 25 Jun 2024 04:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719309485;
	bh=YYbaCGjM9Dz35Gz2eCP629JCL3wzQ9QkaGDO7vlRNiw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dyihsoCCCqu88Ov04PV/ubjbfy5rjw9UbR+YKkzhASXR28FggaBWmZ7QFwwt3BPgz
	 vlcFY8Bt3BTIiu0IQsQSiLzwsSJJn4v0QrCqa1LCNJ61e1lw0OKX4Z9Zdk/i4Ez1m6
	 AIIcpExV26lMFCEFrea+xv+MnzKs2Ewt+cNrvYVE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45P9w4GO124382
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 04:58:05 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 04:58:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 04:58:04 -0500
Received: from [172.24.227.248] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.248])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45P9vxvl093913;
	Tue, 25 Jun 2024 04:58:00 -0500
Message-ID: <76d816b4-6a20-4cda-8552-cfd07203a4d2@ti.com>
Date: Tue, 25 Jun 2024 15:27:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j784s4-main: Add McASP nodes
To: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <j-luthra@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240619095253.290552-1-j-choudhary@ti.com>
 <20240619095253.290552-2-j-choudhary@ti.com>
 <f9f5178b-1e94-489b-8e71-43b814b7252a@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <f9f5178b-1e94-489b-8e71-43b814b7252a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Vignesh!

On 25/06/24 14:01, Vignesh Raghavendra wrote:
> 
> 
> On 19/06/24 15:22, Jayesh Choudhary wrote:
>> Add McASP 0-4 instances and keep them disabled as several required
>> properties are missing as they are board specific.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 80 ++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index fd3d3344efbe..96085dc7bc18 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -2617,4 +2617,84 @@ dss_ports: ports {
>>   			 */
>>   		};
>>   	};
>> +
>> +	mcasp0: mcasp@2b00000 {
>> +		compatible = "ti,am33xx-mcasp-audio";
>> +		reg = <0x0 0x02b00000 0x0 0x2000>,
>> +		      <0x0 0x02b08000 0x0 0x1000>;
> 
> 			^^ Should be 0x00 (elsewhere as well) to be inline with rest of the file

Will fix the padding.

Warm Regards,
-Jayesh



