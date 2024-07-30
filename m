Return-Path: <linux-kernel+bounces-268230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69B9942201
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B290285C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488718A6C6;
	Tue, 30 Jul 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IomQ3G7/"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28238B;
	Tue, 30 Jul 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373505; cv=none; b=aBdHoeKBpOmWvFz0ZCTTUGS9fI8OI9WVd44X4yeUYLqkUAYn81jlrRPPoRd39Maa5g/21oePF8OEWz1Pal5eC+6GQ4v6hp5eA3r2OogoeKygIoiyn4tZD3tajOco3fR1jn1Gq6WGu1KnObXCA2h0UkPStGznpzamEYNyurXLLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373505; c=relaxed/simple;
	bh=GCu4r98kTw83zvHTndHVyfmkZDruuPHLD2NCCoobUuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vp99L4ti2XQ14/fLKofchGHOLaQ0ZWK6aVw+iGaPpQi0CwGXx6KutQ50Chl6JORz9k/JpH6ZHrm2JcB0dfCAKqzjAl5hrTUT0QpHiZKcD2r3b1j3kytRba+Z99Qfe2LJyvwL+ChtLgC28W39Fmo8nn3qnKbkBpEFF1B7MP7t2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IomQ3G7/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UL4o3h044671;
	Tue, 30 Jul 2024 16:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722373490;
	bh=o2Zer9N8QrcaJ8Sh0l8q8o4PRjk5luhYHbS7vLCXUQg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IomQ3G7/RBGWWV5m7ZMa9p/oNEJyLdHqOhgGlePmpnrh4on5bOwKpi22veVSkalQW
	 Tbh4tNjiVVc2bAy6QrpnUEMz9UP94Z7c+C+Kn+AOFPkYcwXgN/RHnJFU9SId08QRsX
	 f2zNsnXduvWaBI/T/g+4TZlWbLChWAjFojbO/LFM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UL4oQP010906
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 16:04:50 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 16:04:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 16:04:50 -0500
Received: from [128.247.81.191] (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UL4ogn071067;
	Tue, 30 Jul 2024 16:04:50 -0500
Message-ID: <56306559-7f30-47f2-a6c6-bace35fc77c5@ti.com>
Date: Tue, 30 Jul 2024 16:04:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62p: Add gpio-ranges for
 mcu_gpio0
To: Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240730143324.114146-1-j-mcarthur@ti.com>
 <20240730143324.114146-2-j-mcarthur@ti.com>
 <20240730145956.n7brt337sc5vjpg5@violet>
Content-Language: en-US
From: Jared McArthur <j-mcarthur@ti.com>
In-Reply-To: <20240730145956.n7brt337sc5vjpg5@violet>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 7/30/24 09:59, Nishanth Menon wrote:
> On 09:33-20240730, Jared McArthur wrote:
>> Commit d72d73a44c3c ("arm64: dts: ti: k3-am62p: Add gpio-ranges
>> properties") introduced pinmux range definition for gpio-ranges,
>> however missed introducing the range description for the mcu_gpio0
>> node. As a result, automatic mapping of GPIO to pin control for mcu
>> gpios is broken. Fix this by introducing the proper ranges.
>>
>> Fixes: d72d73a44c3c ("arm64: dts: ti: k3-am62p: Add gpio-ranges properties")
>> Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
>> index e65db6ce02bf..c0bdbd00dc23 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
>> @@ -146,6 +146,9 @@ mcu_gpio0: gpio@4201000 {
>>  		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
>>  		clocks = <&k3_clks 79 0>;
>>  		clock-names = "gpio";
>> +		gpio-ranges = <&mcu_pmx0 0 0 21>, <&mcu_pmx0 21 23 1>,
>> +			      <&mcu_pmx0 22 32 2>;
>> +		ti,ngpio = <24>;
> we already have ti,ngpio - please drop
Sorry, missed that. I will fix it and resend the patch.
>>  	};
>>  
>>  	mcu_rti0: watchdog@4880000 {
>> -- 
>> 2.34.1
>>

-- 
Best,
Jared McArthur


