Return-Path: <linux-kernel+bounces-277627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7C94A3F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6E1C20CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41CE1CCB26;
	Wed,  7 Aug 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vixwKB0i"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36D1C7B96;
	Wed,  7 Aug 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022177; cv=none; b=pyMMLAejLw1K0nsyIJYesT+gRGl41aTWhwehqA6dfvWnezsg1dkkVZVsv7inbun4IgrzTUs/28mndEumdhuNMYEzREDFm49hhtS01a2WUze04cMqlE94EEK+Kfg6pB1iOqP0pSOdRlYXDhUu53S5iyVKlYyBDJrbjrfahUXI3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022177; c=relaxed/simple;
	bh=ZuTe47JVQMcJhss8fOCfJWiCiFKhu87pLv9XUMXp4j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kgQNCNVxvp1tgZGx5xp0Jrw/cTgRpSCRl+RbGeAhMmRKPwOsx2Xx5g3PROMiwPruw3vxYTDxuLtjbMm510kQoLk+ExOEnt7yqhlSBVVbthVBHaPlE0mWaM2ETkFu9HpldRwgaozx74DBa4pjORoy1pB4OBM3OP3sd/Ykr64fvCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vixwKB0i; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4779G9uS065355;
	Wed, 7 Aug 2024 04:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723022169;
	bh=8C8KMPHoShUAQQZeU9BlrjrX9QLKqFkwz0Ih4eBn9Do=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vixwKB0i3LhzNKl7Gjvg5MrNCqFS9rDs/69pwd9C6z8FhJVRhHnz6fafvQF+ZZUN0
	 MLybzU9V46nLcmWElkyEPb83SGimUlw/O0hhsptKm9hBqRCgvscF/NPEjx5KA5mhf1
	 lobvPCawTZuhQrY00F1MJPZev6yrHo8r0on2qpdU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4779G9Io000735
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 04:16:09 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 04:16:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 04:16:08 -0500
Received: from [172.24.30.93] (lt5cd2489kgj.dhcp.ti.com [172.24.30.93])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4779G4j3131041;
	Wed, 7 Aug 2024 04:16:04 -0500
Message-ID: <e362556b-76b7-47b1-b121-4651b460f3e3@ti.com>
Date: Wed, 7 Aug 2024 14:46:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arm64: dts: ti: k3-j721e*: Add bootph-* properties
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
 <20240730-b4-upstream-bootph-all-v3-4-9bc2eccb6952@ti.com>
 <f042927d-b502-4124-aaee-4bddd94b8bf2@ti.com>
 <20240807083524.4ybzvvwch7e5jwck@uda0497581>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240807083524.4ybzvvwch7e5jwck@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Manorit

On 8/7/2024 2:05 PM, Manorit Chawdhry wrote:
> Hi Udit,
>
> On 13:07-20240807, Kumar, Udit wrote:
>>>    	};
>>>    	vdd_mmc1_en_pins_default: vdd-mmc1-en-default-pins {
>>> @@ -622,6 +627,7 @@ J721E_WKUP_IOPAD(0xf4, PIN_OUTPUT, 2)/* (D25) MCU_I3C0_SDA.MCU_UART0_RTSn */
>>>    			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
>>>    			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0)/* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
>>>    		>;
>>> +		bootph-pre-ram;
>>
>> Please make consistency between pin mux and node.
>>
>> Here I see pin mux is bootph-pre-ram and mcu_uart is bootph-all
> Do we want it to be bootph-pre-ram or bootph-all?


My suggestion will be bootph-all

>
> Regards,
> Manorit

