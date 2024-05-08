Return-Path: <linux-kernel+bounces-173251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11AD8BFDA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8D11C2140B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39F656470;
	Wed,  8 May 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CR+/o3zB"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324050A7E;
	Wed,  8 May 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172505; cv=none; b=DeTP5uGNYd4O2wddCztTzGKpyrQmcuWoaS76q9r+yDfczkFGiDn7n6C2kpFjP9HyEWTesJj6M1mHuuGGjsbnu0++Xgei2oIdEfFwtCfBut8idwsiC/hk1K0C5BGKlmZ+3JV5IyMciXyNxdaDfeYXbOvx5hvYvcYmHmZOwHrHI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172505; c=relaxed/simple;
	bh=FIQlfh2bstN+hWpqxtSySmw1ecObAkBOa2X4+arU7n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aNZ/KRQ1+Hy+gYF9vKHBzrjg86rQ0bJtTKBUBJqYyZWiyrTpzdAMYFRzY17r3EuN+napyzudmnEEsZiYiIelF9jtWZPLZn/fZGcw/g4Xpj/u4qBmP7OVlgt8Ok4mL8Wo10OeDwFofx+dJI3BWSChSvKfhGILwts7dJtz3C1HYdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CR+/o3zB; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 448CmBiK026407;
	Wed, 8 May 2024 07:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715172491;
	bh=5H+tj5RJ1yPj5wj2v7QxKDjzeUn3VidTkO5sVoqF4FY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CR+/o3zBoBNF0TgEpDfatA1EZUGR718IGcUDGxntviGfzm/1t8yUZFUu4rxFyxQTC
	 fvj2sHNV3wcY2zlR5lR+r7DUY2f1TTAMjNWJ2DndI8L8+P3IpEwV0/CSQmUMKR86Fg
	 oWmPGy1igQtwMHto68HpBxBr3rssA+hCZpAwbITs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 448CmBAv065638
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 May 2024 07:48:11 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 07:48:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 07:48:10 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 448Cm784112022;
	Wed, 8 May 2024 07:48:07 -0500
Message-ID: <1e787f16-662e-16ec-d0c5-e2a8c59dc99b@ti.com>
Date: Wed, 8 May 2024 18:18:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1
 configuration for EVM
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ravi
 Gunasekaran <r-gunasekaran@ti.com>
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
 <20240429120932.11456-4-r-gunasekaran@ti.com>
 <2e19a254-58d2-4c27-9c34-2662827ea505@kernel.org>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <2e19a254-58d2-4c27-9c34-2662827ea505@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 5/8/24 5:33 PM, Roger Quadros wrote:
> 
> 
> On 29/04/2024 15:09, Ravi Gunasekaran wrote:
>> The GPIO expander on the EVM allows the USB selection for Type-C
>> port to either USB0 or USB1 via USB hub. By default, let the Type-C
>> port select USB0 via the GPIO expander port P05.
>>
>> Enable super-speed on USB1 by updating SerDes0 lane configuration.
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 58 +++++++++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-serdes.h      |  7 +++
>>  2 files changed, 65 insertions(+)
>>

[...]

>> +
>> +		p05-hog {
>> +			/* P05 - USB2.0_MUX_SEL */
>> +			gpio-hog;
>> +			gpios = <5 GPIO_ACTIVE_LOW>;
>> +			output-high;
>> +			line-name = "USB2.0_MUX_SEL";
> 
> This line-name is already added in gpio-line-names property above.
> Do we really need to add it again?

Not needed. If the line-name property is not present for the hog,
then its taken from the gpio chip via gpio-line-names.
So I will remove the line-name property in v2

static struct gpio_desc *of_parse_own_gpio(...)
..
        if (name && of_property_read_string(np, "line-name", name))                                     
                *name = np->name; 
..

> 
>> +		};
>>  	};
>>  };
>>  

[...]


-- 
Regards,
Ravi

