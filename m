Return-Path: <linux-kernel+bounces-173304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B657D8BFEB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA30A1C22B7A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA727A13A;
	Wed,  8 May 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lrL5nMNW"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D96E5FE;
	Wed,  8 May 2024 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174803; cv=none; b=lfJL6CxH5n3A9z5h2ahGHSJkSbpemltjx7l0YZr+pFEyyQ5mPAuIivAsRJzhYKGnQO54EVapxYU9EZECwtY2duJ5BPqjtPxpxF/c3KuaJmuUcfxHp1kX1hfTt3OHnpzgEiwcv4bkzpx04/mwaNyDxjysSfBZjjhcIMcvuiEcAEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174803; c=relaxed/simple;
	bh=G38/BPHKVSwonW5mVVk81fEl3xs08FysqcY+nVMlhew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZtudBAe0bA1pTNB0v04r9c4zy01Ba766XVbRBvMaGUQfJWjMpOM7GPEb4OZyiFFEmIFDq1O7xuGtCHpVpn4VxoI+b3MEXosx8qVHQ0oQ0FyLf6F6R6W9lhGYz2xJP6486SpE+y9H4DjJtIvIfAQU57GQ2oTsznezXqlt4HAy2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lrL5nMNW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 448DQAL5076930;
	Wed, 8 May 2024 08:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715174770;
	bh=J+Avgf+fUwksoUsXMOQQy6JQ7v/tYEz/lZ2LN0qAqTs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lrL5nMNWY6ruU81BGOqrhjAj1BGbf6b13UFb0nv8bgQaHn2QPDl0GklFzOKN2s1sF
	 vro4gnlwsVauZX5psjNlagUdbi8+6eB6nqyCDxzMKR84/hoIMfBdxQs2JWBxOocdUc
	 Hz3Qmp27LL8q0qiiZBIKQgC4RBXOJEtktPQN/hQ0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 448DQA7d001406
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 May 2024 08:26:10 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 08:26:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 08:26:09 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 448DQ5PH102151;
	Wed, 8 May 2024 08:26:06 -0500
Message-ID: <9f29d226-5c61-ca25-06ef-647769775f45@ti.com>
Date: Wed, 8 May 2024 18:56:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j722s: Add support for SERDES0
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ravi
 Gunasekaran <r-gunasekaran@ti.com>
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
 <20240429120932.11456-2-r-gunasekaran@ti.com>
 <41047a89-2787-422f-a643-3e2d850da6dd@kernel.org>
 <588e4d0a-78c6-553f-3c40-0d248f4c92f9@ti.com>
 <59d8af19-5b2b-486a-9e03-2db2568b0b00@kernel.org>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <59d8af19-5b2b-486a-9e03-2db2568b0b00@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 5/8/24 6:32 PM, Roger Quadros wrote:
> 
> 
> On 08/05/2024 15:34, Ravi Gunasekaran wrote:
>>
>>
>> On 5/8/24 5:29 PM, Roger Quadros wrote:
>>>
>>>
>>> On 29/04/2024 15:09, Ravi Gunasekaran wrote:
>>>> Add SERDES0 and its wrapper description to support USB3
>>>> and SGMII interfaces.
>>>>
>>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-j722s.dtsi | 54 ++++++++++++++++++++++++++++
>>>>  1 file changed, 54 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>>>> index c75744edb143..beba5a3ea6cc 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>>>> @@ -9,6 +9,7 @@
>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>>> +#include <dt-bindings/phy/phy-ti.h>
>>>>  
>>>>  #include "k3-am62p5.dtsi"
>>>>  
>>>> @@ -75,6 +76,50 @@
>>>>  			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>,
>>>>  			 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>;
>>>>  	};
>>>> +
>>>> +	serdes_refclk: clock-cmnrefclk {
>>>
>>> What could be the generic name here?
>>>
>>
>> How about phy-clk or serdes-clk?
>> I searched for "fixed-clock" and wide range of naming conventions is followed.
> 
> We shouldn't encode the clock function in the name. How about just clk-<n> ?
> where <n> is an integer starting from 0 for such fixed-clocks on the platform?
> 

Sure. I can follow this notation.

> e.g. from arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> 
>         tlv320_mclk: clk-0 {
>                 #clock-cells = <0>;
>                 compatible = "fixed-clock";
>                 clock-frequency = <12288000>;
>         };
> 
>>

[...]

>>
> 

-- 
Regards,
Ravi

