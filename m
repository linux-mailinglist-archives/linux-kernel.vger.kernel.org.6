Return-Path: <linux-kernel+bounces-277626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6F194A3F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E4E1F231C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E631CCB26;
	Wed,  7 Aug 2024 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KWEITntP"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37F1C9DCE;
	Wed,  7 Aug 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022138; cv=none; b=h/vSRlyKmZ+zSR7DTs4B90ICj6SzNRWjkyRpVJhoZLlV0jIcWRlH20OZHBa27ZEOHuM5f2ZkrpsNDPBTcJXkPLTeBHwUiyHB0cTNIMGf0tq+aWrB7kh+qDtG+CFftAh/+PUsEkEAkMf73Q8WK6L7RFRpZAM6bucPTPMo5Z+8CCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022138; c=relaxed/simple;
	bh=0xcat+ZB1/z+noNB1MyQNw1Ug+KRj2cj4BUOnaCjSwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CJ8Y7CGu9DSDDRaYgYT6dFnZYfPn52f1RRPv6WNxiKJuMtf8vZAhbw1Rsd/uQ7q/cqZ1XkL9ZWBwXj5nBf49vuewHMADRPheS+CsJvdXDfE7YqJvqC3jVTMouHCU8oSkFunXyjasLDKtFauFbnsSEo0HrI1FsxL0cuM+kq7rkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KWEITntP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4779FT8I037044;
	Wed, 7 Aug 2024 04:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723022129;
	bh=b5VMR16aniBfsI7j924JKMOqEqUwZMtEN2oOPi/9UjY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KWEITntP7yZSjmMnOZfnacEZ2LTp1V6paluGc/W/vDV14a+hztw2QTmaNC3LQLLMH
	 vPVHEqfCSVqoXGIKhgLAnlh9nUljTcWmZ3QxDEgUcZ3Ewgb2IhbDJj7mZ7hHnQIxbj
	 tom5fRnYiLwg2dUAsXg8Yyuy5nWcGvcgzVP89xvU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4779FT1x107389
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 04:15:29 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 04:15:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 04:15:28 -0500
Received: from [172.24.30.93] (lt5cd2489kgj.dhcp.ti.com [172.24.30.93])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4779FOFj009192;
	Wed, 7 Aug 2024 04:15:25 -0500
Message-ID: <e61d817b-8043-4c77-92fe-6faa27881d41@ti.com>
Date: Wed, 7 Aug 2024 14:45:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: k3-j7200*: Add bootph-* properties
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-5-9bc2eccb6952@ti.com>
 <f80996c2-c3ee-430a-9ae6-2a9c524b5d60@ti.com>
 <20240807075039.w56deberpo4rfhjc@uda0497581>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240807075039.w56deberpo4rfhjc@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/7/2024 1:20 PM, Manorit Chawdhry wrote:
> Hi Udit,
>
> On 12:58-20240807, Kumar, Udit wrote:
>> On 7/30/2024 3:23 PM, Manorit Chawdhry wrote:
>>> [..]
>>> I think you should consider to mark hbmc node for boot phase as well
>>>
> It's already marked in k3-j7200-som-p0.dtsi file with bootph-all inside
> the flash node that describe it, is that okay?


yes

>
>>> @@ -652,6 +661,7 @@ wkup_vtm0: temperature-sensor@42040000 {
>>>    		      <0x00 0x42050000 0x00 0x350>;
>>>    		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
>>>    		#thermal-sensor-cells = <1>;
>>> +		bootph-pre-ram;
>>>    	};
>>>    	mcu_esm: esm@40800000 {
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
>>> index 21fe194a5766..d78f86889bf9 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
>>> @@ -121,6 +121,7 @@ J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (B8) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
>>>    			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (A8) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
>>>    			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
>>>    		>;
>>> [..]
>>>    			bucka2: buck2 {
>>> @@ -464,6 +470,7 @@ flash@0 {
>>>    		cdns,tchsh-ns = <60>;
>>>    		cdns,tslch-ns = <60>;
>>>    		cdns,read-delay = <4>;
>>> +		bootph-all;
>>>    		partitions {
>>>    			compatible = "fixed-partitions";
>>
>> Please consider, adding bootph in ospi0 node as well around
>> "ospi.phypattern"
>>
> Okay sure, will move the bootph-all from flash@0 node to under
> ospi.phypattern node as putting it in the child node should propagate
> it.
>
> Thanks for reviewing Udit!
>
> Regards,
> Manorit

